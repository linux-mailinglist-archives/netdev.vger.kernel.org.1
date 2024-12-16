Return-Path: <netdev+bounces-152186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2B39F3027
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38617A2611
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510E20550E;
	Mon, 16 Dec 2024 12:09:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A3204C00
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350998; cv=none; b=KtF/9Xf+835lQRHlL7qzKF5La4AAt29+BWQNdKpNeFU6+45Ld+WW7lBl72QO4Ak1YPtqiY4wwPQk84nnTcFnJiC6f90ruR0C8nuwsN7YPTYiCcX/dCNdliR3l/L89wgjKutRKKtc++UfuAUttThzg5SNlOXTvigGJIa9a/wuKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350998; c=relaxed/simple;
	bh=pfsl2TBxq6ncI2CnbTDx6yfSrPUgIlfFqf6zE4SHubU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcXjugmDpDggIJbhFVVm6cFAnTz5StEqFoYqSH8+PLs6YSr/50zvgjsne4b0/qKu3K3qczFoP8ZVMxCwFtDKzF4V+BoINdaDSP6FoflspGYpS5SKv/CU7ypd1GGWLfbRRcbtX8NGpiVVl5Jt7D+Kx5iBHne2IMBUbk9rcmjRaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9v1-0001C4-9F; Mon, 16 Dec 2024 13:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9uw-003h1j-2G;
	Mon, 16 Dec 2024 13:09:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9ux-0075u0-1H;
	Mon, 16 Dec 2024 13:09:43 +0100
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
Subject: [PATCH net-next v1 3/6] net: usb: lan78xx: Use action-specific label in lan78xx_mac_reset
Date: Mon, 16 Dec 2024 13:09:38 +0100
Message-Id: <20241216120941.1690908-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216120941.1690908-1-o.rempel@pengutronix.de>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
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

Rename the generic `done` label to the action-specific `exit_unlock`
label in `lan78xx_mac_reset`. This improves clarity by indicating the
specific cleanup action (mutex unlock) and aligns with best practices
for error handling and cleanup labels.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/lan78xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 4674051f5c9c..30301af29ab2 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1604,16 +1604,16 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	 */
 	ret = lan78xx_mdiobus_wait_not_busy(dev);
 	if (ret < 0)
-		goto done;
+		goto exit_unlock;
 
 	ret = lan78xx_read_reg(dev, MAC_CR, &val);
 	if (ret < 0)
-		goto done;
+		goto exit_unlock;
 
 	val |= MAC_CR_RST_;
 	ret = lan78xx_write_reg(dev, MAC_CR, val);
 	if (ret < 0)
-		goto done;
+		goto exit_unlock;
 
 	/* Wait for the reset to complete before allowing any further
 	 * MAC register accesses otherwise the MAC may lock up.
@@ -1621,16 +1621,16 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	do {
 		ret = lan78xx_read_reg(dev, MAC_CR, &val);
 		if (ret < 0)
-			goto done;
+			goto exit_unlock;
 
 		if (!(val & MAC_CR_RST_)) {
 			ret = 0;
-			goto done;
+			goto exit_unlock;
 		}
 	} while (!time_after(jiffies, start_time + HZ));
 
 	ret = -ETIMEDOUT;
-done:
+exit_unlock:
 	mutex_unlock(&dev->phy_mutex);
 
 	return ret;
-- 
2.39.5


