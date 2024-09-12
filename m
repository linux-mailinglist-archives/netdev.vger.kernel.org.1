Return-Path: <netdev+bounces-127730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB49763FD
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7224B210E6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B335193426;
	Thu, 12 Sep 2024 08:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE619047C
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128380; cv=none; b=LgpF5oHNRBscbycdX3/Sxl6+y5Qml9mX6BaiTTHKxdoQEb72ZKChmp1WYxTmaKxhVarLu7wOdGBanJGOnh/syVYjz343UQCkVi3ouVBOH1QjK+OJ4+BQf0djybhqapPcLgzqrzWnVeJwUbYsm4RB7ZyNqAqgqGXAnWB8uDSsE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128380; c=relaxed/simple;
	bh=otFIWLqktcMRkW0qlzRO/Z8xAmrLJ5pDjonmVsFAiDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWT67JEby+Fp+tNjCMcsd2zw7cJmYKfDY2RamdXZ+gQGiul2mkMlUYUano6D6v+VtZAZYCNYa4UOD7+je6QAtYoV0IOqAElsUXMbDWslSZwrZGePgUSfdeeqgaNqXMhF0+6F0YT51m9dHaTSYiIrKjii4EGuJ5z2wEV2dmICLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeqA-00049y-AT
	for netdev@vger.kernel.org; Thu, 12 Sep 2024 10:06:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq7-007KhI-DR
	for netdev@vger.kernel.org; Thu, 12 Sep 2024 10:06:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8A41E338EE3
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:04:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D7E44338EA1;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fe5c2388;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jake Hamby <Jake.Hamby@Teledyne.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 3/5] can: m_can: m_can_chip_config(): mask timestamp wraparound IRQ
Date: Thu, 12 Sep 2024 09:59:00 +0200
Message-ID: <20240912080438.2826895-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912080438.2826895-1-mkl@pengutronix.de>
References: <20240912080438.2826895-1-mkl@pengutronix.de>
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

From: Jake Hamby <Jake.Hamby@Teledyne.com>

On the Microchip SAMA7G54 MPU the IR_TSW (timestamp wraparound) fires
at about 1 Hz, but the driver doesn't care about it. Add it to the
list of interrupts to disable in m_can_chip_config to reduce unneeded
wakeups.

Link: https://patch.msgid.link/DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com
Signed-off-by: Jake Hamby <Jake.Hamby@Teledyne.com>
Link: https://patch.msgid.link/20240911-can-m_can-mask-timestamp-wraparound-irq-v1-1-0155b70dc827@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 012c3d22b01d..a7b3bc439ae5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1434,7 +1434,8 @@ static int m_can_chip_config(struct net_device *dev)
 
 	/* Disable unused interrupts */
 	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
-			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
+			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F |
+			IR_TSW);
 
 	err = m_can_config_enable(cdev);
 	if (err)
-- 
2.45.2



