Return-Path: <netdev+bounces-154904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A392A00467
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730571881BE0
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDED1BD014;
	Fri,  3 Jan 2025 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eajhVWZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCC1BC064;
	Fri,  3 Jan 2025 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885997; cv=none; b=hJcWEw6uLtGWd/OCQFGNvj98L18FRiXZApvV5mmNMhJz3sJfNLY+OBVeFKYpnKxyg9jCykxfWGw0wg8DvZLp1LmVLs6LiotuNxdAs1DXIhdoXs/+WmOnjQMDIsOMOcOZR3Z3nIlhsbiBKAJ4TWymG56iQgEoXzsPXetaUs7WCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885997; c=relaxed/simple;
	bh=ZPWWkf8y3PIpl1ZrRUmwZ/M8/KLlJXX6z94I1cyy1oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZZV8cFVcAMIDnlTUktctL5x5HL/5fouodwUlcXd8rKdHwZtCsHgwzgWyREthqUcI41KEzByh1BoWtIyHLqPRoJgDElyGeMEuOg7B5+td7W0njjepmNfqTwZsXI6uL9eoRGdCqR8DSjpmXx6UXqGEE7rSI6I5okYHVT91rP3ibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eajhVWZa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so16520720a91.2;
        Thu, 02 Jan 2025 22:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735885995; x=1736490795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt4NnAFdXC2reJFPXxH+iGtIQoMQDkVtQ1A5Cdj5rvs=;
        b=eajhVWZaThdGtyu5r8g14WCgvwpGZfUMg6F4ig+JKkqUtcxpmFX2JKMsbMaLF16m8J
         EC7VgA7QdfulgrgKt4KJNSkCRhuFkIylKQn4BgFipP5TM387tow9scKnr1WiizAr89Vz
         +Vm6DjUf53jp79TnCwTbuSLLZm+4RHK7sALKUm6GEw8s9LZBmXaAJrKhXX1qIQcDi5/p
         gFWF/rkoImjGFPFk5Wr8yBJkdRS2F5h8YtGmHSGpmHvSI1cgj2Vbx9DXc0PPUEbotP8k
         VJ2+RuM1ks9Ddj94YhEWGsdP4EHzTlArbvXBJjmbMNrj41gvwJIMkzWf8yLicNQqYDH1
         Li5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735885995; x=1736490795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt4NnAFdXC2reJFPXxH+iGtIQoMQDkVtQ1A5Cdj5rvs=;
        b=YVliBKgQsSk41g4SN1VFQFCnRj+9i/4XPfSDOiET2Md7yeTX/7BLfEGn4uSk3VDQ6M
         vp73QY+QAB8SVBai1z0FXfZtnxAQBfAO2vni5AFdpO+XMTc8xnw3Uw1wuzrP069gaK0m
         elav6Dc+kORe4VRWqTiGvmepy+ZkqJThSHVhCckfsLmMk7iJk6RXQamnIV2iYKwYjw8I
         U0yTphErS9Ca8OXa3uUjFBYLNTwU2YliRermt6kBxqNZ31L0J8yFmKFu9WW8HjbTbdwu
         4c5ji0/FRFCemzUClbyzvDnFwhvhLoB05ngLZVSNXLFf5olSvr2Vmj7LgXfZugnB+auX
         XGvw==
X-Forwarded-Encrypted: i=1; AJvYcCUyOif0AK6M2RR+joxf4xOlGuu/qDmSqeeTYXIvmGIjjZ4mlU0h/3QzNSUQK0lKtLahzVRb34hz2GoQ9sXg@vger.kernel.org, AJvYcCW3V5SRo/epvbm1VS9zErcigd1NkMBz2Qx2z7JbK2UD/RUyn1uhYxZQlWJE/ELNA0p9480bQEMmfGkl@vger.kernel.org, AJvYcCXlgRebIZSfa+2eF5E5fbKBAuiqmkAlq5ztq8JqeDD/pJrjQkrGwDCglF5/C74mN0g/BQcT66vk@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAWi3wafPuH48eY6Rm2YDKjpy8tEK3tQnRCk599mGYA8ljAcd
	9VjmvNkRt9ifWYvllgiO4mJ5kVg2QZYPi71wdT5H01+asz6jOy1D
X-Gm-Gg: ASbGncuYrDubWe6fb+1RvZcGoKXijj6GkAGY60SNMVbXgepR8DnF3srK/k720BBMit+
	yJG/ge8RhtNE0jtP4yAOXuXLDOmyH67v0YkKOzQBikei39h8Ld4yBrzxHaJQiqPypEWMhd24abI
	La+EWmbWmetz/0Dhc6IF4bHRQOMNP1ANHRyqzm2/a4PfL/LL+P/2MkIaNGw7vQUl1bVYmulKe8+
	t+uiW1V/QmA680uaOddeABwtEq+IXhVR0PqBxrP2dTkrXXPyiRxSZqBjoKwrXt5tdf2AjWlVU++
	qACdjyuzXKAOVG/S9MVR2g==
X-Google-Smtp-Source: AGHT+IG23kmj6DK+vlZPS0EcCMKK+e9+4Q3xk8hUGRJ9aeWgvaZ8mRigTjEz+v5buodrd7CiMiIrMw==
X-Received: by 2002:a17:90b:520e:b0:2ee:c9b6:c266 with SMTP id 98e67ed59e1d1-2f452e22592mr69746730a91.13.1735885995130;
        Thu, 02 Jan 2025 22:33:15 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26d89asm29427805a91.46.2025.01.02.22.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 22:33:14 -0800 (PST)
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
Subject: [PATCH net-next v6 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Fri,  3 Jan 2025 14:32:40 +0800
Message-Id: <20250103063241.2306312-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103063241.2306312-1-a0987203069@gmail.com>
References: <20250103063241.2306312-1-a0987203069@gmail.com>
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
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 54 +++++++++++++++++++
 3 files changed, 76 insertions(+)

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
index e51b98f5bdce..89712e262ee6 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -379,5 +379,59 @@ uart16: serial@40880000 {
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
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&eth_phy0>;
+			status = "disabled";
+
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
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&eth_phy1>;
+			status = "disabled";
+
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


