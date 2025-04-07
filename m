Return-Path: <netdev+bounces-179926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B146A7EE9A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CBC7A669D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E7222571;
	Mon,  7 Apr 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiXDsXCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF6189B91;
	Mon,  7 Apr 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056608; cv=none; b=NnGfz5BthLVtGwm9iaK/+WCadgI9zfHWA3Qy+sqahjm8jU3qWUgPjFVr6AvBSps4R+5mkmebpcX64AV5jIiq56f4GvzBw9Cl0CLhhaS0TNsrIrFoor3dCoh/UNlco0rBzsuiQ7DO8pnLJqYuf2WVGtmjDmOwyaEld6eYmM+mWTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056608; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naAWghftbluf2/yriVqLywezryWH5Up2XTu2LlPAiNaNmBsGkdtryCQfRQrcOjCB48LkT6l+Ppl3OO8yPN8DC2cdW57G8E61VN7PZROHVyF8nSQMZ2DWHD/Xua/mFC5BtChgl85LNPq8gJsceVq+hKYsQwNLQPR9u00daV3KspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiXDsXCA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-399749152b4so2536428f8f.3;
        Mon, 07 Apr 2025 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056605; x=1744661405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=EiXDsXCAqEKQ0SinHBZNkK0vYJ1I+5XDZxQzOorMVnV5ccjqtwbHuXkQ5IPRaYNq7T
         ms3GCFEOgplJmYD7Enbwis4warQxNzIk3TnpBgrNIpQA9fD0NEXY7U17vEbzjtLmALk3
         6iPKxC9U0Hcbxg8B3O9Iv0TJYrPAe+MBzvVs7F/7hxQaHLmO0cZJtGOrwHwln/JtrcO6
         aYotqZUrkshwxDBQ+ro01Rq8FOQM2KqXR2Qe9sMU9iZJOMaxXjrjEptDH+Efc+/SiNUy
         gr1f8t5aZ+s3duAdmoLMKWL1xsgOiYxjOSAICuUfRozXTlIi6EzSm1Rj1F+/IS1q77K3
         eaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056605; x=1744661405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=f3AqCu2EdzprkiipoVg9mVJGxZ4Mgo/hpEvpYRSXKs4TUFvrsFLRx1xsGBGrUsM7z2
         R2abuHvyuiBBES1FZQc+0py4dS3jg3lSRQkTVzJrw8AcjBQ4j3u5D8SLkq9Bhfcm8eq6
         eZFCrKUw+sdNnEdiYjw1x2t2V5xvGoKDusWiqiZqhwDeavYszGLr7OinZJAAF15gYIvU
         3baKIZYMk2XZp/pA+e1d5oAXMWGhIqHF/lOJoClNraxMuCVH9ci8rWGrYZ5W+S7T9UAs
         cAtvsRjrD0HJvE6F7LpG+h24lIGuh9Q3ksUFlmlEwCmotF1oGI/FJRA35GNxwnSEy+vX
         aeKw==
X-Forwarded-Encrypted: i=1; AJvYcCUFi5AenLLYxGHWX9xLcz3q/5PVNykblPnVekWBf3chz869wb4Ek+zII6BBRw07a1rXv5fpF6cew5RY6kgL@vger.kernel.org, AJvYcCV67PLAbT7qwgWhLoiPle2x89f+cZtyNbEPa4usUDcsMI2Z7OJKh/B6XIz27l4dq2JCdtTuM1GaisIA@vger.kernel.org, AJvYcCVLvp039k7SCNa8ubuQ0oaj+TZyD52rBqciZMbiWl2CLc8ECmo1NsEfEOJIQVWOHb75VBgbJuje@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1boYr2NNolXnQaDmpME/NizSvjkfI58da70rYYf5xskTYY7aw
	D7EBz3SGj2Vqz5DGpU4y+bE6O9mEC2rPX/MSLEgkHqY65CNgbeRT
X-Gm-Gg: ASbGnctbuLeadpvM5kb4n59tgx2Q+WCEjfltu0+NF3FXxElVk7k+R0wg4wK1zpv394i
	NlUVpjpSP8GrNOkJVZZjq/NCYAy0KSFac79CSSxFP8E4mcOLV8qZRh4aWPQEmiWfFQHSE0XLAz8
	3VTgK3IKk9WC3NKbvHR/Vrk8iwOEObdmBSyKshEwOE6Jp1WpcUV3co7sbj9v1bhxN2PueC6+Acm
	Gtg95fhKPVDKrc1Sfe5cerhu9BURg0IEQ2pSQcG/2ATgR3lgUrCQA9KPTDDYzwUr8Oq7hXCQUWs
	ryr+AUSJ1LRwzGDK+7vc1f13KzdJNCGCdT5m7GJ6kBFOBWnDiBw8IQqcAdNPeaEjlgUTsVgnABd
	B+udjlagn7cAViQ==
X-Google-Smtp-Source: AGHT+IGZ1kOdneN1tNdSgTHmJp4z1fRS5lLKnGxomVukCdEutvQS+BUA6STA5UzW7/+UNh8zWS39yA==
X-Received: by 2002:a5d:59ae:0:b0:39c:2661:4ce0 with SMTP id ffacd0b85a97d-39cb35bd5d7mr12462741f8f.13.1744056605347;
        Mon, 07 Apr 2025 13:10:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2e6sm139605995e9.18.2025.04.07.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:10:05 -0700 (PDT)
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
Subject: [net-next PATCH v6 2/6] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Mon,  7 Apr 2025 22:09:22 +0200
Message-ID: <20250407200933.27811-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200933.27811-1-ansuelsmth@gmail.com>
References: <20250407200933.27811-1-ansuelsmth@gmail.com>
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


