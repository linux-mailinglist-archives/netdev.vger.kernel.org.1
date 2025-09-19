Return-Path: <netdev+bounces-224747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C3B8926D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711DC582B59
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE72EE5FF;
	Fri, 19 Sep 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+AxuxFI"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA3244668
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279184; cv=none; b=V9TRRN3hhPgUFveHL01S+PwonHfm4FoArqst9X/UQAncW0Ef0jEaUKftzdTPT4OB4hilBQK+CYXwHAA5yzoPT+Cc3zLUFBxCVMtRYG2qDgx1MX5KtS9z1fbRjxrkxqOvfMEpvinB/lhlVdPTndJURW1aI7rea6ZLDRJGGPDpk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279184; c=relaxed/simple;
	bh=TmC/GnHlrQftISt0Z1IVSPLhIKJsA9OmSpxl1Z3csFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+FTLnjPK+m0vlj0fhPLllRlyE/Yr/6WWRIpyGphZSwZJFjzU1CoFeNWlEPSLFAl3p7hGo83CcVlVCSRQvR2RG2Zh3wljFog5dTWUD5r4/cvy6tSXJb+YF0/yOSd68p//08BSmIyPHrjRyFiPlyYYlmONWJszcSc2fmi07d++ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+AxuxFI; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa5c3ebc-8d9e-411b-b976-97b88272bfda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758279170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaewsVgW1iC3I46EuqYekXE6jhi8j1vA8fdWosmeV4A=;
	b=m+AxuxFIsYei4VE683Ai8LpFP9ftj0+0Q952VmRkO1GYIFMnzGJ/pmw7AHaC+HCLW+xsLc
	xt9m3e9Ouj2gsgSmv/zN0tg89Rfd/cgmGO74KcdAlzhLR0h3x/l4l/Ssf+icT7D9EfoLsI
	0K8uGK1PwOl/QFa1+SwImRXHaeBcRU8=
Date: Fri, 19 Sep 2025 11:52:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igc: fix race condition in
 TX timestamp read for register 0
To: Jacob Keller <jacob.e.keller@intel.com>,
 Chwee-Lin Choong <chwee.lin.choong@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Avi Shalev <avi.shalev@intel.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>
References: <20250918183811.31270-1-chwee.lin.choong@intel.com>
 <0fc877a5-4b35-4802-9cda-e4eca561c5d1@linux.dev>
 <d30d7a43-ca17-445e-b7ae-641be2fcc165@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <d30d7a43-ca17-445e-b7ae-641be2fcc165@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/09/2025 23:10, Jacob Keller wrote:
> 
> 
> On 9/18/2025 1:47 PM, Vadim Fedorenko wrote:
>> On 18/09/2025 19:38, Chwee-Lin Choong wrote:
>>> The current HW bug workaround checks the TXTT_0 ready bit first,
>>> then reads LOW -> HIGH -> LOW from register 0 to detect if a
>>> timestamp was captured.
>>>
>>> This sequence has a race: if a new timestamp is latched after
>>> reading the TXTT mask but before the first LOW read, both old
>>> and new timestamp match, causing the driver to drop a valid
>>> timestamp.
>>>
>>> Fix by reading the LOW register first, then the TXTT mask,
>>> so a newly latched timestamp will always be detected.
>>>
>>> This fix also prevents TX unit hangs observed under heavy
>>> timestamping load.
>>>
>>> Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing timestamps")
>>> Suggested-by: Avi Shalev <avi.shalev@intel.com>
>>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>>> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/igc/igc_ptp.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>
>> [...]
>>
>>>    		 * timestamp was captured, we can read the "high"
>>>    		 * register again.
>>>    		 */
>>
>> This comment begins with 'read the "high" register (to latch a new
>> timestamp)' ...
>>
>>> -		u32 txstmpl_old, txstmpl_new;
>>> +		u32 txstmpl_new;
>>>    
>>> -		txstmpl_old = rd32(IGC_TXSTMPL);
>>>    		rd32(IGC_TXSTMPH);
>>>    		txstmpl_new = rd32(IGC_TXSTMPL);
>>
>> and a couple of lines later in this function you have
>>
>> 		regval = txstmpl_new;
>> 		regval |= (u64)rd32(IGC_TXSTMPH) << 32;
>>
>> According to the comment above, the value in the register will be
>> latched after reading IGC_TXSTMPH. As there will be no read of "low"
>> part of the register, it will stay latched with old value until the
>> next call to the same function. Could it be the reason of unit hangs?
>>
>> It looks like the value of previous read of IGC_TXSTMPH should be stored
>> and used to construct new timestamp, right?
>>
> 
> I wouldn't trust the comment, but instead double check the data sheets.
> Unfortunately, I don't seem to have a copy of the igc hardware data
> sheet handy :(

Well, if the register is not latched, the usual pattern of reading
high->low->high should be applied to avoid overflow scenario, but I
don't see it in neither original, nor updated code. So I would assume
the comment is correct. But I totally agree, data sheet would be proper
source of truth.

