Return-Path: <netdev+bounces-59307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE0681A574
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5DF285B9F
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF3B41234;
	Wed, 20 Dec 2023 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlVf1dBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258346422
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E7AC433C8;
	Wed, 20 Dec 2023 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703090457;
	bh=fal3mILqskyKzcC3w5NdDdkcQqZHXCF7aLPO7R72F6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlVf1dBLVZKf5X0eTCVK31R3w9+0OE2Yd7bbfZwiZW8IX5DJfJp9sV2DnU99z1roj
	 D6RsjSdweMiQaaKJgs5nHncn9pfGIUt9+prXi/Q2K6oOm0E1I57VPEcq1i46MiyS4p
	 CuhdVIxpSjKs4S+L4GA4YI2NhmbbZp6Eocs4RZf6gPTGsKFHm4ivQVbBKBg0p+K5I6
	 eAzkGWDXPGGGFa03sSF+AI4h/NoYDpTWGyANIVOLcVn1hVUa6o+Fr4b3a+SZ9rRCJI
	 3MFxRw19hK2W9sSTkGxQ+976cq0oAjL3fl1GFRlJ5KEkd0Zoe/AXBhX2qLcOYe9Yho
	 wcRNYkOBAjp/w==
Date: Wed, 20 Dec 2023 17:40:50 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 1/5] netdevsim: maintain a list of probed
 netdevsims
Message-ID: <20231220164050.GN882741@kernel.org>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220014747.1508581-2-dw@davidwei.uk>

On Tue, Dec 19, 2023 at 05:47:43PM -0800, David Wei wrote:
> This patch adds a linked list nsim_dev_list of probed netdevsims, added
> during nsim_drv_probe() and removed during nsim_drv_remove(). A mutex
> nsim_dev_list_lock protects the list.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netdevsim/dev.c       | 17 +++++++++++++++++
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index b4d3b9cde8bd..e30a12130e07 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -35,6 +35,9 @@
>  
>  #include "netdevsim.h"
>  
> +static LIST_HEAD(nsim_dev_list);
> +static DEFINE_MUTEX(nsim_dev_list_lock);
> +
>  static unsigned int
>  nsim_dev_port_index(enum nsim_dev_port_type type, unsigned int port_index)
>  {
> @@ -1531,6 +1534,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>  				 nsim_bus_dev->initial_net, &nsim_bus_dev->dev);
>  	if (!devlink)
>  		return -ENOMEM;
> +	mutex_lock(&nsim_dev_list_lock);
>  	devl_lock(devlink);
>  	nsim_dev = devlink_priv(devlink);
>  	nsim_dev->nsim_bus_dev = nsim_bus_dev;
> @@ -1544,6 +1548,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>  	spin_lock_init(&nsim_dev->fa_cookie_lock);
>  
>  	dev_set_drvdata(&nsim_bus_dev->dev, nsim_dev);
> +	list_add(&nsim_dev->list, &nsim_dev_list);
>  
>  	nsim_dev->vfconfigs = kcalloc(nsim_bus_dev->max_vfs,
>  				      sizeof(struct nsim_vf_config),
> @@ -1607,6 +1612,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>  
>  	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
>  	devl_unlock(devlink);
> +	mutex_unlock(&nsim_dev_list_lock);
>  	return 0;
>  

Hi David,

I see Jiri has asked about the scope and type of this lock.
And updates to address those questions may obviate my observation.
But it is that mutex_unlock(&nsim_dev_list_lock); needs to
be added to the unwind ladder:

	...
err_devlink_unlock:
	devl_unlock(devlink);
	mutex_unlock(&nsim_dev_list_lock);
	...

...

Flagged by Smatch.

