Return-Path: <netdev+bounces-50173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0117F4C4C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFC71C2090A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365E4D123;
	Wed, 22 Nov 2023 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="adloZ5Pl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E59F
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eTAjHOJrvssbB1VdWz205dBOu/W0NN76NDhT2SV9zKs=; b=adloZ5PlDaQnnY0jlh+Z8zv/ZQ
	e90b7EdeSPEGqV6YowiYq9m+s9fbsdeOUJjJtNexrCpTkVNlmJ8n5vzrbcR33RFttHhvr9mJfhGSn
	1nz2Co44pqQOSH96g8ye5g/2oGh5AkSTcWMCV+LgS8r++jbD7DwipVkIjKVwoHjG4Hx8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5q1U-000tC3-Io; Wed, 22 Nov 2023 17:24:20 +0100
Date: Wed, 22 Nov 2023 17:24:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 2/5] net: wangxun: add ethtool_ops for ring
 parameters
Message-ID: <4a36b46d-3f71-430f-8158-da58769ae52a@lunn.ch>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
 <20231122102226.986265-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122102226.986265-3-jiawenwu@trustnetic.com>

> +int wx_set_ring(struct wx *wx, u32 new_tx_count, u32 new_rx_count)
> +{
> +	struct wx_ring *temp_ring;
> +	int i, err = 0;
> +
> +	/* allocate temporary buffer to store rings in */
> +	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
> +	temp_ring = vmalloc(i * sizeof(struct wx_ring));

So it is O.K. for the pages to be scattered around the physical
address space, not contiguous. Does this memory ever get passed to the
hardware?

> +static int ngbe_set_ringparam(struct net_device *netdev,
> +			      struct ethtool_ringparam *ring,
> +			      struct kernel_ethtool_ringparam *kernel_ring,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +	u32 new_rx_count, new_tx_count;
> +	int i, err = 0;
> +
> +	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> +		return -EINVAL;

EOPNOTSUP would be better, to indicate you don't support it, not that
it is invalid.

> +	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> +		return -EINVAL;

Same here.

> +
> +	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
> +	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
> +
> +	new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
> +	new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
> +
> +	if (new_tx_count == wx->tx_ring_count &&
> +	    new_rx_count == wx->rx_ring_count)
> +		return 0;
> +
> +	if (!netif_running(wx->netdev)) {
> +		for (i = 0; i < wx->num_tx_queues; i++)
> +			wx->tx_ring[i]->count = new_tx_count;
> +		for (i = 0; i < wx->num_rx_queues; i++)
> +			wx->rx_ring[i]->count = new_rx_count;
> +		wx->tx_ring_count = new_tx_count;
> +		wx->rx_ring_count = new_rx_count;
> +
> +		return 0;
> +	}
> +
> +	txgbe_down(wx);
> +
> +	err = wx_set_ring(wx, new_tx_count, new_rx_count);
> +
> +	txgbe_up(wx);
> +
> +	return err;

Could most of this be moved into the library? It looks pretty similar
for the two devices.

    Andrew

