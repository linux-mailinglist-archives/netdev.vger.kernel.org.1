Return-Path: <netdev+bounces-225878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CDB98DC7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D076318872C8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A152D0C7B;
	Wed, 24 Sep 2025 08:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55772848BE
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702119; cv=none; b=Qp2aSnQTOozLpsHCndLtJYhthDweWh431QuQOODH5Me+SN9tO0/a345lo2wkZpBLyLBB6xQ7gdcIqi4Ppmng2tLJyRt5T6MU9DPEnVvE8rBiG+6yfBsNCNnOrmSh8fPLOxByUR2kfbNgUYR3TY0XPwo3CXj21C7xLJ8l2GxsGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702119; c=relaxed/simple;
	bh=Z/pNAdqrWIaqXBTMawOf4mTZoJtBr0M4jIi2iNGtBW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/Kszl2NpEsFsAQYpuN8bION5rmQPHLME6Bn0xlYjLK1tKyuvjwHHp2faC7h36Tms8haThoYM2aBT772l7G+D+HANyka5NFo5Y2tG/bCMOyDNHW/Nxrja940EbGrjUadWXsbYxnR2JW1dAz3bXB1yva1G8IKpMRSNn7KmnOrQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001GZ-8G; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dx0-28;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3D794788BA;
	Wed, 24 Sep 2025 08:21:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 43/48] can: netlink: add can_bittiming_const_fill_info()
Date: Wed, 24 Sep 2025 10:07:00 +0200
Message-ID: <20250924082104.595459-44-mkl@pengutronix.de>
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

Add function can_bittiming_const_fill_info() to factorise the logic
when filling the bittiming constant information for Classical CAN and
CAN FD. This function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-15-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index bedd2611d358..fa922a61f75a 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -567,6 +567,15 @@ static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
 		nla_put(skb, ifla_can_bittiming, sizeof(*bittiming), bittiming);
 }
 
+static int can_bittiming_const_fill_info(struct sk_buff *skb,
+					 int ifla_can_bittiming_const,
+					 const struct can_bittiming_const *bittiming_const)
+{
+	return bittiming_const &&
+		nla_put(skb, ifla_can_bittiming_const,
+			sizeof(*bittiming_const), bittiming_const);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -652,9 +661,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (can_bittiming_fill_info(skb, IFLA_CAN_BITTIMING,
 				    &priv->bittiming) ||
 
-	    (priv->bittiming_const &&
-	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
-		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
+	    can_bittiming_const_fill_info(skb, IFLA_CAN_BITTIMING_CONST,
+					  priv->bittiming_const) ||
 
 	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(priv->clock), &priv->clock) ||
 	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
@@ -668,10 +676,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    can_bittiming_fill_info(skb, IFLA_CAN_DATA_BITTIMING,
 				    &priv->fd.data_bittiming) ||
 
-	    (priv->fd.data_bittiming_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
-		     sizeof(*priv->fd.data_bittiming_const),
-		     priv->fd.data_bittiming_const)) ||
+	    can_bittiming_const_fill_info(skb, IFLA_CAN_DATA_BITTIMING_CONST,
+					  priv->fd.data_bittiming_const) ||
 
 	    (priv->termination_const &&
 	     (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||
-- 
2.51.0


