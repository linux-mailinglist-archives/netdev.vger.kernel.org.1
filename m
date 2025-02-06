Return-Path: <netdev+bounces-163678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA791A2B58E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FE93A792B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714223AE80;
	Thu,  6 Feb 2025 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FigD2OPo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074923908B
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882107; cv=none; b=snlejeU3BNRiyrbuTfKkZa6bRkrsSyw4y5bhQ4ZAfJBvH0/j/JEog9Hue4q4tSqwaZVimRgEpcv7eNz9KwLTJS7NngivZevGbXukYx9/rI6d+gog3DJcd5ysYd58/5lufzqxJw/+/oOzpk6/i9Q+8SXqesGedw5K+raf6sl+bJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882107; c=relaxed/simple;
	bh=BsYr8xPzy7+Clg3NB+2+t+eBy6Bnh8Cl10byN7syoc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8/PtBErR4I2CL1fk7gQRd9sGm/fBw8yyv72B1YpOhJDCETO+9FULH0xKutGmZy+YTN/eZKbMlzH5K6k6Q8Udbw+7Bzmgs2K0Wk/kcIvgo+VZWyvpW57q4JtKKCnwTEUHSuxpPR/V6dcJlgzVAETroOD1toJ7K3inu7K9xI5weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FigD2OPo; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e2764aa46so1038563a34.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882104; x=1739486904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GH3NKtPpRHESHp33nulC7OX1rB6L2Ayb/Aiy8rtkYPA=;
        b=FigD2OPo/EIvsE6z27uxyPhfFzqcY5jizhT1/mV0w7nlj//SVqEShe0y7JHpCEjYV8
         Wo8WmclDkzxDFolPLke61nLi8IXFYAs3wbp+lxOIuCU+imc6DomBUZ97OlD0WKqmRWyF
         Ya6hAt01fKLpj/Z4nEjtE5ZqYXsqMfERWdgziQvNx5sOQ2+TxCYiwru3ljzKaJtCMZ04
         0nb/kzqvacxwNK0aTjnxhO0Ht1C0JYHcH83D0o0Nq+aq9Bf3eyUiTBZQYcZrM0QAkqvo
         5tPjxemt6x22Rz47n4Go5gqpfoOU5IGSuHeZXZ7Cqi1jb1pK3AleZKB7HI3a+3xS6xlD
         /6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882104; x=1739486904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH3NKtPpRHESHp33nulC7OX1rB6L2Ayb/Aiy8rtkYPA=;
        b=nguAIzxnxUcnutW0+vOlxicSjl5pAkFNx5WkanXcENKUEqt+8qUo8uOrPLZvMTMEIp
         k30nzMae1zRqb3i2MKVVK/AqzYhM6LzuVbMV7xCGwM5GUgFRc/J+njbyEhUkrwxOeGuY
         YO/EmeoLBxE+gAg0vjXMeecdcKIE4jaNPf8mc2oz01pDPgMD3OAL5+f2lhsgQijwu0A6
         CqB3OIpFSWCvucf4u3XoOQYiJWFx6ChWwVZlB4FF8b6ZjNbhdrbl5sTt7PcKlWQ9pKlQ
         RqRpxbcwsLBFc576uPosuvyquVUPjaM1w0XGlpmRKp9JsIhZ88Mt02oHw8g6H4Ot/wQz
         gUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkb4z42MlI2Kn0TZz1Rha5gWIRL7mIwskZLe7qSbpntURDEKIgaT7+YeWTz+lt+jFEdvjfIoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHYBO1k3Sf764LCEVoi9x8QdbofTcB9m94shcZ5YZktsegEAD
	7P+Yp4RqXxM19JKEE9dYVPL6bTr3udVEZbaifBPDHz86+uskO2AUMvi76utCDwo=
X-Gm-Gg: ASbGncvjOuPXMS/hjWfu0PpC0jShJLqQv9gSt5YA3z6cEwljuhRFZgRBcj7ttXJY+Ql
	YdzQd1RE1fliiiO0F02boIgO61EGeIN4ccCFRoTUym5vTl/hL34RnjoCUtqQ8mly29rf0ZD3o/8
	J9ufle/p6aq5NHPBBIuyi0haluSzi/Q0pyYDIbfPYZGDg5+ydJlpMlrc46RZQhAmgDLM8o9BeFS
	zi9v/3+9tIuW0tBv+Cb3LPMPz7hKTZt0JFz2zVZ2hKxJV90uxmsDkR3Od+nu65Z/4UbHcAFDTUf
	TmdI49gocxzz0LrqF0zOk91RdZBl9kfb8gh/I6DDKv0epuA=
X-Google-Smtp-Source: AGHT+IHCjAZ/4mXxk1VXEbjQMmNTdXsRhhKdUtPACGbfwSRhNyt4nhKE9d5n5z8psMK5DgXY9qctNA==
X-Received: by 2002:a05:6830:6c18:b0:71d:fb64:b601 with SMTP id 46e09a7af769-726b88c7282mr749926a34.27.1738882104636;
        Thu, 06 Feb 2025 14:48:24 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:16 -0600
Subject: [PATCH v2 02/13] auxdisplay: seg-led-gpio: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-2-1c5f048f79c3@baylibre.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
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

Acked-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/auxdisplay/seg-led-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/seg-led-gpio.c b/drivers/auxdisplay/seg-led-gpio.c
index f10c25e6bf126cfaac3e4c353f8bfc6639d94a60..dfb62e9ce9b407fe356c3a7d2d25319b91a11a75 100644
--- a/drivers/auxdisplay/seg-led-gpio.c
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -36,8 +36,7 @@ static void seg_led_update(struct work_struct *work)
 
 	bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->buf[0]), 0);
 
-	gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segment_gpios->desc,
-				       priv->segment_gpios->info, values);
+	gpiod_multi_set_value_cansleep(priv->segment_gpios, values);
 }
 
 static int seg_led_linedisp_get_map_type(struct linedisp *linedisp)

-- 
2.43.0


