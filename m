Return-Path: <netdev+bounces-225860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8EB98D48
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E57114E1A5D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7729E0E7;
	Wed, 24 Sep 2025 08:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB7286883
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702112; cv=none; b=UHFMv9S2RlzL1JeHXU1SFtcemLTsiGU+cQ0hfMbruUM9cIpdXSeIhAYDohpej2Bap8DrVeyOLKWSazq3s2XjCTMEvQFQ9EPHJW2S+nlrPNXh1FeYjE1hXO7R/rxc4KHul2kG2xOcMdOf5cHK0z8v4+1L6eG5TXZSIm2b7NIYl08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702112; c=relaxed/simple;
	bh=TID6G+rLF2v38cQ038vN1hh/4REOykjC4eOmkObe34c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaafVgqmVCdcPZpdGK04+zxv9BJmQ5zkOwu953BW0PQ2rMephYoUJ71AegMCZIrUQaSCKkK/ehIeHKx3zV2kOXpflzxR82NJjI3XhOTM8IiPAJzRQdy2Zkdr+LQJznabFgoXqCnpdXXL0tNDNyvAD/Sb8dhuHwh4NF3IzxmIYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001E3-5G; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000DvM-1C;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 13DD84788BC;
	Wed, 24 Sep 2025 08:21:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 44/48] can: netlink: add can_bitrate_const_fill_info()
Date: Wed, 24 Sep 2025 10:07:01 +0200
Message-ID: <20250924082104.595459-45-mkl@pengutronix.de>
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

Add can_bitrate_const_fill_info() to factorise the logic when filling
the bitrate constant information for Classical CAN and CAN FD. This
function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-16-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index fa922a61f75a..9794f283ed58 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -576,6 +576,15 @@ static int can_bittiming_const_fill_info(struct sk_buff *skb,
 			sizeof(*bittiming_const), bittiming_const);
 }
 
+static int can_bitrate_const_fill_info(struct sk_buff *skb,
+				       int ifla_can_bitrate_const,
+				       const u32 *bitrate_const, unsigned int cnt)
+{
+	return bitrate_const &&
+		nla_put(skb, ifla_can_bitrate_const,
+			sizeof(*bitrate_const) * cnt, bitrate_const);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -686,17 +695,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		      priv->termination_const_cnt,
 		      priv->termination_const))) ||
 
-	    (priv->bitrate_const &&
-	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
-		     sizeof(*priv->bitrate_const) *
-		     priv->bitrate_const_cnt,
-		     priv->bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_BITRATE_CONST,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt) ||
 
-	    (priv->fd.data_bitrate_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
-		     sizeof(*priv->fd.data_bitrate_const) *
-		     priv->fd.data_bitrate_const_cnt,
-		     priv->fd.data_bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_DATA_BITRATE_CONST,
+					priv->fd.data_bitrate_const,
+					priv->fd.data_bitrate_const_cnt) ||
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),
-- 
2.51.0


