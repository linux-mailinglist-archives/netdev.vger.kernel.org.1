Return-Path: <netdev+bounces-170927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89AFA4AB87
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 15:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24F2189688E
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130D1DEFEE;
	Sat,  1 Mar 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wr21Ju86"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72E1DED5A;
	Sat,  1 Mar 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838282; cv=none; b=PlrKhbahfIvE24A3L7JXjbRBY6KrBYIu0ep1lgulCK7mOQOA2ewPo2c7HCs8dASX1RFDJmPsL2jhCMiho796D/lT0IyVe8rGikZrzOPP5WC3ZGGHeSDLwPypCN+avGKHeBdAewWL5mmX/w0UbxPzLyrkTWLD2j0C40fyjhtF5Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838282; c=relaxed/simple;
	bh=AswYZNkHo+Cu7mTOivQG5MxzgFbEE5CkE/SmqJv0IMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r26nnpT+IkRyWeXdwDBHcVN9BoYG211uwFtEUmDH7igpqL4IkfrXEyR+gs5iTe3QYN9k/SkPzsyiLkkUyAdrQ3PUjjtpqM8E+pg1tZoZbtG3bHTPuOPaQCphkf3pq9FV5Q+LOH7CbxBNA6vszFYK27H3+xKEmtsgI2tCbZQBSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wr21Ju86; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30CC743315;
	Sat,  1 Mar 2025 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740838277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gxxrA5TGUbh+xCz1QfWoVv9hBkCa7QJfvAHDsjuob1g=;
	b=Wr21Ju86aahNvOxsQKgm/dmyd7gTFvapYwF7CMccXs7tJxrVHUkKQix+jnHC/IdBUst2jO
	SAaEGu4mlRX14a7rp/nz8z3974E+LZIkplH3KWO1XE0a+Mwe7QtvqsMHqBKPJqtZGjrQdD
	CMdi+CoMSAldwMQKiwKxzL2XP5uMfHzTDUQa5y2A5ZtZRSeOlWHUCceLlpj5oWimNqB27U
	ex2H8Ukc92yyhcgs4luiaKO0zmHTW5rit2f3ay43SNZvMRhCd4Mur9LwT8pMswiyj2NK29
	pqNeNxGfOEg75Kw3NdIaA+lwmUo5jakU2M0yrlPXzBvkBXWl1v7uKhXLaW2X3w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net v2] net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device
Date: Sat,  1 Mar 2025 15:11:13 +0100
Message-ID: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgrrhhthhhisggrnhdrvhgvvghrrghsohhorhgrnhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

ethnl_req_get_phydev() is used to lookup a phy_device, in the case an
ethtool netlink command targets a specific phydev within a netdev's
topology.

It takes as a parameter a const struct nlattr *header that's used for
error handling :

       if (!phydev) {
               NL_SET_ERR_MSG_ATTR(extack, header,
                                   "no phy matching phyindex");
               return ERR_PTR(-ENODEV);
       }

In the notify path after a ->set operation however, there's no request
attributes available.

The typical callsite for the above function looks like:

	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_XXX_HEADER],
				      info->extack);

So, when tb is NULL (such as in the ethnl notify path), we have a nice
crash.

It turns out that there's only the PLCA command that is in that case, as
the other phydev-specific commands don't have a notification.

This commit fixes the crash by passing the cmd index and the nlattr
array separately, allowing NULL-checking it directly inside the helper.

Fixes: c15e065b46dc ("net: ethtool: Allow passing a phy index for some commands")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

V2: Send this patch as a standalone fix instead of including it in a
series [1] containing patches that don't belong to net. No modifications
were made besides a rebase on -net.

[1]: https://lore.kernel.org/netdev/20250227182454.1998236-1-maxime.chevallier@bootlin.com/

 net/ethtool/cabletest.c | 8 ++++----
 net/ethtool/linkstate.c | 2 +-
 net/ethtool/netlink.c   | 6 +++---
 net/ethtool/netlink.h   | 5 +++--
 net/ethtool/phy.c       | 2 +-
 net/ethtool/plca.c      | 6 +++---
 net/ethtool/pse-pd.c    | 4 ++--
 net/ethtool/stats.c     | 2 +-
 net/ethtool/strset.c    | 2 +-
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f22051f33868..84096f6b0236 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -72,8 +72,8 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
-	phydev = ethnl_req_get_phydev(&req_info,
-				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
+	phydev = ethnl_req_get_phydev(&req_info, tb,
+				      ETHTOOL_A_CABLE_TEST_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
@@ -339,8 +339,8 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		goto out_dev_put;
 
 	rtnl_lock();
-	phydev = ethnl_req_get_phydev(&req_info,
-				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
+	phydev = ethnl_req_get_phydev(&req_info, tb,
+				      ETHTOOL_A_CABLE_TEST_TDR_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index af19e1bed303..05a5f72c99fa 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -103,7 +103,7 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_LINKSTATE_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_LINKSTATE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev)) {
 		ret = PTR_ERR(phydev);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index b4c45207fa32..734849a57369 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -211,7 +211,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 }
 
 struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
-					const struct nlattr *header,
+					struct nlattr **tb, unsigned int header,
 					struct netlink_ext_ack *extack)
 {
 	struct phy_device *phydev;
@@ -225,8 +225,8 @@ struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
 		return req_info->dev->phydev;
 
 	phydev = phy_link_topo_get_phy(req_info->dev, req_info->phy_index);
-	if (!phydev) {
-		NL_SET_ERR_MSG_ATTR(extack, header,
+	if (!phydev && tb) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[header],
 				    "no phy matching phyindex");
 		return ERR_PTR(-ENODEV);
 	}
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index ff69ca0715de..ec6ab5443a6f 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -275,7 +275,8 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
  * ethnl_req_get_phydev() - Gets the phy_device targeted by this request,
  *			    if any. Must be called under rntl_lock().
  * @req_info:	The ethnl request to get the phy from.
- * @header:	The netlink header, used for error reporting.
+ * @tb:		The netlink attributes array, for error reporting.
+ * @header:	The netlink header index, used for error reporting.
  * @extack:	The netlink extended ACK, for error reporting.
  *
  * The caller must hold RTNL, until it's done interacting with the returned
@@ -289,7 +290,7 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
  *	   is returned.
  */
 struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
-					const struct nlattr *header,
+					struct nlattr **tb, unsigned int header,
 					struct netlink_ext_ack *extack);
 
 /**
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ed8f690f6bac..e067cc234419 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -125,7 +125,7 @@ static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
 	struct phy_req_info *req_info = PHY_REQINFO(req_base);
 	struct phy_device *phydev;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PHY_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PHY_HEADER,
 				      extack);
 	if (!phydev)
 		return 0;
diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index d95d92f173a6..e1f7820a6158 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -62,7 +62,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev)) {
@@ -152,7 +152,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	bool mod = false;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev))
@@ -211,7 +211,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev)) {
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2819e2ba6be2..4f6b99eab2a6 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -64,7 +64,7 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PSE_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
 		return -ENODEV;
@@ -261,7 +261,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	ret = ethnl_set_pse_validate(phydev, info);
 	if (ret)
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 038a2558f052..3ca8eb2a3b31 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -138,7 +138,7 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_STATS_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_STATS_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
 		return PTR_ERR(phydev);
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index 6b76c05caba4..f6a67109beda 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -309,7 +309,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		return 0;
 	}
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_HEADER_FLAGS],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_HEADER_FLAGS,
 				      info->extack);
 
 	/* phydev can be NULL, check for errors only */
-- 
2.48.1


