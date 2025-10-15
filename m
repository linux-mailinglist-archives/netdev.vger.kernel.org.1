Return-Path: <netdev+bounces-229532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1186BDDBD5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296EC4017D6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECB130BBA4;
	Wed, 15 Oct 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fgd2Wpx1";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fxXL+UWl"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71A3090F7;
	Wed, 15 Oct 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519785; cv=none; b=fdYfmgdlTNE4ojpwjcSoB0sNTUyta5ruwN3yroZui13zDwE9HixtPUufr+DQ4GI1pemBV2KcNKZ1ZxlpRx61Uw/2QHDIGzqZl9NzwzqHg24Jvyocl0irOsReFLJzjMKCvfOZru1SXF/Iea7t46EdZ1kZftga17Xjyjk/yiDuaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519785; c=relaxed/simple;
	bh=T0AYQjcYUXwKwFItR8IpyQ2sLUmEmwaqS1bby4hv2K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1WIO3fdrjnQ6k/71SwFy1xCs0P51NgSEluJGW1J+vo2pfGtipTkoxV0tPNbrfLvzcDXVBBv4Jb8YxjEBIxnGIKZ0mHIM++yzRvOHxu1zRmHsVU62f3FiGS2+ZX2s8JFM8hrzp0hZLPsek31z4J02kGZKtAMHu6XMcjlhDrdhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fgd2Wpx1; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fxXL+UWl; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1760519775;
	bh=T0AYQjcYUXwKwFItR8IpyQ2sLUmEmwaqS1bby4hv2K4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fgd2Wpx1MLC43z585qDyMq+W8KnJKWZD/uWr8nHDcHR7r/ManA4HSZQzuv0ATPev7
	 3f4QLs9prlWBRp469rMqBQ7jZ61UskiV/0L6F/6tgUBgcQkmIvPS5nq6+WKNaw+Gyp
	 Qv1a18SsTYsjHStuTp/aMGF3ww0PdBZr1oRGideydJKMXAlCTPvsKoDeoUNXxpZqBG
	 qy1Tdu9+zFSMWQUXsMDr/pLfWuEMa2ZQtRRN/cf4LN4naRAqEpzmuB4VPbTsh9ZrW7
	 CK1jusDP765hr6tKMclgExPnxkmnQYRujJdXrO29oSJeuSDQOD4Uqf8677LYM/jzHN
	 9TMGdOgCF+21Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id F404F4851F; Wed, 15 Oct 2025 09:16:15 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1760519765;
	bh=T0AYQjcYUXwKwFItR8IpyQ2sLUmEmwaqS1bby4hv2K4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fxXL+UWl2tLv1eu/uap1tqyzE7ORIVf35shixhwoTKsYAUbBN+72K3cPRx+l6CMGG
	 erTDtb8dAajLKMdoHB8neU+9L25ukvFO3z3sxWFHuhqpXPG5f45POoQe7GOvaAdp+B
	 ZS3xlxbXEpAnFfJw7L5qb5mHp2zPozS5mo83hVd6Qz/i+LEvvYtZaAyF5XszYi2QTa
	 Rj6t4GfXwjUQkdIwNHWqiiy+el+K3u5ssoGYgh4VJGDuzv+u5odccTDbYsoF324kgz
	 xJQfSjqoCPokJWr5SmthRZ1NfOfPf2haFuVLpoEQYX+LcxlEOTmc6Z9KT07TlJPg6N
	 ZZ9HyasYcXxmg==
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 78FB6484E4;
	Wed, 15 Oct 2025 09:16:05 +0000 (UTC)
Message-ID: <0d2b88ac-d23d-43a5-813d-2a8c4edaa3eb@birger-koblitz.de>
Date: Wed, 15 Oct 2025 11:16:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ixgbe: Add 10G-BX support
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251014-10gbx-v2-1-980c524111e7@birger-koblitz.de>
 <21a53fe4-7cad-4717-87db-2f433659e174@molgen.mpg.de>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <21a53fe4-7cad-4717-87db-2f433659e174@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Paul,

thank you for your feedback!

On 15/10/2025 9:59 am, Paul Menzel wrote:
> Am 14.10.25 um 06:18 schrieb Birger Koblitz:
>> Adds support for 10G-BX modules, i.e. 10GBit Ethernet over a single 
>> strand
>> Single-Mode fiber
> 
> I’d use imperative mood, and add a dot/period at the end.
I will put this into the next patch-version.

>> @@ -1678,6 +1680,31 @@ int ixgbe_identify_sfp_module_generic(struct 
>> ixgbe_hw *hw)
>>               else
>>                   hw->phy.sfp_type =
>>                       ixgbe_sfp_type_1g_bx_core1;
>> +        /* Support Ethernet 10G-BX, checking the Bit Rate
>> +         * Nominal Value as per SFF-8472 to be 12.5 Gb/s (67h) and
>> +         * Single Mode fibre with at least 1km link length
>> +         */
>> +        } else if ((!comp_codes_10g) && (bitrate_nominal == 0x67) &&
>> +               (!(cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE)) &&
>> +               (!(cable_tech & IXGBE_SFF_DA_ACTIVE_CABLE))) {
>> +            status = hw->phy.ops.read_i2c_eeprom(hw,
>> +                        IXGBE_SFF_SM_LENGTH_KM,
>> +                        &sm_length_km);
>> +            if (status != 0)
>> +                goto err_read_i2c_eeprom;
> 
> Should an error be logged?
> 
This needs to be read in the context of the rest of the SFP 
identification function. Several bytes of the EEPROM have already been 
read for module identification by the existing code before reaching this 
point, and failure is handled everywhere by the same goto. What will 
happen if EEPROM reading fails is that an error message will be logged 
that the Module is not supported. This is because the type is not filled 
in and the module therefore considered unsupported. The actual error 
(ret_val = -ENOENT) is ignored e.g. in 
ixgbe_52599/ixgbe_init_phy_ops_82599(). The error logged is probably 
good enough: the module cannot be positively identified and is not 
enabled. I say good enough, because this is actually what is the case: 
the EEPROM is broken and ther

>> +            status = hw->phy.ops.read_i2c_eeprom(hw,
>> +                        IXGBE_SFF_SM_LENGTH_100M,
>> +                        &sm_length_100m);
>> +            if (status != 0)
>> +                goto err_read_i2c_eeprom;
> 
> Should an error be logged?
Same here.

> 
>> +            if (sm_length_km > 0 || sm_length_100m >= 10) {
>> +                if (hw->bus.lan_id == 0)
>> +                    hw->phy.sfp_type =
>> +                        ixgbe_sfp_type_10g_bx_core0;
>> +                else
>> +                    hw->phy.sfp_type =
>> +                        ixgbe_sfp_type_10g_bx_core1;
> 
> I’d prefer the ternary operator, if only the same variable is assigned 
> in both branches.
Me, too. But this is merely code that can be found verbosely the same in 
several places before in this identification function, for each type of 
module identified basically once. If the same code would be written 
differently in this place, it would probably confuse readers who would 
wonder what is different.

Cheers,
   Birger


