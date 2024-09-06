Return-Path: <netdev+bounces-125991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E4A96F792
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C0C1F25F53
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64041D279A;
	Fri,  6 Sep 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TMfa7Nh6"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DA1D1F51;
	Fri,  6 Sep 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634654; cv=none; b=Qx0vqt9cHS5Y6uICUimHc6GRLNr4R/sz9G2yJ8hMfksboIHymHk4TQCoAp0cuhPtV1DT1tsNk4l7FwD/p6FUpNTRnlhvYALJWsSsyPHHb+YW0dDlppZH9SzEBK/AUATMjjIccK5L450ttBBOdpNlxzB1qGuL+bGRRy8/ZH0OMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634654; c=relaxed/simple;
	bh=PpVyvJ+6obkJ5qxezW8mKyk+C0rTLkddD4Srgus//wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNthlJjvGRPVgZG//OF3CRl3+DTZ4JOpY39wSGDNfBGq6FmJZszMIwIYEGGFgkpnPlK7p+Uy0w03Wf5ZvULzNJpjKsuTDBCotBqUpt7xRywaSE2zkQfm9jiTgmtj2UAzVyc/kKt1j8W9xyuibO8MJCQeFQhg72RAUSFdl2QMpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TMfa7Nh6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56BD61C0008;
	Fri,  6 Sep 2024 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725634645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3/+RiR2Da19F7SNi6Bb4iuBExsu9lB2F6BMRdI3YPw=;
	b=TMfa7Nh691jiB1caJ0PBNE3xwUbEReF5z+zm779pM3CiQ+OVYvnNxPRQci0TAWZzJyTkcj
	cuHMvo3b8/GmAyqjkYf7/xskLLTwlAieTxVBXColvowI1MiYHG9dlLlijgal1FA42nUW2N
	Q3RAtuc92smM8LfG9ER8ctQwv0zg0Ln2Ac5D7q152oE15TYJdD/O8Qj/vnI1H51M0+Dosl
	vShUM/mkkLAa1NXYkmjPLEr1TSqIycttp0fRN4Bh8fid/jN8XpeASTt1NRQ0LlnJ0Cllju
	IDcSV1pn0cPUYkQhWmF/d0exDVD+167flupaHGuxl8HSH1MyHvydlWckaRruXg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Michal Kubecek <mkubecek@suse.cz>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH ethtool-next v4 1/3] update UAPI header copies
Date: Fri,  6 Sep 2024 16:57:16 +0200
Message-ID: <20240906145719.387824-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906145719.387824-1-maxime.chevallier@bootlin.com>
References: <20240906145719.387824-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Update to kernel commit 7d3aed652d09.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 uapi/linux/ethtool.h         | 16 ++++++++++++++++
 uapi/linux/ethtool_netlink.h | 25 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index fef07da..7022fcc 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2531,4 +2531,20 @@ struct ethtool_link_settings {
 	 * __u32 map_lp_advertising[link_mode_masks_nwords];
 	 */
 };
+
+/**
+ * enum phy_upstream - Represents the upstream component a given PHY device
+ * is connected to, as in what is on the other end of the MII bus. Most PHYs
+ * will be attached to an Ethernet MAC controller, but in some cases, there's
+ * an intermediate PHY used as a media-converter, which will driver another
+ * MII interface as its output.
+ * @PHY_UPSTREAM_MAC: Upstream component is a MAC (a switch port,
+ *		      or ethernet controller)
+ * @PHY_UPSTREAM_PHY: Upstream component is a PHY (likely a media converter)
+ */
+enum phy_upstream {
+	PHY_UPSTREAM_MAC,
+	PHY_UPSTREAM_PHY,
+};
+
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/uapi/linux/ethtool_netlink.h b/uapi/linux/ethtool_netlink.h
index dfc25a0..f865c7c 100644
--- a/uapi/linux/ethtool_netlink.h
+++ b/uapi/linux/ethtool_netlink.h
@@ -58,6 +58,7 @@ enum {
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
 	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
+	ETHTOOL_MSG_PHY_GET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -111,6 +112,8 @@ enum {
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
 	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
+	ETHTOOL_MSG_PHY_GET_REPLY,
+	ETHTOOL_MSG_PHY_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -134,6 +137,7 @@ enum {
 	ETHTOOL_A_HEADER_DEV_INDEX,		/* u32 */
 	ETHTOOL_A_HEADER_DEV_NAME,		/* string */
 	ETHTOOL_A_HEADER_FLAGS,			/* u32 - ETHTOOL_FLAG_* */
+	ETHTOOL_A_HEADER_PHY_INDEX,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_HEADER_CNT,
@@ -556,6 +560,10 @@ enum {
 	 * a regular 100 Ohm cable and a part with the abnormal impedance value
 	 */
 	ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH,
+	/* TDR not possible due to high noise level */
+	ETHTOOL_A_CABLE_RESULT_CODE_NOISE,
+	/* TDR resolution not possible / out of distance */
+	ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE,
 };
 
 enum {
@@ -965,6 +973,7 @@ enum {
 	ETHTOOL_A_RSS_INDIR,		/* binary */
 	ETHTOOL_A_RSS_HKEY,		/* binary */
 	ETHTOOL_A_RSS_INPUT_XFRM,	/* u32 */
+	ETHTOOL_A_RSS_START_CONTEXT,	/* u32 */
 
 	__ETHTOOL_A_RSS_CNT,
 	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
@@ -1049,6 +1058,22 @@ enum {
 	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PHY_UNSPEC,
+	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PHY_INDEX,			/* u32 */
+	ETHTOOL_A_PHY_DRVNAME,			/* string */
+	ETHTOOL_A_PHY_NAME,			/* string */
+	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u32 */
+	ETHTOOL_A_PHY_UPSTREAM_INDEX,		/* u32 */
+	ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,	/* string */
+	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PHY_CNT,
+	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
-- 
2.46.0


