Return-Path: <netdev+bounces-128195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0620C97870C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321CA1C21C51
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06C82D83;
	Fri, 13 Sep 2024 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfymHwl3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC179DC7;
	Fri, 13 Sep 2024 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249361; cv=none; b=aN7YKxGtg5tXD1DGc2rewAYx9Gf8OQtJXSH7Ga8uQvRJrKs/oOldqZGnp1uxD/X3C/He9WNAFKKnkCcO4rxuGJLQoj65YEPWP2JTXTVLJh0mtMBxrT5q5wSxMfTxqYhlF2+bJTUwvgQDEf6Qk2dGL+oV80OzBmJcsCi/ihOclIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249361; c=relaxed/simple;
	bh=fN7BkmVny58QLjARfISHyOWbDwfMXmVa1FlpEq3RklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1TtyHSO+pN6NgyVOQBNZ8PrSFLkNKquhUc4KTTjvDv4ozQsxsBFalOj1xWk+T3iUxjwln/LRqzV7BNw/EnOUfoYLKr6v+pFp1yqmRu2BuHVwcuMzvIIHiSwegkp/gwOa4A1S2tE4xHyG4JjTYZdDPBxAOT2iDU4yi269RUebkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfymHwl3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso1800294a91.1;
        Fri, 13 Sep 2024 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726249359; x=1726854159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyyEBCTPsvp/ttqnBo0nJUmrFbpdSowy9pfVr+wVois=;
        b=FfymHwl3pEB0imERCT1ZbgvXwbpSCWkLJzHJCmqkh420+9P1ycYUmT9a4peJWJolOc
         EEPcMTEtnk5iXcwf3CvChsq2u7KGpwYH/b/tl5zgBf7SNmWqQxaipbG7pU0tdwLcFCof
         66hiqtbw4P4/QA0ERAYGtYTW5Rz+3L/XrVoGNMwxqvnFPIPRblu2hQkoYqb74PhbpVkZ
         Z8yOoNvjKNXrYwpdidLFGQMfcX/gNNgPs9IC1O/ZJRJ0nhLr3i7MsbMTFN7TcGt9cg0O
         FE5+CfG0dZrdkJPoQ1FFWcRKU8BABDSWH3UhQFaRYIIqt45Ghm5spVUFb6XThdmRbzUM
         IYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249359; x=1726854159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyyEBCTPsvp/ttqnBo0nJUmrFbpdSowy9pfVr+wVois=;
        b=kTxbHQH9jr6ETUz5ukGV2VNvsdfotohN18/i99kSLUYhNWW2/vY46F/fRxDHZfI61j
         M3wVhP7KiktT1x5fnoumVmE5v/Hcsh14qwEwS61mGsnsyvuaEE7szynKarhYeXE76afd
         9UlOFWN1peiAyDCg587cgtEcJQcM4qvTgjiirvoZRU5RMkRy/FO9SWGeonq2nHRgj/zB
         bY2G2bAdUnIyFgbpwa3huqDYtr97gpyfBk6imFGAdP8CtOFcz2NIBkG1dGDqPtaACqSk
         ab17CtCzmEbtmowurNYPHX9S3gLm+EMUUW0I8E/GA8ZzqY0Kx0OgsJFORVFQPBPWhkCP
         4/JA==
X-Forwarded-Encrypted: i=1; AJvYcCUp1RA/bMwySXFkZaip2KuYk/p4c/956SLeGiSev7vkByPuLUjOB8dObcPo190IEj/3YkmWViZZE6uFAL8O@vger.kernel.org, AJvYcCV7P9WvgEMLQa6Xbrp7pk2FOR2DzGrRPrqQu12Zlxni26gJjPqnQx/qtTnnGFQwh0HwXQZekjbkVNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPC+cxdp0ZsfQcXNAgtqbuyZG9R+qlYy9Cs6owzyBs9HrEl9M
	zpQRbEHbT5Oe7mHTRBufa7SJ9mnqRYQ0P3WKRMYEgj7ua/0pHO8=
X-Google-Smtp-Source: AGHT+IFLVAxbpcNpPyXUd4RHvwZRR74cLegwhcpbAvrxVTVD7dzv1jSn7LHuiVNBpAbr/qejtegpQw==
X-Received: by 2002:a17:90a:5ae6:b0:2d8:a672:1869 with SMTP id 98e67ed59e1d1-2dba0048720mr7153723a91.32.1726249359143;
        Fri, 13 Sep 2024 10:42:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d3464fsm2052975a91.51.2024.09.13.10.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:42:38 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:42:37 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, kuba@kernel.org,
	skhawaja@google.com, sdf@fomichev.me, bjorn@rivosinc.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 5/9] net: napi: Add napi_config
Message-ID: <ZuR5jU3BGbsut-q6@mini-arch>
References: <20240912100738.16567-1-jdamato@fastly.com>
 <20240912100738.16567-6-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912100738.16567-6-jdamato@fastly.com>

On 09/12, Joe Damato wrote:
> Add a persistent NAPI config area for NAPI configuration to the core.
> Drivers opt-in to setting the storage for a NAPI by passing an index
> when calling netif_napi_add_storage.
> 
> napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> (after the NAPIs are deleted), and set to 0 when napi_enable is called.
> 
> Drivers which implement call netif_napi_add_storage will have persistent
> NAPI IDs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  .../networking/net_cachelines/net_device.rst  |  1 +
>  include/linux/netdevice.h                     | 34 +++++++++
>  net/core/dev.c                                | 74 +++++++++++++++++--
>  net/core/dev.h                                | 12 +++
>  4 files changed, 113 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 3d02ae79c850..11d659051f5e 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -183,3 +183,4 @@ struct hlist_head                   page_pools
>  struct dim_irq_moder*               irq_moder
>  unsigned_long                       gro_flush_timeout
>  u32                                 napi_defer_hard_irqs
> +struct napi_config*                 napi_config
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3e07ab8e0295..08afc96179f9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -342,6 +342,15 @@ struct gro_list {
>   */
>  #define GRO_HASH_BUCKETS	8
>  
> +/*
> + * Structure for per-NAPI storage
> + */
> +struct napi_config {
> +	u64 gro_flush_timeout;
> +	u32 defer_hard_irqs;
> +	unsigned int napi_id;
> +};
> +
>  /*
>   * Structure for NAPI scheduling similar to tasklet but with weighting
>   */
> @@ -379,6 +388,8 @@ struct napi_struct {
>  	int			irq;
>  	unsigned long		gro_flush_timeout;
>  	u32			defer_hard_irqs;
> +	int			index;
> +	struct napi_config	*config;
>  };
>  
>  enum {
> @@ -2011,6 +2022,9 @@ enum netdev_reg_state {
>   *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
>   *		   where the clock is recovered.
>   *
> + *	@napi_config: An array of napi_config structures containing per-NAPI
> + *		      settings.
> + *
>   *	FIXME: cleanup struct net_device such that network protocol info
>   *	moves out.
>   */
> @@ -2400,6 +2414,7 @@ struct net_device {
>  	struct dim_irq_moder	*irq_moder;
>  	unsigned long		gro_flush_timeout;
>  	u32			napi_defer_hard_irqs;
> +	struct napi_config	*napi_config;
>  
>  	u8			priv[] ____cacheline_aligned
>  				       __counted_by(priv_len);
> @@ -2650,6 +2665,23 @@ netif_napi_add_tx_weight(struct net_device *dev,
>  	netif_napi_add_weight(dev, napi, poll, weight);
>  }
>  
> +/**
> + * netif_napi_add_storage - initialize a NAPI context and set storage area
> + * @dev: network device
> + * @napi: NAPI context
> + * @poll: polling function
> + * @weight: the poll weight of this NAPI
> + * @index: the NAPI index
> + */
> +static inline void
> +netif_napi_add_storage(struct net_device *dev, struct napi_struct *napi,
> +		       int (*poll)(struct napi_struct *, int), int index)
> +{
> +	napi->index = index;
> +	napi->config = &dev->napi_config[index];
> +	netif_napi_add_weight(dev, napi, poll, NAPI_POLL_WEIGHT);
> +}
> +
>  /**
>   * netif_napi_add_tx() - initialize a NAPI context to be used for Tx only
>   * @dev:  network device
> @@ -2685,6 +2717,8 @@ void __netif_napi_del(struct napi_struct *napi);
>   */
>  static inline void netif_napi_del(struct napi_struct *napi)
>  {
> +	napi->config = NULL;
> +	napi->index = -1;
>  	__netif_napi_del(napi);
>  	synchronize_net();
>  }
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f2fd503516de..ca2227d0b8ed 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6493,6 +6493,18 @@ EXPORT_SYMBOL(napi_busy_loop);
>  
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
>  
> +static void napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
> +{
> +	spin_lock(&napi_hash_lock);
> +
> +	napi->napi_id = napi_id;
> +
> +	hlist_add_head_rcu(&napi->napi_hash_node,
> +			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
> +
> +	spin_unlock(&napi_hash_lock);
> +}
> +
>  static void napi_hash_add(struct napi_struct *napi)
>  {
>  	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
> @@ -6505,12 +6517,13 @@ static void napi_hash_add(struct napi_struct *napi)
>  		if (unlikely(++napi_gen_id < MIN_NAPI_ID))
>  			napi_gen_id = MIN_NAPI_ID;
>  	} while (napi_by_id(napi_gen_id));

[..]

> -	napi->napi_id = napi_gen_id;
> -
> -	hlist_add_head_rcu(&napi->napi_hash_node,
> -			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
>  
>  	spin_unlock(&napi_hash_lock);
> +
> +	napi_hash_add_with_id(napi, napi_gen_id);

nit: it is very unlikely that napi_gen_id is gonna wrap around after the
spin_unlock above, but maybe it's safer to have the following?

static void __napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
{
	napi->napi_id = napi_id;
	hlist_add_head_rcu(&napi->napi_hash_node,
			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
}

static void napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
{
	spin_lock(&napi_hash_lock);
	__napi_hash_add_with_id(...);
	spin_unlock(&napi_hash_lock);
}

And use __napi_hash_add_with_id here before spin_unlock?

