Return-Path: <netdev+bounces-174467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D798A5EE05
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDF83BC416
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E431EA7FC;
	Thu, 13 Mar 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXcQXlye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2F260A30
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854528; cv=none; b=KwUUm1WqlFyI7prNewB/MSkrcuuEos4YW5DTq35XTII0PdVmeS2dhe+ptnj9O6M/GuMrWz5UYCQYUR2ugOPibk4lAxuYyrM9xMEgm295VebN5rsAO+pWgWgYWnoTEvnwLq0rHwlWcVON+5tV8z+0ofkG4WPaQZDYOrHvX+hnt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854528; c=relaxed/simple;
	bh=8sX9g+fRZ3SSPwvRjzJp6OE+tuwI4OzkoajzZTP3ig8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaNuCdo57l9m85mo4AT1MVd9BI9F70yg2SpHPzsWo/0bkFMv7mw0VtYRZKu8v+PICArSUlCUEpExnpC/23+vFxzawIiQMF5H6RrJLF4P/C3glz7n2+U+Yk66PRCDnzkx4wz3tH/35x4Cffe992DUfTWYZ+9Js07837R8h4vlhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXcQXlye; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fb0f619dso12368075ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741854525; x=1742459325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYv8SSlgbEdUHSzKbZMq3Qrd3CdkQUKfn6kSLgtT88s=;
        b=hXcQXlyeLT2o4jET1mqMcdexzoFR4HnyTa+BtC0tqRfFPRvXkYyl4YLjrlhJaGwOXO
         CjsTgpFAAtaDqh5BRIypld9CZoCkpyEhaaWqTlha7uzAvgSL7dEiR/HUUaP4XzA1tcDi
         WI67UjarbFQZJzrqNqCirFHCzEf8C4A4tnRE4VbLKtd8y4y7cAB9RhrU6mF9cBeym6rs
         tb3JrLPc3W64OF3InuNE/kUFs8dgW8rO3kfF1oetSEUZPdY8R94P1MM/+QqcVjqg6iry
         73v/9oRtU5rwAtRXo+QuGzyNWsLWlUxH2rKKsirTc00lF8xbLqc6ap/dg7z+sIo23SCY
         vuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741854525; x=1742459325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYv8SSlgbEdUHSzKbZMq3Qrd3CdkQUKfn6kSLgtT88s=;
        b=w6ow4/Pk3Cw6yXcr/Bi0qwjboF6ij+E0h4S4BV6vuovQ9VgKgRHt1rNWeGf5EtZIxe
         sxVBnqwVjspQgrrG9Pb5bE1wSayLvS8nyMQitTwisPjqEsU4rXEKqZOGZKdvqJJi9aCH
         VOc1mCo3d7LWVFUoUoUzBr2STkAX4UrHrzPJgyG7QQmztxts8DX8uENieen+VVurztic
         uZgPPi2QOCJ3gKQqHB0xatW4B/sijbW0QmHu/IVxr+mKKS6yeVoHb/llUfQ0NN9xtQHh
         QU74GV7hloB5tZHvYkLQG8XOExBjChh/fKSMepOt7zohhI8g5IP/fYDQ/KEFQ1mIpDO9
         aQYg==
X-Forwarded-Encrypted: i=1; AJvYcCXnOogrbjYbL31KI2AjoQ/hpGn4Vv9vRR+5VJWGSlEGKqtlVAIcl3GjMnL4FfvTAyPDvnnJg7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwiSO4UhZ+JWZjww7Q8m5syJReQDpk7Gu8ruIeZr813lD5y4A
	GZm2+x/qsWt2O1u8CPdJlGIXHHeb+QemSSmHG3Cz9rmlP9z+KbU=
X-Gm-Gg: ASbGncucWh7xT9nzzVhU55nvFVEX/hLJVGkKrYIr3XjporLbYwMzs68xbUlvTuQMsvj
	RUvnfB+TLaz10Zrw/67J7M/CXjxICSYUzFdSMZiuSW5X3s4EX7vhihj4ovylPuLAoDQb1vniQkv
	MCGJdRfZNBM+fy9YG01n04tDRkIwXi+LplXF5yu7Kpa5v74YVUw8gmXr/Jo12LElcX5kNXgsTSp
	8pMzOG+/qaSv1o/qnAxv58a5DDaI0d/VDw1xbZAG9Bc0qJPgnKe4Oi/aCdpHmXrZxEpj2n4zMFP
	JEVnzK+KRMSNUNS70PgrD0JmA33dyZVfdG+CMniwPFiZ
X-Google-Smtp-Source: AGHT+IEaxgTgEcUBow1mlXlyUT6PdQE06YLVKShb7V7KfNqcIqSZ+BW2FgRRqCKGJI4RPaanftLenQ==
X-Received: by 2002:a17:902:ea0d:b0:221:331:1d46 with SMTP id d9443c01a7336-22592e207camr133360655ad.2.1741854525226;
        Thu, 13 Mar 2025 01:28:45 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c66b75edsm8289565ad.0.2025.03.13.01.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:28:44 -0700 (PDT)
Date: Thu, 13 Mar 2025 01:28:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me
Subject: Re: [PATCH net-next 09/11] net: designate XSK pool pointers in
 queues as "ops protected"
Message-ID: <Z9KXO0Pgx9KKFXyv@mini-arch>
References: <20250312223507.805719-1-kuba@kernel.org>
 <20250312223507.805719-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312223507.805719-10-kuba@kernel.org>

On 03/12, Jakub Kicinski wrote:
> Read accesses go via xsk_get_pool_from_qid(), the call coming
> from the core and gve look safe (other "ops locked" drivers
> don't support XSK).
> 
> Write accesses go via xsk_reg_pool_at_qid() and xsk_clear_pool_at_qid().
> Former is already under the ops lock, latter needs to be locked when
> coming from the workqueue via xp_clear_dev().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/netdevice.h     | 1 +
>  include/net/netdev_rx_queue.h | 6 +++---
>  net/xdp/xsk_buff_pool.c       | 3 +++
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0fc79ae60ff5..7d802ef1c864 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -688,6 +688,7 @@ struct netdev_queue {
>  	/* Subordinate device that the queue has been assigned to */
>  	struct net_device	*sb_dev;
>  #ifdef CONFIG_XDP_SOCKETS
> +	/* "ops protected", see comment about net_device::lock */
>  	struct xsk_buff_pool    *pool;
>  #endif
>  
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index b2238b551dce..8cdcd138b33f 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -20,12 +20,12 @@ struct netdev_rx_queue {
>  	struct net_device		*dev;
>  	netdevice_tracker		dev_tracker;
>  
> +	/* All fields below are "ops protected",
> +	 * see comment about net_device::lock
> +	 */
>  #ifdef CONFIG_XDP_SOCKETS
>  	struct xsk_buff_pool            *pool;
>  #endif
> -	/* NAPI instance for the queue
> -	 * "ops protected", see comment about net_device::lock
> -	 */
>  	struct napi_struct		*napi;
>  	struct pp_memory_provider_params mp_params;
>  } ____cacheline_aligned_in_smp;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 14716ad3d7bc..60b3adb7b2d7 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -279,9 +279,12 @@ static void xp_release_deferred(struct work_struct *work)
>  {
>  	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
>  						  work);
> +	struct net_device *netdev = pool->netdev;

It looks like netdev might be null here. At least xp_clear_dev has
an explicit check. Presumably this happens when the device goes down
and invalidates the open sockets (in xsk_notifier) and we call
xp_release_deferred on socket close afterwards with netdev==null.

>  	rtnl_lock();
> +	netdev_lock_ops(netdev);
>  	xp_clear_dev(pool);
> +	netdev_unlock_ops(netdev);
>  	rtnl_unlock();
>  
>  	if (pool->fq) {
> -- 
> 2.48.1
> 

