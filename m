Return-Path: <netdev+bounces-225847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1394B98D3C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8FC4C32B8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D5228A3FA;
	Wed, 24 Sep 2025 08:21:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5A6283CBD
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702110; cv=none; b=sL7uG6jVM1ynssl8R7OvjHw0cwSrwC4ikQIvzmL8rXs7Pm+jp0TJqO63ik7KEjQ4gzAr8KwavgPJjHOecamr62Igy/SBCachz8qY7T59rfVuUzHOfAhox2a9XJCXO+ea4Ga5iv04aJCybUaqH8YCUklvBpckRAdnC4MgPSwv2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702110; c=relaxed/simple;
	bh=/rW5bL4vMzVF+mkyCg921+as0SWv9bxsZhWsypFvWB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhWwCvcwwslk8r/GFjd2asikzXFSgQGsthiDzq4rRVm3Ixtc4RsHFOZikK8nv9stRwLg471WX/jfbdlccH8p5RTszz0QFqQQdwPLc1+F83EXngrtDTZNwRT3ZdJhZOxIlRI1twXxWFtGr3zeFh/2Dde8eob0QJAuFeuuSrbzfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001E8-5H; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000DvW-1X;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 26F3C4788BE;
	Wed, 24 Sep 2025 08:21:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 45/48] can: netlink: make can_tdc_fill_info() FD agnostic
Date: Wed, 24 Sep 2025 10:07:02 +0200
Message-ID: <20250924082104.595459-46-mkl@pengutronix.de>
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

can_tdc_fill_info() depends on some variables which are specific to CAN
FD. Move these to the function parameters list so that, later on, this
function can be reused for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-17-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 9794f283ed58..99038e0fb25f 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -585,21 +585,34 @@ static int can_bitrate_const_fill_info(struct sk_buff *skb,
 			sizeof(*bitrate_const) * cnt, bitrate_const);
 }
 
-static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
+static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
+			     int ifla_can_tdc)
 {
-	struct nlattr *nest;
 	struct can_priv *priv = netdev_priv(dev);
-	struct can_tdc *tdc = &priv->fd.tdc;
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	struct data_bittiming_params *dbt_params;
+	const struct can_tdc_const *tdc_const;
+	struct can_tdc *tdc;
+	struct nlattr *nest;
+	bool tdc_is_enabled, tdc_manual;
+
+	if (ifla_can_tdc == IFLA_CAN_TDC) {
+		dbt_params = &priv->fd;
+		tdc_is_enabled = can_fd_tdc_is_enabled(priv);
+		tdc_manual = priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL;
+	} else {
+		return -EOPNOTSUPP; /* Place holder for CAN XL */
+	}
+	tdc_const = dbt_params->tdc_const;
+	tdc = &dbt_params->tdc;
 
 	if (!tdc_const)
 		return 0;
 
-	nest = nla_nest_start(skb, IFLA_CAN_TDC);
+	nest = nla_nest_start(skb, ifla_can_tdc);
 	if (!nest)
 		return -EMSGSIZE;
 
-	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL &&
+	if (tdc_manual &&
 	    (nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MIN, tdc_const->tdcv_min) ||
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MAX, tdc_const->tdcv_max)))
 		goto err_cancel;
@@ -611,15 +624,15 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MAX, tdc_const->tdcf_max)))
 		goto err_cancel;
 
-	if (can_fd_tdc_is_enabled(priv)) {
+	if (tdc_is_enabled) {
 		u32 tdcv;
 		int err = -EINVAL;
 
-		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		if (tdc_manual) {
 			tdcv = tdc->tdcv;
 			err = 0;
-		} else if (priv->fd.do_get_auto_tdcv) {
-			err = priv->fd.do_get_auto_tdcv(dev, &tdcv);
+		} else if (dbt_params->do_get_auto_tdcv) {
+			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
 		}
 		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
 			goto err_cancel;
@@ -707,7 +720,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		     sizeof(priv->bitrate_max),
 		     &priv->bitrate_max)) ||
 
-	    can_tdc_fill_info(skb, dev) ||
+	    can_tdc_fill_info(skb, dev, IFLA_CAN_TDC) ||
 
 	    can_ctrlmode_ext_fill_info(skb, priv)
 	    )
-- 
2.51.0


