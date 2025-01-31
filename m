Return-Path: <netdev+bounces-161860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222EA243F1
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4C188AF24
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F71F756A;
	Fri, 31 Jan 2025 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JLqiHDEm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD441F3D59
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355109; cv=none; b=j9BKi44vbfMoPoMnmAZtW9+2iBilj8x/ew2dlYncjZIPKdNFnybDSJTyDYUdk+zBfzLfyQC8hUrGmqLQVwRARdSV0eFX3rRw7jQdLHV6lTN9iwfCG52isjwIf3xIiZokirdFX8cyojMetk4rbqGj9V5iZAPXSyTVkiGxGJCplhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355109; c=relaxed/simple;
	bh=Dir9udBrhZIEDuzX3pRLNcZGmhbiV9AhUdKa7dHH2zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7Xi3c0rJCTqQoNvtHG2jc4aqEVycsc0dk4NYoQo+QSCNF8r40vAMIJJybVnfKV7vU4Myf77UEm31Tx9TcPwE0NdanmOXkxY/Vg135vNEeSP1tZCBSq4/icAYC6Ns0a6v0ymsLr/H5zp0/cNhkXFzaAkjWVftESBq5BxHZT21Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JLqiHDEm; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2a3bf796cccso1125467fac.1
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 12:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355106; x=1738959906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXSo9qIqFw2jH0TFUFiXNHDreUcSE5l/XqXZpt46Vu0=;
        b=JLqiHDEmc5QOTTvhC7d5nL1vn+WC3Poy4hTEcuXYTaFGW4yEm/1zyc+ngmEptSqGFM
         uLDCvKUKB++42M2YtmVGMG0QBxnNnDglYbuSmoY6Ojjf+BoLddAmKeFvrnbE2viMU1zr
         hhhq06ewVft5HMEb2wOISaPPa/E+ZIPsyuNTNxcUhi0AJxLV8Be03dvfV0Xq+T+brhbL
         cQUb2KfmxGPVChau+3bN0HKFgOtWb+up3CWWwR0OUMjKQ6/0E678p/pgFHPrZrG4NkYR
         HfGTCH7jhVbD3GS8EjzY8v/BkE8WIdOJ9SLNLfWUMt8ac9GfrpDw1+tbgvOHgUbuo8Iq
         NhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355106; x=1738959906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXSo9qIqFw2jH0TFUFiXNHDreUcSE5l/XqXZpt46Vu0=;
        b=wPzligensty+IFFzRFue5WPQGf+fCZXB4DtkKcdFALkcBB5EirEykYNXkabwlwuhlU
         WFXXHohtO71HB98Q5+koirN5D5xhz3+649tJklCSu4z+0oxOQyJpBfeA7N7XWZTiaGn+
         o9XaE0P+ISYzrfhx1zVgjkkAaEC6XPT0k3g55Q9uXYDVgMz+kbKF0SbvSj8srGP4kUj3
         yP+IATpivLdMtZ35krsl7PVVzMlHppHgKlU2FrStL+Zs3XpH7GX+OQYAoC7dlWp/5aOj
         BRDD7vfOLSLxSGMurWCOErTH93aTFtF7M39IqEY30P2hM5Jk1NClZl752ah/7Ylj29f2
         Vnkg==
X-Forwarded-Encrypted: i=1; AJvYcCXtETgLomSWGOB/leIdvXR7GkbrdxxFtmsfiyVaBObpoelf3InDX6SI15F8yIaQc99NjMBlO1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH19AT3WIuK5C2r7ebFS1YHxfytlwt0xxfyI833qkCX/WHnRzL
	Wie8SNajrZeGMSkUbZdNBC/OjCxlJKtP2dZtw7gE2nrNqew2VmA7hxriqc/63GU=
X-Gm-Gg: ASbGnctZH17UnQ0T95vvKemc3kJfgxvbVyWS23PeVsw293WR98+Ewvlr+jO75T/Xq+h
	sylXEXLR+Szq6k+dsw9HCmBYKmLM4RDmpCnLu6xF8hp0gPNTsGZNyCOnj+YncPdkzQ8KwcupQC+
	5+dOJZJxSfeelToWRYJX3xtdNjhzG3Yli68JQb+xbr+Y2z8ZuemBI8Q4jKdUFDR5/6lgRdO/KA7
	YF+LvbpiA5JTuQB39h4TFlXZbxPM7V74oMmsBYJ/KnCNdTH+jPwE54hOk9Xv/YlksIofcbex7lW
	3W34Wnu+6yj+IuZVdIWopDGw0tdoGHc4buggU9Rx600FMpQ=
X-Google-Smtp-Source: AGHT+IEk+EYILkaYfRPwnEDbJBIEBFXhatYC+4TE05088ijfOkCj1XESP7wyxn6VQQJyYksFnt4aeg==
X-Received: by 2002:a05:6871:a9cc:b0:29e:2d18:2718 with SMTP id 586e51a60fabf-2b32f26194dmr7999805fac.28.1738355106264;
        Fri, 31 Jan 2025 12:25:06 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:48 -0600
Subject: [PATCH 08/13] iio: resolver: ad2s1210: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-8-991c8ccb4d6e@baylibre.com>
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
gpiods_set_array_value().

These are not called in an atomic context, so changing to the cansleep
variant is fine.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/resolver/ad2s1210.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index b681129a99b6cf399668bf01a1f5a15fbc4f95b8..938176ac7209a92180fe8d55191d4abce026afdd 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -182,8 +182,7 @@ static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
 
 	bitmap[0] = mode;
 
-	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
-				     bitmap);
+	return gpiods_set_array_value_cansleep(gpios, bitmap);
 }
 
 /*
@@ -1473,10 +1472,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 
 		bitmap[0] = st->resolution;
 
-		ret = gpiod_set_array_value(resolution_gpios->ndescs,
-					    resolution_gpios->desc,
-					    resolution_gpios->info,
-					    bitmap);
+		ret = gpiods_set_array_value_cansleep(resolution_gpios, bitmap);
 		if (ret < 0)
 			return dev_err_probe(dev, ret,
 					     "failed to set resolution gpios\n");

-- 
2.43.0


