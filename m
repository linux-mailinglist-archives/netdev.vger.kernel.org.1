Return-Path: <netdev+bounces-157540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E582A0A99C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242CC18872AF
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD651B4F3E;
	Sun, 12 Jan 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ4Ner/G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E741BCA0C
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688789; cv=none; b=KlIc4lYKZRN3Grl1ohS1vFbWsKp0Bov6O6btUptCREPWtiVfrfg4LcySCKPA9yLMtOvrXbrnIg7xdxKWZUcYcKgK36InMnXrZh0vG3I0ruaMWNMEK+ovIREl/vUaurUNFPM6Oq2VwmBWnvgOUCeU2Wm0W5sz0LGNMMsdkia4fJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688789; c=relaxed/simple;
	bh=BLKjHvMGwRWG32GZtZYj7md0qQ8nB6LVGjC0kEjtJ8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLcy99Kx6r5i+YBxSOn+Sa8uFFl3aIGH/icrR44MCEJRA3rv0GwQS1ZQWi5oxOBmUMhC0iG335CWnKetjXIrNps7wwjmiwiOwOR+GWckgr1N6A3djzqsHKf27NW4cDRSRKWDjcmWtLxHBK8Kn4qhXe8unB9aHYUbphPCxZi4YTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJ4Ner/G; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3cfa1da14so645515a12.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736688786; x=1737293586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld8ZPAnxgwhvLaqsgPKYU5t+3ZDPQJl13t2skco9HCk=;
        b=KJ4Ner/G7De0aUhC9am2o9zBjx/TANWeZ479tmefZix7WE7xtL/LD5T+tGkw8HZkGn
         t3zkctMkYk2FM8kYaIKvIfW1q1NoIB5Wy3u1c0PUH2iMX2LrvZjr/SUn3lwoX6Nfg5pd
         wpjzA6mE/rtebMbsCN6XsS61oiW1QIAH9bZeAHfh9aEliZhVgmD/JMM8XMQMu/J22NTl
         zOcXhW8bEZvkE+KX35X1rj/pKyQoQOrm+Ej9DpODGbgbJ0oQmuWpZE9XCBHll1Nmv9mq
         dUQNyY+1ydJO9NxZxzDdj9WBAWzA9T7szgnL46ONYa55TwCv6Bg92PPEXjl8mDhlW603
         l+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688786; x=1737293586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ld8ZPAnxgwhvLaqsgPKYU5t+3ZDPQJl13t2skco9HCk=;
        b=MMTj2LLmyOvbk4Gcfig5Zwns8JEmWV7BEGlrfi6NaE4iSTCxMCH0p4birNyrhNkLNo
         877GgXV6E2GoFUD4bF5ZcZsjHsB6daC2k8ouNEASIjuA8ylwpcXZ3sAPsJh+nBq8+3lo
         2bgvq/j72/gY9v8qq2+iDlfz6ca4spzCLoV5nM4gkgKY8ZzbGHdAMPw4hT8lklZEnkcC
         pdAnZ/Np0A6lFB4nmm9Ags5NpGYh7LeXfkpk/UKECwbL6Tpk0gY/0SkdBPU1yJW7C9zH
         Z9OAluaRgiQ0z2YNHbKY4KIv1dpDP3117lB+7EuGlerLjaZEPgogb8DZ02iAjAKU0TlQ
         IhzA==
X-Forwarded-Encrypted: i=1; AJvYcCVNFeA9lXU8G6mOkNSZhlBtMHweFSmLO4bKwewD8HD4ygVlyTgNc/hGLldOdTvjsEkfJCW/lWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw6iFQ83nyQ51Mewx083ZLlyNxpVGil5hHHU5jluZKg1L2YH4M
	gk9XxF4MZggTYifPiyvsGbOL50X+XG0+TaKQ6NLunYFAw03vFsYkgRQy/57PJS8=
X-Gm-Gg: ASbGncu606UgvdooE0mEf1MW0+XvYM56J0aYfjuG8vg121Ne7tf/WjPZRE0+1kKQdtd
	lK5dbIimycMvOqza54f42NLuyMC9725n3ssAhtN5QH6wCpVdzMdFcldS7AlUf/GaNANO/6NkOhD
	cxvG5PvlhMeJzPV0TeI163m5KYfJJSDftxnZDxW2LCv2ZujFPce56omNZvovbH81yMPjdOH9eNN
	OdsFMZGOB8MaZgjZ+rcjPNUFlJUgNMR08qaEotJa6fLMsAvWYpv7TDvst9VN0y2XLTr1pJy
X-Google-Smtp-Source: AGHT+IFHwHH4KKIrysGLvqwXWCgJxLn+t19M/gFmLmYbS8NY9BWAcFiBlWXc9XqfFSlrFDFKeUN0GA==
X-Received: by 2002:a05:6402:13c1:b0:5d0:bf79:e925 with SMTP id 4fb4d7f45d1cf-5d972e65777mr5439603a12.6.1736688785817;
        Sun, 12 Jan 2025 05:33:05 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4477sm3584609a12.51.2025.01.12.05.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:33:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 14:32:45 +0100
Subject: [PATCH net-next 3/5] net: stmmac: imx: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-net-v1-3-3423889935f7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BLKjHvMGwRWG32GZtZYj7md0qQ8nB6LVGjC0kEjtJ8E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng8SDFkc9BxhB/j87J5OokfF6ZsmgjWIg1zax0
 EyCdFlFVjaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4PEgwAKCRDBN2bmhouD
 1x8AD/9Aau/f9uUdyr+OxKVQyIA5u+wnl31VUsMUYoZKktqRD/7R89XQcAZ4Ihv5P8LoYFUuGSk
 Ietj68aVH4LJP5HlzhkuI0R7ergp7NNod0odUeR15RVmyU5WQ9YSj5PvBGpfHdFPuefkEFt1kfw
 6FNRml6vfFv9oNkE/EcY+g5RtQoSyyAzH5P42KSjH5G56gOJaaeUOQzRP45DP89NXKhbwdOz+cV
 IoU4HZYVAU6EnU0frwulSeum1/Wg4j+Je/kk8DjnQqGSTYQJisj6bKHLettlVZ900rN9Kbfcqow
 a+1Xr5Ja4Lh/z7Av0ogch3QekPRI6lnIPkOX1TpY3BXstIKjyO1KQqVuNTO3qUzj7qlei8hNN0e
 kzDgRqCIU6AqAvU+T43YltB33DLbadSqmwoIYu6ezF7TxsYDGuMmqp9DMpPf0sZrlxHKBI4kkYi
 rX+2JHrdxNjwS8F9F1y2KD6jCrNdECHTMq8e9FY3rhyHN6HQE8kVCV+/JvnwQvxdDbtT8dnjQzX
 /7r7MIXSBoXplzcK1f0vBwLGGxL5mjR3/WmzgH5zpEQth7DJvvIj+FU1F2ZZlZ45Tr6t9pStmgb
 P02MIOsocH27LT2DgRYEF7Qv0xxUSKyva8FtwrioyZg7dKpYTmtz3UkJn7bGdPUxEGY1A5W2OKc
 ophfP6EMaGl2RVA==
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 4ac7a78f4b14b95169787538b56dad7f7fe162d3..20d3a202bb8d16743ba4f31fa8ebf19a246e8236 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -302,15 +302,11 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 		 * is required by i.MX8MP, i.MX93.
 		 * is optinoal for i.MX8DXL.
 		 */
-		dwmac->intf_regmap = syscon_regmap_lookup_by_phandle(np, "intf_mode");
+		dwmac->intf_regmap =
+			syscon_regmap_lookup_by_phandle_args(np, "intf_mode", 1,
+							     &dwmac->intf_reg_off);
 		if (IS_ERR(dwmac->intf_regmap))
 			return PTR_ERR(dwmac->intf_regmap);
-
-		err = of_property_read_u32_index(np, "intf_mode", 1, &dwmac->intf_reg_off);
-		if (err) {
-			dev_err(dev, "Can't get intf mode reg offset (%d)\n", err);
-			return err;
-		}
 	}
 
 	return err;

-- 
2.43.0


