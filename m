Return-Path: <netdev+bounces-197957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD93ADA94C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378B118867A5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23C11FAC4D;
	Mon, 16 Jun 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="M4VZd82x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DE1E493C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058655; cv=none; b=B+k6HxfYM4EwogTEmLEUKx40GyPjLnPLj0UETvYOnrhK/XPTMZCVc1z0FtxvrvlihXUYJeHaLklLit+Q+ruGpJEz57w1uSOEdjIk/K0YgklSX47ourlg6UErNJ2YuNHGV2etoQUrIZoSak+g360LAZS5Pg7yf1Pijc1EFpPrdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058655; c=relaxed/simple;
	bh=DMxSE+KlKXo7E9j2J1aDyImW/V4iGavbbTY1DlV8QQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xfju4anCA4UHkpQcjKDzeV16TbQJ1R0Jc61wPbq/HjMX3UQaIwlkfe98QyygtlWVUzKZJpIK9DYRpUYac68/dBV1K67uzD1N2JOms1q6hGAAZ5hxBZ8xELDPId/3dzLU7oL07FRJAKvYtoOXq7UmnVD0iuSZPvqK7Ru5D0++wAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=M4VZd82x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450ce671a08so25721525e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 00:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750058652; x=1750663452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE6IzPfXHMNhFc7FmQD93cM50XDdvhBiuKkLkDIaWfk=;
        b=M4VZd82x3dixXEQsRSXnF9xzzKKGjQyDdBrwnmF33kR9nDfd/P0r+ZeBxHoCVBqZ5z
         UkTDfahw9S06HeP8zID/l1nuCT8pM8W3L4FILkdOzHJyiFMKWPrnqRahp0dIMWMXGjL8
         daO9LDXcy3WNrgITQOzbUcEUY2t+2t+RzCXjivA3mVUD/S0vsmt8FygwCwg2GAXt5qFU
         b91hPFeINE+WftuBMjtF9U7C3bs/nz97+YLql5Jtaj9QVLgvUabbeXW1v4BrSByg7/t9
         NFMg1YOfXQl2fYtI46XaPZ+g2LqMIAca7H0ZLovZBZ7+uFOopot3++sJZXpTl8/hsjiy
         trng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750058652; x=1750663452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yE6IzPfXHMNhFc7FmQD93cM50XDdvhBiuKkLkDIaWfk=;
        b=XrD8BYM3E/iLhdf81H5u5t2WtLD8KggFa+GdpVT/TrdK1S4o42SwavB4YnkQpGrjUs
         xAiO+TmTrUDYGqsTaxFznFojAibGrsW8ZRGRzv3Q09VW/qdg+1u7vmuA0dhWqhbfSIwE
         +M24xdDnQOuw6XbGxfdi2QU1QZ6XHHA3oXljVkSUFFNntbnW1jRKIDZPWH0dX7AfEjfd
         GXNRqLsDRB+ura6ZgT+MHBBBL1gbOVGZSnPQnzYV01rdPWA2JcfFSDU60dU/l+vI/fQu
         XHjTN6wSg/xy+vkY9yG5rigvc8n88rXNx+mYLlnfEFJvAUI3hbbOh4dxPmtF7DmUPOMe
         JryA==
X-Gm-Message-State: AOJu0YyrW3CelgYuU4tziCV/WXMkk9dIEE4maA8Ot2ms1YyCKnsxjPg9
	FEArrRXUEhNVLdyO14YVHg/RbJpr7oQ57sf6uagUb8xtX2LCRKYtRDw48VBIrzEJoPw=
X-Gm-Gg: ASbGncuBO7J+7Y3xngFoVLoV9CyP8f1tLridQYeXZEexwz8jogDe2KjxZRngroq57aw
	eU9mpRTOnGmZDwNtPHUo/OugkB1qc1YbyF9q5A8JbdpId6rRgWKpT1h0a/cOljBRd87+qsPZNPG
	hUBzG9+bO9idMuIzHkgnbO1TAyMf4OqtnphMWOkeBIC3+4zX3BwsBPVs/7HOL2uPYyzsPOZPFt9
	RBWLSzrc93Q9dqNqq6i7y0JGUnu2PkeTPebZdwzxBYr2La9iMWhQMVvNfbO+YMYi4XcNCFJqHaG
	NyZw7YFwLeNHboXt+ijIKMqtoTP1ft1BxwfqfU8a0VSxbCnn/SN1D0jH
X-Google-Smtp-Source: AGHT+IHPFBPn3Zq/nUDkUy4oRevEKPyumefMdGv6HX3562iJJprMTS9/QcD9Dlx1hTdScj4u8SVCMA==
X-Received: by 2002:a05:6000:4202:b0:3a4:dfaa:df8d with SMTP id ffacd0b85a97d-3a572367c45mr7317623f8f.9.1750058652323;
        Mon, 16 Jun 2025 00:24:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4238:f8a4:c034:8590])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08c99sm10312334f8f.63.2025.06.16.00.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 00:24:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Jun 2025 09:24:04 +0200
Subject: [PATCH v2 1/5] net: dsa: vsc73xx: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-gpiochip-set-rv-net-v2-1-cae0b182a552@linaro.org>
References: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ooSfZcGlJ0aY63V/ZbHM5psbxtwwGfSHGbKlKX+V14k=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoT8aY68phhJHUiYmICb6qi2PtnsxOrk1Qj26di
 Sf0oPxAjkiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaE/GmAAKCRARpy6gFHHX
 cmsID/90DiNKLTStA2nd+V5BqNvhGiL18/ZS+yk4NDv771RccIIvB08RD8O6h9mQk1BbBx2PGDf
 8uUGoxxBYkl6SrCrU2WGXyT5gq7YAtwvpGuDWz0TgdkbCAT3B3FeIFwkAv0ykw1t7oPjNhRRO92
 FzNqC7ddptm3fGUK0ZyPIj55GA9V5mNR9oNqWMYTNQJFzLbGDVfi5+hEZx36mWoyXue6bGO+ByG
 zjrOM+4AbcL2OsTpAZhuMEHFzWlQ490Tw09iu2MGvdzydWZreBvSFPJm2HdNS7qI181vxwc3Pr0
 iEpTY3DJjRuIAXnAYAErCvz4amgZHJ2OSlcUWjpEKs7+57LZI1hfaIAyTfQpsylp3Fn8ucQZ8Bg
 FEL861RY6dMUJvPo7bz3gmb6bEplPlC7RHjimwXhGXTBqvG6WJCEn+l5JiWQpGzFgsf+QmtA6pr
 SFOwZQv/sBjz7nrwKkUExa74MUFw4w/5zidsXfSMokGQgAOGp3U90lHe15KSVz2BCIkXGTH0sDl
 KPagWn/xrxQH/6uqohnVTmdQmCMwgQ2o12ftsnf979MS5FTIOo+lqMFShb6yHBUdu0B4RluVfIT
 UAR8LI5viexSWvvxWDxg+sYDa7kv5sWzinYOHjoBh1tpudIlKw/Sj09VEzti0RhVxW57ynoPS9W
 tyHSiAbzSI0b3dw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index f18aa321053d75f34544267528d68ade37264e89..4f9687ab3b2bc1cc61946eef33b7d08f779db8c6 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -2258,14 +2258,14 @@ static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(val & BIT(offset));
 }
 
-static void vsc73xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			     int val)
+static int vsc73xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int val)
 {
 	struct vsc73xx *vsc = gpiochip_get_data(chip);
 	u32 tmp = val ? BIT(offset) : 0;
 
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_SYSTEM, 0,
-			    VSC73XX_GPIO, BIT(offset), tmp);
+	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_SYSTEM, 0,
+				   VSC73XX_GPIO, BIT(offset), tmp);
 }
 
 static int vsc73xx_gpio_direction_output(struct gpio_chip *chip,
@@ -2317,7 +2317,7 @@ static int vsc73xx_gpio_probe(struct vsc73xx *vsc)
 	vsc->gc.parent = vsc->dev;
 	vsc->gc.base = -1;
 	vsc->gc.get = vsc73xx_gpio_get;
-	vsc->gc.set = vsc73xx_gpio_set;
+	vsc->gc.set_rv = vsc73xx_gpio_set;
 	vsc->gc.direction_input = vsc73xx_gpio_direction_input;
 	vsc->gc.direction_output = vsc73xx_gpio_direction_output;
 	vsc->gc.get_direction = vsc73xx_gpio_get_direction;

-- 
2.48.1


