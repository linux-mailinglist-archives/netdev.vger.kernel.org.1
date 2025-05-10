Return-Path: <netdev+bounces-189488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E98BAB2585
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AAC3BDFC2
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9000D2144C7;
	Sat, 10 May 2025 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+KyKz9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCBB20F063;
	Sat, 10 May 2025 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914793; cv=none; b=mr17/JVqcmopJbcN6S08ZqsI7EgFzYLObzHDJZ6uGQpazNfUTvxS/NvxCbgzK6a1xBIbA3MotEOqrHe4qxxZfMV2qEhOcOkdnsm3ocpVjnO7CgnYYmum84frgEQ6/GjvE34QbGW2gVtQpMvPF+LmC3TjoKAf4MatNbPIX/p0wzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914793; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDGlQVJA077iqv+LFOmLb4e6RvFPbAns9qii8ThSybMUfeFMQFbvdPx3saX/6hO59R82ycOu3LW6EWqrxLXPjYgwLOyeGaaaVMa58BzjrEvmbnCYS17Sb6POgT858aYVxVR9hdYnwLtAdr/M7Xc5rmeHOSSQ6h/qBxJj4jtVR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+KyKz9/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf848528aso27230605e9.2;
        Sat, 10 May 2025 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746914790; x=1747519590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=k+KyKz9/7kBgrANEX0+Ycf0NiYtad/C7W7bIp4k/HBLAguTpQ9MITvZGWe4A0+DDBM
         hVBZ/2GZjiDUWFgeEsfvwjkcB6io+SBqxQV5KhicpNq5s4L1L5vcD/W5dIAjO8mDTAAp
         ISj/SvVcl04qy/QMjws9tD2r3ZZleSJ5cmsYVcatip+ZFXpNGKy+AMIg/kJ2/okGLwYE
         bSxtnFhtj0PmqS+b1eBzKYfCOjy3MvlVwRnp40eX53CoKoa3J2ous6k4eBtu7OXFB+8f
         S+LMaWMRCiCHtYBNvapcvq3TL0iV9Li7LJ15O3ZzwyOAd+o3IK+5aJmeXzH+etwQLhqY
         GGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746914790; x=1747519590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=qTen4YD4Kcq5SB7m1LqKjf+dRZBkgoRJQSMT7YZGOOGlNtrRI1sRBMFj0OFrwe3zdM
         3VBWGrRlV0hP0rCbCiLuXVDOPy7zKoJk65oqITDXd5VCqJuaqCjDufmA+TOWMczZUXwu
         gtDQa4uVaXRlB9w/j+iuk1om7LMA26Dz3S9reSjrEgro5Ve4vENl3SyMQH2SRjn/u4wL
         Q40KNGLwOuR38cTyG6f+0W0O54BUc2gVac4SoIL6skpoJV3edwWsdPEOJPlVcVEgsw6s
         Pkg5fbGCd8xx19u13wZQ5zhZr1GWyqxuD307Ljgiv/xBPCW/vWpcGcE4oaxJShyN522O
         Lw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN9GGE1kIFLPPy2I5iy3E6KQdeiB+JELmarEnIjK5iiSKPbbcaqVN16Fh5dWtWsqKK79sKVwySQyUa@vger.kernel.org, AJvYcCVQJSaEaAdSJr6EVuKBYbPejuG5Vt0yTB9C2xCZiVcxxtp83yTDrrTzrFrzuI4CWhNtnMN9mDw2@vger.kernel.org, AJvYcCVpFdybTCWenDmpC17ricqCQqiFN/qDXG19BKNa2NMXmOX/vsA0JE6RL0Ucihq3ugws98r+U9yvCiOUSsWH@vger.kernel.org
X-Gm-Message-State: AOJu0YzhEqPp9Lmye0nbn+E09QlSx4/eBFsQ4taa1lzrGMMfxUsw50TK
	43vubFspCIA7VGzORFC0F+pTQqQJVCiCzord/QN0ekeDbXCs0jI9
X-Gm-Gg: ASbGncs94Ix6Rugozb6FuiVxQGCzrdQO4RTLXe56SiCSFR3jn/5BLJclk650tnzWYL/
	Q2j8iT0zhagcDKYFipG/hJ5QbNs17U9oVIYAghaCve0PCkLiqTWZ4HKNA+xbrq0QFUE2LzsSIiA
	Z3+4+DDhs1qQYoiDLAPv6UlZhvI1c3/TStc+1KbLm83MYKbRReEa+/GV/8ZCgbLgt6989Mmotsl
	NfZLHuXQUkXFOhQtQgYxrIzObr5WcPb61b480NDgJpUkew1j3uVqSDPzItfLfC1AAriRb0ZwN1S
	pw774HzQCgkEGZ4Y4+WRJ8BSYgdJacphnVLQHeCByFXig2L7vhGWTGJzo7mESWvHPq2oZmS18Tx
	SlDCrLOp6kcwCp0+b5Qju
X-Google-Smtp-Source: AGHT+IEyBhypG8ieXK4DhpoplIgZDSl7i17Cy5I4oKF4ck1H8G6b248XWooq2iuIVMzQ/LdBweOzwQ==
X-Received: by 2002:a05:600c:4f52:b0:43d:40b0:5b with SMTP id 5b1f17b1804b1-442d6dda0bfmr50186575e9.25.1746914789824;
        Sat, 10 May 2025 15:06:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2e9sm7477940f8f.75.2025.05.10.15.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:06:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v8 2/6] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Sun, 11 May 2025 00:05:44 +0200
Message-ID: <20250510220556.3352247-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510220556.3352247-1-ansuelsmth@gmail.com>
References: <20250510220556.3352247-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify .match_phy_device OP by using a generic function and using the
new phy_id PHY driver info instead of hardcoding the matching PHY ID.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/bcm87xx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
index 1e1e2259fc2b..299f9a8f30f4 100644
--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -185,16 +185,10 @@ static irqreturn_t bcm87xx_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static int bcm8706_match_phy_device(struct phy_device *phydev,
+static int bcm87xx_match_phy_device(struct phy_device *phydev,
 				    const struct phy_driver *phydrv)
 {
-	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8706;
-}
-
-static int bcm8727_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
-{
-	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8727;
+	return phydev->c45_ids.device_ids[4] == phydrv->phy_id;
 }
 
 static struct phy_driver bcm87xx_driver[] = {
@@ -208,7 +202,7 @@ static struct phy_driver bcm87xx_driver[] = {
 	.read_status	= bcm87xx_read_status,
 	.config_intr	= bcm87xx_config_intr,
 	.handle_interrupt = bcm87xx_handle_interrupt,
-	.match_phy_device = bcm8706_match_phy_device,
+	.match_phy_device = bcm87xx_match_phy_device,
 }, {
 	.phy_id		= PHY_ID_BCM8727,
 	.phy_id_mask	= 0xffffffff,
@@ -219,7 +213,7 @@ static struct phy_driver bcm87xx_driver[] = {
 	.read_status	= bcm87xx_read_status,
 	.config_intr	= bcm87xx_config_intr,
 	.handle_interrupt = bcm87xx_handle_interrupt,
-	.match_phy_device = bcm8727_match_phy_device,
+	.match_phy_device = bcm87xx_match_phy_device,
 } };
 
 module_phy_driver(bcm87xx_driver);
-- 
2.48.1


