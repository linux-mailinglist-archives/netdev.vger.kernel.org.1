Return-Path: <netdev+bounces-178572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D2A779F3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BCA7A1171
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013D3202C43;
	Tue,  1 Apr 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We86xZDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D468202983;
	Tue,  1 Apr 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508011; cv=none; b=Nf/SxP+ZrC3Z0O3BBqrMTnWw+GiosrJ/7HxBfjWmZPnMx5yisxc+U44UZ99TXhGHEIqX0mf98bypQtseZS/YFzI7PsyHbMUwcWhlfL1Gk4DacxceMDuqLwpTOyiaAvD2CFfWfyFNiDjIt8g8ZfydqnWPY+ZM9v7rW4aAAbTRMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508011; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbsZGYPywRnuhsuGc3WjunjkKMBaG2lbTNkHq+vawq79eo+DYf9DN8g03MfO5SpF0uPBK6XaUe/5/ftwn2MUUS0XGAySkwyG4PLYOT0GU568Fr0WUrZ8/P3jkxmja0UYHa0BzZK3YJ6/UW4cjBmRUpVIYdF8YhRaPKJKQc/UVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We86xZDZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so13256255e9.1;
        Tue, 01 Apr 2025 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743508008; x=1744112808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=We86xZDZTCK97fgM2+RqmGwqlJ4Do+O9qtaxfFLYBVRwj92hlqn0ghCAoKuku+qml1
         hBD/wlbBp0JBrRS/iApi3jaTvWwZJEO1ln3UItSgNnstdYYjbjlv5ea5sXT/Qd1G12/x
         7TIofTQDrO7DlbJL/73EZrqhlvREkwkFY9UAzkRhF50PCd+iHRC2ppTFeUp0CBxfnpTX
         O4xdaYqLXKXEE7oZ7zLb9F/SonCcrrqNshHbT5CfXG5thPado/wr7ytMGP2a+njFUglK
         jMsXSUusQqur/ZTJAKSEyEKlLPscz0YCPf0YwaEsLNQPl1Or9b63eyxImjYM+nRt18Nl
         aOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508008; x=1744112808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=qIlO9FJolRECn20wAvzuSMETKhcj7PFBCHMI/DV1Pt72TZIQtDMm32TKKYu8kfilZr
         cqszTdBCnWmCZjl+2ARyTwItj5xTDHWpKescJu1fTqkKS/l9feRHQl1apwLy0pwQ2NQL
         TMARFxo9lEPFS9LaBE0ukc49PTiG6Sz/6DCkmGTW0px8lXINVH3ZFHP5TmdXBTML9Bed
         HU+hkolo/LCG+PFWSMFkoBTmx1/7mTSR3SFXGXIRUZfM/Spmarjkl5AgYP0ftoZFmkGW
         BHjepcGEgTtrBwVD551C9cwAzdK4yotWKLgD0xHqxsC3DacQoJZ5fdNUjwankWy8w5Pu
         dc1g==
X-Forwarded-Encrypted: i=1; AJvYcCUXrki5Dw7Vnh0y912UKcwe/cog+z8fEJSW8QycWkqO2Ks0RV6Z+Vq63pwbaytwD41Cj+n3qh6c9zBO@vger.kernel.org, AJvYcCVnJscTraqf19vUwMl2b4BXfrtEoF8C8VWu97B8y1ZM4ScJXHLgOQG+aKx+EBjkUv7N6aj/WzxY@vger.kernel.org, AJvYcCXjMW3labPQNWiEMDhG6GJFdxKEikXWQaRKN1uG5uH0AdUo5lkrgBGkptJqRLa/Usa0vyydSwW/QdfDc697@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEnEyUykvW24Epmor1+uEdeZ3vDdCzOH2tRsRJ74GiUB9M1r3
	h8gicBNHZUKUjcgJez51RqTyV3uRvCwBRnFNt7d6u1L1IevOfK3Q
X-Gm-Gg: ASbGnct3plrZdscqhks5X/n844lNGx7TRm19iOFErlTZUpsMKfc9eP9ZkKt//uEG3uW
	eIbX9ezZ8MwzsPEAjyY7yun4xwV6WHwbM7FIyqLRK43eq4uDoBO8+CmZTIvXAmysIbc9pbJrUxN
	9VHNljIvMh+hRiQTUVzpCE7Q5RA/tmqEqjwk5EdIfI+z9TReHLxoMQND5eNE1tKq56wmgoWqGak
	IfvqM0MGAfIlU9S5WOU2H9Ed3R4C9/NMV0R8L7vbWFSp5+irCjA4QVXLErGO0CtJLw20Ku+jP/F
	aKYwo8SXueqWPiNc0FNc22SFndCS8KFo6Pk/j9nZzI675fZf/0xQMPCiZrHvnI1q3/iz5yJ3avB
	yobAlrQkn2ya1qQ==
X-Google-Smtp-Source: AGHT+IHQ0Hjq73bRHFl+XWRxDmb2IoAYW5dsebo09D2nD52qy2Fc5tL5APjwKqJJcI4Dc3k9ZOB/ug==
X-Received: by 2002:a05:600c:1c15:b0:43d:7bfa:2739 with SMTP id 5b1f17b1804b1-43db62bfdcbmr97222135e9.23.1743508008315;
        Tue, 01 Apr 2025 04:46:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ead679894sm8148175e9.40.2025.04.01.04.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:46:48 -0700 (PDT)
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
Subject: [net-next RFC PATCH v5 2/6] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Tue,  1 Apr 2025 13:46:03 +0200
Message-ID: <20250401114611.4063-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401114611.4063-1-ansuelsmth@gmail.com>
References: <20250401114611.4063-1-ansuelsmth@gmail.com>
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


