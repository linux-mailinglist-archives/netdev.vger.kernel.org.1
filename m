Return-Path: <netdev+bounces-164947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D0CA2FD59
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B07F3A7373
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF930254AE4;
	Mon, 10 Feb 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IupX7MF5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3DD25D533
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227075; cv=none; b=pRX0pNWSxERsMl4xA9w/uOMTJ2M9PH/2Hrzb9PpAdfS0hE4oJF2U2NumNaybrghWPx/O2nitoGLyozblWkwEsyhcRjh5vwXfyRZ0C8HkCHKuHZMUEzWG+kL48Ud4lTKkKMsnodGi/eSpTjWAPzd58I3b7teCY4lfoQ4Do6htoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227075; c=relaxed/simple;
	bh=E+QxbL31Mk8vy8KiWcSsFLkHYNRVN/Q8L14IDdICZ60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNiOd5VJuN18FTjXbnDqzEUgKYRqkjUuQ+Pm4iYBjYCCDkD+iGOgh1uV8KgsQsnX3BmoUAArvIBZJqP3yE93dgOtkXdh5rProroaJQ4fcB3fAmxDDKX9rIwEotR2WOj0oft4Cd967SD5JJ7YsCHYuRNRT2PqeVIFEtJFcDKraSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IupX7MF5; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3bc69c8c6so548313b6e.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227071; x=1739831871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KFibiHSceSI9J0YTbtHgVyCC6KTbDSSVoM74byAuKE=;
        b=IupX7MF5SYuuAqOP2Tfu9nnVp7KL3B6z/1ukgLgzjaYemPo7bXexCIkRSyozbc00NR
         GdPkTPZeY9fZk8PJuaFoh4pCx91s3v+mpg5oB46IbKVas1ngrtCjW3sp7ozhLe4+gqxy
         Pzh3uO3ycj0HHNNP3EGFkJ2DH1Zi4NcptaWW6DNAKiAz9kd5mINv/UnHcZYktdnoP35B
         ZwX7bGV4f+cGbF4kO0LBiWvSQiCx6r6VmlHPsN5QC0uQweVrMaxGueO6jSf9K7QvabNu
         5c6h+li92oA9DXqLPxzQI0D6+xQun/37mTsHMRYRMBRX8CR0f/oN1JH2aR34Uwesz9JX
         Gk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227071; x=1739831871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KFibiHSceSI9J0YTbtHgVyCC6KTbDSSVoM74byAuKE=;
        b=a2D0oTuhnkmyDuFwu55LmHo8Kjy2y2KhCkWB2dgGjkdBYIkbYPb965oMyyF4k7ypaf
         iOYwiR0C7YbjY7uAcLZnMzbtirexMVighO1g8VVuVYwR7jtIO/EE8FLE2F5No0mXkcKr
         an4Y4qkfjVfSMDXSg+HjrZPpbtf7BNSnQWLvHcR45j0ZMB5enkzJ/mvCyISYrgNLJ2qu
         INQ0F/ZhTjG7gq0cmiegJxCw1jH2LbIFlUWajbdnWyUZTrgH/CqZV2EbSpBlj28Wqry5
         rbufMwGvgeyzudDGGRuJYfrKqlpbZVJqGjefMbRAcK+32rocHMDIjlNQfGQfxCoIOhqQ
         9NCg==
X-Forwarded-Encrypted: i=1; AJvYcCXd4nj/9gJP0z6gr+/x0d7YgD1oTAKLK7iM4IFBOAuBjIlzmfSCLpCWHp+BQkXQca2E7OYnh/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlrokDL0RFjf4ll2a4YhIgjC1U/EjjR4mRyYVyDgx+lo2UQWH
	XRd/E46jkIHmtkXhRX4IqmOE5ftIgcMMSLHKAHsGTNZ/lpnHqdzUsVBq8IE/ml4=
X-Gm-Gg: ASbGncutaO4yzTjLUPZTSnDipdX1Xz2LFWLT58taA3XrykXgVfGX20VXs9YswM/MUbv
	H9nIjScFauhvFjfpFhaX/mt34BDf1LplDZKfCu5vPPasdQ0Vf2Op4BdADslj8iURerBpQA2Nlt1
	3cvADKom+76BMBYQwJKiH3Sm92mdG5X7qX1gCEspTzLg2WTC4ZymCTT9uAlI0AD4u6a8TM1zoai
	+K4PuWU0/o9Kxe8jan75zS9ok/jEiBTf6tv6KY4ZOeCDeD4duET5I5ODB9NbnOFLzHIoQB+NZ6p
	KszM7eghYWLEUAHG8CiklTsNutU//ZeH/RGYmREW1g2kkBs=
X-Google-Smtp-Source: AGHT+IEqlKxdcHtWmpci4BLtxbDP+p3ZildeCHTAvguDG8QvB4Ez48M4koY5bUOldTogYj+eiwGfHw==
X-Received: by 2002:a05:6808:250a:b0:3f3:ba60:f889 with SMTP id 5614622812f47-3f3c2696ddbmr691568b6e.28.1739227071302;
        Mon, 10 Feb 2025 14:37:51 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:33 -0600
Subject: [PATCH v3 07/15] iio: adc: ad7606: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-7-d6a673674da8@baylibre.com>
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
 linux-sound@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
gpiod_set_array_value().

These are not called in an atomic context, so changing to the cansleep
variant is fine.

Also drop unnecessary braces while we are at it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 3 +--
 drivers/iio/adc/ad7606_spi.c | 7 +++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d8e3c7a43678c57470a5118715637a68b39125c1..9a124139924e4a4fbbbd234a8514eb77024442b3 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -818,8 +818,7 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 
 	values[0] = val & GENMASK(2, 0);
 
-	gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
-			      st->gpio_os->info, values);
+	gpiod_multi_set_value_cansleep(st->gpio_os, values);
 
 	/* AD7616 requires a reset to update value */
 	if (st->chip_info->os_req_reset)
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index e2c1475257065c98bf8e2512bda921d6d88a3002..091f31edb6604da3a8ec4d2d5328ac6550faa22c 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -296,10 +296,9 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 	 * in the device tree, then they need to be set to high,
 	 * otherwise, they must be hardwired to VDD
 	 */
-	if (st->gpio_os) {
-		gpiod_set_array_value(st->gpio_os->ndescs,
-				      st->gpio_os->desc, st->gpio_os->info, os);
-	}
+	if (st->gpio_os)
+		gpiod_multi_set_value_cansleep(st->gpio_os, os);
+
 	/* OS of 128 and 256 are available only in software mode */
 	st->oversampling_avail = ad7606B_oversampling_avail;
 	st->num_os_ratios = ARRAY_SIZE(ad7606B_oversampling_avail);

-- 
2.43.0


