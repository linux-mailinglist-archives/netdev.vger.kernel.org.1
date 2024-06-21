Return-Path: <netdev+bounces-105595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D99911E58
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDD6281F2A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C016F293;
	Fri, 21 Jun 2024 08:12:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680C83CDA
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957520; cv=none; b=WkyJAOGz7bOfTmQSD0lNsccHZUqSLC7KNsCuCMRtixLPmWpVZSm6HDbinh8zCBn7ErgVuaBHwgIhxQi7rmUtJ+AcNij6Kd9SOBzf7rC34pYbJbsKvYQB5b3/6YT8h4Pt7RROwbUoFNNXVOfeB4HSYkSNNgzdN7xTbcyvdcu/IS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957520; c=relaxed/simple;
	bh=2QkcoakKqp/S+E2J3u1v9B1we2NR/aylaUb3T18ORhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tgw2NzEEYicHKK3qGd1zPTrI1jxVU7yxPHFfn0I6LR4T+1Y5Mt7siSuiUAEUF/85Nitv13ghpfZKECQZMKk1jQz7yP+IS9RwLb+L4IxszRYIPB38f88LpyZk4POeHhHnmGI3AoEB+GmmONMjXm2QfFGscGMpzKQ+DReqU7yVFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZNF-0006gg-AH
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:11:57 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZNE-003ti7-Sb
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:11:56 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C0BED2EE41E
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2E3E72EE39A;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5c5cf4de;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Simon Horman <horms@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/24] can: mscan: remove unused struct 'mscan_state'
Date: Fri, 21 Jun 2024 09:48:28 +0200
Message-ID: <20240621080201.305471-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'mscan_state' is unused since the original
commit afa17a500a36 ("net/can: add driver for mscan family &
mpc52xx_mscan").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/all/20240525232509.191735-1-linux@treblig.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index a6829cdc0e81..8c2a7bc64d3d 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -34,12 +34,6 @@ static const struct can_bittiming_const mscan_bittiming_const = {
 	.brp_inc = 1,
 };
 
-struct mscan_state {
-	u8 mode;
-	u8 canrier;
-	u8 cantier;
-};
-
 static enum can_state state_map[] = {
 	CAN_STATE_ERROR_ACTIVE,
 	CAN_STATE_ERROR_WARNING,
-- 
2.43.0



