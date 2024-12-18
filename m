Return-Path: <netdev+bounces-152916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A11DF9F6539
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9B3189446E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4041ACEB6;
	Wed, 18 Dec 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5NOz6Cl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A11AAA23;
	Wed, 18 Dec 2024 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522301; cv=none; b=itsnv9vvTl1w0og3WXWU4zNnE9dTeS7z5okhkacBEC4sgnpryO6MYnlx/qC1kX2ZrE3Wf3BD6G4fC+0ZA2rxRk/anTeXOXJdAX7nyz3rR2fpc1JSZuoU1J789oL7gTbaQWvrMZKJYC4248U64sI8/RwkscxeasIC+0xsqfrfHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522301; c=relaxed/simple;
	bh=ZPWWkf8y3PIpl1ZrRUmwZ/M8/KLlJXX6z94I1cyy1oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouu9IAOr5BPso15L8mQK9R5SLW96JNEDntchGYSsVCO8JUmTzaI5zLOTd5LBe0mAomq4wE5uby5gepYIVet7A1HyAXqU7BFT1+YOti+YoX2+D3edGp76rAJPI8WykYp/fZBUWJ/xJnvmUS/zRoz/BnawPSAP5jgsSCMr0x3HIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5NOz6Cl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-218c80a97caso16957695ad.0;
        Wed, 18 Dec 2024 03:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734522299; x=1735127099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt4NnAFdXC2reJFPXxH+iGtIQoMQDkVtQ1A5Cdj5rvs=;
        b=j5NOz6CljPjRnt41+fb7i2/Jump92hK4mn1C2BGwMx7OZVZb4FzrXFhEH5MnYpCVGD
         ymKLqx4t4htb2UOjouiIxIaxrhCzYD01pn8SZMlEqszx6kPLC2TDo11EkleWjAX+auoW
         v2Vs0adL4KVSTIjsmjqo8nreKzJaM8wT63fXNPsZ4vfL2sOdCY5+GW9MZdhr21qHINWW
         KpfK6FW5JO+6g6hFu2bdIQ95POaZ7JJZwLFPyzIQaj4R17IqPsH7Svxh7NVWh6D0oKXi
         yXCbGTLXE/7Z8XjOe//pQ/H5RQSK7ss9re+Ed6GfVnYQ4JZhI0IYRRekPz2wZYDLGoPp
         TcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734522299; x=1735127099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt4NnAFdXC2reJFPXxH+iGtIQoMQDkVtQ1A5Cdj5rvs=;
        b=BM+veUXbUOcfUB4Jy5K/vatno11ofPbmpGESOI2MnRrXwNZOs4+AJQojAWknjEMjYi
         5u5oGeuai70xE5MkVb+zAO64D4GrdiVM7AGnF47wc0dF49uUB82y2uh7dsX0eR3k0ufk
         7OZCuAO87DgoMWlqprmdRmTWvrInSM7ZB3ePa8jFbLrQCUuPj4Ax+F1NRyjou00drAVY
         LZ1+Wq/mNcV0AyzggxMDJh/71ZiCGfv7BGwgZlmzdTBDcwuAxCcHeBu2eOlKZSSgF6z4
         1UZhxjWtgxAAHlSlpcaEpqH1m3aCa82BnSJbsO+fIjCHy1BbAazNiLyZ/fKC7O2XIwyx
         GMnw==
X-Forwarded-Encrypted: i=1; AJvYcCU3LWPabr/fOnbGPp5q/6tPyv3xSSJ3KXRomFo9/kwWzmXqf/WiAV3Om8Mb3ZBlAnwFbbwiRTyHd3MKpwSd@vger.kernel.org, AJvYcCU8vDAcdu/zCcWyKECUDXR6hjsj9ff8AftOFZ1E4je2sxB6xZJolykfajrHx/nR0lgySGUC2r/5LtUs@vger.kernel.org, AJvYcCXRtInNuyPudv6KNvLI1ojXDfrR7Hsf/NMhsYtHrOkkodUFPMoYnDpapYM0gYoezh4IWivnZHCj@vger.kernel.org
X-Gm-Message-State: AOJu0YxWft3WSc0tkYg3kOR0MwFXW8L+f5udjNEd6vdtOvdL+7dW4QoQ
	Xa4dNwsbLQN3rG4tgTwsHsoKv746bp45ckR7Zmr/k/5oU/dfOYhQ
X-Gm-Gg: ASbGnctwthhYgn9a74NFuGbGqa6yH+eHZ3zp8Y6CuVV9OxHpyADmNxIPl1WK8TrZXsb
	6efPn3I5Ecl9lzvKXzqeYUvMn7N8OjuAGZHIL/r2Fhwd9PleHmR5rm9xUlloV5LWlX12OOLy5vH
	Ma/46qZXM+myfPnVtyUyhg6Pa0PHulNCQpJNBlAXcUAuKDBesgNyDqAza/t2xq0iOY+ZXqe4/nX
	P608CgIzc4E3RB+0GS82k6MVhd/YwhCXB6ojG9ZyY6lZr2VdO6FXaesfAdynddyGY4cmicwafxr
	emxLB46S9nW/wMTNJC7bVw==
X-Google-Smtp-Source: AGHT+IF5Ib/90iPtMR1ImZoOuveUzNiTCwjJb1vOUxqFuNbDY471/cF3KL5yw0aq8vc9EHNJa/MnvA==
X-Received: by 2002:a17:90b:2f03:b0:2ee:8619:210b with SMTP id 98e67ed59e1d1-2f2e9378f01mr3756869a91.29.1734522299091;
        Wed, 18 Dec 2024 03:44:59 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cddbsm1324362a91.15.2024.12.18.03.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:44:58 -0800 (PST)
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
Subject: [PATCH v5 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Wed, 18 Dec 2024 19:44:41 +0800
Message-Id: <20241218114442.137884-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218114442.137884-1-a0987203069@gmail.com>
References: <20241218114442.137884-1-a0987203069@gmail.com>
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


