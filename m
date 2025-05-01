Return-Path: <netdev+bounces-187219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E03AA5D14
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 12:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B177F1BC5DFF
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906322D4E3;
	Thu,  1 May 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfFxbcjm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67B22D4F0
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746094414; cv=none; b=GW7nkmRUwcSqzGyhnTOiKLs8zBxOr3vYsIfOGGihf2Jlx6jZ3mWo5QOs8KlQ+q5sFCsx/hgx8oweILY3B/PViUYZhpmVZNx3AqMF9lyRGrwhVg4ojAhjQ+4O9iCZlx/tbHrSsTj8/YlFg+CfIS+Hvgqx9MQd8sBz4Jz0HcAInzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746094414; c=relaxed/simple;
	bh=2l/QmxsH+YGxcGpFMeCSPcOzGLYAZ/ECE5kxH40vnZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VXRhPSX7iMUUPXDqdPPIP+DpDQhbnWRPp9UsFoUdDKOCt3/Vn2r8Q0nXjLIPBQTn/LX8/LGgbiRTsstO6kb1YEHaYcCItMTPWjmfL3fWQggCTRbQQbEPP6SSbj3wreGRvbBT7LDTIOigE2h7Ae8/m8erOIlApB2qZS7blUPqKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfFxbcjm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746094411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+boqH3jMIoyB+S4qFE3D4u2O925uu+V0nhcw7bE3GY4=;
	b=KfFxbcjmLfOdlZP91mwBgaAxWnBuIAQ1T0im98bd/OdZRuqRRaqKRn+GJPUVbww/M//sVt
	v/Q+SDIk1PS3K8zJjE0NUInfRnRGEmwM8QVPWQoDrLqP3rmmMwrl/rtMUr+7ZRIf75vk4D
	QGNd8f5b1i88rb9Eq7+SzVdjNVgSOkw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-YpMpXZ-jMfiPhkcy5botFQ-1; Thu, 01 May 2025 06:13:29 -0400
X-MC-Unique: YpMpXZ-jMfiPhkcy5botFQ-1
X-Mimecast-MFC-AGG-ID: YpMpXZ-jMfiPhkcy5botFQ_1746094407
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30d8de3f91eso3932881fa.3
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 03:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746094406; x=1746699206;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+boqH3jMIoyB+S4qFE3D4u2O925uu+V0nhcw7bE3GY4=;
        b=tlzhnX9noEW9oMe4mqHOtTbwh+c7oNtbsIojoqDhYWzLITYIP9Lpd4hEjH3wE4FdQg
         rMKI7mIbv81RWaZ971gVqRxldtI0jTTjqLoMNaXqvHQT7sSzra+uRIX51tlVcGDkN7r9
         WHXrc6UYW1rblrF6a0zD57UgWNXG6Yy/g+AGf6bbdAdTz8w2xf6PGWAH9DyBneRU9eRV
         t4h0L/zPygozKqPmZaLDhH8KjLKyw89NI3ytMyxQNG8NswsN/VIei1YiFtgoJzpnzj0F
         TLLA6Ru1zUPKi1x0+l1tzyH5U93cYd0mAV5KkY+7jDklkJywiCWxhJEu8rmcRI8azHNo
         wzJA==
X-Forwarded-Encrypted: i=1; AJvYcCWFeai/dDX/badBP66dK2JtbY+mj+kO23ktt7NPtwo7nsvgCFpxM3l5SHRPp22LQw9h63eqnKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybiLBtaEfMPsLjXuDkxCB19ZYr0zL3T1p4ZHlDG/sYUDcFsEe
	h2xpY8FqOWEkUpskSWAfvpxBkz+iv46Z1aaGxMjv3AA83V/3+ata1mDRMakQnqdcT1fsLgkqQcg
	tWoKO5j4jNeai69OENrgkcFVE+uSFWWKvWEKBZreAyfTziGuyzBR5gA==
X-Gm-Gg: ASbGnctmoCkRCegmSp/C3my8LMSgpI+sjDEXFW074k7nVpZYUYyd/f0Lc6FuIGnvA5R
	rmaoKw2hEchRIxJ5yQ6si+gz6qCerV0XprH67l/IpHyYsJc9eCULy+lgf8n1B4134H3g0PS2chf
	NwrnwcO1PxiocE0Uqx79Acx4CiiAdj+C4o2BiOegoT0xy8x4d1l8J8KjZS+AUuTtd57hXvbFbTw
	rHDJ441rsNlcQ1JAJctJ9lzKKzWYuD7A8bZRH120jxm6cEUia98oj7MQo0oJoeZymgUdxbfqzLV
	Pgkn7UUE
X-Received: by 2002:a05:651c:198c:b0:30d:e104:d64c with SMTP id 38308e7fff4ca-31f957abaf5mr6901691fa.40.1746094406537;
        Thu, 01 May 2025 03:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc2UPX1BFnJhpA8lfp7hWHbWdR3WeJHoV7vyckFWSd/+BKuvRRIDvwwjeftWP5ZTcbRwxOdQ==
X-Received: by 2002:a05:651c:198c:b0:30d:e104:d64c with SMTP id 38308e7fff4ca-31f957abaf5mr6901501fa.40.1746094406038;
        Thu, 01 May 2025 03:13:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3202a89f505sm539711fa.73.2025.05.01.03.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:13:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 540161A08244; Thu, 01 May 2025 12:13:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
In-Reply-To: <20250430124758.1159480-6-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 01 May 2025 12:13:24 +0200
Message-ID: <878qng7i63.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> system_page_pool is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
>
> Make a struct with a page_pool member (original system_page_pool) and a
> local_lock_t and use local_lock_nested_bh() for locking. This change
> adds only lockdep coverage and does not alter the functional behaviour
> for !PREEMPT_RT.
>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/netdevice.h |  7 ++++++-
>  net/core/dev.c            | 15 ++++++++++-----
>  net/core/xdp.c            | 11 +++++++++--
>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 2d11d013cabed..2018e2432cb56 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3502,7 +3502,12 @@ struct softnet_data {
>  };
>  
>  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> -DECLARE_PER_CPU(struct page_pool *, system_page_pool);
> +
> +struct page_pool_bh {
> +	struct page_pool *pool;
> +	local_lock_t bh_lock;
> +};
> +DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
>  
>  #ifndef CONFIG_PREEMPT_RT
>  static inline int dev_recursion_level(void)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1be7cb73a6024..b56becd070bc7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>   * PP consumers must pay attention to run APIs in the appropriate context
>   * (e.g. NAPI context).
>   */
> -DEFINE_PER_CPU(struct page_pool *, system_page_pool);
> +DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) = {
> +	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
> +};

I'm a little fuzzy on how DEFINE_PER_CPU() works, but does this
initialisation automatically do the right thing with the multiple
per-CPU instances?

>  #ifdef CONFIG_LOCKDEP
>  /*
> @@ -5238,7 +5240,10 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
>  	struct sk_buff *skb = *pskb;
>  	int err, hroom, troom;
>  
> -	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, prog))
> +	local_lock_nested_bh(&system_page_pool.bh_lock);
> +	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
> +	local_unlock_nested_bh(&system_page_pool.bh_lock);
> +	if (!err)
>  		return 0;
>  
>  	/* In case we have to go down the path and also linearize,
> @@ -12629,7 +12634,7 @@ static int net_page_pool_create(int cpuid)
>  		return err;
>  	}
>  
> -	per_cpu(system_page_pool, cpuid) = pp_ptr;
> +	per_cpu(system_page_pool.pool, cpuid) = pp_ptr;
>  #endif
>  	return 0;
>  }
> @@ -12759,13 +12764,13 @@ static int __init net_dev_init(void)
>  		for_each_possible_cpu(i) {
>  			struct page_pool *pp_ptr;
>  
> -			pp_ptr = per_cpu(system_page_pool, i);
> +			pp_ptr = per_cpu(system_page_pool.pool, i);
>  			if (!pp_ptr)
>  				continue;
>  
>  			xdp_unreg_page_pool(pp_ptr);
>  			page_pool_destroy(pp_ptr);
> -			per_cpu(system_page_pool, i) = NULL;
> +			per_cpu(system_page_pool.pool, i) = NULL;
>  		}
>  	}
>  
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f86eedad586a7..b2a5c934fe7b7 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -737,10 +737,10 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>   */
>  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  {
> -	struct page_pool *pp = this_cpu_read(system_page_pool);
>  	const struct xdp_rxq_info *rxq = xdp->rxq;
>  	u32 len = xdp->data_end - xdp->data_meta;
>  	u32 truesize = xdp->frame_sz;
> +	struct page_pool *pp;
>  	struct sk_buff *skb;
>  	int metalen;
>  	void *data;
> @@ -748,13 +748,18 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  	if (!IS_ENABLED(CONFIG_PAGE_POOL))
>  		return NULL;
>  
> +	local_lock_nested_bh(&system_page_pool.bh_lock);
> +	pp = this_cpu_read(system_page_pool.pool);
>  	data = page_pool_dev_alloc_va(pp, &truesize);
> -	if (unlikely(!data))
> +	if (unlikely(!data)) {
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>  		return NULL;
> +	}
>  
>  	skb = napi_build_skb(data, truesize);
>  	if (unlikely(!skb)) {
>  		page_pool_free_va(pp, data, true);
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>  		return NULL;
>  	}
>  
> @@ -773,9 +778,11 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  
>  	if (unlikely(xdp_buff_has_frags(xdp)) &&
>  	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>  		napi_consume_skb(skb, true);
>  		return NULL;
>  	}
> +	local_unlock_nested_bh(&system_page_pool.bh_lock);

Hmm, instead of having four separate unlock calls in this function, how
about initialising skb = NULL, and having the unlock call just above
'return skb' with an out: label?

Then the three topmost 'return NULL' can just straight-forwardly be
replaced with 'goto out', while the last one becomes 'skb = NULL; goto
out;'. I think that would be more readable than this repetition.

-Toke


