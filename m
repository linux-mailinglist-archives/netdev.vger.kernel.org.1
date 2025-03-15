Return-Path: <netdev+bounces-175063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6EBA62F7A
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0F67AC52E
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA52063FE;
	Sat, 15 Mar 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsvLPhx0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2629205E0F;
	Sat, 15 Mar 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053491; cv=none; b=WhD9fV1M97aDNNmdUv2ZykO1wrwHqBJRlM4dPOq52ZQho79wOSuYkWRMR3elfz8QWJis4BMWZWq+Vas3lPaMhIeIS5HF1qQGG9HXJlq8o60IAJshuzo37Ld3xF2MVyKw+nluyron5qpOcLQSNLAtyi++iLQnKppazrxO8L5ZnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053491; c=relaxed/simple;
	bh=e/J9AFAnHogYRe/iJlrSPwXbA3k0hVtFkeaCTXItC3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J62DJ3kqgGGVFVWJ2ssKQLpJCRsGK76FQvzz4Mx5ABYNmfpkOGiE1N5h2Ckhlk1EBy/5+5mcZAYfDc00JqVAZvVk4B0XB+iH7uCUILBWSTQH8bT40FkrytsXi2I5tqH/5C/RwrUbq+EgRIMfiYPWcN1KXXWL6QJP9LGve2COp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsvLPhx0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43690d4605dso4543605e9.0;
        Sat, 15 Mar 2025 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053488; x=1742658288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEeHqPbidnUgfl04t+LLdBVbgy41Di7XU1dGgXeGDSo=;
        b=bsvLPhx0Y1XJt5ltsNZ8B2bQV68yt6L55g0CdrGPW1dNGhWawd85SmgIiscvfCO1NR
         WMSNsYQnbXUS7yqjBr4xAB674WhC1mwAfWVy7fgOMGmT8gSvV74Abw0xU3+cMH6pol3M
         1Gpvdpf8ellDEXOFjSvTCeVGbjIHL7r1U/Lh93/+d06dwBb7KR+5c977SVQqD+2AY3j7
         +J+rYr/OLm9XfL+9ws/fkrK2cbo6GdRVxpBWF5OnjiNPev6UN16oXHN/tqqeawDzOjgf
         rauCjxYc/YxiQi1lkWdcYvIRtFuCZGaS8cunMVQpnuHsAEg9qEcv6tCoe7vv0qTYCisb
         P8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053488; x=1742658288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEeHqPbidnUgfl04t+LLdBVbgy41Di7XU1dGgXeGDSo=;
        b=PcObTmFUR5OSHxZuoi71nSpYdSgLILTV1zJXWA19skjsJrpB9FUv5cOdDzu7Urld9O
         IyXhi4igKoqbZDXX1uKscrkFJPNSv5oPQTkl37NBBWW8vY5zVvQTm+jU+8Rh2coWGtrL
         8ii71hpeJC6aM7XH3gQ3UMRnD4GGGAGrliElkvg+X07+L7XUE17Z76KTxCmrCz6Z3lZC
         5e8cE+3sDeC73/H+JgxHjVQ4NFreTzVJuhRvXipmChGeZKVHdA6y1Y7DAnCr7qm9zzT6
         SyyJW9uKvwYEJPWgiKTdeFWL58ny635m29hIAwuX2sPYHw9Z/GU32oVlHWqv7YwF87YH
         iA1A==
X-Forwarded-Encrypted: i=1; AJvYcCUHhtOhIq3nZiUPX6AhZ74gTtBszAiezIRbvKr/WtA9pyJn+pmupBiFe5CKuygLt1NP07gVSTZFCUYrhOZf@vger.kernel.org, AJvYcCWNlE84Je383q7pgk+c/aEn2puJP2V10Aj7IwCuHtpLjoM7mCqWCRxHOFpRCAN2huks4W+Xu85u@vger.kernel.org, AJvYcCXq0/JHHA1RNcRJQJsUfZFfdogxLIXZR33BK+lVbJ2+LWtQwF7JR3z8BAJ3eeGkuxbTOVBBo6DCw2D3@vger.kernel.org
X-Gm-Message-State: AOJu0YxpY+erOcX9Q3MNzJljrdqR+aEgFIhE06Mby+KGGMzRlyDBYvIJ
	bkjHUJ3Ohntf3OW+A3BsghtZe2X2KHWuPalORijSiCj8FrjXf+db
X-Gm-Gg: ASbGnctCfNS2zr2K1TtQLwIDpalUabf+PMLB79nG+NZS7uiatvzCU8vXzjsxniKF985
	Ux2kLF7ICaBAA3zzm7ZM9aykkdZFpsql3iiZ0QBOxYYvxB8CkbLanMFDr3KBYc1HuXqi3qZ2lgg
	LMZmzDwDN0WofP61+Z+xyGp0tg/GwcCqzLEWZUWAIX0YLLQmysz/k3toCf+D1LJIBWKybxOD32v
	lZ1ubLYQMyGw4ZDc477fyymK7Ixv92UnHbf78YfKmk/W/dTy1dZ/bzikyp9zmY48EQIEQUNYqEF
	rKpHusiz4nOVfVzmChaiyfXSUxChfzeZLrRsMTj3j1PLM1bKp2FPzzKHfzo1lHauqZfIlMrW2GV
	XbWbg5L71pscP5g==
X-Google-Smtp-Source: AGHT+IGir5EjbBHxfMQYrp8pkd06ZMtYDcN3X2GtiQlfMspqlPbumHAhw6bjrr+M4eP0wyzj84nKQg==
X-Received: by 2002:a05:600c:4fd3:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-43d1ec9071amr88893115e9.5.1742053488011;
        Sat, 15 Mar 2025 08:44:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v13 06/14] net: mdio: regmap: prepare support for multiple valid addr
Date: Sat, 15 Mar 2025 16:43:46 +0100
Message-ID: <20250315154407.26304-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315154407.26304-1-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
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


