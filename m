Return-Path: <netdev+bounces-196075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3CAD372E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF8A3BC1E1
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912302BFC62;
	Tue, 10 Jun 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y3OfEAf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595532BEC36
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559088; cv=none; b=ovmW6vHc53eMa3nP6q3dGnRrRqRedb6BX+Kju0+y1jjxZgg9i0QRt+TdXahH29mo4P/VLftsb9IHOJrH6FEsNHHcr25mA4K1piTjES9Uu3kHU0xxwU9og/3Muv1XF302mUyl1RbuNFLJzdMKLiXuzUn4oiGlM/uyLW5K5gxf+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559088; c=relaxed/simple;
	bh=2NQ1cPOt4XkS2Zypkx+pVvT81DOqnbvnHNN8rSdp7gQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6oqLue0kc1TXqRX0mZ6SK47TA37CKrnJvWrzQzaz15nLTnmCJ2MACb+XNqq3HsduS/HyRqTKxbctiHFLuhBm/Of/6ee6y1pRirlUIJzLiQQDAC5P72csFdmTiivPJvYmw6D0TTAuBxDoCcrsrHZpySRhZhYGJwun5L+thDrf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y3OfEAf6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2081800f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749559084; x=1750163884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+v15tNEANzRm+7r/NoXuqDH3IXJTclSdS8jb+naQrrI=;
        b=Y3OfEAf6+zk21KovJ4HiuMfmVXLnuXgSWOGMwo2H5ssRODOCnSDVY5xkKXqLnayDF4
         6nZa3t2YdCDY4gM/v5iscN4P8yImHnWG4IRsCmHTgPBU7Sngeb+rCpszlZsZV7GTfSN1
         xbJuUAa9vydz3PjovWMG0Mtf0E2ijo/27+kxqbN0dOxqJTO/l87PytSXNZjFheSyNcCl
         OHWKdA/mfCVmF1iiG2ILGEtAbfe1Pkwmr1XQA5MJ3kew4K/DtTurYQXOQo6Y6G7g5S93
         joVBE0M7azNwCtszbNDsFFB3kfOO9FUCS07ICel+2k2sy17VX9MQopAzysANJLgUA3kT
         L36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749559084; x=1750163884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+v15tNEANzRm+7r/NoXuqDH3IXJTclSdS8jb+naQrrI=;
        b=V0pyY/S2g1XGVvB7HgpmqbNX8jPWXgC32FBLDRJCKGe2o33eswvUvG5IVqnMByU5EL
         cExp5OM7an3zlzPuL9A0PNIK0yh8Vhr2peuylXkdRhZpp/LSeEvUujyy7wDx47rgQucL
         o7TtPwjP7tn4rHY57XEjGLAwm6XaPRa50bJ9Uy5uYUP+4sEHnR+QM5Utt9G0yPwedpn9
         gFFRRHRGvjmmmXX+hFyVbl/4vUYD3cvTdYADR4lLXZDh9oxZ6s13X/31ZS86EBu3XdQJ
         ddQ4wkzWfziWw6vr6nbtwafzYVG1t7gNo1q2K6E9/n7nD98oZdaqKJoEdOZFZSuK5e2K
         xh1Q==
X-Gm-Message-State: AOJu0YyTGieNtGDpZK5ChrRQH+01NnaH0cjtMuTczAjiK4878mi+JgiA
	UCqus115CfSG0fUt/htUS9NobqCJLV0WRY3QJ0Ka/OJrN1X2JOeHZq/kPTf59Eyfklg=
X-Gm-Gg: ASbGncvWCSVJdI8A1PyiTcv5Cwroq7pjT4NANPyNPe4kuGGd1xhMyGnpEI9KBgytgNY
	uv2oJ9n2K+RVpxeRu4kScakuiumeVIkRv1Av+nM1ldZ3BuFiKyBBEHAidTvo8nDx4f5giFpuaCb
	rYk5XlEDCtvgOPESnMSAA/YczcvEU2bcB0anSUdnnp6vB3Y/Mai8KuatZEZ0DC7d7z6a9vKe2sp
	g5P5y+4Mz9MyxMFmilcg0ZYJWT1M90hJE8BFwYMlTNoLgMH8lZ/EBC+fk46jpuoJR0Bhx81B91Q
	AbdXblzxfTsfhdI1khK4GHQdSwbV5lNvVtLfmuP+GHwUISFYSpnE/g==
X-Google-Smtp-Source: AGHT+IGXM/E446xVdY1FfP9/Um69E9UBtSzy/WmUYaOKdEEtjBVdyfljAEXkdz5bvzeT/0NV6hacqw==
X-Received: by 2002:a05:6000:430a:b0:3a4:e56a:48c1 with SMTP id ffacd0b85a97d-3a5522dee1bmr2326990f8f.55.1749559083748;
        Tue, 10 Jun 2025 05:38:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4d:e52b:812d:eb7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213759fb2sm142476805e9.38.2025.06.10.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:38:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 14:37:59 +0200
Subject: [PATCH 3/4] net: can: mcp251x: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-gpiochip-set-rv-net-v1-3-35668dd1c76f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=KLDDGKd5WeP1ZH7PFOPPjiypGPKpSmUdnfupIQJn/j4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoSCcm2R5upegqsW89/iBNvrpgrj3SxMSCFC3Nl
 TOttqE00BqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaEgnJgAKCRARpy6gFHHX
 co7eD/4q7jk4pUE8gWfdeMax9QSwEEkHfhqOylZzhdJH37vjfb5+genXs5+a9aSiMhVv+CUzVRo
 3fzN6/I10/CJqsoImMl+BGSVREdFJcXIVrezmcX3g/CoDU5C5lbMo/PXX/V0c3VycIEYSOm0gzN
 bK8W/frTMV20VkpA9RLNqZEdT5b+3tbAXY3KUruz/73xY8myLP1bsvqIJcSy3+8fpw0XzH6mqSO
 fJ1O+wf69HliyNoYdUIuJ4RNUabK6X3knM3Fq5i2S3Utkpx0QTaAch5ftKvyI82zEjOyyf3B8FZ
 +d/SAeGCuhnoN5mWeVWSPBVUU2N1zxNJPXhQ3Oc1VhFUdWoltDMsO0pAwFzSZbaGuFq2VRW9Mq/
 h2ECjHxSj537C92XxO4LIlDV7LNKSDWKfQqvuee9lOH4H4oqCgfDwoonedPMeoUUJFP2xs80v33
 77CBBKvc7mrkCSwH5ZgVX+ShUZvq6TP2T70qICUOgnQOG+j6Cb/rpEeYI1XdtZqX3MTSCiU+zlA
 Sl6LJqWqF5NCbc5Tp4TbMXJ7p5Bq9ATgsoC5IFpIDbWzAHIYWDpNQRe+dQB+NT2SAGWlct361Hn
 N7MHWvrch2Y/nuHsq7YlV1MgLW8lEFXgpk4FW4tev1/7VTv2SenC2isVuMt0TlfEhDucadN6ghF
 oHodahRBqdw+TJA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/can/spi/mcp251x.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index ec5c64006a16f703bc816983765584c5f3ac76e8..7545497d14b46c6388f3976c2bf7b9a99e959c1e 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -530,8 +530,8 @@ static int mcp251x_gpio_get_multiple(struct gpio_chip *chip,
 	return 0;
 }
 
-static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			     int value)
+static int mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
 {
 	struct mcp251x_priv *priv = gpiochip_get_data(chip);
 	u8 mask, val;
@@ -545,9 +545,11 @@ static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
 
 	priv->reg_bfpctrl &= ~mask;
 	priv->reg_bfpctrl |= val;
+
+	return 0;
 }
 
-static void
+static int
 mcp251x_gpio_set_multiple(struct gpio_chip *chip,
 			  unsigned long *maskp, unsigned long *bitsp)
 {
@@ -561,7 +563,7 @@ mcp251x_gpio_set_multiple(struct gpio_chip *chip,
 	val = FIELD_PREP(BFPCTRL_BFS_MASK, val);
 
 	if (!mask)
-		return;
+		return 0;
 
 	mutex_lock(&priv->mcp_lock);
 	mcp251x_write_bits(priv->spi, BFPCTRL, mask, val);
@@ -569,6 +571,8 @@ mcp251x_gpio_set_multiple(struct gpio_chip *chip,
 
 	priv->reg_bfpctrl &= ~mask;
 	priv->reg_bfpctrl |= val;
+
+	return 0;
 }
 
 static void mcp251x_gpio_restore(struct spi_device *spi)
@@ -594,8 +598,8 @@ static int mcp251x_gpio_setup(struct mcp251x_priv *priv)
 	gpio->get_direction = mcp251x_gpio_get_direction;
 	gpio->get = mcp251x_gpio_get;
 	gpio->get_multiple = mcp251x_gpio_get_multiple;
-	gpio->set = mcp251x_gpio_set;
-	gpio->set_multiple = mcp251x_gpio_set_multiple;
+	gpio->set_rv = mcp251x_gpio_set;
+	gpio->set_multiple_rv = mcp251x_gpio_set_multiple;
 	gpio->base = -1;
 	gpio->ngpio = ARRAY_SIZE(mcp251x_gpio_names);
 	gpio->names = mcp251x_gpio_names;

-- 
2.48.1


