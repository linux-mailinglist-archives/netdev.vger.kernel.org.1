Return-Path: <netdev+bounces-157539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47B6A0A99A
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8A816708A
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC91BAEDC;
	Sun, 12 Jan 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvgEijYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21E1B81DC
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688785; cv=none; b=TjyZ7qrGe3bVniOPByVS7byi1b+PEfy8XqMyrYM/TAogdOQOGvphhCrkpNJW39uy8DfVxPE4WDwQILXQGUPM+wbWcdhJ1egeMiKIM8aIr4Wwhb1mKmnjAvKJb2esmcPmIGeaWWeV5k9QxHGqZ2FIN0MKwglXhmjTrUNb3KrVbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688785; c=relaxed/simple;
	bh=9S7gVVHLbOOdhmOrgxdeq6yW9GeOcGb38tpUZkh03pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0CiuhKTqTGLpmpdCHtFqaKloYwOLFXzhiwHxyR6KDXVL7PfKeRPmNG5Jo3OQEk8vjbru3Sqg0oKeJ+zbkyN2iM0phM0fhAVAsqKRl15Mc3J+4AG76e54ViRngLDsry4KxDvE3jN2qJe+IO55V53Fl1cjhibzG1mpG/VjnR4Pxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IvgEijYQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d8753e9e1fso631256a12.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736688782; x=1737293582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOVqy08C6GsLjB0sMrq2+YSaSxUnwU9JmLZUrKlTUz0=;
        b=IvgEijYQvbnrqu88gunNW/qw7wuuVPToGuP+J7nXymG2wkqerx95mZKDC2xdXAFXGg
         pJrgIJrCX9pSV1cNPummBHm4ikQdf5pgaSNQ/zXrhmw6C0m/z/84Pa+S8NOS8pNzgDO8
         NeiI/xMEARaNWFbmUebWUglU25zfznu9b95KlqYJbKRsHWjk1iPqIMrJDMNXc4LkgR9A
         6iHLJcSk1MXo88bBq3JiRSFRpa6BeAQ2A7CDZxbHcCXHOcZFA//V3tQ7MenvISOdDQeu
         KfEKjcVni2WSxIb3LgUaR6eXf5NEbWJRwN9Yd9SQMr+OJxponSVgCQl+xNvMrKFDNkRy
         u4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688782; x=1737293582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOVqy08C6GsLjB0sMrq2+YSaSxUnwU9JmLZUrKlTUz0=;
        b=KOZwTbtKfi+3cythMtlAnOL6VRTMZbr7saEBTVQCoWhUB6ZRqUGG/l7upkFCMKxMb5
         UXaJa4/1k9mKw4nIC6n4ypczo1xB+4naF1f5uNZSXFUNB6mKNcmImLN3uhNRosln3e6O
         po3e2/IeE3FU4yZv/lJuLkwys2vTVVK1oWEtk5iIWS6LpsO4ui/3xlfi5I0q3yd9FFKs
         a0eNYKJ+jhmfcRR7Wx1acS5dhuz+9JegsMtDsTLZq3jFcKDZsiGRjhFzadL/CshoUTqn
         bbRgFC3MxPCf/vI1inYpmfISAxlIAND/iwZ1QDXDYCyzBd3Q+ueaG9QR+CmyG2B5VkBf
         55iA==
X-Forwarded-Encrypted: i=1; AJvYcCWEvJMR11K5izc9QBDDvtiupznbTuzngVJc4oGgajJtSusAGAq/0nkXXRZjut8MDWeRNdQam9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeKgB+7/Npo4hTZjut50zfE+Vd0+E3a2liUPVM+cskiHupLlO
	APHifFB/n/3nlfOe9len3PSiHUtoK7EHTbyMd5sGddJqEv86kZxTfvW/XVL+UAA=
X-Gm-Gg: ASbGnctKXLY8hBkXD7W4EsfQe2VfgI8NLwni1ObhnAzLpYCUJ1TYb22UhSl0TZJOT0o
	PyGrDoPHcNO8K3D+uZy4qSoplMVv1MRVKL87bChGqc3Kz1QHh9UKV/j+8ZWRmjA8oXCczUK1Xec
	X+PQeWekrDy86tHMLqyv53oL4/icxHtwGulKlm7u/ETbker8UoLoaTC3ueo2e9CCbB94ZMvQpTC
	9TzmueBEvx2r7FKKUIbLBs/kfJprFDW4o97dT/KPB1i8gtKUJnI7B6seizzZySlXMiiAEo0
X-Google-Smtp-Source: AGHT+IHAPDDqI1itoMeCFKalJTN43D2b88pk2KL4TDUxwjUyr+2n3z7I5NTnbvxsw1RUzD8twrEPcg==
X-Received: by 2002:a05:6402:5206:b0:5d3:d747:6496 with SMTP id 4fb4d7f45d1cf-5d972e801dfmr6260298a12.10.1736688781780;
        Sun, 12 Jan 2025 05:33:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4477sm3584609a12.51.2025.01.12.05.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:33:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 14:32:44 +0100
Subject: [PATCH net-next 2/5] net: ti: icssg-prueth: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-net-v1-2-3423889935f7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9S7gVVHLbOOdhmOrgxdeq6yW9GeOcGb38tpUZkh03pU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng8SCCW0MlfjlA9K1TjLeHUu3QGRRtM/WgAZoC
 WMtHJkHeVGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4PEggAKCRDBN2bmhouD
 10+YD/9A02R/3MQQubS4ahQZTK/vIgEnDoLeLOZ2z6ur0SaSsl8P8g2c7riLLdYF92lSsgr7uRd
 jmeT9wLRxCkXUvDb6BlQcaqDWHzdA8yCfatXJo3i/2gmM28IQU0DZHciCQ9Er059Bd1mWk1TZDp
 LNC55whGCCGmpzxIn2wGaL7HylIHDR0oWZ2JQ+IBGe4+Iw2oTVS4tPErPl7ysAZCJbqOl8oHjI4
 ijfACgxQuzSwv72lLqmbXddZZ5BsAbYIfA0ql2sUIVsXx7/dcdo+J+1922mAUQcDtuQ3L8YdsK1
 nrT2AECb9AT2yQFJUWCFgml36SGT/AAGcCDFhEGrSm5sqmRhO+pbePafGg1SzeB/ykFZP8pbtmI
 kYyHMLG58LuLSM9wBwV7e230On5UeKDGtoQB2lhdPZqpTAypo/lNglE9T0jBII67mTOsel8rhNY
 8eWLdF/Ir8VjBmMK66BDKbEGh5NscM7qzw602iC1Zf4w/xVnMqR/P6ukm9kumXSAueVzXvGHj4P
 /9tyS3lSciwxAHxVcbKlC5/9XPgtg7i/7Ij3eN0jCdXqwbClXlaRNEYPaQ6bGPpOj4Ozpq7FzLc
 BDYupKiqx9fiH26x/CdTVFDC0seiQ9ZBJW9cttHi/2Pr2k57jYb1KWuMCQeroyLpY+MEyUYCjfb
 o98tiqTnTayP/uQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5465bf872734a3fb9e7e481d556eaec3cce30e0e..68f1136e3db725eba239b10f337786ac735030ca 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2559,20 +2559,15 @@ static int am65_cpsw_am654_get_efuse_macid(struct device_node *of_node,
 {
 	u32 mac_lo, mac_hi, offset;
 	struct regmap *syscon;
-	int ret;
 
-	syscon = syscon_regmap_lookup_by_phandle(of_node, "ti,syscon-efuse");
+	syscon = syscon_regmap_lookup_by_phandle_args(of_node, "ti,syscon-efuse",
+						      1, &offset);
 	if (IS_ERR(syscon)) {
 		if (PTR_ERR(syscon) == -ENODEV)
 			return 0;
 		return PTR_ERR(syscon);
 	}
 
-	ret = of_property_read_u32_index(of_node, "ti,syscon-efuse", 1,
-					 &offset);
-	if (ret)
-		return ret;
-
 	regmap_read(syscon, offset, &mac_lo);
 	regmap_read(syscon, offset + 4, &mac_hi);
 

-- 
2.43.0


