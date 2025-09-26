Return-Path: <netdev+bounces-226719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3956BA4696
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86283A0460
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5415215F5C;
	Fri, 26 Sep 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTTkJW0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09602045B7
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900611; cv=none; b=bb0y51R0K8em+aOU84lbm7l8vossZLV9T05K7zo3HK/A+jLO18keMEVfgJ1DrNA8kfps0hw71V2Jz+l6D74CLTEWuuxwohfWO5iKLQ8Bg0SsYV2aR0z143v8aoNkfXh5eedmDYndowEH4qL/QY+Q2oS17bp83nItSj1STHhbpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900611; c=relaxed/simple;
	bh=nkeq185D9yQ9yxxChCIJcs1e3lmihBDJv2qnVelLEBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxWhcG7HNh6mJhiDJnOMNd5fb5so2b/cZalLyadRLjvq2Th69icRa5TRDg4xd2VkQNgZUuxvlDzRb6xD7b3w21fX6HNROVrTx0uIPBSFlQlVpUS42GEfkev4QTSa9h/Mc9K9QFm4hClM0wNmguZaAe5tTtQXkY9IrsThSh29Voc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTTkJW0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B091C4CEF4;
	Fri, 26 Sep 2025 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758900611;
	bh=nkeq185D9yQ9yxxChCIJcs1e3lmihBDJv2qnVelLEBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTTkJW0qJG4yuIPpK2aFpnhhMoS5zHe4ZHjDCZDNQ9Ek2Gd5B30EXPbdDPwVWHf5R
	 qyeRxxfUscNvkOx5vooFRcR+a1LZLXWywumf5zm6sQjqI+S5e/DoLAIVqe96Srmpqd
	 YbA4qkBnhgJ0SSRGp/hiYS74GX7yH6beS/9F7/czkp0yON6tKcY3TjYX3m/zEc7u60
	 1mZqSD3Uwjck8zchuN5DNBi5u6AHW7Q4TE9vd8tjcrd18NV0gt6c/pbkvcSm/qux4M
	 9FdGh1o9IbxP6GoKk3mht4lvjHYvlOLQuWJgZQkSeUch1qC5vgjnsjTz2vArwv/bXW
	 GygNgocE2HEhw==
Date: Fri, 26 Sep 2025 16:30:06 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>, Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] netdevsim: a basic test PSP implementation
Message-ID: <aNaxfvNzp9zyWXEd@horms.kernel.org>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
 <20250924194959.2845473-2-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924194959.2845473-2-daniel.zahka@gmail.com>

On Wed, Sep 24, 2025 at 12:49:47PM -0700, Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Provide a PSP implementation for netdevsim.
> 
> Use psp_dev_encapsulate() and psp_dev_rcv() to do actual encapsulation
> and decapsulation on skbs, but perform no encryption or decryption. In
> order to make encryption with a bad key result in a drop on the peer's
> rx side, we stash our psd's generation number in the first byte of each
> key before handing to the peer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

...

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c

...

> @@ -1039,12 +1060,29 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  	if (IS_ENABLED(CONFIG_DEBUG_NET)) {
>  		ns->nb.notifier_call = netdev_debug_event;
>  		if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
> -							&ns->nn))
> +							&ns->nn)){
>  			ns->nb.notifier_call = NULL;
> +			goto err_unregister_netdev;

Hi Daniel, Jakub, all,

This will result in this function returning err.
But here err is set to 0, wheras it seems it
should be set to a negative error value.

Flagged by Smatch.

> +		}
>  	}
>  
> +	err = nsim_psp_init(ns);
> +	if (err)
> +		goto err_unregister_notifier;
> +
>  	return 0;
>  
> +err_unregister_notifier:
> +	if (ns->nb.notifier_call)
> +		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
> +						      &ns->nn);
> +err_unregister_netdev:
> +	rtnl_lock();
> +	peer = rtnl_dereference(ns->peer);
> +	if (peer)
> +		RCU_INIT_POINTER(peer->peer, NULL);
> +	RCU_INIT_POINTER(ns->peer, NULL);
> +	unregister_netdevice(ns->netdev);
>  err_ipsec_teardown:
>  	nsim_ipsec_teardown(ns);
>  	nsim_macsec_teardown(ns);

...

