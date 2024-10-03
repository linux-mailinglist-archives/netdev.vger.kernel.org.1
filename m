Return-Path: <netdev+bounces-131798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C898F9AC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21BFB21749
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D81C9EBE;
	Thu,  3 Oct 2024 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1RmiHvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59B1AB6FA;
	Thu,  3 Oct 2024 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993612; cv=none; b=CDaST0Dxev/2FMvAvIPKWpFQq8jyY0newR3PHdQarJI1a28MgL6gvED/0xICnGN3g21Y55M8GhUQx+WUuO8GzkT1bFoZvZ4AZNQ4u/krc0SevUw91l/eOQAYbqVOxE92RLJIqkYTha9TsSty6xN60duwL3AVDfyHCVw7R4v2tpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993612; c=relaxed/simple;
	bh=Ybx7UlCkDy6Xb7CLxdH8pHv4SLszmuIGTqHEPzKKsUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbdXl1yKgYyMSXLSxNknJ9GyUfk/24M7PpVIcauKEfgVBYZrC9Xi1+i93SiPN2o4ApycNbrDzTaDusMU0JVPV249V0a4PuQVG3WIInlGJlcyv7ZUPkvd5fwzuQKpH6rzU+z8hyH9LnhGJbRQ7ChDnaa/ie48XeJvj/wRKF/dAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1RmiHvq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so11849005e9.1;
        Thu, 03 Oct 2024 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993609; x=1728598409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gjNaonYclvC+eXWWuLusLr6M8V9VR0a8u100joB2gk=;
        b=i1RmiHvqbH3ZJjEowaW2cEst9QqDn3VqBy+hoDG4SoXJEc3VQwJAGAdrkLzDBn8f9V
         gMHfutLoU9HuUl/zkvlNe1xQH0bN1ITRVSwGol5yZOk1bfhel7lDcSpunlvtIjmiY+gC
         4km++hwX8ibthqPw+Y3amodC+OUzoEh2J6Spk4VFYTRPeWL0HBfn8ux4TLWpwoSzfwcp
         cQYcJLXfo7KO0nKApNOds3SYq32qSPGYSV3WjowOsOKTuabaNwhvIJdW1iUBHtL45LMR
         JpXafrhYID0zwSS6d3DTeTvtBx1YNHt0TLWRhFqwLRc+5p3AuBgw1lF7AEZvTRCDt1Uy
         rPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993609; x=1728598409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gjNaonYclvC+eXWWuLusLr6M8V9VR0a8u100joB2gk=;
        b=WefTmcU2hHeRvMUiQfPhe7RsH3ARmY+B9Y50caQz3Ry6+5H41ndBevlwkzCvF58M9H
         ew9Y6BcJlizp1eDN9W45m4IA4GramtRiU4RMImle9bxOy6B8M22WaUXJ0mC30Cm1okNr
         t2XfEtmXnXZOXSgmSycW6/cV5ye+NQte2C1VFo5fDZVFh5pOqHT+BrbGOfHL823WgkRU
         jbIf4sHYK0KT4qFkz6wL0HYPVtJdIfC+1bxEK/1kXPwcKbxHZ2dU1jU/d1HbMZl5W0p7
         zHwbyiuhSwwHzn4yTbziwW4sbW/ycoMMSTGQSA2bElhZGC7O8Iajkg8ml2zAB3cRQHtR
         TnPw==
X-Forwarded-Encrypted: i=1; AJvYcCVBeiu2C5BLLwYNafsVjbhsPz8xCMnW5cBnuoC2l/cAKKEHeDKpwcefGmBZJTU56tAp8AlDYk7t21kGZM0=@vger.kernel.org, AJvYcCXC9CNFwfgnl3DxA8TbVgY74QV7A1tzg1yMzgeCO4n8pSV3Yz4Y4q/KekdDfG2g2Yw3LQLdTmPX@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBJkzHNegX4/9lTb+KQX0CLS3HuPSBnlF4K0MCcf9baNCA69a
	9aerq+WdpjLfzmlPJMnrVJ6WbUSgvejKhi81Wpb0oDNYgvlDjZCU
X-Google-Smtp-Source: AGHT+IG4FdRCltDIxfEH1NmF7gWJsow6JMoXGJ6BlR3H6AE6RErB6Kq+oaHGjkcE4P9kUlP89BnCaQ==
X-Received: by 2002:adf:f209:0:b0:37c:ddab:a625 with SMTP id ffacd0b85a97d-37d0e74d5aamr446438f8f.25.1727993609181;
        Thu, 03 Oct 2024 15:13:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d0822b571sm2088249f8f.40.2024.10.03.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:13:27 -0700 (PDT)
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
Subject: [net-next PATCH] net: phy: Validate PHY LED OPs presence before registering
Date: Fri,  4 Oct 2024 00:12:48 +0200
Message-ID: <20241003221250.5502-1-ansuelsmth@gmail.com>
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
is wrong and should be reported.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index af088bf00bae..ce154a54bfa4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3426,6 +3426,16 @@ static int of_phy_leds(struct phy_device *phydev)
 	if (!leds)
 		return 0;
 
+	/* Check if the PHY driver have at least an OP to
+	 * set the LEDs.
+	 */
+	if (!phydev->drv->led_brightness_set &&
+	    !phydev->drv->led_blink_set &&
+	    !phydev->drv->led_hw_control_set) {
+		phydev_err(phydev, "ignoring leds node defined with no PHY driver support\n");
+		goto exit;
+	}
+
 	for_each_available_child_of_node_scoped(leds, led) {
 		err = of_phy_led(phydev, led);
 		if (err) {
@@ -3435,6 +3445,7 @@ static int of_phy_leds(struct phy_device *phydev)
 		}
 	}
 
+exit:
 	of_node_put(leds);
 	return 0;
 }
-- 
2.45.2


