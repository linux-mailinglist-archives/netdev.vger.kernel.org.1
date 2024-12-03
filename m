Return-Path: <netdev+bounces-148365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677739E13F7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF91B23C74
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671DE1DF27E;
	Tue,  3 Dec 2024 07:22:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B001D9A79
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210529; cv=none; b=MFUyz5lAXT0LJKqjZBaWSnRLc4svq8B++vCBiMR+Kl8TUiISXUl/Bjb4Z/qOnx2CffPB4FhIz2Kqk3wN91h7s5rg+24FO8fHZEVAWG9jLiaiTToQaUjFD/OPDVNT0ts2FOtR3VU9jLmaoBaCMk0+JdWh1ocQNyUrxM2BDPmw/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210529; c=relaxed/simple;
	bh=RzEPvgcUSo8p8Q3eyoUfZA7qfP1T4vfeUOzesxnjCbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCsZlpi40AW26+6nSr/zHM3EOMHcRG0YAom5gL9xzJrRQk4fr6dAFmZlHhT7ENGys3fj/FSIWjNkIAvLTx2pQ6ly6KT64hVj6YoYrtqk6CkBcZvIHultWgWjnzhWTHmjc8qzNEMu1qeMY4ei3++l4TB8KHxk0zDOa9aKKQOJpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004s1-6F; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001Qyo-08;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEn4-2O;
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
Subject: [PATCH net-next v1 04/21] net: usb: lan78xx: Improve error reporting with %pe specifier
Date: Tue,  3 Dec 2024 08:21:37 +0100
Message-Id: <20241203072154.2440034-5-o.rempel@pengutronix.de>
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

Replace integer error codes with the `%pe` format specifier in register
read and write error messages. This change provides human-readable error
strings, making logs more informative and debugging easier.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index dd9b5d3abcb3..94320deaaeea 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -621,8 +621,8 @@ static int lan78xx_read_reg(struct lan78xx_net *dev, u32 index, u32 *data)
 		*data = *buf;
 	} else if (net_ratelimit()) {
 		netdev_warn(dev->net,
-			    "Failed to read register index 0x%08x. ret = %d",
-			    index, ret);
+			    "Failed to read register index 0x%08x. ret = %pe",
+			    index, ERR_PTR(ret));
 	}
 
 	kfree(buf);
@@ -652,8 +652,8 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
 	if (unlikely(ret < 0) &&
 	    net_ratelimit()) {
 		netdev_warn(dev->net,
-			    "Failed to write register index 0x%08x. ret = %d",
-			    index, ret);
+			    "Failed to write register index 0x%08x. ret = %pe",
+			    index, ERR_PTR(ret));
 	}
 
 	kfree(buf);
-- 
2.39.5


