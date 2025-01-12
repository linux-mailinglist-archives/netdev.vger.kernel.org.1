Return-Path: <netdev+bounces-157541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5DA0A99F
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B344188164C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736F1BD9C7;
	Sun, 12 Jan 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTs9SYG5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF71BD01F
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688792; cv=none; b=VGQNSmwNdBKaJ+1npEvaIP3PCwLm0KvNdp65N39sKf+5GgrhceDBRFCCifnOKXg3sCAeVu8xStyRwzu6lxbdmtmvKvnJW13kRSZ0TFl2DWNANCLql/Ko3BHmf3k7Ghc40ak0uegU0NZ9T5v5L6Ed76hRbusoUyemjaYc6wW4YwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688792; c=relaxed/simple;
	bh=NXMkmgaOV2RUkC4HwkfQVhlGXXVP2A5zrSYO2RnmBmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOj2k+Hvgbh8oak4U4ldnJ+P+wrlDq7FQ5q/osycHGcU1gUHhR7jUxOhyyQmiInQwG28oy5bNJVvnHfnkTd2C9cYyu8S2lMP2DeiFZflVHhKl505t6XGvh2KiR9r71KqUPHF3MnNxIVaPI9ndLfYg9ATlIn5Mrq7lBnIR8Zynew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTs9SYG5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0bf4ec53fso632050a12.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736688788; x=1737293588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkxcGNEB2JVbUM+gOy8SUbx7zqelxFkMblu3o9jMzUg=;
        b=QTs9SYG5S8yzyF0gsF24DgiHG4Ch2p/Z98FCjKVNX2EASU7GNbJjvX/G1ZWTgXlh6m
         utcq8gnyWl44Nk07Zq/ZHxT9tN/UY62HdvFhZUEqdtc5gYsE0DruVId6Htjl8nNX1/Na
         yIu+H0Py+1kRBEUWQV8s69Wzdb3wScX7HjBVyMfb539vXGS5JvoWZO9N+GUZU9Y6702n
         oqKzyjS4PWcFw3P0fro94gcphVJnLbCZ0LhIAQhM+FUx2JSxgyJlvq3Z2OiZFcaX400b
         WdpS75FllhfTJQIi0ICiIXJYKakNnrKxTGLiyHxCDHMXXZ1AZKHVt9Dzw8gTzEYDVlWF
         uabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688788; x=1737293588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkxcGNEB2JVbUM+gOy8SUbx7zqelxFkMblu3o9jMzUg=;
        b=fSA6zZnUImO2JmtdNBYBy84sUFL6EgNyD/a0OyQQdHKfUaICNkkk0YsOVrGlcoqLRI
         9Jo+sHDBhzaVtXZcjLXtK/E4bIxkedh7UTUDefpqi0Yw5J4Gg4sRVPA1b1Y2yPdhpR9e
         4cXhbgA9+w9n0bv/HQjuPx7+3yu8q0CHiGikkTbIoGKRB6gHfh4jORMuAhfpRqDZqeMm
         GbCImp+008nHwWDej2GoofqAM/Iw93C9LEi5EfKnkLDfaLIgXcXY62XPN1bJdWTlOLbC
         I/K5///3XuGXh8TZHy5dMxo/0aX8UuWA8/J6GPQbmSVs/N/If26a+DVbOyxOKWDpLq5Z
         Hqdw==
X-Forwarded-Encrypted: i=1; AJvYcCX2RB24K2hMYdEIDMXQdDUiAuuHc136bNb1ljcMq8gid4SKnozaeWgH4lQXKe31YWicRy9o5Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2Ho8vEOAKLExQwpdSkeztSXPUCYwR1jgTmrQ8wCfIRcX9sy3
	RwS28tBbwy68TZjvaC86adeuRwRZtgKZps81bAIBWp8nhbZtme4l6btPFyWntFM=
X-Gm-Gg: ASbGncudud6vL2LBua/diLBLanv+Qt1V1+OzubI6K6q8TszOUQDCXXDr7s7tx1GCIQw
	JcUMcSJ0thae4wyLdWLoJlgSzxCrNkh7Q3oF4ERgG+GA58tKcgg2COXZRF0vIXaezIFssLCJ+fO
	M2kLsjFAQpW414kGsQnhCd+uBVmbWyLwzCMKYMYGnB2y8O7XalHhEwO00L0k7DgnVVydVcH8ywk
	ey9wpKCu2j7+swVqRRMJqlpmtb3pRGKxk8iZqv9T9/hjLSmjsLGIprvpryGtpTaFoL+tFS+
X-Google-Smtp-Source: AGHT+IGF6bnQlGOOJSwmTTavg2zo5fkx649YuwkX2KVGh7yeql8d0d2LdpF/plNT/VzyYLuHpWJzKA==
X-Received: by 2002:a05:6402:13c8:b0:5d0:bb73:4947 with SMTP id 4fb4d7f45d1cf-5d972d26b14mr6157273a12.0.1736688788499;
        Sun, 12 Jan 2025 05:33:08 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4477sm3584609a12.51.2025.01.12.05.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:33:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 14:32:46 +0100
Subject: [PATCH net-next 4/5] net: stmmac: sti: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-net-v1-4-3423889935f7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NXMkmgaOV2RUkC4HwkfQVhlGXXVP2A5zrSYO2RnmBmE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng8SEMvfAj1e6BkujbTFZ72MSWMgcm2SMXQBGK
 GiE3r2n/mWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4PEhAAKCRDBN2bmhouD
 1+CtD/9NYfzUH01iViVY6CFPIesUd//8aqafZv/j9gif1sZe4BnpQWtWRxsUu6VQdMZlDJKE9W2
 glDpCZIW+8lLh+IbsiXM/flGx1S/efHzGzwpjeK7L/+01H4KcEeR/NDg1+8TsGk3d6NX1yF1/js
 HwaSYCG5gF43SPXB2xa/7mE5PMEKpV30x5gImiU69/kQEkU+hG0h7SsxJIgj3xt/HOP5Z2VjmRd
 c4HXi8KAUcvDdEeAC1MKg7tZ39OjLQFztwEufapop5grKUL5tbxEaeZ8o2BlJwG/uCvWOTpXYyE
 XEW+sImdFKOMeKn464A5PXwEu2KkucXyL08nDihzDzhH4RmuG9XNtHs8yCTXvRmIAMtj1eYy2OU
 idW1s7RxvW3VBVusNX1ehUd05WYPYctpK+gqlj4H6DzxGAUuHu7b+vdVjnbFX+XI4UuUpXlkztG
 TkLWHNjvzf6OnOYG86bYh4Dr8IVPiD9ikN4N4rK+xw3ax9d2rsVK1/7ap4qJJt4iRlNaFQa5x89
 prfGPAHxKBpsWwTTUQYDTjGg46zzir0mxKHPl+GxOyLo/9S+3xMdLTt7AAI874KFG7SjGAIgHcr
 JNJ2MvA9XFr3QF2JPTvtkqonyCssxtjXflAge8uhZAveyDIMEC1DiktRW+Y3V0P5Xxfzk03OH8G
 w23Ba9WErAio4Zg==
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index eabc4da9e1a985101643908d2efdb0b4acaa9d60..d30d34fa6ca52e32b10c312c96d462bd6df859d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -199,16 +199,11 @@ static int sti_dwmac_parse_data(struct sti_dwmac *dwmac,
 	if (res)
 		dwmac->clk_sel_reg = res->start;
 
-	regmap = syscon_regmap_lookup_by_phandle(np, "st,syscon");
+	regmap = syscon_regmap_lookup_by_phandle_args(np, "st,syscon",
+						      1, &dwmac->ctrl_reg);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->ctrl_reg);
-	if (err) {
-		dev_err(dev, "Can't get sysconfig ctrl offset (%d)\n", err);
-		return err;
-	}
-
 	err = of_get_phy_mode(np, &dwmac->interface);
 	if (err && err != -ENODEV) {
 		dev_err(dev, "Can't get phy-mode\n");

-- 
2.43.0


