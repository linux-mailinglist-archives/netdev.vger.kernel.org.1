Return-Path: <netdev+bounces-153886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDBA9F9F33
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 09:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5AE16BFD5
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A291F0E2B;
	Sat, 21 Dec 2024 08:15:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF41DF986
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734768952; cv=none; b=nra+g+ihJ9+x8X0QzESQF6ztC4a32p89S8ObjIAJic8lTl77I6XjcSadrEwS8SD2ygattzlCkpk4lSiv8KXEXyjWSFtlV46dr4E1JcGn1X8BraWTn8Xt5LBT3pmEm+1Mi7uIhut+gS2CNnVXgutobAmTLX0dQhU4B6TBvahPaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734768952; c=relaxed/simple;
	bh=IezSPtzCA+GIk5IpkRFZvleekPS1quzOod7dsNbrjWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNf3YXtCuZiAoXX8aEl/cF5Q+ckfri+3XZ+uDmb86FZU5ZIwUw0g3NWmo2s4F3ySQWX1zIZO60VcYrOkcvRRiwqBD8JYn3dH6/HPHDTorywg1duwCJuZhJfg5tLGxMcJ+1+yZ+szzNQWc8IDD9/N04Cxh7jXvTxi7lV6oB6BWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue8-0000Qm-3p; Sat, 21 Dec 2024 09:15:36 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue2-004Vdo-2p;
	Sat, 21 Dec 2024 09:15:31 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue3-00CbSj-1r;
	Sat, 21 Dec 2024 09:15:31 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v4 1/8] ethtool: linkstate: migrate linkstate functions to support multi-PHY setups
Date: Sat, 21 Dec 2024 09:15:23 +0100
Message-Id: <20241221081530.3003900-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241221081530.3003900-1-o.rempel@pengutronix.de>
References: <20241221081530.3003900-1-o.rempel@pengutronix.de>
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

Adapt linkstate_get_sqi() and linkstate_get_sqi_max() to take a
phy_device argument directly, enabling support for setups with
multiple PHYs. The previous assumption of a single PHY attached to
a net_device no longer holds.

Use ethnl_req_get_phydev() to identify the appropriate PHY device
for the operation. Update linkstate_prepare_data() and related
logic to accommodate this change, ensuring compatibility with
multi-PHY configurations.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- s/ETHTOOL_A_PLCA_HEADER/ETHTOOL_A_LINKSTATE_HEADER
---
 net/ethtool/linkstate.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 34d76e87847d..459cfea7652d 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -26,9 +26,8 @@ const struct nla_policy ethnl_linkstate_get_policy[] = {
 		NLA_POLICY_NESTED(ethnl_header_policy_stats),
 };
 
-static int linkstate_get_sqi(struct net_device *dev)
+static int linkstate_get_sqi(struct phy_device *phydev)
 {
-	struct phy_device *phydev = dev->phydev;
 	int ret;
 
 	if (!phydev)
@@ -46,9 +45,8 @@ static int linkstate_get_sqi(struct net_device *dev)
 	return ret;
 }
 
-static int linkstate_get_sqi_max(struct net_device *dev)
+static int linkstate_get_sqi_max(struct phy_device *phydev)
 {
-	struct phy_device *phydev = dev->phydev;
 	int ret;
 
 	if (!phydev)
@@ -100,19 +98,28 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct linkstate_reply_data *data = LINKSTATE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_LINKSTATE_HEADER],
+				      info->extack);
+	if (IS_ERR(phydev)) {
+		ret = PTR_ERR(phydev);
+		goto out;
+	}
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
 	data->link = __ethtool_get_link(dev);
 
-	ret = linkstate_get_sqi(dev);
+	ret = linkstate_get_sqi(phydev);
 	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi = ret;
 
-	ret = linkstate_get_sqi_max(dev);
+	ret = linkstate_get_sqi_max(phydev);
 	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi_max = ret;
@@ -127,9 +134,9 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 			   sizeof(data->link_stats) / 8);
 
 	if (req_base->flags & ETHTOOL_FLAG_STATS) {
-		if (dev->phydev)
+		if (phydev)
 			data->link_stats.link_down_events =
-				READ_ONCE(dev->phydev->link_down_events);
+				READ_ONCE(phydev->link_down_events);
 
 		if (dev->ethtool_ops->get_link_ext_stats)
 			dev->ethtool_ops->get_link_ext_stats(dev,
-- 
2.39.5


