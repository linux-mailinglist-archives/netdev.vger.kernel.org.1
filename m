Return-Path: <netdev+bounces-147970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C439DF8FA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 03:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1045162A46
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 02:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17222868B;
	Mon,  2 Dec 2024 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TND3rqPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2545948;
	Mon,  2 Dec 2024 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733107030; cv=none; b=AMENMDm3nl0usVOIwy9Sj4MmHcrvCkT41aJEdMFsiSgc6NNYusC8lTUPx3AbgVLob7oQ/T0nFb2GX3n0nEnuFk8xNu7Qb+HzK8Hq3pdbxFNOPJ6ulTotWjNhRsNL6nkagH7pH5aU10O+3d/0L3M/xxhB7uB9eHmTYZbYTV9HW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733107030; c=relaxed/simple;
	bh=ZPWWkf8y3PIpl1ZrRUmwZ/M8/KLlJXX6z94I1cyy1oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5VGygbEs1o4cIWUNo2jVGTslaY8J8FKJdUMMBI1WVF7VuNeGO3U16ec3CtUWp2+W0Jm4BvZi3XWRcCotxepS5y9tzZ+f7EG+aXSR6BATYTASdYd4ev4VKPeC0fbPUOmL2pCafFSfhJbVMqas0lIFEZQWJGHMfmRf8TyK+aVek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TND3rqPJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215348d1977so25521015ad.3;
        Sun, 01 Dec 2024 18:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733107028; x=1733711828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt4NnAFdXC2reJFPXxH+iGtIQoMQDkVtQ1A5Cdj5rvs=;
        b=TND3rqPJAYialxIoIg/Ar8VxhJLljCZ1cjVwe3edfOOqG5h6QKF8lodBu10s4xRweG
         42MVO/G5Mo/NGiWYC8RGGfS9TI8GGtCGBdktEOivjhOP2rlQJIAxjYyY3S21xXQPOvBH
         nOCWqeV2udWPsdj7U8zv08a2eOG9nCwkeUcEEugc721LDJ3JAboBDr4/TmsPykKWE69j
         iJrn589FOY7NdhPU0IfbrgKsoLB1VLWm+x+1hgRZCLzORfKkXJ0rL1jTzZdwOmqmlxzu
         zD3uvdOujutBBb00sIqK3sYcnCPJWT+zxCs/vz0i4wlp6MNHOY3qkX/B+752/OvMQgfR
         yPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733107028; x=1733711828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt4NnAFdXC2reJFPXxH+iGtIQoMQDkVtQ1A5Cdj5rvs=;
        b=katY62s/UTaQfrmEYWW8yxJt7/vcU9nmHy/JFB5/wLVYBqadx/Xe0jHfeaH5vzWD3b
         loZtmbjHfhgQloumDAMfzIXFkcB1T/XmXxwrxo5vN0nyZxXwRr/9KkXtpGY/AzMD9px6
         lFxdrLFHtVvO7zzLi4xpWlrArk2QnaOJmz7nY/dyvdYTph/2RfemktvZtuouLhL7AQtG
         7pIz9NIXeZaRDpvWhyPMRAleMTrUwIhzlAS2bo9fYEUn6CT99lzYtdWwBCO0f2431pvD
         QQXJMG0TIWPp6xNLDHnkqYfHmBJqh/0qrJwBTzF3X9Qk6blM1iI/hb4+p/wgXrQ05pxC
         ByGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+iZ6xQcxGjmUdv862ER2b35om+IaVSb8vXvb3VHE0LsS8EyFX8+tDeiOAZVAwkcY8QbFaspkZ@vger.kernel.org, AJvYcCVt7SqJdxb8VYP5dTwcM0ew2h6su5R1pIeTHjsuvb4mb76AAvj9wGgh6EdC1u70X0f+E+QnNdGq43OmVAys@vger.kernel.org, AJvYcCXzhYuGjM6mcMr9wspTQj/p9fu4ehoXJwfidKyi1CXyljWR1bGQ7pyUl7CynVE9f9g+U7UiMvfpc0dc@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2t0rlkHff392cOcjCEbS2fz4a+ng597J0r3sPmRes7k5WITE
	rWE9aeZFNZRh9aUoz5oKhSQbufY5BFzo4ZPnBChIzmodAvB0rMkQi93PM6oN
X-Gm-Gg: ASbGnct0q39oPhvf99Pq6mx1g+GfIOwq9Y2Zq1k9x1Rh9jLO6Wmg52CgCO9z1PU2nBs
	xKPmMlaWJC8s+Pbzh52gdOpVAlrfoL7SYhZii/Eb7dOysEqJFtbdUtIkG9lQm6U6oE/M+Vk/AdC
	XJAofEgUQhZCYi4Q9jvVQ0vloimKqThVI6u8NMOcVINzZG93q/iI1pVcRXUiUx38PM2etRe0t/z
	L/sBd18DN7JOxPp+oxuEGDebHYR5e/OCEsztN1uPyBgiEzFde46nG7t0KruVhlMqbneZqqj+Pgz
	Q/NtwDqWCIkKrjM=
X-Google-Smtp-Source: AGHT+IHG9tioNmTzw/gRzfRn8wxxDcUErSWfYqRhSyvuPLyqeXYrc/COqMFFgjtQSZCuz7fHIUyDNQ==
X-Received: by 2002:a17:902:f710:b0:215:4e52:dcfe with SMTP id d9443c01a7336-2154e52e013mr146944605ad.5.1733107028536;
        Sun, 01 Dec 2024 18:37:08 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159ebee334sm2306375ad.67.2024.12.01.18.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 18:37:08 -0800 (PST)
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
Subject: [PATCH v4 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Mon,  2 Dec 2024 10:36:42 +0800
Message-Id: <20241202023643.75010-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202023643.75010-1-a0987203069@gmail.com>
References: <20241202023643.75010-1-a0987203069@gmail.com>
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


