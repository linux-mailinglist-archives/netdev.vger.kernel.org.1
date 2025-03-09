Return-Path: <netdev+bounces-173337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45C8A58627
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513817A2DB8
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913120296B;
	Sun,  9 Mar 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFccgbBc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B01F8751;
	Sun,  9 Mar 2025 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541281; cv=none; b=U1eS3RnpUDHNu178DxEZY1YVOforNHWYGkJnwYxDFfSatv890fOzoLen0gRax8wV5dOIT1i0l5fBr/R96PqvBBGIRT2ZYsQamVni5S5yGqmSQEG1ugK1k58r1RMnGmp3D7/gSJ4wJYt3UlXjn4vjgSiwni93F3lxNd24s3giaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541281; c=relaxed/simple;
	bh=e/J9AFAnHogYRe/iJlrSPwXbA3k0hVtFkeaCTXItC3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUuigpvLg8Sc/z7Y3LyYF7uIfwcP48npwvV1O7FGS/yIBE5LAGPTd7D/f/g8A5qSisFfvcEoaUg+31TTJhd4HGj2wOWPnDRUrORySz6aKC/1POA9cchX0JxgpSXyiDNUlU14/jJH5DmIu1sp3cfLazf13Y0k2Zes++Na7/11wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFccgbBc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39127512371so1890501f8f.0;
        Sun, 09 Mar 2025 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541278; x=1742146078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEeHqPbidnUgfl04t+LLdBVbgy41Di7XU1dGgXeGDSo=;
        b=OFccgbBct1yNFleKy4UyyVY/7JFZxK5rGTkiFRujN11rKinQ5md1SpZUXV325X98Ml
         q5UMg8zT486jWg8aJzTwa6RSIpNWPozGkaCnVOmzlenQ7EAWW50zagQE3iLQU2kGM4wH
         JhvUBSTIhEyuvKkL1dBUXLqVY313sntbpopS28Ypis0cNLD32h9xlKDnuwX0qFWnw1GV
         r9rDJOuAjzO3imCeLU4gP0tonGSpZLyxPStJbusdfsAq7OH9Ay68kCZU3ENP7e2tcDjv
         xR0cN6/LaRaX0OJLxm+1REwizSFIyco0iuAX4Jbi8dOGXCTxs5vPHV5h6T+3KcNElasI
         51TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541278; x=1742146078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEeHqPbidnUgfl04t+LLdBVbgy41Di7XU1dGgXeGDSo=;
        b=uEqWY4zGl3e1VuCOrHfiXf8wbbRV7L5xM3w9xIfimTrplwet/BGTgRgwhzJznnROu6
         DS3bnFh9he4+E1odio08+s8XJMR80XSUWJRJn4gWBIB9mBwYh3iloiJmVD2RaZDGnEtJ
         EJLtljfU+9VxjXT8aDWT/MD0tBcHMrHdKKnosxYehuKGd0j0AJFEmwMdVTz1FbTDJIqK
         1D/nQsLNSCHAOEyeHa5Ssg9pHGfhuABNtIKsANyqabR7sgxzv7bSo3F6voOyZL77+j4C
         JSZr0js1i0DQY9fRNTNu2XspFg3AnQa/KWLI2KZ0wEdBMinUKn8cj6Yec6ODoAxrG4Dy
         b6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVoh/BHRNMfMZuRjkwX87k7IO0EzR+7uY5UoBNiQKp73g2v6jR8MqTu9hogDFV9DP8qDiaFpn4H43oP55AP@vger.kernel.org, AJvYcCXPseSVf6yI5Aamtnv9BXPUHjFkRpWzJTk5tHM6ZrzRB+jZLd8Uh9nXT1FTB7i6T+hppKcfcGNN@vger.kernel.org, AJvYcCXhucXpkPHu2xK1RFF8YMHsG+cudyJE9RBi9jRyTQsiNHOHtIkRNiT8YphO2tAz+5BzaEqViiXyKZqY@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxCupOWZFX4dc4fwPWQItfmG73cwTQhF61vJfhpDvQuDMFyjM
	ymrbUa7DkywhxA0DhRpidoDW/8hCi5sJJK5QxS7Df1TCg0w2BZjW
X-Gm-Gg: ASbGncudlG9EORiAhKBXG5PDsx3S2BtSLtmRB0B0cvqZgFmlFqscSrQZxoMLgYpy1G2
	EwUDC5vJ5wyl5usRFy5zQy6X25O1CpvPHBnCFkixyjKckHGzDetZejqHgsh3nkaqALjQjDCbf/1
	qJR0w1YiJmD7uINLSU967O3+zhf4mFuOUStzRiPsf6oRaNr0/7/Z0M6xKYgYfDL6FrTdZfgQ6Xr
	KRK6Jpn14wt5nvgTeBEW1weUHm3FBLdSqQZx9yqh9n0IFlq8t8QSCNgIKyDHXXvcjBrCU7cfJLb
	j20kPMtNErlZzRNhjudxF81r4GIdOP/WcInj+yj8fvBOXkYfYm2bVfroi9/P/2OeykPWKxtbGfS
	JHbOqXg/Sc91hSA==
X-Google-Smtp-Source: AGHT+IHPyf+ITAt4IdXJ3Q7OJg+5A4g84Iy8+W1S3hiTKecvKmr5XziE6pPQBfmvhL3NRlALNMbDDg==
X-Received: by 2002:a5d:648f:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39132dd6934mr7733020f8f.43.1741541278531;
        Sun, 09 Mar 2025 10:27:58 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:27:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v12 06/13] net: mdio: regmap: prepare support for multiple valid addr
Date: Sun,  9 Mar 2025 18:26:51 +0100
Message-ID: <20250309172717.9067-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309172717.9067-1-ansuelsmth@gmail.com>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the valid_addr and convert it to a mask in preparation for mdio
regmap to support multiple valid addr in the case the regmap can support
it.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-regmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index 8a742a8d6387..810ba0a736f0 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -19,7 +19,7 @@
 
 struct mdio_regmap_priv {
 	struct regmap *regmap;
-	u8 valid_addr;
+	u32 valid_addr_mask;
 };
 
 static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
@@ -28,7 +28,7 @@ static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
 	unsigned int val;
 	int ret;
 
-	if (ctx->valid_addr != addr)
+	if (!(ctx->valid_addr_mask & BIT(addr)))
 		return -ENODEV;
 
 	ret = regmap_read(ctx->regmap, regnum, &val);
@@ -43,7 +43,7 @@ static int mdio_regmap_write_c22(struct mii_bus *bus, int addr, int regnum,
 {
 	struct mdio_regmap_priv *ctx = bus->priv;
 
-	if (ctx->valid_addr != addr)
+	if (!(ctx->valid_addr_mask & BIT(addr)))
 		return -ENODEV;
 
 	return regmap_write(ctx->regmap, regnum, val);
@@ -65,7 +65,7 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 
 	mr = mii->priv;
 	mr->regmap = config->regmap;
-	mr->valid_addr = config->valid_addr;
+	mr->valid_addr_mask = BIT(config->valid_addr);
 
 	mii->name = DRV_NAME;
 	strscpy(mii->id, config->name, MII_BUS_ID_SIZE);
@@ -74,7 +74,7 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	mii->write = mdio_regmap_write_c22;
 
 	if (config->autoscan)
-		mii->phy_mask = ~BIT(config->valid_addr);
+		mii->phy_mask = ~mr->valid_addr_mask;
 	else
 		mii->phy_mask = ~0;
 
-- 
2.48.1


