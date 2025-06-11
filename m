Return-Path: <netdev+bounces-196681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD78AD5DE9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D65188C294
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD5248191;
	Wed, 11 Jun 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="La17B5WS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267EE244678
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665512; cv=none; b=ZQlUsrmHKdCpPdbR46Ln7z83H59/cXaYreRqWUmGeRvOKM6sRmziMpVeGhfcZcnpD62Ttb04JYjFErEZAp/Tu9GZ0mSCFqxIxpN1ZGMr+PDFgEKxiwO0ws+aUF6lOOhv+jp4x9FyPrJiNm9JPGtUEXo6v8BJWnIbA6m6Br7plKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665512; c=relaxed/simple;
	bh=x2LAshC4TaowOHTTAfdCSxFpB1VG0IOM05NdXRo/GcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jcwz0pmwFvO/vpu1SEVO/I3P/NFj6c4JnMLuP1jMzymlM6S2M92b78i774r8PxaMfLVV0uc/dut1HSK9w5EfGMbwRtrtRGICuXd2lrsc1TSP9xQ40R/90FTCgp9t4iHW6O3v6TT+gYXd+JJmouOXB0w/kcWwUtLKJ0jLwQpLD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=La17B5WS; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40791b696a2so37234b6e.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749665509; x=1750270309; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xix0JxJ/wHDD577WOa2daCtZJP2bD7JoNgtk2Dh0B/s=;
        b=La17B5WSB892ulsxuu8IWfqt3gvwiGX6vLPles3ejgFUhPDo1rSwqicwNsvNGkNeY5
         va4Yen8KLLQWCg0RIEhZlaPjB5qWKhqzdaUrbRbTnGz0ggZv6bfewQqT5AhAPnlklCNc
         MkGKDM9vjU4PXibjjkXPdhyk9tsx6idcR3VxmDV3WLfCcQRGJEHqWgG4dHqwLX1Cc060
         Rtc8OxdebYwOP9kbu+rZ2bkjXeEHP+Kc0DgbnNHApP/OjG3Barg7/exfbtWa6J0X2Om/
         S2XDBWzfnrob8e0p9r2l/eozR4AKJNNY0E2rxWzpmGDrwvuT4aaq42+wg2mRu+yExKcd
         gP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749665509; x=1750270309;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xix0JxJ/wHDD577WOa2daCtZJP2bD7JoNgtk2Dh0B/s=;
        b=QjJud6BBHwhrQzCUTp7ZthcZG+MVX+93NmQBzIk+Ogd2ca8c/oR8CoH/ZD//gOGpGr
         sbPqs7jvz9F5AmDbyycLMDGT9GmtFruSUtK1/fkc0vX8COyokP1YSkl/x4qVrrPuYaom
         dS4TCn8ONG99ekj4BYcPppQ8/Ps+ygrHxWHU4Czt9+OniQ0X9ugILfVo7Zr214eNEldT
         aTY4SbcTQHVzAQsysmY0IXrJWurMpO2w381A4jNe82hD1nOazfcpGP1QAqClvltBbXZt
         862FnQiMjt4zH/37pd7L4WQz4nWLJteNFyckY5d2CCzWTfnlMuPd7rFpqJvnP9Tfeil+
         uzRw==
X-Gm-Message-State: AOJu0Ywi5MgnkGxlEMgFW09dDZwNKZzYKJuuMCv3z+AJ+rFhtmdTSGom
	VVDMXmiA603QN/X1VBCXyCCD6F0OhLOVHXEnws44xc4ttVw5MLItMcgc8jbm6BJ/YD8=
X-Gm-Gg: ASbGncv6S4PQLKvHT4dPifW7/O/3G7CafVWjw5mLTIfRzNlwGvFPQ7US+yEDinanLju
	aK9ENd12P4/yeYhObrCJ7UM1JHjGjS3MN/VFHmhjHBoFbzHdX2UwYkwU1eP2M6HDW1G9QexAGSJ
	/JXJdoXo2ys5JjvQTsduyk+FjE7rQgEe0VGu2YJkJfYbBgX9hRyeKo4CY4ItT7flV8PJriu7bs5
	QOleoO87PwmEmlOaeiSFR+OdiduLvs436DRRo3jCjRwXhELQ1RBAkSyDNaT+0OgdcahO3n2WV53
	xGELKgtgLjO4ooU2PxfrFYpKRzdkkXatcUAweols1zZ1+JzyLx8HQMcuROrCod+4wFZJfn43WFh
	ErHo=
X-Google-Smtp-Source: AGHT+IHf9DVkWmbX6t+akoi4x+O8WSA+NWzTIrXuhlLrnn7dTD81mWETTKau86Jvi85i8SCQm9Zr1A==
X-Received: by 2002:a05:6808:23cd:b0:403:25bd:ca71 with SMTP id 5614622812f47-40a6611ea15mr300602b6e.15.1749665509066;
        Wed, 11 Jun 2025 11:11:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a5d94147esm424719b6e.28.2025.06.11.11.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 11:11:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 13:11:36 -0500
Subject: [PATCH RESEND] net: mdio: mux-gpio: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANfGSWgC/x2NPQvCMBQA/0p5s4GkGG2d7eqgo0gIzbM+SNKQj
 1Io/e+GbnfL3QYJI2GCW7NBxIUSzb6KODUw/rSfkJGpDi1vJb8IwTxm5gzNzJWVTaFCSXiAUa7
 YTCphVou2BdWofbKIgSHv5Vl2vdHXDmo6RPzSemzf8Bxew+MOn33/AwhwSfaOAAAA
X-Change-ID: 20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-e0954589da78
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=x2LAshC4TaowOHTTAfdCSxFpB1VG0IOM05NdXRo/GcQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoScbdHEvJMh49ii8PaXm06NcRK+4G6Qji4mc3I
 3TUxFf2n1GJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEnG3QAKCRDCzCAB/wGP
 wLmRB/wJEQPXAFte0Br8P+SmauFUXC8UTnHAKRXPpH8BojKuIfDgrC1wNdEwKMZh46vbXvAHpXG
 X/CnEN+ox+eAjVXNSc3UacvLPk8qycSRXKYCTpvGxvYQkHYWK1R7UCtvBOxpz2DjjEU644pGmT3
 LfnepErKd3uHDNeJ05Ty+/BTVBcEd2GnSv39G5O8k6S3yR8fngUlviT24vd3aa0DXYYemQdpxo+
 JyW6QbNyTBIukj/wjctMDaHcqEIUpA4c1TR0hAcbZ1bMIMVsnU9IqySeJ62zgg92ufZGjWASUXL
 fuMLT31VN/6z6//tazIRidTeyEwxwsL7Oyo/ksv/fkdPY9UD
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
gpiod_set_array_value_cansleep().

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is a resend of a patch from the series "[PATCH v3 00/15] gpiolib:
add gpiod_multi_set_value_cansleep" [1].

This patch never got acked so didn't go picked up with the rest of that
series. The dependency has been in mainline since v6.15-rc1 so this
patch can now be applied independently.

[1]: https://lore.kernel.org/all/20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com/
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

---
base-commit: 19a60293b9925080d97f22f122aca3fc46dadaf9
change-id: 20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-e0954589da78

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


