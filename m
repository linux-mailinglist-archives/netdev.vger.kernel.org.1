Return-Path: <netdev+bounces-169342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1976AA43888
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8E31689F3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE60267AF1;
	Tue, 25 Feb 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZUEECxt0"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB4267703;
	Tue, 25 Feb 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473865; cv=none; b=M0pp+ihT9eB0ADa/5TXvmpel0xNrsMcCKMf31hJ0VQsmynSq+JvCIOVPHtFXiD39m9NyGX5pV9L4RCCfjUDMn5pOVsd0l0syAvGcUEkS6yYhqgN6R8vGFgbK+uMbYiGINRyTi86PZki8d7FSQyVFPHNwog18kJen0Rflrb/5Z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473865; c=relaxed/simple;
	bh=1+QpmAXRMLqnFnclvfCZDmsPqkITwxVPXq1pgSVO5CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lLQFtQvD//g3hqMxl37eODZEXERgvaySQrrfdVTG6QssomPrM5cd43xRoI8GjsLFi00aMgGg2QVGBlydL6+RWeKN5WV8a5Ec2FaQjRg4a9VFSJvhZZkDle+/AelfbPiWhO/1Mw9S7A74YDb3QlezbxLMcbUZud/tpl00Suk7cFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZUEECxt0; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7xZ5e018143;
	Tue, 25 Feb 2025 09:57:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pKUTLL6CVKfeRMiXGNDAFqyue4eEqDENHzWTiwGjzHE=; b=ZUEECxt0N5CgQ0Fd
	UJTEUAdgDmNEko3nO9YrpArGMrzLijfOebmIEak45kP9LVGTPId+1ZMFVEWZ210X
	GHKEv9DdnIaIPdyfKZm/RwoZoHc1Lnfzis2gwOPS+16RPwVy8BuW27Xf1FhTUrDC
	OT/W6plPx5BACEhC7QnKzfA4rAOoB6zRFCzQyJCXwOi1U6DWvlsHxDUxZQrFEhqo
	tp+QfW43oGRuGkVNGE0gPiMJGYiYDtIDL5MXLGITtErmFh118AGYwr1wKjSr32Zw
	cyBMD0t9WHtaFjga2iNTRNPUOuBUn8MCgmL18Ed7fg78QqjlOARK++lMHQqi7B6T
	DAaGjA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512sqsstr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:57:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 78A4D40092;
	Tue, 25 Feb 2025 09:56:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9AF4B42B143;
	Tue, 25 Feb 2025 09:54:34 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:54:34 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 25 Feb 2025 09:54:10 +0100
Subject: [PATCH v2 07/10] arm64: dts: st: add stm32mp235f-dk board support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250225-b4-stm32mp2_new_dts-v2-7-1a628c1580c7@foss.st.com>
References: <20250225-b4-stm32mp2_new_dts-v2-0-1a628c1580c7@foss.st.com>
In-Reply-To: <20250225-b4-stm32mp2_new_dts-v2-0-1a628c1580c7@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01

Add STM32MP235F Discovery Kit board support. It embeds a STM32MP235FAK
SoC, with 4GB of LPDDR4, 2*USB typeA, 1*USB3 typeC, 1*ETH, wifi/BT
combo, DSI HDMI, LVDS connector ...

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- 'status' property removed from button nodes
---
 arch/arm64/boot/dts/st/Makefile           |   1 +
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 113 ++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/st/Makefile b/arch/arm64/boot/dts/st/Makefile
index 0cc12f2b1dfeea6510793ea26f599f767df77749..06364152206997863d0991c25589de73c63494fb 100644
--- a/arch/arm64/boot/dts/st/Makefile
+++ b/arch/arm64/boot/dts/st/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtb-$(CONFIG_ARCH_STM32) += \
+	stm32mp235f-dk.dtb \
 	stm32mp257f-dk.dtb \
 	stm32mp257f-ev1.dtb
diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
new file mode 100644
index 0000000000000000000000000000000000000000..04d1b434c433e5f76d120f4bd254c15a2de3fb94
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
+ * Author: Amelie Delaunay <amelie.delaunay@foss.st.com> for STMicroelectronics.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include "stm32mp235.dtsi"
+#include "stm32mp23xf.dtsi"
+#include "stm32mp25-pinctrl.dtsi"
+#include "stm32mp25xxak-pinctrl.dtsi"
+
+/ {
+	model = "STMicroelectronics STM32MP235F-DK Discovery Board";
+	compatible = "st,stm32mp235f-dk", "st,stm32mp235";
+
+	aliases {
+		serial0 = &usart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-user-1 {
+			label = "User-1";
+			linux,code = <BTN_1>;
+			gpios = <&gpioc 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		button-user-2 {
+			label = "User-2";
+			linux,code = <BTN_2>;
+			gpios = <&gpioc 11 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpioh 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x1 0x0>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		fw@80000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x80000000 0x0 0x4000000>;
+			no-map;
+		};
+	};
+};
+
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&scmi_regu {
+	scmi_vddio1: regulator@0 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	scmi_vdd_sdcard: regulator@23 {
+		reg = <VOLTD_SCMI_STPMIC2_LDO7>;
+		regulator-name = "vdd_sdcard";
+	};
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	cd-gpios = <&gpiod 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	disable-wp;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&scmi_vdd_sdcard>;
+	vqmmc-supply = <&scmi_vddio1>;
+	status = "okay";
+};
+
+&usart2 {
+	pinctrl-names = "default", "idle", "sleep";
+	pinctrl-0 = <&usart2_pins_a>;
+	pinctrl-1 = <&usart2_idle_pins_a>;
+	pinctrl-2 = <&usart2_sleep_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+};

-- 
2.25.1


