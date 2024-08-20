Return-Path: <netdev+bounces-120083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 185409583CE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB44B246AC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE818CC05;
	Tue, 20 Aug 2024 10:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C618C93E
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148791; cv=none; b=X/tuFJCGS0Y0JoF0mkqrejIUlWhRlJvxaUWbalDG37T6uYw53XzEEwCGb5ll3mfQfC5NSPUdBO/0V3WJfXaVPwl//ULMNQfFTvZ6Nhm8Im4Ob2OlRkQr+wymyosgVssJE05YpxxWf0GiIpyL+knj278j2FPS6Gz0k5aYky4EvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148791; c=relaxed/simple;
	bh=BetCfAwKKqKx3GzydWwVLt96Iq6eCFymkc8TE6tmS34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gnopf2Bs1jFEjfMEHw60p0gdDTr4alxDQbxLrl45JWW2fblPfxOV7PDqkmt7CQga8KQ/cGy2m4fu+QGS4bb/HDDiy05ULK/w5+KrdTrokGTDnQums3zNumcYqQNLn0yQofAf81ya7VM/EYqzeaLFyr1zReyX5wpkUrR7qW3DUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrH-0000hp-Q1; Tue, 20 Aug 2024 12:12:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrH-001kNk-CZ; Tue, 20 Aug 2024 12:12:59 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrH-006Jua-10;
	Tue, 20 Aug 2024 12:12:59 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v2 2/3] ethtool: Add support for specifying information source in cable test results
Date: Tue, 20 Aug 2024 12:12:55 +0200
Message-Id: <20240820101256.1506460-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240820101256.1506460-1-o.rempel@pengutronix.de>
References: <20240820101256.1506460-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Enhance the ethtool cable test interface by introducing the ability to
specify the source of the diagnostic information for cable test results.
This is particularly useful for PHYs that offer multiple diagnostic
methods, such as Time Domain Reflectometry (TDR) and Active Link Cable
Diagnostic (ALCD).

Key changes:
- Added `ethnl_cable_test_result_with_src` and
  `ethnl_cable_test_fault_length_with_src` functions to allow specifying
  the information source when reporting cable test results.
- Updated existing `ethnl_cable_test_result` and
  `ethnl_cable_test_fault_length` functions to use TDR as the default
  source, ensuring backward compatibility.
- Modified the UAPI to support these new attributes, enabling drivers to
  provide more detailed diagnostic information.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- use u8 instead of u32 for src
- do not send src field if src is ETHTOOL_A_CABLE_INF_SRC_UNSPEC
---
 include/linux/ethtool_netlink.h | 29 +++++++++++++++++++++++------
 net/ethtool/cabletest.c         | 19 +++++++++++++++----
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
index fae0dfb9a9c82..a21e5c7b9435f 100644
--- a/include/linux/ethtool_netlink.h
+++ b/include/linux/ethtool_netlink.h
@@ -23,8 +23,10 @@ struct phy_device;
 int ethnl_cable_test_alloc(struct phy_device *phydev, u8 cmd);
 void ethnl_cable_test_free(struct phy_device *phydev);
 void ethnl_cable_test_finished(struct phy_device *phydev);
-int ethnl_cable_test_result(struct phy_device *phydev, u8 pair, u8 result);
-int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm);
+int ethnl_cable_test_result_with_src(struct phy_device *phydev, u8 pair,
+				     u8 result, u8 src);
+int ethnl_cable_test_fault_length_with_src(struct phy_device *phydev, u8 pair,
+					   u32 cm, u8 src);
 int ethnl_cable_test_amplitude(struct phy_device *phydev, u8 pair, s16 mV);
 int ethnl_cable_test_pulse(struct phy_device *phydev, u16 mV);
 int ethnl_cable_test_step(struct phy_device *phydev, u32 first, u32 last,
@@ -54,14 +56,14 @@ static inline void ethnl_cable_test_free(struct phy_device *phydev)
 static inline void ethnl_cable_test_finished(struct phy_device *phydev)
 {
 }
-static inline int ethnl_cable_test_result(struct phy_device *phydev, u8 pair,
-					  u8 result)
+static inline int ethnl_cable_test_result_with_src(struct phy_device *phydev,
+						   u8 pair, u8 result, u8 src)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int ethnl_cable_test_fault_length(struct phy_device *phydev,
-						u8 pair, u32 cm)
+static inline int ethnl_cable_test_fault_length_with_src(struct phy_device *phydev,
+							 u8 pair, u32 cm, u8 src)
 {
 	return -EOPNOTSUPP;
 }
@@ -119,4 +121,19 @@ static inline bool ethtool_dev_mm_supported(struct net_device *dev)
 }
 
 #endif /* IS_ENABLED(CONFIG_ETHTOOL_NETLINK) */
+
+static inline int ethnl_cable_test_result(struct phy_device *phydev, u8 pair,
+					  u8 result)
+{
+	return ethnl_cable_test_result_with_src(phydev, pair, result,
+						ETHTOOL_A_CABLE_INF_SRC_TDR);
+}
+
+static inline int ethnl_cable_test_fault_length(struct phy_device *phydev,
+						u8 pair, u32 cm)
+{
+	return ethnl_cable_test_fault_length_with_src(phydev, pair, cm,
+						      ETHTOOL_A_CABLE_INF_SRC_TDR);
+}
+
 #endif /* _LINUX_ETHTOOL_NETLINK_H_ */
diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f6f136ec7ddfc..97ef7895997e2 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -160,7 +160,8 @@ void ethnl_cable_test_finished(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(ethnl_cable_test_finished);
 
-int ethnl_cable_test_result(struct phy_device *phydev, u8 pair, u8 result)
+int ethnl_cable_test_result_with_src(struct phy_device *phydev, u8 pair,
+				     u8 result, u8 src)
 {
 	struct nlattr *nest;
 	int ret = -EMSGSIZE;
@@ -173,6 +174,10 @@ int ethnl_cable_test_result(struct phy_device *phydev, u8 pair, u8 result)
 		goto err;
 	if (nla_put_u8(phydev->skb, ETHTOOL_A_CABLE_RESULT_CODE, result))
 		goto err;
+	if (src != ETHTOOL_A_CABLE_INF_SRC_UNSPEC) {
+		if (nla_put_u8(phydev->skb, ETHTOOL_A_CABLE_RESULT_SRC, src))
+			goto err;
+	}
 
 	nla_nest_end(phydev->skb, nest);
 	return 0;
@@ -181,9 +186,10 @@ int ethnl_cable_test_result(struct phy_device *phydev, u8 pair, u8 result)
 	nla_nest_cancel(phydev->skb, nest);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ethnl_cable_test_result);
+EXPORT_SYMBOL_GPL(ethnl_cable_test_result_with_src);
 
-int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm)
+int ethnl_cable_test_fault_length_with_src(struct phy_device *phydev, u8 pair,
+					   u32 cm, u8 src)
 {
 	struct nlattr *nest;
 	int ret = -EMSGSIZE;
@@ -197,6 +203,11 @@ int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm)
 		goto err;
 	if (nla_put_u32(phydev->skb, ETHTOOL_A_CABLE_FAULT_LENGTH_CM, cm))
 		goto err;
+	if (src != ETHTOOL_A_CABLE_INF_SRC_UNSPEC) {
+		if (nla_put_u8(phydev->skb, ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,
+			       src))
+			goto err;
+	}
 
 	nla_nest_end(phydev->skb, nest);
 	return 0;
@@ -205,7 +216,7 @@ int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm)
 	nla_nest_cancel(phydev->skb, nest);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ethnl_cable_test_fault_length);
+EXPORT_SYMBOL_GPL(ethnl_cable_test_fault_length_with_src);
 
 static const struct nla_policy cable_test_tdr_act_cfg_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST]	= { .type = NLA_U32 },
-- 
2.39.2


