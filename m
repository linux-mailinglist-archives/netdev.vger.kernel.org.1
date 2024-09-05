Return-Path: <netdev+bounces-125492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA296D5FD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B05B22ECB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAE199246;
	Thu,  5 Sep 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X9bRliLH"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB79198A21;
	Thu,  5 Sep 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531871; cv=none; b=ahO+bCmnEV1hyUHl+OLp6E/HnVMwPw4m9TKGUZVaE8hTu7+otN4TWxDeHlCmV4bgFmqnq2vJ0V17A50VuTjD34gQ6wFTew2emc/Faul9b4orwzq2ryBIHhEu0A3vwxJQe4nov8CLFdEE0iTVYXI4zgtKf4NKDiegIlYkPZQFUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531871; c=relaxed/simple;
	bh=PpVyvJ+6obkJ5qxezW8mKyk+C0rTLkddD4Srgus//wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvp++lWHJT8qbDWTht7chyvKX88T/uZtHZQ8cvHKUlH/pLQg94brJrE0oQgrcb7oTvnw/1lOTpswD80xI/9h6ktAxVVi1HGUxhS7z2FSG/+r/o+zfkxA+r/EAXnTABVLT9hJZT60aoy3o6hYAJAyvYml/fjHT/KFS4SSKvHPGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X9bRliLH; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A6AFE0003;
	Thu,  5 Sep 2024 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725531862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3/+RiR2Da19F7SNi6Bb4iuBExsu9lB2F6BMRdI3YPw=;
	b=X9bRliLHXwaLbAs8za0QvhGo379/504AcIj/HTj14VITNCyCLmeH40ANbJ79s7BmNOMPW4
	fwuDpd/5isVWkLjWqWrcnzGBELzQqDptw09ySMiwPzITkptCnV69PH2ESl9SXOzAcUvGiz
	R+UYYacf5xgt+B51l1eroEfOk9ThbTzQpYhePfY/DALnWvYhXFrBpv2gKYJG8rVDLQij3s
	5vRE21pB/HPF82WnXqZsdo3NxaoCVpUU6gHvD8JG59jro/UAjjg2GYd8TD1rKYNSVF1cEx
	7vNFbk2Hk7fU9owx29LCtG9kYF3kBwAI+6tTDHmuG3eBsxC+mUGJ6NtwcGxA+Q==
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
Subject: [PATCH ethtool-next v3 1/3] update UAPI header copies
Date: Thu,  5 Sep 2024 12:24:14 +0200
Message-ID: <20240905102417.232890-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905102417.232890-1-maxime.chevallier@bootlin.com>
References: <20240905102417.232890-1-maxime.chevallier@bootlin.com>
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


