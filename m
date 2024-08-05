Return-Path: <netdev+bounces-115882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2A9483F2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E7C1C21DE3
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA316EB47;
	Mon,  5 Aug 2024 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUkH89uR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928AD16EC18;
	Mon,  5 Aug 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892290; cv=none; b=TxTlKHrYU9LiUMd7E9GQjWKuXKMAb8ZQX3WmutRKjheG9a5lawgHvdoyh6luwI5deu4UXfcC9cCKziAtMbsOxHR1MlrpTkA+feeSuSI3QTiTDy7giKlSu55japEEbDaIwiZPx22z/cTsR1R/FwQY6SSJMmlEp+DN3ZwBkZsROPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892290; c=relaxed/simple;
	bh=f1rYUehadIPkjV7s9GujD6nHmJnb7l1ocKF57qzrzIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSvqT4FnYuvb4Tx2KmnnDMEVRtyAqaFKaIB6BodKbkCsSwBonnZaJ3GNU18A0V4eLUmA6uSqEhllFjX+NUkopmeOR+Xqj1KpUJy7u8Ko1LQoLjz9n2LTpKe1BR7mHOmCXaf3kuk6QKUcllWkZpnTP/PH6cWdLaefo/p7YBFng1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUkH89uR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so58035571fa.1;
        Mon, 05 Aug 2024 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722892286; x=1723497086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Epvcj2yDIcXIH/BhUb2YswgxSjmOdDD9OTNEx4OZgTU=;
        b=OUkH89uReC0l2Wm+2Z4u7uqeK3H+xk+6ma8izjg5MciSx3CJf1uYEsbzfjAqX+aA/2
         i+omLBP4B1yDcnYONG4tInn9j9yhs6afIJrDOI1DokaJFOaZCSvBhaNO/hq3G/cDMQar
         z+6MZstkuykqlPRd0h+Yjdr55QNlX46n4GP3JcPAE+A9I/AQ6Ml3XqEnuHLTjJXf6Yq1
         dHPUq+t/L1QO+X0R16rsKFkW5hMEiX+cBvdRbXByuHfMZsDzy18juskF9KlGC/ZWmkgR
         NWBqE5DmeLVF4B6iZPa5BKxmvqIdok5FRiOnBzGQBU5Xbcl2ScMIKd0ulUGILP6boXwF
         epjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892286; x=1723497086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Epvcj2yDIcXIH/BhUb2YswgxSjmOdDD9OTNEx4OZgTU=;
        b=Vy4FZ/QHkm9tQ9kwA1sKyi8IKbKEc/Rb13jk4BGUvc8r145FiDVRfqnc89MMbfHihs
         cKYZGtOBDm1AL6j9FEH8IydL5VRMxl8JBX5M3em7VWorTV+JxcDD2J3B/EC5HtLU97df
         kqTBCv3zs9Ev3mvskoXYHJy1GFLYqcLZ66JSgdehgEUav9u8HSKiRwBVw6YSvOoOxXGb
         W/HSMPGfTvMH8CTtZg/eNKb2p/1f0cNazHkDr38MuDyLTR7arzO9kRGSEmfFZDWMLvrd
         R2ZQYDd7oDyhtMqn2Uk5ETmepETEmmnwp2cL6mx98EvsfK9Aluo/jwUGjieOGhbmytfe
         nwPw==
X-Forwarded-Encrypted: i=1; AJvYcCV3hsIpLeFpI3hLLiC0XCNZuXOMy/5ahJGNrgFQk5+HsbhSf/4rZ7sDjkwOmdv+/VK5AR7hxuNuFPMvWfMWG+dgPutOb2c0AF2kuzDG
X-Gm-Message-State: AOJu0Yxb0f3dBSMJEfqECi/hKaAAfFFLWkdabu8ATBtz1QHM7sySf/vC
	YsbJeYOOPPDove5h55oLMxPG5dpkynJNw/KXJgiNIjzYYrfCXT+31V8pUwmI
X-Google-Smtp-Source: AGHT+IH19P2uVE0wChBFrm6lKgC+LhvZ5vlEdyEgeMza4OaCOMm8cST1J4GzQ0H2oDbOJjt47jdukw==
X-Received: by 2002:a2e:9450:0:b0:2f0:2026:3f71 with SMTP id 38308e7fff4ca-2f15763aa5bmr42218151fa.8.1722892286015;
        Mon, 05 Aug 2024 14:11:26 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:1688:6c25:c8e4:9968])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c623csm11875291fa.63.2024.08.05.14.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:11:25 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 5/5] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Mon,  5 Aug 2024 23:10:31 +0200
Message-Id: <20240805211031.1689134-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805211031.1689134-1-paweldembicki@gmail.com>
References: <20240805211031.1689134-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the vsc73xx mdio bus work properly, the generic autonegotiation
configuration works well.

Vsc73xx have auto MDI-X disabled by default in forced mode. This commit
enables it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/phy/vitesse.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 897b979ec03c..19b7bf189be5 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -60,6 +60,11 @@
 /* Vitesse Extended Page Access Register */
 #define MII_VSC82X4_EXT_PAGE_ACCESS	0x1f
 
+/* VSC73XX PHY_BYPASS_CTRL register*/
+#define MII_VSC73XX_PHY_BYPASS_CTRL		MII_DCOUNTER
+#define MII_PBC_FORCED_SPEED_AUTO_MDIX_DIS	BIT(7)
+#define MII_VSC73XX_PBC_AUTO_NP_EXCHANGE_DIS	BIT(1)
+
 /* Vitesse VSC8601 Extended PHY Control Register 1 */
 #define MII_VSC8601_EPHY_CTL		0x17
 #define MII_VSC8601_EPHY_CTL_RGMII_SKEW	(1 << 8)
@@ -239,12 +244,20 @@ static int vsc739x_config_init(struct phy_device *phydev)
 
 static int vsc73xx_config_aneg(struct phy_device *phydev)
 {
-	/* The VSC73xx switches does not like to be instructed to
-	 * do autonegotiation in any way, it prefers that you just go
-	 * with the power-on/reset defaults. Writing some registers will
-	 * just make autonegotiation permanently fail.
-	 */
-	return 0;
+	int ret;
+
+	/* Enable Auto MDI-X in forced 10/100 mode */
+	if (phydev->autoneg != AUTONEG_ENABLE && phydev->speed <= SPEED_100) {
+		ret = genphy_setup_forced(phydev);
+
+		if (ret < 0) /* error */
+			return ret;
+
+		return phy_clear_bits(phydev, MII_VSC73XX_PHY_BYPASS_CTRL,
+				      MII_PBC_FORCED_SPEED_AUTO_MDIX_DIS);
+	}
+
+	return genphy_config_aneg(phydev);
 }
 
 /* This adds a skew for both TX and RX clocks, so the skew should only be
-- 
2.34.1


