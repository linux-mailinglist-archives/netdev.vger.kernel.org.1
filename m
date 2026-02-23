Return-Path: <netdev+bounces-260025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOnzIOJMnGnYDQQAu9opvQ
	(envelope-from <netdev+bounces-260025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:49:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4BF17672C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 157C930F11A3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1020136606F;
	Mon, 23 Feb 2026 12:41:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE213659E0;
	Mon, 23 Feb 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850488; cv=none; b=a1Vt2uhXr6UrUzCeCBzDjbrpzfJYZu2YZ4JhGvUknqbctpORXpUyt3Svy9mYRy8PopO3uyIrra8FXhD8RbdCDot5nX2JPG+swcj5KPVNWqsyDR5euB503PAY/1QLSloUr9YoOA2us6Kd9MRDOPjLE/nEwEfOlNZS7rDmjUUmqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850488; c=relaxed/simple;
	bh=V9qSZ1YOacGlIYDV7EenF11qDRp/oAc/mQ1Jr8b558o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyZ7dswzh9lK4X44CWm1RzTFNT9MFeO13ACg0Q0lOps905F0b8ZtmShDJsS+Xru+HWpmdQjcnrSiCVBewok/3y5/CxZM6SuhoWLziDl6I1VtvLdHfwHgLR3KNmf2RsmC/Xb5VIMsFxV2+T1gNKmhxFcVR8bNHRqLnVu7hV89Tbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 73CCg/46RoWhw5x0yhoOvw==
X-CSE-MsgGUID: Wv1cVRZARwmnx9IONG74hA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Feb 2026 21:41:25 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1AB1F41AB637;
	Mon, 23 Feb 2026 21:41:18 +0900 (JST)
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
Subject: [PATCH net-next 2/4] net: stmmac: Improve double VLAN handling
Date: Mon, 23 Feb 2026 12:41:00 +0000
Message-ID: <20260223124102.120432-3-ovidiu.panait.rb@renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260025-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.862];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: DE4BF17672C
X-Rspamd-Action: no action

The double VLAN bits (EDVLP, ESVL, DOVLTC) are handled inconsistently
between the two vlan_update_hash() implementations:

- dwxgmac2_update_vlan_hash() explicitly clears the double VLAN bits when
is_double is false, meaning that adding a 802.1Q VLAN will disable
double VLAN mode:

  $ ip link add link eth0 name eth0.200 type vlan id 200 protocol 802.1ad
  $ ip link add link eth0 name eth0.100 type vlan id 100
  # Double VLAN bits no longer set

- vlan_update_hash() sets these bits and only clears them when the last
VLAN has been removed, so double VLAN mode remains enabled even after all
802.1AD VLANs are removed.

Address both issues by tracking the number of active 802.1AD VLANs in
priv->num_double_vlans. Pass this count to stmmac_vlan_update() so both
implementations correctly set the double VLAN bits when any 802.1AD
VLAN is active, and clear them only when none remain.

Also update vlan_update_hash() to explicitly clear the double VLAN bits
when is_double is false, matching the dwxgmac2 behavior.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h     |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c    |  8 ++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 51c96a738151..33667a26708c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -323,6 +323,7 @@ struct stmmac_priv {
 	void __iomem *ptpaddr;
 	void __iomem *estaddr;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	unsigned int num_double_vlans;
 	int sfty_irq;
 	int sfty_ce_irq;
 	int sfty_ue_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f2f120ddba46..45f2f3492dbd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6779,6 +6779,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	unsigned int num_double_vlans;
 	bool is_double = false;
 	int ret;
 
@@ -6790,7 +6791,8 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 		is_double = true;
 
 	set_bit(vid, priv->active_vlans);
-	ret = stmmac_vlan_update(priv, is_double);
+	num_double_vlans = priv->num_double_vlans + is_double;
+	ret = stmmac_vlan_update(priv, num_double_vlans);
 	if (ret) {
 		clear_bit(vid, priv->active_vlans);
 		goto err_pm_put;
@@ -6800,11 +6802,13 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
 		if (ret) {
 			clear_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, is_double);
+			stmmac_vlan_update(priv, priv->num_double_vlans);
 			goto err_pm_put;
 		}
 	}
 
+	priv->num_double_vlans = num_double_vlans;
+
 err_pm_put:
 	pm_runtime_put(priv->device);
 
@@ -6817,6 +6821,7 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	unsigned int num_double_vlans;
 	bool is_double = false;
 	int ret;
 
@@ -6828,7 +6833,8 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 		is_double = true;
 
 	clear_bit(vid, priv->active_vlans);
-	ret = stmmac_vlan_update(priv, is_double);
+	num_double_vlans = priv->num_double_vlans - is_double;
+	ret = stmmac_vlan_update(priv, num_double_vlans);
 	if (ret) {
 		set_bit(vid, priv->active_vlans);
 		goto del_vlan_error;
@@ -6838,11 +6844,13 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
 		if (ret) {
 			set_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, is_double);
+			stmmac_vlan_update(priv, priv->num_double_vlans);
 			goto del_vlan_error;
 		}
 	}
 
+	priv->num_double_vlans = num_double_vlans;
+
 del_vlan_error:
 	pm_runtime_put(priv->device);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index b18404dd5a8b..de1a70e1c86e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -183,6 +183,10 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
 			value |= VLAN_EDVLP;
 			value |= VLAN_ESVL;
 			value |= VLAN_DOVLTC;
+		} else {
+			value &= ~VLAN_EDVLP;
+			value &= ~VLAN_ESVL;
+			value &= ~VLAN_DOVLTC;
 		}
 
 		writel(value, ioaddr + VLAN_TAG);
@@ -193,6 +197,10 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
 			value |= VLAN_EDVLP;
 			value |= VLAN_ESVL;
 			value |= VLAN_DOVLTC;
+		} else {
+			value &= ~VLAN_EDVLP;
+			value &= ~VLAN_ESVL;
+			value &= ~VLAN_DOVLTC;
 		}
 
 		writel(value | perfect_match, ioaddr + VLAN_TAG);
-- 
2.34.1


