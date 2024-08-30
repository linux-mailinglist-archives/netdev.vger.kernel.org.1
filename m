Return-Path: <netdev+bounces-123763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7D966701
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A22B22DC0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737681B5313;
	Fri, 30 Aug 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="z/ZRnFkF"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF61B3B15;
	Fri, 30 Aug 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035563; cv=none; b=oqinFog2yJR9TIX0T4frefmzkcT40mxcRFp88RN9dOEGulWVdzNln8uvT23FkTxU82IItWeKhiKhaIMvCQZHrVDiz3uC4zcj6wh3aA8A5IkwQcPBj+O9r9kmSi01RBezeqIdj2TWJVhJiTmjBZQfonkyu2SMSWqlmgDDJpU3tVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035563; c=relaxed/simple;
	bh=Xl0EjAGs2nU5Ssm05KI6rgq6aZCNyjGmQ3ivJtiLTAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rr+W6Y9wQJpkdkYUfEBZll+ijlUjsr1Vw5xi1v49mnnc++/l9dgSCB4nGA+5MSrLvVJy+JQrKSnoA2JUKwq/WnS7M0ctedH2/+ynPmJE/A13gDTWfvpa/4o6BBC+qu+tHdahen0HqT3nWsrUtLd2p+vTlylK1aLXSVnPTrzLifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=z/ZRnFkF; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UCDrpp030260;
	Fri, 30 Aug 2024 18:32:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ZJGV+r2KU6QNsT7JF7Qw5kW6wzhJAglNXdCnyUg5r2I=; b=z/ZRnFkF8NKderxI
	kyIO0d4im/co9TqDntHt3QQhl8QZJ0w15wiJ9QLUCJg8SK+SJjpLa1HpjUVjx2eF
	u2gkEmvkG6QCSL/vrnzrsFsolL78TPVK1TTWKFiP79eRMKjvDnE8YFUO3cFlfW+T
	M9RR+lwW+PZ4H5eIqsoUUOkc3hWadxD44xvByGKS2EVyUCIg5sRmj/hdASU0Jdbm
	VEpsJGorLK55ogdZjdWn9euJOAc0R1cvTpPoRAeYJM8I9Nr7Um/bcpooM9s8XBm+
	VfnpEelsosD2iZsa2ktMcJ+0mEf0FaX8a0bVHFo1+txeIagt/8qOLsTye96dJ3si
	Ti3aNQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41b14tbrdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 18:32:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7F9F54002D;
	Fri, 30 Aug 2024 18:32:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB71F27F643;
	Fri, 30 Aug 2024 18:31:45 +0200 (CEST)
Received: from [10.252.12.18] (10.252.12.18) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 30 Aug
 2024 18:31:44 +0200
Message-ID: <2d1c6db6-eb78-4c0a-aca7-2916bc7ef4d1@foss.st.com>
Date: Fri, 30 Aug 2024 18:31:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm: dts: st: Add MECIO1 and MECT1S board variants
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: David Jander <david@protonic.nl>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>
References: <20240809091615.3535447-1-o.rempel@pengutronix.de>
 <20240809091615.3535447-2-o.rempel@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240809091615.3535447-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01

Hi

On 8/9/24 11:16, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Introduce device tree support for the MECIO1 and MECT1S board variants.
> MECIO1 is an I/O and motor control board used in blood sample analysis
> machines. MECT1S is a 1000Base-T1 switch for internal machine networks
> of blood sample analysis machines.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - convert all pin reconfiguration to &{label/subnode} format
> changes v2:
> - move stm32.yaml changes to a separate patch
> - remove switch reset for now. sja1105 validation should be fixed first
> ---
>   arch/arm/boot/dts/st/Makefile                 |   3 +
>   arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts |  48 ++
>   arch/arm/boot/dts/st/stm32mp151c-mect1s.dts   | 290 ++++++++++
>   arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts |  48 ++
>   .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 527 ++++++++++++++++++
>   5 files changed, 916 insertions(+)
>   create mode 100644 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
>   create mode 100644 arch/arm/boot/dts/st/stm32mp151c-mect1s.dts
>   create mode 100644 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
>   create mode 100644 arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
> 


Applied on stm32-next.

Cheers
Alex






> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
> index 015903d09323f..eab3a9bd435f5 100644
> --- a/arch/arm/boot/dts/st/Makefile
> +++ b/arch/arm/boot/dts/st/Makefile
> @@ -35,8 +35,11 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32mp151a-prtt1c.dtb \
>   	stm32mp151a-prtt1s.dtb \
>   	stm32mp151a-dhcor-testbench.dtb \
> +	stm32mp151c-mecio1r0.dtb \
> +	stm32mp151c-mect1s.dtb \
>   	stm32mp153c-dhcom-drc02.dtb \
>   	stm32mp153c-dhcor-drc-compact.dtb \
> +	stm32mp153c-mecio1r1.dtb \
>   	stm32mp157a-avenger96.dtb \
>   	stm32mp157a-dhcor-avenger96.dtb \
>   	stm32mp157a-dk1.dtb \
> diff --git a/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts b/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
> new file mode 100644
> index 0000000000000..a5ea1431c3991
> --- /dev/null
> +++ b/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) Protonic Holland
> + * Author: David Jander <david@protonic.nl>
> + */
> +/dts-v1/;
> +
> +#include "stm32mp151.dtsi"
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15-pinctrl.dtsi"
> +#include "stm32mp15xxaa-pinctrl.dtsi"
> +#include "stm32mp15x-mecio1-io.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Protonic MECIO1r0";
> +	compatible = "prt,mecio1r0", "st,stm32mp151";
> +
> +	led {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_DEBUG;
> +			gpios = <&gpioa 13 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DEBUG;
> +			gpios = <&gpioa 14 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&clk_hse {
> +	clock-frequency = <25000000>;
> +};
> +
> +&ethernet0 {
> +	assigned-clocks = <&rcc ETHCK_K>, <&rcc PLL3_Q>;
> +	assigned-clock-parents = <&rcc PLL3_Q>;
> +	assigned-clock-rates = <125000000>; /* Clock PLL3 to 625Mhz in tf-a. */
> +	st,eth-clk-sel;
> +};
> diff --git a/arch/arm/boot/dts/st/stm32mp151c-mect1s.dts b/arch/arm/boot/dts/st/stm32mp151c-mect1s.dts
> new file mode 100644
> index 0000000000000..a1b8c3646e98b
> --- /dev/null
> +++ b/arch/arm/boot/dts/st/stm32mp151c-mect1s.dts
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) Protonic Holland
> + * Author: David Jander <david@protonic.nl>
> + */
> +/dts-v1/;
> +
> +#include "stm32mp151.dtsi"
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15-pinctrl.dtsi"
> +#include "stm32mp15xxaa-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Protonic MECT1S";
> +	compatible = "prt,mect1s", "st,stm32mp151";
> +
> +	chosen {
> +		stdout-path = "serial0:1500000n8";
> +	};
> +
> +	aliases {
> +		serial0 = &uart4;
> +		ethernet0 = &ethernet0;
> +		ethernet1 = &ethernet1;
> +		ethernet2 = &ethernet2;
> +		ethernet3 = &ethernet3;
> +		ethernet4 = &ethernet4;
> +	};
> +
> +	v3v3: regulator-v3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	v5v: regulator-v5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	led {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_DEBUG;
> +			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DEBUG;
> +			gpios = <&gpioa 14 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&clk_hse {
> +	clock-frequency = <24000000>;
> +};
> +
> +&clk_lse {
> +	status = "disabled";
> +};
> +
> +&ethernet0 {
> +	status = "okay";
> +	pinctrl-0 = <&ethernet0_rmii_pins_a>;
> +	pinctrl-1 = <&ethernet0_rmii_sleep_pins_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rmii";
> +	max-speed = <100>;
> +	st,eth-clk-sel;
> +
> +	fixed-link {
> +		speed = <100>;
> +		full-duplex;
> +	};
> +
> +	mdio0: mdio {
> +		 #address-cells = <1>;
> +		 #size-cells = <0>;
> +		 compatible = "snps,dwmac-mdio";
> +	};
> +};
> +
> +&{ethernet0_rmii_pins_a/pins1} {
> +	pinmux = <STM32_PINMUX('B', 12, AF11)>, /* ETH1_RMII_TXD0 */
> +		 <STM32_PINMUX('B', 13, AF11)>, /* ETH1_RMII_TXD1 */
> +		 <STM32_PINMUX('B', 11, AF11)>, /* ETH1_RMII_TX_EN */
> +		 <STM32_PINMUX('A', 2, AF11)>,  /* ETH1_MDIO */
> +		 <STM32_PINMUX('C', 1, AF11)>;  /* ETH1_MDC */
> +};
> +
> +&{ethernet0_rmii_pins_a/pins2} {
> +	pinmux = <STM32_PINMUX('C', 4, AF11)>,  /* ETH1_RMII_RXD0 */
> +		 <STM32_PINMUX('C', 5, AF11)>,  /* ETH1_RMII_RXD1 */
> +		 <STM32_PINMUX('A', 1, AF11)>,  /* ETH1_RMII_REF_CLK input */
> +		 <STM32_PINMUX('A', 7, AF11)>;  /* ETH1_RMII_CRS_DV */
> +};
> +
> +&{ethernet0_rmii_sleep_pins_a/pins1} {
> +	pinmux = <STM32_PINMUX('B', 12, ANALOG)>, /* ETH1_RMII_TXD0 */
> +		 <STM32_PINMUX('B', 13, ANALOG)>, /* ETH1_RMII_TXD1 */
> +		 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH1_RMII_TX_EN */
> +		 <STM32_PINMUX('C', 4, ANALOG)>,  /* ETH1_RMII_RXD0 */
> +		 <STM32_PINMUX('C', 5, ANALOG)>,  /* ETH1_RMII_RXD1 */
> +		 <STM32_PINMUX('A', 1, ANALOG)>,  /* ETH1_RMII_REF_CLK */
> +		 <STM32_PINMUX('A', 7, ANALOG)>;  /* ETH1_RMII_CRS_DV */
> +};
> +
> +&mdio0 {
> +	/* All this DP83TG720R PHYs can't be probed before switch@0 is
> +	 * probed so we need to use compatible with PHYid
> +	 */
> +	/* TI DP83TG720R */
> +	t1_phy0: ethernet-phy@8 {
> +		compatible = "ethernet-phy-id2000.a284";
> +		reg = <8>;
> +		interrupts-extended = <&gpioi 5 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&gpioh 13 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10>;
> +		reset-deassert-us = <35>;
> +	};
> +
> +	/* TI DP83TG720R */
> +	t1_phy1: ethernet-phy@c {
> +		compatible = "ethernet-phy-id2000.a284";
> +		reg = <12>;
> +		interrupts-extended = <&gpioj 0 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&gpioh 14 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10>;
> +		reset-deassert-us = <35>;
> +	};
> +
> +	/* TI DP83TG720R */
> +	t1_phy2: ethernet-phy@4 {
> +		compatible = "ethernet-phy-id2000.a284";
> +		reg = <4>;
> +		interrupts-extended = <&gpioi 7 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&gpioh 15 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10>;
> +		reset-deassert-us = <35>;
> +	};
> +
> +	/* TI DP83TG720R */
> +	t1_phy3: ethernet-phy@d {
> +		compatible = "ethernet-phy-id2000.a284";
> +		reg = <13>;
> +		interrupts-extended = <&gpioi 15 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&gpioi 13 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <1000>;
> +	};
> +};
> +
> +&qspi {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&qspi_clk_pins_a
> +		     &qspi_bk1_pins_a
> +		     &qspi_cs1_pins_a>;
> +	pinctrl-1 = <&qspi_clk_sleep_pins_a
> +		     &qspi_bk1_sleep_pins_a
> +		     &qspi_cs1_sleep_pins_a>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <1000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
> +&{qspi_bk1_pins_a/pins} {
> +	/delete-property/ bias-disable;
> +	bias-pull-up;
> +	drive-push-pull;
> +	slew-rate = <1>;
> +};
> +
> +&spi2 {
> +	pinctrl-0 = <&spi2_pins_b>;
> +	pinctrl-names = "default";
> +	cs-gpios = <&gpioj 3 GPIO_ACTIVE_LOW>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +
> +	switch@0 {
> +		compatible = "nxp,sja1105q";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		spi-rx-delay-us = <1>;
> +		spi-tx-delay-us = <1>;
> +		spi-cpha;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ethernet1: port@0 {
> +				reg = <0>;
> +				label = "t10";
> +				phy-mode = "rgmii-id";
> +				phy-handle = <&t1_phy0>;
> +			};
> +
> +			ethernet2: port@1 {
> +				reg = <1>;
> +				label = "t11";
> +				phy-mode = "rgmii-id";
> +				phy-handle = <&t1_phy1>;
> +			};
> +
> +			ethernet3: port@2 {
> +				reg = <2>;
> +				label = "t12";
> +				phy-mode = "rgmii-id";
> +				phy-handle = <&t1_phy2>;
> +			};
> +
> +			ethernet4: port@3 {
> +				reg = <3>;
> +				label = "t13";
> +				phy-mode = "rgmii-id";
> +				phy-handle = <&t1_phy3>;
> +			};
> +
> +			port@4 {
> +				reg = <4>;
> +				label = "cpu";
> +				ethernet = <&ethernet0>;
> +				phy-mode = "rmii";
> +
> +				/* RGMII mode is not working properly, using RMII instead. */
> +				fixed-link {
> +					speed = <100>;
> +					full-duplex;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&uart4_pins_a>;
> +	pinctrl-1 = <&uart4_sleep_pins_a>;
> +	pinctrl-2 = <&uart4_idle_pins_a>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +};
> +
> +&usbh_ehci {
> +	status = "okay";
> +};
> +
> +&usbotg_hs {
> +	dr_mode = "host";
> +	pinctrl-0 = <&usbotg_hs_pins_a>;
> +	pinctrl-names = "default";
> +	phys = <&usbphyc_port1 0>;
> +	phy-names = "usb2-phy";
> +	vbus-supply = <&v5v>;
> +	status = "okay";
> +};
> +
> +&usbphyc {
> +	status = "okay";
> +};
> +
> +&usbphyc_port0 {
> +	phy-supply = <&v3v3>;
> +};
> +
> +&usbphyc_port1 {
> +	phy-supply = <&v3v3>;
> +};
> diff --git a/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts b/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
> new file mode 100644
> index 0000000000000..16b814c19350c
> --- /dev/null
> +++ b/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) Protonic Holland
> + * Author: David Jander <david@protonic.nl>
> + */
> +/dts-v1/;
> +
> +#include "stm32mp153.dtsi"
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15-pinctrl.dtsi"
> +#include "stm32mp15xxaa-pinctrl.dtsi"
> +#include "stm32mp15x-mecio1-io.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Protonic MECIO1r1";
> +	compatible = "prt,mecio1r1", "st,stm32mp153";
> +
> +	led {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_DEBUG;
> +			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DEBUG;
> +			gpios = <&gpioa 14 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&clk_hse {
> +	clock-frequency = <24000000>;
> +};
> +
> +&m_can1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&m_can1_pins_b>;
> +	pinctrl-1 = <&m_can1_sleep_pins_b>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
> new file mode 100644
> index 0000000000000..915ba2526f451
> --- /dev/null
> +++ b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
> @@ -0,0 +1,527 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) Protonic Holland
> + * Author: David Jander <david@protonic.nl>
> + */
> +
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15-pinctrl.dtsi"
> +#include "stm32mp15xxaa-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial0:1500000n8";
> +	};
> +
> +	aliases {
> +		serial0 = &uart4;
> +		ethernet0 = &ethernet0;
> +		spi1 = &spi1;
> +		spi2 = &spi2;
> +		spi3 = &spi3;
> +		spi4 = &spi4;
> +		spi5 = &spi5;
> +		spi6 = &spi6;
> +	};
> +
> +	memory@c0000000 {
> +		device_type = "memory";
> +		reg = <0xC0000000 0x10000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mcuram2: mcuram2@10000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10000000 0x40000>;
> +			no-map;
> +		};
> +
> +		vdev0vring0: vdev0vring0@10040000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10040000 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@10041000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10041000 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0buffer: vdev0buffer@10042000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10042000 0x4000>;
> +			no-map;
> +		};
> +
> +		mcuram: mcuram@30000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x30000000 0x40000>;
> +			no-map;
> +		};
> +
> +		retram: retram@38000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x38000000 0x10000>;
> +			no-map;
> +		};
> +	};
> +
> +	v3v3: regulator-v3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	v5v: regulator-v5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&adc {
> +	/* ANA0, ANA1 are dedicated pins and don't need pinctrl: only in6. */
> +	pinctrl-0 = <&adc12_pins_mecsbc>;
> +	pinctrl-names = "default";
> +	vdd-supply = <&v3v3>;
> +	vdda-supply = <&v3v3>;
> +	vref-supply = <&v3v3>;
> +	status = "okay";
> +};
> +
> +&adc1 {
> +	status = "okay";
> +
> +	channel@0 {
> +		reg = <0>;
> +		/* 16.5 ck_cycles sampling time */
> +		st,min-sample-time-ns = <5000>;
> +		label = "p24v_stp";
> +	};
> +
> +	channel@1 {
> +		reg = <1>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "p24v_hpdcm";
> +	};
> +
> +	channel@2 {
> +		reg = <2>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "ain0";
> +	};
> +
> +	channel@3 {
> +		reg = <3>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "hpdcm1_i2";
> +	};
> +
> +	channel@5 {
> +		reg = <5>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "hpout1_i";
> +	};
> +
> +	channel@6 {
> +		reg = <6>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "ain1";
> +	};
> +
> +	channel@9 {
> +		reg = <9>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "hpout0_i";
> +	};
> +
> +	channel@10 {
> +		reg = <10>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "phint0_ain";
> +	};
> +
> +	channel@13 {
> +		reg = <13>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "phint1_ain";
> +	};
> +
> +	channel@15 {
> +		reg = <15>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "hpdcm0_i1";
> +	};
> +
> +	channel@16 {
> +		reg = <16>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "lsin";
> +	};
> +
> +	channel@18 {
> +		reg = <18>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "hpdcm0_i2";
> +	};
> +
> +	channel@19 {
> +		reg = <19>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "hpdcm1_i1";
> +	};
> +};
> +
> +&adc2 {
> +	status = "okay";
> +
> +	channel@2 {
> +		reg = <2>;
> +		/* 16.5 ck_cycles sampling time */
> +		st,min-sample-time-ns = <5000>;
> +		label = "ain2";
> +	};
> +
> +	channel@6 {
> +		reg = <6>;
> +		st,min-sample-time-ns = <5000>;
> +		label = "ain3";
> +	};
> +};
> +
> +&ethernet0 {
> +	status = "okay";
> +	pinctrl-0 = <&ethernet0_rgmii_pins_x>;
> +	pinctrl-1 = <&ethernet0_rgmii_sleep_pins_x>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rgmii-id";
> +	max-speed = <1000>;
> +	phy-handle = <&phy0>;
> +	st,eth-clk-sel;
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy0: ethernet-phy@8 {
> +			reg = <8>;
> +			interrupts-extended = <&gpiog 7 IRQ_TYPE_LEVEL_LOW>;
> +			reset-gpios = <&gpiog 10 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10>;
> +			reset-deassert-us = <35>;
> +		};
> +	};
> +};
> +
> +&gpiod {
> +	gpio-line-names = "", "", "", "",
> +			  "", "", "", "",
> +			  "", "", "", "",
> +			  "STP_RESETN", "STP_ENABLEN", "HPOUT0", "HPOUT0_ALERTN";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog_d_mecsbc>;
> +};
> +
> +&gpioe {
> +	gpio-line-names = "HPOUT0_RESETN", "HPOUT1", "HPOUT1_ALERTN", "",
> +			  "", "", "HPOUT1_RESETN",
> +			  "LPOUT0", "LPOUT0_ALERTN", "GPOUT0_RESETN",
> +			  "LPOUT1", "LPOUT1_ALERTN", "GPOUT1_RESETN",
> +			  "LPOUT2", "LPOUT2_ALERTN", "GPOUT2_RESETN";
> +};
> +
> +&gpiof {
> +	gpio-line-names = "LPOUT3", "LPOUT3_ALERTN", "GPOUT3_RESETN",
> +			  "LPOUT4", "LPOUT4_ALERTN", "GPOUT4_RESETN",
> +			  "", "",
> +			  "", "", "", "",
> +			  "", "", "", "";
> +};
> +
> +&gpiog {
> +	gpio-line-names = "LPOUT5", "LPOUT5_ALERTN", "", "LPOUT5_RESETN",
> +			  "", "", "", "",
> +			  "", "", "", "",
> +			  "", "", "", "";
> +};
> +
> +&gpioh {
> +	gpio-line-names = "", "", "", "",
> +			  "", "", "", "",
> +			  "GPIO0_RESETN", "", "", "",
> +			  "", "", "", "";
> +};
> +
> +&gpioi {
> +	gpio-line-names = "", "", "", "",
> +			  "", "", "", "",
> +			  "HPDCM0_SLEEPN", "HPDCM1_SLEEPN", "GPIO1_RESETN", "",
> +			  "", "", "", "";
> +};
> +
> +&gpioj {
> +	gpio-line-names = "HSIN10", "HSIN11", "HSIN12", "HSIN13",
> +			  "HSIN14", "HSIN15", "", "",
> +			  "", "", "", "",
> +			  "", "RTD_RESETN", "", "";
> +};
> +
> +&gpiok {
> +	gpio-line-names = "", "", "HSIN0", "HSIN1",
> +			  "HSIN2", "HSIN3", "HSIN4", "HSIN5";
> +};
> +
> +&gpioz {
> +	gpio-line-names = "", "", "", "HSIN6",
> +			  "HSIN7", "HSIN8", "HSIN9", "";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins_a>;
> +	pinctrl-1 = <&i2c2_sleep_pins_a>;
> +	status = "okay";
> +
> +	gpio0: gpio@20 {
> +		compatible = "ti,tca6416";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "HSIN0_BIAS", "HSIN1_BIAS", "HSIN2_BIAS", "HSIN3_BIAS",
> +				  "", "", "HSIN_VREF0_LVL", "HSIN_VREF1_LVL",
> +				  "HSIN4_BIAS", "HSIN5_BIAS", "HSIN6_BIAS", "HSIN9_BIAS",
> +				  "", "", "", "";
> +	};
> +
> +	gpio1: gpio@21 {
> +		compatible = "ti,tca6416";
> +		reg = <0x21>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "HSIN8_BIAS", "HSIN9_BIAS", "HSIN10_BIAS", "HSIN11_BIAS",
> +				  "", "", "HSIN_VREF2_LVL", "HSIN_VREF3_LVL",
> +				  "HSIN12_BIAS", "HSIN13_BIAS", "HSIN14_BIAS", "HSIN15_BIAS",
> +				  "", "", "LSIN8_BIAS", "LSIN9_BIAS";
> +	};
> +};
> +
> +&qspi {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&qspi_clk_pins_a
> +		     &qspi_bk1_pins_a
> +		     &qspi_cs1_pins_a>;
> +	pinctrl-1 = <&qspi_clk_sleep_pins_a
> +		     &qspi_bk1_sleep_pins_a
> +		     &qspi_cs1_sleep_pins_a>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <104000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
> +&{qspi_bk1_pins_a/pins} {
> +	pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
> +		 <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
> +		 <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
> +		 <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
> +	/delete-property/ bias-disable;
> +	bias-pull-up;
> +};
> +
> +&timers1 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +
> +	hpdcm0_pwm: pwm {
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pwm1_pins_mecio1>;
> +		pinctrl-1 = <&pwm1_sleep_pins_mecio1>;
> +		status = "okay";
> +	};
> +};
> +
> +&timers8 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +
> +	hpdcm1_pwm: pwm {
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pwm8_pins_mecio1>;
> +		pinctrl-1 = <&pwm8_sleep_pins_mecio1>;
> +		status = "okay";
> +	};
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&uart4_pins_a>;
> +	pinctrl-1 = <&uart4_sleep_pins_a>;
> +	pinctrl-2 = <&uart4_idle_pins_a>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +};
> +
> +&{uart4_pins_a/pins1} {
> +	pinmux = <STM32_PINMUX('B', 9, AF8)>; /* UART4_TX */
> +};
> +
> +&{uart4_pins_a/pins2} {
> +	pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
> +	/delete-property/ bias-disable;
> +	bias-pull-up;
> +};
> +
> +&usbotg_hs {
> +	dr_mode = "host";
> +	pinctrl-0 = <&usbotg_hs_pins_a>;
> +	pinctrl-names = "default";
> +	phys = <&usbphyc_port1 0>;
> +	phy-names = "usb2-phy";
> +	vbus-supply = <&v5v>;
> +	status = "okay";
> +};
> +
> +&usbphyc {
> +	status = "okay";
> +};
> +
> +&usbphyc_port0 {
> +	phy-supply = <&v3v3>;
> +};
> +
> +&usbphyc_port1 {
> +	phy-supply = <&v3v3>;
> +};
> +
> +&pinctrl {
> +	adc12_pins_mecsbc: adc12-ain-mecsbc-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* ADC1_INP2 */
> +				 <STM32_PINMUX('F', 12, ANALOG)>, /* ADC1_INP6 */
> +				 <STM32_PINMUX('F', 13, ANALOG)>, /* ADC2_INP2 */
> +				 <STM32_PINMUX('F', 14, ANALOG)>, /* ADC2_INP6 */
> +				 <STM32_PINMUX('A', 0, ANALOG)>, /* ADC1_INP16 */
> +				 <STM32_PINMUX('A', 3, ANALOG)>, /* ADC1_INP15 */
> +				 <STM32_PINMUX('A', 4, ANALOG)>, /* ADC1_INP18 */
> +				 <STM32_PINMUX('A', 5, ANALOG)>, /* ADC1_INP19 */
> +				 <STM32_PINMUX('A', 6, ANALOG)>, /* ADC1_INP3 */
> +				 <STM32_PINMUX('B', 0, ANALOG)>, /* ADC1_INP9 */
> +				 <STM32_PINMUX('B', 1, ANALOG)>, /* ADC1_INP5 */
> +				 <STM32_PINMUX('C', 0, ANALOG)>, /* ADC1_INP10 */
> +				 <STM32_PINMUX('C', 3, ANALOG)>; /* ADC1_INP13 */
> +		};
> +	};
> +
> +	pinctrl_hog_d_mecsbc: hog-d-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('D', 12, GPIO)>; /* STP_RESETn */
> +			bias-pull-up;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm1_pins_mecio1: pwm1-mecio1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 8, AF1)>, /* TIM1_CH1 */
> +				 <STM32_PINMUX('A', 8, AF1)>; /* TIM1_CH2 */
> +			bias-pull-down;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm1_sleep_pins_mecio1: pwm1-sleep-mecio1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* TIM1_CH1 */
> +				 <STM32_PINMUX('A', 8, ANALOG)>; /* TIM1_CH2 */
> +		};
> +	};
> +
> +	pwm8_pins_mecio1: pwm8-mecio1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('I', 5, AF3)>, /* TIM8_CH1 */
> +				 <STM32_PINMUX('I', 6, AF3)>; /* TIM8_CH2 */
> +			bias-pull-down;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm8_sleep_pins_mecio1: pwm8-sleep-mecio1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* TIM8_CH1 */
> +				 <STM32_PINMUX('I', 6, ANALOG)>; /* TIM8_CH2 */
> +		};
> +	};
> +
> +	ethernet0_rgmii_pins_x: rgmii-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
> +				 <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
> +				 <STM32_PINMUX('B', 12, AF11)>, /* ETH_RGMII_TXD0 */
> +				 <STM32_PINMUX('B', 13, AF11)>, /* ETH_RGMII_TXD1 */
> +				 <STM32_PINMUX('C', 2, AF11)>, /* ETH_RGMII_TXD2 */
> +				 <STM32_PINMUX('B', 8, AF11)>, /* ETH_RGMII_TXD3 */
> +				 <STM32_PINMUX('B', 11, AF11)>, /* ETH_RGMII_TX_CTL */
> +				 <STM32_PINMUX('C', 1, AF11)>; /* ETH_MDC */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <3>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('A', 2, AF11)>; /* ETH_MDIO */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins3 {
> +			pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH_RGMII_RXD0 */
> +				 <STM32_PINMUX('C', 5, AF11)>, /* ETH_RGMII_RXD1 */
> +				 <STM32_PINMUX('H', 6, AF11)>, /* ETH_RGMII_RXD2 */
> +				 <STM32_PINMUX('H', 7, AF11)>, /* ETH_RGMII_RXD3 */
> +				 <STM32_PINMUX('A', 1, AF11)>, /* ETH_RGMII_RX_CLK */
> +				 <STM32_PINMUX('A', 7, AF11)>; /* ETH_RGMII_RX_CTL */
> +			bias-disable;
> +		};
> +	};
> +
> +	ethernet0_rgmii_sleep_pins_x: rgmii-sleep-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
> +				 <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
> +				 <STM32_PINMUX('B', 12, ANALOG)>, /* ETH_RGMII_TXD0 */
> +				 <STM32_PINMUX('B', 13, ANALOG)>, /* ETH_RGMII_TXD1 */
> +				 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_TXD2 */
> +				 <STM32_PINMUX('B', 8, ANALOG)>, /* ETH_RGMII_TXD3 */
> +				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RGMII_TX_CTL */
> +				 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
> +				 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH_MDC */
> +				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
> +				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RGMII_RXD1 */
> +				 <STM32_PINMUX('H', 6, ANALOG)>, /* ETH_RGMII_RXD2 */
> +				 <STM32_PINMUX('H', 7, ANALOG)>, /* ETH_RGMII_RXD3 */
> +				 <STM32_PINMUX('A', 1, ANALOG)>, /* ETH_RGMII_RX_CLK */
> +				 <STM32_PINMUX('A', 7, ANALOG)>; /* ETH_RGMII_RX_CTL */
> +		};
> +	};
> +};

