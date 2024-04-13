Return-Path: <netdev+bounces-87595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A58A3A7D
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0ABB215D7
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A060101D5;
	Sat, 13 Apr 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI2iKAqN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4414F62;
	Sat, 13 Apr 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975207; cv=none; b=fqp9sU0sug9Zq7eD25y/u8QVr9CGxiKjsGqTS0cgZLlnrk9OZ46h15dHd8GAFYlebA+fg49YRnNoDfsAYi4ROz0ptRgqrHLex/abyTngCv20bIswagrY/kMWLG88uVtPi2W2LivCw+4ISPg1NGkkMLbM6lyYQI53qSbhnqh3EWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975207; c=relaxed/simple;
	bh=F6BtNr0IulJ4IzMkN0vWMk6P1R8R8sgq5wERyywtbAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUHtmDlQhD84F3JBzITPZ8d7ENABskJ9OKbkXGLSImaf+FJ9QWRIQbPjnsi6Rj2NRr0puCD56/UDf/S/YZYxSU54qHLCRkevyC0svkEA26GWEJr5V1g0RKmx3CyWaYMC3b5mt2pyyUHyuJQ9zREa22JJY7jfGSEFspHJtJ1RZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI2iKAqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6316FC113CC;
	Sat, 13 Apr 2024 02:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712975206;
	bh=F6BtNr0IulJ4IzMkN0vWMk6P1R8R8sgq5wERyywtbAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sI2iKAqN7AolETHEG9RKURiIdsV5NZrxyD1PyI8enH0JNTEq/BU0xsCZmly01Wzaa
	 KwCJ9m3GFKgOfLw52ntS5lQsAh/osKS5/Ch7/t/xqeKKpF7n/VbOr2aVQSP7JF+5c/
	 SsMJWcfWNMi8uqVwu7IN9xRgNNhNXdQd9yEdKFx+kUdG3v4t0ItDoxArbQGiaJHerj
	 XlTineswqWwK3htHITnPKRw01GdQVhtFr7w1iK72FeT+ZcQwCfI2HrEgGZ722oGNtK
	 knjDkjhYlwKACbFQ70LXkAuPAjKKEjz5S7szE0cdRyDkSMb75Q5yvxDhB6a6Ls2fo2
	 HOPSPZs0uX+4w==
Date: Fri, 12 Apr 2024 19:26:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240412192645.2c0b745b@kernel.org>
In-Reply-To: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
	<1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 22:12:29 +0800 Heng Qi wrote:
> +#include <linux/dim.h>
>  #include <net/net_trackers.h>
>  #include <net/net_debug.h>
>  #include <net/dropreason-core.h>
> @@ -1649,6 +1650,9 @@ struct net_device_ops {
>   * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
>   *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
>   *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
> + * @IFF_PROFILE_USEC: device supports adjusting the DIM profile's usec field
> + * @IFF_PROFILE_PKTS: device supports adjusting the DIM profile's pkts field
> + * @IFF_PROFILE_COMPS: device supports adjusting the DIM profile's comps field
>   */
>  enum netdev_priv_flags {
>  	IFF_802_1Q_VLAN			= 1<<0,
> @@ -1685,6 +1689,9 @@ enum netdev_priv_flags {
>  	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
>  	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
>  	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
> +	IFF_PROFILE_USEC		= BIT_ULL(34),
> +	IFF_PROFILE_PKTS		= BIT_ULL(35),
> +	IFF_PROFILE_COMPS		= BIT_ULL(36),
>  };
>  
>  #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
> @@ -2400,6 +2407,14 @@ struct net_device {
>  	/** @page_pools: page pools created for this netdevice */
>  	struct hlist_head	page_pools;
>  #endif
> +
> +#if IS_ENABLED(CONFIG_DIMLIB)
> +	/* DIM profile lists for different dim cq modes */
> +	struct dim_cq_moder *rx_eqe_profile;
> +	struct dim_cq_moder *rx_cqe_profile;
> +	struct dim_cq_moder *tx_eqe_profile;
> +	struct dim_cq_moder *tx_cqe_profile;
> +#endif

just one pointer to a new wrapper struct, put the pointers and a flag
field in there.

netdevice.h is included by thousands of files, please use a forward
declaration for the type and avoid including dim.h

