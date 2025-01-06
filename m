Return-Path: <netdev+bounces-155632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6CA03359
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84E41882DC8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2527A1E0DCA;
	Mon,  6 Jan 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="rs4gXC1L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715501DF756
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736206494; cv=none; b=qc3/xUG6t9ieLg3I6D1D92ej+VXOYBN1w/DZGMzgaXBE3ybOpltS7fGLg4zFSzIf9SoHC9oUpFUQGG4aejUCpPsI3cnTks+1btduzRF6Gi20lqVOrKygDrhV451RGhdNQpQz8DcVAuXwjplqC32CUl3VWfOFMklFYBU4kNv33g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736206494; c=relaxed/simple;
	bh=dOQMsCiePOQPkJrNukLB4kFYcv15Dg3+YtzV1IDUT2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRTSULIDaoK0AZTz0ZuEqzu+MHUeM0285Pq+u+3scFWppmKikirHmAxX1tvXQxzqIzsbLRsqojR2PXStt9+xqYPAPH5M49QPBVR7O04FR+d7TWo/S1Vhe/teehpcinZQOIAipJOapp8KuUka8zP5F0uY8GT8HeEQroWIDEWoN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=rs4gXC1L; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162c0f6a39so224048205ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736206492; x=1736811292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUTiUhcVs4m61lunwDl4byPY1WkO7CyeT91vAkQ/pZM=;
        b=rs4gXC1Li/FQOkB4DbedlzcIb9HE/buS1Zg0PbgqulnSLv/fIluhgxE5xaJYzZUY8u
         WDs3MDGpUOKSHuNHVxLCBz/yHNe3GsIoCCpYjcglngVerkvaGoyyOnr6NVUcfaZ2jBDo
         ChuqiBcL4NFfUs2U+5opWIy83DuVXYLM+8OtCZLf4uGrH/lauzTSaJ7nKwoCx6jBgO/m
         O+BgyDpP3wqLwghUAJoTHOfYM+iN6XEVVpImLtHCeK0nTfY72NPtsgvmS+xnTsn94U7O
         OQ9rwPzv+B5pBYgSi9sf6utEBkfpJQg6xylCzrBybbkCYiwW8eX9AdRQ/qzD/GbXMcQo
         0oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736206492; x=1736811292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUTiUhcVs4m61lunwDl4byPY1WkO7CyeT91vAkQ/pZM=;
        b=Ken6rUG29/zr7/UOhc5fZ0vTdvkUbmlCqJxCp1aHm8ooetMcfijazpmYk13kg3Dei5
         gJ7f1TDy7IDVa0NwhOZP9oddxyNxXku+jZW6PxDw4DhRO5UZfIMdtZYuwIMuJ8kio1VP
         GM4rCXvkStBYtCOASobxPDJ/YsnRRId+dfhyaDgE7iS/BBop2qSW1zNWjCrD6K9ZcWBW
         q8a6h7WyyFBveMxag+Pz0oRAI+CFqkt2ptqJ8+urO/Bnmk9066yAYEU+2FnUUgDIfKUD
         aJqB1prDhEOBo+aDnSIZ1aAWz8kAlwmF4sZhxPMiiYWx0l2VATX4eUe7eMAH9Luanboi
         d0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl789CpApviC6Zjlge7BlA+xSiiOpj00gWT3oBf+AnrXgim6WL/BqfWw3/GpW5APxacSUurCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcAdtOynhlBcPfdZXAjeT5jzTaU5Dks1NIIAeW1+5s2VtiPuAI
	X5RzHK5SN7c5YmgQOJN49cq5KdE/fPZO17WimVmno3vAKwMWmEY00Lcy6T4hlgM=
X-Gm-Gg: ASbGncvN6iv84Hp4ujAIcCF1V250Q0L3Oe6MOe0uepklKWFHs+KW2Z3a+Id+bqhkAZ/
	3t3TrNYNDZzO62DIm9A0zmnaIZBBntvS5Et5dsYZQnc8dnaY3ErOreNWlx+M5H30efcKj1B32IP
	qq5fQLPbpqxnn+V4SBGnugfDdGiAiz1SutqEpEsq4ArJQsfCDG3mHxFLdA+g5cP5MilPoADemes
	ctNHAhO+m9rCvUfY73BJJNRCHjgazJsnoa0ZMlzair2TmQA9dVLYfEiAcwfkLMhoywCnV4ztwqm
	iTAouOFkIrWwUBu/Yw==
X-Google-Smtp-Source: AGHT+IFHyZS+a8vYLflU88Kwe+xpc+voo0We9E/F3wAylPGZ4CoE6XiuyVY3nDtSSYxyJkTAiwxbqA==
X-Received: by 2002:a05:6a00:2445:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-72d1036a99fmr1574276b3a.2.1736206491633;
        Mon, 06 Jan 2025 15:34:51 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::5:7895])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e25951c2sm29273629a12.71.2025.01.06.15.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 15:34:51 -0800 (PST)
Message-ID: <0698763f-0a98-4f0b-b287-6e131ef6b99f@davidwei.uk>
Date: Mon, 6 Jan 2025 15:34:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/20] net: page_pool: add a mp hook to
 unregister_netdevice*
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241218003748.796939-1-dw@davidwei.uk>
 <20241218003748.796939-7-dw@davidwei.uk>
 <CAHS8izOg0V5kGq8gsGLC=6t+1VWfk1we_R9gecC+WbOJAdeXgw@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izOg0V5kGq8gsGLC=6t+1VWfk1we_R9gecC+WbOJAdeXgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-01-06 13:44, Mina Almasry wrote:
> On Tue, Dec 17, 2024 at 4:38 PM David Wei <dw@davidwei.uk> wrote:
>>
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Devmem TCP needs a hook in unregister_netdevice_many_notify() to upkeep
>> the set tracking queues it's bound to, i.e. ->bound_rxqs. Instead of
>> devmem sticking directly out of the genetic path, add a mp function.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  include/net/page_pool/types.h |  3 +++
>>  net/core/dev.c                | 15 ++++++++++++++-
>>  net/core/devmem.c             | 36 ++++++++++++++++-------------------
>>  net/core/devmem.h             |  5 -----
>>  4 files changed, 33 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
>> index a473ea0c48c4..140fec6857c6 100644
>> --- a/include/net/page_pool/types.h
>> +++ b/include/net/page_pool/types.h
>> @@ -152,12 +152,15 @@ struct page_pool_stats {
>>   */
>>  #define PAGE_POOL_FRAG_GROUP_ALIGN     (4 * sizeof(long))
>>
>> +struct netdev_rx_queue;
>> +
>>  struct memory_provider_ops {
>>         netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
>>         bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
>>         int (*init)(struct page_pool *pool);
>>         void (*destroy)(struct page_pool *pool);
>>         int (*nl_report)(const struct page_pool *pool, struct sk_buff *rsp);
>> +       void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
> 
> nit: the other params take struct page_pool *pool as input, and find
> the mp_priv in there if they need, it may be nice for consistency to
> continue to pass the entire pool to these ops.
> 
> AFAIU this is the first added non-mandatory op, right? Please specify
> it as so, maybe something like:
> 
> /* optional: called when the memory provider is uninstalled from the
> netdev_rx_queue due to the interface going down or otherwise. The
> memory provider may perform whatever cleanup necessary here if it
> needs to. */

Sounds good, I'll make the change in the next version.

> 
>>  };
>>
>>  struct pp_memory_provider_params {
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index c7f3dea3e0eb..aa082770ab1c 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -11464,6 +11464,19 @@ void unregister_netdevice_queue(struct net_device *dev, struct list_head *head)
>>  }
>>  EXPORT_SYMBOL(unregister_netdevice_queue);
>>
>> +static void dev_memory_provider_uninstall(struct net_device *dev)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < dev->real_num_rx_queues; i++) {
>> +               struct netdev_rx_queue *rxq = &dev->_rx[i];
>> +               struct pp_memory_provider_params *p = &rxq->mp_params;
>> +
>> +               if (p->mp_ops && p->mp_ops->uninstall)
> 
> Previous versions of the code checked p->mp_priv to check if the queue
> is mp enabled or not, I guess you check mp_ops and that is set/cleared
> along with p->mp_priv. I guess that is fine. It would have been nicer,
> maybe, to have all the mp stuff behind one pointer/struct. I would
> dread some code path setting one of mp_[ops|priv] but forgetting to
> set the other... :shrug:

We can follow up with helpers that do the set/unset/check to make sure
it is consistent.

> 
> Anyhow:
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 

