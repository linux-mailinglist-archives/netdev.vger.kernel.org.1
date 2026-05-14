Return-Path: <netdev+bounces-287777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGxOJ/8qBWqJTAIAu9opvQ
	(envelope-from <netdev+bounces-287777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:53:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D9653CDFF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F08273058994
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196BB330315;
	Thu, 14 May 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzYRTTE/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81F31F998;
	Thu, 14 May 2026 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723547; cv=none; b=OjCyd6V2qdRjXhQFtLwiXJgQoyI8GkU+1ziPEW6+67U2l1y+3OMgeICfS/Oyz6TPwwCvhj62R1kFv8QH2UXqlc1ENpT8zoQR318KSGgZXNAFZ7gPSDBnxk7qNcmQlYZbOlCK6OMOy1KtOzMB1RFgeWLgbfJa/ywR3UqsdBe8tes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723547; c=relaxed/simple;
	bh=VILMNxkxjL/GtlR8quQKCsdNfqp7zDgMgna5X1nzLeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKAc18KmA2elhW6sgSRDdCJsfLdd5yn7IR6D8fMkahj100s2Ie9QbWykZRubuDAoBlNU+wQIrDTRmZ2WBb8HAIsCfI8PRFjPTxEs0ztmD0DyxC5T82Pko2SpShjOONVvaPYa5ca8b9gM4eSXTea2iKTl1nAWOmTmyZPWJMnNe5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzYRTTE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF04CC2BCB8;
	Thu, 14 May 2026 01:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723546;
	bh=VILMNxkxjL/GtlR8quQKCsdNfqp7zDgMgna5X1nzLeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzYRTTE/PbVe8BhnllzCK8GVv4l0wg1Hm7QT8ikM0H9mpDXWRGZC+xfsdQ3fHl52b
	 Q+kgkefe3OoFkJCqcWSp/7vxi6t3RWyG3yutJe5pa4JAi9+k2cqwufiGuPR1ABdaZ/
	 S6ghzlKA738wt3ERhJgeSmcvwuNgnUF9GEafElL3dptF1Hfz8B/fv3xsKyplLcYfML
	 MnhD3N/zESMlQXWJGGezQqGgOR3lr3Xy6pNIT+84ELqQwNn5jkFdn/Y+0ferVkKm7V
	 +AdaGVZSbiBni2csuw7ZuNMH6DWQslYAf/Yo7g111fa9KitFTijrfOKuZ1n7Msw/cB
	 d4fxE56o/a5zg==
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
Subject: Re: [net-next v8 3/3] net: ethernet: mtk_eth_soc: Add LRO support
Date: Wed, 13 May 2026 18:52:24 -0700
Message-ID: <20260514015224.521125-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509190938.169290-4-linux@fw-web.de>
References: <20260509190938.169290-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53D9653CDFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287777-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: ethernet: mtk_eth_soc: Add LRO support

This patch adds Hardware Large Receive Offload support to the
mediatek ethernet driver and enables it on MT7988 by adding
MTK_HWLRO to MT7988_CAPS. The patch parameterizes the LRO
register accessors and ring counts on the SoC version, and adds
LRO-specific NAPI/IRQ wiring.

A few questions on the changes below.

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 908fd88287ac..8035fc2557de 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2806,7 +2806,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  	if (!ring->data)
>  		return -ENOMEM;
>  
> -	if (mtk_page_pool_enabled(eth)) {
> +	if (mtk_page_pool_enabled(eth) && rcu_access_pointer(eth->prog))  {
>  		struct page_pool *pp;
>  
>  		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,

[High]
Could the rationale for this gating change be explained in the commit
message?  The subject is "Add LRO support" but this hunk changes the
page_pool creation policy for every netsys v2+ chip.

Before the patch, every v2+ RX ring was backed by a page_pool (since
mtk_page_pool_enabled() returns mtk_is_netsys_v2_or_greater(eth)).
After the patch, a page_pool is only created when an XDP program is
already attached at ring allocation time.

mtk_xdp_setup() also rejects XDP attach with -EOPNOTSUPP when
eth->hwlro is true:

    if (eth->hwlro) {
            NL_SET_ERR_MSG_MOD(extack, "HW LRO and XDP are mutually exclusive");
            return -EOPNOTSUPP;
    }

So on MT7988 (where this patch enables MTK_HWLRO) eth->prog is
permanently NULL and mtk_create_page_pool() is now never reached
for any RX ring, including the non-LRO ring 0.

Does this intentionally disable page_pool/DMA buffer recycling on
MT7988, and on every other v2+ chip until a BPF program is loaded?
mtk_ethtool_pp_stats() depends on ring->page_pool, so the page-pool
counters reported through ethtool would also become empty.

The driver still advertises NETDEV_XDP_ACT_BASIC|REDIRECT|NDO_XMIT|
NDO_XMIT_SG via xdp_features for v2+, which appears to diverge from
the buffer-pool capability after this change.

> @@ -2974,30 +2975,50 @@ static int mtk_hwlro_rx_init(struct mtk_eth *eth)
>  	ring_ctrl_dw2 |= MTK_RING_MAX_AGG_CNT_L;
>  	ring_ctrl_dw3 |= MTK_RING_MAX_AGG_CNT_H;
>  
> -	for (i = 1; i < MTK_MAX_RX_RING_NUM; i++) {
> +	for (i = 1; i <= MTK_HW_LRO_RING_NUM(eth); i++) {
>  		mtk_w32(eth, ring_ctrl_dw1, MTK_LRO_CTRL_DW1_CFG(reg_map, i));

[ ... ]

>  	/* set refresh timer for altering flows to 1 sec. (unit: 20us) */
>  	mtk_w32(eth, (MTK_HW_LRO_TIMER_UNIT << 16) | MTK_HW_LRO_REFRESH_TIME,
>  		MTK_PDMA_LRO_ALT_REFRESH_TIMER);

[Medium]
Should MTK_PDMA_LRO_ALT_REFRESH_TIMER also have been converted to
go through reg_map like every other LRO register touched by this
patch?  Looking at the header, it is still defined as a hardcoded
absolute offset 0x1c that has lived in the v1 PDMA window since
2016.  On MT7988 (newly added to MTK_HWLRO via MT7988_CAPS) the
LRO block lives at 0x6c08-0x6c44 per mt7988_reg_map, while offset
0x1c on v3 falls in the Frame Engine register area between
MTK_FE_INT_ENABLE and MTK_FE_INT_GRP.

Every other LRO register access in this function was switched to
MTK_PDMA_LRO_CTRL_DW0(reg_map), MTK_PDMA_LRO_ALT_SCORE_DELTA(reg_map),
MTK_LRO_DIP_DW0_CFG(reg_map, x) and so on.  Was the omission of
this one register intentional, or should it be a similar
reg_map-based accessor so that on MT7988 the auto-learn refresh
timer is programmed in the LRO block instead of in the FE engine
region?

> -	/* set HW LRO mode & the max aggregation count for rx packets */
> -	lro_ctrl_dw3 |= MTK_ADMA_MODE | (MTK_HW_LRO_MAX_AGG_CNT & 0xff);
> +	if (mtk_is_netsys_v3_or_greater(eth)) {

[ ... ]

>  	/* enable HW LRO */
>  	lro_ctrl_dw0 |= MTK_LRO_EN;
>  
> -	mtk_w32(eth, lro_ctrl_dw3, MTK_PDMA_LRO_CTRL_DW3);
> -	mtk_w32(eth, lro_ctrl_dw0, MTK_PDMA_LRO_CTRL_DW0);
> +	mtk_w32(eth, lro_ctrl_dw3, MTK_PDMA_LRO_CTRL_DW3(reg_map));
> +	mtk_w32(eth, lro_ctrl_dw0, MTK_PDMA_LRO_CTRL_DW0(reg_map));
> +
> +	if (mtk_is_netsys_v2_or_greater(eth)) {
> +		i = (soc->rx.desc_size == sizeof(struct mtk_rx_dma_v2)) ? 1 : 0;
> +		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)),
> +			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)), reg_map->pdma.int_grp);
> +		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 1)),
> +			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 1)),
> +			reg_map->pdma.int_grp + 0x4);
> +		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 2)),
> +			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 2)), reg_map->pdma.int_grp3);
> +	}

[Medium]
On v3 (the only chip with both MTK_HWLRO and v2+ enabled by this
patch), the desc_size check yields i = 1, so this block routes
MTK_HW_LRO_RING(eth, 1..3) — physical rings 5, 6, 7 with done bits
BIT(29..31) — into int_grp, int_grp+0x4 and int_grp3 respectively.
What routes MTK_HW_LRO_RING(eth, 0), i.e. physical ring 4 with done
bit BIT(28)?

mtk_probe() registers an IRQ handler for all MTK_HW_LRO_RING_NUM(eth)
= 4 LRO rings using IRQF_SHARED, so a NAPI is attached for ring 4 on
eth->irq_pdma[MTK_HW_LRO_IRQ(eth, 0)] (= irq_pdma[0] on v3).  Without
ring 4's BIT(28) being OR'd into any int_grp register, does ring 4's
RX interrupt actually reach NAPI, or does that depend on hardware
reset defaults of int_grp on MT7988?

>  	return 0;
>  }
> @@ -3080,6 +3112,65 @@ static int mtk_hwlro_get_ip_cnt(struct mtk_mac *mac)
>  	return cnt;
>  }
>  
> +static int mtk_hwlro_add_ipaddr_idx(struct net_device *dev, u32 ip4dst)
> +{
> +	struct mtk_mac *mac = netdev_priv(dev);
> +	const struct mtk_reg_map *reg_map;
> +	struct mtk_eth *eth = mac->hw;
> +	u32 reg_val;
> +	int i;
> +
> +	reg_map = eth->soc->reg_map;
> +
> +	/* check for duplicate IP address in the current DIP list */
> +	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
> +		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(reg_map, i));
> +		if (reg_val == ip4dst)
> +			break;
> +	}
> +
> +	if (i < MTK_HW_LRO_DIP_NUM(eth) + 1) {
> +		netdev_warn(dev, "Duplicate IP address at DIP(%d)!\n", i);
> +		return -EEXIST;
> +	}
> +
> +	/* find out available DIP index */
> +	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
> +		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(reg_map, i));
> +		if (reg_val == 0UL)
> +			break;
> +	}
> +
> +	if (i >= MTK_HW_LRO_DIP_NUM(eth) + 1) {
> +		netdev_warn(dev, "DIP index is currently out of resource!\n");
> +		return -EBUSY;
> +	}
> +
> +	return i;
> +}

[High]
Is it intentional that the DIP-table allocation policy is changed
from a per-MAC partition (previously hwlro_idx = mac->id *
MTK_MAX_LRO_IP_CNT + fsp->location) to a single global pool searched
across all MACs?  The duplicate check and free-slot search above
both iterate every DIP register without scoping by mac->id.

Two observations:

1. Two netdevs that both want HW LRO on the same destination IP
   collide on the duplicate-check and the second one fails with
   -EEXIST.  A single MAC can also fill all DIP slots and starve
   the other; non-v3 silicon has only 3 slots while the uAPI
   advertises 2 MACs * MTK_MAX_LRO_IP_CNT = 4 rules.

2. mtk_hwlro_add_ipaddr() (below) does not invalidate any
   pre-existing entry at mac->hwlro_ip[fsp->location] before
   calling this helper, so adding a new IP at a location that
   already had one finds a fresh slot for the new IP and then
   overwrites the software state.  The old slot still has the
   original IP with MYIP_VLD set in hardware, and a later del at
   the same location only finds and invalidates the new entry.

Together they look like a CAP_NET_ADMIN-reachable way to leak DIP
slots until device reset, while mac->hwlro_ip[] looks consistent.

> +static int mtk_hwlro_get_ipaddr_idx(struct net_device *dev, u32 ip4dst)
> +{
> +	struct mtk_mac *mac = netdev_priv(dev);
> +	struct mtk_eth *eth = mac->hw;
> +	u32 reg_val;
> +	int i;
> +
> +	/* find out DIP index that matches the given IP address */
> +	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
> +		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(eth->soc->reg_map, i));
> +		if (reg_val == ip4dst)
> +			break;
> +	}
> +
> +	if (i >= MTK_HW_LRO_DIP_NUM(eth) + 1) {
> +		netdev_warn(dev, "DIP address is not exist!\n");
> +		return -ENOENT;
> +	}
> +
> +	return i;
> +}
> +
>  static int mtk_hwlro_add_ipaddr(struct net_device *dev,
>  				struct ethtool_rxnfc *cmd)
>  {
> @@ -3112,13 +3207,17 @@ static int mtk_hwlro_del_ipaddr(struct net_device *dev,
>  	struct mtk_mac *mac = netdev_priv(dev);
>  	struct mtk_eth *eth = mac->hw;
>  	int hwlro_idx;
> +	u32 ip4dst;
>  
>  	if (fsp->location > 1)
>  		return -EINVAL;
>  
> -	mac->hwlro_ip[fsp->location] = 0;
> -	hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + fsp->location;
> +	ip4dst = mac->hwlro_ip[fsp->location];
> +	hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, ip4dst);
> +	if (hwlro_idx < 0)
> +		return hwlro_idx;
>  
> +	mac->hwlro_ip[fsp->location] = 0;
>  	mac->hwlro_ip_cnt = mtk_hwlro_get_ip_cnt(mac);
>  
>  	mtk_hwlro_inval_ipaddr(eth, hwlro_idx);

[Medium]
Should this path validate that mac->hwlro_ip[fsp->location] is
non-zero before passing it to mtk_hwlro_get_ipaddr_idx()?  When the
location was never populated (or was already deleted), ip4dst is 0.
mtk_hwlro_get_ipaddr_idx() then matches the first slot whose register
reads 0 — i.e. an arbitrary unrelated empty slot — and returns a
positive index, after which mtk_hwlro_inval_ipaddr() clears MYIP_VLD
on that unrelated slot and the call returns 0 to userspace.

Either rejecting the call with -ENOENT here when
mac->hwlro_ip[fsp->location] == 0, or having mtk_hwlro_get_ipaddr_idx()
refuse ip4dst == 0, would avoid that.

> @@ -3126,6 +3225,24 @@ static int mtk_hwlro_del_ipaddr(struct net_device *dev,
>  	return 0;
>  }
>  
> +static void mtk_hwlro_netdev_enable(struct net_device *dev)
> +{
> +	struct mtk_mac *mac = netdev_priv(dev);
> +	struct mtk_eth *eth = mac->hw;
> +	int i, hwlro_idx;
> +
> +	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
> +		if (mac->hwlro_ip[i] == 0)
> +			continue;
> +
> +		hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, mac->hwlro_ip[i]);
> +		if (hwlro_idx < 0)
> +			continue;
> +
> +		mtk_hwlro_val_ipaddr(eth, hwlro_idx, mac->hwlro_ip[i]);
> +	}
> +}
> +

[Low]
This isn't a bug, but is mtk_hwlro_netdev_enable() reachable in
practice?  It uses mtk_hwlro_get_ipaddr_idx(), which only succeeds
when the IP is already programmed in hardware.  The only path that
disables LRO is mtk_hwlro_netdev_disable() below, which clears
mac->hwlro_ip[i] = 0 (so the first guard always continues) and also
invalidates the DIP entries.  After ethtool -K lro off the IPs are
gone from both software and hardware, so the subsequent ethtool -K
lro on appears to do nothing.

If the intent is restore-on-re-enable, should the disable preserve
mac->hwlro_ip[] and/or should this enable path call
mtk_hwlro_add_ipaddr_idx() to allocate fresh slots?

>  static void mtk_hwlro_netdev_disable(struct net_device *dev)
>  {
>  	struct mtk_mac *mac = netdev_priv(dev);
> @@ -3133,8 +3250,14 @@ static void mtk_hwlro_netdev_disable(struct net_device *dev)
>  	int i, hwlro_idx;
>  
>  	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
> +		if (mac->hwlro_ip[i] == 0)
> +			continue;
> +
> +		hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, mac->hwlro_ip[i]);
> +		if (hwlro_idx < 0)
> +			continue;
> +
>  		mac->hwlro_ip[i] = 0;
> -		hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + i;
>  
>  		mtk_hwlro_inval_ipaddr(eth, hwlro_idx);
>  	}

[Medium]
Can this leave mac->hwlro_ip[i] populated while mac->hwlro_ip_cnt is
reset to 0?  When mtk_hwlro_get_ipaddr_idx() returns < 0 (for example
because the DIP table was already cleared by a prior
mtk_hwlro_rx_uninit, by a parallel teardown on another MAC, or by a
hardware reset), the continue skips the mac->hwlro_ip[i] = 0
assignment.  After the loop, mac->hwlro_ip_cnt = 0 still runs
unconditionally.

The previous code unconditionally cleared mac->hwlro_ip[i].  In the
new shape, ETHTOOL_GRXCLSRLCNT would report 0 while
ETHTOOL_GRXCLSRLALL via mtk_hwlro_get_fdir_all() still enumerates
the stale entries, and mtk_hwlro_get_ip_cnt() called from a later
add would recount them.

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> index 378cf47913ef..f7e7299fef6b 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -35,7 +35,7 @@
>  #define MTK_DMA_SIZE(x)		(SZ_##x)
>  #define MTK_FQ_DMA_HEAD		32
>  #define MTK_FQ_DMA_LENGTH	2048
> -#define MTK_RX_ETH_HLEN		(ETH_HLEN + ETH_FCS_LEN)
> +#define MTK_RX_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
>  #define MTK_RX_HLEN		(NET_SKB_PAD + MTK_RX_ETH_HLEN + NET_IP_ALIGN)

[High]
Could this change be called out in the commit message?  It widens
MTK_RX_ETH_HLEN from 18 to 26 globally for every supported chip,
not just MT7988/LRO.

mtk_add_mac() sets:

    eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH_2K - MTK_RX_ETH_HLEN;

(and MTK_MAX_RX_LENGTH - MTK_RX_ETH_HLEN for MT7628), so the
maximum MTU advertised by every supported MediaTek SoC drops by 8
bytes (e.g. 2030 -> 2022 on the 2K path, 1518 -> 1510 on MT7628).
Userspace configuration that previously set MTU values up to the
prior limit will now be rejected with -EINVAL.

If headroom for stacked VLANs is needed only on the LRO path, would
it be possible to confine the +8 to MTK_MAX_LRO_RX_LENGTH instead
of changing MTK_RX_ETH_HLEN for every chip?

