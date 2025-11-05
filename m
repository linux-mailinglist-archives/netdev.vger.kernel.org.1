Return-Path: <netdev+bounces-235677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AACC33AE1
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A9F3B4BE9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD74228DC4;
	Wed,  5 Nov 2025 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9BJyI5E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D6149C6F
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306659; cv=none; b=IObJcNLeyjYVA+e9UjmfZwVc+1fV8hXa3K7KaGSuCd/FJWOID8lJKbk2NppLkCnpDySTrLHxzd5a/M3lJdjHDW3Uszi6Bv9I9/tlSowCg+XePtlTV5zCObePbuGSUNRZ+YSTZtm1tM+vcceJHQry33brW1vemZVk3YvxjLBFE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306659; c=relaxed/simple;
	bh=IcyU0Yp3oCClfFclJKfCJuSEiNNqeKLe/tfJ66F7OEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUEhGNl0kpWzPR8k5oXRVg51/WL2ii0IGklr2ajl3YjOJPl0BHMLz0YPqP0bz3YWmQhV+6Ac5YFM6IxT3gJuNus93LZdOg8on6rmXzoVhLho6SN/oQlHt2Hklnt7YnfgNiCj4o2CI9j9+OvUyOeWDBFSt8O2/5Yxf++T6lV8/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9BJyI5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E869C116B1;
	Wed,  5 Nov 2025 01:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306659;
	bh=IcyU0Yp3oCClfFclJKfCJuSEiNNqeKLe/tfJ66F7OEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K9BJyI5E6azayMhVSFx+KbOQ7Wfjay1941Ds+NWc+9bDp+iEis1z5UyMYkZVKT74j
	 jKHBhV/9NKGAw5igjRhf4Gd2+/Y3zWLCpXGvDeHq76mZ5SsqVTPU+UkWc6gdkPbgg3
	 +rqwFSc8IYbVEF6I17/Fs2FinQZ2AjmqU0y3NReXb0Jmql5oySWwoq75lioJZ2xNjP
	 JHmP244Wf9Wg3vepxMjhSyOPPx4qWGELwP33QoUzVQ6OD7f6qC3xFh2K34Pcd+u76S
	 b3ce/A9bKJSoIE1y2mB5Gt5Ztpg09+aWEBDDd9oxu02meA2JgVFg4/7D7RYU/pvTQ3
	 vLFqOEEFiMWzQ==
Date: Tue, 4 Nov 2025 17:37:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Manish Chopra <manishc@marvell.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] bnx2x: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251104173737.3f655692@kernel.org>
In-Reply-To: <20251103150952.3538205-2-vadim.fedorenko@linux.dev>
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
	<20251103150952.3538205-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 15:09:46 +0000 Vadim Fedorenko wrote:
> -static int bnx2x_hwtstamp_ioctl(struct bnx2x *bp, struct ifreq *ifr)
> +static int bnx2x_hwtstamp_set(struct net_device *dev,
> +			      struct kernel_hwtstamp_config *config,
> +			      struct netlink_ext_ack *extack)
>  {
> -	struct hwtstamp_config config;
> +	struct bnx2x *bp = netdev_priv(dev);
>  	int rc;
>  
> -	DP(BNX2X_MSG_PTP, "HWTSTAMP IOCTL called\n");
> -
> -	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
> -		return -EFAULT;
> +	DP(BNX2X_MSG_PTP, "HWTSTAMP SET called\n");
>  
>  	DP(BNX2X_MSG_PTP, "Requested tx_type: %d, requested rx_filters = %d\n",
> -	   config.tx_type, config.rx_filter);
> +	   config->tx_type, config->rx_filter);
>  
>  	bp->hwtstamp_ioctl_called = true;
> -	bp->tx_type = config.tx_type;
> -	bp->rx_filter = config.rx_filter;
> +	bp->tx_type = config->tx_type;
> +	bp->rx_filter = config->rx_filter;
>  
>  	rc = bnx2x_configure_ptp_filters(bp);

bnx2x_configure_ptp_filters() may return -ERANGE if settings were not applied.
This may already be semi-broken but with the get in place we will make
it even worse. 

>  	if (rc)
>  		return rc;
>  
> -	config.rx_filter = bp->rx_filter;
> +	config->rx_filter = bp->rx_filter;
> +
> +	return 0;
> +}
>  
> -	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
> -		-EFAULT : 0;
> +static int bnx2x_hwtstamp_get(struct net_device *dev,
> +			      struct kernel_hwtstamp_config *config)
> +{
> +	struct bnx2x *bp = netdev_priv(dev);
> +
> +	config->rx_filter = bp->rx_filter;
> +	config->tx_type = bp->tx_type;
> +
> +	return 0;
>  }

