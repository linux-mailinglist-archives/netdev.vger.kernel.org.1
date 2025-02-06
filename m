Return-Path: <netdev+bounces-163683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0EA2B5AE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582BC3A66FE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4023BF92;
	Thu,  6 Feb 2025 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AnYjx7dv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AF2376E5
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882115; cv=none; b=kL6Tim/GBqqoJ85lH1tX3hQUuzCwuTZeAptsFDBL4EKqyTJHBTXTjJFuC666WgdXsZf0NGIxAH25P2O7cDPEcLyLps7XBJk/GZMMH7ylmN59HJpp3YDZickEKPKN4UbR7P9wm52V1lv5VS6/r79vRtNWTOFNLRiGqhNVRI55xZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882115; c=relaxed/simple;
	bh=IH4g1d8UAtzwg8g1uq4cmWqDVZbX87ChiYlpGpKjpcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0G31zaUETkqs5oe+dW/W34q87SLR5ZWqcrPVRCLwPO6g97CLtu8m0UCxrvZh6Qf7iuUP2ch8PBnfA+LU5J7492qWTUugOWizXDSaxqNbnpiChN89RRnIzCiVnyllZXSMM9oG4QOb8yxupuAyFlNrBrBBPKOfmTBGN1uRxA7wUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AnYjx7dv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e2a32297dso793165a34.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882111; x=1739486911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wznyorGz9Vd3pJ7hNo9c2JQSgu4MoX0a4PWBg4SPl0=;
        b=AnYjx7dv/fHT+RaED0QPGTL31FjQ8sPhaC9j6rFbYMIqV1bhjP7GNgroxDh2xTM8qE
         X3quFZWilB3KMjn4EFADZF9L+JrUvA3mcmJ0AeJ2ODcxjMSjwix5XgGmu9ttLKsFOWdX
         KnEzRgKY/TYZbPgQhK9gsmaKhaFHixmME7pXAwcdbr7R/6fWRAyHSoZFeahw6OZtohqL
         wm47wd5LlVjIKn0kaq4Sy3PRn3FguH5BqbXEWuvUFu48GWxy1niWvSh6G78pDnZYl5e0
         D2/rKKaYEslnT5KZlOy0NdQAf+KtgZaqBuVg5lex0hkL3chwwd1hgWaNF2CBULDDY4EF
         mbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882111; x=1739486911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wznyorGz9Vd3pJ7hNo9c2JQSgu4MoX0a4PWBg4SPl0=;
        b=LI5xSg3R2w+b9nErbHzYhTEfY0VgcYmv4SLMsnHtMw3VCQgmfx3djIvXwR8uYFx1h4
         +E5t/NXGiNJUC3Bdl+/bkcwDo8bAL2f3HA0g1ct/a9ONtGb5308xlTGRQPE3t80nDNiT
         hv8OQdbtlwvtp2MC0AXnQbZFsF2iP2/NpyMdIhHv8beVDq1jZ3KhQ0LgWYrvy9N//h5t
         fvSu+LFra3najR8ZdSR51P/hOl8WgPxYTZspNLlZJrWcgCR8R6p22Nrf6JvXpOZqjHk1
         G1zNBYieYLH8gjZRjV+3CRFO8FlrSD+mcvvLZYRa5ZaiYyn3YzjIgZ3H720ZDw4MFiOe
         AexQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnEnTTS6SwvXpQq2nJvtRg8+ZrTigDFoo1aXePwAijrEyGLc5fPBUlOvvqYSXYOqsG0xrobqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJQWnR1ujTOEllFR0cOXfUlBC0PnVj0InUj1Zs1jiRBNGzz5F
	pkOj8d9WvfRaTIm0rBlvvf4cG8VzUDxMYDNhCP8GKAZFSkZ6gmPUWAIsoche14M=
X-Gm-Gg: ASbGnctFWcemywxMmpppHkCEK/pCgroBEthlesSPuzebh6QxSt0EMT8wtglHAYPMMcg
	PoBthONuRCEYFFpzbKrY/2KyChYcg5vhboyqVfpm0k9xDX7tPBX0Z7+BjGm909PEoWkZ/onS5rv
	+/k4fsGPuzHZlILe35Tm0gx2sYQ2sOc4ibKO5PjNgRbIqXvvSpYltE3GlgIHdWSHh1NQp3Bc1cS
	4NqrGjuJy+4IOdLaveup/sDeZucvQNF7ZNJhJ2htBLZrffUMBXk5mQWGDRcmumo0Epw7G5LIkJH
	YrctbGMT9oDcfFHls+4EAuuPR3S4F1NJbRqsPvmdoSdNluY=
X-Google-Smtp-Source: AGHT+IFY5Ed96/KcKz8L7aoyZ9lE6qS5z+d/+9NsZ4rcpOBs9+vdKruwDq8O9FLpVqE3mmL4J2bJeg==
X-Received: by 2002:a05:6830:3981:b0:70f:7375:e2b5 with SMTP id 46e09a7af769-726b8f3ab09mr416508a34.6.1738882111587;
        Thu, 06 Feb 2025 14:48:31 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:21 -0600
Subject: [PATCH v2 07/13] iio: amplifiers: hmc425a: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-7-1c5f048f79c3@baylibre.com>
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

Passing NULL as the 3rd argument to gpiod_set_array_value_cansleep()
only needs to be done if the array was constructed manually, which is
not the case here. This change effectively replaces that argument with
st->gpios->array_info. The possible side effect of this change is that
it could make setting the GPIOs more efficient.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/amplifiers/hmc425a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 2ee4c0d70281e24c1c818249b86d89ebe06d4876..d9a359e1388a0f3eb5909bf668ff82102286542b 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -161,8 +161,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 
 	values[0] = value;
 
-	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
-				       NULL, values);
+	gpiod_multi_set_value_cansleep(st->gpios, values);
 	return 0;
 }
 

-- 
2.43.0


