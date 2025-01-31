Return-Path: <netdev+bounces-161862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B72A243F9
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 21:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76305188AFFD
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1991F76B7;
	Fri, 31 Jan 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wlI+CUIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCA1F78E7
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355115; cv=none; b=WS0Rrs9Nx9ikFyJbjGh1X8ym8EjBIqIdy4bfr6jHbx+Md0U8EAyQcqARQwlNEvo6d4z8iMtVvwpyBDqXkfoXstE55lOWe1RwZW1RH/Y72j8c2QouTclV26NPC6sG9E2DKBOWhQmnOaFN5FA+O3K/J6zdx46zKD6vyXjemolqwV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355115; c=relaxed/simple;
	bh=9CicIm6xDarlbk67AANQJSF1s3m5MgjSBlIRcxjc/Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSlGA2CfeMN85XV6S3ArOe/iQ5Oxz0w0n3B3Ww2lsKqU0iHOk6pER0vnmRcLMy5TAuQ+d4sw/v5YXLsW7xw1LBegcC7l6AeIqlYI8S3KhYTeSmlCeuUdSp0YMTNs+J5tnFKu8NyOdgBbXgCAyp6eqoXKvzj/PahxdBMUSHTd40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wlI+CUIC; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e3eb8d224so737522a34.2
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 12:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355112; x=1738959912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8dlq+1FyobpCXd9TkKRwFwRft57r9IiORFW/g/tAaA=;
        b=wlI+CUICXgXZ59m2jPFbdGv2J3EAl6YkI5OUi/o+5HQFg88HspRlr0dr1Ize9/zZhX
         vgbpaxsjqQ/QqRq1yjMqvW9qbxX33uCRK4wTRB91evDI5+FGRFEuBDaMCqG/MQZpJC3/
         bCWmxqxUDHoywe7tnFcOdgK2yuwPKsY+vyODObT6GFruCueLz/oc+ccc/9kSiZ+XWO8E
         8hdmqDBq4XpUmELiwQFDfZpCjeeFhJdOkm6M20lOsf8VzfgOqD5FaKNCKmDUeS++Fdp6
         Xq3mCVUjEVhfX7aQ5E0CD3QkC7ZwhZ9xffOXr1M0hlZ8bVJXGwPCZbNeTgRpOff8wAZW
         z6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355112; x=1738959912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8dlq+1FyobpCXd9TkKRwFwRft57r9IiORFW/g/tAaA=;
        b=JJp+mJtxKp2CwevYuUu+zQFhWY9os9Jjopaz5jcBVpND1B2uctAsiThqr6yaJ0KSnw
         GL6FZQFKw7ZRp02eQkiKY0IV2Gv096Me5c8I9jV42uDY/O9q2++SGkFv6FCTAbhhvfPX
         g9Sd4OAl4pGW/gD0p6L/43PVQFHFyGQIwhcoJIO76W4XXd4fPSOuBdP+M9qHN7C/y/8Q
         u6Aa+aWQ1eYrNixtpzoXm+bh7V8gv+wCOUFbAZmo3zLzOj7jogKtkMxARNC13Rfw5JHM
         LsEDL/UCFLKox++hBaIY2xLypp8JkPn5YpUrqT6MciAMXghyzUeP9rG/0lBfDJeWZiPt
         iZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnidj/JEqMw7BNli+C0bVJuEl6DWVo/B0Hnauimpah4slmVm/qSrYI0gnJKga8bhXbgxWQ380=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3oo3bU4FT4rj0x/YrdthLARFCpOH1ljnPQmOi65dJN+4gIOuq
	+eiF76tU197rJEQDKhAfF0t8PfikfrkiddgSNVlmVZxexUH37kLrAi9/rdRCU+Q=
X-Gm-Gg: ASbGncv2oKlIrGtXn7XInIhNgOQt+ryoPEgr+tmvmft4zTPI0UPfy3OXnK46fNoda2O
	xfkYw5iRllhKdoEklMGTI6nAd4GpQjR5LP/YcX0BDd2WbBjKO8JhGOoMM5dY72A/GCcnBJKNJF1
	8KBwn1LFUfms6Z4he3KyLTOQasnv3rwAa9r01rwO1MFL6CyiZh+OPEhvKDOiw5Fx0bOhi74CRWU
	NFghNlqQpjo1SBM9AE2yG6xhWXmXwpAyeLtLqTOyTfOw3FyYj0l/ETYFSGP4QQ/XN+2arnYcxv5
	g+x+PCzj0X26eOsrUXBA/bpPpPbBEvGgv3DDjfpQ+oH+Xtw=
X-Google-Smtp-Source: AGHT+IEOPFpYcNvsoJvtChI72uu39YNNI5XV7tV2UH+PWhk+hEwEt/BHCYYItie+9RSXj9400mKLXw==
X-Received: by 2002:a05:6871:2106:b0:29e:2caf:8cc with SMTP id 586e51a60fabf-2b32f30c9fcmr7202349fac.37.1738355112453;
        Fri, 31 Jan 2025 12:25:12 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:50 -0600
Subject: [PATCH 10/13] mux: gpio: use gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-10-991c8ccb4d6e@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
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

Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
gpiods_set_array_value_cansleep().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mux/gpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index cc5f2c1861d4a22d984bcd37efb98dd3561ee765..fdfb3407543dc3c2563750b013754ceb3390e39a 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -28,9 +28,7 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 
 	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
 
-	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc,
-				       mux_gpio->gpios->info, values);
+	gpiods_set_array_value_cansleep(mux_gpio->gpios, values);
 
 	return 0;
 }

-- 
2.43.0


