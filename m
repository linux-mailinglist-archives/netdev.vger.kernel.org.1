Return-Path: <netdev+bounces-148902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E359E360F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57291B339E3
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B8D1B0F29;
	Wed,  4 Dec 2024 08:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4491A0AF0
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301718; cv=none; b=WkPrvMnkStrfucw9tvB1vAKSeKrmEVmWAxeYVS0lxkIXABwOCz/O4uhivNRESVAk1KBT9hAUpW03fK86le+vfGpu1XCMwjX4YDOn5X/3dILDyAB1KcknwkZevBPlWoQjL9oS6Fp7DQk4+vo1Q6LJdl5uwIpbxDt0KHamPhVcuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301718; c=relaxed/simple;
	bh=UEl1kyBkpizvYBJw45/v9VHKzd/iejRUMEZu2eIrCa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQkyoy7Lo2Wl7GCOfvC8S1cNlmztFyA9pR300Pc2Ho5JS0TTAvvNyN/Mc2hBO5d+vgR77XOvtEve1/ISi+o3n4c3Sz10zwrU0hdUG5qTXWX0AXEeNNIZoJq4sr/xqaX8qAvgXba/6Cuq9X1JjxY96iDvKxHnfreofTeGe82HyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkxB-0001I9-Ct; Wed, 04 Dec 2024 09:41:49 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-001cUO-14;
	Wed, 04 Dec 2024 09:41:44 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-004pu0-3A;
	Wed, 04 Dec 2024 09:41:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 09/10] net: usb: lan78xx: Add error handling to lan78xx_irq_bus_sync_unlock
Date: Wed,  4 Dec 2024 09:41:41 +0100
Message-Id: <20241204084142.1152696-10-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204084142.1152696-1-o.rempel@pengutronix.de>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


