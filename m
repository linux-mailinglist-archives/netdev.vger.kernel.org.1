Return-Path: <netdev+bounces-64003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6100830A7D
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA182891B7
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB522EFD;
	Wed, 17 Jan 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y3PJUrNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C9225AC
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507715; cv=none; b=ilhV9n3kVm3X+uXC4birJyttgEAYuphKuqmEQA5oqLutg6pmtQcX+0XHr2bYPmtL3d+Cty4YNNvKaSvupSHXA+23xDHI4jGwprNFgz+qtWU059V1Ph8/43KqY6Oh0BXZug1qrlRiSXMc0o+W3o6uGFZzWuwvV9+9lsckKZ+iE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507715; c=relaxed/simple;
	bh=Pg/fENxXcu2zLMeYr9xAi8tTO7TWZmWEho6KkR40EUY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=b3+P9OfUH6e+iXChxCNL/nnImu6XSRdw8IUHYiUG2wTEubwWDQ12lmbnena38URc7KLgmi1aM30/F/EqYbTtjgL8ByL2D871i6c1YpIRluBjcAGuB0HdNSUZ6PN8kUSDB3ObceH2AQDX5+UgfRqz7xaIP0MBIREu8wBcZjG1fFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y3PJUrNB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337c4c9cde2so472452f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705507711; x=1706112511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE8rhVYnIQTzdmEB5YI9mr3bmEjnZIJOH8+2XDSin8c=;
        b=y3PJUrNBP4AUwWq5FuEWkKRR1/1KzL4skJqNfdhG8pMNdxVl/A4sXhWQS72ujgJ6dC
         tfoV8huuyDfUSl/uFbYc3aQoPSFygek8NzsdhNxXJVaY2m4RttX8I+6xnJvwoo+C0V9Y
         7iBJKoItUdwm7U5s3v9abtaFqPQv7GPGS7DP6MEi8sUNg3i/eVLoV8rxtPUtE4BmuxTN
         QvQMR5sGthB/DhMP09AcVsFHH8ybNa6fqS/5m8h+UOPe8y1Nw3dNVcw6XuENHJ35ItUH
         P2IAyAB4/W2xHB+hnXlZv/Off59Yf2ef0K+eNkIVIFu5teKBzcTeFj0+WZCmP8TFHR90
         WBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705507711; x=1706112511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE8rhVYnIQTzdmEB5YI9mr3bmEjnZIJOH8+2XDSin8c=;
        b=GHWSytSWq//D+39LgBVxiyo7u74S9Nh2ry5dgchEiYmU+PPMRDqrBlbTP3krZJEN0F
         rpJdbWI7dncW8rGcRSAygW39bJVJvYiqrS3wJN8fvfSDpXy5+ltl4L1T1pBW/KyaMvBd
         UWil56RXbZCWaveGXHGhcvo7sTzirFWw2s/FNtP5d6xtn1ZQa3M0aE3hIm7AMTZDOkux
         jSQRWMqVfsROe0abRsfvcINHk/ASZ8WKd81hUMAvo1bntu+DR6qNn4HrgaDAcVfD742s
         m2vgfn7rceIhAlZtMkQjQOxilgQqW6Nlsjhf8QHILnz1O9uYCYbAoUzsxXmGgWuDSDR1
         wCbA==
X-Gm-Message-State: AOJu0Yz9Dwz7whfp+o6Kg+HBXo8WYQdbYFDG/PLUpO1mZ6IWOWG2aglq
	pbhF19DA6+bMLEFW/QUQdmTWhoWkhtTOWw==
X-Google-Smtp-Source: AGHT+IHByLRYyKW3b144ASkrglpPI9QJNxChiqmFxutANx4g+4ZbmJ77dmnLmrrxPnGs9ZVDZm3/oA==
X-Received: by 2002:a05:600c:d8:b0:40e:437a:1b56 with SMTP id u24-20020a05600c00d800b0040e437a1b56mr625379wmm.143.1705507711532;
        Wed, 17 Jan 2024 08:08:31 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0b5:43ec:48:baad])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d6a4a000000b00337b0374a3dsm1972092wrw.57.2024.01.17.08.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:08:31 -0800 (PST)
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
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/9] arm64: dts: qcom: sm8650-qrd: add Wifi nodes
Date: Wed, 17 Jan 2024 17:07:42 +0100
Message-Id: <20240117160748.37682-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
References: <20240117160748.37682-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[Bartosz:
  - move the pcieport0 node into the .dtsi
  - make regulator naming consistent with existing DT code
  - add commit message]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 29 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 10 +++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 592a67a47c78..5f960d90e7d2 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -513,6 +513,28 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en>;
+
+		enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+
+		vddio12-supply = <&vreg_l3c_1p2>;
+		vddio-supply = <&vreg_l15b_1p8>;
+		vdd-supply = <&vreg_s4i_0p85>;
+		vddaon-supply = <&vreg_s2c_0p8>;
+		vdddig-supply = <&vreg_s3c_0p9>;
+		vddrfa1-supply = <&vreg_s6c_1p8>;
+		vddrfa2-supply = <&vreg_s1c_1p2>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK1>;
+	};
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l1i_0p88>;
 	vdda-pll-supply = <&vreg_l3i_1p2>;
@@ -718,6 +740,13 @@ ts_reset: ts-reset-state {
 		drive-strength = <8>;
 		bias-pull-up;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio16";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };
 
 &uart14 {
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..1da8b7844224 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2270,6 +2270,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			dma-coherent;
 
 			status = "disabled";
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
-- 
2.40.1


