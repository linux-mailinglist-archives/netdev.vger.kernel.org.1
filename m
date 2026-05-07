Return-Path: <netdev+bounces-285502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGjMG58C/WmIWgAAu9opvQ
	(envelope-from <netdev+bounces-285502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:22:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B67294EF324
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C80273006987
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631C342514;
	Thu,  7 May 2026 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsCDbAJN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA433F5B2;
	Thu,  7 May 2026 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188953; cv=none; b=ceca098anQGhF1xEXmbCsQIHh/PfH4MKNPqr6DHEa9XHsm4PvgjUrHJrMVNrF89JGTuzcS/ydUE2RnuERzB3WIXbzNLe11H6dZkchEJDu1WKHiEgPSMOUdK6XHUrTpKuZZBO6Cv5w+D6DQAGF4fFRR7EigB3bwnx764KklDuyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188953; c=relaxed/simple;
	bh=Sw8HB/3M6ZYpqZZy5khTns+8vYuZE5npZ/cQwbvRDT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuA42LH3NanSSqpaK112+p5v39yUJoAeyuHNGdMSllVWJ5OoBvGZb4mtxVJ+JOF42C7pP3R9AUX6Mx+S0Iwvm3SV0jKclZBuH1zaAtxKzgUEftiSamxyE+kki8cqY2I7nWXZw4FBfI+IKn0kYhGihDqqQtLF46puUfNNAyfjLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsCDbAJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6B0C2BCF5;
	Thu,  7 May 2026 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778188953;
	bh=Sw8HB/3M6ZYpqZZy5khTns+8vYuZE5npZ/cQwbvRDT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TsCDbAJNhnEIe+Z1a35L4BRPfCCS/LIIfDBpObw9VLI1kWb6cVZ3mtM5IH9MuitTS
	 sswdWMXBFyk1FOQxukDhGcfu2EEQulbsKc81hzkN22L8jJcBUzRhWU+x728kzB5J3P
	 BSOFUFkZyLjFOr2PtfGDNFs7qldQZxJmydmM3DiHE7YosocT3lvfglpx26SUeCEsrp
	 IBXFw10x4R0cx7ZyBZ9YSH8jkTLaguZTWthICPNpLFPprwvz0l+E6nDNiptyB5JalP
	 hnDOZf8qu5ivGj+MW1W/DZUfUvY0DS54dB8oTKkWxNVB65iBhk5tlgxRnHMJTryvRQ
	 KP6SE4HhRw1zw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 07 May 2026 23:21:46 +0200
Subject: [PATCH net-next v4 03/10] net: airoha: Move airoha_qdma pointer in
 airoha_gdm_dev struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-airoha-eth-multi-serdes-v4-3-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
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
X-Rspamd-Queue-Id: B67294EF324
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285502-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Move airoha_qdma pointer from airoha_gdm_port struct to airoha_gdm_dev
one since the QDMA block used depends on the particular net_device
WAN/LAN configuration and in the current codebase net_device pointer is
associated to airoha_gdm_dev struct.
This is a preliminary patch to support multiple net_devices connected
to the same GDM{3,4} port via an external hw arbiter.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 101 +++++++++++++++----------------
 drivers/net/ethernet/airoha/airoha_eth.h |   9 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c |  17 +++---
 3 files changed, 61 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 4af64f182968..1798b4a6cf5d 100644
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
 
 	vip_port = eth->soc->ops.get_vip_port(port, port->nbq);
@@ -854,7 +855,8 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 		if (!port)
 			continue;
 
-		if (port->qdma != qdma)
+		dev = port->dev;
+		if (dev->qdma != qdma)
 			continue;
 
 		dev = port->dev;
@@ -1558,9 +1560,10 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
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
@@ -1707,11 +1710,11 @@ static int airoha_dev_open(struct net_device *netdev)
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
 
@@ -1747,11 +1750,11 @@ static int airoha_dev_stop(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
-	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_qdma *qdma = dev->qdma;
 	int i;
 
 	netif_tx_disable(netdev);
-	airoha_set_vip_for_gdm_port(port, false);
+	airoha_set_vip_for_gdm_port(dev, false);
 	for (i = 0; i < netdev->num_tx_queues; i++)
 		netdev_tx_reset_subqueue(netdev, i);
 
@@ -1777,21 +1780,21 @@ static int airoha_dev_stop(struct net_device *netdev)
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
 	u32 val, pse_port, chan;
 	int i, src_port;
 
@@ -1836,7 +1839,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      __field_prep(SP_CPORT_MASK(val), FE_PSE_PORT_CDM2));
 
 	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(port, i, AIROHA_GDM2_IDX);
+		airoha_ppe_set_cpu_port(dev, i, AIROHA_GDM2_IDX);
 
 	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
 		u32 mask = FC_ID_OF_SRC_PORT_MASK(port->nbq);
@@ -1856,9 +1859,9 @@ static int airoha_dev_init(struct net_device *netdev)
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
@@ -1867,7 +1870,7 @@ static int airoha_dev_init(struct net_device *netdev)
 		if (!eth->ports[1]) {
 			int err;
 
-			err = airoha_set_gdm2_loopback(port);
+			err = airoha_set_gdm2_loopback(dev);
 			if (err)
 				return err;
 		}
@@ -1877,8 +1880,7 @@ static int airoha_dev_init(struct net_device *netdev)
 	}
 
 	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(port, i,
-					airoha_get_fe_port(port));
+		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
 
 	return 0;
 }
@@ -1890,7 +1892,7 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
 	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
-	airoha_update_hw_stats(port);
+	airoha_update_hw_stats(dev);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
 		storage->rx_packets = port->stats.rx_ok_pkts;
@@ -1910,8 +1912,8 @@ static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
-	struct airoha_eth *eth = port->qdma->eth;
 	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
+	struct airoha_eth *eth = dev->eth;
 
 	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
 		      GDM_LONG_LEN_MASK,
@@ -1985,10 +1987,10 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
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
@@ -2005,8 +2007,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
-	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_qdma *qdma = dev->qdma;
 	u32 nr_frags, tag, msg0, msg1, len;
 	struct airoha_queue_entry *e;
 	struct netdev_queue *txq;
@@ -2044,7 +2045,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		}
 	}
 
-	fport = airoha_get_fe_port(port);
+	fport = airoha_get_fe_port(dev);
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
@@ -2147,8 +2148,7 @@ static void airoha_ethtool_get_drvinfo(struct net_device *netdev,
 				       struct ethtool_drvinfo *info)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_eth *eth = dev->eth;
 
 	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
 	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
@@ -2161,7 +2161,7 @@ static void airoha_ethtool_get_mac_stats(struct net_device *netdev,
 	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
-	airoha_update_hw_stats(port);
+	airoha_update_hw_stats(dev);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
 		stats->FramesTransmittedOK = port->stats.tx_ok_pkts;
@@ -2201,7 +2201,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 		     ARRAY_SIZE(hw_stats->rx_len) + 1);
 
 	*ranges = airoha_ethtool_rmon_ranges;
-	airoha_update_hw_stats(port);
+	airoha_update_hw_stats(dev);
 	do {
 		int i;
 
@@ -2221,18 +2221,17 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
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
@@ -2240,13 +2239,12 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
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
 
@@ -2312,9 +2310,9 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
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
@@ -2578,17 +2576,16 @@ static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
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
@@ -2638,11 +2635,11 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
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
@@ -2721,7 +2718,6 @@ static int airoha_dev_tc_matchall(struct net_device *netdev,
 {
 	enum trtcm_unit_type unit_type = TRTCM_BYTE_UNIT;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	u32 rate = 0, bucket_size = 0;
 
 	switch (f->command) {
@@ -2746,7 +2742,7 @@ static int airoha_dev_tc_matchall(struct net_device *netdev,
 		fallthrough;
 	}
 	case TC_CLSMATCHALL_DESTROY:
-		return airoha_qdma_set_rx_meter(port, rate, bucket_size,
+		return airoha_qdma_set_rx_meter(dev, rate, bucket_size,
 						unit_type);
 	default:
 		return -EOPNOTSUPP;
@@ -2758,8 +2754,7 @@ static int airoha_dev_setup_tc_block_cb(enum tc_setup_type type,
 {
 	struct net_device *netdev = cb_priv;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_eth *eth = dev->eth;
 
 	if (!tc_can_offload(netdev))
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 21f149aa9c6b..21d308b1f087 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -535,12 +535,12 @@ struct airoha_qdma {
 
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
 	int nbq;
@@ -664,19 +664,18 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
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
index af7af4097b98..22f5f1bae730 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -84,9 +84,9 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 			     AIROHA_FOE_IB1_BIND_TIMESTAMP);
 }
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id, u8 fport)
+void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport)
 {
-	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_qdma *qdma = dev->qdma;
 	struct airoha_eth *eth = qdma->eth;
 	u8 qdma_id = qdma - &eth->qdma[0];
 	u32 fe_cpu_port;
@@ -180,8 +180,8 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			if (!port)
 				continue;
 
-			airoha_ppe_set_cpu_port(port, i,
-						airoha_get_fe_port(port));
+			airoha_ppe_set_cpu_port(port->dev, i,
+						airoha_get_fe_port(port->dev));
 		}
 	}
 }
@@ -1473,11 +1473,12 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
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
2.54.0


