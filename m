Return-Path: <netdev+bounces-196076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3CDAD371A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A4217782E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C32BFC9D;
	Tue, 10 Jun 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ULbB1EY1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42872BEC58
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559089; cv=none; b=eYvZKOQyMy/CPhbbA0kDe9YwiP1iLfRN8Xu52txIUkQXCb/niEh/+zAhpPnMWQ5Wbpzdx9D2NfdJvYyj6aEC9hRaDxAiuntaeTHmtQNl4SuQDs7DlX3uc8nIXNT/HZRrtAIxXX8lKg1KLyE2oitobLME3c9ymcvkykc38xINAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559089; c=relaxed/simple;
	bh=GvgMWLo3v09W5wB7l9cl0mqQY3DSJ1MedVvejheMqM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkYiv7/k2DfMvYe6/VbWKZh2qBwoD8L1vAWGn+0BicWKkl/yrf4FTnI/Yw3EaJh7vS1Hh0JCN68cYtExw2l52DJmNi0utWe/fHJq14HJzkhlOjeOTYisLXJZahY4jd1XYcc9xp197UY7Ew3EGrCPK765EO1mBuik7I3mqOFwl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ULbB1EY1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so29173175e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749559085; x=1750163885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTr0inICqzQ40JhWVH9IpfJkMwVhTdLoWQ78V1Jjb84=;
        b=ULbB1EY1UY1YUJqE2VUQQ6mPaNt33ilLpGKfO7C5BVhV/P/A1BTq5LqaFYihLJXo2s
         8Ab6qP4uZFN1puLhIUesqMkjluzpl1LFlyBQ0KxL8RX/HoMqTFSdQ0Kpt+lELZOunCHS
         +910ApCOo8pKWEF1yT/MKjuh/+MdCH4eu3uBam7q9Z5Ap9ajakR+f0X9k1cBSCdyOUuh
         NK6XqX7GxZtfnL0o7mGJzbeoQxwQTiOUijOW07c8AeDfEZm3nMl8/ejn05ni5rR5NjOk
         7tb/50EAhqh39HhtXPZQcySDGw6BvXnbwDgDM6Ix6gkNJQh4AhNmmm4WAUngdddyWdPZ
         bmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749559085; x=1750163885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTr0inICqzQ40JhWVH9IpfJkMwVhTdLoWQ78V1Jjb84=;
        b=U85QvCWMX9WeTqphd65xAG/YDv1EpbN6Sa1/MJhGCCn+gasVkKATMhkBPrZakfNde+
         kDKTLZTA7RBdBeB9NPqHKCOVF7Qp8wOcdoeSrpW1eNyB15ST76QG2RAB4yvS/saLWmr6
         TjxIr4o4ffaawZGX5tV+tl+NELq73BgDnmFXTjZ7L7WMFPG3dTVcLFebuPqJFxvK4eme
         bRPoqMgB7LrJ/t/U26nLlt/7g1fEfHgGpjTyZgRP/aowc2WL6VXPMcEbqa86GGKpDEe4
         wR/QVjTycBTsiqPyOB3gAT+D3qfeXDXposZBLMBOuzxkKggqS3mdIeSWOu1rUzlIeLzj
         fegg==
X-Gm-Message-State: AOJu0YzKcMaSrk9j+3oRq4P2iwJYon+ztPmdztRUSjwPS+Qcj10PbAmp
	ZxWzTpVWqKcHCQP9VeAh0EZclKEr0+VQ7FupLt+fPddJaKTjrCd6zBZo8dSSKS8R6UI=
X-Gm-Gg: ASbGncsiKBL7P9O1aHfg3ffHRhWSjhbj8sxAIginjcPM4fz7OfcVvdBQcJERh/SdBsQ
	UapmH3rJrk0nj21cOkKYJkPpJEBLZB9yQSLaukrW5944OKSNBhjHshrlGUg0uyr1tIa9dMIevTy
	pvM1TaG2a184hzdR7XRTEJNW/0+FWNbWTwN34SRPDhdxp4AvcKSLIxKcorVmJxBF5hJ7y+NK5oM
	PMa9tYzw+nt3koXnSl/GgHPpkjL0EiqmRZwVHEhqfM6nQCerRwvlw62PPWBAST6Wdr5oh1AdWr8
	1hXknlMqvyMEvlg55n3e0RAGmRXZ0exuo2WRf7CrvYoTJX0UMzJScrfs0wCW/isJ
X-Google-Smtp-Source: AGHT+IHzFp5JvTZ7l1OpOejBOEwCS7yH077Wpi4SDtJY3ulJlf0B+102s2G4CnPyWgM17PCQBMBlxQ==
X-Received: by 2002:a05:600c:3ba6:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-4531d00c453mr31747955e9.16.1749559084818;
        Tue, 10 Jun 2025 05:38:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4d:e52b:812d:eb7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213759fb2sm142476805e9.38.2025.06.10.05.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:38:04 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 14:38:00 +0200
Subject: [PATCH 4/4] net: phy: qca807x: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-gpiochip-set-rv-net-v1-4-35668dd1c76f@linaro.org>
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
In-Reply-To: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=MAnjKHaMoYF5O3f5BcIOHcEhF8AXjM+PNGzo8Pp9cg8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoSCcnC1sEIoktf6UHY2MqMzPGNw9DXFVujb7Kq
 dZR+XEf6QGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaEgnJwAKCRARpy6gFHHX
 csmrD/99f0lIH+W3DfmoJQoGq0LOeqm5buMf8Ch/sw2VizC+NzZBIJnfGPUt6/dMjtzjqFKZdUb
 PqOQGMYAyle/pWuVoS4rqbX6Y6Ct8op5TOVgYw9OJ+Vm2+tpdkJ9O0RGKgPLqidx7WxmDle7eCD
 Ce0FNDGVTnCvEjLlAbUVrnLvH5xp4/5cyi3oDa8DofuWMhbtpowOpcSUHjjAYgn8/lqKl0yz7NK
 g4+uyOJHPYWep1Kr/L1SrDH9reI0B4lnK0N4qyTTJJ1df0JoWw8ZludlKXfa08juZk3BWprkwLT
 Gsri56yEFWJrig1ad/dfL2ME7p4cayZQ2InlJ2uWZbiGhGJwe5XoNfi2bCo45uqO+1F7Nnp8KAA
 3Zjr61t3T6+FauqS5RAzKMjnBDsccpotbDB0oBQjUG1EdBgC8TvAxyy56FujRh8nkIBU1WpJLrz
 TfBdZ+mmrfbnvrNsiz/KAq7yaVOLRltW1nefhvGjP09tnqCEe0vQCK1ENpBKhTb8QoFG7b0x+xt
 AyD2DICy5a6mUUWRrlXQAVlnS2BJ+f8s8pHm+EWr5f52gyithh1/FwFo3LJfiDJtEbzo6+XAer7
 wnx7GBla5W1pPXIf9AI9UPcP0lHc6ECfA8NLILvEcgdNI1UdotkBPEEyG5PhsMMgZa+INZbIV7j
 Sm+SNOSFlvaCYpA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/qcom/qca807x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 1af6b5ead74bf615ad155e396b0ecc6fe5636e8c..bc480710c2bd27d621dad3b5595f0a292a4c72c1 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -377,7 +377,7 @@ static int qca807x_gpio_get(struct gpio_chip *gc, unsigned int offset)
 	return FIELD_GET(QCA807X_GPIO_FORCE_MODE_MASK, val);
 }
 
-static void qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+static int qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
 	u16 reg;
@@ -390,14 +390,12 @@ static void qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int valu
 	val |= QCA807X_GPIO_FORCE_EN;
 	val |= FIELD_PREP(QCA807X_GPIO_FORCE_MODE_MASK, value);
 
-	phy_write_mmd(priv->phy, MDIO_MMD_AN, reg, val);
+	return phy_write_mmd(priv->phy, MDIO_MMD_AN, reg, val);
 }
 
 static int qca807x_gpio_dir_out(struct gpio_chip *gc, unsigned int offset, int value)
 {
-	qca807x_gpio_set(gc, offset, value);
-
-	return 0;
+	return qca807x_gpio_set(gc, offset, value);
 }
 
 static int qca807x_gpio(struct phy_device *phydev)
@@ -425,7 +423,7 @@ static int qca807x_gpio(struct phy_device *phydev)
 	gc->get_direction = qca807x_gpio_get_direction;
 	gc->direction_output = qca807x_gpio_dir_out;
 	gc->get = qca807x_gpio_get;
-	gc->set = qca807x_gpio_set;
+	gc->set_rv = qca807x_gpio_set;
 
 	return devm_gpiochip_add_data(dev, gc, priv);
 }

-- 
2.48.1


