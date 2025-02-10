Return-Path: <netdev+bounces-164949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB64A2FD63
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838AF3A56AE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B61525EF98;
	Mon, 10 Feb 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EX6Geyr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147D254AE3
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227080; cv=none; b=A/pE/27gDVOksJgglUmUBdGpfgg8pfp5ej0oYdL00Ards+FxkfRno2SoK2W4F4wWRtGGXPFAGvrkVG/GiQRJk9QfRpYoINYAXuXo5gJvRtigu9iMo16FofdGKMMR95AwY1I57kqyXQmx+gn5hT6ZA4ZPyVnWM6V+fSdJW65uZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227080; c=relaxed/simple;
	bh=w2oc7RoPm/sb7RYTc8soBDQAfVbctsAzru+e/xVugio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1CbTX15fnmoUFrurSOQQQCeoS6SpcWdxnLATR74lb0B41j+vNWYdcDZM8HZ9aPPa7erFus3N+bPbUK8A54efLcDTuQKHe2ONHZMV68kcIDqd9do4Gaq/UR/RBc5DymLta4MTOqRk/ZrRTHzyz3xHb6yQXS56kIp2dmOKid5CXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EX6Geyr2; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f3b8f6ff68so698437b6e.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227078; x=1739831878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teHDghklDJ1V7cAi8g37Bvg2ko8a0NpXKiatSq796/g=;
        b=EX6Geyr2f5PrlcFQSDLNi8nG/h2PCdswLOTbPl4cfWLsKNV2v0DyC90gNZ3HcnGcC7
         WLFTD6vVne9vl9xZfLrI850yPkknlKXY+s9FoBjWe0o6kfDt05hvDX6Z4xPtx2twLoDu
         Gg5/75WgIukUpmgSmbfgiekGaK/Uz2lI3X3FXAvJDPj3bqjUqSCBLtBayYCCwiM+d6P7
         8wFqrDDLd/EwGgjGGVqn1XWvp23Ng9elYqsFt7WQrjcFELX6uRC5J6xC+yKawGNvuLEN
         loDm8yXQayJvC4kj+QCMv0rbMw2wPJCXPEWGTqZgBHuVYhUPwJg1c1WoYlntxYKYpzUR
         40sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227078; x=1739831878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teHDghklDJ1V7cAi8g37Bvg2ko8a0NpXKiatSq796/g=;
        b=Fw0a1HiVJnQYntiOQ8Fi1gB1S95cwkQCw8oeaZy3yT6i2jr1uYBvcJ9OCXiJdb+eWy
         0pDILnvVGuFuZKg8dhyh1B1HfEFujdVkVJpM6fNmmcguo/6O2sA7Y9UooqCXylSIZx3A
         btRy3wE3A5B+5BFPxo+sHH9Mno7Q8Kj14sxtxzjvalxVUJx1bJI3mHow7VngPG2dY6Zm
         xi+u1kgk6ctMwyDjuapd1qWBc+gNbXtY1voxThc86yLtDrP0RrQ1R1hLPMAJlPQxXKNQ
         DEaUFjjF8M5CdbhOj3f18Eda0udqiVtoyWrlIP28Mv6jbiWR8y6nreaREmQpW1Jb2uwU
         aOgA==
X-Forwarded-Encrypted: i=1; AJvYcCW4DHZJxlKFfHcZ32aYn6M1pSeJgXSXhfeWX1mnm8XU+ZnHwK3UwhP7bGYSGQyZx5JrT6hJQ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70SAxbPV3oNejX96FfU93n5RTMbaZNmxJdmk+tbUmnU2CDGZC
	3BSwHKo6WJNqMJHR4ecHU+2XagGX4lk9lZJ+g5NXw5gRaOJB2QKvDHJ1s04humU=
X-Gm-Gg: ASbGncvidEMNfzD2OJT7dnyUvlriIZfEqLfiqdm0/IGVwAjqxmyu5WR21+o6sRzVbtK
	BDjG1fVE2AavfbHOdfJA8mvTwe5BgNVXm3dmZCOSpfRQQ3DsgfgfHSkQDi8f2wBTJ57qW9BIIge
	M5QV6XEdFtpAJfzOsAtX+JxIW5SrRi7mfzOhaKBKamyiacimloQ08pB2opy2BUPipRJQr02OR9L
	kCYGsPDOQDlgw9Cy/okIUsiv0Cb08g6QDiieGsKLDtmPADujERYTvlkDtymzHEswqyZGu8iKutc
	W/ZC7LHX3B3jnewHzOZV43Nk8kKiTRAQ828MkouCtyLUrkQ=
X-Google-Smtp-Source: AGHT+IG3DTzAWvVW4SJ21A/SRgFk31074gXMN9+oGlJqzs/MtMc8XsiOogFgKzSWDZ9AZ40PkdjrRg==
X-Received: by 2002:a05:6808:3c8e:b0:3f3:bda5:5739 with SMTP id 5614622812f47-3f3bda570bamr2064722b6e.17.1739227077726;
        Mon, 10 Feb 2025 14:37:57 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:35 -0600
Subject: [PATCH v3 09/15] iio: resolver: ad2s1210: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-9-d6a673674da8@baylibre.com>
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/resolver/ad2s1210.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index b681129a99b6cf399668bf01a1f5a15fbc4f95b8..7f18df790157f1e411fb70de193a49f0677c999f 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -182,8 +182,7 @@ static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
 
 	bitmap[0] = mode;
 
-	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
-				     bitmap);
+	return gpiod_multi_set_value_cansleep(gpios, bitmap);
 }
 
 /*
@@ -1473,10 +1472,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 
 		bitmap[0] = st->resolution;
 
-		ret = gpiod_set_array_value(resolution_gpios->ndescs,
-					    resolution_gpios->desc,
-					    resolution_gpios->info,
-					    bitmap);
+		ret = gpiod_multi_set_value_cansleep(resolution_gpios, bitmap);
 		if (ret < 0)
 			return dev_err_probe(dev, ret,
 					     "failed to set resolution gpios\n");

-- 
2.43.0


