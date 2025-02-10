Return-Path: <netdev+bounces-164952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A5A2FD79
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F47188B3EF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD726214A;
	Mon, 10 Feb 2025 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LTcJkq0b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FD261393
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227089; cv=none; b=ClLCxo+kvnQV08HtiQPTkDxAc4G76rMNzId5JWD7kOEz7jWVPCeoygQoM2DEih+NXH2wosEeiRdaio52/qwSnQN84An3/ukCqGHpimbAGWLdjXD0yPMDsmHAr9s6NXBHPSfT/tvXVBCRfzRmx2uk1Gyv9o5haCOmCbJJoNwVwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227089; c=relaxed/simple;
	bh=DTPgNGmkXhUVKQ7XC6/DETbHbqjA5xVWJi+TJtvGAQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ao5c3CObKbtGP1VbWDl5FXuW7VYod9ujfB8lmUQ57zS81C59L66f98gFiT0VohedaTtIXzHn5tf0UhDntPiOFGEdJE72iyAtkczBeAe8AHOf4LMYP/4ZPfmH4twceU9VtTG6aVWtQzR32fI+TX3nA0SXJCC9pxsk/7ghudtUj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LTcJkq0b; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3bc69c8c6so548447b6e.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227087; x=1739831887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aqCjYxf4gSpR0G6gRQq6zdrmHAVbQWmkyM76ZxN2F8=;
        b=LTcJkq0bR7PqP6F7wNnr7kEwpB4IF+ENhJyvzgS8fx9V1DHttG4+yB9aXdX2XtYqey
         ImnOvKF1kPCn+B+hvwptAIyqjFNAhCVoYf4R7MYlBP3TdUek2RvoXt9ei+lvtG1TpNZR
         ldm6VIh8HdBroOf+FV63AN3VmfB3IcIuE04PXtVLjGk/7zP69+7IGc8rwtxn8G0PW7LR
         93iucsg1kEq8zsf/UOq2z0xlzl/mjinkGJli56pIiLAyo+aYgXx8EtjBhb+XdWAeo8b8
         pNiGcAzR3dQcfld0oLNZt3rK+u/gbZ8n4OevvpuU/QoE7LeRXbkQSsHY2H3sg33vaU0C
         lNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227087; x=1739831887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aqCjYxf4gSpR0G6gRQq6zdrmHAVbQWmkyM76ZxN2F8=;
        b=UjTQiPsj7yX1+fp05661OgyWlf8/HhKNfkDtQIZtE2plRt/nlYS2SiTMG0HDk5yliK
         KH96hkVqenNqEjKB5I6fsdpdTLZMavQXQ8Cd1nHW414B3ShIRyWqjompIinQJ8CMSDmX
         tq3dTcqKjszggZ2ePnRTrs5m+4tt5AnFCV41w/OEcfPQvZ30bZyqKMsUr6wBSFvZIUCw
         DDVdJKzoMsKAsJDVUZFtjvd4krDIq5OUfl//q/0Mp9dGnZZm5dUyrvYHXq6BHG50+McV
         OT0OGU4KbhYE8Y1Uh1tk7YKHp/BUz5mJAN7PrYGfc0f23crTipis58NP85okzalUAmle
         rNhw==
X-Forwarded-Encrypted: i=1; AJvYcCU1RWZiqSbgERFYCJULttRX22pAn/+4zb2e69TNDVgDT/33iITSjvIsqxDb860O23CrQTe8XnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4YXcqgZHfuLMvBRToKM03BXPTmSvyjUq9RU8dZdYn2WJyPgW
	ijZ27RlUlPeoQYee8CsUn39Fha6YdY1xlkgJ4kS0j5cNFLMSRkXcnfwky2PgU3M=
X-Gm-Gg: ASbGncsEXoXRRpzhqyjMfRrRkTpyBo3FCaccVlyfdrlfHOJgPPUbLzQvRPhOv7QNTep
	scQqItatddxQyKe2e7b1EcgqqytibS4Kg7UE+bFY4+4Lalcp1xC06OqoF+llFPo5Cs068ln/gv6
	3RgEuxWZBt6q0TB7hsdxbQrHLXA+5xbnV2tLWrT7i+hL07s6eIo0mTwneXA8gam014eDUKs8D5r
	2NrpAthMraI5BuULbmYgEyatclnXGj1IKJiCJ1JUJKv6LN7zFhPzUZ0qeOqb4NvxDqMxHarjUEE
	jS85MAvuTg+MdvOJJOKOj91T36OTZAh7qKkpU8Z+moBHogg=
X-Google-Smtp-Source: AGHT+IFodsa1xU/+j9iOyHK4zd5srfGLBws68RU1hOd0Hvn3EqSmNLjWe0xJTDgUwSiCbolk4Lse1g==
X-Received: by 2002:a05:6808:23cb:b0:3eb:5f1a:d083 with SMTP id 5614622812f47-3f3c2633408mr767124b6e.20.1739227087286;
        Mon, 10 Feb 2025 14:38:07 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:38:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:38 -0600
Subject: [PATCH v3 12/15] mux: gpio: use gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-12-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
gpiod_set_array_value_cansleep().

Acked-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mux/gpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index cc5f2c1861d4a22d984bcd37efb98dd3561ee765..5710879cd47f89b6ef4458d6b4419a1fe9ad349f 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -28,9 +28,7 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 
 	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
 
-	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc,
-				       mux_gpio->gpios->info, values);
+	gpiod_multi_set_value_cansleep(mux_gpio->gpios, values);
 
 	return 0;
 }

-- 
2.43.0


