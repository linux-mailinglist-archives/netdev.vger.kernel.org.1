Return-Path: <netdev+bounces-97687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE28CCBC2
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4651C21179
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C14F211;
	Thu, 23 May 2024 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="bEvTLkbs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53053363
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442215; cv=none; b=rRgYp545MhFPbs3f6TTLWnG+5nk7ac5bXP0REsTpTjcp02VPlnEp5g7xRHFRR44ATjcVX+Mmqzu9Z9Nmicgn5uZSCKOSFqCFKcgx+4F0EO6i2F/MwQ97zIR3+iIYBv9EL4sGZFRUfMrS/jUx+zDMA4Vt1QRokd4z2ac5cOIg5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442215; c=relaxed/simple;
	bh=r6C+3TTfUbMcCHy+4GNkIIfOtOwaTpz/KvNJCdiWoBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJTbga7oIP5ejx2I+kYTSEVqr7prdPa8/3EGpynqT31Ze+SSkVR9/C8mQtxCXP7C7ukZU4rwdHBUAbKwxjerdEMmazS+Psict0NCKFHFNdEGrw0SnFRL+inDzKLTnRmfLX9ZacXEc+eTQlMbwcs44J4oVZkgCcUZw6KQqym2WxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=bEvTLkbs; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44N5TjDj011131
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 23 May 2024 07:29:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1716442190; bh=wQiJZzwzA77GyEUAqsttFBzKDini9PWueExd6zt40Wk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bEvTLkbs37xnwOK8Tdo/6Ezqhl/w8wU/nWpyn1rBeluw9H3gjsp/QxD5r396H63ko
	 vj7cVqog81HpLtvmOY1ti7sdhscyol1xYnQ1FB+ky/OWk4cn8sJwsqEcQSS69ZkI5i
	 j2qfboAiuqmz+UELq+xv8EHG1JjS77eleK9gEcWo=
Message-ID: <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
Date: Wed, 22 May 2024 22:29:43 -0700
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
To: Andrew Lunn <andrew@lunn.ch>, Ido Schimmel <idosch@nvidia.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tariqt@nvidia.com
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl> <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22.05.2024 at 05:44, Andrew Lunn wrote:
>>> So right, the function returns 512 for SFP and 256 for everything else, which explains why SFP does work but QSFP - not.
>>
>> Since you already did all the work and you are able to test patches, do
>> you want to fix it yourself and submit or report to the mlx4 maintainer
>> (copied)? Fix should be similar to mlx5 commit a708fb7b1f8d ("net/mlx5e:
>> ethtool, Add support for EEPROM high pages query").

Oh, thank you so much for the pointer! Turns out, it was way easier than I thought:

# ethtool -m eth2
        Identifier                                : 0x0d (QSFP+)
        Extended identifier                       : 0x00
        Extended identifier description           : 1.5W max. Power consumption
        Extended identifier description           : No CDR in TX, No CDR in RX
        Extended identifier description           : High Power Class (> 3.5 W) not enabled
        Power set                                 : On
        Power override                            : On
        Connector                                 : 0x0c (MPO Parallel Optic)
        Transceiver codes                         : 0x04 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Transceiver type                          : 40G Ethernet: 40G Base-SR4
        Encoding                                  : 0x05 (64B/66B)
        BR, Nominal                               : 10300Mbps
        Rate identifier                           : 0x00
        Length (SMF,km)                           : 0km
        Length (OM3 50um)                         : 100m
        Length (OM2 50um)                         : 0m
        Length (OM1 62.5um)                       : 0m
        Length (Copper or Active cable)           : 0m
        Transmitter technology                    : 0x00 (850 nm VCSEL)
        Laser wavelength                          : 850.000nm
        Laser wavelength tolerance                : 10.000nm
        Vendor name                               : AVAGO
        Vendor OUI                                : 00:17:6a
        Vendor PN                                 : <REDACTED>
        Vendor rev                                : 01
        Vendor SN                                 : <REDACTED>
        Date code                                 : <REDACTED>
        Revision Compliance                       : Revision not specified
        Module temperature                        : 42.17 degrees C / 107.90 degrees F
        Module voltage                            : 3.2917 V
        Alarm/warning flags implemented           : Yes
        Laser tx bias current (Channel 1)         : 6.662 mA
        Laser tx bias current (Channel 2)         : 0.000 mA
        Laser tx bias current (Channel 3)         : 0.000 mA
        Laser tx bias current (Channel 4)         : 0.000 mA
        Transmit avg optical power (Channel 1)    : 0.7119 mW / -1.48 dBm
        Transmit avg optical power (Channel 2)    : 0.0000 mW / -inf dBm
        Transmit avg optical power (Channel 3)    : 0.0000 mW / -inf dBm
        Transmit avg optical power (Channel 4)    : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 1)  : 0.7682 mW / -1.15 dBm
        Rcvr signal avg optical power(Channel 2)  : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 3)  : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 4)  : 0.0000 mW / -inf dBm
        Laser bias current high alarm   (Chan 1)  : Off
        Laser bias current low alarm    (Chan 1)  : Off
        Laser bias current high warning (Chan 1)  : Off
        Laser bias current low warning  (Chan 1)  : Off
        Laser bias current high alarm   (Chan 2)  : Off
        Laser bias current low alarm    (Chan 2)  : Off
        Laser bias current high warning (Chan 2)  : Off
        Laser bias current low warning  (Chan 2)  : Off
        Laser bias current high alarm   (Chan 3)  : Off
        Laser bias current low alarm    (Chan 3)  : Off
        Laser bias current high warning (Chan 3)  : Off
        Laser bias current low warning  (Chan 3)  : Off
        Laser bias current high alarm   (Chan 4)  : Off
        Laser bias current low alarm    (Chan 4)  : Off
        Laser bias current high warning (Chan 4)  : Off
        Laser bias current low warning  (Chan 4)  : Off
        Module temperature high alarm             : Off
        Module temperature low alarm              : Off
        Module temperature high warning           : Off
        Module temperature low warning            : Off
        Module voltage high alarm                 : Off
        Module voltage low alarm                  : Off
        Module voltage high warning               : Off
        Module voltage low warning                : Off
        Laser tx power high alarm   (Channel 1)   : Off
        Laser tx power low alarm    (Channel 1)   : Off
        Laser tx power high warning (Channel 1)   : Off
        Laser tx power low warning  (Channel 1)   : Off
        Laser tx power high alarm   (Channel 2)   : Off
        Laser tx power low alarm    (Channel 2)   : Off
        Laser tx power high warning (Channel 2)   : Off
        Laser tx power low warning  (Channel 2)   : Off
        Laser tx power high alarm   (Channel 3)   : Off
        Laser tx power low alarm    (Channel 3)   : Off
        Laser tx power high warning (Channel 3)   : Off
        Laser tx power low warning  (Channel 3)   : Off
        Laser tx power high alarm   (Channel 4)   : Off
        Laser tx power low alarm    (Channel 4)   : Off
        Laser tx power high warning (Channel 4)   : Off
        Laser tx power low warning  (Channel 4)   : Off
        Laser rx power high alarm   (Channel 1)   : Off
        Laser rx power low alarm    (Channel 1)   : Off
        Laser rx power high warning (Channel 1)   : Off
        Laser rx power low warning  (Channel 1)   : Off
        Laser rx power high alarm   (Channel 2)   : Off
        Laser rx power low alarm    (Channel 2)   : Off
        Laser rx power high warning (Channel 2)   : Off
        Laser rx power low warning  (Channel 2)   : Off
        Laser rx power high alarm   (Channel 3)   : Off
        Laser rx power low alarm    (Channel 3)   : Off
        Laser rx power high warning (Channel 3)   : Off
        Laser rx power low warning  (Channel 3)   : Off
        Laser rx power high alarm   (Channel 4)   : Off
        Laser rx power low alarm    (Channel 4)   : Off
        Laser rx power high warning (Channel 4)   : Off
        Laser rx power low warning  (Channel 4)   : Off
        Laser bias current high alarm threshold   : 10.000 mA
        Laser bias current low alarm threshold    : 0.500 mA
        Laser bias current high warning threshold : 9.500 mA
        Laser bias current low warning threshold  : 1.000 mA
        Laser output power high alarm threshold   : 0.0000 mW / -inf dBm
        Laser output power low alarm threshold    : 0.0000 mW / -inf dBm
        Laser output power high warning threshold : 0.0000 mW / -inf dBm
        Laser output power low warning threshold  : 0.0000 mW / -inf dBm
        Module temperature high alarm threshold   : 75.00 degrees C / 167.00 degrees F
        Module temperature low alarm threshold    : -5.00 degrees C / 23.00 degrees F
        Module temperature high warning threshold : 70.00 degrees C / 158.00 degrees F
        Module temperature low warning threshold  : 0.00 degrees C / 32.00 degrees F
        Module voltage high alarm threshold       : 3.6300 V
        Module voltage low alarm threshold        : 2.9700 V
        Module voltage high warning threshold     : 3.4650 V
        Module voltage low warning threshold      : 3.1349 V
        Laser rx power high alarm threshold       : 2.1878 mW / 3.40 dBm
        Laser rx power low alarm threshold        : 0.0446 mW / -13.51 dBm
        Laser rx power high warning threshold     : 1.7378 mW / 2.40 dBm
        Laser rx power low warning threshold      : 0.1122 mW / -9.50 dBm

Looks like all we need to do is:

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        2024-04-17 02:19:38.000000000 -0700
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        2024-05-22 12:46:57.290947887 -0700
@@ -2055,15 +2055,15 @@
        switch (data[0] /* identifier */) {
        case MLX4_MODULE_ID_QSFP:
                modinfo->type = ETH_MODULE_SFF_8436;
-               modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+               modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
                break;
        case MLX4_MODULE_ID_QSFP_PLUS:
                if (data[1] >= 0x3) { /* revision id */
                        modinfo->type = ETH_MODULE_SFF_8636;
-                       modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
+                       modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
                } else {
                        modinfo->type = ETH_MODULE_SFF_8436;
-                       modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+                       modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
                }
                break;
        case MLX4_MODULE_ID_QSFP28:

If I'm not mistaken, the rest of the logic is already there, such as:

static void mlx4_qsfp_eeprom_params_set(u8 *i2c_addr, u8 *page_num, u16 *offset)
{
        /* Offsets 0-255 belong to page 0.
         * Offsets 256-639 belong to pages 01, 02, 03.
         * For example, offset 400 is page 02: 1 + (400 - 256) / 128 = 2
         */
        if (*offset < I2C_PAGE_SIZE)
                *page_num = 0;
        else
                *page_num = 1 + (*offset - I2C_PAGE_SIZE) / I2C_HIGH_PAGE_SIZE;
        *i2c_addr = I2C_ADDR_LOW;
        *offset -= *page_num * I2C_HIGH_PAGE_SIZE;
}

So, we don't need to make as many changes as in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a708fb7b1f8dcc7a8ed949839958cd5d812dd939

> Before you do that, please could you work on ethtool. I would say it
> has a bug. It has been provided with 256 bytes of SPF data. It should
> be able to decode that and print it in human readable format. So the
> EINVAL should not be considered fatal to decoding.

Yes, I was also thinking this way. Luckily, similar to the situation with the mlx4 driver, all the logic is there - sff8636_dom_parse() checks if map->page_03h is set and if not, just returns gracefully.

So, all we need to do is modify sff8636_memory_map_init_pages():
@@ -1038,7 +1039,7 @@
        sff8636_request_init(&request, 0x3, SFF8636_PAGE_SIZE);
        ret = nl_get_eeprom_page(ctx, &request);
        if (ret < 0)
-               return ret;
+               return 0;
        map->page_03h = request.data - SFF8636_PAGE_SIZE;

        return 0;

As you described, we get all the data except the DOM:
        Identifier                                : 0x0d (QSFP+)
        Extended identifier                       : 0x00
        Extended identifier description           : 1.5W max. Power consumption
        Extended identifier description           : No CDR in TX, No CDR in RX
        Extended identifier description           : High Power Class (> 3.5 W) not enabled
        Power set                                 : On
        Power override                            : On
        Connector                                 : 0x0c (MPO Parallel Optic)
        Transceiver codes                         : 0x00 0x00 0x30 0x00 0x00 0x00 0x00 0x00
        Transceiver type                          : SAS 6.0G
        Transceiver type                          : SAS 3.0G
        Encoding                                  : 0x01 (8B/10B)
        BR, Nominal                               : 0Mbps
        Rate identifier                           : 0x00
        Length (SMF,km)                           : 0km
        Length (OM3 50um)                         : 0m
        Length (OM2 50um)                         : 0m
        Length (OM1 62.5um)                       : 0m
        Length (Copper or Active cable)           : 0m
        Transmitter technology                    : 0x00 (850 nm VCSEL)
        Laser wavelength                          : 850.000nm
        Laser wavelength tolerance                : 10.000nm
        Vendor name                               : AVAGO
        Vendor OUI                                : 00:17:6a
        Vendor PN                                 : <REDACTED>
        Vendor rev                                : A0
        Vendor SN                                 : <REDACTED>
        Date code                                 : <REDACTED>
        Revision Compliance                       : Revision not specified
        Rx loss of signal                         : None
        Tx loss of signal                         : None
        Tx fault                                  : None
        Module temperature                        : 40.91 degrees C / 105.63 degrees F
        Module voltage                            : 3.2848 V
        Alarm/warning flags implemented           : No
        Laser tx bias current (Channel 1)         : 6.634 mA
        Laser tx bias current (Channel 2)         : 0.000 mA
        Laser tx bias current (Channel 3)         : 0.000 mA
        Laser tx bias current (Channel 4)         : 0.000 mA
        Transmit avg optical power (Channel 1)    : 0.8101 mW / -0.91 dBm
        Transmit avg optical power (Channel 2)    : 0.0000 mW / -inf dBm
        Transmit avg optical power (Channel 3)    : 0.0000 mW / -inf dBm
        Transmit avg optical power (Channel 4)    : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 1)  : 0.5692 mW / -2.45 dBm
        Rcvr signal avg optical power(Channel 2)  : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 3)  : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 4)  : 0.0000 mW / -inf dBm

Do you think it would make sense to print a warning in such situation, or just handle this silently?

Finally, as I was looking at the code in fallback_set_params() I started thinking if the length check is actually correct?

I think instead of:
 if (offset >= modinfo->eeprom_len)
we may want:
 if (offset + length > modinfo->eeprom_len)

I don't know if it is safe to assume we always read a single page and cross page reads are not allowed and even if so, that we should rely on this instead of checking the len explicitly? What do you think?

Once I hear from y'all I will prepare the patches.

Thanks,
 Krzysztof


