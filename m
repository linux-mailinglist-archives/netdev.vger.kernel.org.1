Return-Path: <netdev+bounces-178033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8AA74110
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FAB3B1DF4
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14C01E8355;
	Thu, 27 Mar 2025 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du5sxzsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC91E1E00;
	Thu, 27 Mar 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115566; cv=none; b=tag/5DUVjj/iz6igP4/49DH3AGG/RXGLGPnxub0TZurFR3bndTnMhiP/tCLw7nL7bkjpmfIlZXjZZiLFgJYjxgADQQ19WCauI18HXiFRuMkuAX17y2PKx7R4f1A2ovnAh1coqBo62HxEFMH+2CNPJHFGbf5POP2krhN1XYzO5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115566; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjCIdJGUiUtgxdfB/prRMgKj0dn9qITd3jhk8S2JcOpoVWTYk9CgOS3IO2nk2k5Ua3UHx2EsokhDPUeb3n5ltbijPQ7oRALhApUnDeiikwA84Eg1WekvbCQ9yJ6PQhP438fIv3g5un30Zsw8d4gVB8hJajR+GSrTULn7DPan92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du5sxzsd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39bf44be22fso624135f8f.0;
        Thu, 27 Mar 2025 15:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743115563; x=1743720363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=du5sxzsdiac+VSlFOMkByDmFQWvkH7Wn1Tc7pJW788TMwa/eTSrS84+8yaifw3aeVd
         /G5EGvOv39waYM0Ks/VeeME721RtUvlZAmpFloTrryel1D4Sf+rDZcX0Auf2mmV+xaeb
         7yezEJhcDLTxMMsYxngTojNZJZpjhu6/U/aVZJ82MlgU2112owaoA6tSbrrFD/VkA5Yi
         tovE/HfPdWMbcxXdHiqzZVwDcgm+yjUnvvUOteUOUEp1uItR/eTOaZc1zIsmQM/fRbii
         TQUUbe3HQMKzs+ppWR4UOLX2FkVznhcxedE0YynRm7jezVAZympB+eO3GR9wBZeOjFCJ
         QWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115563; x=1743720363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=hMX7AV+zxocQ3UDQHdn6t7wKjnMOkCEOgHlO9bKKLR6DAyDVem0ur7S8fujXBebyya
         fmLxx41HMGUbjFhMh0iTQNjwqHCiYm9iCwlzwQl9d2DtksjA0rMV5jEW8yjYKIDNDN6b
         pBtfBnfRk90se3R8RhQHlmXyTyxe1JDd9EaIMSiFBTlOpPuaucIbcTNkSHOODdObHzdK
         QcWEVYQTg73XDUzaO7wqrginvu5qRlVVlE2YsLAl/OvcclNlzges4qxbOCJtTDN4i5jJ
         sV6tqHEnr9eBLK2ISvOngIJfBmRF7s4JrCSHp0IHI2XrpoKl5c7oeiHVp0PPTPvwjE3H
         orNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsHtrnFX+nPPiW800EwB2rolBQkQGzIECW/uAYWamd3k7lZGAoxb1UD3LqfEuMgpNTtq0HVQgXAFZu@vger.kernel.org, AJvYcCUu10hC++k2c7i8BwaYSeTJMh1cWtGuweiReyBl4qVfTrX9/f8wRCuHHIA6pSM0tKeMMUFchoA7w5HvovGz@vger.kernel.org, AJvYcCVK7r9KxaxB7JJLzqASZmx0IZgmHV4csIhqpBEmalKmxy3SoL7o7vi73NfMw2PSzCMQ17DhQzzH@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBfumXdnuIeldbz/26q1r2ZRtSjj8dgrTuR1ldTD3r7HnjEGR
	S2NhnUARgxSaAn1VC09dC6DyzrdHvAnf30h8ocZBkYZU54oLxwwd
X-Gm-Gg: ASbGncuNk4FcKbOHlRHTwRLtE7ouOELs4TFle6P1q/2SF64pd7XY9t4fRxIFNO8sEBb
	+B5W2ub02C1em1Hln1/rMa4wBL23cMQ4pNOUroOQDijpGF2pHJMPvqvyAaGOqKhMRc3FJJMzjkG
	LFKBBLU1z1E1jK8rVax69vqy8Z7zspU4ROoOXKkgMH98P0omLm1BRzuLPWYqlvpBZG5xbjnRCtd
	RzsrIIDJtfkixVcCN3PnmYekly+fDX3BSygN/8QrMhCJ41j6zU/il2uwcPCvIy11Iiw6FM9OwH7
	r3Xkls23UPOFeXdgexEiYtnpX7i/hMbP3pb1GIkIMHkIA1JbTs2Jnbn+djTO01PIr6o5Ca5+uvn
	rYdJyM0Aa0bBMyOkGYSpIr0ad
X-Google-Smtp-Source: AGHT+IFH3EoaL0CbDbjpYSv4m1ITEwAEqpKleVr1qSUQ6QRbimalB6dXlJm1Nu6utbh7p/zbZ3wA2Q==
X-Received: by 2002:a5d:64c8:0:b0:39a:ca0c:fc90 with SMTP id ffacd0b85a97d-39ad1746356mr5324505f8f.14.1743115562964;
        Thu, 27 Mar 2025 15:46:02 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c0b6588dbsm789476f8f.2.2025.03.27.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 15:46:02 -0700 (PDT)
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
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next RFC PATCH v4 2/6] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Thu, 27 Mar 2025 23:45:13 +0100
Message-ID: <20250327224529.814-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327224529.814-1-ansuelsmth@gmail.com>
References: <20250327224529.814-1-ansuelsmth@gmail.com>
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


