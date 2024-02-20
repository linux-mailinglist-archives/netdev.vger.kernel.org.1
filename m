Return-Path: <netdev+bounces-73211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925DA85B5F5
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1B28387E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859015FB98;
	Tue, 20 Feb 2024 08:51:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066C5F481
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419100; cv=none; b=drusKKteEIrFjXETcz9Th7jM5JLss55H9WssoonyqPZxu6ukP+R8jpSnQ5sbB67R0YD7ZLW0Fqw3hx5+2y/ISbVlbNQjihjV7gB0oSv6Y7w+vVAZMV7JwcQKuI5OOw2+cRSGq9KossnsdzXPVdxqgayG6W9CpPbO/hBFpQ87FD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419100; c=relaxed/simple;
	bh=y+l3MKIT64LPOmsfFfzlB4BvU3thWCXlVoyfgqL4vLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy5R7KjZDxieoo1IA9nCbBxLFOI6jrhaqMhpQChcOanMSyiV+8qOV59pLibGksjQ++RcROpsBxTr53vRf/rxAG9qCnVbFb9quODDPrMOWnwvMpcUIO/+j/L7otg8HqABDLfM4xgwO8iEzYXZanNmtVbvj002EjCFzUDHzjRAkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqj-0001hw-2s
	for netdev@vger.kernel.org; Tue, 20 Feb 2024 09:51:37 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqi-001oGQ-1q
	for netdev@vger.kernel.org; Tue, 20 Feb 2024 09:51:36 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AE5F7292F2C
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:51:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3607E292EF2;
	Tue, 20 Feb 2024 08:51:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8dd11c88;
	Tue, 20 Feb 2024 08:51:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH net-next 9/9] can: raw: raw_getsockopt(): reduce scope of err
Date: Tue, 20 Feb 2024 09:46:11 +0100
Message-ID: <20240220085130.2936533-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220085130.2936533-1-mkl@pengutronix.de>
References: <20240220085130.2936533-1-mkl@pengutronix.de>
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

Reduce the scope of the variable "err" to the individual cases. This
is to avoid the mistake of setting "err" in the mistaken belief that
it will be evaluated later.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 897ffc17d850..00533f64d69d 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -756,7 +756,6 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	struct raw_sock *ro = raw_sk(sk);
 	int len;
 	void *val;
-	int err = 0;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
@@ -766,7 +765,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	switch (optname) {
-	case CAN_RAW_FILTER:
+	case CAN_RAW_FILTER: {
+		int err = 0;
+
 		lock_sock(sk);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
@@ -791,7 +792,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		if (!err)
 			err = put_user(len, optlen);
 		return err;
-
+	}
 	case CAN_RAW_ERR_FILTER:
 		if (len > sizeof(can_err_mask_t))
 			len = sizeof(can_err_mask_t);
@@ -822,7 +823,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		val = &ro->xl_frames;
 		break;
 
-	case CAN_RAW_XL_VCID_OPTS:
+	case CAN_RAW_XL_VCID_OPTS: {
+		int err = 0;
+
 		/* user space buffer to small for VCID opts? */
 		if (len < sizeof(ro->raw_vcid_opts)) {
 			/* return -ERANGE and needed space in optlen */
@@ -838,7 +841,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		if (!err)
 			err = put_user(len, optlen);
 		return err;
-
+	}
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
 			len = sizeof(int);
-- 
2.43.0



