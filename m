Return-Path: <netdev+bounces-228884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533CBD5753
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A56DE4F06B0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38729AB15;
	Mon, 13 Oct 2025 17:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1A35965;
	Mon, 13 Oct 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375843; cv=none; b=sPpNnLrKZECK+gzLtYbM8cDTxCObYmcwBgfnzxNQUTjFnY66X0d0i1GzDp2upXL/mNVrL9qHsT+EBpLiJ9BhnEafukU9Clcs7oP7pHiQrnNTAofATWZd94tTCE6nicLm3xanEvvFSIH2TrIgZTZac0D7we/YIflqu4Dm4lJvr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375843; c=relaxed/simple;
	bh=fcND229VHRDota8cK8z5FL5e4ujtwhOSk4MZxJErcQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFilvUn++b09+396sD97svDGzF8dseyDq31tCNaQifhzTpJmctkBbwQmjnTCqKTSQyP0JizDBzJg3bu9BAuttcWRaKiZGhvS6dh224UbYxCVCRTCxXQKSZm9XV0q1YkP9o8rTi3wDWKjTp6UsS1JnzkV2YFkQPDkcKvjoZYiAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 85DA648532; Mon, 13 Oct 2025 17:17:19 +0000 (UTC)
X-Spam-Level: 
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 87BC3484CE;
	Mon, 13 Oct 2025 17:17:18 +0000 (UTC)
Message-ID: <70d926a1-e118-43d9-8715-70feebc214a5@birger-koblitz.de>
Date: Mon, 13 Oct 2025 19:17:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ixgbe: Add 10G-BX support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-10gbx-v1-1-ab9896af3d58@birger-koblitz.de>
 <b5dd3a3e-2420-4c7c-b690-3799fac14623@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <b5dd3a3e-2420-4c7c-b690-3799fac14623@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2025 6:31 pm, Andrew Lunn wrote:
>> @@ -1678,6 +1679,26 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
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
>> +					    IXGBE_SFF_SM_LENGTH,
>> +					    &sm_length);
> 
> It seems like byte 15, Length (SMF), "Link length supported for single
> mode fiber, units of 100 m" should be checked here. A 255 * 100m would
> be more than 1Km, the condition you say in the comment.
> 
> 	Andrew

Bytes 14 and 15 refer to the same information, just in different units. 
Byte 14 is the SM link length in km, byte 15 the same in 100m units. BX 
offers a link length of at least 1km, up to at least 40km, which would 
overflow to 255 in byte 15. In theory one could make a consistency check 
between bytes 14 and 15 by dividing byte 15 by 10 and comparing the 
result with byte 14, but in terms of identifying link lengths of >=1km, 
checking byte 14 is probably enough, in particular as rounding of byte 
14 could be inconsistently done, making the consistency check difficult. 
One could also check for byte 14 to be 0 and byte 15 to be < 10 to 
identify SM links <1km, but I do not believe such BX modules exist and 
again, there would be the issue of rounding for link lengths >=500m.

Birger

