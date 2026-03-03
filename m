Return-Path: <netdev+bounces-263261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEkIG633pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:01:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 102741F1EE9
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8B5E304F6CA
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CEC3D75C0;
	Tue,  3 Mar 2026 14:58:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F813D5651;
	Tue,  3 Mar 2026 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549939; cv=none; b=HxHLC6k4ftfkzPa1VxV1L/hCHbfQ0PXQrOn5AqzP9AjGGUMwspQbP4Dw6UqbEHanBA4iIx1B4PJoITnD487IOD9iNGDP6lxB8ov3YrH92jPv0ojqlheCEcWCGXteWalfopEoh8vnlJGXeMW/9jA6sxraWaQ3R/wzeBBLfaUoF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549939; c=relaxed/simple;
	bh=C4356gas4yxYUHodweEZbzXX2g6jB6SVAnqNCI976ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gjtw7vWivGjlspjQrIBkbMc3mGTbGH+/ap7nxwA88AgXpkcSybszNwgGE45qTOcmT39rfx09syh1uCx4nI7UCdwjBf3oEf2ZWole4/XIKZhXQonRhX0IOwAAMZPFePzQTyh48J4fhcpm9WG8a7JraatcSPkAmudQs5KZ06Wrhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: KDc5Hfc0Sse6lgeiaEJN8w==
X-CSE-MsgGUID: XJTvLmIRTNek0bFMqTUZOQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Mar 2026 23:58:56 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.15])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 00848400D0EA;
	Tue,  3 Mar 2026 23:58:49 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	boon.khai.ng@altera.com,
	rohan.g.thomas@altera.com,
	vladimir.oltean@nxp.com,
	hayashi.kunihiko@socionext.com,
	boon.leong.ong@intel.com,
	kim.tatt.chuah@intel.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/4] net: stmmac: Fix VLAN HW state restore
Date: Tue,  3 Mar 2026 14:58:27 +0000
Message-ID: <20260303145828.7845-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303145828.7845-1-ovidiu.panait.rb@renesas.com>
References: <20260303145828.7845-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 102741F1EE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263261-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.572];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,renesas.com:mid,renesas.com:email]
X-Rspamd-Action: no action

When the network interface is opened or resumed, a DMA reset is performed,
which resets all hardware state, including VLAN state. Currently, only
the resume path is restoring the VLAN state via
stmmac_restore_hw_vlan_rx_fltr(), but that is incomplete: the VLAN hash
table and the VLAN_TAG control bits are not restored.

Therefore, add stmmac_vlan_restore(), which restores the full VLAN
state by updating both the HW filter entries and the hash table, and
call it from both the open and resume paths.

The VLAN restore is moved outside of phylink_rx_clk_stop_block/unblock
in the resume path because receive clock stop is already disabled when
stmmac supports VLAN.

Also, remove the hash readback code in vlan_restore_hw_rx_fltr() that
attempts to restore VTHM by reading VLAN_HASH_TABLE, as it always reads
zero after DMA reset, making it dead code.

Fixes: 3cd1cfcba26e ("net: stmmac: Implement VLAN Hash Filtering in XGMAC")
Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v3 changes: none.

v2 changes: new patch.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 24 +++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 10 --------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2365b12fbe05..a8fb091d7b5d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -157,6 +157,7 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue);
 static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue);
 static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 					  u32 rxmode, u32 chan);
+static int stmmac_vlan_restore(struct stmmac_priv *priv);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
@@ -4111,6 +4112,8 @@ static int __stmmac_open(struct net_device *dev,
 
 	phylink_start(priv->phylink);
 
+	stmmac_vlan_restore(priv);
+
 	ret = stmmac_request_irq(dev);
 	if (ret)
 		goto irq_error;
@@ -6858,6 +6861,23 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 	return ret;
 }
 
+static int stmmac_vlan_restore(struct stmmac_priv *priv)
+{
+	int ret;
+
+	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
+		return 0;
+
+	if (priv->hw->num_vlan)
+		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
+
+	ret = stmmac_vlan_update(priv, priv->num_double_vlans);
+	if (ret)
+		netdev_err(priv->dev, "Failed to restore VLANs\n");
+
+	return ret;
+}
+
 static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -8282,10 +8302,10 @@ int stmmac_resume(struct device *dev)
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_rx_mode(ndev);
-
-	stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
 	phylink_rx_clk_stop_unblock(priv->phylink);
 
+	stmmac_vlan_restore(priv);
+
 	stmmac_enable_all_queues(priv);
 	stmmac_enable_all_dma_irq(priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index de1a70e1c86e..fcc34867405e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -139,9 +139,6 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 				    struct mac_device_info *hw)
 {
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-	u32 hash;
 	u32 val;
 	int i;
 
@@ -158,13 +155,6 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 			vlan_write_filter(dev, hw, i, val);
 		}
 	}
-
-	hash = readl(ioaddr + VLAN_HASH_TABLE);
-	if (hash & VLAN_VLHT) {
-		value = readl(ioaddr + VLAN_TAG);
-		value |= VLAN_VTHM;
-		writel(value, ioaddr + VLAN_TAG);
-	}
 }
 
 static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
-- 
2.51.0


