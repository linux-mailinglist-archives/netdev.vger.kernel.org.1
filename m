Return-Path: <netdev+bounces-134878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23BA99B6F5
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 22:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75E4282B16
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFBA19B3DD;
	Sat, 12 Oct 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPslhdzm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C0199945
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765333; cv=none; b=Cf5qYDMNLnXabl/lCs5NSplkfzd0iNL+3CHdrJwUKlzJdZ7O0olbWGPbWFS7kmsh5LfiUZ59ckQ6EXvvnNIogoUwunRCm9IxmEn3zNKfuMLBLdBD4cHzVcJui5EVRxM2pIM6Qg6nYpk+xvlTJDb7iryAhSQGcoDPjUJe3XHj32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765333; c=relaxed/simple;
	bh=bR7FC8VWF9azFEsVJCiTQeIR6jO9asrrgxJfaMm3ly8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYgr6SLBzfrjMBnB7IN1Uri67MJ2dqzQY26ppac6568NtZ+QUkYwv5eoImijEH1YZJJWuG+Ia+r4ZCwnOTr09mPhGvfBphhogAp1xHZ0nSG9tqYIYOufZgSDOtGQpKKCK2DbmuurgVEESKAg2WbBRpP6ykchVGKSJhK35g0wZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPslhdzm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a993f6916daso534035466b.1
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728765330; x=1729370130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to3mIiOzBldkugoM8pz4dZYJabZ2oKuPwcC5thWShwo=;
        b=XPslhdzmE9zdbIvAdg79TTadB9L2HT605VIoU4eAF+lbqSsccFnI6SbcFoMYU55bEp
         vzo/GkTlUoXRwgg/iOG/QxSPdY3FXI6Q9i4QcQRzaELBJ9GApxrCDPoPwsTRpcVigdNp
         kvYMJfCzfLoLsN624tm6gMiaxx4AtZdrd3j3hRBPr+eHjVXYWfy+i96h3cKu+O9n1VUs
         rpOigPVDgU3YW4yra119xCvdSVeh0+dogsP7PhKhWlFtxfyAmr80UpbHCDO8ZhG5wfv5
         90OPpQtfhEeHFZSCKOyHqoarsLcVG5Bas+8+z8006y0btiTqHVkoAAL8ax3cFosde4yX
         jAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728765330; x=1729370130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to3mIiOzBldkugoM8pz4dZYJabZ2oKuPwcC5thWShwo=;
        b=jcmRWbQMR5MOjlS/XFaqs375RqKBujpDH7WEEK9PdQz2ykllchlg+TVmxfoL5n7Cbf
         KWBclkKPWB/FWLAUsZndaBhEsB9dpTC5vD8n86kDb9iUtgWNFRPEyBh9ZrGGZF2g69IK
         LwLtD/TH2L2xVyV1IC2t2K1vbSP6FI+mPz9NuExz+EVFXQF/TJA4g0HWtosfwlui3wZh
         p9edHWFXyEvzSv/7Yrf1MGBjCexH6sVFYVxOJ6tDUSgK6137yrl+EWQVOi58iYQNDXu0
         +oOpBX+1rJH+RadcoPxiF76lh3xBGDdKGY307+b8gb97dxiEPm2EhWx5+g9fS2d6GYTH
         1F4A==
X-Forwarded-Encrypted: i=1; AJvYcCVSt4DBNccJd5SKXrh4PF7hH9jmlA3xVyoZAc0tGAXfYfTahBICcxHv0H/vqPfKCBU0wWS4G0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNmL+c9CiiZ0EAucoKF/AY3KzZj0l6dBLB+/NbnJuC6psw6f/
	o51jtx2FdGmio1G1xklZZED6bnwV/Zpu/8Rn5NmBJe+KhJPCiAiNSScpGiA6LqmlwiU6u+054bH
	y
X-Google-Smtp-Source: AGHT+IE1210x3qcH0JfkcF1Jc4lbtcGrzAr3gKE9XtvrMMKxePvpRYucwnKDfDEOSkYQ0LngBoE7NQ==
X-Received: by 2002:a17:907:ea0:b0:a80:f81c:fd75 with SMTP id a640c23a62f3a-a99b8e8ca9bmr655078166b.0.1728765330397;
        Sat, 12 Oct 2024 13:35:30 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372940c1sm3164335a12.82.2024.10.12.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:35:30 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 12 Oct 2024 22:35:23 +0200
Subject: [PATCH 2/2] net: phy: mdio-bcm-unimac: Add BCM6846 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-bcm6846-mdio-v1-2-c703ca83e962@linaro.org>
References: <20241012-bcm6846-mdio-v1-0-c703ca83e962@linaro.org>
In-Reply-To: <20241012-bcm6846-mdio-v1-0-c703ca83e962@linaro.org>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

Add Unimac mdio compatible string for the special BCM6846
variant.

This variant has a few extra registers compared to other
versions.

Suggested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/linux-devicetree/b542b2e8-115c-4234-a464-e73aa6bece5c@broadcom.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index f40eb50bb978..b7bc70586ee0 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -337,6 +337,7 @@ static const struct of_device_id unimac_mdio_ids[] = {
 	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v2.1-mdio", },
 	{ .compatible = "brcm,asp-v2.0-mdio", },
+	{ .compatible = "brcm,bcm6846-mdio", },
 	{ .compatible = "brcm,genet-mdio-v5", },
 	{ .compatible = "brcm,genet-mdio-v4", },
 	{ .compatible = "brcm,genet-mdio-v3", },

-- 
2.46.2


