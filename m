Return-Path: <netdev+bounces-169345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD05AA43891
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D5016C06F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81D267F62;
	Tue, 25 Feb 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TbA3evuf"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF38267F41;
	Tue, 25 Feb 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473869; cv=none; b=jdE0vNeHKhJoVrJfQmdRS+eeQFOwJt5Skh1KmtIGiBSILA1I/VLTijShIu4Alw5N6kbH2c/w0cW6DLF3AV8rDi/EugD1sZ5zcLiOQKPCoJOOcdDwR+NuUHiES2k6srJ3NQO1f9CeuPpTPJUXUeqleG4JQmba9K2r05aw2Ebafng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473869; c=relaxed/simple;
	bh=ZTqY3saDDvAT1wcw7L1eQmyRac1ifszGNwkP7G70Cgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=txdLzzCJzsSduXdsfULVwtAnS3TSMF4rP0a3oMbilQVKqayRE8JKwgvqCA3dXc0ZbAsL0ZD7YATna5AEiXnVDT7AsDRTtAJzynxGCiWudFRnFYTtcWgyOYxb9/dqDEEyhK637h4EJaq31Ac+hUks5A1Fss7Eq52H2IeyK4/dR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TbA3evuf; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7rwMq022869;
	Tue, 25 Feb 2025 09:57:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NZKLZnDhtoA+SWJrmqIIJfSU34sSx2ive+Luf1ZpFcE=; b=TbA3evufcbNs7Ncy
	qdR4jauLlZRvdVXkN+CFd0t5JwBhwVhc7pT4Jql1TSMMuMjZqtD/dq5XL0OH5PuW
	i5mU22yNsxvBUybh/Wv10isLZbU8m1VvsqB0yu9z6T0ZalAE/Wm7gO/+SIgA/Z1H
	wevkO9Ghp5KkvoRA7uDhnxrWJqiQkJX4pwadfsaLnhX0zQtv0qlc0hEYL+UFct6f
	wFbogvIQ613Oot35sOQx4V2oBFsDTSasYKM+rGMmmfiDnk9Ms7souw/L4Mk5Z7pR
	oAECyS8CRExs89+tfX8G12TQL+sHHzwhxzdaxCY9sc59W24H/ZWujyMZlM5Vqyg/
	i4xLlg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512sp1uen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:57:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8380640095;
	Tue, 25 Feb 2025 09:56:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5177047D0F2;
	Tue, 25 Feb 2025 09:54:35 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:54:35 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 25 Feb 2025 09:54:11 +0100
Subject: [PATCH v2 08/10] arm64: dts: st: introduce stm32mp21 SoCs family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250225-b4-stm32mp2_new_dts-v2-8-1a628c1580c7@foss.st.com>
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

From: Alexandre Torgue <alexandre.torgue@foss.st.com>

STM32MP21 family is composed of 3 SoCs defined as following:

-STM32MP211: common part composed of 1*Cortex-A35, common peripherals
like SDMMC, UART, SPI, I2C, parallel display, 1*ETH ...

-STM32MP213: STM32MP211 + a second ETH, CAN-FD.

-STM32MP215: STM32MP213 + Display and CSI2.

A second diversity layer exists for security features/ A35 frequency:
-STM32MP21xY, "Y" gives information:
 -Y = A means A35@1.2GHz + no cryp IP and no secure boot.
 -Y = C means A35@1.2GHz + cryp IP and secure boot.
 -Y = D means A35@1.5GHz + no cryp IP and no secure boot.
 -Y = F means A35@1.5GHz + cryp IP and secure boot.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- Comply with DTS coding style
- interrupt-controller node moved under soc node
---
 arch/arm64/boot/dts/st/stm32mp211.dtsi  | 128 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp213.dtsi  |   9 +++
 arch/arm64/boot/dts/st/stm32mp215.dtsi  |   9 +++
 arch/arm64/boot/dts/st/stm32mp21xc.dtsi |   8 ++
 arch/arm64/boot/dts/st/stm32mp21xf.dtsi |   8 ++
 5 files changed, 162 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts/st/stm32mp211.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..6dd1377f3e1d8b2693790179435a9b1b3dfb0d84
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a35";
+			reg = <0>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>;
+		interrupt-parent = <&intc>;
+	};
+
+	arm_wdt: watchdog {
+		compatible = "arm,smc-wdt";
+		arm,smc-id = <0xbc000000>;
+		status = "disabled";
+	};
+
+	ck_flexgen_08: clock-64000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <64000000>;
+	};
+
+	ck_flexgen_51: clock-200000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		scmi: scmi {
+			compatible = "linaro,scmi-optee";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			linaro,optee-channel-id = <0>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,no-tick-in-suspend;
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		ranges = <0x0 0x0 0x0 0x0 0x80000000>;
+		dma-ranges = <0x0 0x0 0x80000000 0x1 0x0>;
+		interrupt-parent = <&intc>;
+		#address-cells = <1>;
+		#size-cells = <2>;
+
+		rifsc: bus@42080000 {
+			compatible = "simple-bus";
+			reg = <0x42080000 0x0 0x1000>;
+			ranges;
+			dma-ranges;
+			#address-cells = <1>;
+			#size-cells = <2>;
+
+			usart2: serial@400e0000 {
+				compatible = "st,stm32h7-uart";
+				reg = <0x400e0000 0x0 0x400>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ck_flexgen_08>;
+				status = "disabled";
+			};
+		};
+
+		syscfg: syscon@44230000 {
+			compatible = "st,stm32mp21-syscfg", "syscon";
+			reg = <0x44230000 0x0 0x10000>;
+		};
+
+		intc: interrupt-controller@4ac10000 {
+			compatible = "arm,cortex-a7-gic";
+			reg = <0x4ac10000 0x0 0x1000>,
+			      <0x4ac20000 0x0 0x2000>,
+			      <0x4ac40000 0x0 0x2000>,
+			      <0x4ac60000 0x0 0x2000>;
+			      #interrupt-cells = <3>;
+			      interrupt-controller;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp213.dtsi b/arch/arm64/boot/dts/st/stm32mp213.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..fdd2dc432edd119fc0169f2a827f30eee9e48f8b
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp213.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+#include "stm32mp211.dtsi"
+
+/ {
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp215.dtsi b/arch/arm64/boot/dts/st/stm32mp215.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..a7df77f928c50ef6bc388498121119bb07d2e965
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp215.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+#include "stm32mp213.dtsi"
+
+/ {
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp21xc.dtsi b/arch/arm64/boot/dts/st/stm32mp21xc.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e33b00b424e1207dc6212e75235785f8c61e5055
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp21xc.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+
+/ {
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp21xf.dtsi b/arch/arm64/boot/dts/st/stm32mp21xf.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e33b00b424e1207dc6212e75235785f8c61e5055
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp21xf.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+
+/ {
+};

-- 
2.25.1


