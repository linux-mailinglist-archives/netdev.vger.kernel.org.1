Return-Path: <netdev+bounces-148381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701669E1407
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3553C28171F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA21E0E12;
	Tue,  3 Dec 2024 07:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E31DEFC0
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210534; cv=none; b=iNTett2xDxSlAqg0j6evsIGSxaNwVvnMzjH8jDaH3A4exhSNwI86XGUXWI+4mb6aQ0kc3B9+kdN6/z+fSxKyIusyfoxe/EvS7Ev9GF4KDFLwwWzzx17/oxHR43dc66vVKkVZdnzywKFoRoM6E/6/mQQ0g+xqLcrHU0E3+YzfeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210534; c=relaxed/simple;
	bh=R4/0zDSvXQ7j2t6w8Tqa4xvfeIvEbrVq6ZRm2VJWwpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iidl4dhVqMI9jv/mYZLpBUVEY0Civ/zUP4OeNyZWXP36VOK+VzeyLi/voLdFz0qLBKaRC7MGJcdPEt2LDKIopgWblJnWNfFKEuVf0lpdZTP4erk4ev+yNQk7/1QxFYONKUfmX9I+hNt2DWWHEVBdqU1NTS/yd0Pr9zvEaTAVXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEP-0004sE-MC; Tue, 03 Dec 2024 08:22:01 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001QzH-1K;
	Tue, 03 Dec 2024 08:21:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEpS-3B;
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
Subject: [PATCH net-next v1 18/21] net: usb: lan78xx: Use function-specific label in lan78xx_mac_reset
Date: Tue,  3 Dec 2024 08:21:51 +0100
Message-Id: <20241203072154.2440034-19-o.rempel@pengutronix.de>
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

Rename the generic `done` label to the function-specific
`mac_reset_done` label in `lan78xx_mac_reset`. This improves clarity and
aligns with best practices for error handling and cleanup labels.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c66e404f51ac..fdeb95db529b 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1604,16 +1604,16 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	 */
 	ret = lan78xx_phy_wait_not_busy(dev);
 	if (ret < 0)
-		goto done;
+		goto mac_reset_done;
 
 	ret = lan78xx_read_reg(dev, MAC_CR, &val);
 	if (ret < 0)
-		goto done;
+		goto mac_reset_done;
 
 	val |= MAC_CR_RST_;
 	ret = lan78xx_write_reg(dev, MAC_CR, val);
 	if (ret < 0)
-		goto done;
+		goto mac_reset_done;
 
 	/* Wait for the reset to complete before allowing any further
 	 * MAC register accesses otherwise the MAC may lock up.
@@ -1621,16 +1621,16 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	do {
 		ret = lan78xx_read_reg(dev, MAC_CR, &val);
 		if (ret < 0)
-			goto done;
+			goto mac_reset_done;
 
 		if (!(val & MAC_CR_RST_)) {
 			ret = 0;
-			goto done;
+			goto mac_reset_done;
 		}
 	} while (!time_after(jiffies, start_time + HZ));
 
 	ret = -ETIMEDOUT;
-done:
+mac_reset_done:
 	mutex_unlock(&dev->phy_mutex);
 
 	return ret;
-- 
2.39.5


