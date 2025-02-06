Return-Path: <netdev+bounces-163686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17570A2B5BD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B201F3A8446
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7AA23E245;
	Thu,  6 Feb 2025 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FUvAybKH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D07239094
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882118; cv=none; b=umyNtF7PDNDNHQQY0CNE4+9KA25mTHLj+fe4vRbnpkLvu4THOeu8p9/4hZsr8bIU8YC3hrWaMszusp/ZiUEgO+WJbcCm+XwrQ2FDMDBHaGmiAbjWf7QXZhTCdvi/lCD9hU3Qerf/FaHmhsoBY2BSWgpNCx1lwnnc34ZWcXOIOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882118; c=relaxed/simple;
	bh=DTPgNGmkXhUVKQ7XC6/DETbHbqjA5xVWJi+TJtvGAQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTlTNtm1ext8zyiC2wLSvuTjAbTB4z2848KcSPX7o7yWQ5tOCsLyVvUo1LMyhCeCiPa4BsQA3rUKgexcB8qbpJoEmCPvR9wMFQeVhUrnR9X3CJe/T+Mub9T3EaEu3gbZEGBMEzwPLK6e9PZtlT7rK+x67oRd0gOkUG1a966LkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FUvAybKH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e181fb288so995336a34.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882115; x=1739486915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aqCjYxf4gSpR0G6gRQq6zdrmHAVbQWmkyM76ZxN2F8=;
        b=FUvAybKH7qyx5T1F1PyRz0oSxcmZcJJYmbheZJIBhW49+S57dHaKqoULcX3dNUDYTa
         6TQKB+ttrcz2kHWvUi/6UQBhUn7JjmC1jegHyuOAEMYUIlQjVGPbCnlACitchBv2ypSO
         fjQJAkihUEh59LAYOD0OcXrrHtL2P2pgQnn3YrMFYW3Pt1UVTZDdUzQ59z5lmUfEB3jZ
         gMHxxII3M6qe8xRyrhQXa/kzQTrNQgq1cXYZpitlxefzhAPRC3EGx7QGTxOfqpKy1QEF
         tJWg2A9B3QTE3dnopc5a9FoZuRkXl8/MPVkpw+MSqSzdVL4ZCxs8xOBZT4nMCAt62aqM
         /ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882115; x=1739486915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aqCjYxf4gSpR0G6gRQq6zdrmHAVbQWmkyM76ZxN2F8=;
        b=LkAv52wBBvmf0Gdl22bSZZG7gCKKnptjHenzTyzgExitIq6p9IGQQji+L1hN2Q1x6g
         xRxuTe9i8B3q1dDFe1bAPdMWDkgQPK2Fc+/8SoAMQKOvXO7tGpdY5qWyQA9ptGfDMceL
         w7Xry/kUyGx2U8TlpNsttlEZMjsiQd26GAvK0mIp1jne9H69EDzj5TLf/wbZhPjVqlew
         f8NnbyHMbq2iyZx54Tql67Qo1RP4iaZRrm3VRzg28CqqxLqfzZCPA36JZT+05AcPP1fZ
         cmdD/IvnWe7iVjTl06CNx5AzolcyBXZwCjw6b/NkGjSWBgfIYnhw2hZHpiqwnuyOvbnU
         74Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV9xZnu3mY2kzc4eE46J6kqfb8OzRXX9jrVgCCDTp2SK2PYvRWH6t2mfeEcpwt6B+ypqInp0tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGm6XGmoTf4W3R8jxj9B3SO7nkMp5vDxwlcDpSEQ0nb9kvRm8u
	gIj2hpdK0aQZhfY0P1XG93S/6lJPFpRUibiH7lQngloGUzWFwvYvtw8+TFrHTOg=
X-Gm-Gg: ASbGncthfXfwqDn9Nkfraob5m+oMWbFQ2/W3N4aU1w4hG60nw34Ehh7fMOiJ7sH7IUu
	SwiIggpUdAkNnYpJ7zhnd7mKwHj5+OQTzh7SrnVtd0w7nX466zQO1/pzHFuUP9kWvM5wIfTH/vZ
	qzPIU+om7RGoVf++hD8abBVu55mS0GrIUTXtUSh91TWZlDGWmhSoZ7hxf93lfQFj6JZ4vmLiTOz
	eL5lA/sJkbRSbhCJMlEaGPkoqyKXbF+Y96QjBuduh9n4z+wgabO+n+vVhZUrJm4zDEahQ4aWkUg
	23IHQ2AUByKpMdPnF7vNOqzCfvgpCJYYxKD4Oushi5QzLJ0=
X-Google-Smtp-Source: AGHT+IFi5pOT04kq25kPl4tFke6cDrSG8LtrrGuNrjvHOS0CkDrwzGgg5qxvsBSG8EfBe8D1EHBqsg==
X-Received: by 2002:a05:6830:d81:b0:71e:17c1:45e with SMTP id 46e09a7af769-726b88883famr823900a34.21.1738882115069;
        Thu, 06 Feb 2025 14:48:35 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:24 -0600
Subject: [PATCH v2 10/13] mux: gpio: use gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-10-1c5f048f79c3@baylibre.com>
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


