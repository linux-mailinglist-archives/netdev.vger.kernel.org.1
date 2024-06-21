Return-Path: <netdev+bounces-105690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A79124F6
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBCA2825E1
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078015218C;
	Fri, 21 Jun 2024 12:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47314F9EA
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972270; cv=none; b=nn3t1DJSiuJHARNte+FHaas9XHpkAkvby319ooBvWIRM/A2fshMLMfiDuS0nTdmJMl2yxIpgbvtpFcQvMHGS9UndxGXwR2Rok4osu+/SdhNS0gQpYnw4prxuPM/ggbJTsxuBcKv/rGIE/NTP5dreapojDdwOSXjLT8SWMoD/I7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972270; c=relaxed/simple;
	bh=LzVgQc+eKDZ2L0HBaWIGFUrE03cpmejzcha/92eBk1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TC4l8y+w9NbOOAXlzf2eESqVcv13uaLKzqfJP5+I+w+PuUpnojvbrTkCZV1w+kUNn3uc1tIGtwRnom5DVnBPWqG5dvURP/PKI7pRUtsWKCEp5ewBOSo4okMMHjsR5rcx73OgvA5mM0dy9gNIAkiVGi+GTs0yMef86BpRnVFR7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKdD8-0002O4-Ju
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 14:17:46 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKdD7-003wFB-4b
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 14:17:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C89DB2EE830
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 12:17:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C67DC2EE809;
	Fri, 21 Jun 2024 12:17:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8634ce34;
	Fri, 21 Jun 2024 12:17:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/5] net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new
Date: Fri, 21 Jun 2024 13:23:36 +0200
Message-ID: <20240621121739.434355-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621121739.434355-1-mkl@pengutronix.de>
References: <20240621121739.434355-1-mkl@pengutronix.de>
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

From: Oleksij Rempel <o.rempel@pengutronix.de>

This patch enhances error handling in scenarios with RTS (Request to
Send) messages arriving closely. It replaces the less informative WARN_ON_ONCE
backtraces with a new error handling method. This provides clearer error
messages and allows for the early termination of problematic sessions.
Previously, sessions were only released at the end of j1939_xtp_rx_rts().

Potentially this could be reproduced with something like:
testj1939 -r vcan0:0x80 &
while true; do
	# send first RTS
	cansend vcan0 18EC8090#1014000303002301;
	# send second RTS
	cansend vcan0 18EC8090#1014000303002301;
	# send abort
	cansend vcan0 18EC8090#ff00000000002301;
done

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/all/20231117124959.961171-1-o.rempel@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe3df23a2595..c6569f98d251 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1593,8 +1593,8 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	struct j1939_sk_buff_cb skcb = *j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	const u8 *dat;
+	int len, ret;
 	pgn_t pgn;
-	int len;
 
 	netdev_dbg(priv->ndev, "%s\n", __func__);
 
@@ -1653,7 +1653,22 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->tskey = priv->rx_tskey++;
 	j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_RTS);
 
-	WARN_ON_ONCE(j1939_session_activate(session));
+	ret = j1939_session_activate(session);
+	if (ret) {
+		/* Entering this scope indicates an issue with the J1939 bus.
+		 * Possible scenarios include:
+		 * - A time lapse occurred, and a new session was initiated
+		 *   due to another packet being sent correctly. This could
+		 *   have been caused by too long interrupt, debugger, or being
+		 *   out-scheduled by another task.
+		 * - The bus is receiving numerous erroneous packets, either
+		 *   from a malfunctioning device or during a test scenario.
+		 */
+		netdev_alert(priv->ndev, "%s: 0x%p: concurrent session with same addr (%02x %02x) is already active.\n",
+			     __func__, session, skcb.addr.sa, skcb.addr.da);
+		j1939_session_put(session);
+		return NULL;
+	}
 
 	return session;
 }

base-commit: 8851346912a1fa33e7a5966fe51f07313b274627
-- 
2.43.0



