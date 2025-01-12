Return-Path: <netdev+bounces-157542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1007A0A9A0
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA7C3A7E43
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874851BE86E;
	Sun, 12 Jan 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pugOECaV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC811BD9FB
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688794; cv=none; b=gdzi+3vwRBUSNFT+GMDYuynEKz9R9nUNJA2+0cbeL7GgVvQ6gxHwpgVZIoB3GGq+XxTRWABVfIMqKdtLskUfKoj/7++n3+OWKe2NFbD1JlZCD/5Lh1jex4FJpLOps9ouPRApc8lSLZKP2mq1N4HmOss3bhiUO54uJ7NIj/p37so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688794; c=relaxed/simple;
	bh=56BLcFVoX+7Lw71cTwO9yffs0jhx9suVmg3Qou8SBBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjuW6czA8T3aPh3uqUiK2683yQjvxebJEpqdHeod8Bx9yFBezVKOpRc23Xddo1KaEAxAEJMaBwRQ/lI/zojCPQlZ4wLlnBrqyfVTG+pBv0NU4vJdvvg3TI1pWavDbRUzhUHU2rzAZ9SReKoUGZFmi5xflDIXVl0aCd151E4mI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pugOECaV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3ce64e7e5so495344a12.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736688791; x=1737293591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TB4adxko33N4lxV8vB34w9Deg0raCbTSnaXjgezepI0=;
        b=pugOECaVywPkNHKYFOctHlD9b6dqX5clqRtQswgh5YMCTWn7335ZpHKHSd1pfct/3B
         VDozM3L8TAgBVbfkXT84jkHXoSmRGQ7usVuDQLJ+mT93uM730HxCWpwRRsAdEzMD5VYq
         z7f23ZuWi07erFgpviiB/3Ubi9o5BfQmX9qHtqjHc6TFrOysYyCzIawCBOo4Ry5OzOKq
         Uum5oa8j8UNPQURYxniIa0m9YbbNx1CUMZ3YpwIvLchyBgegF1hH/FGIqDUQTufICNBu
         2NFTCuFmeQDY7c6rhFEn9OAPtAGXXz9g9qpafWYOCxEj3Dc/YtfROqKneM3r11vcBRot
         7FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688791; x=1737293591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB4adxko33N4lxV8vB34w9Deg0raCbTSnaXjgezepI0=;
        b=As2D/9GPhqIY6Uw08osEDxnh5MF08mZ2lJjgiTfaG54la4p87W1u9E0VFp7OnMSYzU
         VXWvgO30CiA3f8qGfIDrKqtxA7qsS/demX9d3zTM2nLppxBL+PoR226bYkxozwoJqrvD
         fmBdGEo6UIqaxy7YuIO3OO0vmgZEH1boa6KecrAVQMtEmc+Dt+lqgRlTyChpcqlE0R3N
         WFVKrRC9dPw4GGN5pc1hFkhQWe+OI7BgJ4ehnEw8usfk5MRy+sOxPrsvlXnhIkXEGwb9
         k1uel810qoIxeSceBVlWBWbVqgM9/sJC5a8nZwmADsfc7KK490E8ojr7Ypkssy58Vr+F
         15sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW5YW2UJtdyDpGvt2xM/HntjmgqZYfrTVYP9P8fo8iH7C2mA+qumIhHSn8X04qKJGHzINJgiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFjoPLxsdQwCES7wxtxdcGr+ffqumdY5oEJuTH9iuN3kvuOdZ
	tAOXrX4vUdv0xJyPqTNBsFRCOAb57Cv+Ya9x4NJ9gR/Ers139HLUJ61/6DwLpxs=
X-Gm-Gg: ASbGncvuoT/os33xRiqBoy/dQBHyCLEF9lUqVTbYnt1KAEkp36R6HWZatPo16mTBqlj
	x7v2mRIl5eTHcTfINsFTSqoJYhY7LM7ZyMUhiz5w/ZdLud4EyJaRxN9hZUFcKRT5uptYQ/p0MhH
	C7l8PntKj1QzAIfCOMGxcLyr0+01vByy8lutZwoinPZ2beAcQd8asi5Px4tx41VHuVrwsrQbjj0
	Lf7vuWY7d+znTMiuS2mNmE5TD1bxBbAAAHHKbJcPTXdChSI2WqeXWCYteYkVF75841O5p4b
X-Google-Smtp-Source: AGHT+IHIeA9RUVsHVjCtYBXrSzIpeTFeEgLh0b/t4eC6XNfpXfMITPN9fmFvIdYvwM7BkZDK6rGKqw==
X-Received: by 2002:a05:6402:2355:b0:5d0:8111:e946 with SMTP id 4fb4d7f45d1cf-5d972e15f45mr5790801a12.5.1736688791295;
        Sun, 12 Jan 2025 05:33:11 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4477sm3584609a12.51.2025.01.12.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:33:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 14:32:47 +0100
Subject: [PATCH net-next 5/5] net: stmmac: stm32: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-net-v1-5-3423889935f7@linaro.org>
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 imx@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=56BLcFVoX+7Lw71cTwO9yffs0jhx9suVmg3Qou8SBBk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng8SEkQmvfABZs7QuVyVH4wapih3fPoh+Xo3JF
 lM90gZIsb6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4PEhAAKCRDBN2bmhouD
 14yoD/9oAXKquSceP15cb4gscg+NjoZ+s/tq5Q7p4hSunWTAFL8/Wd9T3H6hKFgZZce+fKazJeH
 OuMNJ+xcL0SXlWwVY9G4b9YXdEuYoJA6TSXQUiajhx0AbWHblwVbebmLTEJVyYxSPWKdYMkDOM1
 TwZdHK7mwNYgdJvCSJ5ND4AME0ONupR57eCjYKJHW06hflFBoqQ8JoXGpkG1cVrGrD5Yc/OpRdL
 qs0TPrx9Pcx0TLduLA4Y0WEIwAjWwQqipQVQXuiGf7bJDAcmgmrl3MMGhztBFz53tcAzWArA+wz
 vb3OxaD76FgG1AH8bHu1gUF6XiOMqGyO5MNclKzxnq20cnvmD51A9HJVo4AZ6Kn5iyQ2Uc7JAmX
 f852BpZXk+tD20hJ4LWw1CunjrtcZMKrTZs3KwJJqwhYUcylqd5+Jud0bH/kIJ0hy0kr4HV12ME
 3cNiRRBx75ErXkyDnOh85zzcqJ1wHwyKln9Bu5QVcuOFmneuqUyzyCf1YYN/Yo/V1dGEMoThVcc
 Q91OFMfYpRjz4xynGG/SP2H+RVf9RMxS4KE0TyKWEUrX2T7KR3PB9WV0SZsrOss40nqpKqD7WaP
 y8K8kyRxarGD7SGNq5RqQXaHmQcDpKew2kHjLq1oC/56T8THHvlHWulDPgyaCHBrlE/uSvzogDW
 bj/Ib9m93TZhnaA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 1e8bac665cc9bc95c3aa96e87a8e95d9c63ba8e1..1fcb74e9e3ffacdc7581b267febb55d015a83aed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -419,16 +419,11 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 	}
 
 	/* Get mode register */
-	dwmac->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscon");
+	dwmac->regmap = syscon_regmap_lookup_by_phandle_args(np, "st,syscon",
+							     1, &dwmac->mode_reg);
 	if (IS_ERR(dwmac->regmap))
 		return PTR_ERR(dwmac->regmap);
 
-	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
-	if (err) {
-		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
-		return err;
-	}
-
 	if (dwmac->ops->is_mp2)
 		return 0;
 

-- 
2.43.0


