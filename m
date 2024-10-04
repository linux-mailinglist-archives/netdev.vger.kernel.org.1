Return-Path: <netdev+bounces-132197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA761990F2C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F0F281318
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D17B1E0DDD;
	Fri,  4 Oct 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYuVnOB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A4231C91;
	Fri,  4 Oct 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066832; cv=none; b=h/c2tEs0dNa3Tyz6YcW4KAq4gHsqGXhJwK1Le1zjf6BtLBYPCerQ9JSKjZkdkizrUMJoK5DOhVKgYIF4E6NFpSMSfOUezPAduuFTC4y4kOM1T0kCdUX4TNoa7XctRg707AkhHMmDL1m9LrM4GWL6hsAWs4ExFjn2AG0JID6KNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066832; c=relaxed/simple;
	bh=ZJojrD0MiFBc82T9ho+Qu0OfFoyqUGxJb3o88qAdpRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNm1RCnIZcXsJuDSOq0i3gQyfD0JVC+dQlFTnxKNgQYa5+7Joj2Q7D8wmLoW4gHfRAkMaI2OPfIiGWBUtUQVLiY1keY5h9GYT5FaAjjT4N1L1FL2JZgDZAPg4EkuAj2wPS1YpDzNhTpY9yYqtL/9Grl14WM7lHRzC9tKn4bsGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYuVnOB5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so24074195e9.0;
        Fri, 04 Oct 2024 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728066829; x=1728671629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+eivA74IJ09ih5Gd9yZF2KHb3khSrTcjkEBWfJwMu0=;
        b=VYuVnOB5t8O9m316b3fWSmUbnzBbfwhDW6QJ8fnclzTlmOBpbzaPLCrPW/FbFq93yX
         4YdMLeGp3ZJ32fXwWWP5bHJBZ2SIbwezim/549sBteNwM7T74QzT4vaLDqsZ38bUE5Vp
         WAO0tpLBORHk4pZ8J0R1PVnyZSFlpfOBFVL4PZ0nYbDEUgd9PafCJk1updc4cRUKD1DR
         lpWynTK9TWBpCR4VXEEAEvumolZ7wuhBf8+p/U+RcLA4srrJBVlYaWTW4yq+A0WNjQZA
         fPhzLKR5l6ORtALCbTeyYXgO5fxNXsceeZLzdjqVxh1whTjxSv4zNNSfcLKr1CUhL9mJ
         O+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728066829; x=1728671629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+eivA74IJ09ih5Gd9yZF2KHb3khSrTcjkEBWfJwMu0=;
        b=cz7ctoI/Lpd6N1lNiUwQ+tPfxdLdLHmmFrgqDz+BFY8F6/+IvCoVPERxTD9/eOg5Nm
         XxV9yy1VwE77vFjf/h+syMD/yuNCY8oTHCZWrVm/Xkz1uFz0k6mdiQ2+iK0a7K4ooE+8
         wYBaVCnSXATo5dmKL7yi4BLXB96KOMigziPL23je2gHTzQkJ62UwAz+mK9fh0TCx3QXn
         NgtdBBgshUHHFCgZRwpgxnQj5H3cYr0pwGRTB/p1kfoygRiLGByS+W7Nu7qHCXQIOo7T
         BPb/JSPFZequQklhbrGvoseVWC0JvptCRIr8rZh2OT+1rInhs0V+Owkb/pAb9O4SfCNu
         qdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5oRa1wLathEIGUPNRLm2jEM9o8K268YGNDl2GFNDZYiXPnDa2aFUaxKZxLV90WpwLj3Xk5MbtH5dV8Qc=@vger.kernel.org, AJvYcCXQLkgqgBI2kfOOYuksLrOg5fKtjL8nbUj0D9s9czIW3HaQ3pa/MasBKvzP+KXMQx89XFQicRyu@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0GC7Gzn1D+IdM4S0ePUKbjxU+I1wmZdc9GdQtqUQKqwDG/vw
	fRO4k1Jq52ivGB6Tb5+X5Ycb6HscjTs385Tb4JSBWVdPSg/9y+Co
X-Google-Smtp-Source: AGHT+IFDmFVFFxe2MyfGZo8gTm8mEKtZk46BdZRLcGR9ECJZt5B8zo/Ek2cjYUXmSy7cPVcGCr+MJw==
X-Received: by 2002:a05:600c:a49:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-42f85aad1c3mr30536915e9.10.1728066829322;
        Fri, 04 Oct 2024 11:33:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f89ec644dsm3546475e9.37.2024.10.04.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 11:33:48 -0700 (PDT)
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
Subject: [net-next PATCH v2] net: phy: Validate PHY LED OPs presence before registering
Date: Fri,  4 Oct 2024 20:33:11 +0200
Message-ID: <20241004183312.14829-1-ansuelsmth@gmail.com>
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
Changes v2:
- Use phydev_dbg instead of warn

 drivers/net/phy/phy_device.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 499797646580..e3aff78945a2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3421,6 +3421,16 @@ static int of_phy_leds(struct phy_device *phydev)
 	if (!leds)
 		return 0;
 
+	/* Check if the PHY driver have at least an OP to
+	 * set the LEDs.
+	 */
+	if (!phydev->drv->led_brightness_set &&
+	    !phydev->drv->led_blink_set &&
+	    !phydev->drv->led_hw_control_set) {
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


