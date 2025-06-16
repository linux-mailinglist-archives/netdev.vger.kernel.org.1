Return-Path: <netdev+bounces-197960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9FEADA962
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925AA1895341
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 07:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DE0213248;
	Mon, 16 Jun 2025 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aEBOMGGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5720966B
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058661; cv=none; b=jZ0xMsWga+weWfsDrY1H6AaQheB7hEc2BVFbnMw9ZBicdsVoAEFAKc+937mPvOfYjtN/g/du8IIFYfm0mXfBXeU3dQyWCqD2csBcoi1i8scEBQKSUmsVZgIvRUzYNFxKSqg3p+AuwGoUdTRJLhOm2N+9ORQyIWfpk1ScsTUb8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058661; c=relaxed/simple;
	bh=vJ8bAp6BM8Ym7lhFiXPJqMY9TEHYiyl/QFo5utRKFMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKa3LMnoJgMYuWzGlwugDS9V8CPY8cY5C4cmPQtCbKB7oP12VhlCs3CjNOR3CC3QEpy/C2nPEzpUZMuTC9C1ZNMJ8aZcORPAb3vd1YsCu5fPEL2F9lNcypnZYCOLNwD6WNzWEZYOvZpVmprJB6kiQKkvNTwOEGEMQVwRr5JNAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aEBOMGGg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375e72473so2332571f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750058656; x=1750663456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWpvlitNQyjX/3TaR360oAQrBTAeMtXI+WOaWtAQaSM=;
        b=aEBOMGGgX2iSIC/zvbWqiBxJqEWVnIkG8iHiJZ1HaXF+inISU93AFd0GyK8BA4S4AN
         DqlIF2QKHGDpAQbuurvd0+v8nri0GcKRtdGHpLVghz3fpOADVy7WRZpP35jeKi1ngIIm
         av/N8zNryDlNYSTlE+J99YZOVkzFDgnY29TXZzvhgLMn/5EGKESEYLbV76wVRt+yf4k5
         c5LepnENVbCviPcP/g0oBJ6+/skash5OeIhtu1yBfMm/5caz06EHIdLRDjvJzddVvLpA
         yB61sk+IaNkmkk4cDj/6dCAI88TFUO66lS3rqkuFCy6oUgOBcFZ6I9hiiApE+a3uJWeP
         49pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750058656; x=1750663456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWpvlitNQyjX/3TaR360oAQrBTAeMtXI+WOaWtAQaSM=;
        b=G41HUVrPS8RqlVTd/eRJ7viYX8DFqtEMqMJidcVMQF39D4EGZhQf7WKShoKjpYwGeT
         fQoa4GvTXVGG4pXAmXX7I2vP5QIG6+nojGsF80C9BS3b/CNqHwtGZ1k3HvRzl0nGQC1C
         MALNzWoUaRFFziM2MmpwZLRuqv/0vYO/Atj/1N5LEXFWlFkJzHGpAUHqvum0rtsg7KRj
         t1UtgbNknVoin5K2M6jT3msSHCsh2ElC9Ize2FMpUoBCEqicOhLrqRIZf44DnkGZVSZj
         8HkogHXrs+ofsMlBBcH5xbX56Bd5FJTBxlmuw5hD4P4LHoMHzzhLyi6sZUf2bw+m99u2
         DTUA==
X-Gm-Message-State: AOJu0YxuTmDhdpXFlq2VRkxASrvYqMPrj+C1wYH4P9aC3QJGbmePKwLK
	qZyDeV/GDiXkfSmfBTdmkz1LjRcbqmdj6K9E692d5yaAUco42iNfuUhEy0AlTO8wcfM=
X-Gm-Gg: ASbGncuk6upLhBVyqBPusIz8TGSkcdiFRB+dVjTcC+txspq35qovjhpp0rYlfQHJ+3G
	f2xpOwQ0UWWONvcZpdB1RuuumCsBmwL56BOeQyK03P6uWEKXN5KY6jsazG9/C3KJ4gai5orjcFV
	2gE+sqI6rfvc3rrAMS4lNL938ljEwQ+bjH+IebOmbwpg+kvGM2IjB0icsAeXVjK/AOvnS6Ux59V
	YzZWZOYduIDUOO8Nm1ni5a2vG9lB1L/FxAu+Qa0o2iSHYskujK2w7VvFukiJ7cF2Ab6C4Rf4Gak
	udvwLZeMk82nAzWvpMYDPHPa7PdhbKBy8C4en9Bqi3IjeAq5u6H0Vy08
X-Google-Smtp-Source: AGHT+IG60Qst8hEoeVHJrOe8WgEudvUhx+mpO473XIVAY3lrRn/4uizUbO770sqASh+Stcf20K9q/w==
X-Received: by 2002:a05:6000:1887:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3a5723a22d6mr6934662f8f.34.1750058656267;
        Mon, 16 Jun 2025 00:24:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4238:f8a4:c034:8590])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08c99sm10312334f8f.63.2025.06.16.00.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 00:24:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Jun 2025 09:24:07 +0200
Subject: [PATCH v2 4/5] net: can: mcp251x: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-gpiochip-set-rv-net-v2-4-cae0b182a552@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=lkJ86orkP2RFoVEY51zoeHCrs4bybXiW/Oh3wEXk8Lc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoT8aZQKikr6KLr+7sJ83F72c4Qw2op7eIEQMdv
 SZWIKBUqIyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaE/GmQAKCRARpy6gFHHX
 cmMMD/91tStvBSl3Yl2SLPgO2b3FWoqjotFtD9nwyncmCBZAaKQaMsQe9bWB7/9rqiuJTzGliVu
 rlXPWr9hparqPA5clW3XAkCo77zYB8ea47eoILRXc/zdlqkJ6x+zgY6LrugVt8Uviz/0d8/z47x
 KZBnL3k+VnNoAIOhiCp93MvuBcGJjh/ufkABKWOxleQqVxAlwaEjdeGpn6h/EzHECApiZy+w9C1
 WEgI2Wx+xQ0FUrvhc2/GNSV7vQ7dtde0zYOK/T1R7CuGMsXQrMcBoY3/1MwKBbLstuPTmZ3nRa6
 Aw/KQO/PInbLvdftJA0kNzp3PZlBiG6EaXCwxN4JDNy6NamYf1kD/bGN69y45Ug1A1V7+jQVAUm
 G6OnyqsTaVo+xHwv9zs23rhRM3tdiXIwLzEhCahGLa3POsNGle6cmp04dQEUOgNmE0oEpWrB3GJ
 fWpEh0l6ewJWmPUMB0YjfYyeBQkc1mmo+cJd5nrhyNxNrmnB+MyMlxxuOMhwXHymJTwlLk0qztO
 deyO3oZa7k42NQcrmz76wLzL3IRRhC3K6JqMRUj36MtULNvrKNNM6xS34kAKd+CIuNCuElPWpzX
 rzMsMO6As+RxHRr+IVZB1SM0jlr2VvYCXu/pXDUCayEgXwQgo4KEBWnN1OQqIg80E22J+g8ARGL
 WXvAcETCA/XZPWg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/can/spi/mcp251x.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 60b7fd3040d02f114693cf66d61c8a075a32e278..5a95877b7419b4644664b2115c6b43f4b586cf4c 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -533,29 +533,35 @@ static int mcp251x_gpio_get_multiple(struct gpio_chip *chip,
 	return 0;
 }
 
-static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			     int value)
+static int mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
 {
 	struct mcp251x_priv *priv = gpiochip_get_data(chip);
 	u8 mask, val;
+	int ret;
 
 	mask = BFPCTRL_BFS(offset - MCP251X_GPIO_RX0BF);
 	val = value ? mask : 0;
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_write_bits(priv->spi, BFPCTRL, mask, val);
+	ret = mcp251x_write_bits(priv->spi, BFPCTRL, mask, val);
 	mutex_unlock(&priv->mcp_lock);
+	if (ret)
+		return ret;
 
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
 	struct mcp251x_priv *priv = gpiochip_get_data(chip);
 	u8 mask, val;
+	int ret;
 
 	mask = FIELD_GET(MCP251X_GPIO_OUTPUT_MASK, maskp[0]);
 	mask = FIELD_PREP(BFPCTRL_BFS_MASK, mask);
@@ -564,14 +570,18 @@ mcp251x_gpio_set_multiple(struct gpio_chip *chip,
 	val = FIELD_PREP(BFPCTRL_BFS_MASK, val);
 
 	if (!mask)
-		return;
+		return 0;
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_write_bits(priv->spi, BFPCTRL, mask, val);
+	ret = mcp251x_write_bits(priv->spi, BFPCTRL, mask, val);
 	mutex_unlock(&priv->mcp_lock);
+	if (ret)
+		return ret;
 
 	priv->reg_bfpctrl &= ~mask;
 	priv->reg_bfpctrl |= val;
+
+	return 0;
 }
 
 static void mcp251x_gpio_restore(struct spi_device *spi)
@@ -597,8 +607,8 @@ static int mcp251x_gpio_setup(struct mcp251x_priv *priv)
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


