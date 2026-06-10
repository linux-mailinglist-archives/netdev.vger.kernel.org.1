Return-Path: <netdev+bounces-297684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 09/YDZBpKWq1WQMAu9opvQ
	(envelope-from <netdev+bounces-297684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:41:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6CB669D7A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:41:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tuo1NJvb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297684-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297684-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C57F331C073
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27740B6C9;
	Wed, 10 Jun 2026 13:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FE3D8128
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:34:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098465; cv=none; b=rT59STnQb7mRhiMmI4vULJqmt/CnvCQ9mLFCZWn1SQlljHtKIq/WyU7CNaLlCUyPHuFkVh6mdpYGzkiBhKopV88cX8+4hsfQcPgpohNa3xegHqTlkj2f8EKhCZqoPRdhHBOHb6qSFexTfqGIqWF8XSFEIcLr9WK4mICBGtEATy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098465; c=relaxed/simple;
	bh=EHgOipOVrS8vHv1wz/Ne1vBCvgiBMGEIYTFby2ygCuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CtK9QJJ8zBUZqlsvmuZJbPAPiSyE1O5l9QgKgoQy8D0N92AQIJ9pgK9diMCKTXb726jEN393x4dj9PMtzsO2RxOD8aDhOoS3GRErgaGEb0FmkT6VJPSffGXDwKJ34vLdwnF5Zxio6y0GO27DdjA76Untid5Rsl8WvAZSNaCUVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tuo1NJvb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6371F00898;
	Wed, 10 Jun 2026 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781098457;
	bh=yBCm89AJMdN6cWaGBIC4WnuWEFv8YAzMmjhSA2lQqOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tuo1NJvbh5I5BAORz9PgtHvI9ckperQ53j17894ad4htLuoR4pFk2KhAcge/ayxkO
	 2rq0IbttxQrhJYbbP5j+Y7B63m/GLwFg0E5vFgD2Jf+49xp4qqGI3qtI1MCsvNiYVG
	 nnMF/xQEBHdwP5/78NWwh9Uug0S+SvXKekB/M8gMqFT1FFb0LrD0kETSE1M+ozcJF8
	 KRQMgEwVjBBrw8fUUcBq4kVRS5ix7iJ0CA53uAJQ9rdTjuszIIPSniwZBWv9XWHE4n
	 Tjn7B0BxMiK4FDZwa1rLIB20KGUCRj81neyRozeN1IMSIM22Qnh+ThqP1mKzE51NtN
	 34wD6pdXeldxQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Jun 2026 15:33:37 +0200
Subject: [PATCH net-next v4 2/2] net: airoha: defer GDM3/GDM4 WAN mode and
 GDM2 loopback to QoS offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-airoha-ethtool-priv_flags-v4-2-60e89cf28fea@kernel.org>
References: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
In-Reply-To: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A6CB669D7A

GDM3 and GDM4 ports require GDM2 loopback to be enabled for hardware
QoS offload to function. Without it, HTB and ETS offload on these ports
do not work.
Previously, GDM3/GDM4 ports were automatically configured as WAN with
GDM2 loopback enabled during ndo_init(). Add the capability to configure
GDM3/GDM4 as WAN/LAN on demand when QoS offload is created or destroyed.
Hook airoha_enable_qos_for_gdm34() into TC_HTB_CREATE so that requesting
HTB offload on a GDM3/GDM4 LAN port switches it to WAN mode and enables
GDM2 loopback, with proper rollback on failure. Hook the counterpart
airoha_disable_qos_for_gdm34() into TC_HTB_DESTROY to restore LAN mode
when the offloaded qdisc is torn down.
Since airoha_dev_set_qdma() can now be called on a running device to
migrate between QDMA blocks, make dev->qdma an RCU pointer so the TX
path can safely dereference it without holding RTNL.
Hold flow_offload_mutex in airoha_dev_set_qdma() around the QDMA pointer
update and __airoha_ppe_set_cpu_port() call, serializing against
concurrent airoha_ppe_hw_init() in the TC_SETUP_CLSFLOWER offload path.
Introduce airoha_qdma_deref() helper that wraps rcu_dereference_protected()
with a lockdep condition accepting either rtnl_lock or flow_offload_mutex,
and use it across all control-path dereferences of the RCU-protected
dev->qdma pointer.
Add airoha_disable_gdm2_loopback() to disable GDM2 hw loopback.

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 220 ++++++++++++++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h  |  24 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c  |  18 ++-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 231 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index aeac66df5f3b..10232470a333 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -921,9 +921,11 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 			if (!dev)
 				continue;
 
-			if (dev->qdma != qdma)
-				continue;
-
+			/* Do not filter by dev->qdma here: the device
+			 * may have migrated to a different QDMA block
+			 * since the packet was submitted, so completions
+			 * can arrive on the old block.
+			 */
 			netdev = netdev_from_priv(dev);
 			for (j = 0; j < netdev->num_tx_queues; j++) {
 				if (airoha_qdma_get_txq(qdma, j) != qid)
@@ -1811,13 +1813,14 @@ static int airoha_dev_open(struct net_device *netdev)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
-	struct airoha_qdma *qdma = dev->qdma;
+	struct airoha_qdma *qdma;
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
 	if (err)
 		return err;
 
+	qdma = airoha_qdma_deref(dev);
 	if (netdev_uses_dsa(netdev))
 		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 			      GDM_STAG_EN_MASK);
@@ -1879,7 +1882,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
-	struct airoha_qdma *qdma = dev->qdma;
+	struct airoha_qdma *qdma;
 	int i;
 
 	netif_tx_disable(netdev);
@@ -1887,6 +1890,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 	for (i = 0; i < netdev->num_tx_queues; i++)
 		netdev_tx_reset_subqueue(netdev, i);
 
+	qdma = airoha_qdma_deref(dev);
 	if (--port->users)
 		airoha_set_port_mtu(dev->eth, port);
 	else
@@ -1979,6 +1983,52 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 	return 0;
 }
 
+static int airoha_disable_gdm2_loopback(struct airoha_gdm_dev *dev)
+{
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
+	int i, src_port;
+	u32 pse_port;
+
+	src_port = eth->soc->ops.get_sport(dev->port, dev->nbq);
+	if (src_port < 0)
+		return src_port;
+
+	airoha_fe_clear(eth,
+			REG_SP_DFT_CPORT(src_port >> fls(SP_CPORT_DFT_MASK)),
+			SP_CPORT_MASK(src_port & SP_CPORT_DFT_MASK));
+
+	airoha_fe_set(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+		      GDM_STRIP_CRC_MASK);
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+				    FE_PSE_PORT_DROP);
+	airoha_fe_clear(eth, REG_GDM_LPBK_CFG(AIROHA_GDM2_IDX),
+			LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK);
+	pse_port = airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
+						 : FE_PSE_PORT_PPE1;
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+				    pse_port);
+
+	airoha_fe_rmw(eth, REG_FE_WAN_PORT, WAN0_MASK,
+		      FIELD_PREP(WAN0_MASK, AIROHA_GDM2_IDX));
+
+	for (i = 0; i < eth->soc->num_ppe; i++)
+		airoha_ppe_clear_cpu_port(dev, i, AIROHA_GDM2_IDX);
+
+	/* Enable VIP and IFC for GDM2 */
+	airoha_fe_set(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
+	airoha_fe_set(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
+
+	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
+		u32 mask = FC_ID_OF_SRC_PORT_MASK(dev->nbq);
+
+		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
+			      FC_MAP6_DEF_VALUE & mask);
+	}
+
+	return 0;
+}
+
 static struct airoha_gdm_dev *
 airoha_get_wan_gdm_dev(struct airoha_eth *eth)
 {
@@ -2005,15 +2055,36 @@ airoha_get_wan_gdm_dev(struct airoha_eth *eth)
 static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
 {
 	struct net_device *netdev = netdev_from_priv(dev);
+	struct airoha_qdma *cur_qdma, *qdma;
 	struct airoha_eth *eth = dev->eth;
 	int ppe_id;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
-	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
-	netdev->irq = dev->qdma->irq_banks[0].irq;
+	qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
+	cur_qdma = airoha_qdma_deref(dev);
+	if (netif_running(netdev))
+		airoha_qdma_start(qdma);
+
+	/* Serialize QDMA pointer and PPE CPU port configuration against
+	 * concurrent airoha_ppe_hw_init() in airoha_ppe_setup_tc_block_cb().
+	 */
+	mutex_lock(&flow_offload_mutex);
+
+	rcu_assign_pointer(dev->qdma, qdma);
+	netdev->irq = qdma->irq_banks[0].irq;
 
 	ppe_id = !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
-	airoha_ppe_set_cpu_port(dev, ppe_id, airoha_get_fe_port(dev));
+	__airoha_ppe_set_cpu_port(dev, ppe_id, airoha_get_fe_port(dev));
+
+	mutex_unlock(&flow_offload_mutex);
+
+	if (!cur_qdma)
+		return;
+
+	synchronize_rcu();
+
+	if (netif_running(netdev))
+		airoha_qdma_stop(cur_qdma);
 }
 
 static int airoha_dev_init(struct net_device *netdev)
@@ -2177,9 +2248,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_qdma *qdma = dev->qdma;
 	u32 nr_frags, tag, msg0, msg1, len;
 	struct airoha_queue_entry *e;
+	struct airoha_qdma *qdma;
 	struct netdev_queue *txq;
 	struct airoha_queue *q;
 	LIST_HEAD(tx_list);
@@ -2188,6 +2259,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	u16 index;
 	u8 fport;
 
+	rcu_read_lock();
+	qdma = rcu_dereference(dev->qdma);
 	qid = airoha_qdma_get_txq(qdma, skb_get_queue_mapping(skb));
 	tag = airoha_get_dsa_tag(skb, netdev);
 
@@ -2234,6 +2307,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		netif_tx_stop_queue(txq);
 		q->txq_stopped = true;
 		spin_unlock_bh(&q->lock);
+		rcu_read_unlock();
+
 		return NETDEV_TX_BUSY;
 	}
 
@@ -2296,6 +2371,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
 	spin_unlock_bh(&q->lock);
+	rcu_read_unlock();
 
 	return NETDEV_TX_OK;
 
@@ -2311,6 +2387,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 error:
 	dev_kfree_skb_any(skb);
 	netdev->stats.tx_dropped++;
+	rcu_read_unlock();
 
 	return NETDEV_TX_OK;
 }
@@ -2392,17 +2469,19 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 					 const u16 *weights, u8 n_weights)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma;
 	int i;
 
+	qdma = airoha_qdma_deref(dev);
 	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
-		airoha_qdma_clear(dev->qdma, REG_QUEUE_CLOSE_CFG(channel),
+		airoha_qdma_clear(qdma, REG_QUEUE_CLOSE_CFG(channel),
 				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
 
 	for (i = 0; i < n_weights; i++) {
 		u32 status;
 		int err;
 
-		airoha_qdma_wr(dev->qdma, REG_TXWRR_WEIGHT_CFG,
+		airoha_qdma_wr(qdma, REG_TXWRR_WEIGHT_CFG,
 			       TWRR_RW_CMD_MASK |
 			       FIELD_PREP(TWRR_CHAN_IDX_MASK, channel) |
 			       FIELD_PREP(TWRR_QUEUE_IDX_MASK, i) |
@@ -2410,12 +2489,12 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 		err = read_poll_timeout(airoha_qdma_rr, status,
 					status & TWRR_RW_CMD_DONE,
 					USEC_PER_MSEC, 10 * USEC_PER_MSEC,
-					true, dev->qdma, REG_TXWRR_WEIGHT_CFG);
+					true, qdma, REG_TXWRR_WEIGHT_CFG);
 		if (err)
 			return err;
 	}
 
-	airoha_qdma_rmw(dev->qdma, REG_CHAN_QOS_MODE(channel >> 3),
+	airoha_qdma_rmw(qdma, REG_CHAN_QOS_MODE(channel >> 3),
 			CHAN_QOS_MODE_MASK(channel),
 			__field_prep(CHAN_QOS_MODE_MASK(channel), mode));
 
@@ -2479,13 +2558,15 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_qdma *qdma = dev->qdma;
+	u64 cpu_tx_packets, fwd_tx_packets, tx_packets;
+	struct airoha_qdma *qdma;
 
-	u64 cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
-	u64 fwd_tx_packets = airoha_qdma_rr(qdma,
-					    REG_CNTR_VAL((channel << 1) + 1));
-	u64 tx_packets = (cpu_tx_packets - dev->cpu_tx_packets) +
-			 (fwd_tx_packets - dev->fwd_tx_packets);
+	qdma = airoha_qdma_deref(dev);
+	cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
+	fwd_tx_packets = airoha_qdma_rr(qdma,
+					REG_CNTR_VAL((channel << 1) + 1));
+	tx_packets = (cpu_tx_packets - dev->cpu_tx_packets) +
+		     (fwd_tx_packets - dev->fwd_tx_packets);
 
 	_bstats_update(opt->stats.bstats, 0, tx_packets);
 	dev->cpu_tx_packets = cpu_tx_packets;
@@ -2745,16 +2826,18 @@ static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
 					 u32 bucket_size)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma;
 	int i, err;
 
+	qdma = airoha_qdma_deref(dev);
 	for (i = 0; i <= TRTCM_PEAK_MODE; i++) {
-		err = airoha_qdma_set_trtcm_config(dev->qdma, channel,
+		err = airoha_qdma_set_trtcm_config(qdma, channel,
 						   REG_EGRESS_TRTCM_CFG, i,
 						   !!rate, TRTCM_METER_MODE);
 		if (err)
 			return err;
 
-		err = airoha_qdma_set_trtcm_token_bucket(dev->qdma, channel,
+		err = airoha_qdma_set_trtcm_token_bucket(qdma, channel,
 							 REG_EGRESS_TRTCM_CFG,
 							 i, rate, bucket_size);
 		if (err)
@@ -2790,11 +2873,12 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	int err, num_tx_queues = netdev->real_num_tx_queues;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_qdma *qdma = dev->qdma;
+	struct airoha_qdma *qdma;
 
 	/* Here we need to check the requested QDMA channel is not already
 	 * in use by another net_device running on the same QDMA block.
 	 */
+	qdma = airoha_qdma_deref(dev);
 	if (test_and_set_bit(channel, qdma->qos_channel_map)) {
 		NL_SET_ERR_MSG_MOD(opt->extack,
 				   "qdma qos channel already in use");
@@ -2828,7 +2912,7 @@ static int airoha_qdma_set_rx_meter(struct airoha_gdm_dev *dev,
 				    u32 rate, u32 bucket_size,
 				    enum trtcm_unit_type unit_type)
 {
-	struct airoha_qdma *qdma = dev->qdma;
+	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
@@ -3002,11 +3086,12 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_qdma *qdma = dev->qdma;
+	struct airoha_qdma *qdma;
 
 	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
 	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
 
+	qdma = airoha_qdma_deref(dev);
 	clear_bit(queue, qdma->qos_channel_map);
 	clear_bit(queue, dev->qos_sq_bmap);
 }
@@ -3027,6 +3112,89 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 	return 0;
 }
 
+static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
+				       struct netlink_ext_ack *extack)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
+	int err;
+
+	if (port->id != AIROHA_GDM3_IDX &&
+	    port->id != AIROHA_GDM4_IDX) {
+		/* HW QoS is always supported by GDM1 and GDM2 */
+		return 0;
+	}
+
+	if (!airoha_is_lan_gdm_dev(dev)) /* Already enabled */
+		return 0;
+
+	/* Verify the WAN device is not already configured */
+	if (airoha_get_wan_gdm_dev(eth)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "WAN device already configured");
+		return -EBUSY;
+	}
+
+	dev->flags |= AIROHA_PRIV_F_WAN;
+	airoha_dev_set_qdma(dev);
+	err = airoha_enable_gdm2_loopback(dev);
+	if (err)
+		goto error_disable_wan;
+
+	err = airoha_set_macaddr(dev, netdev->dev_addr);
+	if (err)
+		goto error_disable_loopback;
+
+	if (netif_running(netdev)) {
+		u32 pse_port;
+
+		pse_port = airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
+							 : FE_PSE_PORT_PPE1;
+		airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(port->id),
+					    pse_port);
+	}
+
+	return 0;
+
+error_disable_loopback:
+	/* Restore previous LAN configuration */
+	airoha_disable_gdm2_loopback(dev);
+error_disable_wan:
+	dev->flags &= ~AIROHA_PRIV_F_WAN;
+	airoha_dev_set_qdma(dev);
+
+	return err;
+}
+
+static void airoha_disable_qos_for_gdm34(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
+	int err;
+
+	if (port->id != AIROHA_GDM3_IDX &&
+	    port->id != AIROHA_GDM4_IDX) {
+		return;
+	}
+
+	if (airoha_is_lan_gdm_dev(dev)) /* Already disabled */
+		return;
+
+	err = airoha_disable_gdm2_loopback(dev);
+	if (err)
+		netdev_warn(netdev,
+			    "failed disabling GDM2 loopback: %d\n", err);
+
+	dev->flags &= ~AIROHA_PRIV_F_WAN;
+	airoha_dev_set_qdma(dev);
+	airoha_set_macaddr(dev, netdev->dev_addr);
+	if (netif_running(netdev))
+		airoha_set_gdm_port_fwd_cfg(dev->eth,
+					    REG_GDM_FWD_CFG(port->id),
+					    FE_PSE_PORT_PPE1);
+}
+
 static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
@@ -3035,6 +3203,8 @@ static int airoha_tc_htb_destroy(struct net_device *netdev)
 	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
 		airoha_tc_remove_htb_queue(netdev, q);
 
+	airoha_disable_qos_for_gdm34(netdev);
+
 	return 0;
 }
 
@@ -3059,7 +3229,7 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
 {
 	switch (opt->command) {
 	case TC_HTB_CREATE:
-		break;
+		return airoha_enable_qos_for_gdm34(dev, opt->extack);
 	case TC_HTB_DESTROY:
 		return airoha_tc_htb_destroy(dev);
 	case TC_HTB_NODE_MODIFY:
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8f42973f9cf5..8795af0010b6 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -543,8 +543,8 @@ enum airoha_priv_flags {
 };
 
 struct airoha_gdm_dev {
+	struct airoha_qdma __rcu *qdma;
 	struct airoha_gdm_port *port;
-	struct airoha_qdma *qdma;
 	struct airoha_eth *eth;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
@@ -676,7 +676,27 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev);
 bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 			     struct airoha_gdm_dev *dev);
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport);
+extern struct mutex flow_offload_mutex;
+
+static inline struct airoha_qdma *
+airoha_qdma_deref(struct airoha_gdm_dev *dev)
+{
+	return rcu_dereference_protected(dev->qdma,
+					 lockdep_rtnl_is_held() ||
+					 lockdep_is_held(&flow_offload_mutex));
+}
+
+void __airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport);
+void airoha_ppe_clear_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport);
+
+static inline void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev,
+					   u8 ppe_id, u8 fport)
+{
+	mutex_lock(&flow_offload_mutex);
+	__airoha_ppe_set_cpu_port(dev, ppe_id, fport);
+	mutex_unlock(&flow_offload_mutex);
+}
+
 bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
 void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 			  u16 hash, bool rx_wlan);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 91bcc55a6ac6..0ee0dd385645 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -15,7 +15,7 @@
 #include "airoha_regs.h"
 #include "airoha_eth.h"
 
-static DEFINE_MUTEX(flow_offload_mutex);
+DEFINE_MUTEX(flow_offload_mutex);
 static DEFINE_SPINLOCK(ppe_lock);
 
 static const struct rhashtable_params airoha_flow_table_params = {
@@ -84,10 +84,10 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 			     AIROHA_FOE_IB1_BIND_TIMESTAMP);
 }
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport)
+void __airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport)
 {
-	struct airoha_qdma *qdma = dev->qdma;
-	struct airoha_eth *eth = qdma->eth;
+	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
+	struct airoha_eth *eth = dev->eth;
 	u8 qdma_id = qdma - &eth->qdma[0];
 	u32 fe_cpu_port;
 
@@ -97,6 +97,14 @@ void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport)
 		      __field_prep(DFT_CPORT_MASK(fport), fe_cpu_port));
 }
 
+void airoha_ppe_clear_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport)
+{
+	mutex_lock(&flow_offload_mutex);
+	airoha_fe_clear(dev->eth, REG_PPE_DFT_CPORT(ppe_id, fport),
+			DFT_CPORT_MASK(fport));
+	mutex_unlock(&flow_offload_mutex);
+}
+
 static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 {
 	u32 sram_ppe_num_data_entries = PPE_SRAM_NUM_ENTRIES, sram_num_entries;
@@ -195,7 +203,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			ppe_id = !airoha_is_lan_gdm_dev(dev) &&
 				 airoha_ppe_is_enabled(eth, 1);
 			fport = airoha_get_fe_port(dev);
-			airoha_ppe_set_cpu_port(dev, ppe_id, fport);
+			__airoha_ppe_set_cpu_port(dev, ppe_id, fport);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..4e17dfbcf2b8 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -376,6 +376,7 @@
 
 #define REG_SRC_PORT_FC_MAP6		0x2298
 #define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
+#define FC_MAP6_DEF_VALUE		0x1b1a1918
 
 #define REG_CDM5_RX_OQ1_DROP_CNT	0x29d4
 

-- 
2.54.0


