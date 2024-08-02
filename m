Return-Path: <netdev+bounces-115247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F8945980
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8961C23A4D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A541C4605;
	Fri,  2 Aug 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6QVwv3D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE991C3F0B;
	Fri,  2 Aug 2024 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585875; cv=none; b=kN1ii1c2F75I2bRyIg1FLfT/xJtr6s3aUKyJo3spBCkP/S2+HzbVYbWRR2McSiZ9lPfUQcH/URqAJ/kfM9Gh1aSA4nYvoOhGEiLZU65CWeBSmRvQm3fJicUvrH+wleOIkFkpboBi8dK4jtaPZmS8fh71/VyPvmbKh0Fd3wsCEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585875; c=relaxed/simple;
	bh=wJ8CKjo99FdygF4Dyf6T71+jLKBvtf5FYO+XPBN2Cv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GguPqw2WCi1ToSnavfJlUVB/QhY5/niq7OP5A8hJLZtRCo3nXQyCk3GPY8uEgCft+qZCrwfwnry2AIOiakgZfgemKVA6FN+4kpaxU2Yevh2uJS0wBe/vyRrXVltWx1GM8JJyWqr5I+PXVGKJhkwQdJ5u1WtTYuAVAFTvHZ6ZBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6QVwv3D; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efdf02d13so13006826e87.2;
        Fri, 02 Aug 2024 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585872; x=1723190672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCR2a8QUcsGwPUUS/KFvb11t9ihPQhvH+olYLUnMnJk=;
        b=g6QVwv3DM2HHi1LwY1NptWNkmIVyJg/m7ZwsiNyFGaXV5DCySkYtBOO9Ze6dAShmMs
         /gSFrI7pUJZMsjgGM/L2xYhkJCdrFJk6S0CJFznMBIZL3K4Z3Bty8mn6WEh6ivvH/qqO
         rp2CSaRDiPLTJZwOVrLru3pw0NzKq7E4RagNXmaotYvjNLsluxtZpaNg4R0wIM29VE7j
         7dsTW/D1gPjB1YmYme9HXYgRGmc38NuE47bcf6XLMrn6j+PQTPmQ48WqedV7427JPJpV
         ltumsMVNqjmTiPrnSUzEejGsB4XYFx+TihtqMSIVJG1XWfYqZ+Ro/vGFYqwtubrragL2
         RMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585872; x=1723190672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCR2a8QUcsGwPUUS/KFvb11t9ihPQhvH+olYLUnMnJk=;
        b=mQpxsdEuhupubcTaK2yJcQDyaUEy3KwEZV9y+cHJjK5E17Rim6r1KYf9Ce8iOaSbyb
         58KLlrhruuNcYHeHYiMPVs1KtGVD9bhDo1+gwm2am7QY8cUvwqKWjTK0xccpTHMzBxpo
         wIVc5SUIAQVE3Q1V7jXP3DSovSQRYAa0jw2zk7dzjcnQ/0DdoTe/41LgOOHIU5Ma9dGq
         vLkcUdxnstpDHrlqp2ocM3pmcgi/nTBFXGbNHHis5j9mC46WP7NJNvdRMNgzu0DWyqG+
         K4Vn3A1tnyxBtGAWDI3JBzY5WnDsva64O4J9QcxU7VM3RjOKWfy4E8ngiSQ6/ROd6twp
         p5eA==
X-Forwarded-Encrypted: i=1; AJvYcCVNHbd1u6VmW93B3v/h+8B+77H8s1XPoRxADeft73snfHyg30Nwyr7edzcedkIV5Nhyr+6mFBuHPJ6FBmoGJQ2vQg91vjn1ff+z/wJr
X-Gm-Message-State: AOJu0Yy4WJ8eCKSSDnKO3TZOrFwu9d2GFWvpYNr3azjba07HmHR9wlUK
	jvAukfuS4J0K4CSaESESHD82C2GiAD34cc1tOo6IIuwAo1H2m6m8jGv9r07L
X-Google-Smtp-Source: AGHT+IFItHcRt/6EbjbqS01vh8MV12Glv+W1faYnKk4teDVR+zPHWe8r7SH/K9qlSdh2kEheHIWH7A==
X-Received: by 2002:a05:6512:39d2:b0:52c:e091:66e4 with SMTP id 2adb3069b0e04-530bb3b461cmr2379189e87.44.1722585871529;
        Fri, 02 Aug 2024 01:04:31 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e46sm163281e87.32.2024.08.02.01.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:04:31 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 6/6] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Fri,  2 Aug 2024 10:04:03 +0200
Message-Id: <20240802080403.739509-7-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802080403.739509-1-paweldembicki@gmail.com>
References: <20240802080403.739509-1-paweldembicki@gmail.com>
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


