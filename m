Return-Path: <netdev+bounces-260985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PyIIkgHn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:29:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AC7198BFF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21E6430E2BA5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72813B8D4A;
	Wed, 25 Feb 2026 14:24:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5983D349B;
	Wed, 25 Feb 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029497; cv=none; b=QLCmP6DIZuNbyFbYwrlgQDkV4lYc41vmjrDQm2XXx8BCJJt1sEp54SzQbnmn3eSAhiXGJD2nSZGIVJK3ShGhPd5v7kMJv0JAelj30X4nSeKOS6U6VzutL9RYR10AXEc4MwhYD80zJxXPZhwXedPWKp/Xj4upXaJ3MeCAgIT+cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029497; c=relaxed/simple;
	bh=+RmBZM1X2mmeQ5E0ux8AhVEjIHMn5mMEsxCjHMYhfOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqL2ZpZGLivHnkTK0At7IaB4kUr5hZqcsNXOhdEVfMuo6AW5bZbEn/F1cIEni1/JGfG348hRe3KQOBqzlnBIm5vHYCb6FpJ6ML2jFNZz7pFIzrlkw8IVJ11fzu/hR3fsnZZovwkMh6smzoRD1TkztP/r3UMBqE70VM8Iq3IRKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: wjXg1zDVTHaep9JmLwo6EA==
X-CSE-MsgGUID: pbnM9QIVQWudH1d9Ob5JRQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Feb 2026 23:24:55 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B10104017D8D;
	Wed, 25 Feb 2026 23:24:49 +0900 (JST)
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
Subject: [PATCH net-next v2 5/5] net: stmmac: Defer VLAN HW configuration when interface is down
Date: Wed, 25 Feb 2026 14:24:14 +0000
Message-ID: <20260225142414.130144-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225142414.130144-1-ovidiu.panait.rb@renesas.com>
References: <20260225142414.130144-1-ovidiu.panait.rb@renesas.com>
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
	TAGGED_FROM(0.00)[bounces-260985-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:mid,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2AC7198BFF
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

When the interface is brought up, stmmac_vlan_restore() is called
to write the VLAN state to hardware.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v2 changes:
- Split this commit - added a new commit (3/5) which fixes VLAN
  restore on resume and open paths.
- Dropped phylink_rx_clk_stop_block()/unblock() calls around VLAN restore.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++------
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c    |  9 ++-------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 19c86e3b42cc..1098227272ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6787,6 +6787,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double,
 static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	bool write_hw = netif_running(ndev);
 	unsigned int num_double_vlans;
 	bool is_double = false;
 	int ret;
@@ -6800,7 +6801,7 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 
 	set_bit(vid, priv->active_vlans);
 	num_double_vlans = priv->num_double_vlans + is_double;
-	ret = stmmac_vlan_update(priv, num_double_vlans, true);
+	ret = stmmac_vlan_update(priv, num_double_vlans, write_hw);
 	if (ret) {
 		clear_bit(vid, priv->active_vlans);
 		goto err_pm_put;
@@ -6808,10 +6809,11 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 
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
@@ -6830,6 +6832,7 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	bool write_hw = netif_running(ndev);
 	unsigned int num_double_vlans;
 	bool is_double = false;
 	int ret;
@@ -6843,7 +6846,7 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 
 	clear_bit(vid, priv->active_vlans);
 	num_double_vlans = priv->num_double_vlans - is_double;
-	ret = stmmac_vlan_update(priv, num_double_vlans, true);
+	ret = stmmac_vlan_update(priv, num_double_vlans, write_hw);
 	if (ret) {
 		set_bit(vid, priv->active_vlans);
 		goto del_vlan_error;
@@ -6851,10 +6854,11 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index f81015179d04..261bc751ade2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -147,7 +147,6 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 				    struct mac_device_info *hw)
 {
-	u32 val;
 	int i;
 
 	/* Single Rx VLAN Filter */
@@ -157,12 +156,8 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
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
 }
 
 static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
-- 
2.51.0


