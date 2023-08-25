Return-Path: <netdev+bounces-30749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21907788DCD
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 19:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538731C20DAA
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2418030;
	Fri, 25 Aug 2023 17:25:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50642107A8
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 17:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E6FC433C8;
	Fri, 25 Aug 2023 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692984347;
	bh=hQjAYMR2LVMdI/EWun0sAdi1d+BSM7TJKY29+NPc9Bo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=goVhy8INSLR/EKnXvH3yBOjKAZBxY5JuoUhrMWoP/58tltgOkkB7wsDGHaoNdGBz5
	 2jbSouCRoAbgpPNjl2vXSX1tHyjsYlxKoL6TjSl/7dq44LzAkXS43R3oAeteixvGgD
	 FMjaoT/afAYGQJ6ryEkVUo9MvNJAYAASTdk2skKVgtSCTLsEgClxjjUmAZ4CpHMSGu
	 q/ewriYx9zAFEL9P2oe08zqtOkrpql8f1heIyxJXpr5HC+DXJJ4f2YygXLlcEsw3ED
	 b0VWZs/nLD+IWRJ7UsBTgQaw2Ao30BPtIHt+Pv/JNkfMTQjUqhjZTadcmXcqPFp+6w
	 YLEwkBZknxd9w==
Message-ID: <2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
Date: Fri, 25 Aug 2023 19:25:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
 <sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 hariprasad <hkelam@marvell.com>,
 Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
 <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
 <044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
 <ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/08/2023 15.38, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
> Date: Fri, 25 Aug 2023 15:22:05 +0200
> 
>>
>>
>> On 24/08/2023 17.26, Alexander Lobakin wrote:
>>> From: Jesper Dangaard Brouer<hawk@kernel.org>
>>> Date: Wed, 23 Aug 2023 21:45:04 +0200
>>>
>>>> (Cc Olek as he have changes in this code path)
>>> Thanks! I was reading the thread a bit on LKML, but being in the CC list
>>> is more convenient :D
>>>
>>
>> :D
>>
>>>> On 23/08/2023 11.47, Sebastian Andrzej Siewior wrote:
>>>>> Hi,
>>>>>
>>>>> I've been looking at the page_pool locking.
>>>>>
>>>>> page_pool_alloc_frag() -> page_pool_alloc_pages() ->
>>>>> __page_pool_get_cached():
>>>>>
>>>>> There core of the allocation is:
>>>>> |         /* Caller MUST guarantee safe non-concurrent access, e.g.
>>>>> softirq */
>>>>> |         if (likely(pool->alloc.count)) {
>>>>> |                 /* Fast-path */
>>>>> |                 page = pool->alloc.cache[--pool->alloc.count];
>>>>>
>>>>> The access to the `cache' array and the `count' variable is not locked.
>>>>> This is fine as long as there only one consumer per pool. In my
>>>>> understanding the intention is to have one page_pool per NAPI callback
>>>>> to ensure this.
>>>>>
>>>> Yes, the intention is a single PP instance is "bound" to one RX-NAPI.
>>>
>>> Isn't that also a misuse of page_pool->p.napi? I thought it can be set
>>> only when page allocation and cache refill happen both inside the same
>>> NAPI polling function. Otx2 uses workqueues to refill the queues,
>>> meaning that consumer and producer can happen in different contexts or
>>> even threads and it shouldn't set p.napi.
>>>
>>
>> As Jakub wrote this otx2 driver doesn't set p.napi (so that part of the
>> problem cannot happen).
> 
> Oh I'm dumb :z
> 
>>
>> That said using workqueues to refill the queues is not compatible with
>> using page_pool_alloc APIs.  This need to be fixed in driver!
> 
> Hmmm I'm wondering now, how should we use Page Pool if we want to run
> consume and alloc routines separately? Do you want to say we can't use
> Page Pool in that case at all? Quoting other your reply:
> 
>> This WQ process is not allowed to use the page_pool_alloc() API this
>> way (from a work-queue).  The PP alloc-side API must only be used
>> under NAPI protection.
> 
> Who did say that? If I don't set p.napi, how is Page Pool then tied to NAPI?

*I* say that (as the PP inventor) as that was the design and intent,
that this is tied to a NAPI instance and rely on the NAPI protection to
make it safe to do lockless access to this cache array.

> Moreover, when you initially do an ifup/.ndo_open, you have to fill your
> Rx queues. It's process context and it can happen on whichever CPU.
> Do you mean I can't allocate pages in .ndo_open? :D

True, that all driver basically allocate from this *before* the RX-ring 
/ NAPI is activated.  That is safe and "allowed" given the driver 
RX-ring is not active yet.  This use-case unfortunately also make it 
harder to add something to the PP API, that detect miss-usage of the API.

Looking again at the driver otx2_txrx.c NAPI code path also calls PP 
directly in otx2_napi_handler() will call refill_pool_ptrs() -> 
otx2_refill_pool_ptrs() -> otx2_alloc_buffer() -> __otx2_alloc_rbuf() -> 
if (pool->page_pool) otx2_alloc_pool_buf() -> page_pool_alloc_frag().

The function otx2_alloc_buffer() can also choose to start a WQ, that 
also called PP alloc API this time via otx2_alloc_rbuf() that have 
BH-disable.  Like Sebastian, I don't think this is safe!

--Jesper

This can be a workaround fix:

$ git diff
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c 
b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index dce3cea00032..ab7ca146fddf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -578,6 +578,10 @@ int otx2_alloc_buffer(struct otx2_nic *pfvf, struct 
otx2_cq_queue *cq,
                 struct refill_work *work;
                 struct delayed_work *dwork;

+               /* page_pool alloc API cannot be used from WQ */
+               if (cq->rbpool->page_pool)
+                       return -ENOMEM;
+
                 work = &pfvf->refill_wrk[cq->cq_idx];
                 dwork = &work->pool_refill_work;
                 /* Schedule a task if no other task is running */

