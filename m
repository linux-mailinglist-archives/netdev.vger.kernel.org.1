Return-Path: <netdev+bounces-163679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D078FA2B594
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6823A188585A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C52451E6;
	Thu,  6 Feb 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XdCajTEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA023AE68
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882108; cv=none; b=iCF2u7MK3WYrAs7tdnO67qwX97Y/pmZqQTmSoYC9sawzVuZea33gR5Enq6mkZ6SjHrpHzWiNvLU8GICD/PAxAvX6yapJyG61Shus8xh1nXK9BhUhNNcCP1L/nNk82mJ6FpCiJwYfBHqJmNB6O+s/d8EO4M45k/Jf/b7l69O0bOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882108; c=relaxed/simple;
	bh=SFpLyUrSkeov8lTDekLTl8UML1Z5oaveGJ3pRpViCz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNsFFl4rdRBbzvjY7Ilfl67l8/MUd0La3uucdcsYPWAa3Q0efpAPw3U2Yqr+ABJ0qHvuz98i2FENbqMt9ScKYuiiF+W3yVNkQg6c3fo1XJwejNvRdd3G184MuM556JFUo57qIL+P0gA3XitBD6x9XCvfFgXn9TBQS1PS5y+ZGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XdCajTEC; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e22b2387cso1145389a34.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882106; x=1739486906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dI+YClki4Q+OM8j5JXLpkAENpDyF7Cb60VCru1h+I9Y=;
        b=XdCajTEC8miI59hIeNRWVqWyNKU0u/Pjm/gav4xIFSMuoO1mAKR6GN+q/DZ19uychX
         eIfu/ZSWQiT6qbbOk/9cp9BFlogm+o+4V5KyzwvRpRT09tAs5OUbblKy/AEd91PgNvbC
         zhkFCD8mZDF0PeoIA60IIHGpbisaDClqAd8H6NSGOWzAUvA/94mprp78uiuo3pEWE4lP
         B1pdVApYG4oRuTkSSPJU1hDsRqKzSLCD5SSGbWQpzhQRTffb3SVcjpqTYoJ9PF7V8hOF
         BHNufqWFqn04YSOkLa7WXqb8qtZBANCf4yCxwx0diDLosT5iVlSAoPrpRGWYWubdkTzP
         hjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882106; x=1739486906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI+YClki4Q+OM8j5JXLpkAENpDyF7Cb60VCru1h+I9Y=;
        b=dtHctt/PCXD9i5MqslC9/9197aViq4V0vodsEDqlHezSb34Yq6pvIBbO0t7wsXBYkb
         VF1BU78e8corGJUCOgF9QEhvIaJhZwUW3KF0fyXcfM7R+z8AxM0DgVc+WFaiKfDDdyPI
         5i2BPAZ1TWah7vG1QnSkUI8FNLuloN9CbTDq7Fg16B1P2DY8kcD2EQuMsRJudGcKTX5s
         BUh566lWwmCKiGqCNpBD1BNXy4bLvc4hnFll0nyaHzoIRp1Jru8i7UcSgmwV14FqB4cu
         NwLflZ3WHFv//lz/6zutCpT1bqqM47e0GET87lZar3iyzHm7CFV3e2Q3CQWW72f6orVF
         vvIw==
X-Forwarded-Encrypted: i=1; AJvYcCWTQr8aPQvmVUiXlQpQ3ng1h01ufPha6IrqCYl4BRFrh6XVVygZnDNwsPFNdtFbdQWfpaiOubc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsM0TrFa2YY1i1E7TlliChto5qxZP/2mCFwBncnPgi4Pm6dbB
	NqOJlFFclfPuJwKeYiiHRU+k+0GlCKL2nBvUsNyk/L9evKp6uTmfu9WMPYLLf9M=
X-Gm-Gg: ASbGnctndkeFVTrmDYQp9b9cNuaAV6EXI1wcZ+oxGSstVezjx38L406cgOAYNductCh
	Ruxh2PKXg6u8Uo9JdMkTRHpWLpvsRBbQhw+lztfkvraqr4UMH84p7PSwmRufAzELgIoi2a783fK
	lAXhx3tfhDm5o33yIreFABf38j+t6rZyU9NKZp50T4ls26mDokH/PD7XPN29QDn3+HjJCnG712U
	M0pBVdyPkZQuewM/+Sv4Xngfu9EHTJHk3hzC9RE2wCWL2SYwto/FbRL0/ZJKk5FuMTMJa2ykF+p
	Re5VCRMaYn+RPO8dRigUL2ZQ0CmyEWo8s1gL794HXI2xReo=
X-Google-Smtp-Source: AGHT+IGju4AgrFHpgx+WkS4zNBcn38CgmaIyeMDkbsnAb4rmy84NG+uCyuhvFXnSaOB2zZt+BWiqyg==
X-Received: by 2002:a05:6830:6e03:b0:71d:63fc:2ea6 with SMTP id 46e09a7af769-726b87db6c0mr918380a34.8.1738882105791;
        Thu, 06 Feb 2025 14:48:25 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:17 -0600
Subject: [PATCH v2 03/13] bus: ts-nbus: validate ts,data-gpios array size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-3-1c5f048f79c3@baylibre.com>
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

Add validation of ts,data-gpios array size during probe. The driver
later hard-codes 8 as the size of the array when using it, so we should
be validating that the array is actually that big to prevent possible
out of bounds accesses.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/bus/ts-nbus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 2328c48b9b1260e805c631f2aa7379d620084537..d3ee102a13893c83c50e41f7298821f4d7ae3487 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -48,6 +48,10 @@ static int ts_nbus_init_pdata(struct platform_device *pdev,
 		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->data),
 				     "failed to retrieve ts,data-gpio from dts\n");
 
+	if (ts_nbus->data->ndescs != 8)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "invalid number of ts,data-gpios\n");
+
 	ts_nbus->csn = devm_gpiod_get(&pdev->dev, "ts,csn", GPIOD_OUT_HIGH);
 	if (IS_ERR(ts_nbus->csn))
 		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->csn),

-- 
2.43.0


