Return-Path: <netdev+bounces-133221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3F6995569
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87C31C247CC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EA41E22EC;
	Tue,  8 Oct 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YjaXWjDK"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDA1E22EA
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407598; cv=none; b=F/pWQgeZSe30HqTQEm2URRcnh85u21ebH7SFUwJobM+CZul82hLSoPtSjChIUvAcrdg3zqPVTxaVW2jyDy04jQEGv1w8HeWW67taqdt5lv1rdK1d1p/aUTLz/HxpcZw1/SnroXrIPtxs2CDXzekniyhMbTd9ZPtXZ5D6Zt+m5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407598; c=relaxed/simple;
	bh=ft1sGrEGEicqVhDTwSRTmwfIMvqalFUtxO/PMZOeO9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6DiJUm+6UU/x0nD2QaEXhOeMiGVpCN3l9Oi73/vSzoTBHTqETcmZipjDiga4zorumGzt/S2Lm7SbxnsZ/IYN5/pawmxFlDM0TNl9p3EIYd04S4OO4S6ZdUuIM2TIUpXtWxzZQ4F+3lxUS+FV6pNos9Pkvil1lq8mCw53hz0cPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YjaXWjDK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fbf9e403-d21c-4652-a48a-427d9942b82e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728407593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tthQE5vS8hCxdo3zSEsIuqWMp4dVf3PsjZMYq+8Yu3o=;
	b=YjaXWjDKoDOQ0FByBFOsrnhhhnp45BPg77SLLHLXacnYj+Qqsm9yyeQQ2ibz0GjXDiS6Mr
	xgiiPHseBSuBRO+34fjxMN8CCg//GLFVzN5i90CNwozFOctvmBCxCbgE1rXMg42kye3BRb
	lNLEJs4xUASRpo4DkrhGCmbBYKI6K2A=
Date: Tue, 8 Oct 2024 18:13:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/5] eth: fbnic: add RX packets timestamping
 support
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-4-vadfed@meta.com>
 <a64b3bfd-8a85-4523-aad8-e4b534448a0b@intel.com>
 <09283978-f414-4c77-b48e-f5586fa67edf@linux.dev>
 <89b40200-34b5-4c94-9e5a-2a6626d44477@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <89b40200-34b5-4c94-9e5a-2a6626d44477@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/10/2024 18:01, Jacob Keller wrote:
> 
> 
> On 10/8/2024 9:47 AM, Vadim Fedorenko wrote:
>> On 05/10/2024 00:14, Jacob Keller wrote:
>>>
>>>
>>> On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
>>>> Add callbacks to support timestamping configuration via ethtool.
>>>> Add processing of RX timestamps.
>>>>
>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>>    
>>>> +/**
>>>> + * fbnic_ts40_to_ns() - convert descriptor timestamp to PHC time
>>>> + * @fbn: netdev priv of the FB NIC
>>>> + * @ts40: timestamp read from a descriptor
>>>> + *
>>>> + * Return: u64 value of PHC time in nanoseconds
>>>> + *
>>>> + * Convert truncated 40 bit device timestamp as read from a descriptor
>>>> + * to the full PHC time in nanoseconds.
>>>> + */
>>>> +static __maybe_unused u64 fbnic_ts40_to_ns(struct fbnic_net *fbn, u64 ts40)
>>>> +{
>>>> +	unsigned int s;
>>>> +	u64 time_ns;
>>>> +	s64 offset;
>>>> +	u8 ts_top;
>>>> +	u32 high;
>>>> +
>>>> +	do {
>>>> +		s = u64_stats_fetch_begin(&fbn->time_seq);
>>>> +		offset = READ_ONCE(fbn->time_offset);
>>>> +	} while (u64_stats_fetch_retry(&fbn->time_seq, s));
>>>> +
>>>> +	high = READ_ONCE(fbn->time_high);
>>>> +
>>>> +	/* Bits 63..40 from periodic clock reads, 39..0 from ts40 */
>>>> +	time_ns = (u64)(high >> 8) << 40 | ts40;
>>>> +
>>>> +	/* Compare bits 32-39 between periodic reads and ts40,
>>>> +	 * see if HW clock may have wrapped since last read
>>>> +	 */
>>>> +	ts_top = ts40 >> 32;
>>>> +	if (ts_top < (u8)high && (u8)high - ts_top > U8_MAX / 2)
>>>> +		time_ns += 1ULL << 40;
>>>> +
>>>> +	return time_ns + offset;
>>>> +}
>>>> +
>>>
>>> This logic doesn't seem to match the logic used by the cyclecounter
>>> code, and Its not clear to me if this safe against a race between
>>> time_high updating and the packet timestamp arriving.
>>>
>>> the timestamp could arrive either before or after the time_high update,
>>> and the logic needs to ensure the appropriate high bits are applied in
>>> both cases.
>>
>> To avoid this race condition we decided to make sure that incoming
>> timestamps are always later then cached high bits. That will make the
>> logic above correct.
>>
> 
> How do you do that? Timestamps come in asynchronously. The value is
> captured by hardware. How do you guarantee that it was captured only
> after an update to the cached high bits?
> 
> I guess if it arrives before the roll-over, you handle that by the range
> check to see if the clock wrapped around.
> 
> Hmm.
> 
> But what happens if an Rx timestamp races with an update to the high
> value and comes in just before the 40 bit time would have overflowed,
> but the cached time_high value is captured just after it overflowed.
> 
> Do you have some mechanism to ensure that this is impossible? i.e.
> either ensuring that the conversion uses the old time_high value, or
> ensuring that Rx timestamps can't come in during an update?
> 
> Otherwise, I think the logic here could accidentally combine a time
> value from an Rx timestamp that is just prior to the time_high update
> and just prior to a rollover, then it would see a huge gap between the
> values and trigger the addition of another 1 << 40, which would cycle it
> even farther out of what the real value should have been.

Yes, you are absolutely correct, we have missed the situation when the
logic can bring additional (1 << 40) value on top of wrongly calculated
higher bits. This can only happen in case of overflow of lower 8 bits of
high cached value. But if we keep high cached value a bit below the real
value, this will never happen. If we subtract 16 from high value it will
translate into ~1 minute of oldness of cached value. If for any reasons
the packet processing will be delayed by 1 minute, user-space app will
definitely give up on waiting for the packet/timestamp and will ignore
wrong timestamp. In all other cases the logic in fbnic_ts40_to_ns() will
work perfectly fine.

>>> Again, I think your use case makes sense to just implement with a
>>> timecounter and cyclecounter, since you're not modifying the hardware
>>> cycle counter and are leaving it as free-running.
>>
>> After discussion with Jakub we decided to keep simple logic without
>> timecounter + cyclecounter, as it's pretty straight forward.
> 
> Fair enough.


