Return-Path: <netdev+bounces-168042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48852A3D2D4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EEB189B80A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5BE1EA7F1;
	Thu, 20 Feb 2025 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwVIQ8DC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C61E9B15;
	Thu, 20 Feb 2025 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039086; cv=none; b=i0tCIlyzmFVvNdrOnMeeE6moawcXoiasordUEovwrRL1evxPvDWo667lAJbcDnWJZojkJH/rRtTBs7qrRzodGu5+jjlnduS6wrUh6wWy9/YUbKYer0gJ0GHIvqrTG/JZFCttyQkmz4NagE4HdZtnTBNBXwBZC+WZ/YQn4bqg2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039086; c=relaxed/simple;
	bh=88dGMLu8oaNtxGztqh9kzlzwVzulFxQ8HdKBEeDyku0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFl8ooNwnOxzdXArAqVFwP6EA0VNYKfMAlD+X6xYlJAECG5WgmAIsAIyM9tj/lxy8rTk5/glzK5OuYr2ZlepqArlOIcA4dPJberSvuPWjtiRzJ7tdRXr4p52kfYxmEnJpqkeBlYyZsjdcO6KsCvYDa2y1xEsBdXrf6af76y/I/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwVIQ8DC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so890567a12.0;
        Thu, 20 Feb 2025 00:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039082; x=1740643882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Fa2XpJndeHO6ZeXRgA/FTB/dBRlEZM5Xwzi0nKk5Uc=;
        b=CwVIQ8DCFOrvNpN25iq3gnnu5KtCnEDZeMZhX42oX/fk3RL22iuftLjVk7rPuFt2eJ
         DakZC7/lE2uAxxPck3UMA37MKPfIRLEOesaJdZrC2HPqwiSx7oo2yFkb6YyBtsg9MVpB
         +SgwkuXkYxLPHRR5SNjkEfyNLut0rdB9LthSuh2ctfsrH6cuVBDbWuvDmgQyYRlNtb62
         kkfP5UiOuOmMxlMw9uROulTVS8Eb7CSq0nhcLzPxrwUpdpHcJAvWy1qIr7fQgunns2PN
         MULjBhJNkfaKdujAa5Y6qRuI/Sk5P0dHtco891fifY9QvnnxoJuowaa7+V/wXq7gCpr/
         cx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039082; x=1740643882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Fa2XpJndeHO6ZeXRgA/FTB/dBRlEZM5Xwzi0nKk5Uc=;
        b=gbe4Ezt91uKUZMFMaGyE9zEzh7qwoWtuCIaVpMq4P9Kty7FQLJnEItJi1fIlCo4p8i
         Z5OqtqkvFtBCtma8x8qmOkZlvl1mPvq8Sj1tQLU0fuu6ieTQukuMLKzXRMaPt7ZrySRa
         J5Ro0FFTQNZhNe4MJ9WrlmNym1QOakz6yzRSilIPEI1828f1EkmrR1m1DeiEeEgxjuw/
         z0W6a3zfT11cEYKIJG8EjQZMv7s9Ylan4ZxHatnDr6nVtHS3FsFjEsggXiwAqGq9aP7p
         j48njLgQNXCqtzltctnm0C5Ar7M+oh5QjakjAmY1NrS2RNYVgVaEeOFER8kHxlOd/0aX
         XhGw==
X-Forwarded-Encrypted: i=1; AJvYcCXgcT1c7e5CW/XJBB5RnlThAqayoPrc4GXi1QwggQdURnpG6KXiO8EmHtIWWvzKjAoBJ/NfVP8G3uKfEAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywy064DhsyLQbZNtp0ILLvXEfux9OiSV7Tto+3D58SMmgFzWsS
	oPqkLen9XnvR28hMwZhPcJ0k3m5uVOHxibKqBBls5EuX7a0B+G10
X-Gm-Gg: ASbGncupgvTnUZVMHfu6KndoGunPEaIDcT+XbBR+NG8QUFWCjG0g4MoxT/ioCxqxfb5
	H2dfokAab2iPicBN1SIxzOzgedVR76dh6OWOnS64wummmE7CB09xZJ9zLP6gJXPzpNR74b5iUij
	jXJgRcyQppxu7aB4bQ9wCvvwYWIX8HvFctmv7w2AXIKZ+aDrENJ7Utr944Bs0QiKpYW40Zk6+xT
	/fTxnN6MOzguW7+0Vi+tqbXarWQ99vjlG9dLbkrToxhKc68/b5UDN6sCw9ptIXXMoF90VE5TR1C
	8hK1//XEo+F9L7cRNFU=
X-Google-Smtp-Source: AGHT+IFzmhGHcf+HPHFX4JdxPJPqktZVrOKvQRRqSO56JNqoy0UqptElxpsg0ocQy+oy1VKWJUhDng==
X-Received: by 2002:a05:6402:1ecd:b0:5df:6de2:1e38 with SMTP id 4fb4d7f45d1cf-5e03607e9b2mr21972798a12.17.1740039082352;
        Thu, 20 Feb 2025 00:11:22 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270967sm11636298a12.55.2025.02.20.00.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:11:21 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Thu, 20 Feb 2025 09:11:11 +0100
Subject: [PATCH net-next v2 1/2] net: phy: marvell-88q2xxx: Enable
 temperature measurement in probe again
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-1-78b2838a62da@gmail.com>
References: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
In-Reply-To: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
mv88q222x_config_init with the consequence that the sensor is only
usable when the PHY is configured. Enable the sensor in
mv88q2xxx_hwmon_probe as well to fix this.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 15c0f8adc2f5391e8ee30b68641314a60d8b0a0d..342a909a12a2785ad579656eb369c69acaace9d1 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -513,7 +513,10 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	/* Enable temperature sense */
+	/* Enable temperature sensor again. There might have been a hard reset
+	 * of the PHY and in this case the register content is restored to
+	 * defaults and we need to enable it again.
+	 */
 	if (priv->enable_temp) {
 		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
 				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
@@ -766,6 +769,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon;
 	char *hwmon_name;
+	int ret;
+
+	/* Enable temperature sense */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+	if (ret < 0)
+		return ret;
 
 	priv->enable_temp = true;
 	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));

-- 
2.39.5


