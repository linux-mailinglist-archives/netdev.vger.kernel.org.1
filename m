Return-Path: <netdev+bounces-221586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67162B510C0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D274484838
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A4B314A80;
	Wed, 10 Sep 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SCkGzMAs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F23148D4
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491688; cv=none; b=oMbQJ6tOXokaxG3+mzJPpH+ymZXe81sf5jbin0FEgw5ake1slNiQZEtV2c8Diblk012HE4DqiQdBscbrYeNxYUN4JSR3MMDFEC/lnsiZvoCyGjwi8+Z02eDLh6fxVGIZuwI/auGROADguk/gQPwWYhfd1+/BVePQ2uVpHhAQFLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491688; c=relaxed/simple;
	bh=NKTMPnPBEN3JCEgCuFzVlb6Jno24tg0DVRR09XWDb2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZa+jF6flZbSMxpOtjG5MVYitY5dGTMyZwER6PKiuKf3kEYMooTg0ZrFshEmBpxH4wAg1qPUuYvW3FlyCCkAgNeNK9YZIhTroMqv4jXa2rBI6GteGQm+xsAs4LFWoiNkIXVfDnsJZtIwMil5/Ff6bUM3u3Kw1/IgcL0W9QJD7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SCkGzMAs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45df7cb7f6bso2441645e9.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757491684; x=1758096484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdoEjc5e7kQwXoL1Cm6IjPM2seG7Imvb9wLqalhk7Jo=;
        b=SCkGzMAsQFap2dIP0bebgFeHUi0m/8G8rGzTLS1qL5rkj+wWcrZ1ecgYCrR+/oX7ER
         CG6yLimcUUus8b5W3ldaQEAvHwTyjzRBcfR+ZVFoHFeLsOoy/88Iu1qAmC2dLNOoi/bM
         iosxic+/1pMYBowPPiT5a6hrZMuq0dXcHog/5CHveuLF/hfN84l7SIebqacEglVNJ/Rm
         dROvzmhoBlqTwtpr8ehtCZwCTGjF4E3z7klInEe1ri5XC/ydp1Dlv+VBxaqQWytqBUA9
         rlLH+covD3C0Tck4/YoSGalPgfhZnNTS7NXjLibKCDzdKeP7izAPdxlRthsqNz+3ioqI
         QApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491684; x=1758096484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdoEjc5e7kQwXoL1Cm6IjPM2seG7Imvb9wLqalhk7Jo=;
        b=CZ4B0dbcF90Nbbj/Twxti1LLoPBwAsrFTf6N/U0YlIuEdZl7J/+MY+eZfh3TBy/zhr
         G1g/AzH8PhLMoMprx7+zMFs16GwcQuEfeTd0nCkrwzKSEbsEiBNcBL9efq8qBU7BIMrN
         QakXQuBbFUrH3obt90Fk86Tnqet6lz9LR0KWlFmpXMj49jyFLtABwDn7TeMDYl/lEyGz
         qpL+urosE94/q04PYxW0GJy9N5JIZJZ+1yhs87U8j0lJ3xGsfCCnANZHwCTysxT74SkW
         h/O81Ja/z4CsF7ejxY3mtGu1DLUVJgpr0ofc08x8Q3ja1RXiYP1abWqztYJIYJh8bulu
         +9SA==
X-Forwarded-Encrypted: i=1; AJvYcCVeVEwB+5Z8j/CMnV5CjpNViT8cmCoajSbCPMTm6ccihpA0OrF238wxD6xG2a/wM0CxO6UAH7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9vFrFUR/AcP6I4lIJoLwa8OnmzdUXa1VSsO3Jy92Px+gj83I
	NjEiq+OZBYDDc80JHJ3n9WRaDDTTKBSHJN8tp07xBM1L7Tq4xMK0Le03AocXYCOS8/s=
X-Gm-Gg: ASbGncvsNzEgpOR/O0c5hhFX5rK4SjpNqCEMwGdle3N6hVp+qjvh1Vch78pmtcmieL3
	wS24nEEaAjdcxB23hEvcvDy5lPY4q3ot6KLUPRMTXhrFj69GuNWH+ZjJcDl82xzEpXnBLXXmSK6
	vzT2qcsxH9Gu73cm5QTBcN0UGjJwsQbBSsXzEHD8uXPDvh7OFlZXfRuhEHbZ2g5U7hsBz9d9uT3
	N4IJNZNI5ddBApX/bLKlkWk1VsvQIm0U9b85M0bODASgr5cDmh36SsK4RUlrIms4v37mzbH3YOW
	F4lmDAi78Xu/vE605/5f/1b1VNpQwH5N21tOIpyazxf66TwabA2GFPYKTpX9j7clE0BDp8QjG/d
	LYnR21VVXwaTheVQMnw==
X-Google-Smtp-Source: AGHT+IGvVc5t4v/zXXj3XSOg9VlCKaRjy8RNapwWMKX626xKKo9LfhELM3jW9IkDumPkK7A4e7csLA==
X-Received: by 2002:a05:600c:1f11:b0:45d:db2a:ce4a with SMTP id 5b1f17b1804b1-45de07ee7b3mr127598945e9.9.1757491684304;
        Wed, 10 Sep 2025 01:08:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8247cc6sm17813605e9.12.2025.09.10.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:08:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 10:07:45 +0200
Subject: [PATCH 8/9] net: stmmac: qcom-ethqos: define a callback for
 setting the serdes speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-sa8255p-emac-v1-8-32a79cf1e668@linaro.org>
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
In-Reply-To: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=xmsTTIN+xNt0moiTieLp775A3Rxh60igauD1SnixUA4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowTHO6EyrLNmJZzntjQ+QxktZHKsf8HIE32fP3
 DKzaOXZ/t2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMExzgAKCRARpy6gFHHX
 cjAhD/9mxAdGPfan6KTr7LSNd95YNC9Xhm8DikmzNJETYy9C99YxJGy+fco1O7O6JQB/NB2yyqj
 b8H7YlXOcHEWEpajLXslZcKO+MGrldGf+4YySTKrgVI0eJfC2tiKU72AgyWVX8mTvzbCYd/QE1B
 Q/q6VX+d5LcP83v7vJMP+qvyJCEc9zm/AGrV1v67wekYIh0jN+i9PITEBqqCqdHyNeEmhtxXDbH
 BrPBe/0Q7vQH4t0YCui0PB67K2J7bTu2TE3be8u3eJQ+AyDXkQIMGNxfmZ7/SHhPk8ISPRarx6P
 3A/7hoe2nFnpq78Jtda4OWOzSxizgWCwylVbcGAY6N6B1bFwxBkmu3xFk4yvXeO5YueTq7XFbc7
 /SsCnTdkkNI/qwMHtzRaF1aqEy4A8gqomnxkO/icK9cUAGKtvyI4JbAfp9DzrkTsfAkZF6C9Fg0
 yqbqHPKHpiecBRW4GDJZl4YiqP/IA+wPY/D7Pj4VJjpdfID0XsnGAOgonVEzjPxwoPm4C2iKk1W
 Q/P8QkqnnazoP08VI0ZR/oUhxONVStSbiCTJ2IOvWcUYSUfm6/2lJeAvxvQ4l7aQfjFi0mTbUok
 mGTyi/ZSo1b+kDIJ9Swlrh8hlqVaEirtfRm1fTTz0L0md52Fn65DO4rIbsFEm83rxn1oWUZ8KJJ
 dA/04HfQrhChqmA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Ahead of adding support for firmware driven power management, let's
allow different ways of setting the PHY speed. To that end create a
callback with a single implementation for now, that will be extended
later.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 1fec3aa62f0f01b29cdbc4a5887dbaa0c3c60fcd..2a6136a663268ed40f99b47c9f0694f30053b94a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -125,6 +125,7 @@ struct qcom_ethqos {
 	struct ethqos_emac_pm_ctx pm;
 	phy_interface_t phy_mode;
 	int serdes_speed;
+	int (*set_serdes_speed)(struct qcom_ethqos *ethqos);
 
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
@@ -646,11 +647,16 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos, int speed)
 	return 0;
 }
 
+static int ethqos_set_serdes_speed_phy(struct qcom_ethqos *ethqos)
+{
+	return phy_set_speed(ethqos->pm.serdes_phy, ethqos->serdes_speed);
+}
+
 static void ethqos_set_serdes_speed(struct qcom_ethqos *ethqos, int speed)
 {
 	if (ethqos->serdes_speed != speed) {
-		phy_set_speed(ethqos->pm.serdes_phy, speed);
 		ethqos->serdes_speed = speed;
+		ethqos->set_serdes_speed(ethqos);
 	}
 }
 
@@ -881,6 +887,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ethqos->pm.serdes_phy),
 				     "Failed to get serdes phy\n");
 
+	ethqos->set_serdes_speed = ethqos_set_serdes_speed_phy;
 	ethqos->serdes_speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
 	ethqos_set_func_clk_en(ethqos);

-- 
2.48.1


