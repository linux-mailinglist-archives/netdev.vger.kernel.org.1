Return-Path: <netdev+bounces-152182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546609F3021
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D21641D2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB43204C1E;
	Mon, 16 Dec 2024 12:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14ED2046B2
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350997; cv=none; b=UpHzGrpokrMUPnLUMoKBSivPVJvh7AfuyribbM5aZWSricVCyydk30ETfK7zlrV8IUsI5ao9OjZQhMwPwZhPetEhyHr1WeXnKqinVXK1mhkoRyEYk+FZXE7ZLCCV++6f/GzXJpofANSctmd04EpUGAnoJ72bOWb3BlIn2z9ohFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350997; c=relaxed/simple;
	bh=smjRVQ6loD7RNSPz3LagPvSvg5qkvEYEgfWW6vwiwRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBG7ondsDVgZ9NWA713QF62dy8xMnJjKEg2a4vAn5iyxkUjwFF0e7dzRrkwkqKgkg87JptSu5oDRrC2IxKgNaLqLYSI9QyjxOC0uFSp/6G4SDKSXLiQn0+b8Qc/eJFKqWomJqcEYYifjwytc5pk2ecvrbVbHRuPOJlVVKAdAszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9v1-0001C3-9K; Mon, 16 Dec 2024 13:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9uw-003h1i-2C;
	Mon, 16 Dec 2024 13:09:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9ux-0075tp-1E;
	Mon, 16 Dec 2024 13:09:43 +0100
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
Subject: [PATCH net-next v1 2/6] net: usb: lan78xx: Use ETIMEDOUT instead of ETIME in lan78xx_stop_hw
Date: Mon, 16 Dec 2024 13:09:37 +0100
Message-Id: <20241216120941.1690908-3-o.rempel@pengutronix.de>
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

Update lan78xx_stop_hw to return -ETIMEDOUT instead of -ETIME when
a timeout occurs. While -ETIME indicates a general timer expiration,
-ETIMEDOUT is more commonly used for signaling operation timeouts and
provides better consistency with standard error handling in the driver.

The -ETIME checks in tx_complete() and rx_complete() are unrelated to
this error handling change. In these functions, the error values are derived
from urb->status, which reflects USB transfer errors. The error value from
lan78xx_stop_hw will be exposed in the following cases:
- usb_driver::suspend
- net_device_ops::ndo_stop (potentially, though currently the return value
  is not used).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 270345fcad65..4674051f5c9c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -844,9 +844,7 @@ static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
 		} while (!stopped && !time_after(jiffies, timeout));
 	}
 
-	ret = stopped ? 0 : -ETIME;
-
-	return ret;
+	return stopped ? 0 : -ETIMEDOUT;
 }
 
 static int lan78xx_flush_fifo(struct lan78xx_net *dev, u32 reg, u32 fifo_flush)
-- 
2.39.5


