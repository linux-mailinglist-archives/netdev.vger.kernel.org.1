Return-Path: <netdev+bounces-95601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C498C2C75
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B916E2846F0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D164913D280;
	Fri, 10 May 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHuc2Ti4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28613D25A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378941; cv=none; b=fFFcpBGyCBobMt82tigcKFIfXCw2IRQkd++dRh+XzjN/z6B269OKE1pA09PYKJto4n90Kjq+PRlYmrveq1pMXEDz8nZZlAqqHXdadv5LTdHebScNGuElFHI754P8HCZwbRGJzHlN0tiqch3YccSQ5gh6LeZUIjfIKSBpmZNivA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378941; c=relaxed/simple;
	bh=6V6RqJXtAOVDpZCKczamPr5DHDi9TbnzlmxJ5b+iceQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3T10zcYzLE9FYXQNf0mK8r0y5O0kZfyb9hwqGi5n9Sqpa6eY5nXIk4gF40QPBPZNyMxrQoKHFuWAk55IdXPpibS/S7gx/7ds+FDivd4hP3efjgegIeVcjOboyFEbb+y52BW8Wd2xHawdTOCyPCr98ARwL6oY0G/lwGMq0hs+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GHuc2Ti4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so414101866b.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715378938; x=1715983738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkIbJ/qflXfSFw4UpiGmwq8QzkxZY+hDO2BaC+txcYw=;
        b=GHuc2Ti4KHLXWoGvhV6XoKPhz4wPjqrywL2HwkvhZLCYGJT4vGuUvvlC/U4um7d2xd
         ZNlhng/bY5BU7DclKMkbVthwEnl6kpzGoq60vu5S2jxjoGVO2/e7kKTmRDpoN/wi0jXG
         sLhkdsJI3p4ISlECKaY0fTGQSOqVbkIpOd5+dL9ucgzh1BG+fJcIC/BbNslUOgt1nGJc
         C2yRTqKl+1HhbEKAyhmrjSBnF8efZPHFH7r1SQpmAnpLfxL0LeppFVyvzIgugEuOtZ8P
         LtfCAd31eD0AaCEWHcLDGY6+b5Q9qsF546ozjbI/9Gj/syktZpE2OZ4rA3TLmh2OU9Q/
         UV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378938; x=1715983738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkIbJ/qflXfSFw4UpiGmwq8QzkxZY+hDO2BaC+txcYw=;
        b=an1fO/xXywAE/knaHkxzvBa3bXWY1gV/aFxZGNTD6AbOXiWMeo0Iedk/1VdMcuCQpR
         wQE1Hoj1LEr8+vmaLXHuoM8/n0JAU9XHXBKEnfPVjesxXBnPjiIlkZGxPoGIO7QGiLKE
         y5x41O8ZUpKGmWtIxPYPYrTKgEAmhUdhPaiJKOhdFfoaMNltLX2ahHdfyUKCJUTomeYF
         xAnwY53ThUapQfGKR9VbD9F5EuFVG/ACoZHzTcP/GILplslCxjAdstU0VJEV4EOUoOj4
         1G7ogg/XGyvvYmcAE3Fa7T0sU7EYpBACKrU2NaS12JLbVyRcaVBCWqr0vN56uPtjaUNx
         TLgw==
X-Gm-Message-State: AOJu0Yz8TuYoI6ye8ZLOqOS+qrnn3TPcFVjjmxnVBMKwZGBjo+Okk80g
	i2pofnjjpmEun3gQUc6dRuwOuYcF3bj/9CQRoPOzj5oF2D3YRFQdQ/tBLPrhFGD17X3DPZTSKRH
	2
X-Google-Smtp-Source: AGHT+IH2T0tARdewDiZtc81LFzwnvq3lzID7G8IfCzWaPDGXnmdgHxztlKAp0Ge1g+M/tFpn7YesdA==
X-Received: by 2002:a17:906:118b:b0:a59:9edf:14b6 with SMTP id a640c23a62f3a-a5a2d5f2606mr244149666b.45.1715378938361;
        Fri, 10 May 2024 15:08:58 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce3fsm228219866b.4.2024.05.10.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:08:57 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 11 May 2024 00:08:42 +0200
Subject: [PATCH net-next v2 4/5] net: ethernet: cortina: Use negotiated
 TX/RX pause
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240511-gemini-ethernet-fix-tso-v2-4-2ed841574624@linaro.org>
References: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
In-Reply-To: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

Instead of directly poking into registers of the PHY, use
the existing function to query phylib about this directly.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index e9b4946ec45f..d3134db032a2 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -293,8 +293,8 @@ static void gmac_adjust_link(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
 	union gmac_status status, old_status;
-	int pause_tx = 0;
-	int pause_rx = 0;
+	bool pause_tx = false;
+	bool pause_rx = false;
 
 	status.bits32 = readl(port->gmac_base + GMAC_STATUS);
 	old_status.bits32 = status.bits32;
@@ -328,19 +328,13 @@ static void gmac_adjust_link(struct net_device *netdev)
 			    phydev->speed, phydev_name(phydev));
 	}
 
-	if (phydev->duplex == DUPLEX_FULL) {
-		u16 lcladv = phy_read(phydev, MII_ADVERTISE);
-		u16 rmtadv = phy_read(phydev, MII_LPA);
-		u8 cap = mii_resolve_flowctrl_fdx(lcladv, rmtadv);
-
-		if (cap & FLOW_CTRL_RX)
-			pause_rx = 1;
-		if (cap & FLOW_CTRL_TX)
-			pause_tx = 1;
+	if (phydev->autoneg) {
+		phy_get_pause(phydev, &pause_tx, &pause_rx);
+		netdev_dbg(netdev, "set negotiated pause params pause TX = %s, pause RX = %s\n",
+			   pause_tx ? "ON" : "OFF", pause_rx ? "ON" : "OFF");
+		gmac_set_flow_control(netdev, pause_tx, pause_rx);
 	}
 
-	gmac_set_flow_control(netdev, pause_tx, pause_rx);
-
 	if (old_status.bits32 == status.bits32)
 		return;
 

-- 
2.45.0


