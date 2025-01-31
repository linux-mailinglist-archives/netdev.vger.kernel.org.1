Return-Path: <netdev+bounces-161854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D88A243D2
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5815E188AA3F
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D31F4701;
	Fri, 31 Jan 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ig2spnB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBC1F3FFD
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355094; cv=none; b=MGywVFuRZ+6MAhqfaKGlzoX4uyHCx+E5gcrAb/Vpwd65OHPxCoGhS1qrmKvonl3iYth5qiqK9bkjzFPspVfZowSdjPB0Ar9jyStdeXlLKm6IJNmjju0AALNT+CxOgpUGuAnEXZyVbt6t7MX1XZAe8LJgUELBPIuRdF00oWlR+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355094; c=relaxed/simple;
	bh=rw0sTpvokUQNOxXktkwUiVgyBWFEQak6z7kbvwC+d0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YsdBzx7bFOA6RWuAvn9NxrNZ0MQrgsBp/zgoPcs/HQwypM+iLs4WRbrKAORTLU5YUciL0q2F5cPGajLUTVYQSr5WRAu9rvAXLSiafb05tKRfyZ07hK4ReIt+p1EGWbsXmDknD6wdna2fiAyZM0653kcvWvrcTTmDkpWnHOmDgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ig2spnB5; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f4ce54feb8so1270157eaf.3
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355091; x=1738959891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Y1Uq2vC9ngxtabj+o6Gf/0MmnPKx34MFqyZVe1ZJHY=;
        b=ig2spnB5ORsHBPO9Y7nXycafF0XrCNtyHpbBQiJlFhRCJzhD+P63NHG7Yc3+rie4wo
         Mr917YqOD9SDmep54TVk1MQRWPTZklSbZHJI0otG2bBK7sL8CU+OGhyYSPEut98gL4Am
         /OamnTc89XUpnCD9s8nMCU1Yp2t50dPGzeYwrwj4B0whOWNhTdqOgAGsfB57FU3Q7ibZ
         +D2hbdgSPZW/fxOr2hN2CCrhN6U1bEW+MkJXEhvm7iZ0xdvgqfME5m+uCnNVxhEQEJMH
         Lx2W6FXmvSWHlwbKU0a4TJ/gjeqx78VIr5vzW4+lr6aucRQxdzZvzXh+n5sjyaEunDVz
         5L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355091; x=1738959891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y1Uq2vC9ngxtabj+o6Gf/0MmnPKx34MFqyZVe1ZJHY=;
        b=mCVYh4ILmmcfgry6+zcnSuIDkdaiWKMJJ3YVqeH3h5JdEPp35AC7CTaxO09xi0CzLN
         3cAffZhpMXJomtkgfd+YtGQ3b/aTvFSFj3JkS92s0fW7R6yAE/1X4DHJ/e/GtE0KGvzK
         fNsNPDW9CSzjrFn/6TwNbnHkUZBJGJM3r3nQP6jdW/QG+3PY830n4D9SfmJj4h5FoPPa
         hs5ItWYc6pCYQSGdsi1IUkdHIW2fONOObYxjKfT0FLzMEur5DiQd1U68yaZMZNQNMvwY
         Ngv5gtH6/j1uLt2SpTYEPeISObL2Re26MnszT/b4BeoeYfzdNHy4VUG16DyeOz41B0H+
         BfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxiKRjsErGAlnhutbfsUC6S61w5Dlyg6j9Pkr5fZWOPYYbrb9rB+GaT7afGXbkx552NvBQfQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJa0NWH+ZXZ4FBUlb3w9o77PJ0Cu4+fJaWcficzlMkdcmXVIeO
	jkhKDNOPM5CQ5S7xMBLoMmg3UyYUTUQwclSC8ARFW2YVVTkYF2QrAg7HYf2zOBM=
X-Gm-Gg: ASbGncs8Vlup47jTeNtKBRA5/HTA5ndNi0+fCb2KO+ZKcaMd8kwbx6ENSoVMOet4Hf8
	B9bWgwcEGaYzQBXWCS+pyTsBkoiJWBscUy1ruu9yH/dVeKX2iC8Q1pArCqHe29v15olvds2idYo
	s3PcNJT8N9STFvTmWYQlmd+Mnxy2Gco7r5lfAVM7pKrHs7/hjxdzW9I1BRh52N98NoGCKJ9tbqu
	mqiUZVFMPVt7rcmMgkVcQzy1buQ+mZLEEijlWCTdbXNQFiq8BOdC+/yFF5yywDA5wERpCzDwlls
	/414ZeiAUgBocvvF+i0mm2cxzOsAtn/Ce/3va035lbBLdcs=
X-Google-Smtp-Source: AGHT+IHpL9OiC+7p99DGjWrddY5GvJC4qVZT5ABdvIbOzG8MeWG3IwFdHaR/KYiBNOSR8xIQZbb8jw==
X-Received: by 2002:a05:6870:ff46:b0:29f:ecfc:32df with SMTP id 586e51a60fabf-2b32f02152dmr8447581fac.14.1738355091503;
        Fri, 31 Jan 2025 12:24:51 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:24:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:42 -0600
Subject: [PATCH 02/13] auxdisplay: seg-led-gpio: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-2-991c8ccb4d6e@baylibre.com>
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
 drivers/auxdisplay/seg-led-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/seg-led-gpio.c b/drivers/auxdisplay/seg-led-gpio.c
index f10c25e6bf126cfaac3e4c353f8bfc6639d94a60..c158b2c2827415e75d0b122914b8b18c043e8c76 100644
--- a/drivers/auxdisplay/seg-led-gpio.c
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -36,8 +36,7 @@ static void seg_led_update(struct work_struct *work)
 
 	bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->buf[0]), 0);
 
-	gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segment_gpios->desc,
-				       priv->segment_gpios->info, values);
+	gpiods_set_array_value_cansleep(priv->segment_gpios, values);
 }
 
 static int seg_led_linedisp_get_map_type(struct linedisp *linedisp)

-- 
2.43.0


