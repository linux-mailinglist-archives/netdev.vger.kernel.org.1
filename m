Return-Path: <netdev+bounces-234561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F94CC22F96
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 03:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F36F4E5BFE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85F2741C9;
	Fri, 31 Oct 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1gbfvX8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372A221271;
	Fri, 31 Oct 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877220; cv=none; b=jvh7dnAy4OPPwfa/oduGlr2YhWfHC483AH8s6ZbxerTe2hQCf5q61ZhPBCDMot/nOIop8S1z3nOQBP7aLivqsI9BQZShmlSRw/HsUYUDpEMhD7X5AjuuqAsObXTXvCF9ipKmdQhx18jnkR5NxzCzpkcoZRiuwsV/tqc6jYnR6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877220; c=relaxed/simple;
	bh=zhRf3WzvDJyPeejmO5aptZIISSdrujJbMf1xOd4/lhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8tn29qiHpdXVkW9fkNd0QBKmP5xxpD1solQUbeXTMPvOzsBY6VCbd3LnEhjfadiG6lS61qYByQaXvy0NcMMgmQRi1MMQK5E3JRHgztqhOCo8hq8iWefv7XyNsCl9Jjv6f2H6dCYJV/3qlsyrZH00LJkWp8REkH37mnPkWbQyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1gbfvX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA93C4CEFD;
	Fri, 31 Oct 2025 02:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761877219;
	bh=zhRf3WzvDJyPeejmO5aptZIISSdrujJbMf1xOd4/lhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k1gbfvX8XNS+ou0cZHxljo92H+tqL6GPLLAUgYbPMES9QCOufZdnukq5wfv1ytkCW
	 fIWCLdZAAzqivVON/zd7EEuIDCgxubjpmfmvKYl0Y/VndCGbxWaYiHz3dDETaiWfgG
	 2DzEciXJ6D5oJATynijfrhkF6Gty3okDR43txlhY47en64B2m/AK1rBLFOioX0uu0i
	 YnFIYnBTA2igU00wQlqEnDvMG1TOa2HM0mB0ii9LOs3Oh8eDEn4tUeO+STG+uZt25f
	 DuIy5ylH5B6yIua1F/OFyfBhv/+hu/87SPGP8HtJwpATy8rd1DNHr6GgNT3DyNXkZ9
	 t/fj9OFblawHw==
Date: Thu, 30 Oct 2025 19:20:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config
 and helper structs and functions:
Message-ID: <20251030192018.28dcd830@kernel.org>
In-Reply-To: <20251028174222.1739954-2-viswanathiyyappan@gmail.com>
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
	<20251028174222.1739954-2-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 23:12:21 +0530 I Viswanath wrote:
> @@ -1421,6 +1426,7 @@ struct net_device_ops {
>  	void			(*ndo_change_rx_flags)(struct net_device *dev,
>  						       int flags);
>  	void			(*ndo_set_rx_mode)(struct net_device *dev);
> +	void			(*ndo_write_rx_config)(struct net_device *dev);
>  	int			(*ndo_set_mac_address)(struct net_device *dev,
>  						       void *addr);
>  	int			(*ndo_validate_addr)(struct net_device *dev);
> @@ -1767,6 +1773,12 @@ enum netdev_reg_state {
>  	NETREG_DUMMY,		/* dummy device for NAPI poll */
>  };
>  
> +struct rx_config_work {

pls make sure to prefix names of types and functions with netif,
netdev or net

> +	struct work_struct config_write;
> +	struct net_device *dev;
> +	spinlock_t config_lock;
> +};
> +

> +#define update_snapshot(config_ptr, type)						\
> +	do {										\
> +		typeof((config_ptr)) rx_config = ((type *)(dev->priv))->rx_config;	\
> +		unsigned long flags;							\
> +		spin_lock_irqsave(&((dev)->rx_work->config_lock), flags);		\
> +		*rx_config = *(config_ptr);						\
> +		spin_unlock_irqrestore(&((dev)->rx_work->config_lock), flags);		\
> +	} while (0)

The driver you picked is relatively trivial, advanced drivers need
to sync longer lists of mcast / ucast addresses. Bulk of the complexity
is in keeping those lists. Simple 

	*rx_config = *(config_ptr);

assignment is not enough. The driver needs to know old and new entries
and send ADD/DEL commands to FW. Converting virtio_net would be better,
but it does one huge dump which is also not representative of most
advanced NICs.

> @@ -11961,9 +11989,17 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  	refcount_set(&dev->dev_refcnt, 1);
>  #endif
>  
> -	if (dev_addr_init(dev))
> +	dev->rx_work = kmalloc(sizeof(*dev->rx_work), GFP_KERNEL);

Let's only allocate any extra state if driver has the NDO

> +	if (!dev->rx_work)
>  		goto free_pcpu;
>  
> +	dev->rx_work->dev = dev;
> +	spin_lock_init(&dev->rx_work->config_lock);
> +	INIT_WORK(&dev->rx_work->config_write, execute_write_rx_config);
> +
> +	if (dev_addr_init(dev))
> +		goto free_rx_work;
> +
>  	dev_mc_init(dev);
>  	dev_uc_init(dev);
>  
> @@ -12045,6 +12081,10 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  	free_netdev(dev);
>  	return NULL;
>  
> +free_rx_work:
> +	cancel_work_sync(&dev->rx_work->config_write);
> +	kfree(dev->rx_work);
> +
>  free_pcpu:
>  #ifdef CONFIG_PCPU_DEV_REFCNT
>  	free_percpu(dev->pcpu_refcnt);
> @@ -12130,6 +12170,9 @@ void free_netdev(struct net_device *dev)
>  		return;
>  	}
>  
> +	cancel_work_sync(&dev->rx_work->config_write);
> +	kfree(dev->rx_work);

We need to shut down sooner, some time between ndo_stop and ndo_uninit


