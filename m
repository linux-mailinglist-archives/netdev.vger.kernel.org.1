Return-Path: <netdev+bounces-242168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF72C8CEF1
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 745994E14E0
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 06:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492002BCF4C;
	Thu, 27 Nov 2025 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="gLHvvCfi";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cwXmnxk+"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E605285C9F
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225531; cv=none; b=cDvZSXK00Frg0zcGvWJ3SJvW7jkRVSCSpRZrjt0gIyv3lOX7Fb9UNRphWWlELhLEBU4kc2Tu51B3pxG5KJAcLz5N3EF/O7AYpIsrd8O8iUAqr6ssukXgppa0JnGFr/isEs9AUB0J/BPP6Sgz2xgdtOTZzG64ufFqT/g7zlnVG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225531; c=relaxed/simple;
	bh=x+CuBnaP/YzRwyKaxW69/h0DWudONnL76FYTN0hq8po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfB3OmDsy4RRWE16CTWcvgPe/Fw911cB/kjQGh2gUiIpSZSRIJYltpkwdmwnV65148hpZPS88MDPDWdJdlvny0kbQv5ARr56PkCaBoC+GThagrTWfmP2Z764PlrkAv5zw77NptkoDSnzh8iLe98GUx/4bzJOtYmaK6sTmQ0Jm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=gLHvvCfi; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cwXmnxk+; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1764225195;
	bh=x+CuBnaP/YzRwyKaxW69/h0DWudONnL76FYTN0hq8po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gLHvvCfiG5LjLCsW8QxYOImiihEz++KsHx58I79nGcBMOXVpbgT8Y+KOMZ/Gxe1E6
	 9e3dnJ26GgbgoOqYRWgPjYMLKcyENdOoPftmo3D6GTy/xzaYYw82DBbPGRCw+gCD7k
	 zzYClm7K7Dn7q956WTi+B9uun/VYlzBR9qb4T4P1ZjOAPwX4kKMlf5iJiwcvqU4v8M
	 I2D0v/V9qjobR/aCKUG+23cnQxpIyJJDTulSH+T3m/sMICL1mYj8PJ5jKnesmA2ojA
	 SS7RdlNFu24b7DlXqMHYANFdUPBcqVppuNIjp3tEY1Cu+AZLBQGzmxv4xUAawYeDIr
	 fZc4Th+sT8Uxg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8BCE03EBEE; Thu, 27 Nov 2025 06:33:15 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1764225194;
	bh=x+CuBnaP/YzRwyKaxW69/h0DWudONnL76FYTN0hq8po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cwXmnxk+y6PzKC31A1JshuNc2GU3+fRpM7vffZJeoInIlB0jqdqcN/wDFVcniabvF
	 c8P0pwVKn+6hZdWRIDuACGeOwBaj0XcOhKz1fS0muE8d0PZJfuE5XTRx9+t1fGqqbu
	 TiT2lDv/rtYoo0xgnCRCLeI5gm223TDSqCte9UEysVIhGM1mWqST2evsl+hiN9LBpm
	 smEiT0s1/zLyWUdalyu/NUHy+XEXl4KkuxeMFc8EFePCDYd2nETAZ0lMNOfyp2NGUI
	 Lvb8DvJPOYjh9T3Ei7qMyX/UqKFzUDbXJbP0vhlZCKquKIa+apKXQcwdws3V3lRoVk
	 ZH0dwybqDe/uw==
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 516173EA43;
	Thu, 27 Nov 2025 06:33:14 +0000 (UTC)
Message-ID: <93508e7f-cf7e-40f6-bf28-fb9e70ea3184@birger-koblitz.de>
Date: Thu, 27 Nov 2025 07:33:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/11] ixgbe: Add 10G-BX support
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rinitha S <sx.rinitha@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
 <20251125223632.1857532-4-anthony.l.nguyen@intel.com>
 <20251126153245.66281590@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20251126153245.66281590@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/11/2025 12:32 am, Jakub Kicinski wrote:
> 
> 
>> @@ -1678,6 +1680,31 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
>>   			else
>>   				hw->phy.sfp_type =
>>   					ixgbe_sfp_type_1g_bx_core1;
>> +		/* Support Ethernet 10G-BX, checking the Bit Rate
>> +		 * Nominal Value as per SFF-8472 to be 12.5 Gb/s (67h) and
>> +		 * Single Mode fibre with at least 1km link length
>> +		 */
>> +		} else if ((!comp_codes_10g) && (bitrate_nominal == 0x67) &&
>> +			   (!(cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE)) &&
>> +			   (!(cable_tech & IXGBE_SFF_DA_ACTIVE_CABLE))) {
>> +			status = hw->phy.ops.read_i2c_eeprom(hw,
>> +					    IXGBE_SFF_SM_LENGTH_KM,
>> +					    &sm_length_km);
>> +			if (status != 0)
>> +				goto err_read_i2c_eeprom;
>> +			status = hw->phy.ops.read_i2c_eeprom(hw,
>> +					    IXGBE_SFF_SM_LENGTH_100M,
>> +					    &sm_length_100m);
>> +			if (status != 0)
>> +				goto err_read_i2c_eeprom;
>> +			if (sm_length_km > 0 || sm_length_100m >= 10) {
>> +				if (hw->bus.lan_id == 0)
>> +					hw->phy.sfp_type =
>> +						ixgbe_sfp_type_10g_bx_core0;
>> +				else
>> +					hw->phy.sfp_type =
>> +						ixgbe_sfp_type_10g_bx_core1;
>> +			}
>                          ^^^^
> 
> Claude says:
> 
> In ixgbe_identify_sfp_module_generic(), what happens when a module has
> the 10G-BX characteristics (empty comp_codes_10g, bitrate 0x67, fiber
> mode) but the link length check fails (both sm_length values < 1km)?
> 
> The outer else-if condition matches, so we skip the final else clause
> that sets sfp_type to unknown. But the inner if condition fails, so we
> don't set the 10g_bx type either. This leaves hw->phy.sfp_type
> unchanged from whatever value it had previously.
> 
> All other branches in this if-else chain explicitly set sfp_type, but
> this path only conditionally sets it. Should there be an else clause
> after the inner if to set sfp_type = ixgbe_sfp_type_unknown when the
> link length requirement isn't met?
The ixgbe_identify_sfp_module_generic detects SFP modules that it knows 
how to initialize in a positive manner, that is all the conditions have 
to be fulfilled. If this is not the case, then the default from 
ixgbe_main.c:ixgbe_probe() kicks in, which sets
	hw->phy.sfp_type = ixgbe_sfp_type_unknown;
before probing the SFP. The else is unnecessary.

If the SFP module cannot be positively identified, then that functions 
logs an error:
	e_dev_err("failed to load because an unsupported SFP+ or QSFP module 
type was detected.\n");
	e_dev_err("Reload the driver after installing a supported module.\n");


