Return-Path: <netdev+bounces-142133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1459BD9D2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512441F239B4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21706216A28;
	Tue,  5 Nov 2024 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WakmP/W+"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCBA1D31A9
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850143; cv=none; b=eECuNCSd55GaHTykk7N25qnJpf68asfCnQOxLu0bXwso9t4td8qElfbA6SN4BEtMKTSxi89x6ta+DkpZvM+TRwqzVUTt0My+zyWd/bCO78EFC+EggtcDNH0Uoxh5xGDgO+ocA4X/G4aOV9U6OBClWcxKZGigoztxBIo/Yg2yCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850143; c=relaxed/simple;
	bh=0jVs9zHue4+7eJEKCH21MgnPhUP2ISKxYTONZ8VxzwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDrcDjjajfFO/eeYA4iEOCMRw+1WA4vtvHxSegpQJwAOm99ugRrlRhf5WVTf4BgqekKpxV5X/e5yNCnobYnNkeH8EVDj7fR5/DPUCtQCs5nJqEb3VyMQ6SxQOf6JELkLgkbgzCOTUrDXGwcHg6J2ecGqxw4V96wMI/i270weKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WakmP/W+; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <771bd976-e68c-48d0-bfbd-1f1b73d7bb91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730850139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ejCR1VlU2IfzBLT6gtDi6E+/DpO3ZNW9b3UKwQgrR0=;
	b=WakmP/W+Yz8B36HqJoKm6qFanPL+TsWNStmC42tMritQf1tcUqlOSffDUwIEXot2LtuYe2
	fUW7D2tRyx1CvWSLmRNUpv2HNBpWaD3UlrVsZ3bwKS04/NAtd2+P0VAvKDZIFf/RCHNb3x
	QUkk0ICxPFRvU0oS3J5wkK9ziM0Fa4o=
Date: Tue, 5 Nov 2024 23:42:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Pedro Tammela <pctammela@mojatatu.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
 <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
 <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
 <9dbb815a-0137-4565-ad91-8ed92d53bced@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <9dbb815a-0137-4565-ad91-8ed92d53bced@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/11/2024 22:14, Alexandre Ferrieux wrote:
>> On 04/11/2024 22:33, Vadim Fedorenko wrote:
>>>> On 04/11/2024 18:00, Pedro Tammela wrote:
>>>>> 'static inline' is discouraged in .c files
>>>>
>>>> Why ?
>>>>
>>>> It could have been a local macro, but an inline has (a bit) better type
>>>> checking. And I didn't want to add it to a .h that is included by many other
>>>> unrelated components, as it makes no sense to them. So, what is the recommendation ?
>>>
>>> Either move it to some local header file, or use 'static u32
>>> handle2id(u32 h)'
>>> and let compiler decide whether to include it or not.
>>
>> I believe you mean "let the compiler decide whether to _inline_ it or not".
>> Sure, with a sufficiently modern Gcc this will do. However, what about more
>> exotic environments ? Wouldn't it risk a perf regression for style reasons ?
>>
>> And speaking of style, what about the dozens of instances of "static inline" in
>> net/sched/*.c alone ? Why is it a concern suddenly ?
> 
> Can you please explain *why* in the first place you're saying "'static inline'
> is discouraged in .c files" ? I see no trace if this in coding-style.rst, and
> the kernel contains hundreds of counter-examples.

The biggest reason is because it will mask unused function warnings when
"static inline" function will not be used because of some future
patches. There is no big reason to refactor old code that's why there
are counter-examples in the kernel, but the new code shouldn't have it.

I don't really understand what kind of exotic environment you are
thinking about, but modern kernel has proper gcc/clang version
dependency, both of these compilers have good heuristics to identify
which function to inline.


