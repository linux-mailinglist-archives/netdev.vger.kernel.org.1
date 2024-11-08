Return-Path: <netdev+bounces-143137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AC79C13B3
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83921C225F5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF61312E5D;
	Fri,  8 Nov 2024 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMkfr6hI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7501401C
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029698; cv=none; b=Pqs/KsPUorKLT2JuE2x8mDU70ZvYRD55V1mZo14x2bJzyP2Ue4wcNOmTqRB8tDxa+77euMsHL5roRpEM88jlxx/6lD95vf2UmVTQIl4Y7UCAvWKJySjyMiSwbRNe0zeMmMSAknQwLep0m2W+VOUY2hNiWLOR6KXWMQzw50R7dgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029698; c=relaxed/simple;
	bh=3PWwfPezOXOkEW7fuBDo69XkaNeJ8J4qCrCKpy9vgwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNZ46A36wTqU66qz+yc15vte3UrB+cOWpjJm6UUXW+IpTTFsPWoO08pAyKpEkdAI3VXRL0H2nVahGdW7O+CSTD2EymhW+jKS+KxwKFuaF70Yf28kWT8gC+jcx1mmv0/Rwr8nMEa76a58JQepT+uYKD0odoxv28ewKQmhEvOcC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMkfr6hI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1354903b3a.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 17:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731029696; x=1731634496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5/OYgacDAJ7U/Y578+21dqXxFYhbyW6VtYgSQnEWHE=;
        b=BMkfr6hIyn7d7cx09j2Swesa6ljNbGXEXp+0I6IrKR31bpTFn5RnbmEX7W2PYy4jB6
         OT9kHPnSrw5ROgJjrnZQ2pmVOCxrasWKLUBimlmPfr/2u8AQiRDpymJthOt9zA6j4YGV
         +Ww1IYDinvwLhecpB9XXFCD5C1c/GnyqQlGaoFOR2xWsvxIKYNad7Ee+RqiM/FoVuWHz
         wNVSB16nWGMLbu5GD8fWO9NWUQy+ok1dap7Iu/B3Lt5P8yXU1yc/E6Q7MXvQs8JE25x2
         xnjIeeNJTciP0R6k+fIxW1faKUfc0MICL/xbtq0wAo9m3sBvIKZ+J0W1IoP/b4USPWsf
         JUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731029696; x=1731634496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5/OYgacDAJ7U/Y578+21dqXxFYhbyW6VtYgSQnEWHE=;
        b=NxLQ6sKxQXu1TyvzmwGmLD+VJ9D4y25gTYqXrC5mmPtaTa8vS7YyEGECObxFSLu02Z
         L0IkHl67AARUR5tzDmlyH/vsvajLsXTJoDnqLHArik8ImqXNrmDH1+A/5doKmwsfyRVP
         pJokyz7IfTi40a44exWX7+Nf26xzvB3zCqpecbrDgy9fwXjT3nIYlPrB8FqnHADKjjZa
         cFyW2/R49ZlwJ0lZ75jOUvm8fUEGgRuXXbr9wMXp81u2PjK6ytC4uosGU6qHVv0rE0eE
         HjUGtpHHe99SGgopX+yyYWM1O8a3cyXwxpfAcksP7Ru5HVT+GEBsemAxoOfKnbCxBulw
         CsVA==
X-Forwarded-Encrypted: i=1; AJvYcCVq32mf9kyaJsPhgqpLHksM+7uHRVkiVxcdLqwWn/26Q2YNM7y++/7CXc7SXRppVzT0UWKDztU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZFASjWAChEEE5c+9T5yLrJPpsP/jE6KP28uTpIiPLxXmxAQ+
	FKjyN/nB+fybk8BK2sus3koK9oNB/4moat8oA1LH/IEro/17OtlZ
X-Google-Smtp-Source: AGHT+IFyZzFIqHGXWGhtXxYVb+p8P96ljpWUn8hjCL+CH91dsUhwL+2JRQVq4NMJlONzJzv6JMMRIQ==
X-Received: by 2002:a05:6a00:2444:b0:71e:59d2:9c99 with SMTP id d2e1a72fcca58-72413274284mr1695936b3a.4.1731029696307;
        Thu, 07 Nov 2024 17:34:56 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:4aa1:4b70:8855:42e6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bb8fsm2363373b3a.116.2024.11.07.17.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 17:34:55 -0800 (PST)
Date: Thu, 7 Nov 2024 17:34:54 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us,
	alexandre.ferrieux@orange.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v5] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
Message-ID: <Zy1qvkSHyEREU3Y1@pop-os.localdomain>
References: <20241107231123.298299-1-alexandre.ferrieux@orange.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107231123.298299-1-alexandre.ferrieux@orange.com>

On Fri, Nov 08, 2024 at 12:11:23AM +0100, Alexandre Ferrieux wrote:
> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> encodes the returned small integer into a structured 32-bit
> word. Unfortunately, at disposal time, the needed decoding
> is not done. As a result, idr_remove() fails, and the IDR
> fills up. Since its size is 2048, the following script ends up
> with "Filter already exists":
> 
>   tc filter add dev myve $FILTER1
>   tc filter add dev myve $FILTER2
>   for i in {1..2048}
>   do
>     echo $i
>     tc filter del dev myve $FILTER2
>     tc filter add dev myve $FILTER2
>   done
> 
> This patch adds the missing decoding logic for handles that
> deserve it, along with a corresponding tdc test.

Good catch! I have a few comments below.

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> ---
> v5: fix title - again
> v4: add tdc test
> v3: prepend title with subsystem ident
> v2: use u32 type in handle encoder/decoder
> 
> 
>  net/sched/cls_u32.c                           | 18 ++++++++++----
>  .../tc-testing/tc-tests/filters/u32.json      | 24 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 9412d88a99bc..6da94b809926 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -41,6 +41,16 @@
>  #include <linux/idr.h>
>  #include <net/tc_wrapper.h>
>  
> +static inline u32 handle2id(u32 h)
> +{
> +	return ((h & 0x80000000) ? ((h >> 20) & 0x7FF) : h);
> +}
> +
> +static inline u32 id2handle(u32 id)
> +{
> +	return (id | 0x800U) << 20;
> +}
> +
>  struct tc_u_knode {
>  	struct tc_u_knode __rcu	*next;
>  	u32			handle;
> @@ -310,7 +320,7 @@ static u32 gen_new_htid(struct tc_u_common *tp_c, struct tc_u_hnode *ptr)
>  	int id = idr_alloc_cyclic(&tp_c->handle_idr, ptr, 1, 0x7FF, GFP_KERNEL);
>  	if (id < 0)
>  		return 0;
> -	return (id | 0x800U) << 20;
> +	return id2handle(id);
>  }
>  
>  static struct hlist_head *tc_u_common_hash;
> @@ -360,7 +370,7 @@ static int u32_init(struct tcf_proto *tp)
>  		return -ENOBUFS;
>  
>  	refcount_set(&root_ht->refcnt, 1);
> -	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : 0x80000000;
> +	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : id2handle(0);
>  	root_ht->prio = tp->prio;
>  	root_ht->is_root = true;
>  	idr_init(&root_ht->handle_idr);
> @@ -612,7 +622,7 @@ static int u32_destroy_hnode(struct tcf_proto *tp, struct tc_u_hnode *ht,
>  		if (phn == ht) {
>  			u32_clear_hw_hnode(tp, ht, extack);
>  			idr_destroy(&ht->handle_idr);
> -			idr_remove(&tp_c->handle_idr, ht->handle);
> +			idr_remove(&tp_c->handle_idr, handle2id(ht->handle));
>  			RCU_INIT_POINTER(*hn, ht->next);
>  			kfree_rcu(ht, rcu);
>  			return 0;
> @@ -989,7 +999,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>  
>  		err = u32_replace_hw_hnode(tp, ht, userflags, extack);
>  		if (err) {
> -			idr_remove(&tp_c->handle_idr, handle);
> +			idr_remove(&tp_c->handle_idr, handle2id(handle));
>  			kfree(ht);
>  			return err;
>  		}

It seems you missed the idr_replace() case?

 - idr_replace(&ht->handle_idr, n, n->handle);
 + idr_replace(&ht->handle_idr, n, handle2id(n->handle));


> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> index 24bd0c2a3014..2095baa19c6a 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> @@ -329,5 +329,29 @@
>          "teardown": [
>              "$TC qdisc del dev $DEV1 parent root drr"
>          ]
> +    },
> +    {
> +        "id": "1234",
> +        "name": "Exercise IDR leaks by creating/deleting a filter many (2048) times",
> +        "category": [
> +            "filter",
> +            "u32"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
> +            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 match ip src 0.0.0.2/32 action drop",
> +            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action drop"
> +        ],
> +        "cmdUnderTest": "bash -c 'for i in {1..2048} ;do $TC filter delete dev $DEV1 pref 3;$TC filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action drop || exit 1;i=`expr $i + 1`;done'",

Any reason using this for loop instead of tdc_multibatch.py?

Thanks.

