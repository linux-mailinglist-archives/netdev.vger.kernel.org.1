Return-Path: <netdev+bounces-84812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F4B898647
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C02B288831
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8C839E5;
	Thu,  4 Apr 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLrsLtWI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06B7580B;
	Thu,  4 Apr 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230998; cv=none; b=tBDxl3lcpJLht01KdCq5DOqgTudv5Jo75pJakBIAEdGP4RCuuiVOGlfGa84X2p6PF1Myv3MaY7hU+lU4NKZtRmlIMnnxpNgbg+TMlrqBpksXTuSSkz5l1ncolRL/P/EZ6MRh0bK9KK7qqgEFgVKCtgqX59sKjaiJhOKvpfMwNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230998; c=relaxed/simple;
	bh=uVry49fJjUe2Hhm3zKZ5KK+niiiH19A39/dh9Eyy/CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAE4o6IT4KbmdFjl8XRDrOoAcCmkWbjtCrMLVYsvqxw651LIWEn5giwCiBD14VhXOs9TyptbYxhaxdvVmOT8r7jTIypzOCPrM32KVek7hPKX1JbDfXlyjqDGVlNMsY5dYhwyYLZt5bftHrX1uqWUDXVVyPu/dMtMptelyUVxPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLrsLtWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B19C433C7;
	Thu,  4 Apr 2024 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712230998;
	bh=uVry49fJjUe2Hhm3zKZ5KK+niiiH19A39/dh9Eyy/CM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RLrsLtWI/kmBxf3hd/4sqZYNqNzie/9EaBUioqizw2uD9sOyEFnYdcBYOx512wJdZ
	 l/C1Ro37u0SchiJ6Sy2NZ2U5rCDf2jVAuHHcS+q6oaWk8KBLehH+Urdsbslamiktsa
	 uHCx+ZIA7eHeIaBQPt1w6DyH8HRbEBwJzLc3siIrf2kU9gv30sl3bidv+DQxvU73Lk
	 YgImWrhQNCdbpzS3t4da9/5vfo2VqhwFu0vrSmnyiLniJsaNFGev+ei54NUT80tzGr
	 cl1nknCrJC2XMXnNOF97BlO/tEfgjGpKOEwaCXE3p9agnWwx/xpdSsMdvR12BemfD7
	 oiaSKiUgCemZA==
Message-ID: <f53e02ef-ee33-4cd0-b045-a3efe7f0fae4@kernel.org>
Date: Thu, 4 Apr 2024 13:43:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] bpf: test_run: Use system page pool for
 XDP live frame mode
To: John Fastabend <john.fastabend@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-3-toke@redhat.com>
 <2746b1d9-2e1f-4e66-89ed-19949a189a92@intel.com>
 <660dbe87d8797_1cf6b2083c@john.notmuch>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <660dbe87d8797_1cf6b2083c@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/04/2024 22.39, John Fastabend wrote:
> Alexander Lobakin wrote:
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> Date: Tue, 20 Feb 2024 22:03:39 +0100
>>
>>> The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
>>> each time it is called and uses that to allocate the frames used for the
>>> XDP run. This works well if the syscall is used with a high repetitions
>>> number, as it allows for efficient page recycling. However, if used with
>>> a small number of repetitions, the overhead of creating and tearing down
>>> the page pool is significant, and can even lead to system stalls if the
>>> syscall is called in a tight loop.
>>>
>>> Now that we have a persistent system page pool instance, it becomes
>>> pretty straight forward to change the test_run code to use it. The only
>>> wrinkle is that we can no longer rely on a custom page init callback
>>> from page_pool itself; instead, we change the test_run code to write a
>>> random cookie value to the beginning of the page as an indicator that
>>> the page has been initialised and can be re-used without copying the
>>> initial data again.
>>>
>>> The cookie is a random 128-bit value, which means the probability that
>>> we will get accidental collisions (which would lead to recycling the
>>> wrong page values and reading garbage) is on the order of 2^-128. This
>>> is in the "won't happen before the heat death of the universe" range, so
>>> this marking is safe for the intended usage.
>>>
>>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> Hey,
>>
>> What's the status of this series, now that the window is open?
>>
>> Thanks,
>> Olek
> 
> Hi Toke,
> 
> I read the thread from top to bottom so seems someone else notices the
> 2^128 is unique numbers not the collision probability. Anywaays I'm still
> a bit confused, whats the use case here? Maybe I need to understand
> what this XDP live frame mode is better?
> 
> Could another solution be to avoid calling BPF_TEST_RUN multiple times
> in a row? Or perhaps have a BPF_SETUP_RUN that does the config and lets
> BPF_TEST_RUN skip the page allocation? Another idea just have the first
> run of BPF_TEST_RUN init a page pool and not destroy it.
> 

I like John's idea of "the first run of BPF_TEST_RUN init a page pool
and not destroy it".  On exit we could start a work-queue that tried to
"destroy" the PP (in the future) if it's not in use.

Page pool (PP) performance comes from having an association with a
SINGLE RX-queue, which means no synchronization is needed then
"allocating" new pages (from the alloc cache array).

Thus, IMHO each BPF_TEST_RUN should gets it's own PP instance, as then
lockless PP scheme works (and we don't have to depend on NAPI /
BH-disable).  This still works with John's idea, as we could simply have
a list of PP instances that can be reused.

--Jesper

