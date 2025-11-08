Return-Path: <netdev+bounces-236991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F14AC42EE4
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 16:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565BF3AF8FB
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D6145329;
	Sat,  8 Nov 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o99wbess"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113518C2C
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762616876; cv=none; b=SRtJ67fAltLrIhMWkM3Fv5Ponlz49VTQABjnLjlrgXyjJ5atcr7/CzpR7LVAmdX1g4Fp+TvLjjtlXYu4tBT0QK6fbn2iAK0kdNRAZrMKsWz6atlhv8H0MU4o+1RorbOQ8NKDZiAjKOAzvNXlwsTJiINqc/vvy3J4KpRfWqLLjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762616876; c=relaxed/simple;
	bh=ZSxs/LDbsurYA7+OWrzlisCgMYmIxxK4i0JdWmWOy/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiNsuXGqdf/0UwiTIyBjifyoBj+ePZPzWi0x4wn1zqOsf23pIZbqehxBVYrVsRsZ98brfG7601WP6rj1XN5MZ/zQsxvpxNo9+E/NTxAuP5OWfExBzGoyOTw0lUflkUHvq9jTrfYOKaYt5jqxFMIw4Ex91AbS3YcIVQ6DNYLC64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o99wbess; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1B4C19423;
	Sat,  8 Nov 2025 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762616875;
	bh=ZSxs/LDbsurYA7+OWrzlisCgMYmIxxK4i0JdWmWOy/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o99wbessXBNcBPl19q5N/JtfaUhL56a0QU/7aCTnmQmWiVmXC9jj53/U6ZuiQ+u1M
	 TRVSsORle5Q2z4MWfDoa4kPdDJQd/5cbpMQoB8Rj/JJ71+EtGWc34DUTqsgjbWWBme
	 E+0E6v3xsPK8Qjjzmu+Q6wEvMhVF+9StGravloshh6IbjU1GJoptQMOigl6cXSGfaP
	 cINWx8CvYT+9kPgVwAoN/va7wvoXf0w/Tu7n6hiLgS7NJVDWeLWiqxtGlA03DvhAQ0
	 VhdjeobEtBAZsIFbaTqoO0+9B/piLNvvvcXVtarj5Q5UgFSSjoZesbLTWrGoOQFAL1
	 tTL3Fr9y2Hadw==
Date: Sat, 8 Nov 2025 15:47:50 +0000
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v11 3/5] eea: probe the netdevice and create
 adminq
Message-ID: <aQ9mJvir26jPv_WC@horms.kernel.org>
References: <20251107054955.16236-1-xuanzhuo@linux.alibaba.com>
 <20251107054955.16236-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107054955.16236-4-xuanzhuo@linux.alibaba.com>

On Fri, Nov 07, 2025 at 01:49:53PM +0800, Xuan Zhuo wrote:

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c

...

> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
> +	struct eea_aq_cfg *cfg;
> +	int err;
> +	u32 mtu;
> +
> +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	err = eea_adminq_query_cfg(enet, cfg);
> +	if (err)
> +		goto err_free;
> +
> +	mtu = le16_to_cpu(cfg->mtu);
> +	if (mtu < ETH_MIN_MTU) {
> +		dev_err(edev->dma_dev, "The device gave us an invalid MTU. Here we can only exit the initialization. %d < %d",
> +			mtu, ETH_MIN_MTU);
> +		err = -EINVAL;
> +		goto err_free;
> +	}
> +
> +	eea_update_cfg(enet, edev, cfg);
> +
> +	netdev->priv_flags |= IFF_UNICAST_FLT;
> +	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +
> +	netdev->hw_features |= NETIF_F_HW_CSUM;
> +	netdev->hw_features |= NETIF_F_GRO_HW;
> +	netdev->hw_features |= NETIF_F_SG;
> +	netdev->hw_features |= NETIF_F_TSO;
> +	netdev->hw_features |= NETIF_F_TSO_ECN;
> +	netdev->hw_features |= NETIF_F_TSO6;
> +	netdev->hw_features |= NETIF_F_GSO_UDP_L4;
> +
> +	netdev->features |= NETIF_F_HIGHDMA;
> +	netdev->features |= NETIF_F_HW_CSUM;
> +	netdev->features |= NETIF_F_SG;
> +	netdev->features |= NETIF_F_GSO_ROBUST;
> +	netdev->features |= netdev->hw_features & NETIF_F_ALL_TSO;
> +	netdev->features |= NETIF_F_RXCSUM;
> +	netdev->features |= NETIF_F_GRO_HW;
> +
> +	netdev->vlan_features = netdev->features;
> +
> +	eth_hw_addr_set(netdev, cfg->mac);
> +
> +	enet->speed = SPEED_UNKNOWN;
> +	enet->duplex = DUPLEX_UNKNOWN;
> +
> +	netdev->min_mtu = ETH_MIN_MTU;
> +
> +	netdev->mtu = mtu;
> +
> +	/* If jumbo frames are already enabled, then the returned MTU will be a
> +	 * jumbo MTU, and the driver will automatically enable jumbo frame
> +	 * support by default.
> +	 */
> +	netdev->max_mtu = mtu;
> +
> +	netif_carrier_on(netdev);
> +
> +err_free:
> +	kfree(cfg);
> +
> +	return 0;

This always returns 0, even on error.

If there is no error, then err will be 0. Otherwise, err will be a negative
error value. So I think this can by addressed by simply replacing the
line above with:

	return err;

> +}

...

