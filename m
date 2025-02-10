Return-Path: <netdev+bounces-164941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDCAA2FD3C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912151889DA0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC070253F34;
	Mon, 10 Feb 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UtsC4PU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2B253F08
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227055; cv=none; b=qq7s9MnvpLBZ8JW3LBaaj+2H+e8e7RKwyB26W8zsvil1B5u91QX0df2oW0XZTZHurzEDBTaIdTkqm5a/qd+vRrGj3BfuQyRIXc8DZBNmXSeigX5eWXBrclIbZUSQgWj3yGxWmnoVWdUrlMEtvAZ1rf/l1oZkaeFBOYjuZjegqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227055; c=relaxed/simple;
	bh=N0Em4RkHQUvBxoy2r74GZrWjDlivg7oqNPXmv4at8dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKrZxxgBVJtf8L1+YTVdZz48QPmVksPOkGw8xldnSK8YGtLoIM9kxtTR4B/XdV9y/yw7TAcSCwC92wP/mOuwtNrQEhhROH4Raao+M/5CxOP5CaScjNk77j6ixiXCJoK93BM/QgApQ7hakrZaERNOwoLXsME0pBF0S1alj5Isfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UtsC4PU2; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3a97b3e26so1138337b6e.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227053; x=1739831853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BdRdts91zZ1lBz7cZl7Oig3MKNc6jPxib3EI6sYvCw=;
        b=UtsC4PU2jEf6Iigi4rlnw6wcpWHJPn9dN1Y/ssJiTHPQO/CZtNRpsBzMfDZlyt/we0
         RHuvVN+hHYkiWa+JZ9v2hwWgZBkL9x+SieJHP5Ac/9ymC+T0V6fuZ9mDkfZyOmRAwJne
         uPbi8Z4raeikVNmyPxq48ndMS9AY4DnshSuYZQXcVYZAxWB6CLw/5yRRn7eHlEkcFFnI
         cWRNaWQ/SNXQXB/fEk3gZ3NBilf2Ay0p8Z3tmcIGDHXh9atrJO+I7wOKX6b+rD/P9Tw9
         bum8f285kxDjh+R4nDlD/oxghHe+83NmYNGeeyjmHMDgAXUxM9+gyp49TVcNafo13Xw1
         0qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227053; x=1739831853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BdRdts91zZ1lBz7cZl7Oig3MKNc6jPxib3EI6sYvCw=;
        b=Jvqzl+Ir62BQcgfEDbP/n09L008GPiJSQypf4bqxe+ly4eYfZEvM82HPUMRzsF+uXr
         PJMoK012LMEOz3bpME5RpED9LsQfLrW1GpU3r40J1TeIoaX1LRgQPBz9kjMTpnzj07st
         e0Z2BQACuTA4zLROo8hMkRx6C7gqNNWyK5mkQ2hJGYGn0okGO8rA4Ib0+8DZXEf7Y8R6
         /UE5asYPlCtFO7FqoFF/4eFxPAvt0XJNSV80QWXBtOODUNm0Y7uLuBFiEJ7iIGaeXhD4
         9QeqwWvl//LwEWdhh3aEC+Hl0J8/qCxIZ8h4kUr1CissawII14NSCaV0qg+P3V3qzfIO
         0NPw==
X-Forwarded-Encrypted: i=1; AJvYcCWsSsK5rth9bH40J2UlfpbKBL5nc394Aw3xO/Y3Ns2PLESsOhcGgz2DHuHOcX8qw3YWNiK9B9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyH+S2ZyGg30txhlwhWGEQbNMwCdI1jYYv5+P8667+Nzb/bzqb
	tJrfKkVXOOf/G0u/Z2A3nLi4STf2PdttiMVHjDkFbUn1YK/z8mYcjPy84qcFd4Y=
X-Gm-Gg: ASbGnctLIdoVsSEFlCLJKUX5CiWe3I3FdZH5+sCWcc7Q5U4HcTrRvX8ZRy1AOPsKm9O
	r+MUfgj7HkSj6Dgi+fJw7JVDtL18uRc/RP7vbzzq/FAIOjtVDtiFRMnwd6zWZ8ybHhSRAw3wX/m
	mPXxzvG0dFF/RR5F60bzx61ZCLprSUT/yjV9GSjt1O66oJnzburOVY3dmvXhJEyMRuZ5KVrSCVx
	jrqr7DY5KpHW0nlCj7WbRZxPupMZJnE3C+G4X4kkowW/hSrS+j9v2kkt9SBk2nhf36/tzAqduKb
	U+mpegAwnsOA8YIhJe5P1gM7icfZRpMHUAgrHFdgh3hbCjg=
X-Google-Smtp-Source: AGHT+IHsM3QlE/6UGVvIOu1IlhPnETs+gBtT/fIeOJD2BqtDOh052hlxzN8ugWj1HusAxyIKgoI2uA==
X-Received: by 2002:a05:6808:1590:b0:3f3:b8c5:4ff9 with SMTP id 5614622812f47-3f3b8c55799mr3309849b6e.28.1739227052973;
        Mon, 10 Feb 2025 14:37:32 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:27 -0600
Subject: [PATCH v3 01/15] gpiolib: add gpiod_multi_set_value_cansleep()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-1-d6a673674da8@baylibre.com>
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

Add a new gpiod_multi_set_value_cansleep() helper function with fewer
parameters than gpiod_set_array_value_cansleep().

Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
cases, the first arguments all come from the same struct gpio_descs, so
having a separate function where we can just pass that cuts down on the
boilerplate.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

FYI, I dropped Linus' Reviewed-by: tag since adding the IS_ERR_OR_NULL()
check isn't exactly trivial.
---
 include/linux/gpio/consumer.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edbd12059826183b1c0f73c7a58ff40..5cbd4afd78625367a761e224acc3f7336d310dd0 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -3,6 +3,7 @@
 #define __LINUX_GPIO_CONSUMER_H
 
 #include <linux/bits.h>
+#include <linux/err.h>
 #include <linux/types.h>
 
 struct acpi_device;
@@ -655,4 +656,14 @@ static inline void gpiod_unexport(struct gpio_desc *desc)
 
 #endif /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
 
+static inline int gpiod_multi_set_value_cansleep(struct gpio_descs *descs,
+						 unsigned long *value_bitmap)
+{
+	if (IS_ERR_OR_NULL(descs))
+		return PTR_ERR_OR_ZERO(descs);
+
+	return gpiod_set_array_value_cansleep(descs->ndescs, descs->desc,
+					      descs->info, value_bitmap);
+}
+
 #endif

-- 
2.43.0


