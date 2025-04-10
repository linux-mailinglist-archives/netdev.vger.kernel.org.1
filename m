Return-Path: <netdev+bounces-181168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA32A83FA1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E278A3BF08E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06B26B091;
	Thu, 10 Apr 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC68hzKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28B204F81;
	Thu, 10 Apr 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278923; cv=none; b=ko1qYHw5PR2lHB40Scmh/8hjWsOnpCaztFCXIqFVj3q8OUj5uDeMVo+AfNZrdsqwmaRxWgNF8QrklgsW8jWJQI1eXRvsb5x9Jw+m14DXh7D7XF2EUoVc6OVqUej71/U9pJESOriPSJg9lIjkkrwnL6OvRCHwhRFBxdzHzBZpvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278923; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/Df3r46kthqvL+O9Ki3w8L+vw4Ge0o/2Lll9FR1vQD3qpfyUnIbBgTFXY9pQ2aKxonfre97JwHCbS4KfbQhKd2lVVcwfhk9IJ1qKLttxUFoM0TdD6VNr15PcstIg0uC95BYgTjtv9c5tK6IGE/MQADZbI54RdXH2Tas/8C0gMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC68hzKC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43690d4605dso4968535e9.0;
        Thu, 10 Apr 2025 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278920; x=1744883720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=dC68hzKCVf46x2YK7+PqjHmi+c+clr4Igyq+dYCxLdO+yHZfZDAJSE5vyq0iOl7RHK
         qJ8X4+ZnLayUHsWzgAlgb8i+KeJJcMnlwYC1WaJYS4hA/kS9agVePzEQiF38QiUuJBne
         wdO04IFF5/0j/ABhUk3/7M62maMd1UGIhx2mU5UuAoBSr0ejGz03fTeRumqxvvlVVRJn
         B4YvqRNvUS8vZKoxfccAa8tMOvb8Z6jvGZcWZXO1alVvfCZmGBIuKagxmHGfQHHYha0R
         xigM5Q9d7Z/p5r4lqMbJ2fM/aCW34nxFe838cT4TqhGCihDhx62ZCJvama/2cZRWChuT
         CW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278920; x=1744883720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=QtZ6XSDcv0Z61y640eEcFyJAV4+8/SyUUbzww/1FjZ6gdWoJ3Wv8ym02AmMTJlGkLQ
         0M/XdVELPFf4ThrVF+UY9yKxk4n2HWqkU+T+YURRRkzpdsQ5FDCt9RhS42l7UKRD8PNf
         nYzoIV2gkJU1+zgmxXl4rjwr/gCXP08e3HVI6tt9IyPxEyN/q4GsP7EIXqqaywhOKqlD
         OFooZWfOELZ6p0pZ9qhve4RIutxPTKdHF8ivh2mvpwwGkuLTPdUG3n/+1Oefet+b+Qtj
         zMJUxpxHlktqpO+l/ljI2KsBd+dJCSXgT6Hg+uc4GPPeZ3gxUUQGx+gMNtm08BFAK0FD
         IUog==
X-Forwarded-Encrypted: i=1; AJvYcCVBMhtAkU2kq/iOkX5CV6Hkjx+stpNIQOSDfs6pmqpkZsuCoaoBWOEFP71uMDQQTybQHc3ipVTx0s4Y@vger.kernel.org, AJvYcCXxG3hNfTyZwchge0/MLY9j/p7wDbrJaEN5LkvmfanImdUHaJFEjCsOtKksmbAe8/FEcPHDVdol@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAeIKLMfkPcKVpzy4WN3H+F+HWfEfEYuRw84tYE1V0Q2ujSs2
	cLzjqnUWH8vJKbPrBOX/wkbS4rK33Hdx0yzfKQ9WMZER88HslEbV
X-Gm-Gg: ASbGnctXel2om7whIq7xwcYVEqxbl/SnOQvtkgVAQi9nx/bfIoFtTmK9Q5B01LJ5P0N
	pjfQaCTL0nul72zKm1RdkxE8SmSPhpA4uWub/zUo9Ya+F1GspPlb/qVhhuVDCpcl9naBpxnWf1w
	IAbvi9kWMFZPLIrs3BBL+YlfZGHhwmYw8DGT9NCteV5kxlF0i4aAfkEnreo7EbiJ00mG+qNZnAv
	KnRoy+nsG/jKCB486Q3lp+RFDlAPB9eK7g5vuZI4A6QfqwI6kH0aJi3p3Raz0crto+JpnmCHwpm
	KrRj4JBKeJkKxhPrXWdWzIHa2S+KOLOXLfqxtHdr6QikCKBH66Zfn2gKIVxvFeb/aPzvpjlwg+d
	XHoh+v2o8Vg==
X-Google-Smtp-Source: AGHT+IHgPRHJxe0Aw+dm/YoSHw1oOjW/dciHkziJIEUEeezIQdaLzTyhPYDBBdOa5RnYL0LkVlFmhg==
X-Received: by 2002:a05:600c:5494:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-43f2d7aef61mr20723445e9.1.1744278919928;
        Thu, 10 Apr 2025 02:55:19 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233a2f71sm45404425e9.15.2025.04.10.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:55:19 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.or
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v7 2/6] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Thu, 10 Apr 2025 11:53:32 +0200
Message-ID: <20250410095443.30848-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410095443.30848-1-ansuelsmth@gmail.com>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
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


