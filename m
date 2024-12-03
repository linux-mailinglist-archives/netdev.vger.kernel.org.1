Return-Path: <netdev+bounces-148378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E7D9E1404
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE2C28329C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F37A1E0DE1;
	Tue,  3 Dec 2024 07:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666A1DF73D
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210533; cv=none; b=qscMcVl6ozAlR/2M18My+2whrwsfcnsrhn14KM4ueAPPZeVR1Ckike0ifppkaCmGXeJsfQVt2E9+PJOwMJdXb+pQFyTE8FEwLOGmHIOX4wgcdfnDFQmxsBpo7+0AuOnouKzPY27zJbQeZk8srspkcfZB4rxqS+wfGw6JD5/Yqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210533; c=relaxed/simple;
	bh=XEwcvbODC+8N8ljyjNk7DdHoQZtBLYnZdZl96XbXSlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1gvJ8DnKYuaM4BKr0WDmXAomlCsQb113Lui0zZq9rkQ0GLegSwf3YTiHOCFHHrX6cy+ln91rG+fcwJmncIJMDMfhaZdVVfgL57aBk7nOIjBt97WnwUVrASJjA9iIWffO3C1EsTYzFvjjoO8w8ikQ8yAv9IkopbOJuV04oyQcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEP-0004s5-Go; Tue, 03 Dec 2024 08:22:01 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001Qz1-0c;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEnv-2g;
	Tue, 03 Dec 2024 08:21:55 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 09/21] net: usb: lan78xx: Add error handling to lan78xx_irq_bus_sync_unlock
Date: Tue,  3 Dec 2024 08:21:42 +0100
Message-Id: <20241203072154.2440034-10-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Update `lan78xx_irq_bus_sync_unlock` to handle errors in register
read/write operations. If an error occurs, log it and exit the function
appropriately.  This ensures proper handling of failures during IRQ
synchronization.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 2d16c1fc850e..2ae9565b5044 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2382,13 +2382,22 @@ static void lan78xx_irq_bus_sync_unlock(struct irq_data *irqd)
 	struct lan78xx_net *dev =
 			container_of(data, struct lan78xx_net, domain_data);
 	u32 buf;
+	int ret;
 
 	/* call register access here because irq_bus_lock & irq_bus_sync_unlock
 	 * are only two callbacks executed in non-atomic contex.
 	 */
-	lan78xx_read_reg(dev, INT_EP_CTL, &buf);
+	ret = lan78xx_read_reg(dev, INT_EP_CTL, &buf);
+	if (ret < 0)
+		goto irq_bus_sync_unlock;
+
 	if (buf != data->irqenable)
-		lan78xx_write_reg(dev, INT_EP_CTL, data->irqenable);
+		ret = lan78xx_write_reg(dev, INT_EP_CTL, data->irqenable);
+
+irq_bus_sync_unlock:
+	if (ret < 0)
+		netdev_err(dev->net, "Failed to sync IRQ enable register: %pe\n",
+			   ERR_PTR(ret));
 
 	mutex_unlock(&data->irq_lock);
 }
-- 
2.39.5


