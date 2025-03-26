Return-Path: <netdev+bounces-177872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1797A7270F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 00:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EF31753C7
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21102641FB;
	Wed, 26 Mar 2025 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWuqbUzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF6253F26;
	Wed, 26 Mar 2025 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032151; cv=none; b=EFILVedwkR9bLwHOxoQCUWhJQlnN909ptorJjt1UieSMWNfHdCyEjC1UpZ4Ti0Gqbyuc4Le/mS+6ZBB+P649pKrKPKmNhoPK9rQZypLfC0Gzm8yzkfQ3IJUHrIdJH35pZYJ8OV8tG2dnHvHwvIZMZoJuArw9+zaD4KNnESJB0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032151; c=relaxed/simple;
	bh=lbW0dm9cpYRsI5fczkvr1PQPXs9w7fOCuPHKt6gm5io=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3+Cv2ma7Z2e29NOlM8PeWhaTUUhGlYrm9u4OvPFa4/SScVMeRCTqLNFaxdob27hJXsqYnGbdRgjvuf7PFd0aeoPGP19OaCeBx50upQMg9OBfa8k6nbos9OubvJcf67c8mqvwBNORg9VD5l5o6jFcLUvbjMSK5WfUlXQAuRg+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWuqbUzH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso207478f8f.2;
        Wed, 26 Mar 2025 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743032148; x=1743636948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmtUYkrWbq//wEiBGA4Lmo6NUH8HS5BtMBEkrIN2VLo=;
        b=ZWuqbUzHYcMleNbATzeCCi1/WTAUGRcsiQ/0ArdK0YZyw3LqNnwm8wpW1nzsoP6DQN
         ttWEeoOYsviuw8rlyqdhAm1wRdHi5zMWBLRaXGyCfxs17AQJ0p0rOWMpHFje9k2KD3B8
         dnIXboigz5V1sRm5XBQF4diGu34txUejHjP/rFSVeKWCIt3Hzr3+ymMItm0dW7Z+Aaej
         u+iPOkNy2u6MlCKLMOGHsaVlwT9djpCu6qLquaNzLKg8qAoKZRPJPIU2yLAn6TFuEz8E
         vstlAHFHkpwSD6ZyleHH1TSJiVx47Ki18zRJ6mYPJl0um5SCTogr3ZTvGsPB0dFHodm/
         jqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743032148; x=1743636948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmtUYkrWbq//wEiBGA4Lmo6NUH8HS5BtMBEkrIN2VLo=;
        b=JtboJ9Eg2OmwsIdSc1+gU7+XMzlIh3Qp3cVNad3i6CZDo7FsrTMtUajiUlK6c7RyeB
         e4SAr+rrh9cbAh+Ct0yIPvr/pPilCGTdxUEG+4zqAOH4EApWFxMe+xpwtbeM8aufZ7NN
         YHQGzSEuBi1fa8qW3cfawjtHTg+wNO9cleRrikY7YhTyQ6p5Eg+vcsVq8tdM2k/dN2Me
         Te4ZQ/UCL7G5V9FAhd58+Np2LEWkaalU1FoOoaT8O6UCO+cjRTTTJwLAwLszwbYN8uzm
         nX+CwiSOaxvAH7vZf3saFYCwnfFAByUUkP2xZJ+g+Xx/prXY/UVN24/sVGXTaDkqobOh
         xoDw==
X-Forwarded-Encrypted: i=1; AJvYcCVijJVbMMhc3WDvs0jJ1v7q4v5UWkiSh7odo6iMhObp8c+4f122pWI1QVMPyEmIyqVD21B4hrq7qDCJ@vger.kernel.org, AJvYcCWDNlqTD6+avN4gqUeCwgUAQk0T1icTblNBkLgjDpwoSiqrc4GudZM+MUVVZ0ju40l2HSygGxWPFZTeEiIm@vger.kernel.org, AJvYcCXlyZlrJfyou/hhtdNbVcWPIpixaUht0/y0U0Hn9x4xT6o2f/uzUahS/tCV7f7QCokLvbsbonwR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WEhKeLoxl0q18r0oMrKnule5Z/lMuV53Q29wCc6lKt8EWuql
	lst79jYPJKcvC2VS/5BrNZPexzt05bfetV+tu0e5wK5GnpZq1tHZ
X-Gm-Gg: ASbGncsRASOaVy3VS/vyPmGUKdeZ/NFJurkJ+O/POtKw61SYNLJW5Iz/HJ1n44skCNJ
	/R1oEP3GHG/XQIFFRcEKgbEckKdWBBhnBOQPGCpGXh6x97cZfqTpWl7nOE7Gowtu6FN+TACkF2Z
	wGBiXKkeqG0a/+aXR7PaWe1545RqTTPCMkra5m1eOBp6ddjBDbk9CCXZuvzJTw03a7EUvDHJUO5
	VDR+TnnoldhWMqlMz/Ds4+8fSjq/YtF0BO8jpcS6MRzGAKnU863GxttLGqTHIFyblMhOounJf1C
	r6vD6Rvrtg2ORj8JzgIk2eGfmFLK+FXBGbo/RZKeHgzsCLC8uiL0nlZbUlVCO64oMfe5iR3sAK+
	x7rg9QY8dPBXjdw==
X-Google-Smtp-Source: AGHT+IHTpovy402t//M4l20qJxPXAvRaMi4gJ+XQdJ/gjTQ3OTcAUGORtSqMMLJTwZc0ZQLO8UNXCw==
X-Received: by 2002:a05:6000:2a5:b0:391:1806:e23d with SMTP id ffacd0b85a97d-39ad1740291mr931734f8f.6.1743032148220;
        Wed, 26 Mar 2025 16:35:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f99579bsm18390328f8f.19.2025.03.26.16.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 16:35:47 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v3 2/4] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Thu, 27 Mar 2025 00:35:02 +0100
Message-ID: <20250326233512.17153-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326233512.17153-1-ansuelsmth@gmail.com>
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify .match_phy_device OP by using a generic function and using the
new phy_id PHY driver info instead of hardcoding the matching PHY ID.

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


