Return-Path: <netdev+bounces-127840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFE976CF2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123891C23A83
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB141ABEDB;
	Thu, 12 Sep 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GPYWlXFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2411A42B7
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153441; cv=none; b=UskyXmRQ05NKgJm1IIITojw3Ax695mZtZXmbeuCFsp7bwUklZrndyRyRM6illnAbIzj5/n4HNH3hPhEgSzSYMoBTU9T4h43BgojSDYtFZYMyoPB+LlwaQdIkaSA85rP8nWEfcUW7EZM5SwfR7hF45hXHXXhykNu+DwKfRQm0ILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153441; c=relaxed/simple;
	bh=+7LZG0rvJj/L4db5k+I3s+YJckWW5sdZM0oLD+DvjWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0tF0I2n91L9Ndd6yG8CRPanYqxi/sNtUtL0nKHDjE4ddEX6oMx/bWLI3knDtrAhNL3bT0jXRZij3WH3bQCnVZ0jmr4Ydpyfwr62zxcoykRGXrHX/ctUtgFnsAIBg8jDzNTSRnNuYFmlJ938pryWjFaRy3+p/6LM+KaX1nhjOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GPYWlXFf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so172748366b.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726153437; x=1726758237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJrAQUSIxLUkiGeqfi+dbP3QmEaNP85b+aRDPyt1b4U=;
        b=GPYWlXFfyDcc6mYfItldWCpZfulq8BiFK3yuUV6PU94p9aPt6aCIzvMzamR2iMPpvs
         d6Pe/C/f+DBVo4ro9TjJJZ5S309Yz0erln6kG50OnA6/JrEGqnb0525OR24+HfJyyYdI
         Jm/xDc+pzcpVSS8ZqcLAyDk1hVP6ZcSzr5w1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153437; x=1726758237;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJrAQUSIxLUkiGeqfi+dbP3QmEaNP85b+aRDPyt1b4U=;
        b=rGWF0YA/4ZpWQsMTISUk9Najmy5tAcwmVmDbtagrQb58Whst1wWzEKu4LJBg6S+67y
         uRgXLL1hWH9uKN8a/X1BvIOCrHtgx2UwkevaPGlL9yFZUHIp5aeUGcal/UnS8wEVQvlw
         pr2F4M8kwDyUf8V0yemhk96FgasHfjzQ9iyaJ8qf+U8NBxmxWlITrkOhA6kSknU75GUK
         wOTKG9ByGLpIjODP6UgKTIY2DDY4+5aRhaRwJnqoeDzGDIYRzjYgsByLNZDpFDMNznzk
         /TdEBNHMjhtU6GrV1U6+8JIGVtC7xfCe0jQaCGy4iXCijGS6drO8g87/N6iBC+Z5fo5k
         8NEQ==
X-Gm-Message-State: AOJu0YxkfQbFcDvzr0Whd3Pq9m4GqhY7+mXY7b6sl9LEIbMqNgsJubzx
	rTG0w82cqJ+vGu8SGkgoaBE+k9unVmx+kXGIdcVA24EfebZZNvrQhE/OhrhMYD1Pz7zBucsotLu
	TTIXi3J2B5MRPniANRpCFc7uJGIXDLQJG6KThqA6Jbhrz9sVy/38yQiI8sTz6k8EyCXLFz05dSA
	qyP8Z8WUFANUmRIm2FplGzJnc7WTce5VJNW6gAnCQJ
X-Google-Smtp-Source: AGHT+IGcPPkC8mduVKODvGQyiolKYPsJm52YqQ1ZBEdnm+fcF25sCtznRpVLU7JypXn/P305OYE5Ng==
X-Received: by 2002:a17:907:e25b:b0:a8d:439d:5c3c with SMTP id a640c23a62f3a-a9029408106mr344291866b.8.1726153436519;
        Thu, 12 Sep 2024 08:03:56 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25950a7fsm761862866b.57.2024.09.12.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:03:56 -0700 (PDT)
Date: Thu, 12 Sep 2024 17:03:53 +0200
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
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
Message-ID: <ZuMC2fYPPtWggB2w@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240912100738.16567-1-jdamato@fastly.com>
 <20240912100738.16567-6-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912100738.16567-6-jdamato@fastly.com>

Several comments on different things below for this patch that I just noticed.

On Thu, Sep 12, 2024 at 10:07:13AM +0000, Joe Damato wrote:
> Add a persistent NAPI config area for NAPI configuration to the core.
> Drivers opt-in to setting the storage for a NAPI by passing an index
> when calling netif_napi_add_storage.
> 
> napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> (after the NAPIs are deleted), and set to 0 when napi_enable is called.

Forgot to re-read all the commit messages. I will do that for rfcv4
and make sure they are all correct; this message is not correct.
 
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

[...]

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3e07ab8e0295..08afc96179f9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h

[...]

> @@ -2685,6 +2717,8 @@ void __netif_napi_del(struct napi_struct *napi);
>   */
>  static inline void netif_napi_del(struct napi_struct *napi)
>  {
> +	napi->config = NULL;
> +	napi->index = -1;
>  	__netif_napi_del(napi);
>  	synchronize_net();
>  }

I don't quite see how, but occasionally when changing the queue
count with ethtool -L, I seem to trigger a page_pool issue.

I assumed it was related to either my changes above in netif_napi_del, or 
below in __netif_napi_del, but I'm not so sure because the issue does not
happen reliably and I can't seem to figure out how my change would cause this.

When it does happen, this is the stack trace:

  page_pool_empty_ring() page_pool refcnt -30528 violation
  ------------[ cut here ]------------
  Negative(-1) inflight packet-pages
  WARNING: CPU: 1 PID: 5117 at net/core/page_pool.c:617 page_pool_inflight+0x4c/0x90

  [...]

  CPU: 1 UID: 0 PID: 5117 Comm: ethtool Tainted: G        W          [...]

  RIP: 0010:page_pool_inflight+0x4c/0x90
  Code: e4 b8 00 00 00 00 44 0f 48 e0 44 89 e0 41 5c e9 8a c1 1b 00 66 90 45 85 e4 79 ef 44 89 e6 48 c7 c7 78 56 26 82 e8 14 63 78 ff <0f> 0b eb dc 65 8b 05 b5 af 71 7e 48 0f a3 05 21 d9 3b 01 73 d7 48
  RSP: 0018:ffffc9001d01b640 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
  RDX: 0000000000000027 RSI: 00000000ffefffff RDI: ffff88bf4f45c988
  RBP: ffff8900da55a800 R08: 0000000000000000 R09: ffffc9001d01b480
  R10: 0000000000000001 R11: 0000000000000001 R12: 00000000ffffffff
  R13: ffffffff82cd35b0 R14: ffff890062550f00 R15: ffff8881b0e85400
  FS:  00007fa9cb382740(0000) GS:ffff88bf4f440000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000558baa9d3b38 CR3: 000000011222a000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   ? __warn+0x80/0x110
   ? page_pool_inflight+0x4c/0x90
   ? report_bug+0x19c/0x1b0
   ? handle_bug+0x3c/0x70
   ? exc_invalid_op+0x18/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? page_pool_inflight+0x4c/0x90
   page_pool_release+0x10e/0x1d0
   page_pool_destroy+0x66/0x160
   mlx5e_free_rq+0x69/0xb0 [mlx5_core]
   mlx5e_close_queues+0x39/0x150 [mlx5_core]
   mlx5e_close_channel+0x1c/0x60 [mlx5_core]
   mlx5e_close_channels+0x49/0xa0 [mlx5_core]
   mlx5e_switch_priv_channels+0xa9/0x120 [mlx5_core]
   ? __pfx_mlx5e_num_channels_changed_ctx+0x10/0x10 [mlx5_core]
   mlx5e_safe_switch_params+0xb8/0xf0 [mlx5_core]
   mlx5e_ethtool_set_channels+0x17a/0x290 [mlx5_core]
   ethnl_set_channels+0x243/0x310
   ethnl_default_set_doit+0xc1/0x170
   genl_family_rcv_msg_doit+0xd9/0x130
   genl_rcv_msg+0x18f/0x2c0
   ? __pfx_ethnl_default_set_doit+0x10/0x10
   ? __pfx_genl_rcv_msg+0x10/0x10
   netlink_rcv_skb+0x5a/0x110
   genl_rcv+0x28/0x40
   netlink_unicast+0x1aa/0x260
   netlink_sendmsg+0x1e9/0x420
   __sys_sendto+0x1d5/0x1f0
   ? handle_mm_fault+0x1cb/0x290
   ? do_user_addr_fault+0x558/0x7c0
   __x64_sys_sendto+0x29/0x30
   do_syscall_64+0x5d/0x170
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f2fd503516de..ca2227d0b8ed 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[...]

> @@ -6736,7 +6776,13 @@ void __netif_napi_del(struct napi_struct *napi)
>  	if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
>  		return;
>  
> -	napi_hash_del(napi);
> +	if (!napi->config) {
> +		napi_hash_del(napi);
> +	} else {
> +		napi->index = -1;
> +		napi->config = NULL;
> +	}
> +

See above; perhaps something related to this change is triggering the page pool
warning occasionally.

>  	list_del_rcu(&napi->dev_list);
>  	napi_free_frags(napi);
>  
> @@ -11049,6 +11095,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  		unsigned int txqs, unsigned int rxqs)
>  {
>  	struct net_device *dev;
> +	size_t napi_config_sz;
> +	unsigned int maxqs;
>  
>  	BUG_ON(strlen(name) >= sizeof(dev->name));
>  
> @@ -11062,6 +11110,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  		return NULL;
>  	}
>  
> +	WARN_ON_ONCE(txqs != rxqs);

This warning triggers for me on boot every time with mlx5 NICs.

The code in mlx5 seems to get the rxq and txq maximums in:
  drivers/net/ethernet/mellanox/mlx5/core/en_main.c
    mlx5e_create_netdev

  which does:

    txqs = mlx5e_get_max_num_txqs(mdev, profile);
    rxqs = mlx5e_get_max_num_rxqs(mdev, profile);

    netdev = alloc_etherdev_mqs(sizeof(struct mlx5e_priv), txqs, rxqs);

In my case for my device, txqs: 760, rxqs: 63.

I would guess that this warning will trigger everytime for mlx5 NICs
and would be quite annoying.

We may just want to replace the allocation logic to allocate
txqs+rxqs, remove the WARN_ON_ONCE, and be OK with some wasted
space?

> +	maxqs = max(txqs, rxqs);
> +
>  	dev = kvzalloc(struct_size(dev, priv, sizeof_priv),
>  		       GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>  	if (!dev)
> @@ -11136,6 +11187,11 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  	if (!dev->ethtool)
>  		goto free_all;
>  
> +	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
> +	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
> +	if (!dev->napi_config)
> +		goto free_all;
> +

[...]

> diff --git a/net/core/dev.h b/net/core/dev.h
> index a9d5f678564a..9eb3f559275c 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -167,11 +167,17 @@ static inline void napi_set_defer_hard_irqs(struct napi_struct *n, u32 defer)
>  static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
>  					      u32 defer)
>  {
> +	unsigned int count = max(netdev->num_rx_queues,
> +				 netdev->num_tx_queues);
>  	struct napi_struct *napi;
> +	int i;
>  
>  	WRITE_ONCE(netdev->napi_defer_hard_irqs, defer);
>  	list_for_each_entry(napi, &netdev->napi_list, dev_list)
>  		napi_set_defer_hard_irqs(napi, defer);
> +
> +	for (i = 0; i < count; i++)
> +		netdev->napi_config[i].defer_hard_irqs = defer;

The above is incorrect. Some devices may have netdev->napi_config =
NULL if they don't call the add_storage wrapper.

Unless there is major feedback/changes requested that affect this
code, in the rfcv4 branch I plan to fix this by adding a NULL check:

  if (netdev->napi_config)
    for (....)
      netdev->napi_config[i]....

>  
>  /**
> @@ -206,11 +212,17 @@ static inline void napi_set_gro_flush_timeout(struct napi_struct *n,
>  static inline void netdev_set_gro_flush_timeout(struct net_device *netdev,
>  						unsigned long timeout)
>  {
> +	unsigned int count = max(netdev->num_rx_queues,
> +				 netdev->num_tx_queues);
>  	struct napi_struct *napi;
> +	int i;
>  
>  	WRITE_ONCE(netdev->gro_flush_timeout, timeout);
>  	list_for_each_entry(napi, &netdev->napi_list, dev_list)
>  		napi_set_gro_flush_timeout(napi, timeout);
> +
> +	for (i = 0; i < count; i++)
> +		netdev->napi_config[i].gro_flush_timeout = timeout;

Same as above.

