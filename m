Return-Path: <netdev+bounces-175066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227FA62F83
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D9D3BD841
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D5B207A0F;
	Sat, 15 Mar 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNtb/x/9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A35207669;
	Sat, 15 Mar 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053496; cv=none; b=NdWo6reGuY8WzxFftx42ZjrKmRFtjqlIr1m7QeMsg3HRFF+/u3N44ms198IzBav3M0IdimmYrsf4ZAlNqdEch9kO/ZUsiYNNpPXHfXO43mlroQLtZ4/aeVUhsIWZOyGywP5djLq1P7DrOVL6ahVCSLTeC2oRB89qMuTajOrX7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053496; c=relaxed/simple;
	bh=ySqujHFR96IIBQhdaLRLxccLZuHkD84IWUQvUJGbBjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyI4u08zJkEVhiIPX/DCxs7zVaGlbYECJ6IqbzHINS3xDJN6xS9ZJ9WasOxtwSquxljGiT7VnUTHSJ5SkiGGU+j2NGr1WFAHTCGgS9VPN+KaWQlmmoQGChMjzQ+d5Mt8CvKz83UM5Vup/11KXjwFlaeOYK1JruaazUi19WPRt+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNtb/x/9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so3460635e9.3;
        Sat, 15 Mar 2025 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053493; x=1742658293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHfS9Ayq+62ZEPKyiIIGlUUpg7PHKrYF5eIEp4kJv8I=;
        b=dNtb/x/95xrb35MzZjyxNEQ8FCqPIzU2Ls7tGPreQOLnPR6MuZC87RdHlVq2qoW9Gc
         OZ652ONtJ11VwF/CMtSJZf7JHudBRjlT287KixQ7BrYjQfYbbNRKhVEe/GSG44zaI//4
         Z9Qcy/32XgUrlKxYnSePWFA/GsuH4hph3u9t93Rb/vbUbLQYzcES/9wjdcaDb3vJ+XDq
         hUh/+SH5FKgX8hB+vXDnFkuIyAYh7ngHENo+dhnuepKn4fK0Hf/k+EJhB+sI6KHPlAg/
         E/VMdEAY2UW3x8P29CENu1h/4e4toZg9CX92S6su9t3fuuT5PXpn1g2fPBotHnIodMGH
         qKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053493; x=1742658293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHfS9Ayq+62ZEPKyiIIGlUUpg7PHKrYF5eIEp4kJv8I=;
        b=DCnHICXbkv02I3o41ytWvxdZ89Q5bp4BJkeYlkLecWfCu378csN1a0iFKU4OKk45Sc
         vIzZtEGmwrEWgDunSzty+pqUGFk6YNkwxuxtFq6GBRrQGGel9T4Th6xP+KwbP8b+CYWr
         HMnhPkKeNTx9f5R0QDXlzh5goyh7G81vE0wKSkXzAieWomWW/COvWBjTxjWxHqJX0s8k
         ZYvq18Pyx7SlIdySxkImoGFOxARRGvkOu3RgjE42OJpRo7FAFtgkPeERAo9m8zYSud0V
         D4B8OpNT0cEG3wGt0YszypBTLNr+rmUBIv9D3jPNseQXrXD/bG6jGOSYPdOJ7Zpr1tG0
         CROA==
X-Forwarded-Encrypted: i=1; AJvYcCUjxI2qTlBktq9nfWNEiDaaSY2E9jrKYFiuyKGMW0wvOqSCWGYw24mOiNjealubZrPrGopfTYKuqKgf@vger.kernel.org, AJvYcCVcqcN7X9zT71tZDJxFvYDLcuxYX/M3AuI9pxMKa5J+7ryDFSS9nUYJD1lydEbs8x9Sv0d/DTWt@vger.kernel.org, AJvYcCXjl+te+4GWi/Lq4LLnbVzUxnFJk36+z9TItm0T6Yep8AEGFU8akE/wgERplB1dPZJW5+kXVG2RsI4iid1p@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfwx8FNU8yZACg5RlsyTb/EiN3L3F4KbEmsl70rZvDXH8meVgR
	bAr4k+Eq9jk3+XM2ajG8Tpffx+/bJQC8V6NWZvyq2fu4PhcOpTtM
X-Gm-Gg: ASbGncvmm5q8hj1c0oFQnULVMTW9pF6rO6oDKaLdAgvE5ORd7SJHilhWKyfOdh7FAGC
	4ztF2evSPKE0W20H79csAmzcSXIDB2r69bM+XrhGoSmWKsbu78d5AyugICvN1CVppcuXoepRkMS
	n1dORlqXGs2l6VHA+q46dhTdTigjcdzxzhUtulc1GJDNaL++nM/XxmK7BLsfhHnp/ppuSkfxJWd
	NBM1wm7LmogKYD0jTQYdy/f8QH1J3w6m2im1c7FB8r6oAOMOgESaefMIz7IU8FHGnsxpO62TCke
	NbL9QBEIOaoNmu/U7Yv05dduG0dxlCv2zxGmSyzfVumJQaDynsBC6Mn21ed1YCnjZZW1vucDPjk
	YNC1GEqIJkNRJCg==
X-Google-Smtp-Source: AGHT+IGeR0GlB6V/S9Dn/s5gMh0ja71UFOJhw5HL2cIq3odbRefg3sGJoJMZ8zyrbhiVe+3weElnTg==
X-Received: by 2002:a05:600c:1548:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-43d2a2ececcmr8971025e9.5.1742053493214;
        Sat, 15 Mar 2025 08:44:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:52 -0700 (PDT)
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
Subject: [net-next PATCH v13 09/14] net: mdio: regmap: add OF support
Date: Sat, 15 Mar 2025 16:43:49 +0100
Message-ID: <20250315154407.26304-10-ansuelsmth@gmail.com>
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

Permit to pass a device tree node to mdio regmap config and use
the OF variant of mdiobus_register.

This is done to autoprobe PHY defined in device tree as the current
mdiobus_register only permits probing PHY using the MDIO mask value.

Previous implementation is not changed as of_mdiobus_register fallback
to mdiobus_register if the passed device tree pointer is NULL.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-regmap.c   | 2 +-
 include/linux/mdio/mdio-regmap.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index ed0443eb039f..8e89068c844d 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -143,7 +143,7 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	else
 		mii->phy_mask = ~0;
 
-	rc = devm_mdiobus_register(dev, mii);
+	rc = devm_of_mdiobus_register(dev, mii, config->np);
 	if (rc) {
 		dev_err(config->parent, "Cannot register MDIO bus![%s] (%d)\n", mii->id, rc);
 		return ERR_PTR(rc);
diff --git a/include/linux/mdio/mdio-regmap.h b/include/linux/mdio/mdio-regmap.h
index bb0e7dc9c0dc..228f12e90750 100644
--- a/include/linux/mdio/mdio-regmap.h
+++ b/include/linux/mdio/mdio-regmap.h
@@ -14,6 +14,7 @@ struct regmap;
 
 struct mdio_regmap_config {
 	struct device *parent;
+	struct device_node *np;
 	struct regmap *regmap;
 	char name[MII_BUS_ID_SIZE];
 	u8 valid_addr;
-- 
2.48.1


