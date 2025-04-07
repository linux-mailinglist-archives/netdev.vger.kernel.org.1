Return-Path: <netdev+bounces-179993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F95A7F0D6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438403AF8CF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516C22D4F4;
	Mon,  7 Apr 2025 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OP8if3s0"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B322CBEF
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067892; cv=none; b=XSes+liyH0bOMZQwbWkP8+QiJHm8TanjLVXYSl7BVZSeGQp2Jo630oKGc1cInyOCMkQQzjsuE1BqlE/OI8F1vVB1ebWzyRr/OgTDZNfHVj9V6+ezpMp70zc1C3aZg5IjVHZ7CVPcRd7qbfw5NOSE84MrigDDASb4kmLGTrpbmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067892; c=relaxed/simple;
	bh=AC7RcwPVpV3XOV/lZJo+4IGpi7BDO+mqRwD6yNvd4+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fg3meXaAw42hQxBbs+ciX0EPU9ooN3OOn0gD3XWC8BnBi/5DVff4NaOQDAJFlBXhEWsbbjQH3xGkfrlagap1PzQRTEkcx8zrqxU4OKLgsgtmEFPNhF6OvGy+UVNrnDTUg8dPQjrxacJWb2cUWBae0XjGVvtfnmxsHx35oSO8Ly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OP8if3s0; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744067888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6a4Wcye6WJVPgGZBEyX6k0xTnOuI2j7TkoMRNc7qY4=;
	b=OP8if3s0QgKUQHdD/c1/+nU5o+jwZIkLjg5DDcpxeA5FgS+e+1yysHdSnaUdJ7jTdCwNGm
	+iIVAHYxh9Wj5P9GhEBByODpB43nCJMs5rgE8Gu8ewfDchMoRkEKIy+jtCFr4t2Rp4hhtw
	mjPjdX8r9iNuGY+AKHMdSEMCw/OqPJ0=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [net-next PATCH v2 05/14] net: phylink: Support setting PCS link change callbacks
Date: Mon,  7 Apr 2025 19:17:36 -0400
Message-Id: <20250407231746.2316518-6-sean.anderson@linux.dev>
In-Reply-To: <20250407231746.2316518-1-sean.anderson@linux.dev>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Support changing the link change callback, similar to how PHYs do it.
This will allow the PCS wrapper to forward link changes to the wrapped
PCS.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/net/phy/phylink.c | 24 +++++++-----------------
 include/linux/phylink.h   | 27 ++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 69ca765485db..76ce96315c0c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1205,6 +1205,8 @@ static void phylink_pcs_neg_mode(struct phylink *pl, struct phylink_pcs *pcs,
 	pl->act_link_an_mode = mode;
 }
 
+static void pcs_change_callback(void *priv, bool up);
+
 static void phylink_major_config(struct phylink *pl, bool restart,
 				  const struct phylink_link_state *state)
 {
@@ -1260,10 +1262,10 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		phylink_pcs_disable(pl->pcs);
 
 		if (pl->pcs)
-			pl->pcs->phylink = NULL;
-
-		pcs->phylink = pl;
+			pl->pcs->link_change_priv = NULL;
 
+		pcs->link_change = pcs_change_callback;
+		pcs->link_change_priv = pl;
 		pl->pcs = pcs;
 	}
 
@@ -2333,25 +2335,13 @@ void phylink_mac_change(struct phylink *pl, bool up)
 }
 EXPORT_SYMBOL_GPL(phylink_mac_change);
 
-/**
- * phylink_pcs_change() - notify phylink of a change to PCS link state
- * @pcs: pointer to &struct phylink_pcs
- * @up: indicates whether the link is currently up.
- *
- * The PCS driver should call this when the state of its link changes
- * (e.g. link failure, new negotiation results, etc.) Note: it should
- * not determine "up" by reading the BMSR. If in doubt about the link
- * state at interrupt time, then pass true if pcs_get_state() returns
- * the latched link-down state, otherwise pass false.
- */
-void phylink_pcs_change(struct phylink_pcs *pcs, bool up)
+static void pcs_change_callback(void *priv, bool up)
 {
-	struct phylink *pl = pcs->phylink;
+	struct phylink *pl = priv;
 
 	if (pl)
 		phylink_link_changed(pl, up, "pcs");
 }
-EXPORT_SYMBOL_GPL(phylink_pcs_change);
 
 static irqreturn_t phylink_link_handler(int irq, void *data)
 {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 1f5773ab5660..a16282ae746d 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -441,7 +441,8 @@ struct phylink_pcs_ops;
  * @supported_interfaces: describing which PHY_INTERFACE_MODE_xxx
  *                        are supported by this PCS.
  * @ops: a pointer to the &struct phylink_pcs_ops structure
- * @phylink: pointer to &struct phylink_config
+ * @link_change: callback for when the link changes
+ * @link_change_priv: first argument to @link_change
  * @poll: poll the PCS for link changes
  * @rxc_always_on: The MAC driver requires the reference clock
  *                 to always be on. Standalone PCS drivers which
@@ -451,13 +452,14 @@ struct phylink_pcs_ops;
  * This structure is designed to be embedded within the PCS private data,
  * and will be passed between phylink and the PCS.
  *
- * The @phylink member is private to phylink and must not be touched by
- * the PCS driver.
+ * @link_change, @link_change_priv, and @rxc_always_on will be filled in by
+ * phylink.
  */
 struct phylink_pcs {
 	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
 	const struct phylink_pcs_ops *ops;
-	struct phylink *phylink;
+	void (*link_change)(void *priv, bool up);
+	void *link_change_priv;
 	bool poll;
 	bool rxc_always_on;
 };
@@ -699,7 +701,22 @@ int phylink_set_fixed_link(struct phylink *,
 			   const struct phylink_link_state *);
 
 void phylink_mac_change(struct phylink *, bool up);
-void phylink_pcs_change(struct phylink_pcs *, bool up);
+/**
+ * phylink_pcs_change() - notify phylink of a change to PCS link state
+ * @pcs: pointer to &struct phylink_pcs
+ * @up: indicates whether the link is currently up.
+ *
+ * The PCS driver should call this when the state of its link changes
+ * (e.g. link failure, new negotiation results, etc.) Note: it should
+ * not determine "up" by reading the BMSR. If in doubt about the link
+ * state at interrupt time, then pass true if pcs_get_state() returns
+ * the latched link-down state, otherwise pass false.
+ */
+static inline void phylink_pcs_change(struct phylink_pcs *pcs, bool up)
+{
+	if (pcs->link_change)
+		pcs->link_change(pcs->link_change_priv, up);
+}
 
 int phylink_pcs_pre_init(struct phylink *pl, struct phylink_pcs *pcs);
 
-- 
2.35.1.1320.gc452695387.dirty


