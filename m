Return-Path: <netdev+bounces-159750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56CDA16B83
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A00163A4F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892721DF747;
	Mon, 20 Jan 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2J3LuZZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937411C07E6
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372290; cv=none; b=W0f8/wLgG3yJehg9pzcCOPj6ZKoR0KwOOMtWbObQjFEXM+UwY1o1fXbVrTdrvCvshyujSVTG/j7Cv4GMcPrtrTrl2ZMoUidL5L57Hk3Odnn1u8prWWDabFvfy8OGcDz/3sqarwlST0Bv0f7Vt7p47bOO4TRz8XVAU++KDnwVx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372290; c=relaxed/simple;
	bh=HnzLtcA0ftZbEPTThiL4c4YxlcN0pxZvUGbLyag6wfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QFCT9xKMBfCCrKAdG+vJhr/+a06by2Ot8xixKE/hM/852XGfh7T5nmg1BGPv1H/Djcc8Teltfiq7D/PuZQGp3H133rAsLpbyVig5Wf9i+jcf720OBrB1fk1p2M+oToezcbH0CkGc2bSUrRDnWlTHRp0TCpBjXYSFs/40Sq+di1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2J3LuZZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737372287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hERlSFrL95STexjnjci0jv3hwDZvlU2EIS68UvEIOI=;
	b=J2J3LuZZti7sP21NtPPF8Lhl1rG5hkLm5zDomBEREELY1KySVwdixQAjrRGBXjHQyU2LD4
	KjQrKSiSq54sGfX0R7mhI5Hllvb4kJrGtjuhmc2oDb9rR7WDILAIl9y5p/8hIgb4b//Wgw
	8qU2twsm4obBSQ8VBIZvhYQWAo5MlFg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-rY3EPYUrO5WApjj9YWdP5Q-1; Mon, 20 Jan 2025 06:24:46 -0500
X-MC-Unique: rY3EPYUrO5WApjj9YWdP5Q-1
X-Mimecast-MFC-AGG-ID: rY3EPYUrO5WApjj9YWdP5Q
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6704ffcaeso446151266b.2
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 03:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372285; x=1737977085;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hERlSFrL95STexjnjci0jv3hwDZvlU2EIS68UvEIOI=;
        b=DyWQ4+HhIi9QhRocO66b6djn507q13ujfEs61306wizTwzkFPQPXEUHu1RtZThkJxr
         KXCPE0XyflolbdC9xqOOJ5CpTmfxr3h1jE75KZI9FzDQB0veuIL5jmjnN4Mx/PmH/Wfd
         3lsqbMFBP/WQ/FClUwUKFNZp4uZx9zhWgB9wEnVZGiH6pYBHl0QRUnmpvfgYW3t4fben
         bShUPATNnY7W6nEp95Hm7Gk2slYWltsssuxZqbMqa1vajcdIkUT50NZlLe7MgiMDA5T1
         GP9a30+GUlQmI85outpxHYmoGj0ZumV7/xqaHhXUbMhApapIlECmlOw5PIihf5QRzNfz
         WUPw==
X-Forwarded-Encrypted: i=1; AJvYcCUD+Q+MgPacc3hN6U9ltMpUHUyP68eWafah0zKUa7LE/WmR4DMaAFxlQjqhKzdBB9rINMM8egA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUXUCMxR82XYDTd4QZA9+UXZvJn0Gm4MBS+qlscYbXX0M357os
	GWGN4RayoN//ygKsznCARl9KgPq4/sVB8iJxQKpQhIyuljI2RWGZfAYIWTkbcEZ5c6TyaQohyS7
	+QGezIo+POjI2VmDx7Zar5wha/jbTlrEBsLE7pFv5JjcrE/mEF/4Fww==
X-Gm-Gg: ASbGncu0Pj2gxJWPjW5kyIw0tGGGd5L9B9Sb1whiZL06L7eYVIMKN+npVseSE4VQ71L
	X2YkT0tdgMsMyVfUAi+hguDPR0C5oc9402xttbeHuWPPGUhSdnSzrjgnmE+pYLg91tDQDe9hYKs
	6HXbfbFffpDB+X0bqvns+IA3ZcDab/b2Io8O7BxWzNTYn60ksz23Mxe140iEzeAOraZAOMJ8si6
	k+Rr+JHXCnh3QNLZFCy4HRoVVal7RSHJLwF3QYZCJnMYOGBrFRWW26DG39t+mbqXzw=
X-Received: by 2002:a17:906:f598:b0:aa6:7933:8b26 with SMTP id a640c23a62f3a-ab38b1b17ecmr1225033966b.9.1737372284745;
        Mon, 20 Jan 2025 03:24:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/IRY62/UO9mPk1O+m/yAnyzoYOhH4ZKFalbx+wiidprDSpXejqrX19mTjUcxDWnHd66wBIg==
X-Received: by 2002:a17:906:f598:b0:aa6:7933:8b26 with SMTP id a640c23a62f3a-ab38b1b17ecmr1225030166b.9.1737372284204;
        Mon, 20 Jan 2025 03:24:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce6890sm601816766b.70.2025.01.20.03.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:24:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1E1BC17E7C28; Mon, 20 Jan 2025 12:24:37 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
In-Reply-To: <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com> <87sepqhe3n.fsf@toke.dk>
 <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 20 Jan 2025 12:24:36 +0100
Message-ID: <87plkhn2x7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 1/10/2025 11:40 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yunsheng Lin <linyunsheng@huawei.com> writes:
>>=20
>>> page_pool page may be freed from skb_defer_free_flush() in
>>> softirq context without binding to any specific napi, it
>>> may cause use-after-free problem due to the below time window,
>>> as below, CPU1 may still access napi->list_owner after CPU0
>>> free the napi memory:
>>>
>>>              CPU 0                           CPU1
>>>        page_pool_destroy()          skb_defer_free_flush()
>>>               .                               .
>>>               .                napi =3D READ_ONCE(pool->p.napi);
>>>               .                               .
>>> page_pool_disable_direct_recycling()         .
>>>     driver free napi memory                   .
>>>               .                               .
>>>               .       napi && READ_ONCE(napi->list_owner) =3D=3D cpuid
>>>               .                               .
>>=20
>> Have you actually observed this happen, or are you just speculating?
>
> I did not actually observe this happen, but I added some delaying and
> pr_err() debugging code in page_pool_napi_local()/page_pool_destroy(),
> and modified the test module for page_pool in [1] to trigger that it is
> indeed possible if the delay between reading napi and checking
> napi->list_owner is long enough.
>
> 1.=20
> https://patchwork.kernel.org/project/netdevbpf/patch/20240909091913.98782=
6-1-linyunsheng@huawei.com/

Right, I wasn't contesting whether it's possible to trigger this race by
calling those two functions directly in some fashion. I was asking
whether there are any drivers that use the API in a way that this race
can happen; because I would consider any such driver buggy, and we
should fix this rather than adding more cruft to the page_pool API. See
below.

>> Because I don't think it can; deleting a NAPI instance already requires
>> observing an RCU grace period, cf netdevice.h:
>>=20
>> /**
>>   *  __netif_napi_del - remove a NAPI context
>>   *  @napi: NAPI context
>>   *
>>   * Warning: caller must observe RCU grace period before freeing memory
>>   * containing @napi. Drivers might want to call this helper to combine
>>   * all the needed RCU grace periods into a single one.
>>   */
>> void __netif_napi_del(struct napi_struct *napi);
>>=20
>> /**
>>   *  netif_napi_del - remove a NAPI context
>>   *  @napi: NAPI context
>>   *
>>   *  netif_napi_del() removes a NAPI context from the network device NAP=
I list
>>   */
>> static inline void netif_napi_del(struct napi_struct *napi)
>> {
>> 	__netif_napi_del(napi);
>> 	synchronize_net();
>> }
>
> I am not sure we can reliably depend on the implicit synchronize_net()
> above if netif_napi_del() might not be called before page_pool_destroy()
> as there might not be netif_napi_del() before page_pool_destroy() for
> the case of changing rx_desc_num for a queue, which seems to be the case
> of hns3_set_ringparam() for hns3 driver.

The hns3 driver doesn't use pp->napi at all AFAICT, so that's hardly
relevant.

>>=20
>>=20
>>> Use rcu mechanism to avoid the above problem.
>>>
>>> Note, the above was found during code reviewing on how to fix
>>> the problem in [1].
>>>
>>> As the following IOMMU fix patch depends on synchronize_rcu()
>>> added in this patch and the time window is so small that it
>>> doesn't seem to be an urgent fix, so target the net-next as
>>> the IOMMU fix patch does.
>>>
>>> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@ke=
rnel.org/T/
>>>
>>> Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>>   net/core/page_pool.c | 15 ++++++++++++++-
>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index 9733206d6406..1aa7b93bdcc8 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -799,6 +799,7 @@ __page_pool_put_page(struct page_pool *pool, netmem=
_ref netmem,
>>>   static bool page_pool_napi_local(const struct page_pool *pool)
>>>   {
>>>   	const struct napi_struct *napi;
>>> +	bool napi_local;
>>>   	u32 cpuid;
>>>=20=20=20
>>>   	if (unlikely(!in_softirq()))
>>> @@ -814,9 +815,15 @@ static bool page_pool_napi_local(const struct page=
_pool *pool)
>>>   	if (READ_ONCE(pool->cpuid) =3D=3D cpuid)
>>>   		return true;
>>>=20=20=20
>>> +	/* Synchronizated with page_pool_destory() to avoid use-after-free
>>> +	 * for 'napi'.
>>> +	 */
>>> +	rcu_read_lock();
>>>   	napi =3D READ_ONCE(pool->p.napi);
>>> +	napi_local =3D napi && READ_ONCE(napi->list_owner) =3D=3D cpuid;
>>> +	rcu_read_unlock();
>>=20
>> This rcu_read_lock/unlock() pair is redundant in the context you mention
>> above, since skb_defer_free_flush() is only ever called from softirq
>> context (within local_bh_disable()), which already function as an RCU
>> read lock.
>
> I thought about it, but I am not sure if we need a explicit rcu lock
> for different kernel PREEMPT and RCU config.
> Perhaps use rcu_read_lock_bh_held() to ensure that we are in the
> correct context?

page_pool_napi_local() returns immediately if in_softirq() returns
false. So the rcu_read_lock() is definitely not needed.

>>=20
>>> -	return napi && READ_ONCE(napi->list_owner) =3D=3D cpuid;
>>> +	return napi_local;
>>>   }
>>>=20=20=20
>>>   void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref =
netmem,
>>> @@ -1165,6 +1172,12 @@ void page_pool_destroy(struct page_pool *pool)
>>>   	if (!page_pool_release(pool))
>>>   		return;
>>>=20=20=20
>>> +	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
>>> +	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
>>> +	 * before returning to driver to free the napi instance.
>>> +	 */
>>> +	synchronize_rcu();
>>=20
>> Most drivers call page_pool_destroy() in a loop for each RX queue, so
>> now you're introducing a full synchronize_rcu() wait for each queue.
>> That can delay tearing down the device significantly, so I don't think
>> this is a good idea.
>
> synchronize_rcu() is called after page_pool_release(pool), which means
> it is only called when there are some inflight pages, so there is not
> necessarily a full synchronize_rcu() wait for each queue.
>
> Anyway, it seems that there are some cases that need explicit
> synchronize_rcu() and some cases depending on the other API providing
> synchronize_rcu() semantics, maybe we provide two diffferent API for
> both cases like the netif_napi_del()/__netif_napi_del() APIs do?

I don't think so. This race can only be triggered if:

- An skb is allocated from a page_pool with a napi instance attached

- That skb is freed *in softirq context* while the memory backing the
  NAPI instance is being freed.

It's only valid to free a napi instance after calling netif_napi_del(),
which does a full synchronise_rcu(). This means that any running
softirqs will have exited at this point, and all packets will have been
flushed from the deferred freeing queues. And since the NAPI has been
stopped at this point, no new packets can enter the deferred freeing
queue from that NAPI instance.

So I really don't see a way for this race to happen with correct usage
of the page_pool and NAPI APIs, which means there's no reason to make
the change you are proposing here.

-Toke


