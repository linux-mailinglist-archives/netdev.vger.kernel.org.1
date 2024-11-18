Return-Path: <netdev+bounces-145770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E09D0AF5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261421F236EB
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2496198E75;
	Mon, 18 Nov 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoQ+yLqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0A198A39;
	Mon, 18 Nov 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918461; cv=none; b=sAihf8k8Qc6zeDY+JFrsjuelwrykZAuzHYXr6u47HCcZHTyJKAcqpuVdSWPmJK3fKuflaqf3x9LIFBM1xOraQoQTzrjNdn8XmB8mvNqTuuvpHpaC3V4u2mHOXVIO1mA6awsm2TDqUiAnHUzCIQmGgQaU2qHx0tQ0rtP1r+CKeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918461; c=relaxed/simple;
	bh=AcqgUlNykGrBzkEGVWnI7M9STpc9AvAeaiWg0EhW70M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFkZft272mDuSL6Uzww+lbWj3x/D6apt+VpjIjxJpw8pPB2dH0QKHROorWo0KOT+kzRYrdh1YcOfsgpMVJIa0ngYWlKZOcrIqskxsVmOlYbfTORdReKXqzB5iiiIsgZ7x7tfh7GMqWtIzSGmxGwFx04BK4m7DIxMEumEE8avuog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoQ+yLqN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cf6eea3c0so35147265ad.0;
        Mon, 18 Nov 2024 00:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731918458; x=1732523258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js4XwaykndxmdA7yiX8pwiKscaOEEt+IBgrF0wpJ000=;
        b=GoQ+yLqNbU0ff3P9TxuQgwGnvF11B3ppDoQ5+RR8TMWsnNeZRkl2qJfV1jUA4vZbez
         oa+G4ni49Hy+hJUHiFTwF5kWNUGl7gTryc10UYf4Va3Z7Kb96zSjTC8Eh78BaLVkRGvH
         LWJKf+RCbTk//ud70dV0HSuRwc47BWJvHC7FbFwD69s6GHLNTzfAs0WSjB8NaBLI7NhN
         shUubOB1goy3OFY0JUuFxGjXoNRcnqS4AyJYDrq1pDb16DOxokwe5HCVBu8fFCo3vJ2g
         sl89Rw9kTuL6ySQnvgKTgYZxBf0ryF3oCTf2hk4SMJG52GwpOscgF0m8HMQrq5E88a56
         knOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918458; x=1732523258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js4XwaykndxmdA7yiX8pwiKscaOEEt+IBgrF0wpJ000=;
        b=MB4hX9YAs9hBhwf33P8V9QCugIfv90uBMw5zBubT6bFytwsUZG0KoXl6IgxTv3TDvj
         QrmEU/Oo+9WjQMN1t7UBNpbHSgJmf+JDX6RnJjYlVamTuXWTsgwriF3Z/smOMUhmdckj
         ljOm8W8VLLjRwt9v0oCp/9fwX5bzwklyQnCzbpqZMnbOEBm2YpB1Xyo99NkLKlGocjfF
         CzYlAQpij2aOKqqhGDylxBFJR6g6Mp62QKEFm1DGwO3g3RAIObyiBJxUB9iEcW7yPHtb
         DvUIBOytgZ369vDN7a2HroJqUdx19W5E2O7fS+OXof7pYvIC2unx18nvYePVriRkiIKz
         E3vA==
X-Forwarded-Encrypted: i=1; AJvYcCUjvg6uR7x8D2BuTNAHPOUnfdu1qrZ1d1eoimggRK9r0NxscOuIBubpUkIrZWxEJu7zbn56aej7@vger.kernel.org, AJvYcCVt9aROLjGwLWINZdxPeREZtU2WH5Q5k/y/sVaPAs8hXsZyYCzvzLRpyyFmpGdUgp/vR2KSTCEkxgdTbBvz@vger.kernel.org, AJvYcCXbhi8Aw6HFG/oDB50XFTvPwPSPmAwrZF8ZwozO8KEH3jfEiRnCByHvs80jC8zbsabtnwcWtDEVunkm@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJnSBo/aCSrkXabdb/hgJ6SwKl0CemBjb8D61W7VoHNZ9hRj6
	0cz40dToYiwYpa3rOmKPMYebmdWAEL3bXDxuWqp77y5wRKYxFTNh
X-Google-Smtp-Source: AGHT+IHsm3Txde2aN86FKECvf2CdflmYt/JDCEML/U6tfMKKmqNWqaQEFWe+BBbYl2dbFEA2ZfGw1Q==
X-Received: by 2002:a17:902:f710:b0:212:c9d:5f62 with SMTP id d9443c01a7336-2120c9d604amr71094745ad.52.1731918458392;
        Mon, 18 Nov 2024 00:27:38 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ebbf9esm51883815ad.45.2024.11.18.00.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:27:38 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v3 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Mon, 18 Nov 2024 16:27:06 +0800
Message-Id: <20241118082707.8504-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118082707.8504-1-a0987203069@gmail.com>
References: <20241118082707.8504-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add GMAC nodes for our MA35D1 development boards:
two RGMII interfaces for SOM board, and one RGMII and one RMII
interface for IoT board.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 12 +++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 10 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 52 +++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index 9482bec1aa57..5cc712ae92d8 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -18,6 +18,8 @@ aliases {
 		serial12 = &uart12;
 		serial13 = &uart13;
 		serial14 = &uart14;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 	};
 
 	chosen {
@@ -126,3 +128,13 @@ &uart14 {
 	pinctrl-0 = <&pinctrl_uart14>;
 	status = "okay";
 };
+
+&gmac0 {
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&gmac1 {
+	phy-mode = "rmii";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index f6f20a17e501..1d9ac350a1f1 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -18,6 +18,8 @@ aliases {
 		serial12 = &uart12;
 		serial14 = &uart14;
 		serial16 = &uart16;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 	};
 
 	chosen {
@@ -129,3 +131,11 @@ &uart16 {
 	pinctrl-0 = <&pinctrl_uart16>;
 	status = "okay";
 };
+
+&gmac0 {
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index e51b98f5bdce..2e0071329309 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -379,5 +379,57 @@ uart16: serial@40880000 {
 			clocks = <&clk UART16_GATE>;
 			status = "disabled";
 		};
+
+		gmac0: ethernet@40120000 {
+			compatible = "nuvoton,ma35d1-dwmac";
+			reg = <0x0 0x40120000 0x0 0x10000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+			clock-names = "stmmaceth", "ptp_ref";
+
+			nuvoton,sys = <&sys 0>;
+			resets = <&sys MA35D1_RESET_GMAC0>;
+			reset-names = "stmmaceth";
+			status = "disabled";
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&eth_phy0>;
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eth_phy0: ethernet-phy@0 {
+					reg = <0>;
+				};
+			};
+		};
+
+		gmac1: ethernet@40130000 {
+			compatible = "nuvoton,ma35d1-dwmac";
+			reg = <0x0 0x40130000 0x0 0x10000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk EMAC1_GATE>, <&clk EPLL_DIV8>;
+			clock-names = "stmmaceth", "ptp_ref";
+
+			nuvoton,sys = <&sys 1>;
+			resets = <&sys MA35D1_RESET_GMAC1>;
+			reset-names = "stmmaceth";
+			status = "disabled";
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&eth_phy1>;
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eth_phy1: ethernet-phy@1 {
+					reg = <1>;
+				};
+			};
+		};
 	};
 };
-- 
2.34.1


