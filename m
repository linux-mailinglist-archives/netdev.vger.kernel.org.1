Return-Path: <netdev+bounces-275562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG26MOSM02n1iwcAu9opvQ
	(envelope-from <netdev+bounces-275562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:37:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 610833A2DD1
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E443019184
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEF32BF24;
	Mon,  6 Apr 2026 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmSiX19Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50EA3290DB;
	Mon,  6 Apr 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471710; cv=none; b=SoshFEcgivXLQuclswhMw0ysu/mAdi3+isQaElf4fAggIhe+WdjcQxAI+OxkjFU5TkoL6dKWD4IrYlUL8F/VRBGzEXnaSMUHVWA7rCbIVrMWUG5Jo9YRggMmlng8WbYEPLqlOgA9GTmIJ4R/Xnb/sKPXjeBfyoDK5bhm13S6l1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471710; c=relaxed/simple;
	bh=Iu3FfDl736RSTU1BwIE+JzeCfPvcZfuyp5lzZ5VRLxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuFzVbuJlhAODc5x3XLN0m/J7OE0N7/qhLaECgE0gVkDku+oqGp3FsZD+VP1DUcViF4CRxoKCq2TVXyBa0H9ySrYVcvPDNPIGIeNYyAAy2GVqpn+EQUiob42/l6nNGIrWhgIu+XYFhcXGpp7JTg2c4hkq0gS0eWtT+BO/aZMCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmSiX19Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B4EC2BC9E;
	Mon,  6 Apr 2026 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471709;
	bh=Iu3FfDl736RSTU1BwIE+JzeCfPvcZfuyp5lzZ5VRLxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WmSiX19ZTh0q+dSoXSXbE3bStx90MUPGGUvnF6ThFxH3QunlGUGSaYjtsAgtARjUM
	 iR2sdaq5D0mhbyBNR73b9vMR1hgYhSUeRXF/IzU/hgaTmb/3BBuIW0iVOO4p+RxFvy
	 tvOzkZAbYJXb9LZhEkKb03YzT/cV2GnZQOhirajHf4vpYM6bvWWVK7FKIimIoKw+Nr
	 W3yt4tehtIJyFQaXQOzffkLcDrxnOYmZH44XpP8jU1pBcMhbK67YQTTn+yGOdiScXL
	 eIYu2YCrw8QbWzFNuT/5R3GvevXiGZSCJtsFrmZYOenafRDbkrEC7ZkdB8mSXtRA9b
	 ionKDosABBjBQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 06 Apr 2026 12:34:12 +0200
Subject: [PATCH net-next v3 07/12] net: airoha: Move airoha_qdma pointer in
 airoha_gdm_dev struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-airoha-eth-multi-serdes-v3-7-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 610833A2DD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move airoha_qdma pointer from airoha_gdm_port struct to airoha_gdm_dev
one since the QDMA block used depends on the particular net_device
WAN/LAN configuration and in the current codebase net_device pointer is
associated to airoha_gdm_dev struct.
This is a preliminary patch to support multiple net_devices connected
to the same GDM{3,4} port via an external hw arbiter.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 98 +++++++++++++++-----------------
 drivers/net/ethernet/airoha/airoha_eth.h |  9 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 17 +++---
 3 files changed, 59 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c2fc4967c340..716b73f0dff4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -71,9 +71,10 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
 	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
 }
 
-static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
+static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
 {
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
 	u32 val, reg;
 
 	reg = airoha_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
@@ -85,7 +86,7 @@ static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
 	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
 	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
 
-	airoha_ppe_init_upd_mem(port);
+	airoha_ppe_init_upd_mem(dev);
 }
 
 static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
@@ -101,10 +102,10 @@ static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
 		      FIELD_PREP(GDM_UCFQ_MASK, val));
 }
 
-static int airoha_set_vip_for_gdm_port(struct airoha_gdm_port *port,
-				       bool enable)
+static int airoha_set_vip_for_gdm_port(struct airoha_gdm_dev *dev, bool enable)
 {
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
 	u32 vip_port;
 
 	switch (port->id) {
@@ -1497,9 +1498,10 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 	}
 }
 
-static void airoha_update_hw_stats(struct airoha_gdm_port *port)
+static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 {
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
 	u32 val, i = 0;
 
 	spin_lock(&port->stats.lock);
@@ -1646,11 +1648,11 @@ static int airoha_dev_open(struct net_device *netdev)
 	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
-	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_qdma *qdma = dev->qdma;
 	u32 pse_port = FE_PSE_PORT_PPE1;
 
 	netif_tx_start_all_queues(netdev);
-	err = airoha_set_vip_for_gdm_port(port, true);
+	err = airoha_set_vip_for_gdm_port(dev, true);
 	if (err)
 		return err;
 
@@ -1686,11 +1688,11 @@ static int airoha_dev_stop(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
-	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_qdma *qdma = dev->qdma;
 	int i, err;
 
 	netif_tx_disable(netdev);
-	err = airoha_set_vip_for_gdm_port(port, false);
+	err = airoha_set_vip_for_gdm_port(dev, false);
 	if (err)
 		return err;
 
@@ -1719,21 +1721,21 @@ static int airoha_dev_stop(struct net_device *netdev)
 static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	int err;
 
 	err = eth_mac_addr(netdev, p);
 	if (err)
 		return err;
 
-	airoha_set_macaddr(port, netdev->dev_addr);
+	airoha_set_macaddr(dev, netdev->dev_addr);
 
 	return 0;
 }
 
-static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
+static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
 {
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
 	u32 val, pse_port, chan, nbq;
 	int i, src_port;
 
@@ -1780,7 +1782,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      __field_prep(SP_CPORT_MASK(val), FE_PSE_PORT_CDM2));
 
 	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(port, i, AIROHA_GDM2_IDX);
+		airoha_ppe_set_cpu_port(dev, i, AIROHA_GDM2_IDX);
 
 	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
 		u32 mask = FC_ID_OF_SRC_PORT_MASK(nbq);
@@ -1800,9 +1802,9 @@ static int airoha_dev_init(struct net_device *netdev)
 	int i;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
-	port->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
-	dev->dev->irq = port->qdma->irq_banks[0].irq;
-	airoha_set_macaddr(port, netdev->dev_addr);
+	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
+	dev->dev->irq = dev->qdma->irq_banks[0].irq;
+	airoha_set_macaddr(dev, netdev->dev_addr);
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
@@ -1811,7 +1813,7 @@ static int airoha_dev_init(struct net_device *netdev)
 		if (!eth->ports[1]) {
 			int err;
 
-			err = airoha_set_gdm2_loopback(port);
+			err = airoha_set_gdm2_loopback(dev);
 			if (err)
 				return err;
 		}
@@ -1821,8 +1823,7 @@ static int airoha_dev_init(struct net_device *netdev)
 	}
 
 	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(port, i,
-					airoha_get_fe_port(port));
+		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
 
 	return 0;
 }
@@ -1834,7 +1835,7 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
 	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
-	airoha_update_hw_stats(port);
+	airoha_update_hw_stats(dev);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
 		storage->rx_packets = port->stats.rx_ok_pkts;
@@ -1854,8 +1855,8 @@ static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
-	struct airoha_eth *eth = port->qdma->eth;
 	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
+	struct airoha_eth *eth = dev->eth;
 
 	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
 		      GDM_LONG_LEN_MASK,
@@ -1929,10 +1930,10 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
 }
 
-int airoha_get_fe_port(struct airoha_gdm_port *port)
+int airoha_get_fe_port(struct airoha_gdm_dev *dev)
 {
-	struct airoha_qdma *qdma = port->qdma;
-	struct airoha_eth *eth = qdma->eth;
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
 
 	switch (eth->soc->version) {
 	case 0x7583:
@@ -1949,8 +1950,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
-	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_qdma *qdma = dev->qdma;
 	u32 nr_frags, tag, msg0, msg1, len;
 	struct airoha_queue_entry *e;
 	struct netdev_queue *txq;
@@ -1988,7 +1988,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		}
 	}
 
-	fport = airoha_get_fe_port(port);
+	fport = airoha_get_fe_port(dev);
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
@@ -2088,8 +2088,7 @@ static void airoha_ethtool_get_drvinfo(struct net_device *netdev,
 				       struct ethtool_drvinfo *info)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_eth *eth = dev->eth;
 
 	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
 	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
@@ -2102,7 +2101,7 @@ static void airoha_ethtool_get_mac_stats(struct net_device *netdev,
 	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
-	airoha_update_hw_stats(port);
+	airoha_update_hw_stats(dev);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
 		stats->FramesTransmittedOK = port->stats.tx_ok_pkts;
@@ -2142,7 +2141,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 		     ARRAY_SIZE(hw_stats->rx_len) + 1);
 
 	*ranges = airoha_ethtool_rmon_ranges;
-	airoha_update_hw_stats(port);
+	airoha_update_hw_stats(dev);
 	do {
 		int i;
 
@@ -2162,18 +2161,17 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 					 const u16 *weights, u8 n_weights)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	int i;
 
 	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
-		airoha_qdma_clear(port->qdma, REG_QUEUE_CLOSE_CFG(channel),
+		airoha_qdma_clear(dev->qdma, REG_QUEUE_CLOSE_CFG(channel),
 				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
 
 	for (i = 0; i < n_weights; i++) {
 		u32 status;
 		int err;
 
-		airoha_qdma_wr(port->qdma, REG_TXWRR_WEIGHT_CFG,
+		airoha_qdma_wr(dev->qdma, REG_TXWRR_WEIGHT_CFG,
 			       TWRR_RW_CMD_MASK |
 			       FIELD_PREP(TWRR_CHAN_IDX_MASK, channel) |
 			       FIELD_PREP(TWRR_QUEUE_IDX_MASK, i) |
@@ -2181,13 +2179,12 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 		err = read_poll_timeout(airoha_qdma_rr, status,
 					status & TWRR_RW_CMD_DONE,
 					USEC_PER_MSEC, 10 * USEC_PER_MSEC,
-					true, port->qdma,
-					REG_TXWRR_WEIGHT_CFG);
+					true, dev->qdma, REG_TXWRR_WEIGHT_CFG);
 		if (err)
 			return err;
 	}
 
-	airoha_qdma_rmw(port->qdma, REG_CHAN_QOS_MODE(channel >> 3),
+	airoha_qdma_rmw(dev->qdma, REG_CHAN_QOS_MODE(channel >> 3),
 			CHAN_QOS_MODE_MASK(channel),
 			__field_prep(CHAN_QOS_MODE_MASK(channel), mode));
 
@@ -2253,9 +2250,9 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 
-	u64 cpu_tx_packets = airoha_qdma_rr(port->qdma,
+	u64 cpu_tx_packets = airoha_qdma_rr(dev->qdma,
 					    REG_CNTR_VAL(channel << 1));
-	u64 fwd_tx_packets = airoha_qdma_rr(port->qdma,
+	u64 fwd_tx_packets = airoha_qdma_rr(dev->qdma,
 					    REG_CNTR_VAL((channel << 1) + 1));
 	u64 tx_packets = (cpu_tx_packets - port->cpu_tx_packets) +
 			 (fwd_tx_packets - port->fwd_tx_packets);
@@ -2518,17 +2515,16 @@ static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
 					 u32 bucket_size)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	int i, err;
 
 	for (i = 0; i <= TRTCM_PEAK_MODE; i++) {
-		err = airoha_qdma_set_trtcm_config(port->qdma, channel,
+		err = airoha_qdma_set_trtcm_config(dev->qdma, channel,
 						   REG_EGRESS_TRTCM_CFG, i,
 						   !!rate, TRTCM_METER_MODE);
 		if (err)
 			return err;
 
-		err = airoha_qdma_set_trtcm_token_bucket(port->qdma, channel,
+		err = airoha_qdma_set_trtcm_token_bucket(dev->qdma, channel,
 							 REG_EGRESS_TRTCM_CFG,
 							 i, rate, bucket_size);
 		if (err)
@@ -2578,11 +2574,11 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	return 0;
 }
 
-static int airoha_qdma_set_rx_meter(struct airoha_gdm_port *port,
+static int airoha_qdma_set_rx_meter(struct airoha_gdm_dev *dev,
 				    u32 rate, u32 bucket_size,
 				    enum trtcm_unit_type unit_type)
 {
-	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_qdma *qdma = dev->qdma;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
@@ -2661,7 +2657,6 @@ static int airoha_dev_tc_matchall(struct net_device *netdev,
 {
 	enum trtcm_unit_type unit_type = TRTCM_BYTE_UNIT;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	u32 rate = 0, bucket_size = 0;
 
 	switch (f->command) {
@@ -2686,7 +2681,7 @@ static int airoha_dev_tc_matchall(struct net_device *netdev,
 		fallthrough;
 	}
 	case TC_CLSMATCHALL_DESTROY:
-		return airoha_qdma_set_rx_meter(port, rate, bucket_size,
+		return airoha_qdma_set_rx_meter(dev, rate, bucket_size,
 						unit_type);
 	default:
 		return -EOPNOTSUPP;
@@ -2698,8 +2693,7 @@ static int airoha_dev_setup_tc_block_cb(enum tc_setup_type type,
 {
 	struct net_device *netdev = cb_priv;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_eth *eth = dev->eth;
 
 	if (!tc_can_offload(netdev))
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 54cb9984ff4b..05ffe4d9de4f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -534,12 +534,12 @@ struct airoha_qdma {
 
 struct airoha_gdm_dev {
 	struct airoha_gdm_port *port;
+	struct airoha_qdma *qdma;
 	struct net_device *dev;
 	struct airoha_eth *eth;
 };
 
 struct airoha_gdm_port {
-	struct airoha_qdma *qdma;
 	struct airoha_gdm_dev *dev;
 	int id;
 
@@ -652,19 +652,18 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 	return eth->soc->version == 0x7583;
 }
 
-int airoha_get_fe_port(struct airoha_gdm_port *port);
+int airoha_get_fe_port(struct airoha_gdm_dev *dev);
 bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 			     struct airoha_gdm_dev *dev);
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id,
-			     u8 fport);
+void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport);
 bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
 void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 			  u16 hash, bool rx_wlan);
 int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
-void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port);
+void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev);
 u32 airoha_ppe_get_total_num_entries(struct airoha_ppe *ppe);
 struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
 						  u32 hash);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 65aadb29330e..2d4560e9ec5f 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -85,9 +85,9 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 	return FIELD_GET(AIROHA_FOE_IB1_BIND_TIMESTAMP, timestamp);
 }
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id, u8 fport)
+void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport)
 {
-	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_qdma *qdma = dev->qdma;
 	struct airoha_eth *eth = qdma->eth;
 	u8 qdma_id = qdma - &eth->qdma[0];
 	u32 fe_cpu_port;
@@ -173,8 +173,8 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			if (!port)
 				continue;
 
-			airoha_ppe_set_cpu_port(port, i,
-						airoha_get_fe_port(port));
+			airoha_ppe_set_cpu_port(port->dev, i,
+						airoha_get_fe_port(port->dev));
 		}
 	}
 }
@@ -1430,11 +1430,12 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 	airoha_ppe_foe_insert_entry(ppe, skb, hash, rx_wlan);
 }
 
-void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
+void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev)
 {
-	struct airoha_eth *eth = port->qdma->eth;
-	struct net_device *dev = port->dev->dev;
-	const u8 *addr = dev->dev_addr;
+	struct airoha_gdm_port *port = dev->port;
+	struct net_device *netdev = dev->dev;
+	struct airoha_eth *eth = dev->eth;
+	const u8 *addr = netdev->dev_addr;
 	u32 val;
 
 	val = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];

-- 
2.53.0


