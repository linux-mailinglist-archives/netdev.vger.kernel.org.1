Return-Path: <netdev+bounces-133207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DE89954D0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B070F1C20BC4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4CA1E0E1C;
	Tue,  8 Oct 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fz3md7s9"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF190136327
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406035; cv=none; b=ORmNoVWl/rX9cTYSaKthsUvryrDcZnukKmE6lF6MXbmA0U95WrhGIMRSisVftxXJNh/WBXO/QXxNPpM5aN0iu/3vG2zR4MngJLhuFg0Lkvaox6gyk3uK7L2K0qnN3mNC7MpmCRomYw2WRrTKkH7otCxTgel+dWfiN3TJqe93D2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406035; c=relaxed/simple;
	bh=cy2+Nd3mSSyUPx+2IU9sLg52SkGgw6j33ZBd6EB+3I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cq4pLQbGBbeqLAqQ6d2o5FvYow1QYm6lOHfcZ7jxbrgQpYvfAwJhLtw/PXhT1zBX/10IeV1nKnxQOooCNeDHX0L+qbJlCSHsO8Hi4bOBEfIjajhNmUW+aAdBrYvrRWQfTUsOr0gagVRWXNZL6LlW7Kfo/Tq/ibv96MJaXqtTFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fz3md7s9; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09283978-f414-4c77-b48e-f5586fa67edf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728406031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dniU1CPw6MEtrcCSAAPPs2nQCIYA8qblFbyt/2I4SMM=;
	b=Fz3md7s9fal97y13NLC9M2PYwLK9KTm978suGeiLfNq6wa/TX0CLxYxC6q0/EYskCcWVs9
	kKsjl6M1JeXk4lP4P353syRtQdcct+fZ4pbsuX2daabNNo8vKxigZRqRW+J/han/gZnZf6
	2ACiXES+N56OlQGwjj/abWYJrS/rcVY=
Date: Tue, 8 Oct 2024 17:47:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/5] eth: fbnic: add RX packets timestamping
 support
To: Jacob Keller <jacob.e.keller@intel.com>, Vadim Fedorenko
 <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-4-vadfed@meta.com>
 <a64b3bfd-8a85-4523-aad8-e4b534448a0b@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <a64b3bfd-8a85-4523-aad8-e4b534448a0b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/10/2024 00:14, Jacob Keller wrote:
> 
> 
> On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
>> Add callbacks to support timestamping configuration via ethtool.
>> Add processing of RX timestamps.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>   
>> +/**
>> + * fbnic_ts40_to_ns() - convert descriptor timestamp to PHC time
>> + * @fbn: netdev priv of the FB NIC
>> + * @ts40: timestamp read from a descriptor
>> + *
>> + * Return: u64 value of PHC time in nanoseconds
>> + *
>> + * Convert truncated 40 bit device timestamp as read from a descriptor
>> + * to the full PHC time in nanoseconds.
>> + */
>> +static __maybe_unused u64 fbnic_ts40_to_ns(struct fbnic_net *fbn, u64 ts40)
>> +{
>> +	unsigned int s;
>> +	u64 time_ns;
>> +	s64 offset;
>> +	u8 ts_top;
>> +	u32 high;
>> +
>> +	do {
>> +		s = u64_stats_fetch_begin(&fbn->time_seq);
>> +		offset = READ_ONCE(fbn->time_offset);
>> +	} while (u64_stats_fetch_retry(&fbn->time_seq, s));
>> +
>> +	high = READ_ONCE(fbn->time_high);
>> +
>> +	/* Bits 63..40 from periodic clock reads, 39..0 from ts40 */
>> +	time_ns = (u64)(high >> 8) << 40 | ts40;
>> +
>> +	/* Compare bits 32-39 between periodic reads and ts40,
>> +	 * see if HW clock may have wrapped since last read
>> +	 */
>> +	ts_top = ts40 >> 32;
>> +	if (ts_top < (u8)high && (u8)high - ts_top > U8_MAX / 2)
>> +		time_ns += 1ULL << 40;
>> +
>> +	return time_ns + offset;
>> +}
>> +
> 
> This logic doesn't seem to match the logic used by the cyclecounter
> code, and Its not clear to me if this safe against a race between
> time_high updating and the packet timestamp arriving.
> 
> the timestamp could arrive either before or after the time_high update,
> and the logic needs to ensure the appropriate high bits are applied in
> both cases.

To avoid this race condition we decided to make sure that incoming
timestamps are always later then cached high bits. That will make the
logic above correct.

> Again, I think your use case makes sense to just implement with a
> timecounter and cyclecounter, since you're not modifying the hardware
> cycle counter and are leaving it as free-running.

After discussion with Jakub we decided to keep simple logic without
timecounter + cyclecounter, as it's pretty straight forward.

