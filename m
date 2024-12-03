Return-Path: <netdev+bounces-148382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79F9E140C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0537283492
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4001E1C04;
	Tue,  3 Dec 2024 07:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE518FDAE
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210534; cv=none; b=i9myczjcsUKijnTZqCIyVIePnAtMaShGP67zwAu+HGR1OSs03ciySZQcttguoift4BrFjRjtOpmQ01B2+khanTn06uitcU3gqdysUV8PMdz3qo6ncRCpvetS5qxg4pjowHlf7VIvNf/tq1HoPzdm3JZulOYb7Ti+j2J83ih7na4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210534; c=relaxed/simple;
	bh=kCCfcs5qWKbWNrkYGX7ewBGKk+ZoMqqsF7UlhigcN4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwj15E8YKVofU5c1zB9mKod7zYlHLVB2Knk3NnbNb4Y7wyuy9msaIPj3aJqehK4dilQM2Bz52cC0cyXGOg09ojrDPTQOqyd7BKs77k8UxSKmpzBmtXLh37ZLsqiUGlk2ek1WZQirl2r5YYiay64S6IOFfw2Z4KR9nYkLt1+Qs6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEP-0004sH-MH; Tue, 03 Dec 2024 08:22:01 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001QzI-1N;
	Tue, 03 Dec 2024 08:21:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEK-00AEpd-00;
	Tue, 03 Dec 2024 08:21:56 +0100
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
Subject: [PATCH net-next v1 19/21] net: usb: lan78xx: Improve error handling in lan78xx_phy_wait_not_busy
Date: Tue,  3 Dec 2024 08:21:52 +0100
Message-Id: <20241203072154.2440034-20-o.rempel@pengutronix.de>
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

Update `lan78xx_phy_wait_not_busy` to forward errors from
`lan78xx_read_reg` instead of overwriting them with `-EIO`. Replace
`-EIO` with `-ETIMEDOUT` for timeout cases, providing more specific and
appropriate error codes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index fdeb95db529b..9852526be002 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -961,14 +961,14 @@ static int lan78xx_phy_wait_not_busy(struct lan78xx_net *dev)
 
 	do {
 		ret = lan78xx_read_reg(dev, MII_ACC, &val);
-		if (unlikely(ret < 0))
-			return -EIO;
+		if (ret < 0)
+			return ret;
 
 		if (!(val & MII_ACC_MII_BUSY_))
 			return 0;
 	} while (!time_after(jiffies, start_time + HZ));
 
-	return -EIO;
+	return -ETIMEDOUT;
 }
 
 static inline u32 mii_access(int id, int index, int read)
-- 
2.39.5


