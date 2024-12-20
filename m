Return-Path: <netdev+bounces-153790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B69F9AFB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25361890792
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE5227586;
	Fri, 20 Dec 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MJuPLsiA"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966B22541D;
	Fri, 20 Dec 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725723; cv=none; b=XaA/JIk29kNzFu8st5nh540gFXBh8ua+1UbnFCmj3ffuRHRP0aHMFdMlG2kMOw3AAXxaoD18NEM1AHWhuNpgS15pAiq8D/V+W0vwlSh2nejOsnij2OIoYPA281LP2Q9W26MeKWzAFcAmCV10r5/oYgneNO5PRlubF0hG+tK1Vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725723; c=relaxed/simple;
	bh=s50VugW3jbYNSX4TWU7do6mlYr64q3KAWDUJPvqhUC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKNA/gYPhh8PEHkt/k6fc4ozVMldPptAtL/6f4p5UXS/cFnWWc8Yox6EmuluMzQC7eTHdGpmFwrHWycgLcsEu+ENZR6g57LVqRx0X1Cyi8DVTO+DkPoVlxekZjefSI6PVHo1vuqj2Glmge+qCykbQXekAnGHJUZGbZtwgzW26KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MJuPLsiA; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C43E1E0006;
	Fri, 20 Dec 2024 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734725714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDjS9wsj/i5sYXVRvIAzP89uRLtBdLP5tmgPtBoF7s4=;
	b=MJuPLsiA0RRuh0Lbl+3dGbpGPyEkmENswunuNJpa1c2A1athplvAZd86XMr09AX4MAELny
	LetRjftc06k8t9QxAWKdSeAyf0XLidHaWzUYjzs06POFVqwLf4r7/xy1+flGyrpCxhBOLo
	EKZXVscHbG3b4Exh2JfPWT6+jY758vXonJtsAnGpt4l+uUt+9wNHiUgR73eNZtDSAk9nfF
	Wno2dQGXUfjUa+pxJkCbLzcMhGNVS8b/WnHzUR0NBkWKxyj8NpPSYLv26L88bSWtGMWOln
	rVWqSs2KlaVYx4Kj+K3j5MOTGepBIuneTpl2kQmJ7PuBxZta2U4RU7VD4h8vbA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next RFC 3/5] net: ethtool: Export the link_mode_params definitions
Date: Fri, 20 Dec 2024 21:15:02 +0100
Message-ID: <20241220201506.2791940-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

link_mode_params contains a lookup table of all 802.3 link modes that
are currently supported with structured data about each mode's speed,
duplex, number of lanes and mediums.

As a preparation for a port representation, export that table for the
rest of the net stack to use.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/linux/ethtool.h | 10 ++++++++++
 net/ethtool/common.c    |  1 +
 net/ethtool/common.h    |  9 ---------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index dc02a1bef549..51d110dfa8ef 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -251,6 +251,16 @@ static inline const char *phy_mediums(enum ethtool_link_medium medium)
 	}
 }
 
+struct link_mode_info {
+	int                             speed;
+	u8                              min_lanes;
+	u8                              lanes;
+	u8                              duplex;
+	enum ethtool_link_medium        medium;
+};
+
+extern const struct link_mode_info link_mode_params[];
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 41e7598f6ed7..bded82c0bba4 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -392,6 +392,7 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(10, T1BRR, Full, T),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
+EXPORT_SYMBOL_GPL(link_mode_params);
 
 const char netif_msg_class_names[][ETH_GSTRING_LEN] = {
 	[NETIF_MSG_DRV_BIT]		= "drv",
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index b25011a05fea..ee250a5c5364 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -14,14 +14,6 @@
 
 #define __SOF_TIMESTAMPING_CNT (const_ilog2(SOF_TIMESTAMPING_LAST) + 1)
 
-struct link_mode_info {
-	int				speed;
-	u8				min_lanes;
-	u8				lanes;
-	u8				duplex;
-	enum ethtool_link_medium	medium;
-};
-
 struct genl_info;
 struct hwtstamp_provider_desc;
 
@@ -34,7 +26,6 @@ tunable_strings[__ETHTOOL_TUNABLE_COUNT][ETH_GSTRING_LEN];
 extern const char
 phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN];
 extern const char link_mode_names[][ETH_GSTRING_LEN];
-extern const struct link_mode_info link_mode_params[];
 extern const char netif_msg_class_names[][ETH_GSTRING_LEN];
 extern const char wol_mode_names[][ETH_GSTRING_LEN];
 extern const char sof_timestamping_names[][ETH_GSTRING_LEN];
-- 
2.47.1


