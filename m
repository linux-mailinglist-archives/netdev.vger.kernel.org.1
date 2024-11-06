Return-Path: <netdev+bounces-142332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A738E9BE4DF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE5E1F27B25
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1551DD525;
	Wed,  6 Nov 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wZmdVm6G"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C0E1D278C
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890472; cv=none; b=SvQBshoTFnXEBwIn/B0EKB2ktx6L/IWdLqOxAGYRC4q3DsPnhukoVOtsmkLhI99C4UQzTDjAmk0oL0c0yqtK9XLAtnmlRT0zEQdkxUgOCD/e99l/B1p1tJmAXnrMMtPpbwoGztDkdo5UiKauE2jf/2zGuccIIrPZqA8CkkTdBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890472; c=relaxed/simple;
	bh=2vJwLVuKi9QQ269rZIFWxx2Km1vebYt3WRKfcSlJ1Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHbztYOdgt3Lh4jfQ6c4TzbGDgh/4N5dvt89vwLf3LqHQBmzQq78AmnpFiWBkHl17fdyF+bioKfAoZKFcPr74g/KsZ6CevP8R0+2q5Oof0F266wK6gESVBOHjMlNQbJ2lfjvsabbaaBmlAg4aLoobMTpsOlmTURcQTLIyUhM/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wZmdVm6G; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bf6b5e0a-d44e-4923-93cb-edb41a2ff1a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730890466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UR0EccXeXwgstd99Ae3BF8j0iwXN/SQQWCzA0aDvjw=;
	b=wZmdVm6GYdB9cDxe5gad9iJ0bht6TfTtKlzjSQVyMavzd33OhmKGClU6X/V1G4bZzSxygl
	ajvPdfMy2PngJ1vsaKaxabQgZmteQnalo+8ch1oHr42Tic/80WwpGStOY5fkP2dctxu1WC
	8OYAqekXHp0qC2USn72kOxDJ4sTUPEA=
Date: Wed, 6 Nov 2024 10:54:21 +0000
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
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
 <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
 <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
 <9dbb815a-0137-4565-ad91-8ed92d53bced@gmail.com>
 <771bd976-e68c-48d0-bfbd-1f1b73d7bb91@linux.dev>
 <7cbd8419-2c74-4201-b5a3-7b88c3ec83fe@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <7cbd8419-2c74-4201-b5a3-7b88c3ec83fe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/11/2024 10:15, Alexandre Ferrieux wrote:
> On 06/11/2024 00:42, Vadim Fedorenko wrote:
>> On 05/11/2024 22:14, Alexandre Ferrieux wrote:
>>>
>>> Can you please explain *why* in the first place you're saying "'static inline'
>>> is discouraged in .c files" ? I see no trace if this in coding-style.rst, and
>>> the kernel contains hundreds of counter-examples.
>>
>> The biggest reason is because it will mask unused function warnings when
>> "static inline" function will not be used because of some future
>> patches. There is no big reason to refactor old code that's why there
>> are counter-examples in the kernel, but the new code shouldn't have it.
> 
> A macro doesn't elicit unused function warnings either, so this looks like a
> very weak motivation. While coding-style.rst explicitly encourages to use static
> inline instead of macros, as they have better type checking and syntaxic isolation.

Unused macro will not generate any code and will not make build time
longer. But don't get me wrong, I'm not encouraging you to use macro in
this case.

> Regarding old vs new code, below are the last two month's fresh commits of
> "static inline" in *.c. So it looks like the motivation is not shared by other
> maintainers. Do we expect to see "local styles" emerge ?

There are some "local styles" differences in different subsystems. If
you filter out netdev related diffs from awk-magic below, you will find
that is was mostly refactoring of already existing code.

Anyways, you can ignore this suggestion, it's always up to submitter
how to use review feedback given by others.

> 
> $ git log --pretty='%h %as %ae'   -p | gawk
> '/^[0-9a-f]{12}/{c=$0;next}/^diff/{f=$NF;next}/^[+].*static.inline/{if
> (f~/[.]c$/){print c "\t"gensub(/.*\//,"","1",f)}}'
> 
> baa802d2aa5c 2024-10-21 daniel@iogearbox.net    verifier_const.c
> baa802d2aa5c 2024-10-21 daniel@iogearbox.net    verifier_const.c
> d1744a4c975b 2024-10-21 bp@alien8.de    amd.c
> d1744a4c975b 2024-10-21 bp@alien8.de    amd.c
> a6e0ceb7bf48 2024-10-11 sidhartha.kumar@oracle.com      maple.c
> 78f636e82b22 2024-09-25 freude@linux.ibm.com    ap_queue.c
> 19773ec99720 2024-10-07 kent.overstreet@linux.dev       disk_accounting.c
> 9b23fdbd5d29 2024-09-29 kent.overstreet@linux.dev       inode.c
> 9b23fdbd5d29 2024-09-29 kent.overstreet@linux.dev       inode.c
> 3d5854d75e31 2024-09-30 agordeev@linux.ibm.com  kcore.c
> 3d5854d75e31 2024-09-30 agordeev@linux.ibm.com  kcore.c
> 38864eccf78b 2024-09-30 kent.overstreet@linux.dev       fsck.c
> d278a9de5e18 2024-10-02 perex@perex.cz  init.c
> f811b83879fb 2024-10-02 mpatocka@redhat.com     dm-verity-target.c
> 4c411cca33cf 2024-09-13 artem.bityutskiy@linux.intel.com        intel_idle.c
> 42268ad0eb41 2024-09-24 tj@kernel.org   ext.c
> 56bcd0f07fdb 2024-09-05 snitzer@kernel.org      localio.c
> 1b11c4d36548 2024-09-01 kent.overstreet@linux.dev       ec.c
> 7a51608d0125 2024-09-04 kent.overstreet@linux.dev       btree_cache.c
> 7a51608d0125 2024-09-04 kent.overstreet@linux.dev       btree_cache.c
> 691f2cba2291 2024-09-05 kent.overstreet@linux.dev       btree_cache.c
> 


