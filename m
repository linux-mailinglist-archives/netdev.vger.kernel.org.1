Return-Path: <netdev+bounces-167457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF807A3A5B1
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662E21749F2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B71EB5D0;
	Tue, 18 Feb 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4cWwiV3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15D17A30E;
	Tue, 18 Feb 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903610; cv=none; b=tEjGe7sa+xztg12iYVdp3NuakK2ji/xDdqgdTqrOfWucfKIzAOxBhonSCLqnhYg9NQPgc4VNRYNxdXYTJMz68DHDtRY2hIb9jju2ad7hPoPbmNlxqkIY2LqNbqMZoa3EyuSxAQkW+jVhmeK0TojsSM73IU5Kb8K6XtKv3fbBpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903610; c=relaxed/simple;
	bh=ZaFiNUxlJ+xE92UarjUVC9hipqYCtTDv2MbJls99AGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3mmTccNpXz0O6zR4YHbrqO+Mk04+8JAJIL/H636jC19lGsl3NsA1KzfHrGCD4n60wgLPHiKiIemnAeqOLRgzOHTc4RokWe09aHbR0BIot0oPyMTgK+XAI4gSEqP2UesleOdjJ8//UvNNogxjmsFjcOzmtjqI7TmI4v5SoDAZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4cWwiV3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab771575040so10237466b.1;
        Tue, 18 Feb 2025 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739903607; x=1740508407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aXtMatln3Wn9zdhmPu2eGE8bvytb1YjxJ8pZD6oX5M=;
        b=B4cWwiV3Au6DGH1/mp5EfQpThdq0mWDset+XORmjE1gOm3u6SPX3DU+7Fih1JPqOfG
         JaD5z0//mxfZESorPBLL62C3pwP9S+3AVKtmp8HDi7qUhZuO7QoU5J0K9fDIlF5pyVU1
         EXwn1MAn0XzB9CpAFpHLIJC0oKoocWZUbCKuY0W5KrZl0uPjIOSrIPC3rYe0xZAQuE2l
         zTgFNG8AXmCbAL/koWcKtULxTsHxcF2x+s1KQQ+cGQ5xqPwWe3VGflsxtPUUJsxVqfoJ
         HA9gBBBsweUQfIgdc/sPD0Wh/gDp/Jq8QQ4/VWUWawFKpB9emJAm0G+PzkYeq3Wc2SiV
         lFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903607; x=1740508407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aXtMatln3Wn9zdhmPu2eGE8bvytb1YjxJ8pZD6oX5M=;
        b=dl+zGFpuOM/FyPjzndsbBdi+V4dK9smT4muR5WEvw10xCWfITdA0Q6EhHkZmJ3K34W
         M1O3/Bkxv7U8MbbPqrRnrFcy1N71ySDIaYwKQ1U8liG9imNys6BaYPw8CPgssKUu/QeL
         l3hCKgpqiCxW7SP0p8v2IpBgAgN7Fh5NCnXysLbI5WoKoAUo6xQ5v5ktXxZwfuZeVDHc
         aRXQO8dlwIECRmn6glhqH/JRwBJYynxGailfKlBFzwg+C2NjdW+uuSopgXUg35AQPndG
         /Wrn9IYeIRTyd71KJWdBnj67uB7ku9wVy42HRvx6D6jKFF20E3JspkaJckxaFV+E+35n
         AmyA==
X-Forwarded-Encrypted: i=1; AJvYcCWAu/f6HhNqrT9dRrq6fZA+QXK3NoJDtGHZmQ4dV3qD46C87iOUg+5kYGBWgaYtYJExk1qwTjt8J3Aj/NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2Bz1j4cS9Ag0mrF9EJzD6kwLtH9602hTNTdpr7lIy+SWzOWF
	UFkgjF0IRK61epPcqOKnB7YEbJ5+t9fHYQDCfCpqLZ62Yn7ZKH4LVk4etg==
X-Gm-Gg: ASbGncs9a1jEzSW7Me4+h/c9NmUToxbz/Jp8ktmJeAGkVH6ge6lW8szW/yipGCcSfEq
	WcnFDzZSFjuoZkAGK0GwVlvW31hv2s8qBQL8LJLdoUATc0AhUdN+c4oBOHK/7egcjdmqNp8Ezck
	4XBQFkPLfnQi7sw3qLdx0x+teaCNP31vdT956bDPVgSPa3H3EqbcC9Brzr5oI9ZCfZxbDS3VwfP
	bGAFbqCjWMGlx+dqEaN5VYXt2x4pa9QBeHjQqv6pDz2w+7A1t0twUUvLECRroHrXQA5EvyBjUQC
	cFKQMnyatxuW8r6UleU=
X-Google-Smtp-Source: AGHT+IGlEj8nOCayhHN9ZMkBiY19NBn4oPfAGyfUhRE7ri5viBFR3p4iACs7VXtpaN/LcaXuBhz94Q==
X-Received: by 2002:a17:907:2ce5:b0:ab7:b7b5:2a0c with SMTP id a640c23a62f3a-abbcc5ba441mr116446766b.6.1739903607255;
        Tue, 18 Feb 2025 10:33:27 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:625:3600:3000:d590:6fca:357f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232039sm1106649266b.9.2025.02.18.10.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:33:26 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Tue, 18 Feb 2025 19:33:09 +0100
Subject: [PATCH 1/2] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-1-999a304c8a11@gmail.com>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
In-Reply-To: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
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

Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..30d71bfc365597d77c34c48f05390db9d63c4af4 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -718,6 +718,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
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


