Return-Path: <netdev+bounces-260027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP7pJQFNnGnYDQQAu9opvQ
	(envelope-from <netdev+bounces-260027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:50:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE817673B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4CC53124161
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE07366045;
	Mon, 23 Feb 2026 12:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B9C366044;
	Mon, 23 Feb 2026 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850502; cv=none; b=eC6AspBmMsMB/lWsyoAvY3E71LYNHY62dRvVrUEbqNP4Y+KfHXY56fh8T+PD4U9RDu19fxTE5bkIRmBNqTSNYUUZ5fu7tHokMij9oFi4OdkLsDZDGduiwi0ofv/hsBHzmoaarrVznD5zGcK+0VWymeTyY+3DznvlEOTFPLEEaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850502; c=relaxed/simple;
	bh=my3ie864iTaDCoQbedVs3qsRAL84M9L7UnzCUL3bZ9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPvE0w8zNOtLAqvVptXaQrr5hXS74ys0LSZEeYqBGpeWM4viCdqPjFfYhnAeULGwr/N+U6XRnTYWBMQ0MHqC1JLgHbEejwcuJmqjFATBn4iXszGYsXOmkpeypDpmPHxLUsDoq5LfFQTNNhapw24adhVW9VdQDQYDNopFSLOaaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: RATekyJ1R5yKNNf7lStgUQ==
X-CSE-MsgGUID: y0YMchb9Q8eDUObnCEjfig==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Feb 2026 21:41:40 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DEB7641AB637;
	Mon, 23 Feb 2026 21:41:33 +0900 (JST)
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
	matthew.gerlach@altera.com,
	vee.khee.wong@intel.com,
	boon.leong.ong@intel.com,
	kim.tatt.chuah@intel.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: stmmac: Defer VLAN HW configuration when interface is down
Date: Mon, 23 Feb 2026 12:41:02 +0000
Message-ID: <20260223124102.120432-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223124102.120432-1-ovidiu.panait.rb@renesas.com>
References: <20260223124102.120432-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260027-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.860];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 1BFE817673B
X-Rspamd-Action: no action

VLAN register accesses on the MAC side require the PHY RX clock to be
active. When the network interface is down, the PHY is suspended and
the RX clock is unavailable, causing VLAN operations to fail with
timeouts.

The VLAN core automatically removes VID 0 after the interface goes down
and re-adds it when it comes back up, so these timeouts happen during
normal interface down/up:

    # ip link set end1 down
    renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    renesas-gbeth 15c40000.ethernet end1: failed to kill vid 0081/0

Adding VLANs while the interface is down also fails:

    # ip link add link end1 name end1.10 type vlan id 10
    renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    RTNETLINK answers: Device or resource busy

Use the write_hw parameter introduced in the previous commit to skip
hardware register writes when the interface is down. The software state
is always kept up to date regardless of interface state.

When the interface is brought up, stmmac_vlan_configure() is called
to write the VLAN state to hardware.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 +++++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c |  9 ++---
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 536668a0d6dd..d0aede23ae0d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -156,6 +156,7 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue);
 static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue);
 static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 					  u32 rxmode, u32 chan);
+static int stmmac_vlan_configure(struct stmmac_priv *priv);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
@@ -4111,6 +4112,14 @@ static int __stmmac_open(struct net_device *dev,
 
 	phylink_start(priv->phylink);
 
+	if (dev->features & NETIF_F_VLAN_FEATURES) {
+		phylink_rx_clk_stop_block(priv->phylink);
+		ret = stmmac_vlan_configure(priv);
+		phylink_rx_clk_stop_unblock(priv->phylink);
+		if (ret)
+			netdev_err(dev, "Failed to configure VLANs\n");
+	}
+
 	ret = stmmac_request_irq(dev);
 	if (ret)
 		goto irq_error;
@@ -6784,6 +6793,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double,
 static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	bool write_hw = netif_running(ndev);
 	unsigned int num_double_vlans;
 	bool is_double = false;
 	int ret;
@@ -6797,7 +6807,7 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 
 	set_bit(vid, priv->active_vlans);
 	num_double_vlans = priv->num_double_vlans + is_double;
-	ret = stmmac_vlan_update(priv, num_double_vlans, true);
+	ret = stmmac_vlan_update(priv, num_double_vlans, write_hw);
 	if (ret) {
 		clear_bit(vid, priv->active_vlans);
 		goto err_pm_put;
@@ -6805,10 +6815,11 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 
 	if (priv->hw->num_vlan) {
 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto,
-						 vid, true);
+						 vid, write_hw);
 		if (ret) {
 			clear_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, priv->num_double_vlans, true);
+			stmmac_vlan_update(priv, priv->num_double_vlans,
+					   write_hw);
 			goto err_pm_put;
 		}
 	}
@@ -6827,6 +6838,7 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	bool write_hw = netif_running(ndev);
 	unsigned int num_double_vlans;
 	bool is_double = false;
 	int ret;
@@ -6840,7 +6852,7 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 
 	clear_bit(vid, priv->active_vlans);
 	num_double_vlans = priv->num_double_vlans - is_double;
-	ret = stmmac_vlan_update(priv, num_double_vlans, true);
+	ret = stmmac_vlan_update(priv, num_double_vlans, write_hw);
 	if (ret) {
 		set_bit(vid, priv->active_vlans);
 		goto del_vlan_error;
@@ -6848,10 +6860,11 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 
 	if (priv->hw->num_vlan) {
 		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto,
-						 vid, true);
+						 vid, write_hw);
 		if (ret) {
 			set_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, priv->num_double_vlans, true);
+			stmmac_vlan_update(priv, priv->num_double_vlans,
+					   write_hw);
 			goto del_vlan_error;
 		}
 	}
@@ -6864,6 +6877,14 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 	return ret;
 }
 
+static int stmmac_vlan_configure(struct stmmac_priv *priv)
+{
+	if (priv->hw->num_vlan)
+		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
+
+	return stmmac_vlan_update(priv, priv->num_double_vlans, true);
+}
+
 static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index b74c173da1b5..070c11870c02 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -150,7 +150,6 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 	u32 hash;
-	u32 val;
 	int i;
 
 	/* Single Rx VLAN Filter */
@@ -160,12 +159,8 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 	}
 
 	/* Extended Rx VLAN Filter Enable */
-	for (i = 0; i < hw->num_vlan; i++) {
-		if (hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) {
-			val = hw->vlan_filter[i];
-			vlan_write_filter(dev, hw, i, val);
-		}
-	}
+	for (i = 0; i < hw->num_vlan; i++)
+		vlan_write_filter(dev, hw, i, hw->vlan_filter[i]);
 
 	hash = readl(ioaddr + VLAN_HASH_TABLE);
 	if (hash & VLAN_VLHT) {
-- 
2.34.1


