Return-Path: <netdev+bounces-133296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B89957D8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D377D2894C6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F581213ECB;
	Tue,  8 Oct 2024 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MasVL4ZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A54F9C0;
	Tue,  8 Oct 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416869; cv=none; b=EcBsqKAuM2eMnApaWD7aBQTXuDaoNbOUen9AQtx1vVn9u9g2JMiKyuAPKj/R+GEfPM1OVJquLgmx9TDVIZbA8D0GqsPpO4SDkFecYBvLbXfOfcZVyiEoCDhJm3xeV/sXR9EQD6PpFU55OUCNVjn61KofMYGoyVMab3MS8PC/yR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416869; c=relaxed/simple;
	bh=qDJdjgvBxlmyVwz9YKp2AfHFXEDTQTI1gRsclBG6xzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFlZiOTHz0XtT3uHumNWg3jnJENaHAIp84Svg8Ez2bOOzdyAFl6H0s4LCAlCMIFpwrD3MVaIoGExraQNIbZ+EHjWf++G9MEZau8z2dGlvxUnH+fP0PTXI+TgeKmA7v0Tz+0XPEzYb7N5l+CFExxiKaBO1sRjCZal/jSmwxlHtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MasVL4ZT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so61318065e9.3;
        Tue, 08 Oct 2024 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728416866; x=1729021666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KX2jK4fDHxCD6QAvAd7J88cTq2gGBD9moCY5ZB/GroA=;
        b=MasVL4ZTk6OlUKYA4capu+rrY0fu7zlbnnkCD47ldo52WbwEu9BBgpTq3qhZR9Evcq
         A/HyyMBgfwGwOsnJ60Uo09dHeq8nbyj+SXaznmrqWDW7eSvrGBkOCIKmjItzttLkZUnC
         wipTL/N9QcN81kxoHLfMH5QqOYWHy2QpDRCeSCk3Nn7CYqeyO5MBKR3UqVMQrbLPC2SO
         iOwcSxgAJY6LTAtR3j6d8Hhn7d3M9fa5WhjSzXlhwI+nR8Ek3Lis/lzm/jDZMZSnJ41j
         XWiRkqjzPRKOj9TLzX8dor0XEpFCBFC+87td3hUlyVZIVNd1fHKPbMbWqFtlqu1Z4CUj
         /2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416866; x=1729021666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KX2jK4fDHxCD6QAvAd7J88cTq2gGBD9moCY5ZB/GroA=;
        b=Pus9muiIk/G2p3UBo4NyJZlr6RFoxXkDQ4L5+dVQAiedSMAv0oxjftSnYLuzE7WeUC
         sNs3epKR1jjfP/n7BVwvxkwkFN8zqaKmMkhlntXxE5md5lfhE0qn2CnLuOIRJ7J5YT4t
         /zGCvd4uoHK8pVwx71XurPHj5/vRBX0JRySWaGM2QmzxtuUbTL58rtvw3DrsY9ctMy5N
         VF4q3JzSJuddnpzHURtY2mdhHk1hw/DYpusb9n3blMplBQ5EAAQDiBAmO0k+w3q9q55Z
         a1FPJlOfG5K7wLFRAlJI181bzE/EJ/FSw7FTFJqRC3ZWIa9ioiZXVRGzNPmJyf3dcM6r
         egJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmLg1puJn2h2y+nppA8uaZ1UiXZg580acCtQpSNPJhwyEkK1x1j+AAbIN7XOzYdksl2prSkqCJ@vger.kernel.org, AJvYcCWT251p+171o+iiYWqy1B/zV69xuj2Txk/a1knGa4fl9D9Uqa/GQVlDTGMJ/YYYWpD8uz5q5WrSgRdpcuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRb/qzWcWRo8MqzVfsRQonA5tHkP9M3fhh8Xea6N+YN2ufgKo
	8Pr5q7h2vaxzUY/+1jyJL+Ipy31+SQFIlrw4silrLnWe0Dsi64oZ
X-Google-Smtp-Source: AGHT+IGIsLcDHZALgGF/PKsHz7uZEcdiCBkMKGPXJ7q00CgMg+2wXt6A/f0f7BKVJa/a8GOd5fJIOg==
X-Received: by 2002:a05:600c:350c:b0:42c:ac9f:b505 with SMTP id 5b1f17b1804b1-42f85af0486mr135152845e9.31.1728416865485;
        Tue, 08 Oct 2024 12:47:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86a20595sm136526145e9.14.2024.10.08.12.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 12:47:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3] net: phy: Validate PHY LED OPs presence before registering
Date: Tue,  8 Oct 2024 21:47:16 +0200
Message-ID: <20241008194718.9682-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate PHY LED OPs presence before registering and parsing them.
Defining LED nodes for a PHY driver that actually doesn't supports them
is redundant and useless.

It's also the case with Generic PHY driver used and a DT having LEDs
node for the specific PHY.

Skip it and report the error with debug print enabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Make condition more readable
Changes v2:
- Use phydev_dbg instead of warn

 drivers/net/phy/phy_device.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 499797646580..e4a1d0e74e47 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3421,6 +3421,16 @@ static int of_phy_leds(struct phy_device *phydev)
 	if (!leds)
 		return 0;
 
+	/* Check if the PHY driver have at least an OP to
+	 * set the LEDs.
+	 */
+	if (!(phydev->drv->led_brightness_set ||
+	      phydev->drv->led_blink_set ||
+	      phydev->drv->led_hw_control_set)) {
+		phydev_dbg(phydev, "ignoring leds node defined with no PHY driver support\n");
+		goto exit;
+	}
+
 	for_each_available_child_of_node_scoped(leds, led) {
 		err = of_phy_led(phydev, led);
 		if (err) {
@@ -3430,6 +3440,7 @@ static int of_phy_leds(struct phy_device *phydev)
 		}
 	}
 
+exit:
 	of_node_put(leds);
 	return 0;
 }
-- 
2.45.2


