Return-Path: <netdev+bounces-216244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF1B32B9C
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546A71BC6832
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3E31C5D7D;
	Sat, 23 Aug 2025 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZcwrU4cZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2412CD88;
	Sat, 23 Aug 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755976635; cv=none; b=bJ4PPtPvvlwhdO8c8hdh4gYpplTfMTJZyHCBGktEuivo5zNvH9O0rdf1NW94cTrKa4VT5wDWHaWAJPmThn9lRAfFMhVg0Oh0qwiCPodMIb0INCnEHDQbnWLsi5WzvhiEF7yCTqC4sW0a8GeP/KA8JxE7QlC9Mrq/R7/wdQwEakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755976635; c=relaxed/simple;
	bh=s340WqMcJU7AxJr57RiSkbdE9QeRabzwg4PQtuLfwGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGk/itc/i60fs1E9g1OUCN1HO280fqSpPBPmSR+4yGD6NVTT3+2SzEYv9SqY/0TYvxndxIMXN+JUieQjRF5RJL+4Ytl7IJVywL4B3tBej4LmRm/KTG0cb1siAwkBxg3uSm05r8WPaP2FvT5gsrwwXqNOJBYnw3R6RE6Fno1qSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZcwrU4cZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J08n4WogbNzRfDSeTlNnPcC0IJXZ9h3RTPxx2XMNT1Q=; b=ZcwrU4cZ3Xu3eBWbUSy/6b0Mo+
	u+jnJyItOtQc8OKnSCOWb1GgsL8Jkv08KF/cQYQrY3EZjIktmDtsz9UKpxAcdIUH/QnSkRxS5VWlV
	GeZxXZRGhqIdhYWvAUjjs2HOR/W/NV7VA2W5aviWkl3ocN41cSCKdj0m1IeNRihNrz28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uptjb-005mFu-EW; Sat, 23 Aug 2025 21:17:03 +0200
Date: Sat, 23 Aug 2025 21:17:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH v3 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Message-ID: <221027d6-a3b1-4608-8952-16ae512e63a5@lunn.ch>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-5-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823190110.1186960-5-shenwei.wang@nxp.com>

> +static int fec_change_mtu(struct net_device *ndev, int new_mtu)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	int order, done;
> +
> +	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> +	if (fep->pagepool_order == order) {
> +		WRITE_ONCE(ndev->mtu, new_mtu);
> +		return 0;
> +	}
> +
> +	fep->pagepool_order = order;
> +	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_ENET_XDP_HEADROOM
> +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	if (!netif_running(ndev)) {
> +		WRITE_ONCE(ndev->mtu, new_mtu);
> +		return 0;
> +	}
> +
> +	/* Stop TX/RX and free the buffers */
> +	napi_disable(&fep->napi);
> +	netif_tx_disable(ndev);
> +	read_poll_timeout(fec_enet_rx_napi, done, (done == 0),
> +			  10, 1000, false, &fep->napi, 10);
> +	fec_stop(ndev);
> +	fec_enet_free_buffers(ndev);
> +
> +	WRITE_ONCE(ndev->mtu, new_mtu);
> +
> +	/* Create the pagepool according the new mtu */
> +	if (fec_enet_alloc_buffers(ndev) < 0)
> +		return -ENOMEM;
> +

This is the wrong order. You need to first allocate the new buffers
and then free the old ones. If the allocation fails, you still have a
working interface using the smaller buffers, and the MTU change just
returns -ENOMEM. If you free the buffers and the allocation of the new
buffers fail, you interface is dead, because it has no buffers.

	Andrew

