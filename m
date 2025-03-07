Return-Path: <netdev+bounces-172853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC7A564B8
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC445188B73C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4D320DD7E;
	Fri,  7 Mar 2025 10:12:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387A20C481
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342365; cv=none; b=exkLDUX9BuDJMGARN/7wdk+Tv70kNqfGa2rUxn8YPHNltQix1eBLurJmDEbTXCJ0o7PMFPS2c3FNCg3KfgQ/LqKtGug0msDi7bfIAmWa9mVoXsLZvh/sf1CmN4jvp9gQKBBYz+DtCfwCOxGh+seBKFkBWPBcELFwobq3vkj+clE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342365; c=relaxed/simple;
	bh=Zd3MLH3vLqS9AEaOhI1WkF8aKP2oVC9sXSgSMRYDf2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXCEwNH1du1jHWeiMdyZgL0BYdwJPR+wKwheJ9+b90v6fAyZoUSogMyEESUkzxjTtt7cF7pDRiLt+5GFddDP+0cRS1ouZc4wNsfwP+YspZ9HQLMx5eiqDYq4TKs0YLSbLr2vklpusbToOqCQb5Mf4jtNW2TwL0a72zP+QhUaW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tqUgt-00083y-Mm; Fri, 07 Mar 2025 11:12:27 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqUgs-004T8Y-0a;
	Fri, 07 Mar 2025 11:12:26 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqUgs-00Ch7A-0L;
	Fri, 07 Mar 2025 11:12:26 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net v1 1/1] net: usb: lan78xx: Sanitize return values of register read/write functions
Date: Fri,  7 Mar 2025 11:12:23 +0100
Message-Id: <20250307101223.3025632-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

usb_control_msg() returns the number of transferred bytes or a negative
error code. The current implementation propagates the transferred byte
count, which is unintended. This affects code paths that assume a
boolean success/failure check, such as the EEPROM detection logic.

Fix this by ensuring lan78xx_read_reg() and lan78xx_write_reg() return
only 0 on success and preserve negative error codes.

This approach is consistent with existing usage, as the transferred byte
count is not explicitly checked elsewhere.

Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/ac965de8-f320-430f-80f6-b16f4e1ba06d@sirena.org.uk
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a91bf9c7e31d..137adf6d5b08 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -627,7 +627,7 @@ static int lan78xx_read_reg(struct lan78xx_net *dev, u32 index, u32 *data)
 
 	kfree(buf);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
@@ -658,7 +658,7 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
 
 	kfree(buf);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int lan78xx_update_reg(struct lan78xx_net *dev, u32 reg, u32 mask,
-- 
2.39.5


