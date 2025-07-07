Return-Path: <netdev+bounces-204526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9FAAFB09B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35197A20DC
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B46C288C35;
	Mon,  7 Jul 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6NRB7S8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB01F8755;
	Mon,  7 Jul 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751882492; cv=none; b=Wp3B4M6iCSl3dVIqkto9mwTtKwye6vcM1gCB7V7Fs0P89kU1rrGj/Gt466fVZXuv4zRi0mmFqK7TBH7DE321yIDtwGpgb16f7KdX59JeWb3l6VHNkI8f7qH0wB4K++5UOTT5sRvHOHmolQcxEmumSgF073LjvikJgXBoyXJZhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751882492; c=relaxed/simple;
	bh=LrbLvzvF6gmWIWOl/u5715b2a2XljRasgW9tuQ0jM6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQcBW/sNuDpSnsFFAdb3XNoAth+9sUHcGeMYl7mOqjS+o3T39z6owG5hRP5HRoy3X/HJtkrZe7MuoQfHjZ9YMVQD++cDkRfm8qjX7lYckGDoOfKiI5Y0eKbuMjt27STq7eVC5cb7ZhbAbhKn8QB/J4Wu70mj/6J1EWkFm+b02ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6NRB7S8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181DCC4CEE3;
	Mon,  7 Jul 2025 10:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751882490;
	bh=LrbLvzvF6gmWIWOl/u5715b2a2XljRasgW9tuQ0jM6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6NRB7S8gi/pE+s4x+hbM9kCMnDJbR3mkeGKx8D65z8RIF9O/zQMzDaF9fKX2lZe5
	 Nd0DpOG0gitZdCYiaqF1JNSqnOZ5KgaDUP3UqsA9MhbPpJd4J6jWznNxbPwjGew77M
	 2+2tTI1brE2/H97GiNnLhgMhPy6DOzkvLNMZeNNdjXm9f32tnILnNwf90kIcCXoFlu
	 VUupgU0UWvQsG9GqD9iFLY/+AbbhxD2252FQtSr1zJ8M1xYhxN0M+/jCQz30+VIqQ+
	 jp/3pGkDcE+M9uDE4o9E+mIrIGYImdlp9Y0RI7xKh1bPXEfXNroQ1BOhfFc9e3fSvc
	 4qCcaMf4Trtnw==
Date: Mon, 7 Jul 2025 11:01:24 +0100
From: Simon Horman <horms@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: spacemit: Add K1 Ethernet MAC
Message-ID: <20250707100124.GC89747@horms.kernel.org>
References: <20250703-net-k1-emac-v4-0-686d09c4cfa8@iscas.ac.cn>
 <20250703-net-k1-emac-v4-2-686d09c4cfa8@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-net-k1-emac-v4-2-686d09c4cfa8@iscas.ac.cn>

On Thu, Jul 03, 2025 at 05:42:03PM +0800, Vivian Wang wrote:
> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
> that only superficially resembles some other embedded MACs. SpacemiT
> refers to them as "EMAC", so let's just call the driver "k1_emac".
> 
> This driver is based on "k1x-emac" in the same directory in the vendor's
> tree [1]. Some debugging tunables have been fixed to vendor-recommended
> defaults, and PTP support is not included yet.
> 
> [1]: https://github.com/spacemit-com/linux-k1x
> 
> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

...

> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c

...

> +/**
> + * struct emac_desc_ring - Software-side information for one descriptor ring
> + * Same struture used for both RX and TX

nit: structure

> + * @desc_addr: Virtual address to the descriptor ring memory
> + * @desc_dma_addr: DMA address of the descriptor ring
> + * @total_size: Size of ring in bytes
> + * @total_cnt: Number of descriptors
> + * @head: Next descriptor to associate a buffer with
> + * @tail: Next descriptor to check status bit
> + * @rx_desc_buf: Array of descriptors for RX
> + * @tx_desc_buf: Array of descriptors for TX, with max of two buffers each
> + */

...

> +static void emac_set_mac_addr(struct emac_priv *priv, const unsigned char *addr)
> +{
> +	emac_wr(priv, MAC_ADDRESS1_HIGH, ((addr[1] << 8) | addr[0]));

nit: no need for inner parentheses here,
     the order of operations is on your side

	emac_wr(priv, MAC_ADDRESS1_HIGH, addr[1] << 8 | addr[0]);

> +	emac_wr(priv, MAC_ADDRESS1_MED, ((addr[3] << 8) | addr[2]));
> +	emac_wr(priv, MAC_ADDRESS1_LOW, ((addr[5] << 8) | addr[4]));
> +}

...

> +static int emac_rx_frame_status(struct emac_priv *priv, struct emac_desc *desc)
> +{
> +	/* Drop if not last descriptor */
> +	if (!(desc->desc0 & RX_DESC_0_LAST_DESCRIPTOR)) {
> +		netdev_dbg(priv->ndev, "RX not last descriptor\n");

Unless I am mistaken these logs can occur on the basis of user
(Network packet) input. If so, I think rate limited debug
messages are more appropriate here and below.

> +		return RX_FRAME_DISCARD;
> +	}
> +
> +	if (desc->desc0 & RX_DESC_0_FRAME_RUNT) {
> +		netdev_dbg(priv->ndev, "RX runt frame\n");
> +		return RX_FRAME_DISCARD;
> +	}
> +
> +	if (desc->desc0 & RX_DESC_0_FRAME_CRC_ERR) {
> +		netdev_dbg(priv->ndev, "RX frame CRC error\n");
> +		return RX_FRAME_DISCARD;
> +	}
> +
> +	if (desc->desc0 & RX_DESC_0_FRAME_MAX_LEN_ERR) {
> +		netdev_dbg(priv->ndev, "RX frame exceeds max length\n");
> +		return RX_FRAME_DISCARD;
> +	}
> +
> +	if (desc->desc0 & RX_DESC_0_FRAME_JABBER_ERR) {
> +		netdev_dbg(priv->ndev, "RX frame jabber error\n");
> +		return RX_FRAME_DISCARD;
> +	}
> +
> +	if (desc->desc0 & RX_DESC_0_FRAME_LENGTH_ERR) {
> +		netdev_dbg(priv->ndev, "RX frame length error\n");
> +		return RX_FRAME_DISCARD;
> +	}
> +
> +	if (rx_frame_len(desc) <= ETH_FCS_LEN ||
> +	    rx_frame_len(desc) > priv->dma_buf_sz) {
> +		netdev_dbg(priv->ndev, "RX frame length unacceptable\n");
> +		return RX_FRAME_DISCARD;
> +	}
> +	return RX_FRAME_OK;
> +}

...

> +static int emac_resume(struct device *dev)
> +{
> +	struct emac_priv *priv = dev_get_drvdata(dev);
> +	struct net_device *ndev = priv->ndev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->bus_clk);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!netif_running(ndev))
> +		return 0;
> +
> +	ret = emac_open(ndev);
> +	if (ret)

Smatch flags that priv->bus_clk resources are leaked here, and I agree.

> +		return ret;
> +
> +	netif_device_attach(ndev);
> +	return 0;
> +}

I would suggest addressing that like this.
(Compile tested only!)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 6158e776bc67..ebd02ec2bb01 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -1843,10 +1843,14 @@ static int emac_resume(struct device *dev)
 
 	ret = emac_open(ndev);
 	if (ret)
-		return ret;
+		goto err_clk_disable_unprepare;
 
 	netif_device_attach(ndev);
 	return 0;
+
+err_clk_disable_unprepare:
+	clk_disable_unprepare(priv->bus_clk);
+	return ret;
 }
 
 static int emac_suspend(struct device *dev)

...

> diff --git a/drivers/net/ethernet/spacemit/k1_emac.h b/drivers/net/ethernet/spacemit/k1_emac.h

...

> +struct emac_hw_stats {
> +	u32 tx_ok_pkts;
> +	u32 tx_total_pkts;
> +	u32 tx_ok_bytes;
> +	u32 tx_err_pkts;
> +	u32 tx_singleclsn_pkts;
> +	u32 tx_multiclsn_pkts;
> +	u32 tx_lateclsn_pkts;
> +	u32 tx_excessclsn_pkts;
> +	u32 tx_unicast_pkts;
> +	u32 tx_multicast_pkts;
> +	u32 tx_broadcast_pkts;
> +	u32 tx_pause_pkts;
> +	u32 rx_ok_pkts;
> +	u32 rx_total_pkts;
> +	u32 rx_crc_err_pkts;
> +	u32 rx_align_err_pkts;
> +	u32 rx_err_total_pkts;
> +	u32 rx_ok_bytes;
> +	u32 rx_total_bytes;
> +	u32 rx_unicast_pkts;
> +	u32 rx_multicast_pkts;
> +	u32 rx_broadcast_pkts;
> +	u32 rx_pause_pkts;
> +	u32 rx_len_err_pkts;
> +	u32 rx_len_undersize_pkts;
> +	u32 rx_len_oversize_pkts;
> +	u32 rx_len_fragment_pkts;
> +	u32 rx_len_jabber_pkts;
> +	u32 rx_64_pkts;
> +	u32 rx_65_127_pkts;
> +	u32 rx_128_255_pkts;
> +	u32 rx_256_511_pkts;
> +	u32 rx_512_1023_pkts;
> +	u32 rx_1024_1518_pkts;
> +	u32 rx_1519_plus_pkts;
> +	u32 rx_drp_fifo_full_pkts;
> +	u32 rx_truncate_fifo_full_pkts;
> +};

Many of the stats above appear to cover stats covered by struct
rtnl_link_stats64, ethtool_pause_stats, struct ethtool_rmon_stats, and
possibly others standardised in ethtool.h. Please only report standard
counters using standard mechanisms. And only use get_ethtool_stats to
report non-standard counters.

Link: https://www.kernel.org/doc/html/v6.16-rc4/networking/statistics.html#notes-for-driver-authors

...

-- 
pw-bot: changes-requested

