Return-Path: <netdev+bounces-168625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F926A3FD79
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF2189081D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B82505BC;
	Fri, 21 Feb 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JcgWjflw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3152F3B
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159018; cv=none; b=pvA/tNPQ5Y4imlEYKcT4j0a4TJXyMbGwqqR36iAgpp78bvY6plsNV3hpUGgvJRjyD780ZbEU4aFSaBJxDb7ZQEQlGRndL0IB8GkNmMOfzW7dvsvQHtsxZ6OxVIJwgJZDhlBUlndWJ5k4crt2DOYU/uq70lh6/ooAv/UlKVYSH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159018; c=relaxed/simple;
	bh=n4K5LgedBielf0hnAQFklcvng586MuWobBxW2N0slT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7tCTdCd69JR4STvowf9zfyoP2YhIjTtGjB8EhRNNmlYN2JEo+KjvO9vyfs+y5e0bJfKMBrx6yBt1ue9xDcY3pHR7Y+xLj1ALBuvh9Q4l4wbgCxjUugKuqDYd7zR1PZ4pLC69PQKGZ3Lo+Gv9xx7Y0FkXyR0DO70r22axztwwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JcgWjflw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0b9f35dc7so309627485a.2
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740159015; x=1740763815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWytvIz7GiExTCjjd9cGzglj4b7zNOEtPFoWbv49aGw=;
        b=JcgWjflwZWu3CnTzP4phOCpYw9OZDqewd20L7IPaHEMaFZgEQEawXhmjgjU0GpJMWF
         V3eLqvR/paQwC1iPVRpAolTOeA0/IYFhBa5zfqZGfzgJiRvGssmfoFgbJjDdyj4ebtAm
         FDEnCZl2KJdzPuBdfojXlOlROQiDbctY+hE/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159015; x=1740763815;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWytvIz7GiExTCjjd9cGzglj4b7zNOEtPFoWbv49aGw=;
        b=gj8vNZ9GnSDE/0Wk8C8UmNANMIeH+zoewavcGo34uNOEyOV+P//lparj7i9nedMDKV
         qj7AVCqZUrJ4AlJXOThcXofc0ncItjaAYpdtFP1ZZ/a2KDThDCukyJkxDuA4FyY9mzBi
         C0eU3+zS111x24h6wZE/oNut7HFW6J8vFk1RIOCfuRLUcmdayo5pqFaQ8ENbF0tjFpQI
         5M9eITzfng4iZVoTd3JAzVSEtu8OM6HB2dn3cHjfGgro7yT/bDgp/nGq58s/jTjIb4va
         gnnpVHFvBOGw8O/7Y1LPi22+X6vaDGocDKS5hK3DjYefUULGZY8F91ofWmHiLsf8+YKV
         MGOA==
X-Forwarded-Encrypted: i=1; AJvYcCWI4a22nBM+eqQKnx17pbqomJne5Ay/ILk78gMTn03uVXvLMvI4SSp19dtsVQYwKkI/3TLF9TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjG3ei2bUgXIo1yf7d8o5LOpnCcCZW+XifTPDVRaTZweBSHBK8
	isbQLOhYcb7IrhSUg1CtBn3ROL2xHpS+5ZQKOR/O0qwJUWOkcvwWWYz+tQgms6s=
X-Gm-Gg: ASbGnctAdGCv1cD840ZzInrsB1VC2xGwvWmy2RVzSyCh+GdMLjBmMa25J801BK7Ro6j
	dKwAIb237bKap3q4zs99o6+XCHULtmFXQ4ME1v2XK3YaOloXBg0acpCiV8qFIqybFbdof1Yd5Ef
	UiHoe80pH86PWhAY4qz4zQxyeGQF87l7HeV/yV071GFIuC8PTie00l02GexMuDnQluix7J3TyAY
	C6wIupG+o67dv0FLbZ/9qyx7VCZ36gVAJcrcvCyoW90QJ7I/omt5LtPuZd6LxoCGhbunsJivjJW
	JUu/vviuxB1eGq3ayn4kUp2BPXSh3kE9EuwK2D0bRl0TJZkcLb3lDC5Cb09/zmtw
X-Google-Smtp-Source: AGHT+IGNZ5nbYE8Fd43w25borAE5oWxLp3BVFgZoQNiZy6uuhPEBq3Mtxfb/dWKAaOhrBCafk/Tx3Q==
X-Received: by 2002:a05:620a:4492:b0:7c0:b1aa:ba5a with SMTP id af79cd13be357-7c0cef1721cmr471596585a.33.1740159014946;
        Fri, 21 Feb 2025 09:30:14 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c4bd042dsm213181085a.61.2025.02.21.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:30:14 -0800 (PST)
Date: Fri, 21 Feb 2025 12:30:12 -0500
From: Joe Damato <jdamato@fastly.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 2/2] page_pool: Convert page_pool_alloc_stats to
 u64_stats_t.
Message-ID: <Z7i4JPCZHbbP0OLS@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
 <20250221115221.291006-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221115221.291006-3-bigeasy@linutronix.de>

On Fri, Feb 21, 2025 at 12:52:21PM +0100, Sebastian Andrzej Siewior wrote:
> Using u64 for statistics can lead to inconsistency on 32bit because an
> update and a read requires to access two 32bit values.
> This can be avoided by using u64_stats_t for the counters and
> u64_stats_sync for the required synchronisation on 32bit platforms. The
> synchronisation is a NOP on 64bit architectures.

Same as in previous messages: I'd want to see clearly that this is
indeed an issue on 32bit systems showing before/after assembly.
 
> Use u64_stats_t for the counters in page_pool_recycle_stats.

Commit message says page_pool_recycle_stats, but code below is for
alloc stats.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  .../ethernet/mellanox/mlx5/core/en_stats.c    | 12 ++---
>  include/net/page_pool/types.h                 | 14 +++---
>  net/core/page_pool.c                          | 45 +++++++++++++------
>  net/core/page_pool_user.c                     | 12 ++---
>  4 files changed, 52 insertions(+), 31 deletions(-)

[...]

> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -96,6 +96,7 @@ struct page_pool_params {
>  #ifdef CONFIG_PAGE_POOL_STATS
>  /**
>   * struct page_pool_alloc_stats - allocation statistics
> + * @syncp:	synchronisations point for updates.
>   * @fast:	successful fast path allocations
>   * @slow:	slow path order-0 allocations
>   * @slow_high_order: slow path high order allocations
> @@ -105,12 +106,13 @@ struct page_pool_params {
>   *		the cache due to a NUMA mismatch
>   */
>  struct page_pool_alloc_stats {
> -	u64 fast;
> -	u64 slow;
> -	u64 slow_high_order;
> -	u64 empty;
> -	u64 refill;
> -	u64 waive;
> +	struct u64_stats_sync syncp;
> +	u64_stats_t fast;
> +	u64_stats_t slow;
> +	u64_stats_t slow_high_order;
> +	u64_stats_t empty;
> +	u64_stats_t refill;
> +	u64_stats_t waive;
>  };

When I tried to get this in initially, Jesper had feelings about the
cacheline placement of the counters. I have no idea if that is still
the case or not.

My suggestion to you (assuming that your initial assertion is
correct that this_cpu_inc isn't safe on 32bit x86) would be to:

  - include pahole output showing the placement of these counters
  - include the same benchmarks I included in the original series
    [1] that Jesper requested from me. I believe the code for the
    benchmarks can be found here:
       https://github.com/netoptimizer/prototype-kernel/tree/master/kernel/lib

That would probably make it easier for the page pool people to
review / ack and would likely result in fewer revisions.

[1]: https://lore.kernel.org/all/1646172610-129397-1-git-send-email-jdamato@fastly.com/

