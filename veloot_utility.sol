// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15 <0.9.0;

/**
* @title The veLoot Utility contract is used to add additial features to the veLoot NFT contract
* @dev Use the NFT contract 0x1f173256C08E557D0791BC6EF2aC1b1099F57Ed5 for all NFT manipulations
*/

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";


/// @notice Interface to get the token owner from the NFT contract
interface IOwnerOf {
    function ownerOf(uint tokenId)
        external
        view
        returns (address);
}

/**
* @notice Interfaces for calling the CRUD database contract
*/
interface IBag {
    function getBag(uint tokenId)
        external
        view
        returns (string[9] memory);
}

interface IWeapon {
    function getWeapon(uint tokenId)
        external
        view
        returns (string memory);
}

interface IMagic {
    function getMagic(uint tokenId)
        external
        view
        returns (string memory);
}

interface IChest {
    function getChestArmor(uint tokenId)
        external
        view
        returns (string memory);
}

interface IHead {
    function getHeadArmor(uint tokenId)
        external
        view
        returns (string memory);
}

interface IWaist {
    function getWaistArmor(uint tokenId)
        external
        view
        returns (string memory);
}

interface IFoot {
    function getFootArmor(uint tokenId)
        external
        view
        returns (string memory);
}

interface IHand {
    function getHandArmor(uint tokenId)
        external
        view
        returns (string memory);
}

interface INeck {
    function getNecklace(uint tokenId)
        external
        view
        returns (string memory);
}

interface IRing {
    function getRing(uint tokenId)
        external
        view
        returns (string memory);
}

contract veLootUtility {
    using Strings for uint256;


/**
* @notice Variables to store contract addresses
*/
    string public name = "veLoot Utility contract";
    /// @dev CRUD database that stores the veLoot strings
    address public databaseAddress = 0x0e1324A3948DE5FEBC6F72A9e9D4B96DF1D23Fc0;
    /// @dev veLoot NFT address
    address public nftAddress = 0x1f173256C08E557D0791BC6EF2aC1b1099F57Ed5;


/**
* @notice Functions to call data from the interfaces
*/
    function ownerOf(uint tokenId) public view returns (address) {
        return IOwnerOf(nftAddress).ownerOf(tokenId);
    }

    /// @dev All items in each bag returned as strings
    function getBag(uint tokenId) public view returns (string memory weapon,
                                                        string memory magic,
                                                        string memory chest,
                                                        string memory head,
                                                        string memory waist,
                                                        string memory foot,
                                                        string memory hand,
                                                        string memory neck,
                                                        string memory ring) {
        string[9] memory bag = IBag(databaseAddress).getBag(tokenId);
        return (bag[0], bag[1], bag[2], bag[3], bag[4], bag[5], bag[6], bag[7], bag[8]);
    }

    /// @dev All items in each bag returned as an array
    function getBagArray(uint tokenId) public view returns (string[9] memory) {
        return IBag(databaseAddress).getBag(tokenId);
    }

    function getWeapon(uint tokenId) public view returns (string memory) {
        return IWeapon(databaseAddress).getWeapon(tokenId);
    }

    function getMagic(uint tokenId) public view returns (string memory) {
        return IMagic(databaseAddress).getMagic(tokenId);
    } 

    function getChest(uint tokenId) public view returns (string memory) {
        return IChest(databaseAddress).getChestArmor(tokenId);
    }

    function getHead(uint tokenId) public view returns (string memory) {
        return IHead(databaseAddress).getHeadArmor(tokenId);
    }

    function getWaist(uint tokenId) public view returns (string memory) {
        return IWaist(databaseAddress).getWaistArmor(tokenId);
    }

    function getFoot(uint tokenId) public view returns (string memory) {
        return IFoot(databaseAddress).getFootArmor(tokenId);
    }

    function getHand(uint tokenId) public view returns (string memory) {
        return IHand(databaseAddress).getHandArmor(tokenId);
    }

    function getNeck(uint tokenId) public view returns (string memory) {
        return INeck(databaseAddress).getNecklace(tokenId);
    }    

    function getRing(uint tokenId) public view returns (string memory) {
        return IRing(databaseAddress).getRing(tokenId);
    }    


/**
* @notice Create veLoot Bag SVG and encode into Base64
* @dev See reference to orgianl Loot Project: https://etherscan.io/address/0xff9c1b15b16263c61d017ee9f65c50e4ae0113d7#code#L1525
*/
    function tokenURI(uint tokenId) public view returns (string memory) {
        string[19] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill:#15bdff; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = getWeapon(tokenId);

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = getMagic(tokenId);

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = getChest(tokenId);

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = getHead(tokenId);

        parts[8] = '</text><text x="10" y="100" class="base">';

        parts[9] = getWaist(tokenId);

        parts[10] = '</text><text x="10" y="120" class="base">';

        parts[11] = getFoot(tokenId);

        parts[12] = '</text><text x="10" y="140" class="base">';

        parts[13] = getHand(tokenId);

        parts[14] = '</text><text x="10" y="160" class="base">';

        parts[15] = getNeck(tokenId);

        parts[16] = '</text><text x="10" y="180" class="base">';

        parts[17] = getRing(tokenId);

        parts[18] = '</text></svg>';

        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));
        output = string(abi.encodePacked(output, parts[9], parts[10], parts[11], parts[12], parts[13], parts[14], parts[15], parts[16], parts[17], parts[18]));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "veLoot #', Strings.toString(tokenId),'", "description": "veLoot itself is a collection of 6,000 unique bags of adventurer gear NFTs.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
    }

}