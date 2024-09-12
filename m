Return-Path: <netdev+bounces-127653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7536975F61
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AC2288FF6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16B126C03;
	Thu, 12 Sep 2024 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IAvMdQtN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE4126C15
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109824; cv=none; b=G3942njcsbWtW+qwrTUN7DPCuHVSd3Q1ZwViaT1WGyYtwk7vL9nI13NVfJMUWGHni/OC2INhSsx6jDIMABaxulFPZZsTzsQbT/adXU3BG4t3DfdA+LRrE/7IXLED8fbC1vgBW4eW6iy1/wYED68i95FLqKj5XD9ymOkHp0cNHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109824; c=relaxed/simple;
	bh=k5k1Ysr62BVhOo/gBfAqHmcJM9ZZy7JPNFr1TW0Nkss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC1hCd4l0Q+wGtCzlvED6OF7cFb3oRxiqDgkNS1a5dciw7e5Nca+MRybC79qBDoIZAtipGjaI+F1fnNZFesh7M9pOJL2ovZdGltnHkJy2IdtV4dMwDG9+zWhdku/QsPPJn0ROIr720co8Rgqv+2AEtv9ZWBmnax+ViwJZJomIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IAvMdQtN; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726109777;
	bh=+EnDZRERSOAudDg8409eRPVKFThSaZM/l4cgteHHwUQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IAvMdQtNFKyxJffmyPZm/gAPpxjP2zq1ukdF0VlkphcexPIf5pfLVACjTGHVlYLgm
	 REByB1PYPsT2ECZv/l3ERrGZ5qmuyDEY106VdwPJqTu7CPEeYjq2lMeqvCrUsnANy6
	 nYoAILiQT2novgHeUKRksmxrCm/sEaRDfpKkaSmM=
X-QQ-mid: bizesmtp81t1726109760tiaowpx1
X-QQ-Originating-IP: jQNHIan+DZA+z5jFRT8s8Ee02LLQhkFG/dOmOvDtljM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:55:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17270031002842427660
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com,
	conor.dooley@microchip.com,
	wangyuli@uniontech.com,
	xingyu.wu@starfivetech.com,
	walker.chen@starfivetech.com,
	robh@kernel.org,
	hal.feng@starfivetech.com
Cc: kernel@esmil.dk,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 6.6 v2 3/4] riscv: dts: starfive: Add the nodes and pins of I2Srx/I2Stx0/I2Stx1
Date: Thu, 12 Sep 2024 10:55:07 +0800
Message-ID: <D2DCF9E2F70EDC93+20240912025539.1928223-3-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240912025539.1928223-1-wangyuli@uniontech.com>
References: <20240912025539.1928223-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Xingyu Wu <xingyu.wu@starfivetech.com>

[ Upstream commit 92cfc35838b2a4006abb9e3bafc291b56f135d01 ]

Add I2Srx/I2Stx0/I2Stx1 nodes and pins configuration for the
StarFive JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 58 +++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 65 +++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 4874e3bb42ab..caa59b9b2f19 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -202,6 +202,24 @@ &i2c6 {
 	status = "okay";
 };
 
+&i2srx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2srx_pins>;
+	status = "okay";
+};
+
+&i2stx0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mclk_ext_pins>;
+	status = "okay";
+};
+
+&i2stx1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2stx1_pins>;
+	status = "okay";
+};
+
 &mmc0 {
 	max-frequency = <100000000>;
 	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
@@ -340,6 +358,46 @@ GPOEN_SYS_I2C6_DATA,
 		};
 	};
 
+	i2srx_pins: i2srx-0 {
+		clk-sd-pins {
+			pinmux = <GPIOMUX(38, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2SRX_BCLK)>,
+				 <GPIOMUX(63, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2SRX_LRCK)>,
+				 <GPIOMUX(38, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2STX1_BCLK)>,
+				 <GPIOMUX(63, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2STX1_LRCK)>,
+				 <GPIOMUX(61, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2SRX_SDIN0)>;
+			input-enable;
+		};
+	};
+
+	i2stx1_pins: i2stx1-0 {
+		sd-pins {
+			pinmux = <GPIOMUX(44, GPOUT_SYS_I2STX1_SDO0,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+		};
+	};
+
+	mclk_ext_pins: mclk-ext-0 {
+		mclk-ext-pins {
+			pinmux = <GPIOMUX(4, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_MCLK_EXT)>;
+			input-enable;
+		};
+	};
+
 	mmc0_pins: mmc0-0 {
 		 rst-pins {
 			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index e85464c328d0..621b68c02ea8 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -512,6 +512,30 @@ tdm: tdm@10090000 {
 			status = "disabled";
 		};
 
+		i2srx: i2s@100e0000 {
+			compatible = "starfive,jh7110-i2srx";
+			reg = <0x0 0x100e0000 0x0 0x1000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2SRX_BCLK_MST>,
+				 <&syscrg JH7110_SYSCLK_I2SRX_APB>,
+				 <&syscrg JH7110_SYSCLK_MCLK>,
+				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
+				 <&mclk_ext>,
+				 <&syscrg JH7110_SYSCLK_I2SRX_BCLK>,
+				 <&syscrg JH7110_SYSCLK_I2SRX_LRCK>,
+				 <&i2srx_bclk_ext>,
+				 <&i2srx_lrck_ext>;
+			clock-names = "i2sclk", "apb", "mclk",
+				      "mclk_inner", "mclk_ext", "bclk",
+				      "lrck", "bclk_ext", "lrck_ext";
+			resets = <&syscrg JH7110_SYSRST_I2SRX_APB>,
+				 <&syscrg JH7110_SYSRST_I2SRX_BCLK>;
+			dmas = <0>, <&dma 24>;
+			dma-names = "tx", "rx";
+			starfive,syscon = <&sys_syscon 0x18 0x2>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		usb0: usb@10100000 {
 			compatible = "starfive,jh7110-usb";
 			ranges = <0x0 0x0 0x10100000 0x100000>;
@@ -736,6 +760,47 @@ spi6: spi@120a0000 {
 			status = "disabled";
 		};
 
+		i2stx0: i2s@120b0000 {
+			compatible = "starfive,jh7110-i2stx0";
+			reg = <0x0 0x120b0000 0x0 0x1000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2STX0_BCLK_MST>,
+				 <&syscrg JH7110_SYSCLK_I2STX0_APB>,
+				 <&syscrg JH7110_SYSCLK_MCLK>,
+				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
+				 <&mclk_ext>;
+			clock-names = "i2sclk", "apb", "mclk",
+				      "mclk_inner","mclk_ext";
+			resets = <&syscrg JH7110_SYSRST_I2STX0_APB>,
+				 <&syscrg JH7110_SYSRST_I2STX0_BCLK>;
+			dmas = <&dma 47>;
+			dma-names = "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		i2stx1: i2s@120c0000 {
+			compatible = "starfive,jh7110-i2stx1";
+			reg = <0x0 0x120c0000 0x0 0x1000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2STX1_BCLK_MST>,
+				 <&syscrg JH7110_SYSCLK_I2STX1_APB>,
+				 <&syscrg JH7110_SYSCLK_MCLK>,
+				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
+				 <&mclk_ext>,
+				 <&syscrg JH7110_SYSCLK_I2STX1_BCLK>,
+				 <&syscrg JH7110_SYSCLK_I2STX1_LRCK>,
+				 <&i2stx_bclk_ext>,
+				 <&i2stx_lrck_ext>;
+			clock-names = "i2sclk", "apb", "mclk",
+				      "mclk_inner", "mclk_ext", "bclk",
+				      "lrck", "bclk_ext", "lrck_ext";
+			resets = <&syscrg JH7110_SYSRST_I2STX1_APB>,
+				 <&syscrg JH7110_SYSRST_I2STX1_BCLK>;
+			dmas = <&dma 48>;
+			dma-names = "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		sfctemp: temperature-sensor@120e0000 {
 			compatible = "starfive,jh7110-temp";
 			reg = <0x0 0x120e0000 0x0 0x10000>;
-- 
2.43.4


