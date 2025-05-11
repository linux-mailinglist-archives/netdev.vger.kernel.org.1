Return-Path: <netdev+bounces-189567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A791FAB2A5F
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EDB7AB9AB
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D82609F3;
	Sun, 11 May 2025 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX7sK/0C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71125F969;
	Sun, 11 May 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988825; cv=none; b=dxCYPSHWvSnPN9knS3+jDA+q8rtoGK2Aq2/fL/kTZzBS1ttQACiqLV5dr1zsQk+LqtD4ugg1nhccHApKjrEMxpBI8ZfR+RYIlXaHMzsyfmobbcAMhe76CUGDvw428RZw9G8rbvU+FeHlbP7tVIgGCBc7CtYZWfsLHPov9E2vrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988825; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KffF1+R1yBPZwqpuZ9sps4oZ6noEGIoRk7UsnL3bSCJkztc+8Vosz4zoZ/AfYnii6deSqJwX2OM2VFcTpFZVl6HOLrRD7NOG3Ijk6BBOHj82H1jLRTfPbPNwQlTqMFc/D7/0D8lmOl518ykZNwRFbxXsI6q8uX78RAXQ8zMiBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX7sK/0C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso37728685e9.2;
        Sun, 11 May 2025 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746988822; x=1747593622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=TX7sK/0ChNLIbtiyg6YMkwTMgVQEhfs5LPT0X3veT3lP5lpi1QSjiwAjLRC0TSCjpa
         7AmkF1/LmHEuWgND6MSp7RnB4q35/dxO7HE8OVzWRwATYonZEaA19ozIMSk3tloBYhwz
         Xael4jfIHw+biBqt3jkX2GTa9dwCdQbHKAPwpG8PlLTItt0Ur/+t94pUfTtmeKRWa0i/
         UU/k0neShJ+MUdZMKJvsdrfGUIYBpHjkwdSEt6N6FjrFHD3ZLT/AX62qjnYaFJkVpGIJ
         LNexSc0fqpwFLphLa07Wh0RecwBXpUjWN/hspFlvegAIKHx1U9Iq5UJOXUEm3RHhbgll
         M0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746988822; x=1747593622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=EdwgdWa6yUat1ZxPJy470Ome7YSiKCQgaw0T1h/waq6Y4qxS0w0GQwfAMxNTFM7Rfs
         gw3jWQAA2kDBpCBpldNqA4qYyStkMAbRHpwq3IzY/id7SDqbq+lg9A60NcWq/KI31Tl+
         MJchZHhOOcZcMUYl0bDv7rE7PLLXW58XL2ZhU051EELmWuph9FJEdDaXVkPR57fUkSYv
         nMUosF6Ff9FFyuZGI69n3lbMs06qyB9XkORijwAmerLa4isXu/lrfhFDPpkkxYpJc643
         GjVQ6rD7NKCWbJ1FpAcpha50Abfrd2Isa1i28VBT+dPotbFvV2U+JEaDfZjmMEhmIZJz
         8y0A==
X-Forwarded-Encrypted: i=1; AJvYcCVJrccilG9qo6mdyRMzcSWRPoxydWJlc2bR0QwTcmU/DPZMx3dDimMhIH1B02ZsdkV1QpoSf+P/pClRsatJ@vger.kernel.org, AJvYcCVjl1eKk2hgLAAQs8D2MGet/Xt+gBI/ozKYw5HwLQ88o4XlgYn/QZylA/7xKa01UCyQQR9C0MxKI1gy@vger.kernel.org, AJvYcCVx8rZ2IRHi3OEOV+NFSAHaL6ILbm/te9NDbRy3t0PvHkqdk/wIJzK8uKcH4yXFXhvUoauXeMKy@vger.kernel.org
X-Gm-Message-State: AOJu0YweX0ibPSxGkhfBhteSIqK5JHYVXElBI5G5JYMXL2Eja6Wh2Pdw
	nz0srQXHu+bbZctTVWyEOiaT8kM2SPe/1238fpEzxgvZpvUKl8zz
X-Gm-Gg: ASbGnct9NZNHluoGnUWjWrEOXz2/mu3FOhW2WdVOx9fB3Dg5pyD9aYjPTJae0u0TwTM
	uFMnw+bxzb4eBuryKBhwlLnkXfd6rzG4RNMenJxm0XqmsNMxjMhkkMTkELyd6nZczwEZZhvi6LY
	OjvwbTo+U35sx527VqLCyXGlWyv9gPKo3bL5r5u0PmLBKSXCQYrPa+SwhQUJWRhWnUWNt+v1m2t
	dBIDNbGRK92DCcSDX92HJgryp2dEWJFC43yEp2V3It3zE/7j3uNwiOXq86i8nuRKU6NJXnVLHQT
	5gMkI0zO9z2JJwTqakpKpclRfxgD4hUu9BUXQdbiQi35Ng4ibGi6a1aX4SgCGnFb1YWKX/NK8Ly
	dGTSSFXCRdOi2YoO0MpoD
X-Google-Smtp-Source: AGHT+IG1lgJdBBtBufUu7EMqcsypH7gqNW2zn6PVpB1dxzTe9b8x/aeuiNP1WuW2g0rxcg7QnIN1lg==
X-Received: by 2002:a05:600c:510b:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-442d6d4483fmr86993445e9.12.1746988821312;
        Sun, 11 May 2025 11:40:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d76b7fd6sm61020615e9.0.2025.05.11.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 11:40:20 -0700 (PDT)
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
Subject: [net-next PATCH v9 2/6] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Sun, 11 May 2025 20:39:26 +0200
Message-ID: <20250511183933.3749017-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511183933.3749017-1-ansuelsmth@gmail.com>
References: <20250511183933.3749017-1-ansuelsmth@gmail.com>
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


