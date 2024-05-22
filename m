Return-Path: <netdev+bounces-97491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65298CBA81
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 06:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6CD282BB8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 04:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E557CB4;
	Wed, 22 May 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="PjietDRh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344774C62
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716353711; cv=none; b=apj3uktulU2TgMMzw1uRjdw8L5kxnhU5TyT5WB1dPrv5+yTgq1Osi3FzHwRW0AlNYMmqSzeiP9+jusgUVdN/yk3kXC3ybFdbNVbM/MvSHJa7WT0rk5pM8/3MHZ3r/PEqM/flOI0GU/9FqX/u3Z85A2+8uIuaodoIFSBJVVXooKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716353711; c=relaxed/simple;
	bh=W3U1c463STi8ZLFMoDz7kz9VC6lUk9y7dYLFOflubIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2Sg3tNdb8cmQ9nwEqV0pCv9V+oa9dzURz/9cH6ebDUhsDlOdp0GLp5EIX2LG1JEutQGF3e9ug//xc2PwAsdTBm4teWsRKG8pFptQpGIlZe4jMplUzdV2CeRuDmGsQzn+ZFCHGXpQ0Pe4Xa/aqIOCtMp3QwcSSccKRF/EcJPl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=PjietDRh; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44M4soZ7021504
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 22 May 2024 06:54:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1716353694; bh=wqVcYurnq4BgYinGhpGn+5A5r71y0yvTjwH022g7Ar0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PjietDRhEIH13i0hYfGDLkB3jr/eZ5X6FUMFUPSbtqMzzvlulxJk8oZuz1E3GU3IX
	 Hmt3WeSWY1/PMffcp4xHoJGwva3G5Fr7BBPzJ6h5Hthr5kYzfPrL1hg8qQUqk88EEN
	 c0/K9O9xCE9Df9hQHkLjd0TLzyNCtB1PVA6rFSbg=
Message-ID: <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
Date: Tue, 21 May 2024 21:54:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Kubecek <mkubecek@suse.cz>, Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, idosch@nvidia.com
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 21.05.2024 at 13:21, Andrew Lunn wrote:
>> sending genetlink packet (76 bytes):
>>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
>>     ETHTOOL_MSG_MODULE_EEPROM_GET
>>         ETHTOOL_A_MODULE_EEPROM_HEADER
>>             ETHTOOL_A_HEADER_DEV_NAME = "eth3"
>>         ETHTOOL_A_MODULE_EEPROM_LENGTH = 128
>>         ETHTOOL_A_MODULE_EEPROM_OFFSET = 128
>>         ETHTOOL_A_MODULE_EEPROM_PAGE = 3
>>         ETHTOOL_A_MODULE_EEPROM_BANK = 0
>>         ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS = 80
>> received genetlink packet (96 bytes):
>>     msg length 96 error errno=-22
> 
> This is a mellanox card right?

Yes, sorry. This is indeed Mellanox (now Nvidia) CX3 / CX3Pro, using the drivers/net/ethernet/mellanox/mlx4 driver.

> mlx4_en_get_module_info() and mlx4_en_get_module_eeprom() implement
> the old API for reading data from an SFP module. So the ethtool core
> will be mapping the new API to the old API. The interesting function
> is probably fallback_set_params():
> 
> https://elixir.bootlin.com/linux/latest/source/net/ethtool/eeprom.c#L29
> 
> and my guess is, you are hitting:
> 
> 	if (offset >= modinfo->eeprom_len)
> 		return -EINVAL;
> 
> offset is 3 * 128 + 128 = 512.
> 
> mlx4_en_get_module_info() is probably returning eeprom_len of 256?
> 
> Could you verify this?

Ah, excellent catch Andrew!

# egrep -R 'ETH_MODULE_SFF_[0-9]+_LEN' include/uapi/linux/ethtool.h
#define ETH_MODULE_SFF_8079_LEN         256
#define ETH_MODULE_SFF_8472_LEN         512
#define ETH_MODULE_SFF_8636_LEN         256
#define ETH_MODULE_SFF_8436_LEN         256

The code in mlx4_en_get_module_info (with length annotation):

        switch (data[0] /* identifier */) {
        case MLX4_MODULE_ID_QSFP:
                modinfo->type = ETH_MODULE_SFF_8436;
                modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;		// 256
                break;
        case MLX4_MODULE_ID_QSFP_PLUS:
                if (data[1] >= 0x3) { /* revision id */
                        modinfo->type = ETH_MODULE_SFF_8636;
                        modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;	// 256
                } else {
                        modinfo->type = ETH_MODULE_SFF_8436;
                        modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;	// 256
                }
                break;
        case MLX4_MODULE_ID_QSFP28:
                modinfo->type = ETH_MODULE_SFF_8636;
                modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;		// 256
                break;
        case MLX4_MODULE_ID_SFP:
                modinfo->type = ETH_MODULE_SFF_8472;
                modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;		// 512
                break;
        default:
                return -EINVAL;
        }

So right, the function returns 512 for SFP and 256 for everything else, which explains why SFP does work but QSFP - not.

Following your advice, I added some debug printks to net/ethtool/eeprom.c:

@@ -33,16 +33,24 @@
        u32 offset = request->offset;
        u32 length = request->length;

+       printk("A: offset=%u, modinfo->eeprom_len=%u\n", offset, modinfo->eeprom_len);
+
        if (request->page)
                offset = request->page * ETH_MODULE_EEPROM_PAGE_LEN + offset;

+       printk("B: offset=%u, modinfo->eeprom_len=%u\n", offset, modinfo->eeprom_len);
+
        if (modinfo->type == ETH_MODULE_SFF_8472 &&
            request->i2c_address == 0x51)
                offset += ETH_MODULE_EEPROM_PAGE_LEN * 2;

+       printk("C: offset=%u, modinfo->eeprom_len=%u\n", offset, modinfo->eeprom_len);
+
        if (offset >= modinfo->eeprom_len)
                return -EINVAL;

+       printk("D: offset=%u, modinfo->eeprom_len=%u\n", offset, modinfo->eeprom_len);
+
        eeprom->cmd = ETHTOOL_GMODULEEEPROM;
        eeprom->len = length;
        eeprom->offset = offset;

Here is the result:

SFP:
A: offset=0, modinfo->eeprom_len=512
B: offset=0, modinfo->eeprom_len=512
C: offset=0, modinfo->eeprom_len=512
D: offset=0, modinfo->eeprom_len=512
A: offset=0, modinfo->eeprom_len=512
B: offset=0, modinfo->eeprom_len=512
C: offset=0, modinfo->eeprom_len=512
D: offset=0, modinfo->eeprom_len=512

QSFP:
A: offset=0, modinfo->eeprom_len=256
B: offset=0, modinfo->eeprom_len=256
C: offset=0, modinfo->eeprom_len=256
D: offset=0, modinfo->eeprom_len=256

A: offset=0, modinfo->eeprom_len=256
B: offset=0, modinfo->eeprom_len=256
C: offset=0, modinfo->eeprom_len=256
D: offset=0, modinfo->eeprom_len=256

A: offset=128, modinfo->eeprom_len=256
B: offset=128, modinfo->eeprom_len=256
C: offset=128, modinfo->eeprom_len=256
D: offset=128, modinfo->eeprom_len=256

A: offset=128, modinfo->eeprom_len=256
B: offset=512, modinfo->eeprom_len=256
C: offset=512, modinfo->eeprom_len=256
Note - no "D" as -EINVAL is returned exactly as you predicted.

BTW: there is another suspicious looking thing in this code:
 - "u32 length = request->length;" is set early in the function
 - length is never updated
 - at the end, we have "eeprom->len = length"

In this case, the existence of length seems at least seems redundant, unless I missed something?

For the reference, the function was added in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96d971e307cc0e434f96329b42bbd98cfbca07d2
Later https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a3bb7b63813f674fb62bac321cdd897cc62de094 changed ETH_MODULE_SFF_8079 to ETH_MODULE_SFF_8472.

Thanks,
 Krzysztof

