Return-Path: <netdev+bounces-236730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6AC3F8A8
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 11:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A55DD4F0B9B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C806330E0E2;
	Fri,  7 Nov 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hApn78O+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D031E0EF
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511431; cv=none; b=djqvV3sEsQgv0cv/MI8Z2IyW9CB0quacaK5A40e8GxnXL88yDy9kK+gDfkSpHCrmmhXw6CRGxPA2htZDIALO72cIOxzIf8u5egiXeHfYNekBPefJJ6UzNZLXdxrH5wqU3+T/NnFbkeVrqh2OMPrt2fih28nB7r9YQpoyPCkXkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511431; c=relaxed/simple;
	bh=BTzIyLnQ2pVcjPzl4+AQTmQgi4C/R6FPWEbJ7GZ3dIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUXVo12t0EuZoJv0fY10+A3IV2VwaEMrekhY2qwbvPch7eCika98XpB5g3mt+7MKonXnwrXFQt7pgb70bEM4x/qwiPlpI6/tP91uVFLT8BOZdI8iEYwXRIdGI5GskdGtB9bGANkLrDe0p7qXCK5fuqDFaV6zP69GYzRd+Z2nz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hApn78O+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47117f92e32so4486895e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 02:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762511426; x=1763116226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7G2ramQk2hxdGs1tmlSj6o/OfknwFPaFfxdjJIosVo=;
        b=hApn78O+cXcTB31x5Ha4XSlG8Nc268JYMhOoxokLg1eMV80/mWPTDs78F50z+kS7DS
         bGVjfvuPBI87DdhckB2X0TUPQBYjlwkBkLx9Ow+oqEEmBvSnCx9VO9Pa8n2ZH9cZATwK
         ZAd5UrUgwq8eS9naFy94aGvvfKVTAXsLP9vc7hX9Ua/Ugu6sHnjv/QSVmg7+sABu2mxf
         /zO6Ujb0GPB162/jgl8MGFsQK9QegRmOToO58VkQWsVHgHadivf5W4W6nP3AfTIucAf1
         6KwrJPPao28Nf/a+iXxm44+6BGrSkelwsKwNIkjcm0tnvqSfgxn3X/Lxet3J2YRQXorq
         DqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511426; x=1763116226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A7G2ramQk2hxdGs1tmlSj6o/OfknwFPaFfxdjJIosVo=;
        b=FkIrvJIbOtgDh5OqyGO0ngekvnwPxAh/6Prp4kAqHTPHiAHBRCsJ9gL8IMIgKQv6ru
         bu9dIn+qKlShHIO3gjzVEWPvxFvOpL870J2+jCO31PyonsZGKO2QT6Wj5wT7/KWFR5jA
         +baV9wbmy+EQs5m1jZOyrBoSZy0TvG/VS6hMEwc1awnff1etH5tzjrVB+TPltknQk4+b
         2crprAac8LU8o2HKgKnwdCu1fK749EBbxabEux53pAN3w9q6RGgWZxM0vdoBa+4GyXuI
         RXVHi19CAOVQI6nR9BKAMGDGw+8mDU/8/0oin8ZsJSiEbAC2ZxOBPPf66WgqT200iDqL
         uzMg==
X-Forwarded-Encrypted: i=1; AJvYcCWK01nbREzYoJcswXSVQx83ZRTeN33oSTp77ABUwlKXymkWl1XwmmDJSFjh6X8OvWScvtEi81k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvcl2cuXpZtM2jPN6aqOkM/A1m216jhSrtlRJJ/OVdXQCx9Gwu
	LqpaetEDm5jHrfkJ57Lt6wQK49zM9aUvOfFzVIoH8P3pcsDMb2a8vRqOcLP8RqyZmLs=
X-Gm-Gg: ASbGnctKgOLCyOtUxgM1aNg9Hgy4//cUaRI27gyilQmVLnT84gXpcsS4TEUf3luL0M0
	wbVb0C8gh3fyJXgxF4tNTmdm7DcWWpKPGS7iuqUYTw51yR3h8e30CRfftKyBG5MMGvYoB/W91hP
	mQaoBRwoQZASlHVw2fmD9AriVHsyMPwbnRZoHs84cCTS9gv9EZSfHonfXKGU4bT+DnRdqtdtS1I
	TDF50wWBzp04o1COXjdoQ148ve8uYrwIvJa+BSL/c83ZH9r4CfOU66yOWvpL/zMMSCtpDx/S4zX
	49Vuw2xATHF1A9tCTFGNf0tm4qhuBF6M3hWTbaf3TToNVbtjEe98q+gmTQULACSkZsKWdlcnmIP
	VtcPZaJ5xVt2EQfcqYtB/7YGPtX+zQ8PXNzbaAupxujKt2fRJhi4JP7ZgBCpYWr649w0ATO7ZWq
	G0pP4=
X-Google-Smtp-Source: AGHT+IHIBx2tJqRLVHmEw90vFp0rp7ojXL3UXgjP5mQ5luFxcEaSq2ZhQysTlSzW77Ym94NwaGSiSA==
X-Received: by 2002:a05:600c:4695:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-4776bd04cc9mr22964605e9.29.1762511425524;
        Fri, 07 Nov 2025 02:30:25 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fb6d:2ee:af61:f551])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67920fcsm4414864f8f.39.2025.11.07.02.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:30:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 07 Nov 2025 11:29:57 +0100
Subject: [PATCH v5 7/8] net: stmmac: qcom-ethqos: define a callback for
 setting the serdes speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-qcom-sa8255p-emac-v5-7-01d3e3aaf388@linaro.org>
References: <20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org>
In-Reply-To: <20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org>
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
 Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Keguang Zhang <keguang.zhang@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, 
 s32@nxp.com, Romain Gantois <romain.gantois@bootlin.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Heiko Stuebner <heiko@sntech.de>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Minda Chen <minda.chen@starfivetech.com>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Shuang Liang <liangshuang@eswincomputing.com>, 
 Zhi Li <lizhi2@eswincomputing.com>, 
 Shangjuan Wei <weishangjuan@eswincomputing.com>, 
 "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>, 
 Samin Guo <samin.guo@starfivetech.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Swathi K S <swathi.ks@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Yczz6nmRkpIoGqMAKNVvyF3zmCEkrzboH4PyVFVc9jM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDcopMMZ8M5zQYmizMBW3totvKz7P+ctBnkiJX
 04NgM1FS42JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQ3KKQAKCRARpy6gFHHX
 ckX/EAC9NUTeuFc1Qq8u9nvzBzxll6MRRMehTj3Mt9pnQD7hqBrWvtqc1jkjY1i2hL6D8DqCTNM
 ADwHBwy0x5IGuvWAJgJBtkLFqjNVBn4RkdBeT+fgNbc065JK/E5gq7+k/5CFt5J/F+vtYIMdUn2
 ACgjrXNcC1mGlubZtKqKfS7JYyF+ghRRLlL+Z6JFM77knoDS0e68XGH9wa9xSSur4rV1Z0dP0tL
 fugNnQ1QTejMfr7s8TEqIJUz4LUt9vj/mQK18PmZ/rCG5KRMU5elHEmQpzMMS5Hm4pJr/qghOW5
 hLfCpdzX8hXSeBe4J1Tqbmaepw1sZH76HsiPITTMz4FMAfz1fMDewaqq7RTgZCv2owuCs19v5SO
 ekn0rEpj7GFrQARyyOJ4+BFtm1IM6NXNFoEOec6ol+AoYS3CgMjxn8f2bvBVp7/yoY+kT8yFc/b
 QPgf/DeZGqa+fiZNjmUE5h7gv50ss4MqfK4zDAjPeaMF24qClKLWvvrH45j7PiNQFpa4BTG6D69
 r39IcYnucrELGDsODIPAKsBCAxWjQvw4XF7hlU7iYYvhCdUyyJPGAA5B+oKdpKV/zsULdmpSTQY
 gCuDCRrYfZkwiknvEqG20ltxDvZ66jVSUECOq7C2J0RA5MQwN1aNdvRTV4zOUcQkj0BojlaFihE
 yL6mFKj/t21Xc+w==
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
index 09f122062dec87aa11804af2769ddff4964e6596..446f06b591a0b70992c7a431b56cf88c1b6718fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -120,6 +120,7 @@ struct qcom_ethqos {
 	struct ethqos_emac_pm_ctx pm;
 	phy_interface_t phy_mode;
 	int serdes_speed;
+	int (*set_serdes_speed)(struct qcom_ethqos *ethqos);
 
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
@@ -640,11 +641,16 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos, int speed)
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
 
@@ -865,6 +871,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ethqos->pm.serdes_phy),
 				     "Failed to get serdes phy\n");
 
+	ethqos->set_serdes_speed = ethqos_set_serdes_speed_phy;
 	ethqos->serdes_speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
 	ethqos_set_func_clk_en(ethqos);

-- 
2.51.0


