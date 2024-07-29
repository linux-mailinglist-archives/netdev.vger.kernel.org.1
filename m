Return-Path: <netdev+bounces-113816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA92694001A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182E91C22140
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1218FDDF;
	Mon, 29 Jul 2024 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTSoyyoB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680918D4B0;
	Mon, 29 Jul 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287201; cv=none; b=ofldWotuLrFn4G6kT74/AmXFT7witUyu1kZaTyYiUK47ua+4IjUirzbfwkYFuZjzazU3pzPBygbspD3dzRxNfYbe2uJdG6UDS+R+rVXUucjjIWhqi/lbuIwjAajoOU+ShL8v/DMy3UGVvgkLxucBV6JVpRr/o6+ZWAjcYHYwaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287201; c=relaxed/simple;
	bh=F5NZxDnweHdu6at7fyQq2LLAHVE4BsU9fZw3/kQA2KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GRge061iMHGdiow8EXizPZ3YT+yQ5yJ9UY3/a85hfhWwzyU2Imv7CIUcMqWN77XnS2BS3AJnNtnpzn9YC03yMXDmMgJyiICa7JCy/L1VmMLVTh/vMslzh1/skgQg8yIiHHOJTefR5GtLkt8F0cbK76ovG2bsBSqpHEtXlzrebDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTSoyyoB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ef95ec938so4720769e87.3;
        Mon, 29 Jul 2024 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287197; x=1722891997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUH0bFr3P3XDMrBpdmW5Yx5nikStsLn0wPrng5g2mmI=;
        b=lTSoyyoB0c+h+734y+WPcdwlheGC7nU10NfWskXBlw224KSeV2rS8cOrs3QtudjiVh
         hnOA9dB/meA92ibAttvSmikRDIcCDLjf8OVvWOYJnILTnOwUEz//VQXH6tSyJRuuh6J+
         Rj4gfi8lyqdD9lN/FYxXxd9WkXBEFXJ1A1zIeGRAg30pKD83AKFkLH0rI4ZspHC5f+8z
         T7i4PN3K1IPrc76JqeRCsU+I9RnFHWb3I2L3e7zkDM4+VDc7iLgo+TFvfN+ZdL2guwbC
         lVFpf0vOaQSqGLd/CYolv1ED+a9r4UjO9bQ0ip9LFPxe5JNA7C/GobIIdLFhnZYGll80
         ItQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287197; x=1722891997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUH0bFr3P3XDMrBpdmW5Yx5nikStsLn0wPrng5g2mmI=;
        b=i/DnuyBHTkKelreLprKvCvOoAdO6fw1jbOxp3eVMpY61U72+na75pq+bweFgRDYK14
         ddcTpGkwYLX8fdMXpx3uDGQzrSb61wltjVR3SC2qU7Y9X69ICHf5RadNWD4XX/azf3eF
         iegiSEQyy5eMVsTKqkXUa6Y23UKuf1ic17O1zwuUjozDahIJ9ZRz8laev5EvyN+l3j68
         QOjlgJ+QtCJTIypeo976uqy7Eju9ip+6O91/RYI80Q57iMiGjKMOm1SnsLrsmaa94h3E
         8Z8AG6Rn1BwScJp2ey4L8yMrQg2PChxL19sEb8SMSrz2Jpa3qd2O9l0a3sMHBdfC4LxR
         XOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkxgJV8eU8KqhaEmPUp1tPTpn6/rrjzq8TbJ+QKWBJGy2ULQ/afUNeOkCFHYAGVBrlNgrmsNEIkDmsBx+RpeNHRqfF7vETpXnh3Q9D
X-Gm-Message-State: AOJu0Yy9rTp/VQJfW9BqNr9nDQD9NYTtPnWuu75GkM1EBHIbgHmm/LsW
	dIcvI2Vd76WZgnGpaulwTtwKi4ttHgg0Uzz88INnUxFXy6b8WaWteBlaIO0Q
X-Google-Smtp-Source: AGHT+IFxxpsoquWZA4AZabFN6Fh0mTPqwOp2t+ejCtqRU10M0v7Pf85E9gZR9bYJr0VYk06p+T7OOw==
X-Received: by 2002:ac2:4d89:0:b0:52c:8a37:6cf4 with SMTP id 2adb3069b0e04-5309b26b4a4mr5166755e87.14.1722287196847;
        Mon, 29 Jul 2024 14:06:36 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:36 -0700 (PDT)
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 8/9] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Mon, 29 Jul 2024 23:06:14 +0200
Message-Id: <20240729210615.279952-9-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729210615.279952-1-paweldembicki@gmail.com>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
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


