Return-Path: <netdev+bounces-143142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9D9C1425
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645E81C22322
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C813C69E;
	Fri,  8 Nov 2024 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="VlAvpI9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31313BAE3
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033370; cv=none; b=CjXyv3L0u1SM0AGpZHZ769kDL6v8SP/3p+fjbLc6jY66NJHRnPL2qDh3PC/7eXBQW0PdomHoh8kaIQONezzILFMzWIqmSgG9eMOu5iFWx7d5avqWaXh2yaeEegffqfmGomxULdPsUM8my25/vf3Jojbr6dyY+BzHRUX3mHHRa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033370; c=relaxed/simple;
	bh=qDJ5LmtmPUriFCnpMhMc5scGbNBSa6mmdMKJ8KLdCU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaEI0tN9U500vQbCvsN3XcnQ9sybFSKEA5XYhJpnARw4CBJOxdfD0Zt4HxhzJE/mZfw4N2Fuj+sG2z+uQQlZtmdqGBo/wJEYW8Nl4socKrNMVGHWRxmv3L4E8suef0/iNEoeAs+D1OxupJpWhffJqYwG3GP66sKAODucHocstkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=VlAvpI9u; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-723db2798caso1842020b3a.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 18:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1731033368; x=1731638168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+jyeFz5qLcpNF1wQeUyeaIh19p1lD8bQtGka/s8n1Q=;
        b=VlAvpI9uFes87YdjurMLNeFumSqm9D320j3fdwTBFbw7m863VZjseyrd4tXvxGJuZh
         V1ln6844jIlV9E+rWyQ5fN5u6CLwI7mWgQrPsItKJPYPfTKtBnqrWG45vnz+uQygE4v7
         YcdGrUmWD+JhkvP9YL2MQ+l+fZuVxm4R+NrkKCSsg4MUKj6S3ZWJ41txKjVTzLSfOArt
         VamVI36DZf8LPHfMRi4sTaId70gAnI2gF7eXHNy1u8soBO1P3YpTxb1cQaD2aj9Z3Hsi
         zbmAEAHEoKnW2O6cmRws5Lt06KCFZPOcVDfxoTyGK0oEO3WmbaLlnDrnSROdccUnfsPs
         NIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033368; x=1731638168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+jyeFz5qLcpNF1wQeUyeaIh19p1lD8bQtGka/s8n1Q=;
        b=OIyOoc5ce2eZeMhOuD/9BXkAyoL0QFgXoUCEE7uvSdLyBbggI8jXcBbBLiePYgoAhM
         jc344UVF6ihOgUTu9dNYB7RFOWLG4GIVrgLWFcJEvT4K5UFa9URKchfrIH1MFaj48rPw
         szK08RgQFeGq+Elasl4EFwTEwUJWRkhJNTS1cKMaAel7d8gHU92bR3w9IiBv0cqnN/G2
         UdSCE2HNz2oltQfk3M6fBoqN3iUaCPjNoJ+kkJXaNKgUu7NuZ22AOm26XMkNc83VIBHg
         PU8VnVFXvhTJPG6lPOlXwSKdVMD341JWUen8wx+57HarEzr5YjyD7nhf1oUO6c2npL/2
         ixug==
X-Forwarded-Encrypted: i=1; AJvYcCVFUCCmXulKenMgdE8raqVGTLig1yghzCHf9lzc2ItuD07tO9AZ9qfAUE4KmqvylJpBbGLhyqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvsk+j1ZSjxeoUjHHIKGkMIF0izKnjH43iQM9T8yxbxJ9n7SCa
	9CiNLq2P27VqQu/WXdV21Y1tR3WVcpIeLZVX/0eV9AmeUFwhBO9ODpQicJyKnx0=
X-Google-Smtp-Source: AGHT+IFkTBYmvuaObrf/NhsL6bgy8VSLe5N8eK2nw/1LxrZ9F9SMeNiCvMwnlaaGOCdkpjvr4IsokQ==
X-Received: by 2002:a05:6a00:1819:b0:71d:f510:b791 with SMTP id d2e1a72fcca58-724132cd1b1mr1832008b3a.12.1731033367828;
        Thu, 07 Nov 2024 18:36:07 -0800 (PST)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a17ed3sm2541107b3a.142.2024.11.07.18.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:36:07 -0800 (PST)
Date: Thu, 7 Nov 2024 18:36:04 -0800
From: Drew Fustini <drew@pdp7.com>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v4 3/3] riscv: dts: thead: Add TH1520 ethernet
 nodes
Message-ID: <Zy15FJZrOFA2t687@x1>
References: <20241020-th1520-dwmac-v4-0-c77acd33ccef@tenstorrent.com>
 <20241020-th1520-dwmac-v4-3-c77acd33ccef@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020-th1520-dwmac-v4-3-c77acd33ccef@tenstorrent.com>

On Sun, Oct 20, 2024 at 07:36:02PM -0700, Drew Fustini wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> 
> Add gmac, mdio, and phy nodes to enable the gigabit Ethernet ports on
> the BeagleV Ahead and Sipeed Lichee Pi 4a boards.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: change apb registers from syscon to second reg of gmac node,
>        add phy reset delay properties for beaglev ahead]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  91 ++++++++++++++++
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 119 +++++++++++++++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi              |  50 +++++++++
>  3 files changed, 260 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> index 86feb3df02c8..21c33f165ba9 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -15,6 +15,7 @@ / {
>  	compatible = "beagle,beaglev-ahead", "thead,th1520";
>  
>  	aliases {
> +		ethernet0 = &gmac0;
>  		gpio0 = &gpio0;
>  		gpio1 = &gpio1;
>  		gpio2 = &gpio2;
> @@ -98,6 +99,25 @@ &emmc {
>  	status = "okay";
>  };
>  
> +&gmac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_pins>;
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	phy0: ethernet-phy@1 {
> +		reg = <1>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <10000>;
> +		reset-post-delay-us = <50000>;
> +	};
> +};
> +
>  &padctrl_aosys {
>  	led_pins: led-0 {
>  		led-pins {
> @@ -116,6 +136,77 @@ led-pins {
>  };
>  
>  &padctrl0_apsys {
> +	gmac0_pins: gmac0-0 {
> +		tx-pins {
> +			pins = "GMAC0_TX_CLK",
> +			       "GMAC0_TXEN",
> +			       "GMAC0_TXD0",
> +			       "GMAC0_TXD1",
> +			       "GMAC0_TXD2",
> +			       "GMAC0_TXD3";
> +			function = "gmac0";
> +			bias-disable;
> +			drive-strength = <25>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pins = "GMAC0_RX_CLK",
> +			       "GMAC0_RXDV",
> +			       "GMAC0_RXD0",
> +			       "GMAC0_RXD1",
> +			       "GMAC0_RXD2",
> +			       "GMAC0_RXD3";
> +			function = "gmac0";
> +			bias-disable;
> +			drive-strength = <1>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		mdc-pins {
> +			pins = "GMAC0_MDC";
> +			function = "gmac0";
> +			bias-disable;
> +			drive-strength = <13>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		mdio-pins {
> +			pins = "GMAC0_MDIO";
> +			function = "gmac0";
> +			bias-disable;
> +			drive-strength = <13>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +
> +		phy-reset-pins {
> +			pins = "GMAC0_COL"; /* GPIO3_21 */
> +			bias-disable;
> +			drive-strength = <3>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		phy-interrupt-pins {
> +			pins = "GMAC0_CRS"; /* GPIO3_22 */
> +			function = "gpio";
> +			bias-pull-up;
> +			drive-strength = <1>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
>  	uart0_pins: uart0-0 {
>  		tx-pins {
>  			pins = "UART0_TXD";
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index 724d9645471d..8e76b63e0100 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -11,6 +11,11 @@ / {
>  	model = "Sipeed Lichee Module 4A";
>  	compatible = "sipeed,lichee-module-4a", "thead,th1520";
>  
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x00000000 0x2 0x00000000>;
> @@ -45,6 +50,22 @@ &emmc {
>  	status = "okay";
>  };
>  
> +&gmac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_pins>, <&mdio0_pins>;
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&gmac1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_pins>;
> +	phy-handle = <&phy1>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
>  &gpio0 {
>  	gpio-line-names = "", "", "", "", "", "", "", "", "", "",
>  			  "", "", "", "", "", "", "", "", "", "",
> @@ -78,6 +99,104 @@ &gpio3 {
>  			  "GPIO10";
>  };
>  
> +&mdio0 {
> +	phy0: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +
> +	phy1: ethernet-phy@2 {
> +		reg = <2>;
> +	};
> +};
> +
> +&padctrl0_apsys {
> +	gmac0_pins: gmac0-0 {
> +		tx-pins {
> +			pins = "GMAC0_TX_CLK",
> +			       "GMAC0_TXEN",
> +			       "GMAC0_TXD0",
> +			       "GMAC0_TXD1",
> +			       "GMAC0_TXD2",
> +			       "GMAC0_TXD3";
> +			function = "gmac0";
> +			bias-disable;
> +			drive-strength = <25>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pins = "GMAC0_RX_CLK",
> +			       "GMAC0_RXDV",
> +			       "GMAC0_RXD0",
> +			       "GMAC0_RXD1",
> +			       "GMAC0_RXD2",
> +			       "GMAC0_RXD3";
> +			function = "gmac0";
> +			bias-disable;
> +			drive-strength = <1>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	gmac1_pins: gmac1-0 {
> +		tx-pins {
> +			pins = "GPIO2_18", /* GMAC1_TX_CLK */
> +			       "GPIO2_20", /* GMAC1_TXEN */
> +			       "GPIO2_21", /* GMAC1_TXD0 */
> +			       "GPIO2_22", /* GMAC1_TXD1 */
> +			       "GPIO2_23", /* GMAC1_TXD2 */
> +			       "GPIO2_24"; /* GMAC1_TXD3 */
> +			function = "gmac1";
> +			bias-disable;
> +			drive-strength = <25>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pins = "GPIO2_19", /* GMAC1_RX_CLK */
> +			       "GPIO2_25", /* GMAC1_RXDV */
> +			       "GPIO2_30", /* GMAC1_RXD0 */
> +			       "GPIO2_31", /* GMAC1_RXD1 */
> +			       "GPIO3_0",  /* GMAC1_RXD2 */
> +			       "GPIO3_1";  /* GMAC1_RXD3 */
> +			function = "gmac1";
> +			bias-disable;
> +			drive-strength = <1>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	mdio0_pins: mdio0-0 {
> +		mdc-pins {
> +			pins = "GMAC0_MDC";
> +			function = "gmac0";
> +			bias-disable;
> +			drive-strength = <13>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		mdio-pins {
> +			pins = "GMAC0_MDIO";
> +			function = "gmac0";
> +			bias-disable;
> +			drive-strength = <13>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
>  &sdio0 {
>  	bus-width = <4>;
>  	max-frequency = <198000000>;
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index cd835aea07d2..acfe030e803a 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -223,6 +223,12 @@ aonsys_clk: clock-73728000 {
>  		#clock-cells = <0>;
>  	};
>  
> +	stmmac_axi_config: stmmac-axi-config {
> +		snps,wr_osr_lmt = <15>;
> +		snps,rd_osr_lmt = <15>;
> +		snps,blen = <0 0 64 32 0 0 0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> @@ -274,6 +280,50 @@ uart0: serial@ffe7014000 {
>  			status = "disabled";
>  		};
>  
> +		gmac1: ethernet@ffe7060000 {
> +			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
> +			reg = <0xff 0xe7060000 0x0 0x2000>, <0xff 0xec004000 0x0 0x1000>;
> +			reg-names = "dwmac", "apb";
> +			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC1>;
> +			clock-names = "stmmaceth", "pclk";
> +			snps,pbl = <32>;
> +			snps,fixed-burst;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <32>;
> +			snps,axi-config = <&stmmac_axi_config>;
> +			status = "disabled";
> +
> +			mdio1: mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		gmac0: ethernet@ffe7070000 {
> +			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
> +			reg = <0xff 0xe7070000 0x0 0x2000>, <0xff 0xec003000 0x0 0x1000>;
> +			reg-names = "dwmac", "apb";
> +			interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC0>;
> +			clock-names = "stmmaceth", "pclk";
> +			snps,pbl = <32>;
> +			snps,fixed-burst;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <32>;
> +			snps,axi-config = <&stmmac_axi_config>;
> +			status = "disabled";
> +
> +			mdio0: mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>  		emmc: mmc@ffe7080000 {
>  			compatible = "thead,th1520-dwcmshc";
>  			reg = <0xff 0xe7080000 0x0 0x10000>;
> 
> -- 
> 2.34.1
> 

The dwmac-thead driver and dt binding have been applied to net-next [1]
so I have now applied this dts patch to thead-dt-for-next [2].

-Drew

[1] https://lore.kernel.org/linux-riscv/173085843050.764350.5609116722213276708.git-patchwork-notify@kernel.org/
[2] https://github.com/pdp7/linux/commit/7e756671a664b73b2a3c0cc37fd25abf6bcd851e

