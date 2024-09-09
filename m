Return-Path: <netdev+bounces-126400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E961971037
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32891C22151
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AEE1B1D5E;
	Mon,  9 Sep 2024 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TVeBlZx8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6C1B143E
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868105; cv=none; b=TBlRPQ9BQ8lVsH3O6+wDEZvqNo+zBxHpuP1Bu8V7xRIAMFXb8sMROGwCwlkuWuychNKVYTY0f2k8YEr+suPOaXpCJ3plQQWCGyblkjG0LkXniBQq0cGYjaDHFwzU1861iK7LFec+pTVYiBt9XbMMDtlnEsKgDp7y5i2u7acGKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868105; c=relaxed/simple;
	bh=gHoIWe4DshAryM3sWTVzuIt+3nqqVmIKyTTPUBOz6MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx5VGekGmYrm2/MceKssmxpCLs7IKxKJD+as9orVyBMkBdUcYcNWv0gLGcCyYrpqC1TgXB7cR7nRwvbJ6TxuTBiaY2YeND8T4pKAB4mqMI52+Z6ECsdsNyMads5pCxWX+hTUMPGfAd2aLJO6f3B7uO3bIY6QCbYfbVkncdgQiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TVeBlZx8; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725868054;
	bh=5FdF3iaUoY2lzZR+9NIbIdVYtZtH02F85kfv8IfYqbE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TVeBlZx8CfUc7C706SJ07sbV3AgKtjDBdBJR+mLO24DeVhSVtD/yvifZQ6gYWPuIZ
	 daYIkkJNR7K8RsLfCpHcHVZMWEugrferlCVq6+6lx4cVTQ3+9OF2GBjNV/AlmeuP41
	 +xJ8Mx8gaaPm6Wk5AcEXuTxPfR/CHNPT9xWmxzAs=
X-QQ-mid: bizesmtpsz13t1725868033tg17wn
X-QQ-Originating-IP: TzYnNEJLZSXkcsiHg6P6agGU+dL18pXPSJ1Y7rEcoMk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Sep 2024 15:47:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18407148698930502739
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
Subject: [PATCH 6.6 4/4] riscv: dts: starfive: Add JH7110 PWM-DAC support
Date: Mon,  9 Sep 2024 15:46:30 +0800
Message-ID: <37CBC770FBB00E54+20240909074645.1161554-4-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240909074645.1161554-1-wangyuli@uniontech.com>
References: <20240909074645.1161554-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Hal Feng <hal.feng@starfivetech.com>

Add PWM-DAC support for StarFive JH7110 SoC.

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 49 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 13 +++++
 2 files changed, 62 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index caa59b9b2f19..0e077f2f02d1 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -40,6 +40,33 @@ gpio-restart {
 		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
 		priority = <224>;
 	};
+
+	pwmdac_codec: pwmdac-codec {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	sound-pwmdac {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "left_j";
+			bitclock-master = <&sndcpu0>;
+			frame-master = <&sndcpu0>;
+
+			sndcpu0: cpu {
+				sound-dai = <&pwmdac>;
+			};
+
+			codec {
+				sound-dai = <&pwmdac_codec>;
+			};
+		};
+	};
 };
 
 &dvp_clk {
@@ -253,6 +280,12 @@ &mmc1 {
 	status = "okay";
 };
 
+&pwmdac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwmdac_pins>;
+	status = "okay";
+};
+
 &qspi {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -463,6 +496,22 @@ GPOEN_SYS_SDIO1_DATA3,
 		};
 	};
 
+	pwmdac_pins: pwmdac-0 {
+		pwmdac-pins {
+			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>,
+				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <2>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	spi0_pins: spi0-0 {
 		mosi-pins {
 			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 621b68c02ea8..9f31dec57c0d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -536,6 +536,19 @@ i2srx: i2s@100e0000 {
 			status = "disabled";
 		};
 
+		pwmdac: pwmdac@100b0000 {
+			compatible = "starfive,jh7110-pwmdac";
+			reg = <0x0 0x100b0000 0x0 0x1000>;
+			clocks = <&syscrg JH7110_SYSCLK_PWMDAC_APB>,
+				 <&syscrg JH7110_SYSCLK_PWMDAC_CORE>;
+			clock-names = "apb", "core";
+			resets = <&syscrg JH7110_SYSRST_PWMDAC_APB>;
+			dmas = <&dma 22>;
+			dma-names = "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		usb0: usb@10100000 {
 			compatible = "starfive,jh7110-usb";
 			ranges = <0x0 0x0 0x10100000 0x100000>;
-- 
2.43.4


