Return-Path: <netdev+bounces-119743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802DB956CE7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F5B283B91
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B5B16F850;
	Mon, 19 Aug 2024 14:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BD16D4EE
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076778; cv=none; b=JccxkCpoWbuer1ZzPUMY/7zXbcxzvfdKhU3flo4TQlTNEhD7WvGd/MsvQ8zROWW0MU4NkqaJ0oZXi7oQoN55CoKnQHfS+CCazFqE/AkEo2r06pDBRzFj6/tBOSCuZeHRoa3zLpmK5/ysltgCX7gubMbxgPHPGhyfcQeG+bkCHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076778; c=relaxed/simple;
	bh=Y5Vj4BGznGMYCDZp5U/UaYL53YbReDL7EZDaEI48aDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BB6+AZWvGfCKGPqVSPDFv9JF5TmgWIawGUwPOoTFsjlmnU1dSj2/h/F99IszrPI9UnzDytokMTZVHPNzoGJGaUslbP1+yUp7+FNIa5KhfUJOJ8pSOhcQAJ1tb4zZQdzLDCv2dUKKf3DRYnz1MCTbj4OygECjCBYnpUHZai+4C0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37k-0007o7-Cj; Mon, 19 Aug 2024 16:12:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37i-001YDp-Pe; Mon, 19 Aug 2024 16:12:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37i-00BNQD-2K;
	Mon, 19 Aug 2024 16:12:42 +0200
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
Subject: [PATCH net-next v1 2/3] ethtool: Add support for specifying information source in cable test results
Date: Mon, 19 Aug 2024 16:12:40 +0200
Message-Id: <20240819141241.2711601-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240819141241.2711601-1-o.rempel@pengutronix.de>
References: <20240819141241.2711601-1-o.rempel@pengutronix.de>
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
 include/linux/ethtool_netlink.h | 29 +++++++++++++++++++++++------
 net/ethtool/cabletest.c         | 14 ++++++++++----
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
index fae0dfb9a9c82..aba91335273af 100644
--- a/include/linux/ethtool_netlink.h
+++ b/include/linux/ethtool_netlink.h
@@ -23,8 +23,10 @@ struct phy_device;
 int ethnl_cable_test_alloc(struct phy_device *phydev, u8 cmd);
 void ethnl_cable_test_free(struct phy_device *phydev);
 void ethnl_cable_test_finished(struct phy_device *phydev);
-int ethnl_cable_test_result(struct phy_device *phydev, u8 pair, u8 result);
-int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm);
+int ethnl_cable_test_result_with_src(struct phy_device *phydev, u8 pair,
+				     u8 result, u32 src);
+int ethnl_cable_test_fault_length_with_src(struct phy_device *phydev, u8 pair,
+					   u32 cm, u32 src);
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
+						   u8 pair, u8 result, u32 src)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int ethnl_cable_test_fault_length(struct phy_device *phydev,
-						u8 pair, u32 cm)
+static inline int ethnl_cable_test_fault_length_with_src(struct phy_device *phydev,
+							 u8 pair, u32 cm, u32 src)
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
index f6f136ec7ddfc..6e87e30492c4e 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -160,7 +160,8 @@ void ethnl_cable_test_finished(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(ethnl_cable_test_finished);
 
-int ethnl_cable_test_result(struct phy_device *phydev, u8 pair, u8 result)
+int ethnl_cable_test_result_with_src(struct phy_device *phydev, u8 pair,
+				     u8 result, u32 src)
 {
 	struct nlattr *nest;
 	int ret = -EMSGSIZE;
@@ -173,6 +174,8 @@ int ethnl_cable_test_result(struct phy_device *phydev, u8 pair, u8 result)
 		goto err;
 	if (nla_put_u8(phydev->skb, ETHTOOL_A_CABLE_RESULT_CODE, result))
 		goto err;
+	if (nla_put_u32(phydev->skb, ETHTOOL_A_CABLE_RESULT_SRC, src))
+		goto err;
 
 	nla_nest_end(phydev->skb, nest);
 	return 0;
@@ -181,9 +184,10 @@ int ethnl_cable_test_result(struct phy_device *phydev, u8 pair, u8 result)
 	nla_nest_cancel(phydev->skb, nest);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ethnl_cable_test_result);
+EXPORT_SYMBOL_GPL(ethnl_cable_test_result_with_src);
 
-int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm)
+int ethnl_cable_test_fault_length_with_src(struct phy_device *phydev, u8 pair,
+					   u32 cm, u32 src)
 {
 	struct nlattr *nest;
 	int ret = -EMSGSIZE;
@@ -197,6 +201,8 @@ int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm)
 		goto err;
 	if (nla_put_u32(phydev->skb, ETHTOOL_A_CABLE_FAULT_LENGTH_CM, cm))
 		goto err;
+	if (nla_put_u32(phydev->skb, ETHTOOL_A_CABLE_FAULT_LENGTH_SRC, src))
+		goto err;
 
 	nla_nest_end(phydev->skb, nest);
 	return 0;
@@ -205,7 +211,7 @@ int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm)
 	nla_nest_cancel(phydev->skb, nest);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ethnl_cable_test_fault_length);
+EXPORT_SYMBOL_GPL(ethnl_cable_test_fault_length_with_src);
 
 static const struct nla_policy cable_test_tdr_act_cfg_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST]	= { .type = NLA_U32 },
-- 
2.39.2


