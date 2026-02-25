Return-Path: <netdev+bounces-260984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLc5Ag8Hn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:28:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC95198BC3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C1830BF994
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93B3B8D4A;
	Wed, 25 Feb 2026 14:24:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4059D392822;
	Wed, 25 Feb 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029492; cv=none; b=UY8un1aUfdYTaBlPnUvnvM7qeTRLFAa7dvmcmOWEDmpSKrZCEHWmD0W0YJcTusf6U4ZlMImbX1wx5WredXRQMF63auFRmZXVPxlRI52+1LoVBzW9vajOJTuIwWL/Q9pjlHVIHe6ycopbGxLwYxw4FCfdEpZf73q5VAeE61+Nm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029492; c=relaxed/simple;
	bh=90v2V3edTeUdWM0oAbEoX+Yh7zyuJt/oEpYWh3miwjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwPM/wwlb8jXwo7QORy4TR5qre9evxKWRP2W4ByWVZ3iPZXCocWmD8ZYUGJzTLlLqYLvhOK/Ls4yWDSdH3u5oow85BQJmTvSe3jgG5iG7AzOxTxWPA1xSZP2IbaHaqQBV8laA46nqUfuXPQcAYYmm1LKxaWmC0rmOq3iFbcM4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: L+IALaWDRBO0q4YalVUyWw==
X-CSE-MsgGUID: cCWN2MKST6q+m7KfE0ELWQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Feb 2026 23:24:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D25B14017D8D;
	Wed, 25 Feb 2026 23:24:42 +0900 (JST)
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
Subject: [PATCH net-next v2 4/5] net: stmmac: Add write_hw parameter to VLAN filter operations
Date: Wed, 25 Feb 2026 14:24:13 +0000
Message-ID: <20260225142414.130144-5-ovidiu.panait.rb@renesas.com>
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
	TAGGED_FROM(0.00)[bounces-260984-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:mid,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AC95198BC3
X-Rspamd-Action: no action

Add a write_hw parameter to the VLAN add/delete HW filter functions and
to stmmac_vlan_update(). This flag controls whether the actual hardware
register accesses are performed. When set to false, only the software
state is updated.

The next commit will use this to defer hardware writes when the
interface is down.

No functional change.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v2 changes: none.

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  6 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 34 ++++++++++++-------
 3 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 0db96a387259..d7598c76251f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -647,10 +647,12 @@ struct stmmac_vlan_ops {
 	void (*set_hw_vlan_mode)(struct mac_device_info *hw);
 	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
 				   struct mac_device_info *hw,
-				   __be16 proto, u16 vid);
+				   __be16 proto, u16 vid,
+				   bool write_hw);
 	int (*del_hw_vlan_rx_fltr)(struct net_device *dev,
 				   struct mac_device_info *hw,
-				   __be16 proto, u16 vid);
+				   __be16 proto, u16 vid,
+				   bool write_hw);
 	void (*restore_hw_vlan_rx_fltr)(struct net_device *dev,
 					struct mac_device_info *hw);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a02575f67057..19c86e3b42cc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6751,7 +6751,8 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
 	return crc;
 }
 
-static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
+static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double,
+			      bool write_hw)
 {
 	u32 crc, hash = 0;
 	u16 pmatch = 0;
@@ -6773,7 +6774,11 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		hash = 0;
 	}
 
-	return stmmac_update_vlan_hash(priv, priv->hw, hash, pmatch, is_double);
+	if (write_hw)
+		return stmmac_update_vlan_hash(priv, priv->hw, hash, pmatch,
+					       is_double);
+
+	return 0;
 }
 
 /* FIXME: This may need RXC to be running, but it may be called with BH
@@ -6795,17 +6800,18 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 
 	set_bit(vid, priv->active_vlans);
 	num_double_vlans = priv->num_double_vlans + is_double;
-	ret = stmmac_vlan_update(priv, num_double_vlans);
+	ret = stmmac_vlan_update(priv, num_double_vlans, true);
 	if (ret) {
 		clear_bit(vid, priv->active_vlans);
 		goto err_pm_put;
 	}
 
 	if (priv->hw->num_vlan) {
-		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
+		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto,
+						 vid, true);
 		if (ret) {
 			clear_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, priv->num_double_vlans);
+			stmmac_vlan_update(priv, priv->num_double_vlans, true);
 			goto err_pm_put;
 		}
 	}
@@ -6837,17 +6843,18 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 
 	clear_bit(vid, priv->active_vlans);
 	num_double_vlans = priv->num_double_vlans - is_double;
-	ret = stmmac_vlan_update(priv, num_double_vlans);
+	ret = stmmac_vlan_update(priv, num_double_vlans, true);
 	if (ret) {
 		set_bit(vid, priv->active_vlans);
 		goto del_vlan_error;
 	}
 
 	if (priv->hw->num_vlan) {
-		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
+		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto,
+						 vid, true);
 		if (ret) {
 			set_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, priv->num_double_vlans);
+			stmmac_vlan_update(priv, priv->num_double_vlans, true);
 			goto del_vlan_error;
 		}
 	}
@@ -6870,7 +6877,7 @@ static int stmmac_vlan_restore(struct stmmac_priv *priv)
 	if (priv->hw->num_vlan)
 		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
 
-	ret = stmmac_vlan_update(priv, priv->num_double_vlans);
+	ret = stmmac_vlan_update(priv, priv->num_double_vlans, true);
 	if (ret)
 		netdev_err(priv->dev, "Failed to restore VLANs\n");
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index fcc34867405e..f81015179d04 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -53,7 +53,8 @@ static int vlan_write_filter(struct net_device *dev,
 
 static int vlan_add_hw_rx_fltr(struct net_device *dev,
 			       struct mac_device_info *hw,
-			       __be16 proto, u16 vid)
+			       __be16 proto, u16 vid,
+			       bool write_hw)
 {
 	int index = -1;
 	u32 val = 0;
@@ -76,7 +77,8 @@ static int vlan_add_hw_rx_fltr(struct net_device *dev,
 		}
 
 		hw->vlan_filter[0] = vid;
-		vlan_write_single(dev, vid);
+		if (write_hw)
+			vlan_write_single(dev, vid);
 
 		return 0;
 	}
@@ -97,17 +99,21 @@ static int vlan_add_hw_rx_fltr(struct net_device *dev,
 		return -EPERM;
 	}
 
-	ret = vlan_write_filter(dev, hw, index, val);
+	if (write_hw) {
+		ret = vlan_write_filter(dev, hw, index, val);
+		if (ret)
+			return ret;
+	}
 
-	if (!ret)
-		hw->vlan_filter[index] = val;
+	hw->vlan_filter[index] = val;
 
-	return ret;
+	return 0;
 }
 
 static int vlan_del_hw_rx_fltr(struct net_device *dev,
 			       struct mac_device_info *hw,
-			       __be16 proto, u16 vid)
+			       __be16 proto, u16 vid,
+			       bool write_hw)
 {
 	int i, ret = 0;
 
@@ -115,7 +121,8 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 	if (hw->num_vlan == 1) {
 		if ((hw->vlan_filter[0] & VLAN_TAG_VID) == vid) {
 			hw->vlan_filter[0] = 0;
-			vlan_write_single(dev, 0);
+			if (write_hw)
+				vlan_write_single(dev, 0);
 		}
 		return 0;
 	}
@@ -124,12 +131,13 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 	for (i = 0; i < hw->num_vlan; i++) {
 		if ((hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) &&
 		    ((hw->vlan_filter[i] & VLAN_TAG_DATA_VID) == vid)) {
-			ret = vlan_write_filter(dev, hw, i, 0);
+			if (write_hw) {
+				ret = vlan_write_filter(dev, hw, i, 0);
+				if (ret)
+					return ret;
+			}
 
-			if (!ret)
-				hw->vlan_filter[i] = 0;
-			else
-				return ret;
+			hw->vlan_filter[i] = 0;
 		}
 	}
 
-- 
2.51.0


