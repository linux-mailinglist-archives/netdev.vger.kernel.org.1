Return-Path: <netdev+bounces-196027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1FAD32B6
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED93B173B57
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9140B28D8F0;
	Tue, 10 Jun 2025 09:49:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B451FF5F9
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548983; cv=none; b=IvEm9PDKAwmZwKIx5JQNC0xrMmAnlJebuolg0YO9pbFxca/GvgUVgl8NTN7x+aIrOUK1ISVq8oKFoMQTdH4V13cKjlW77sQ3rJtG4S7ZkHwwGENscwLD/avXTz5WQZnHwyAz6jBOFvPGhiE7yUgu83bG2esOhypx+0PNs9Gy9rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548983; c=relaxed/simple;
	bh=weM+OnsNvV4FWKwTPqn0FVRndQe1+bf9ZR7EdL/YkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcRlQcnP2rJKmi+YeChScXebLmL9uvSdQjwkfVjTiR7SwrI5eS4gTk/EJN8lGKPPzmzd+m8AvsT7ruZa5F+sTea5SE2X4Vnsi6UyMeutwQDfgcsY5V89uBrPwI5h0aY3xpqT5/7fFzeVRLLxVnwGyXMclfpChjakG9PmGrktVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbv-00067C-AE
	for netdev@vger.kernel.org; Tue, 10 Jun 2025 11:49:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbu-002kdy-1a
	for netdev@vger.kernel.org;
	Tue, 10 Jun 2025 11:49:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 232954241BA
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:49:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9AF28424189;
	Tue, 10 Jun 2025 09:49:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d87a5492;
	Tue, 10 Jun 2025 09:49:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Davide Caratti <dcaratti@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 6/7] can: add drop reasons in the receive path of AF_CAN
Date: Tue, 10 Jun 2025 11:46:21 +0200
Message-ID: <20250610094933.1593081-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610094933.1593081-1-mkl@pengutronix.de>
References: <20250610094933.1593081-1-mkl@pengutronix.de>
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

From: Davide Caratti <dcaratti@redhat.com>

Besides the existing pr_warn_once(), use skb drop reasons in case AF_CAN
layer drops non-conformant CAN{,FD,XL} frames, or conformant frames
received by "wrong" devices, so that it's possible to debug (and count)
such events using existing tracepoints:

| # perf record -e skb:kfree_skb -aR -- ./drv/canfdtest -v -g -l 1 vcan0
| # perf script
| [...]
| canfdtest  1123 [000]  3893.271264: skb:kfree_skb: skbaddr=0xffff975703c9f700 rx_sk=(nil) protocol=12 location=can_rcv+0x4b  reason: CAN_RX_INVALID_FRAME

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Link: https://patch.msgid.link/20250604160605.1005704-2-dcaratti@redhat.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/net/dropreason-core.h | 18 ++++++++++++++++++
 net/can/af_can.c              |  6 +++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index bcf9d7467e1a..b9e78290269e 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -121,6 +121,9 @@
 	FN(ARP_PVLAN_DISABLE)		\
 	FN(MAC_IEEE_MAC_CONTROL)	\
 	FN(BRIDGE_INGRESS_STP_STATE)	\
+	FN(CAN_RX_INVALID_FRAME)	\
+	FN(CANFD_RX_INVALID_FRAME)	\
+	FN(CANXL_RX_INVALID_FRAME)	\
 	FNe(MAX)
 
 /**
@@ -573,6 +576,21 @@ enum skb_drop_reason {
 	 * ingress bridge port does not allow frames to be forwarded.
 	 */
 	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
+	/**
+	 * @SKB_DROP_REASON_CAN_RX_INVALID_FRAME: received
+	 * non conform CAN frame (or device is unable to receive CAN frames)
+	 */
+	SKB_DROP_REASON_CAN_RX_INVALID_FRAME,
+	/**
+	 * @SKB_DROP_REASON_CANFD_RX_INVALID_FRAME: received
+	 * non conform CAN-FD frame (or device is unable to receive CAN frames)
+	 */
+	SKB_DROP_REASON_CANFD_RX_INVALID_FRAME,
+	/**
+	 * @SKB_DROP_REASON_CANXL_RX_INVALID_FRAME: received
+	 * non conform CAN-XL frame (or device is unable to receive CAN frames)
+	 */
+	SKB_DROP_REASON_CANXL_RX_INVALID_FRAME,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 4aab7033c933..b2387a46794a 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -683,7 +683,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_CAN_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
@@ -698,7 +698,7 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_CANFD_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
@@ -713,7 +713,7 @@ static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_CANXL_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
-- 
2.47.2



