Return-Path: <netdev+bounces-61509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F5482423B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5551C23DCC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8C22313;
	Thu,  4 Jan 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LwzpOVgJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55295224EF
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so419766f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 05:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373325; x=1704978125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef54oPQshoe7Gm//fznSEK5vgc/1PN5IaLbwIyajU/k=;
        b=LwzpOVgJodhygxDlW6YFe6csiuO+9HxvTvMHgGSzjBIotXkjlmxdDH3aG+0f0SCygj
         8iO0lsFZaljaKCf2O7KwfuE6l4VsiYEvzEuhIJm9FrVNVmBxCVZMMXqaz+W/RKf8Kju3
         P0Zw5wJCvw6Ptw27/ujtAnAcdeLNIp0Tdv6hOGIyU2tm0Nq4ned+ArRXem8ESSlTUYXw
         MLgAMP4F8kB2EpWj05qdk6X2udED2FidzfFIeKDOQ08loU2GFowMTWowMofcG67t4lbo
         TrkaRJLuqmU7/Vei5ZS/M3gvByPAJNrJzfRvUTZTa4bMx9Yy65LlHOOe2XdPD78QaK/A
         dKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373325; x=1704978125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ef54oPQshoe7Gm//fznSEK5vgc/1PN5IaLbwIyajU/k=;
        b=AILcu2I1yxvzEQnEL9MalapImXHPfCgtlQqd/po87DtRJWGZhXKyYcg8+wCriAHhKL
         59Va0iXDna1GuW4b2YdT2DbjsYT8Jd5nakeMCREIh7uCEeJ/CCM064sNbfJPv90a2ciC
         Efo2yYQkGMbP5JOuZvs6pjXc2ZYZihuSd+7sYGp6WlHcU6uopWKoaT1hfkk9rLWl4LXC
         RnBBWBpL3Ed0eWbjRjOVAnkOJcc7mYTV0rsoUNuDGVYfU3l/2EcT7M7OZh4zzM6/Z2Jz
         YVFLV7BgsUp8LEzTu0LjCIWmQ552zaFulAvTQZIalYOMMkTFhoR4NfOx4fLk8QtQYS6/
         DONA==
X-Gm-Message-State: AOJu0YzcBbEsFM2VwjNzc+Oprqa/M7rX72s9S6linSVN61FMvCZ+LrJC
	bKsNde3QDA9BPw/YxlvPyHcyrxYH0TQP1Q==
X-Google-Smtp-Source: AGHT+IE3hMjwAGjPrVJAC4uAAQmbYFgXxxZo1RNc4JRLcmBIwG0h5ZwWYvnldKAKE5zO1xwte3fjeQ==
X-Received: by 2002:adf:ef47:0:b0:336:7d86:113e with SMTP id c7-20020adfef47000000b003367d86113emr232689wrp.80.1704373325566;
        Thu, 04 Jan 2024 05:02:05 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:04 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
Date: Thu,  4 Jan 2024 14:01:16 +0100
Message-Id: <20240104130123.37115-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
References: <20240104130123.37115-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the ath11k WLAN on-board the QCA6390 module. Include the
relevant regulators and the enable GPIO.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index cd0db4f31d4a..721f86af952b 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -734,6 +734,22 @@ &pcie0_phy {
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1101";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en_state>;
+
+		enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddpcie1-supply = <&vreg_s8c_1p3>;
+		vddpcie2-supply = <&vreg_s5a_1p9>;
+	};
+};
+
 &pcie1 {
 	status = "okay";
 };
@@ -1303,6 +1319,14 @@ sdc2_card_det_n: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	wlan_en_state: wlan-default-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-up;
+	};
 };
 
 &uart6 {
-- 
2.40.1


