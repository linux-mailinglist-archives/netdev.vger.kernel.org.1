Return-Path: <netdev+bounces-109603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27F92912A
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 07:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B0DB21812
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 05:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90BD179BD;
	Sat,  6 Jul 2024 05:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6718645
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720244962; cv=none; b=saWLtvICwf8P5OByK56hB5KSn6+Blm8DbV++qil1+z2qlehLgHSX9XtrvpOCL6xhbUF8MXW7CQ+lKtHqCVTmIXhluRf/SNxXXplQXakfFQZYHaqql98QAlrfpNvzHj/s+ccT0PVG3foCOiaBpcO50UFCVhMW6RnsDX5HlqZ57/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720244962; c=relaxed/simple;
	bh=m/RaNl4T9cQru0+ThZ5I54BlLb7Jgc1dzINgA/T+TNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bhwlOKeP7URBVVyFBrdnJLn+/Tk0Y9LJFo5+KxwuW/K+RBhWmuW/a2K2PzoT0vSZQhgmKiAFLr7B//gKm1T8/d5qyfsBUGFdSjDlLh18wz/tdcHI1dEkWzHotojmavyvvvjLL573eFh/bmo83RruOoGdH7/+FDOZBajcMtHkUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPyID-00037g-EA; Sat, 06 Jul 2024 07:49:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPyIA-007VN2-9D; Sat, 06 Jul 2024 07:49:02 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPyIA-005P6I-0g;
	Sat, 06 Jul 2024 07:49:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Michal Kubecek <mkubecek@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Woojung.Huh@microchip.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/1] ethtool: netlink: do not return SQI value if link is down
Date: Sat,  6 Jul 2024 07:49:00 +0200
Message-Id: <20240706054900.1288111-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Do not attach SQI value if link is down. "SQI values are only valid if
link-up condition is present" per OpenAlliance specification of
100Base-T1 Interoperability Test suite [1]. The same rule would apply
for other link types.

[1] https://opensig.org/automotive-ethernet-specifications/#

Fixes: 806602191592 ("ethtool: provide UAPI for PHY Signal Quality Index (SQI)")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- add and reuse helper functions linkstate_sqi_critical_error() and
  linkstate_sqi_valid()
- make sure we set sqi and sqi_max vals only if both are valid
---
 net/ethtool/linkstate.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index b2de2108b356a..4efd327ba5d92 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -37,6 +37,8 @@ static int linkstate_get_sqi(struct net_device *dev)
 	mutex_lock(&phydev->lock);
 	if (!phydev->drv || !phydev->drv->get_sqi)
 		ret = -EOPNOTSUPP;
+	else if (!phydev->link)
+		ret = -ENETDOWN;
 	else
 		ret = phydev->drv->get_sqi(phydev);
 	mutex_unlock(&phydev->lock);
@@ -55,6 +57,8 @@ static int linkstate_get_sqi_max(struct net_device *dev)
 	mutex_lock(&phydev->lock);
 	if (!phydev->drv || !phydev->drv->get_sqi_max)
 		ret = -EOPNOTSUPP;
+	else if (!phydev->link)
+		ret = -ENETDOWN;
 	else
 		ret = phydev->drv->get_sqi_max(phydev);
 	mutex_unlock(&phydev->lock);
@@ -62,6 +66,16 @@ static int linkstate_get_sqi_max(struct net_device *dev)
 	return ret;
 };
 
+static bool linkstate_sqi_critical_error(int sqi)
+{
+	return sqi < 0 && sqi != -EOPNOTSUPP && sqi != -ENETDOWN;
+}
+
+static bool linkstate_sqi_valid(struct linkstate_reply_data *data)
+{
+	return data->sqi >= 0 && data->sqi_max >= 0;
+}
+
 static int linkstate_get_link_ext_state(struct net_device *dev,
 					struct linkstate_reply_data *data)
 {
@@ -93,12 +107,12 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 	data->link = __ethtool_get_link(dev);
 
 	ret = linkstate_get_sqi(dev);
-	if (ret < 0 && ret != -EOPNOTSUPP)
+	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi = ret;
 
 	ret = linkstate_get_sqi_max(dev);
-	if (ret < 0 && ret != -EOPNOTSUPP)
+	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi_max = ret;
 
@@ -136,11 +150,10 @@ static int linkstate_reply_size(const struct ethnl_req_info *req_base,
 	len = nla_total_size(sizeof(u8)) /* LINKSTATE_LINK */
 		+ 0;
 
-	if (data->sqi != -EOPNOTSUPP)
-		len += nla_total_size(sizeof(u32));
-
-	if (data->sqi_max != -EOPNOTSUPP)
-		len += nla_total_size(sizeof(u32));
+	if (linkstate_sqi_valid(data)) {
+		len += nla_total_size(sizeof(u32)); /* LINKSTATE_SQI */
+		len += nla_total_size(sizeof(u32)); /* LINKSTATE_SQI_MAX */
+	}
 
 	if (data->link_ext_state_provided)
 		len += nla_total_size(sizeof(u8)); /* LINKSTATE_EXT_STATE */
@@ -164,13 +177,14 @@ static int linkstate_fill_reply(struct sk_buff *skb,
 	    nla_put_u8(skb, ETHTOOL_A_LINKSTATE_LINK, !!data->link))
 		return -EMSGSIZE;
 
-	if (data->sqi != -EOPNOTSUPP &&
-	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
-		return -EMSGSIZE;
+	if (linkstate_sqi_valid(data)) {
+		if (nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
+			return -EMSGSIZE;
 
-	if (data->sqi_max != -EOPNOTSUPP &&
-	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI_MAX, data->sqi_max))
-		return -EMSGSIZE;
+		if (nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI_MAX,
+				data->sqi_max))
+			return -EMSGSIZE;
+	}
 
 	if (data->link_ext_state_provided) {
 		if (nla_put_u8(skb, ETHTOOL_A_LINKSTATE_EXT_STATE,
-- 
2.39.2


