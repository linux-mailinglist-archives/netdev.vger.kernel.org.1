Return-Path: <netdev+bounces-109105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D31926EED
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0DD9B210FF
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB523146A6F;
	Thu,  4 Jul 2024 05:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE2DDA9
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071625; cv=none; b=pINTHzaheaVxskShi3BOafaBGQsgKA8uJ/TY7geUvebx3e8F6ptqyg3YWIiiREw052b9gIniNGQ0xgyxEHgMJOinIlB9BgjHRTRo9glWWLY2OF1h/99cLzmxOMtzCUIng00boNvOv2Z/mlyUwV9knY6St7T0cX8TDjWN7a3jAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071625; c=relaxed/simple;
	bh=RxYhbKxDFWrB9aIz/ch+jfVzAZ+tULj6Z/kHMQNrK7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c9y8shG/iX+d98+xSk4zw6XEG/GTZTzvTzORj2UfqYqBDCQ7LOZ5X+pLtrxvcpWWPsIUbuRzCXWA+s9iB7k6Uofs+PSU2q9K6wGxdxh3uk51J9mdVUfMzkhmkEadQuJYtEKFSvzjC0k7oWpRFm1p+Q4zBRZYVXE6Lsu4+mQ7J3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPFCU-0002Q3-MW; Thu, 04 Jul 2024 07:40:10 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPFCT-00717s-4G; Thu, 04 Jul 2024 07:40:09 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPFCT-0044EP-0B;
	Thu, 04 Jul 2024 07:40:09 +0200
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
Subject: [PATCH net v1 1/1] ethtool: netlink: do not return SQI value if link is down
Date: Thu,  4 Jul 2024 07:40:07 +0200
Message-Id: <20240704054007.969557-1-o.rempel@pengutronix.de>
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

Do not attach SQI value if link is down. "SQI values are only valid if link-up
condition is present" per OpenAlliance specification of 100Base-T1
Interoperability Test suite [1]. The same rule would apply for other link
types.

[1] https://opensig.org/automotive-ethernet-specifications/#

Fixes: 8066021915924 ("ethtool: provide UAPI for PHY Signal Quality Index (SQI)")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/ethtool/linkstate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index b2de2108b356a..370ae628b13a4 100644
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
@@ -93,12 +97,12 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 	data->link = __ethtool_get_link(dev);
 
 	ret = linkstate_get_sqi(dev);
-	if (ret < 0 && ret != -EOPNOTSUPP)
+	if (ret < 0 && ret != -EOPNOTSUPP && ret != -ENETDOWN)
 		goto out;
 	data->sqi = ret;
 
 	ret = linkstate_get_sqi_max(dev);
-	if (ret < 0 && ret != -EOPNOTSUPP)
+	if (ret < 0 && ret != -EOPNOTSUPP && ret != -ENETDOWN)
 		goto out;
 	data->sqi_max = ret;
 
@@ -136,10 +140,10 @@ static int linkstate_reply_size(const struct ethnl_req_info *req_base,
 	len = nla_total_size(sizeof(u8)) /* LINKSTATE_LINK */
 		+ 0;
 
-	if (data->sqi != -EOPNOTSUPP)
+	if (data->sqi != -EOPNOTSUPP && data->sqi != -ENETDOWN)
 		len += nla_total_size(sizeof(u32));
 
-	if (data->sqi_max != -EOPNOTSUPP)
+	if (data->sqi_max != -EOPNOTSUPP && data->sqi_max != -ENETDOWN)
 		len += nla_total_size(sizeof(u32));
 
 	if (data->link_ext_state_provided)
@@ -164,11 +168,11 @@ static int linkstate_fill_reply(struct sk_buff *skb,
 	    nla_put_u8(skb, ETHTOOL_A_LINKSTATE_LINK, !!data->link))
 		return -EMSGSIZE;
 
-	if (data->sqi != -EOPNOTSUPP &&
+	if (data->sqi != -EOPNOTSUPP && data->sqi != -ENETDOWN &&
 	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
 		return -EMSGSIZE;
 
-	if (data->sqi_max != -EOPNOTSUPP &&
+	if (data->sqi_max != -EOPNOTSUPP && data->sqi_max != -ENETDOWN &&
 	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI_MAX, data->sqi_max))
 		return -EMSGSIZE;
 
-- 
2.39.2


