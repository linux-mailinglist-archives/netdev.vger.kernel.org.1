Return-Path: <netdev+bounces-221787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D8FB51DB6
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0751018896F1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79133A03D;
	Wed, 10 Sep 2025 16:29:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B76334376
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521758; cv=none; b=b82OllJ+xhenB++vb7LWUPSFm/JaGThsxMTk6bYzt0lhuUOj6n7ljQQ24dpWtKk20QDooXY1Qo7tEuNEadu24PkiGS39cmwQlzeGuQrLwO4QUi2dTsmUK14PNImmzzMwFRs8KPVflhE6PQgcBhf0TUCJg7nDGkQ2uKSsbMZuYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521758; c=relaxed/simple;
	bh=f8Xw2Ag63ubhhZolri6MAHXX0klnntUY84aYWu7T+4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDhZA16foXrn0fpU4+WzMG+fPnIXaCZeRNizGTA5FgHaxc+7YbDqv37IzdOvX+n6mSDKFdr1JP/66768tUBQvWWQDsERasNI1WbvdftH0bq1Y+m9xMKXCIusbAlJJkS2PW1zXM/33fK4d+LjNhoIBLVS5F5tneNyqpFuvukwOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwNh5-0004sH-5t
	for netdev@vger.kernel.org; Wed, 10 Sep 2025 18:29:15 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwNh3-000cXA-38
	for netdev@vger.kernel.org;
	Wed, 10 Sep 2025 18:29:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A958846B202
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:29:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0FF8446B1CB;
	Wed, 10 Sep 2025 16:29:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d9e09faf;
	Wed, 10 Sep 2025 16:29:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Anssi Hannula <anssi.hannula@bitwise.fi>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 6/7] can: xilinx_can: xcan_write_frame(): fix use-after-free of transmitted SKB
Date: Wed, 10 Sep 2025 18:20:26 +0200
Message-ID: <20250910162907.948454-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910162907.948454-1-mkl@pengutronix.de>
References: <20250910162907.948454-1-mkl@pengutronix.de>
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

From: Anssi Hannula <anssi.hannula@bitwise.fi>

can_put_echo_skb() takes ownership of the SKB and it may be freed
during or after the call.

However, xilinx_can xcan_write_frame() keeps using SKB after the call.

Fix that by only calling can_put_echo_skb() after the code is done
touching the SKB.

The tx_lock is held for the entire xcan_write_frame() execution and
also on the can_get_echo_skb() side so the order of operations does not
matter.

An earlier fix commit 3d3c817c3a40 ("can: xilinx_can: Fix usage of skb
memory") did not move the can_put_echo_skb() call far enough.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Fixes: 1598efe57b3e ("can: xilinx_can: refactor code in preparation for CAN FD support")
Link: https://patch.msgid.link/20250822095002.168389-1-anssi.hannula@bitwise.fi
[mkl: add "commit" in front of sha1 in patch description]
[mkl: fix indention]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 81baec8eb1e5..a25a3ca62c12 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -690,14 +690,6 @@ static void xcan_write_frame(struct net_device *ndev, struct sk_buff *skb,
 		dlc |= XCAN_DLCR_EDL_MASK;
 	}
 
-	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
-	    (priv->devtype.flags & XCAN_FLAG_TXFEMP))
-		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
-	else
-		can_put_echo_skb(skb, ndev, 0, 0);
-
-	priv->tx_head++;
-
 	priv->write_reg(priv, XCAN_FRAME_ID_OFFSET(frame_offset), id);
 	/* If the CAN frame is RTR frame this write triggers transmission
 	 * (not on CAN FD)
@@ -730,6 +722,14 @@ static void xcan_write_frame(struct net_device *ndev, struct sk_buff *skb,
 					data[1]);
 		}
 	}
+
+	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
+	    (priv->devtype.flags & XCAN_FLAG_TXFEMP))
+		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
+	else
+		can_put_echo_skb(skb, ndev, 0, 0);
+
+	priv->tx_head++;
 }
 
 /**
-- 
2.51.0



