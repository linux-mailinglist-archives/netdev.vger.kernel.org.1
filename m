Return-Path: <netdev+bounces-183060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C6A8ACC1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A860B1733FE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520E1CAA98;
	Wed, 16 Apr 2025 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdoxO4ep"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B941CAA97
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763612; cv=none; b=bciXaUSxn2DwyOEQtoWVHIMPRv2Z58rBt5z7auAQ650VcEDnWxblZ92ijEAhY3pTto+W5+lloxZo0g/g8Vk865ILIWm4RHHmQH4w62oPjQUhGSYPDNzPTdQ978JWBklUXLvvHrctzoNZErzOiBr8hr8nwN5wvOpNPKipcb2rWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763612; c=relaxed/simple;
	bh=ZgT42BknCq4aaMIkQZhsuwcX8WBgz23UplchQzscXe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuQiyWgbKXG+r95sv+ItwpQj40ivD76B015zWQVEXuUgeEZ4z6NaJNcsrdUs67rI7f40Gm+OIGzbgAP1VJqjX5Jk9dOXPrHQKJo6LiQ46LnP9qLyFi0iOzRVSz27gsXHXIX0COIDtofeZhLtZDDHaUyz+SEM1EAreJQljcPKl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdoxO4ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D411AC4CEE7;
	Wed, 16 Apr 2025 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744763611;
	bh=ZgT42BknCq4aaMIkQZhsuwcX8WBgz23UplchQzscXe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UdoxO4epqAqtxFgup7Wc07cKsiTAxRHXsgcSLeXF1uB6wJn0RQ3OsTjFYLdRcL+H6
	 u7lQfgvlobo3SRrGVxpf6ar/B5o6XlKLR+G8oY2CsYaHxbJ6bOgNjWLLGIppMOmkjf
	 8fq2S6CPa17+ZIY/bpRx/m5srejfxFeDffn8ub56YGxDu6CiX8Z4umJq00tCDol1bx
	 6ysQBDHKc3voDCtGvQ137r6WZD3ucm3HkNwgKwoIpBEZkU0wZxbg/LMdVMkEmdkqQB
	 WuyomTgh8cJZbse0vBXZp9i0vO8vR3yRfSrNEFA5iQgDTHPcITOTTBpVbP51V9Knex
	 r+w7Hx8Kzmzaw==
Date: Tue, 15 Apr 2025 17:33:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 dlemoal@kernel.org, jdamato@fastly.com, saikrishnag@marvell.com,
 vadim.fedorenko@linux.dev, przemyslaw.kitszel@intel.com,
 ecree.xilinx@gmail.com, rmk+kernel@armlinux.org.uk,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 1/2] net: txgbe: Support to set UDP tunnel
 port
Message-ID: <20250415173329.27f83c52@kernel.org>
In-Reply-To: <20250414091022.383328-2-jiawenwu@trustnetic.com>
References: <20250414091022.383328-1-jiawenwu@trustnetic.com>
	<20250414091022.383328-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 17:10:21 +0800 Jiawen Wu wrote:
> +	udp_tunnel_nic_reset_ntf(netdev);

you issue the reset here, without clearing the ports...

>  	return 0;
>  
>  err_free_irq:
> @@ -537,6 +540,87 @@ void txgbe_do_reset(struct net_device *netdev)
>  		txgbe_reset(wx);
>  }
>  
> +static int txgbe_udp_tunnel_set(struct net_device *dev, unsigned int table,
> +				unsigned int entry, struct udp_tunnel_info *ti)
> +{
> +	struct wx *wx = netdev_priv(dev);
> +	struct txgbe *txgbe = wx->priv;
> +
> +	switch (ti->type) {
> +	case UDP_TUNNEL_TYPE_VXLAN:
> +		if (txgbe->vxlan_port == ti->port)

then you ignore the set if the port is already the same.

Why do you need the udp_tunnel_nic_reset_ntf() call?
Read the kdoc on that function.
It doesn't seem like your NIC loses the state.

> +			break;
> +
> +		if (txgbe->vxlan_port) {
> +			wx_err(wx, "VXLAN port %d set, not adding port %d\n",
> +			       txgbe->vxlan_port, ti->port);
> +			return -EINVAL;
> +		}

Why...

> +		txgbe->vxlan_port = ti->port;
> +		wr32(wx, TXGBE_CFG_VXLAN, ntohs(ti->port));
> +		break;

> +static const struct udp_tunnel_nic_info txgbe_udp_tunnels = {
> +	.set_port	= txgbe_udp_tunnel_set,
> +	.unset_port	= txgbe_udp_tunnel_unset,
> +	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP,

Where do the callbacks sleep?
-- 
pw-bot: cr

