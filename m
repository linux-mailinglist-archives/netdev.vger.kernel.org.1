Return-Path: <netdev+bounces-153789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632039F9AF9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC91016D56D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB2226899;
	Fri, 20 Dec 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VeJS9VbS"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603F225414;
	Fri, 20 Dec 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725723; cv=none; b=u+gZT6VtJOCNEecByRzbJNbOtzlc7SHq+XF0HFedSv2o2t1eJ4vwBLGfnFQr0f1Cuvjaov5s8gwcRpfwgX2LkTuqgAKjjaSZwZkB7ecFhWGfgq6LVyFRmceRphhOCXCmiVnXrVy/+T8GYLgTVXo/0yhMA8EpzjC0/CdNmnhHZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725723; c=relaxed/simple;
	bh=f/ETiwurF6C7fNfGGj+KXaCBubkV+AZJ0yPK+e69MOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpFumm3K5FVQnREis8DQsvI/p/5MIjT8zJomTnPTdsQLp2EUswwG1efN/R1bp++l7u20wRfVnoK56qcXQrXl7jqJYFMGTv6aqwC39QfJLSBWC5qm7NQzB6479WU8nxtT3jkobxebQvEZJj5UMHyskYWS3f1cAXEKqr8FgzqGShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VeJS9VbS; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76E89E0004;
	Fri, 20 Dec 2024 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734725712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8y3GYFgiXXzVTdJKrJVfeq/XWJ138yOwkWJ7cl9Hh9U=;
	b=VeJS9VbSSS5k7XyJJezpbZhIQfWO1p/glvOJKJ3qLBq0oZL9v9JxHB1oumu/hhuOgDbIpU
	lmXfnm6fMS9mBdgYDmBzDh0+ZZoT3sJhH9MADk4GWdhlcZlSrpzOeBLjSlLxeRUEnQX6Gi
	OOSJvm85oba/XxyagTK+TfKjJ26aRBEg9WhDcPwmt3AYO4NeBINgGrLh2/OK8DroN6HUue
	EG2DEjeubBgYRXY/PWChM7Lzr59H2jNQusBq8lp2v3NTr6GcPDs+c7H9HaHF2kHyJmEWuN
	yC2///vI9DEP9y5Zwm20Gff4kljnQnw1rnm4MQbY2auE+Tz6zaaYPl18r8d1lQ==
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
Subject: [PATCH net-next RFC 2/5] net: ethtool: Introduce ETHTOOL_LINK_MEDIUM_* values
Date: Fri, 20 Dec 2024 21:15:01 +0100
Message-ID: <20241220201506.2791940-3-maxime.chevallier@bootlin.com>
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

In an effort to have a better representation of Ethernet ports,
introduce enumeration values representing the various ethernet Mediums.

This is part of the 802.3 naming convention, for example :

1000 Base T 4
 |    |   | |
 |    |   | \_ lanes (4)
 |    |   \___ Medium (T == Twisted Copper Pairs)
 |    \_______ Baseband transmission
 \____________ Speed

 Other example :

10000 Base K X 4
           | | \_ lanes (4)
           | \___ encoding (BaseX is 8b/10b while BaseR is 66b/64b)
           \_____ Medium (K is backplane ethernet)

In the case of representing a physical port, only the medium and number
of lanes should be relevant. One exception would be 1000BaseX, which is
currently also used as a medium in what appears to be any of
1000BaseSX, 1000BaseFX, 1000BaseCX and 1000BaseLX.

These mediums are set in the net/ethtool/common.c lookup table that
maintains a list of all linkmodes with their number of lanes, medium,
encoding, speed and duplex.

One notable exception to this is 100M BaseT Ethernet. 100BaseTX is a 2-lanes
protocol but it will also work on 4-lanes cables, so the lookup table
contains 2 sets of lane numbers, indicating the min number of lanes for
a protocol to work and the "nominal" number of lanes as well.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/linux/ethtool.h |  48 ++++++++++
 net/ethtool/common.c    | 194 +++++++++++++++++++++-------------------
 net/ethtool/common.h    |   2 +
 3 files changed, 153 insertions(+), 91 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f711bfd75c4d..dc02a1bef549 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -203,6 +203,54 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
 
+enum ethtool_link_medium {
+	ETHTOOL_LINK_MEDIUM_BASET = 0,
+	ETHTOOL_LINK_MEDIUM_BASEK,
+	ETHTOOL_LINK_MEDIUM_BASES,
+	ETHTOOL_LINK_MEDIUM_BASEC,
+	ETHTOOL_LINK_MEDIUM_BASEL,
+	ETHTOOL_LINK_MEDIUM_BASED,
+	ETHTOOL_LINK_MEDIUM_BASEE,
+	ETHTOOL_LINK_MEDIUM_BASEF,
+	ETHTOOL_LINK_MEDIUM_BASEV,
+	ETHTOOL_LINK_MEDIUM_BASEMLD, /* I don't know what that is */
+	ETHTOOL_LINK_MEDIUM_BASEX, /* Not a true medium, but abused... */
+	ETHTOOL_LINK_MEDIUM_NONE,
+
+	__ETHTOOL_LINK_MEDIUM_LAST,
+};
+
+static inline const char *phy_mediums(enum ethtool_link_medium medium)
+{
+	switch (medium) {
+	case ETHTOOL_LINK_MEDIUM_BASET:
+		return "BaseT";
+	case ETHTOOL_LINK_MEDIUM_BASEK:
+		return "BaseK";
+	case ETHTOOL_LINK_MEDIUM_BASES:
+		return "BaseS";
+	case ETHTOOL_LINK_MEDIUM_BASEC:
+		return "BaseC";
+	case ETHTOOL_LINK_MEDIUM_BASEL:
+		return "BaseL";
+	case ETHTOOL_LINK_MEDIUM_BASED:
+		return "BaseD";
+	case ETHTOOL_LINK_MEDIUM_BASEE:
+		return "BaseE";
+	case ETHTOOL_LINK_MEDIUM_BASEF:
+		return "BaseF";
+	case ETHTOOL_LINK_MEDIUM_BASEV:
+		return "BaseV";
+	case ETHTOOL_LINK_MEDIUM_BASEMLD:
+		return "BaseMLD";
+	case ETHTOOL_LINK_MEDIUM_BASEX:
+		return "BaseX";
+	case ETHTOOL_LINK_MEDIUM_NONE:
+		return "None";
+	default: return "unknown";
+	}
+}
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5a9c09ce57d5..41e7598f6ed7 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -255,11 +255,22 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 #define __LINK_MODE_LANES_DR8_2		8
 #define __LINK_MODE_LANES_T1BRR		1
 
-#define __DEFINE_LINK_MODE_PARAMS(_speed, _type, _duplex)	\
+#define __DEFINE_LINK_MODE_PARAMS_LANES(_speed, _type, _min_lanes, _lanes, _duplex, _medium) \
 	[ETHTOOL_LINK_MODE(_speed, _type, _duplex)] = {		\
 		.speed  = SPEED_ ## _speed, \
+		.min_lanes  = _min_lanes, \
+		.lanes  = _lanes, \
+		.duplex	= __DUPLEX_ ## _duplex, \
+		.medium = ETHTOOL_LINK_MEDIUM_BASE ## _medium \
+	}
+
+#define __DEFINE_LINK_MODE_PARAMS(_speed, _type, _duplex, _medium)	\
+	[ETHTOOL_LINK_MODE(_speed, _type, _duplex)] = {		\
+		.speed  = SPEED_ ## _speed, \
+		.min_lanes  = __LINK_MODE_LANES_ ## _type, \
 		.lanes  = __LINK_MODE_LANES_ ## _type, \
-		.duplex	= __DUPLEX_ ## _duplex \
+		.duplex	= __DUPLEX_ ## _duplex, \
+		.medium = ETHTOOL_LINK_MEDIUM_BASE ## _medium \
 	}
 #define __DUPLEX_Half DUPLEX_HALF
 #define __DUPLEX_Full DUPLEX_FULL
@@ -268,116 +279,117 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 		.speed	= SPEED_UNKNOWN, \
 		.lanes	= 0, \
 		.duplex	= DUPLEX_UNKNOWN, \
+		.medium	= ETHTOOL_LINK_MEDIUM_NONE, \
 	}
 
 const struct link_mode_info link_mode_params[] = {
-	__DEFINE_LINK_MODE_PARAMS(10, T, Half),
-	__DEFINE_LINK_MODE_PARAMS(10, T, Full),
-	__DEFINE_LINK_MODE_PARAMS(100, T, Half),
-	__DEFINE_LINK_MODE_PARAMS(100, T, Full),
-	__DEFINE_LINK_MODE_PARAMS(1000, T, Half),
-	__DEFINE_LINK_MODE_PARAMS(1000, T, Full),
+	__DEFINE_LINK_MODE_PARAMS_LANES(10, T, 2, 4, Half, T),
+	__DEFINE_LINK_MODE_PARAMS_LANES(10, T, 2, 4, Full, T),
+	__DEFINE_LINK_MODE_PARAMS_LANES(100, T, 2, 4, Half, T),
+	__DEFINE_LINK_MODE_PARAMS_LANES(100, T, 2, 4, Full, T),
+	__DEFINE_LINK_MODE_PARAMS(1000, T, Half, T),
+	__DEFINE_LINK_MODE_PARAMS(1000, T, Full, T),
 	__DEFINE_SPECIAL_MODE_PARAMS(Autoneg),
 	__DEFINE_SPECIAL_MODE_PARAMS(TP),
 	__DEFINE_SPECIAL_MODE_PARAMS(AUI),
 	__DEFINE_SPECIAL_MODE_PARAMS(MII),
 	__DEFINE_SPECIAL_MODE_PARAMS(FIBRE),
 	__DEFINE_SPECIAL_MODE_PARAMS(BNC),
-	__DEFINE_LINK_MODE_PARAMS(10000, T, Full),
+	__DEFINE_LINK_MODE_PARAMS(10000, T, Full, T),
 	__DEFINE_SPECIAL_MODE_PARAMS(Pause),
 	__DEFINE_SPECIAL_MODE_PARAMS(Asym_Pause),
-	__DEFINE_LINK_MODE_PARAMS(2500, X, Full),
+	__DEFINE_LINK_MODE_PARAMS(2500, X, Full, X),
 	__DEFINE_SPECIAL_MODE_PARAMS(Backplane),
-	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full),
-	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full),
-	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full),
+	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full, K),
 	[ETHTOOL_LINK_MODE_10000baseR_FEC_BIT] = {
 		.speed	= SPEED_10000,
 		.lanes	= 1,
 		.duplex = DUPLEX_FULL,
 	},
-	__DEFINE_LINK_MODE_PARAMS(20000, MLD2, Full),
-	__DEFINE_LINK_MODE_PARAMS(20000, KR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(40000, KR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(40000, CR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(40000, SR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(40000, LR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(56000, KR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(56000, CR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(56000, SR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(56000, LR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(25000, CR, Full),
-	__DEFINE_LINK_MODE_PARAMS(25000, KR, Full),
-	__DEFINE_LINK_MODE_PARAMS(25000, SR, Full),
-	__DEFINE_LINK_MODE_PARAMS(50000, CR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(50000, KR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, KR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, SR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, CR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, LR4_ER4, Full),
-	__DEFINE_LINK_MODE_PARAMS(50000, SR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(1000, X, Full),
-	__DEFINE_LINK_MODE_PARAMS(10000, CR, Full),
-	__DEFINE_LINK_MODE_PARAMS(10000, SR, Full),
-	__DEFINE_LINK_MODE_PARAMS(10000, LR, Full),
-	__DEFINE_LINK_MODE_PARAMS(10000, LRM, Full),
-	__DEFINE_LINK_MODE_PARAMS(10000, ER, Full),
-	__DEFINE_LINK_MODE_PARAMS(2500, T, Full),
-	__DEFINE_LINK_MODE_PARAMS(5000, T, Full),
+	__DEFINE_LINK_MODE_PARAMS(20000, MLD2, Full, MLD),
+	__DEFINE_LINK_MODE_PARAMS(20000, KR2, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(40000, KR4, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(40000, CR4, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(40000, SR4, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(40000, LR4, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(56000, KR4, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(56000, CR4, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(56000, SR4, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(56000, LR4, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(25000, CR, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(25000, KR, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(25000, SR, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(50000, CR2, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(50000, KR2, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(100000, KR4, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(100000, SR4, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(100000, CR4, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(100000, LR4_ER4, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(50000, SR2, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(1000, X, Full, X), /* :( */
+	__DEFINE_LINK_MODE_PARAMS(10000, CR, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(10000, SR, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(10000, LR, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(10000, LRM, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(10000, ER, Full, E),
+	__DEFINE_LINK_MODE_PARAMS(2500, T, Full, T),
+	__DEFINE_LINK_MODE_PARAMS(5000, T, Full, T),
 	__DEFINE_SPECIAL_MODE_PARAMS(FEC_NONE),
 	__DEFINE_SPECIAL_MODE_PARAMS(FEC_RS),
 	__DEFINE_SPECIAL_MODE_PARAMS(FEC_BASER),
-	__DEFINE_LINK_MODE_PARAMS(50000, KR, Full),
-	__DEFINE_LINK_MODE_PARAMS(50000, SR, Full),
-	__DEFINE_LINK_MODE_PARAMS(50000, CR, Full),
-	__DEFINE_LINK_MODE_PARAMS(50000, LR_ER_FR, Full),
-	__DEFINE_LINK_MODE_PARAMS(50000, DR, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, KR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, SR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, CR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, LR2_ER2_FR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, DR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, KR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, SR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, LR4_ER4_FR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, DR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, CR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(100, T1, Full),
-	__DEFINE_LINK_MODE_PARAMS(1000, T1, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, KR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, SR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, LR8_ER8_FR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, DR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, CR8, Full),
+	__DEFINE_LINK_MODE_PARAMS(50000, KR, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(50000, SR, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(50000, CR, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(50000, LR_ER_FR, Full, L), /* I guess ? */
+	__DEFINE_LINK_MODE_PARAMS(50000, DR, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(100000, KR2, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(100000, SR2, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(100000, CR2, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(100000, LR2_ER2_FR2, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(100000, DR2, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(200000, KR4, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(200000, SR4, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(200000, LR4_ER4_FR4, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(200000, DR4, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(200000, CR4, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(100, T1, Full, T),
+	__DEFINE_LINK_MODE_PARAMS(1000, T1, Full, T),
+	__DEFINE_LINK_MODE_PARAMS(400000, KR8, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(400000, SR8, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(400000, LR8_ER8_FR8, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(400000, DR8, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(400000, CR8, Full, C),
 	__DEFINE_SPECIAL_MODE_PARAMS(FEC_LLRS),
-	__DEFINE_LINK_MODE_PARAMS(100000, KR, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, SR, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, LR_ER_FR, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, DR, Full),
-	__DEFINE_LINK_MODE_PARAMS(100000, CR, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, KR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, SR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, LR2_ER2_FR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, DR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(200000, CR2, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, KR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, SR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, LR4_ER4_FR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, DR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(400000, CR4, Full),
-	__DEFINE_LINK_MODE_PARAMS(100, FX, Half),
-	__DEFINE_LINK_MODE_PARAMS(100, FX, Full),
-	__DEFINE_LINK_MODE_PARAMS(10, T1L, Full),
-	__DEFINE_LINK_MODE_PARAMS(800000, CR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(800000, KR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(800000, DR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(800000, DR8_2, Full),
-	__DEFINE_LINK_MODE_PARAMS(800000, SR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(800000, VR8, Full),
-	__DEFINE_LINK_MODE_PARAMS(10, T1S, Full),
-	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half),
-	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half),
-	__DEFINE_LINK_MODE_PARAMS(10, T1BRR, Full),
+	__DEFINE_LINK_MODE_PARAMS(100000, KR, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(100000, SR, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(100000, LR_ER_FR, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(100000, DR, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(100000, CR, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(200000, KR2, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(200000, SR2, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(200000, LR2_ER2_FR2, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(200000, DR2, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(200000, CR2, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(400000, KR4, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(400000, SR4, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(400000, LR4_ER4_FR4, Full, L),
+	__DEFINE_LINK_MODE_PARAMS(400000, DR4, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(400000, CR4, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(100, FX, Half, F),
+	__DEFINE_LINK_MODE_PARAMS(100, FX, Full, F),
+	__DEFINE_LINK_MODE_PARAMS(10, T1L, Full, T),
+	__DEFINE_LINK_MODE_PARAMS(800000, CR8, Full, C),
+	__DEFINE_LINK_MODE_PARAMS(800000, KR8, Full, K),
+	__DEFINE_LINK_MODE_PARAMS(800000, DR8, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(800000, DR8_2, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(800000, SR8, Full, S),
+	__DEFINE_LINK_MODE_PARAMS(800000, VR8, Full, V),
+	__DEFINE_LINK_MODE_PARAMS(10, T1S, Full, T),
+	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half, T),
+	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half, T),
+	__DEFINE_LINK_MODE_PARAMS(10, T1BRR, Full, T),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 850eadde4bfc..b25011a05fea 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -16,8 +16,10 @@
 
 struct link_mode_info {
 	int				speed;
+	u8				min_lanes;
 	u8				lanes;
 	u8				duplex;
+	enum ethtool_link_medium	medium;
 };
 
 struct genl_info;
-- 
2.47.1


