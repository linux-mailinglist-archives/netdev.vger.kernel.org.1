Return-Path: <netdev+bounces-225874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9F4B98DB5
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054651883BB1
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18D2C2377;
	Wed, 24 Sep 2025 08:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495128CF5D
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702118; cv=none; b=n3/PeDacuPumgEYEjOKV2y1jCklnONuVYkVBqH4L3IWMO7fd/1sjaCAAW1dS6uqsLjWTJ5kJq7zdP3I/lohqSqlil9RtrOSP+8mVysqrhYbiNsQkAfe9ADU+NezL7kzivy7Gk5xzDZfoXDDpsrzwSlnmI7JLz/iqJ17K6ox8w8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702118; c=relaxed/simple;
	bh=nhUCSKIL2hYdeXzob67zd28PoDnumsPgGFB5dT9HytA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpjOyxEd0TNMw9S0ZBnrHtT0TsRB9z/th12Ffh+rhJiLnRuVak2lfA5UwyvcxnNGQxYQ1O44jnMillQTpcqF6T3IZEHT8+dgL1vr/SJxCG9VpDyvjg4Ls3oTnYbCi15Np7NIOdVAqWr3Fd2ixEQKBPvs5f74qKjHDVL6lKVoxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001G5-4m; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000DwH-17;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 974D64788B2;
	Wed, 24 Sep 2025 08:21:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 39/48] can: netlink: add can_ctrlmode_changelink()
Date: Wed, 24 Sep 2025 10:06:56 +0200
Message-ID: <20250924082104.595459-40-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

Split the control mode change link logic into a new function:
can_ctrlmode_changelink(). The purpose is to increase code readability
by preventing can_changelink() from becoming too big.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-11-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 96 ++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 5f2962aab576..e1a1767c0a6c 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -172,6 +172,59 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
+static int can_ctrlmode_changelink(struct net_device *dev,
+				   struct nlattr *data[],
+				   struct netlink_ext_ack *extack)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_ctrlmode *cm;
+	u32 maskedflags;
+	u32 ctrlstatic;
+
+	if (!data[IFLA_CAN_CTRLMODE])
+		return 0;
+
+	/* Do not allow changing controller mode while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	cm = nla_data(data[IFLA_CAN_CTRLMODE]);
+	maskedflags = cm->flags & cm->mask;
+	ctrlstatic = can_get_static_ctrlmode(priv);
+
+	/* check whether provided bits are allowed to be passed */
+	if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
+		return -EOPNOTSUPP;
+
+	/* do not check for static fd-non-iso if 'fd' is disabled */
+	if (!(maskedflags & CAN_CTRLMODE_FD))
+		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+
+	/* make sure static options are provided by configuration */
+	if ((maskedflags & ctrlstatic) != ctrlstatic)
+		return -EOPNOTSUPP;
+
+	/* If a top dependency flag is provided, reset all its dependencies */
+	if (cm->mask & CAN_CTRLMODE_FD)
+		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+
+	/* clear bits to be modified and copy the flag values */
+	priv->ctrlmode &= ~cm->mask;
+	priv->ctrlmode |= maskedflags;
+
+	/* Wipe potential leftovers from previous CAN FD config */
+	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
+		memset(&priv->fd.data_bittiming, 0,
+		       sizeof(priv->fd.data_bittiming));
+		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
+	}
+
+	can_set_default_mtu(dev);
+
+	return 0;
+}
+
 static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
 			      const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
@@ -315,48 +368,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
-	if (data[IFLA_CAN_CTRLMODE]) {
-		struct can_ctrlmode *cm;
-		u32 ctrlstatic;
-		u32 maskedflags;
-
-		/* Do not allow changing controller mode while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		ctrlstatic = can_get_static_ctrlmode(priv);
-		maskedflags = cm->flags & cm->mask;
-
-		/* check whether provided bits are allowed to be passed */
-		if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
-			return -EOPNOTSUPP;
-
-		/* do not check for static fd-non-iso if 'fd' is disabled */
-		if (!(maskedflags & CAN_CTRLMODE_FD))
-			ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
-
-		/* make sure static options are provided by configuration */
-		if ((maskedflags & ctrlstatic) != ctrlstatic)
-			return -EOPNOTSUPP;
-
-		/* If a top dependency flag is provided, reset all its dependencies */
-		if (cm->mask & CAN_CTRLMODE_FD)
-			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
-
-		/* clear bits to be modified and copy the flag values */
-		priv->ctrlmode &= ~cm->mask;
-		priv->ctrlmode |= maskedflags;
-
-		/* Wipe potential leftovers from previous CAN FD config */
-		if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
-			memset(&priv->fd.data_bittiming, 0,
-			       sizeof(priv->fd.data_bittiming));
-			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
-			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
-		}
-
-		can_set_default_mtu(dev);
-	}
+	can_ctrlmode_changelink(dev, data, extack);
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;
-- 
2.51.0


