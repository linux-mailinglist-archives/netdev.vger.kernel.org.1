Return-Path: <netdev+bounces-287776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFEIKeEqBWo4TAIAu9opvQ
	(envelope-from <netdev+bounces-287776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:52:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632353CDE9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 922BC3017E6E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9792C3290B1;
	Thu, 14 May 2026 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXPUYEAK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528A3264CF;
	Thu, 14 May 2026 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723544; cv=none; b=dtKzh556nK/v2b0q0K1iiCiz3cUpchaVl0QbFH3sjVxpMKFh63hRTEkndTzPtoKMwz9gxJNKHuIp1V1eeTSxmHC5Xd0SaobCMZ/xyb1jufUcmTLt5p6aZBJjSdYgkREXrywih+UKI/upDgBPV48pVjv8HvcWP0XF5lBFTbD+DzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723544; c=relaxed/simple;
	bh=6pDgQjyeEBWiVFg+WVkREdLSXDvJhnpd2OuFfswe+9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvThdfGIPDRxt3Q/T2HVlnZPAFAm2MtU1IUYoOYbTHDDXHNGV9DOK20OCNFGsYl5AQnHxuEo4zHihjlJpU6Ax8/5uBnxKPFmbUZAVvpGNUZHntZNimschb56YOwRxeTIbAlT4my4/+R+gp7lAS++XwH4sjgR003ofrp+VW2hck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXPUYEAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6C3C19425;
	Thu, 14 May 2026 01:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723544;
	bh=6pDgQjyeEBWiVFg+WVkREdLSXDvJhnpd2OuFfswe+9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXPUYEAKLucuK2Ciw9f3xEQ2zn5oNhYnaL5rKpZWIR8GnQWYfDhgeSA+EM7+TwBUw
	 w+OZ/uamSE0Sy7i4mXZzPsq0atTgcNwPTCw3LutwMYNtuYDnchhyl72EUWBrCmYGUq
	 vv7XFngSwKk96OzTYfh16A0hT8kQ1syoWD2blvFub98z+ax5wCmuyYTDGi2Ouqcs4+
	 r82wyIYHkJ1qpp9+RMZR6ms63DQrvaJ5ceflpxLr9qz7cBSCAvESaTTzLh7aeuUfFU
	 UN0rHfgb0YsZTrEKEB0pioG91SJ2kkQhw0JATflkqndelnrRUClaCW6kYncZMQRE/Q
	 Y9zw2anKBoACw==
From: Jakub Kicinski <kuba@kernel.org>
To: linux@fw-web.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	nbd@nbd.name,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux@armlinux.org.uk,
	mason-cw.chang@mediatek.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next v8 2/3] net: ethernet: mtk_eth_soc: Add RSS support
Date: Wed, 13 May 2026 18:52:20 -0700
Message-ID: <20260514015221.521091-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509190938.169290-3-linux@fw-web.de>
References: <20260509190938.169290-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4632353CDE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287776-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nbd.name,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk,mediatek.com,vger.kernel.org,makrotopia.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: ethernet: mtk_eth_soc: Add RSS support

This commit adds Receive Side Scaling support for the mtk_eth_soc driver,
enabling up to four RX rings on MT7988 with ethtool -x and
--set-rxfh-indir support. It also reworks the RX NAPI / IRQ handling
into per-ring instances and renames eth->irq[] to eth->irq_fe[] /
eth->irq_pdma[].

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c

[ ... ]

> @@ -2235,16 +2199,15 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
[ ... ]
> @@ -2436,7 +2399,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  		 * we continue
>  		 */
>  		wmb();
> -		mtk_update_rx_cpu_idx(eth);
> +		mtk_update_rx_cpu_idx(eth, ring);
>  	}
>  
>  	eth->rx_packets += done;

[High]
With RSS enabled, up to MTK_RX_NAPI_NUM (=4) NAPI instances can run
concurrently on different CPUs.  eth->rx_packets, eth->rx_bytes (here)
and eth->rx_events (incremented in mtk_handle_irq_rx with IRQF_SHARED)
are plain u32 fields with no atomic, no spinlock, and no per-CPU
storage:

	eth->rx_packets += done;
	eth->rx_bytes += bytes;
	dim_update_sample(eth->rx_events, eth->rx_packets, eth->rx_bytes,
			  &dim_sample);
	net_dim(&eth->rx_dim, &dim_sample);

Pre-patch a single rx_napi serialised these accesses.  Are these
unsynchronised cross-CPU updates intentional?  The corrupted values
feed dim_update_sample() / net_dim() which drives interrupt
moderation, and eth->rx_dim is a single struct dim shared across all
RX NAPIs.

> @@ -2645,7 +2608,9 @@ static int mtk_napi_tx(struct napi_struct *napi, int budget)
>  
>  static int mtk_napi_rx(struct napi_struct *napi, int budget)
>  {
> -	struct mtk_eth *eth = container_of(napi, struct mtk_eth, rx_napi);
> +	struct mtk_napi *rx_napi = container_of(napi, struct mtk_napi, napi);
> +	struct mtk_eth *eth = rx_napi->eth;
> +	struct mtk_rx_ring *ring = rx_napi->rx_ring;
>  	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
>  	int rx_done_total = 0;

[Medium]
mtk_napi_rx() calls mtk_handle_status_irq(eth) on entry of every poll.
mtk_handle_status_irq() does an unprotected read / clear of
MTK_INT_STATUS2 and calls mtk_stats_update():

	status2 = mtk_r32(eth, MTK_INT_STATUS2);
	if (unlikely(status2 & (MTK_GDM1_AF | MTK_GDM2_AF))) {
		mtk_stats_update(eth);
		mtk_w32(eth, (MTK_GDM1_AF | MTK_GDM2_AF), MTK_INT_STATUS2);
	}

With multiple rx_napi instances polling on different CPUs, can a fresh
AF event arriving between the read and the write be silently dropped,
or stats be double-counted?  The per-MAC stats_lock taken inside
mtk_stats_update_mac does not synchronise the status read or the
clear.

[ ... ]

> @@ -3222,6 +3192,105 @@ static int mtk_hwlro_get_fdir_all(struct net_device *dev,
[ ... ]
> +static int mtk_rss_init(struct mtk_eth *eth)
> +{
> +	const struct mtk_soc_data *soc = eth->soc;
> +	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
> +	struct mtk_rss_params *rss_params = &eth->rss_params;
> +	u32 val;
> +	int i;
> +
> +	netdev_rss_key_fill(rss_params->hash_key, MTK_RSS_HASH_KEYSIZE);
> +
> +	for (i = 0; i < MTK_RSS_MAX_INDIRECTION_TABLE; i++)
> +		rss_params->indirection_table[i] = ethtool_rxfh_indir_default(i, eth->soc->rss_num);
> +
> +	if (soc->rx.desc_size == sizeof(struct mtk_rx_dma)) {
> +		/* Set RSS rings to PSE modes */
> +		for (i = 1; i <= MTK_HW_LRO_RING_NUM(eth); i++) {
> +			val = mtk_r32(eth, MTK_LRO_CTRL_DW2_CFG(reg_map, i));
> +			val |= MTK_RING_PSE_MODE;
> +			mtk_w32(eth, val, MTK_LRO_CTRL_DW2_CFG(reg_map, i));
> +		}
> +
> +		/* Enable non-lro multiple rx */
> +		val = mtk_r32(eth, reg_map->pdma.lro_ctrl_dw0);
> +		val |= MTK_NON_LRO_MULTI_EN;
> +		mtk_w32(eth, val, reg_map->pdma.lro_ctrl_dw0);
> +
> +		/* Enable RSS dly int supoort */
> +		val |= MTK_LRO_DLY_INT_EN;
> +		mtk_w32(eth, val, reg_map->pdma.lro_ctrl_dw0);
> +	}

[Medium]
Is this block reachable on any SoC?  mtk_rss_init() is only invoked
from mtk_dma_init() under MTK_HAS_CAPS(MTK_RSS).  Only mt7988_data
sets MTK_RSS in caps, and mt7988_data uses
rx.desc_size = sizeof(struct mtk_rx_dma_v2), not
sizeof(struct mtk_rx_dma).

If the PSE-mode / MTK_NON_LRO_MULTI_EN / MTK_LRO_DLY_INT_EN
programming is needed on MT7988, is it being silently skipped?  If it
was intended for mt7981 / mt7986, those SoCs never reach this path
because their caps lack MTK_RSS.

There is also a typo above: "RSS dly int supoort" -> "support".

[ ... ]

> +	/* Set perRSS GRP INT */
> +	mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_RSS_RING(1)),
> +		MTK_RX_DONE_INT(eth, MTK_RSS_RING(1)), reg_map->pdma.int_grp);

[ ... ]

> +
> +	return 0;
> +}

[ ... ]

> @@ -3312,6 +3381,17 @@ static int mtk_dma_init(struct mtk_eth *eth)
[ ... ]
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSS)) {
> +		for (i = 1; i < MTK_RX_RSS_NUM(eth); i++) {
> +			err = mtk_rx_alloc(eth, MTK_RSS_RING(i), MTK_RX_FLAGS_NORMAL);
> +			if (err)
> +				return err;
> +		}
> +		err = mtk_rss_init(eth);
> +		if (err)
> +			return err;
> +	}
> +

[ ... ]

> @@ -3437,14 +3523,36 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
>  	return 0;
>  }
>  
> -static irqreturn_t mtk_handle_irq_rx(int irq, void *_eth)
> +static int mtk_get_irqs_pdma(struct platform_device *pdev, struct mtk_eth *eth)
>  {
> -	struct mtk_eth *eth = _eth;
> +	char rxring[] = "pdma0";
> +	int i;
> +
> +	for (i = 0; i < MTK_PDMA_IRQ_NUM; i++) {
> +		rxring[4] = '0' + i;
> +		eth->irq_pdma[i] = platform_get_irq_byname(pdev, rxring);
> +		if (eth->irq_pdma[i] < 0)
> +			return eth->irq_pdma[i];
> +	}
> +
> +	return 0;
> +}

[High]
This loop demands all four pdma0..pdma3 IRQs whenever
MTK_HAS_CAPS(MTK_PDMA_INT) is set, but the same patch adds
MTK_PDMA_INT to MT7981_CAPS and MT7986_CAPS — SoCs which do not
have MTK_RSS.  On those SoCs only rx_napi[0] / pdma0 is ever
referenced (every pdma1..pdma3 use site is gated on
MTK_HAS_CAPS(MTK_RSS) in probe / open / stop / dma_init / dma_free).

Existing MT7981 / MT7986 device trees declare only fe1 / fe2.  Does
this turn into a probe-time -ENXIO failure for those boards?  Should
the call to mtk_get_irqs_pdma(), or at least the requests for
pdma1..pdma3, be folded under MTK_HAS_CAPS(MTK_RSS) so older DTs
continue to probe?

> +
> +static irqreturn_t mtk_handle_irq_rx(int irq, void *priv)
> +{
> +	struct mtk_napi *rx_napi = priv;
> +	struct mtk_eth *eth = rx_napi->eth;
> +	struct mtk_rx_ring *ring = rx_napi->rx_ring;
>  
>  	eth->rx_events++;
> -	if (likely(napi_schedule_prep(&eth->rx_napi))) {
> -		mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
> -		__napi_schedule(&eth->rx_napi);
> +	if (unlikely(!(mtk_r32(eth, eth->soc->reg_map->pdma.irq_status) &
> +		       mtk_r32(eth, eth->soc->reg_map->pdma.irq_mask) &
> +		       MTK_RX_DONE_INT(eth, ring->ring_no))))
> +		return IRQ_NONE;

[High]
Pre-patch mt7988_data set rx.irq_done_mask = MTK_RX_DONE_INT_V2 =
BIT(14).  Post-patch the per-soc field is removed and replaced with
MTK_RX_DONE_INT(eth, ring_no), which for V3 (mt7988) expands to
BIT(24 + ring_no), so MTK_RX_DONE_INT(eth, 0) is now BIT(24) instead
of BIT(14).

Is the bit number change intentional?  If MT7988 RX-done is actually
signalled on BIT(14), the new mask never matches, mtk_handle_irq_rx
returns IRQ_NONE, and RX traffic stalls.  If BIT(14) was wrong all
along, could the commit message describe the silent fix?  The patch
otherwise advertises only RSS.

[ ... ]

> @@ -3888,9 +4011,7 @@ static void mtk_dim_rx(struct work_struct *work)
[ ... ]
> -	val = mtk_r32(eth, reg_map->pdma.delay_irq);
> -	val &= MTK_PDMA_DELAY_TX_MASK;
> -	val |= MTK_PDMA_DELAY_RX_EN;
> +	val = MTK_PDMA_DELAY_RX_EN;
[ ... ]
> -	mtk_w32(eth, val, reg_map->pdma.delay_irq);
>  	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
> -		mtk_w32(eth, val, reg_map->qdma.delay_irq);
> +		mtk_m32(eth, MTK_PDMA_DELAY_TX_MASK,
> +			val << MTK_PDMA_DELAY_TX_PTIME_SHIFT, reg_map->qdma.delay_irq);
> +
> +	if (eth->soc->rx.desc_size == sizeof(struct mtk_rx_dma)) {
> +		mtk_m32(eth, MTK_PDMA_DELAY_RX_MASK, val, reg_map->pdma.delay_irq);
> +		mtk_w32(eth, val, reg_map->pdma.lro_rx1_dly_int);
> +		mtk_w32(eth, val, reg_map->pdma.lro_rx1_dly_int + 0x4);
> +		mtk_w32(eth, val, reg_map->pdma.lro_rx1_dly_int + 0x8);
> +	} else {
> +		val = val | (val << MTK_PDMA_DELAY_RX_RING_SHIFT);
> +		mtk_w32(eth, val, reg_map->pdma.rx_delay_irq);
> +	}

[Critical]
The new branch is gated on rx.desc_size, not on a capability bit.
rt5350_data (MT7628) has rx.desc_size = sizeof(struct mtk_rx_dma) and
uses mt7628_reg_map, which does not initialise lro_rx1_dly_int (it
defaults to 0).

mtk_hw_init() calls mtk_dim_rx(&eth->rx_dim.work) inside the MT7628
branch, and net_dim invokes it again on every moderation update.  Each
call therefore performs:

	mtk_w32(eth, val, 0);
	mtk_w32(eth, val, 0x4);
	mtk_w32(eth, val, 0x8);

These offsets land in the Frame Engine global config region
(MTK_FE_GLO_CFG(0) = 0x00 etc.) instead of any LRO/RSS register, with
val containing MTK_PDMA_DELAY_RX_EN = BIT(15).  Can this corrupt
MT7628 frame-engine state on every boot and every NAPI moderation
update?  Should the branch be gated on MTK_HWLRO or MTK_RSS rather
than on rx.desc_size?

[Medium]
On V3 hardware (the only chip enabling RSS) only two ring slots are
programmed here:

	val = val | (val << MTK_PDMA_DELAY_RX_RING_SHIFT);
	mtk_w32(eth, val, reg_map->pdma.rx_delay_irq);

With MTK_PDMA_DELAY_RX_RING_SHIFT = 16 the register holds two rings,
but RSS uses MTK_RX_RSS_NUM(eth) = 4 rings.  Do rings 2 and 3 ever
receive DIM-driven moderation updates after probe, or do they stay at
the hardware default?

[ ... ]

> @@ -4149,6 +4285,25 @@ static void mtk_hw_reset_monitor_work(struct work_struct *work)
[ ... ]
> +static int mtk_napi_init(struct mtk_eth *eth)
> +{
[ ... ]
> +}

[ ... ]

> @@ -4238,12 +4393,11 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
[ ... ]

> @@ -4700,8 +4860,13 @@ static void mtk_get_ethtool_stats(struct net_device *dev,
>  
>  static u32 mtk_get_rx_ring_count(struct net_device *dev)
>  {
> +	struct mtk_mac *mac = netdev_priv(dev);
> +	struct mtk_eth *eth = mac->hw;
> +
>  	if (dev->hw_features & NETIF_F_LRO)
>  		return MTK_MAX_RX_RING_NUM;
> +	else if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSS))
> +		return MTK_RX_RSS_NUM(eth);
>  
>  	return 0;
>  }

[ ... ]

> @@ -4784,6 +4949,70 @@ static int mtk_set_eee(struct net_device *dev, struct ethtool_keee *eee)
[ ... ]
> +static int mtk_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct mtk_mac *mac = netdev_priv(dev);
> +	struct mtk_eth *eth = mac->hw;
> +	struct mtk_rss_params *rss_params = &eth->rss_params;
> +	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
> +	int i;
> +
> +	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> +	    rxfh->hfunc != ETH_RSS_HASH_TOP)
> +		return -EOPNOTSUPP;
> +
> +	if (rxfh->key) {
> +		memcpy(rss_params->hash_key, rxfh->key,
> +		       sizeof(rss_params->hash_key));
> +		for (i = 0; i < MTK_RSS_HASH_KEYSIZE / sizeof(u32); i++)
> +			mtk_w32(eth, rss_params->hash_key[i],
> +				MTK_RSS_HASH_KEY_DW(reg_map, i));
> +	}
> +
> +	if (rxfh->indir) {
> +		for (i = 0; i < MTK_RSS_MAX_INDIRECTION_TABLE; i++)
> +			rss_params->indirection_table[i] = rxfh->indir[i];
> +		for (i = 0; i < MTK_RSS_MAX_INDIRECTION_TABLE / 16; i++)
> +			mtk_w32(eth, mtk_rss_indr_table(rss_params, i),
> +				MTK_RSS_INDR_TABLE_DW(reg_map, i));
> +	}
> +
> +	return 0;
> +}

[High]
Should this op (and .get_rxfh / .get_rxfh_key_size /
.get_rxfh_indir_size) be gated on MTK_HAS_CAPS(MTK_RSS)?  As written,
mtk_ethtool_ops exposes them unconditionally for every SoC the driver
supports.

MTK_RSS_HASH_KEY_DW(reg_map, x) and MTK_RSS_INDR_TABLE_DW(reg_map, x)
are computed as (reg_map)->pdma.rss_glo_cfg + 0x20 + ... and + 0x50 +
... .  mtk_reg_map (mt2701/mt7621/mt7622/mt7623/mt7629) and
mt7628_reg_map do not initialise rss_glo_cfg, so it defaults to 0.

A CAP_NET_ADMIN user invoking ethtool -X dev hkey ... on those SoCs
would write user-controlled u32 values into absolute frame-engine
offsets 0x20..0x44 (and indirection writes to 0x50..0x6c).  Can these
ops be made conditional on MTK_RSS, or filled in only for the RSS-
capable SoC?

[Medium]
mtk_set_rxfh() does not validate user-supplied indir[i] entries
against MTK_RX_RSS_NUM(eth).  The packing helper allots only 2 bits
per entry:

	val |= (rss_params->indirection_table[i] << (2 * (i % 16)));

ethtool core only enforces indir[i] < num_rx_rings when
num_rx_rings is non-zero, and MTK_RSS hardware has at most 4 rings.
Should the driver reject values >= MTK_RX_RSS_NUM(eth) so they don't
silently bleed across the 2-bit slots in the packed register?  The
indirection table also stores the raw u32 into a u8 field, which
truncates 4..255 instead of catching them.

[Medium]
mtk_rss_init() wraps key / indirection writes with an
MTK_RSS_CFG_REQ pause / release handshake:

	/* Pause */
	val |= MTK_RSS_CFG_REQ;
	mtk_w32(eth, val, reg_map->pdma.rss_glo_cfg);
	...
	/* Release pause */
	val &= ~(MTK_RSS_CFG_REQ);

mtk_set_rxfh() writes the same registers at runtime without that
handshake.  Can the hardware sample partially-updated key /
indirection state and steer packets to incorrect or out-of-range
rings while the write loop is in flight?

[ ... ]

> @@ -5424,6 +5708,7 @@ static const struct mtk_soc_data mt2701_data = {

[ ... entries for mt2701/mt7621/mt7622/mt7623/mt7629/rt5350 ... ]

> @@ -5567,16 +5851,16 @@ static const struct mtk_soc_data mt7981_data = {
[ ... ]
>  	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
> +	.rss_num = 4,
[ ... ]
> @@ -5597,6 +5881,7 @@ static const struct mtk_soc_data mt7986_data = {
[ ... ]
>  	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
> +	.rss_num = 4,

[Low]
mt7981_data and mt7986_data set rss_num = 4, but MT7981_CAPS and
MT7986_CAPS do not include MTK_RSS (only MT7988_CAPS does).  Every
RSS code path is gated on MTK_HAS_CAPS(MTK_RSS) before consulting
rss_num, so this has no current effect, but the SoC capability table
becomes internally inconsistent.  Should rss_num be 0 on these SoCs
until MTK_RSS is actually wired up and tested for them?

> @@ -5627,20 +5911,20 @@ static const struct mtk_soc_data mt7988_data = {
[ ... ]
>  	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
> +	.rss_num = 4,
[ ... ]
>  	.rx = {
>  		.desc_size = sizeof(struct mtk_rx_dma_v2),
> -		.irq_done_mask = MTK_RX_DONE_INT_V2,
>  		.dma_l4_valid = RX_DMA_L4_VALID_V2,
>  		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
>  		.dma_len_offset = 8,
> -		.dma_size = MTK_DMA_SIZE(2K),
> +		.dma_size = MTK_DMA_SIZE(1K),
>  	},
>  };

[ ... ]
-- 
pw-bot: cr

