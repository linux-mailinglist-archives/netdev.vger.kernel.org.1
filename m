Return-Path: <netdev+bounces-164953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B51FA2FD76
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5BB7A2B3B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BCD262D00;
	Mon, 10 Feb 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BJ0usfEc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D3254B1C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227093; cv=none; b=kpWDjUNhJvCQo3+xm8gbJb/GHEmm703FBMxaMtQnFYaOy6XRj33TLR0URAUkYJIRWZfJGzwQ5vgfhws3tVNgyzaA6rzdmshuo6rR1isBPb7qDiIjzg2hip2G5mTIBFpCqGsbs/08kN8aP1VJJHS2ucLiAGe3kM82gV+YRgVFWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227093; c=relaxed/simple;
	bh=S7dgE3UPYoL2oEd02LPby/4FImzR8JSvqPwrh4K9qkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNZkGguYKid9U3bwIDTz2qMtQZcTuo+gCZJA1utIgWwZdauerr3mNtphjO92uIYYuFm2ZA3/5Bdy5LbfVb8/QWis86TiQ6zGxjHuzu3QnUbFxRXFZ7NYD1XLjkXnyaejTT9CT2FJ+9zNs4R/VpZln2upuEDn1SYs0IDEcgjSSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BJ0usfEc; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3b93e4e32so650355b6e.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227090; x=1739831890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wW6RHWEtayZ55WpdhtLO2i1JoETOot8MdB4MGkvPArg=;
        b=BJ0usfEc8bq2iGaNqvnO+QrMUgXM4SZlUqy86xdWNruvIJewuF0mRFPLiTJrvKgBkD
         SjPXKAuhfZoCQlkwLVxSwPryGbpR7fHGwTcWaL8B8PpBUn+bjKC76ATM2e3VE9qQna6J
         B+5N59bxZXtcAONRrE4AThe7VNP4QoM3rAF43E3RumEFvj/I3GwobPkbndcTNDJqN+Wr
         kQOX41HS5dORLNUgDRg0VlhIa0xDaxRzpL3BEY9N3YGYpdQQE+zOUSIQsGC0QMOhrJbJ
         ilScfPVVtamPAZvcWVgMwsr4k0+HYngZSpXAKdfgPw0ott3VUMhIQcvo22BQqYhqlEfR
         9mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227090; x=1739831890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW6RHWEtayZ55WpdhtLO2i1JoETOot8MdB4MGkvPArg=;
        b=bw0Nz5bXqdcKFKJRoonJAcuULw9tg98c6UUoEP2A3llBHPot+06LYFpYbLNS20rL97
         5D8adXutoMD4JgGvZc2FpE8Pq5RAz2GfgHFvi5HKwnWAjtDKZK7J3ohxdjWGG74pYzN/
         of1GHP9bgQiNzUqr4xeFlwYI9/YDbGTkLwjkluljpf9jw0FWpjiKffBZAvg0L7P3vZV1
         7Yj6jJYANnfzY/s3tLh7Nixl2csFi+2cOct5NgyEmGvP3VneGVeuFPC13n3SyoQ1hjqg
         K/BQboDtsRxZH6LoMSRSh3tqD+clcGhGeXKABdWmbr1Pmo3uPzxaABxfpW0tYf2HV4P8
         WSVw==
X-Forwarded-Encrypted: i=1; AJvYcCVXIn5QQhAdT0HrxAjAETYUif4bS4nOCqkznl3C+MYWG00J539lZ17zn61pOFn9lbkXse582lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxamQyEdT81w22C0Km/awF/OYKiTTZRlYL+PYJzocvkVT0ZBX45
	ardqFQDjfcMBwV+dcZI091ZFBSwxQxiMWCuAENyihaFBPHaKIshDNypk6dJcosI=
X-Gm-Gg: ASbGncudtgjmUwSilvLdaKQ7kAaBNybdWzMUBJ8HaV3tMtCVwFl8NeBA1HuvebBamXH
	OYh01NhENQb/yJ5pfP0mbpm0zpay9h2qhXEHw7AJpYjOocQFtrFhgslnCf7xOS8RNm9+f2rUgdx
	CFz4NUWpJtPfJEdzVS9KwzPWOKfNb6j7APyCyBwLoP1tMVQlVQhcSW6/HuzA0XlUt8sbxgjMot9
	2XgJWeVQz+PkLl4ze0fihSeqJz2jYuU7Rk00xS3bXkvHzG2oXzu14wEPBccvoQIACv5gXW9cCX7
	E0UIUxZu4eDMJN+/R2XdSs1K33YWWwACZBeECSWL9JIFdwE=
X-Google-Smtp-Source: AGHT+IExgIdSlhgQSDcOsxwx6WPuocJhwApgTGH7w9m44PNZh2BZdc/bphIdIFYjyr15eu6B7MhSQQ==
X-Received: by 2002:a05:6808:308e:b0:3e6:54c8:fad3 with SMTP id 5614622812f47-3f3c2abf6c3mr690448b6e.19.1739227090579;
        Mon, 10 Feb 2025 14:38:10 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:38:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:39 -0600
Subject: [PATCH v3 13/15] net: mdio: mux-gpio: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-13-d6a673674da8@baylibre.com>
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/mdio/mdio-mux-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-gpio.c b/drivers/net/mdio/mdio-mux-gpio.c
index ef77bd1abae984e5b1e51315de39cae33e0d063d..fefa40ea5227c5a35d89ec2c6f95c6668a2470f6 100644
--- a/drivers/net/mdio/mdio-mux-gpio.c
+++ b/drivers/net/mdio/mdio-mux-gpio.c
@@ -30,8 +30,7 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 
 	values[0] = desired_child;
 
-	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       s->gpios->info, values);
+	gpiod_multi_set_value_cansleep(s->gpios, values);
 
 	return 0;
 }

-- 
2.43.0


