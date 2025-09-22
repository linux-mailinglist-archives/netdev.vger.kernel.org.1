Return-Path: <netdev+bounces-225329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0555FB924B9
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC0A7A4E1E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078A311C3C;
	Mon, 22 Sep 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1eKEgZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F323115AD
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559685; cv=none; b=Ta8+h5fZKGk1iC1CXB+bmkhv5DbrFT1fa7dfhU6peA5/uXnWckp840Y9wX7Um5/aLQ3udNRGopR4CQMp7p2M8+Q4GdBOj7naGHDPm7mJajGnGZKC9SQ4RL6pEvIOW+uKiVedUhGRN5UHlH8L7UqfCfxIYCMUn4tz4lb8Z5ka7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559685; c=relaxed/simple;
	bh=jWXdeGGGgkjMzjGrqhFHOvMVLqFH9NLTOg+0l5iyG4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feJHsOC3OWiy0oXnCiv+UAn9kfolMweHR3/eOY5HKMKLE2OdQ9XtuGM8V2dBhwPfqPAp+fmU73rVIEGR3in7H/t/EP6UlKAHX3T0B6mCYOxNh9lBS0iIPiVbyygnSMQF3TTVGOBzjnNdveXi0EB8jWss/4l+W/b5aJsxQ0/qVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1eKEgZ4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b552590d8cdso2938398a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758559683; x=1759164483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLd/PEFRdlVhmkXjk+h4NVsNhitE9KvBZ+AXpxa+Bco=;
        b=O1eKEgZ4+afWq230dyw9VEpChT79Rdnl5e2dkUeQkf1/CQCp016p1b2Pibv9myjlqe
         ntLbUUsKYNQRywvIVAvsk9yXN58QCZo5Ga5XTmS2NwTXzGVTnmoQLlpcsP06zgRW4WIS
         kfaRDCoQi59Hg8WnrrAauJTh7ZVnM9afeYRtyS51vQFsGza7o8gnM4//M+aAKv4BMNMM
         /VJJu71JXqodtB7KyHixZ8aeo8ehpz2tR183W8bfGu4VK6y4V68AUWjhRZ5Hh0JpJQtP
         DcnOSxTuUYO6RCaNpm7UrLWXjuBQP4/3UBdDmR5ULKkKe0yxV40lctjDMayQwVFdMyNg
         MysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559683; x=1759164483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLd/PEFRdlVhmkXjk+h4NVsNhitE9KvBZ+AXpxa+Bco=;
        b=TdH3CG/Uh4W+sd1uZhCMoe5TeaoyC9rIKO0P7DgZxV0z3+XnoBgS2amDq8OfXIJGKM
         R7Cs2apIz43rNa4h0nnnsxAGSbchTIy8NPywTh6d48RohkPfXZXFYKo86kXxJUPP609L
         J6kuE1P3sE7MCASA05fIf9E3FfzDKRV88PwPD9Dv5r9fytPepL0dlzHXptEy4dpvfdDb
         0JbPs3zSGunfjXt+35ZitG/qx6vuV/D2YPRUy0nbnBUUnkd87CZh0rkvIWNhtwocLaj7
         8COLamdQ1fFhGOvhJpR1dVcphagN3CHmqSO4UHnhyWJ0TPdbwMiYyF0Cx3KH/nC+eu5l
         pUoA==
X-Gm-Message-State: AOJu0Ywa0UduXZxt/Wqt2nx76oMpSYUicvTASRRhZVk5ddCDvi+gPq3f
	So7tvY4spHWTyhqGtT+40FrfaVOgR6XDGKujkAOx4F3Yicl8byJwc7w=
X-Gm-Gg: ASbGncuzx7SVkjUoamRDn6E0y2sQFewT53lIxZOQxXg3kUMb6sVqW9g4bK9nHPCGUhd
	nJ/Bh/aOG86NBq0P9UyszMUKI4iY9F7smsOXMQwngtjVxtKzPa2ZB3Nsl4+IzWJYWTAUt/1yDcE
	dvD6TwnDZ07bYH3BUOcYlWjECXsOlveRgGAUFgsw4Rh/UWkRrpsdH6nqGlKdy+UgnwzOIJJEHyi
	vqA4THiGgdcDRpkgakqEsFjt+EsGkJrj0qFyydtTwqpZYJyM4KLK8PXAlLm9rLHRGkfZAZiGiQ/
	1TJaorDswLeqwwN/lmNUX/ydF7Xi1wiR3r8m0jLB4pNAa+KRNfsoyB77M+TS2Wej8urcKdSoWDn
	AIStI2n1X73qTRBzyAlKGvORKzE4nnFBExJ5US52IppzvWvKLbyeQSgM0uM/NO+eh4kQBeKWHQv
	Te8KlhAxY5zO5t5Y4OBNYmbRPIoz2sQNdr5QBMeoEc7aUr1lSjdu+vlY1oHodEKzQCQnnFSEPBb
	vs1
X-Google-Smtp-Source: AGHT+IF+oD35LIv3CJ6KA7GHnZhPc4X7hT0udCz/Fxf7vUFgycWpsJe9ezDmgaCzuDGvU8c7RvG9Lw==
X-Received: by 2002:a17:90b:3b49:b0:32e:37a1:cf65 with SMTP id 98e67ed59e1d1-33098362f99mr16420429a91.28.1758559682804;
        Mon, 22 Sep 2025 09:48:02 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-332906a5348sm875704a91.1.2025.09.22.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:48:02 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:48:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 13/20] xsk: Proxy pool management for mapped
 queues
Message-ID: <aNF9waxmQUipXe1_@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-14-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-14-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> Similarly what we do for net_mp_{open,close}_rxq for mapped queues,
> proxy also the xsk_{reg,clear}_pool_at_qid via __netif_get_rx_queue_peer
> such that when a virtual netdev picked a mapped rxq, the request gets
> through to the real rxq in the physical netdev.
> 
> Change the function signatures for queue_id to unsigned int in order
> to pass the queue_id parameter into __netif_get_rx_queue_peer. The
> proxying is only relevant for queue_id < dev->real_num_rx_queues since
> right now its only supported for rxqs.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  include/net/xdp_sock_drv.h |  4 ++--
>  net/xdp/xsk.c              | 16 +++++++++++-----
>  net/xdp/xsk.h              |  5 ++---
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 47120666d8d6..709af292cba7 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -29,7 +29,7 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
>  void xsk_tx_release(struct xsk_buff_pool *pool);
>  struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
> -					    u16 queue_id);
> +					    unsigned int queue_id);
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
>  void xsk_set_tx_need_wakeup(struct xsk_buff_pool *pool);
>  void xsk_clear_rx_need_wakeup(struct xsk_buff_pool *pool);
> @@ -286,7 +286,7 @@ static inline void xsk_tx_release(struct xsk_buff_pool *pool)
>  }
>  
>  static inline struct xsk_buff_pool *
> -xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
> +xsk_get_pool_from_qid(struct net_device *dev, unsigned int queue_id)
>  {
>  	return NULL;
>  }
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index cf40c70ee59f..b9efa6d8a112 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -23,6 +23,8 @@
>  #include <linux/netdevice.h>
>  #include <linux/rculist.h>
>  #include <linux/vmalloc.h>
> +
> +#include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/busy_poll.h>
>  #include <net/netdev_lock.h>
> @@ -111,19 +113,20 @@ bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
>  EXPORT_SYMBOL(xsk_uses_need_wakeup);
>  
>  struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
> -					    u16 queue_id)
> +					    unsigned int queue_id)
>  {
>  	if (queue_id < dev->real_num_rx_queues)
>  		return dev->_rx[queue_id].pool;
>  	if (queue_id < dev->real_num_tx_queues)
>  		return dev->_tx[queue_id].pool;
> -
>  	return NULL;
>  }
>  EXPORT_SYMBOL(xsk_get_pool_from_qid);
>  
> -void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
> +void xsk_clear_pool_at_qid(struct net_device *dev, unsigned int queue_id)
>  {
> +	if (queue_id < dev->real_num_rx_queues)
> +		__netif_get_rx_queue_peer(&dev, &queue_id);
>  	if (queue_id < dev->num_rx_queues)
>  		dev->_rx[queue_id].pool = NULL;
>  	if (queue_id < dev->num_tx_queues)
> @@ -135,7 +138,7 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
>   * This might also change during run time.
>   */
>  int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
> -			u16 queue_id)
> +			unsigned int queue_id)
>  {
>  	if (queue_id >= max_t(unsigned int,
>  			      dev->real_num_rx_queues,
> @@ -143,6 +146,10 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
>  		return -EINVAL;
>  	if (xsk_get_pool_from_qid(dev, queue_id))
>  		return -EBUSY;
> +	if (queue_id < dev->real_num_rx_queues)
> +		__netif_get_rx_queue_peer(&dev, &queue_id);
> +	if (xsk_get_pool_from_qid(dev, queue_id))
> +		return -EBUSY;
>  
>  	pool->netdev = dev;
>  	pool->queue_id = queue_id;

I feel like both of the above are also gonna be problematic wrt netdev
lock. The callers lock the netdev, the callers will also have
to resolve the virtual->real queue mapping. Hacking up the
queue/netdev deep in the call stack in a few places is not gonna work.

Maybe also add assert for the (new) netdev lock to __netif_get_rx_queue_peer
to trigger these.

