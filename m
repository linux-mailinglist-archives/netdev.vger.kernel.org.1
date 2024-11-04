Return-Path: <netdev+bounces-141596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463FE9BBAE7
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A869B21C88
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D93B1C4A25;
	Mon,  4 Nov 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="T+s4gFVn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060F762EB
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739623; cv=none; b=hqvBfiPLRUSypeEe2xjw1Kh4L39wnHDKZ5Kqf8OcJHgwte1fEIYfBrZzDKnFHH9VLuDqvxNn8pxV9jz0VflgnWqf9mIvjiuH6w9gG1D7dQ7hmY855B3NJFQUj8Rr9p0nTJQ2uYRESMhKgRgUybIkPNWROJWjctQKrGFLIkSLE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739623; c=relaxed/simple;
	bh=tLodSbLl9vhYX48+Oqa6/TPkkDflt1kVfZL8YvQFAtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUmN4wTMEWtV3Lmdhf/VpZruIieP6nNFyGP0MBbM0KGBYgfXP5jLhQ6dlQrM5IGs0bKNoI2JP3W2FULZ7Lb0Fh4U858M9hKiF5+8JqZkD69pylL4TEC/KKs9KR3nhpZRTuCGnbUs+Z0mivcMmjZT3M+aJWTvCxkzo1+E9dt2hoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=T+s4gFVn; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso2982515a12.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1730739620; x=1731344420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fz0f5g1eOQDpYJJNrZVGOLQo3m9qwjFOyaGQn7Ykj/s=;
        b=T+s4gFVnn6mLRJBbd2C59xGifR6w8rvilf6KhL1JxjnLXOBvdehoZrW8gAGa7zhUbz
         1Z3eYZ7UxHY6vTHo7puM2Xx52MIvRnpRo/AuqdVIFjpWmHcGQDIBjjBadVq746nGw9Vg
         yrwiv3XbeTSBF2eB0TJDcBoVy2gP6Neyu4od/jupyTlJXGbqNagxX+BsXYOA3nj/1708
         b4B14HsFn5lMv8m6tXLBJwN3Nrm5+1O9GD+Zn6LDwaMvsvAkfg056BATGvhON6maD1DH
         VP1LN1c94671I7UIsc9tIpVBHYO9zocyJlSDIAJyYHxDdeTOFNkOdneeWaH8FWQ0MI3s
         25Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739620; x=1731344420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fz0f5g1eOQDpYJJNrZVGOLQo3m9qwjFOyaGQn7Ykj/s=;
        b=lNf66ckyjO++rSVpYdZ0mSK+dR5cnLjoGD4UyKRRUcgDuhRfSG16B1wCrMs0YpP6wr
         ZenEfuo3drBm4xtRHtaGi1ZTBn2bD5lH+bFs2YQ+Ez8xO/YVU6plAOxecMihJufzIa3e
         Q8SrMNkfX/cX5Ueg2krM/zAfot0qmyN5DYvtdHjRodk8uFpuOu4Zjd7UnO1Cpjw3HMUw
         goZpMFKJBr4Hr7q6mKh2LYAvp66dWnOZrxjqw1O28I95rLAWOQSfv3jt/oMtLq5LP6/E
         u0ryE8GPhMj/O8GJedpEQBAwnaeRmzxKuE90qXejFxhnLfgvyKt7ngs3NrN3eJw0imdc
         AiZA==
X-Forwarded-Encrypted: i=1; AJvYcCXu/qQUV0lBybI00NQZ1Vi3J0z0jms8QeN+n+0R6l0lHOwSQCgq3cg7bU8Us3az83VkPqpbbC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvexFNo5QiHHf58uu6EU6kGSdHvMOTiLFFzky0QTuF8PVth3l
	taF3/6+okRSPwTT+G2IEgn8jxHwmwsl2qwVXTgdgK9RuCUy5ZcsJFaVm2EjW/g==
X-Google-Smtp-Source: AGHT+IHca3niBOOz/CPm1LphCtKewVfZaLj57m+SH0Zl1FXowM8i6S+a793tBCiid0uSUolkGS7NGg==
X-Received: by 2002:a17:90b:54c4:b0:2e3:b168:70f5 with SMTP id 98e67ed59e1d1-2e94c2e472emr17880903a91.21.1730739619940;
        Mon, 04 Nov 2024 09:00:19 -0800 (PST)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93dab27a8sm7910007a91.22.2024.11.04.09.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 09:00:19 -0800 (PST)
Message-ID: <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
Date: Mon, 4 Nov 2024 14:00:15 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 alexandre.ferrieux@orange.com, netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2024 07:26, Alexandre Ferrieux wrote:
> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> encodes the returned small integer into a structured 32-bit
> word. Unfortunately, at disposal time, the needed decoding
> is not done. As a result, idr_remove() fails, and the IDR
> fills up. Since its size is 2048, the following script ends up
> with "Filter already exists":
> 
>    tc filter add dev myve $FILTER1
>    tc filter add dev myve $FILTER2
>    for i in {1..2048}
>    do
>      echo $i
>      tc filter del dev myve $FILTER2
>      tc filter add dev myve $FILTER2
>    done
> 
> This patch adds the missing decoding logic for handles that
> deserve it.
> 
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>

SoB does not match sender, probably missing 'From:' tag
Also, this seems to deserve a 'Fixes:' tag as well

> ---
>   net/sched/cls_u32.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 9412d88a99bc..54b5fca623da 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -41,6 +41,16 @@
>   #include <linux/idr.h>
>   #include <net/tc_wrapper.h>
>   
> +static inline unsigned int handle2id(unsigned int h)
> +{
> +	return ((h & 0x80000000) ? ((h >> 20) & 0x7FF) : h);
> +}
> +
> +static inline unsigned int id2handle(unsigned int id)
> +{
> +	return (id | 0x800U) << 20;
> +}
> +

'static inline' is discouraged in .c files

>   struct tc_u_knode {
>   	struct tc_u_knode __rcu	*next;
>   	u32			handle;
> @@ -310,7 +320,7 @@ static u32 gen_new_htid(struct tc_u_common *tp_c, struct tc_u_hnode *ptr)
>   	int id = idr_alloc_cyclic(&tp_c->handle_idr, ptr, 1, 0x7FF, GFP_KERNEL);
>   	if (id < 0)
>   		return 0;
> -	return (id | 0x800U) << 20;
> +	return id2handle(id);
>   }
>   
>   static struct hlist_head *tc_u_common_hash;
> @@ -360,7 +370,7 @@ static int u32_init(struct tcf_proto *tp)
>   		return -ENOBUFS;
>   
>   	refcount_set(&root_ht->refcnt, 1);
> -	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : 0x80000000;
> +	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : id2handle(0);
>   	root_ht->prio = tp->prio;
>   	root_ht->is_root = true;
>   	idr_init(&root_ht->handle_idr);
> @@ -612,7 +622,7 @@ static int u32_destroy_hnode(struct tcf_proto *tp, struct tc_u_hnode *ht,
>   		if (phn == ht) {
>   			u32_clear_hw_hnode(tp, ht, extack);
>   			idr_destroy(&ht->handle_idr);
> -			idr_remove(&tp_c->handle_idr, ht->handle);
> +			idr_remove(&tp_c->handle_idr, handle2id(ht->handle));
>   			RCU_INIT_POINTER(*hn, ht->next);
>   			kfree_rcu(ht, rcu);
>   			return 0;
> @@ -989,7 +999,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>   
>   		err = u32_replace_hw_hnode(tp, ht, userflags, extack);
>   		if (err) {
> -			idr_remove(&tp_c->handle_idr, handle);
> +			idr_remove(&tp_c->handle_idr, handle2id(handle));
>   			kfree(ht);
>   			return err;
>   		}


