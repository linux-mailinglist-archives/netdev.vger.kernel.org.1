Return-Path: <netdev+bounces-71301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12984852F6E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24002838DE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ABD376E6;
	Tue, 13 Feb 2024 11:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E023717A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824086; cv=none; b=tOHFp+1GoDhE96KhpQI+/urOX5GV1nLOpKW1KsySV6d/rkpg5foqz62M87OSuo+PZVSrXrCvVxCQNH0Y+xFW3FUO31x4zZC9zinvoPUohg95Lmms1v3dGtVc7YsnN1y5eg1p70urkbialmXOBqtlwE5ekDdCLKhKCB7XAk8EvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824086; c=relaxed/simple;
	bh=bEIc8h/Aqqv6z3a1vl6XcDEVVL1CiMYoyBdzePDp17o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqBBqvi25qQD1O0HWEMIRY63W1PJf2tQ7+GI1pep2jDpWR83me+8CvDsl8FDd1/EVrFQXr6QpMNpWAx7Ixo4yCtKPxlf3NwOaRGLS9/daZ0k3BzOwyyLZDJJ5bW8JXeRHt0jqem9nx4R2EoGLeq/eHW270Xwd0+P5vxqUkghU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3i-00016G-DL
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:42 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3h-000TR5-5k
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:41 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C3C8E28D650
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D5EE628D624;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 25e77370;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/23] can: isotp: support dynamic flow control parameters
Date: Tue, 13 Feb 2024 12:25:05 +0100
Message-ID: <20240213113437.1884372-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

The ISO15765-2 standard supports to take the PDUs communication parameters
blocksize (BS) and Separation Time minimum (STmin) either from the first
received flow control (FC) "static" or from every received FC "dynamic".

Add a new CAN_ISOTP_DYN_FC_PARMS flag to support dynamic FC parameters.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20231208165729.3011-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can/isotp.h | 1 +
 net/can/isotp.c                | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
index 439c982f7e81..6cde62371b6f 100644
--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -137,6 +137,7 @@ struct can_isotp_ll_options {
 #define CAN_ISOTP_WAIT_TX_DONE	0x0400	/* wait for tx completion */
 #define CAN_ISOTP_SF_BROADCAST	0x0800	/* 1-to-N functional addressing */
 #define CAN_ISOTP_CF_BROADCAST	0x1000	/* 1-to-N transmission w/o FC */
+#define CAN_ISOTP_DYN_FC_PARMS	0x2000	/* dynamic FC parameters BS/STmin */
 
 /* protocol machine default values */
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index d1c6f206f429..25bac0fafc83 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -381,8 +381,9 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 		return 1;
 	}
 
-	/* get communication parameters only from the first FC frame */
-	if (so->tx.state == ISOTP_WAIT_FIRST_FC) {
+	/* get static/dynamic communication params from first/every FC frame */
+	if (so->tx.state == ISOTP_WAIT_FIRST_FC ||
+	    so->opt.flags & CAN_ISOTP_DYN_FC_PARMS) {
 		so->txfc.bs = cf->data[ae + 1];
 		so->txfc.stmin = cf->data[ae + 2];
 
-- 
2.43.0



