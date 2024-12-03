Return-Path: <netdev+bounces-148379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF609E1409
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5669B165743
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC21E0DE9;
	Tue,  3 Dec 2024 07:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36C190497
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210533; cv=none; b=tjKj+ZT5MVsRN6lNxHxM8eVKglW0AgIJfwKB9zGrw/zxtTXwi3J6Sgjg7IrhFJIIfNaNzDRTU6Im3FvfNlH9m2qXhs9UCRlSr/ZGRUgZskFPUZmANV/FTYzYONqaf1diz++ZQmemo+TPCNP99pJe0Ak3tM65HTZU91EHWrpOoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210533; c=relaxed/simple;
	bh=84clEU0P/5CbvPrnaLag9WOQh/98lXhngHyQ/rKGNEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ixdz04GDO+3ohmmIf47fu+aGYy3fr5qZzpeyRJWHy9TOdHcROgvajjMq3NcBrqIgUrI0S8e7xC6q6sB18wk859QCQjdTKk8GleSEDIDhlh6QZ9uOPq4gMkATK+7zlOLIOWA+Wt92lH1iJ6DWztuWGsIT2H95p9H5od4GpPyckV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEP-0004s8-Gp; Tue, 03 Dec 2024 08:22:01 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001Qz4-0o;
	Tue, 03 Dec 2024 08:21:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEoH-2n;
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
Subject: [PATCH net-next v1 11/21] net: usb: lan78xx: Add error handling to lan78xx_setup_irq_domain
Date: Tue,  3 Dec 2024 08:21:44 +0100
Message-Id: <20241203072154.2440034-12-o.rempel@pengutronix.de>
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

Update `lan78xx_setup_irq_domain` to handle errors in
`lan78xx_read_reg`.  Return the error code immediately if the read
operation fails, ensuring proper error propagation during IRQ domain
setup.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d5f6367d3714..070b21baffaf 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2445,7 +2445,10 @@ static int lan78xx_setup_irq_domain(struct lan78xx_net *dev)
 
 	mutex_init(&dev->domain_data.irq_lock);
 
-	lan78xx_read_reg(dev, INT_EP_CTL, &buf);
+	ret = lan78xx_read_reg(dev, INT_EP_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	dev->domain_data.irqenable = buf;
 
 	dev->domain_data.irqchip = &lan78xx_irqchip;
-- 
2.39.5


