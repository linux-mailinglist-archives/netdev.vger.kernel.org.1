Return-Path: <netdev+bounces-130198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54A7989175
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 23:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8221CB23B94
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835541779BD;
	Sat, 28 Sep 2024 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="TJ0Pnlgw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889E15B995
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727557518; cv=none; b=dHQXGwjVEwDjaX1wpiZHNgKeCRdEcUxFOMJ4nRGBYb79XUDF41Ol5t/L7lYxJarFTPxN3/77RPTdX1Bm75JUCt1NrAimv31HY5VUjojqxy97LWS5GSulODJilLa5g88p07lRYoMIjSjAKiUNSXYeQj5nyA0/x0xPSAYNwtLzkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727557518; c=relaxed/simple;
	bh=3iwNZf9694qndONfeZ/ixAk+ja9A/vLtbNrNa24+SFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWs85KUIWIRNRAr/lC14+pWshGe91ArVwekLU1FZetAw2MreX5N8Vros1M5hX1GMUWlx1PyxN/S47k/CHl/rfgvxZ/OITATeOwkyhK34mQo5JVVzx1oerWaiwuqO+6V12ZPMH7Xy/9M10uV9CGJJbC12vv9xSso+3AkSc8gZyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=TJ0Pnlgw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71b070ff24dso2834769b3a.2
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727557515; x=1728162315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9i+1khY6cZCPGetGL9p/QuDc4cg82jy9GCe3mjkCw+I=;
        b=TJ0PnlgwvtgCoeoptViDmGj7d7BCzkxY3UkMTOVU1B2yK82C7FTsNmlgf+qyu919/V
         MDTNFYU/mu6YzSG9mJWZkRTk9X9+nVCY9Wp8I++TsPo1jDxxfYzElgpd+9uM5DzvTOBo
         L5fdLGbWfOOvsfg2diAWQH4lkgOyvlkIfBcoVlCMCm8h3XcSlXy0wTPY9ZMAELpRNNbL
         gqpfKjfLHan0as0LftfMCsznYepTRGYy6wGRJUg8KsDY1XzCU+3XMWodf/GvPTIPLmaD
         YhO2OlBlPLH7dtoPzbBhhf0x2mi+pmMNL3+fwWiG7NTaETpJBXynnhRxgjUle94ydd3D
         lJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727557515; x=1728162315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i+1khY6cZCPGetGL9p/QuDc4cg82jy9GCe3mjkCw+I=;
        b=mGZ5BW4BKLTNA8llG9ZyhU0XiGQk0JueyVRSw+Nv4E1NPXr3dblUjzHgYRx7xeJHfW
         Fl7BNU1FiWjAP7/v6tzwe/oJ3BjB4a6iJkFj/yLAdjCwS9BxHxMuXjjWzK4TUXAgKPAZ
         bsZUeDP8/+JFBKMT8B0OQH1U+nSUTwebhWqjXUJizs2F1qwep9b+SYEGLFQS9IWylPTB
         NqXm+LIcHZ9PJ5qP0nUCYOHzoxn037m5dAVcsUr1wYzMkU/OzczzzKG0yV1R54xMbqos
         7HGasmBVoSC70Z3Oq1vm57i0zxyGfKk5v1oiK3N6AJ+GXvhks/P9gdSH4rk+5VD9BO0e
         OV9A==
X-Forwarded-Encrypted: i=1; AJvYcCXaY1OyHEyMf7lOWN98IgAHuJeqirqy9w8JHqiB8P2xammdye7d9WJe7OJqHnvNozcR5WBOIAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8YstJOovBAxYHTDb7Qq39JCg7PFP4ADlf0/0iC4QSr0vmLnL
	RIOFIumF0CQV5CPwlAH/4vsgnlNJSekhMT1uWJ6zGEmV9n6v9U/hSlftTTsHqSg=
X-Google-Smtp-Source: AGHT+IFPA8N1lIApwXdlaSl/HNsi0gfOXQ+7UfB2eYS+MdF/mHrjX6Aptdb7GIyUvtzl3aI6WvOevg==
X-Received: by 2002:a05:6a00:22c8:b0:70d:33b3:2d7f with SMTP id d2e1a72fcca58-71b260790a9mr10956907b3a.26.1727557515302;
        Sat, 28 Sep 2024 14:05:15 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bb2b8sm3550025b3a.61.2024.09.28.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 14:05:15 -0700 (PDT)
Date: Sat, 28 Sep 2024 14:05:13 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Add TH1520 ethernet nodes
Message-ID: <ZvhviRUb/CitmhgQ@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
 <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
 <ZvWyQo+2mwsC1HS6@x1>
 <0b49b681-2289-412a-8969-d134ffcfb7fc@lunn.ch>
 <ZvYJfrPx75FA1IFC@x1>
 <5076789c-3a35-4349-9733-f5d47528c184@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5076789c-3a35-4349-9733-f5d47528c184@lunn.ch>

On Fri, Sep 27, 2024 at 01:58:40PM +0200, Andrew Lunn wrote:
> > I tried to setup an nfs server with a rootfs on my local network. I can
> > mount it okay from my laptop so I think it is working okay. However, it
> > does not seem to work on the lpi4a [3]. It appears the rgmii-id
> > validation fails and the dwmac driver can not open the phy:
> > 
> >  thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> >  thead-dwmac ffe7060000.ethernet eth0: validation of rgmii-id with support \
> >              00,00000000,00000000,00006280 and advertisementa \
> > 	     00,00000000,00000000,00006280 failed: -EINVAL
> >  thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -22)
> 
> Given what Emil said, i would suggest flipping the MDIO busses
> around. Put the PHYs on gmac1's MDIO bus, and set the pinmux so that
> its MDIO bus controller is connected to the outside world. Then, when
> gmac1 probes first, its MDIO bus will be probed at the same time, and
> its PHY found.
> 
> 	Andrew

I'm trying to configure the pinmux to have gmac1 control the mdio bus
but it seems I've not done so correctly. I changed pins "GMAC0_MDC" and
"GMAC0_MDIO" to function "gmac1" (see the patch below).

I don't see any errors about the dwmac or phy in the boot log [1] but
ultimately there is no carrier detected and the ethernet interface does
not come up.

Section "3.3.4.103 G3_MUXCFG_007" in the TH1520 System User Manual shows
that bits [19:16] control GMAC0_MDIO_MUX_CFG where value of 2 selects
GMAC1_MDIO. Similarly, bits [15:12] control GMAC0_MDC_MUX_CFG where a
value of 2 also selects GMAC1_MDC.

Emil - do you have any suggestion as to what I might be doing wrong with
the pinmux?

Thanks,
Drew

[1] https://gist.github.com/pdp7/1f9fcd76f26acd5715398d54f65a2e27

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index ca84bc2039ef..f2f6c9d9b590 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -11,6 +11,11 @@ / {
        model = "Sipeed Lichee Module 4A";
        compatible = "sipeed,lichee-module-4a", "thead,th1520";

+       aliases {
+               ethernet0 = &gmac0;
+               ethernet1 = &gmac1;
+       };
+
        memory@0 {
                device_type = "memory";
                reg = <0x0 0x00000000 0x2 0x00000000>;
@@ -55,6 +60,22 @@ &sdio0 {
        status = "okay";
 };

+&gmac0 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&gmac0_pins>;
+       phy-handle = <&phy0>;
+       phy-mode = "rgmii-id";
+       status = "okay";
+};
+
+&gmac1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&gmac1_pins>, <&mdio1_pins>;
+       phy-handle = <&phy1>;
+       phy-mode = "rgmii-id";
+       status = "okay";
+};
+
 &gpio0 {
        gpio-line-names = "", "", "", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "", "", "",
@@ -87,3 +108,101 @@ &gpio3 {
                          "GPIO09",
                          "GPIO10";
 };
+
+&mdio1 {
+       phy0: ethernet-phy@1 {
+               reg = <1>;
+       };
+
+       phy1: ethernet-phy@2 {
+               reg = <2>;
+       };
+};
+
+&padctrl0_apsys {
+       gmac0_pins: gmac0-0 {
+               tx-pins {
+                       pins = "GMAC0_TX_CLK",
+                              "GMAC0_TXEN",
+                              "GMAC0_TXD0",
+                              "GMAC0_TXD1",
+                              "GMAC0_TXD2",
+                              "GMAC0_TXD3";
+                       function = "gmac0";
+                       bias-disable;
+                       drive-strength = <25>;
+                       input-disable;
+                       input-schmitt-disable;
+                       slew-rate = <0>;
+               };
+
+               rx-pins {
+                       pins = "GMAC0_RX_CLK",
+                              "GMAC0_RXDV",
+                              "GMAC0_RXD0",
+                              "GMAC0_RXD1",
+                              "GMAC0_RXD2",
+                              "GMAC0_RXD3";
+                       function = "gmac0";
+                       bias-disable;
+                       drive-strength = <1>;
+                       input-enable;
+                       input-schmitt-disable;
+                       slew-rate = <0>;
+               };
+       };
+
+       gmac1_pins: gmac1-0 {
+               tx-pins {
+                       pins = "GPIO2_18", /* GMAC1_TX_CLK */
+                              "GPIO2_20", /* GMAC1_TXEN */
+                              "GPIO2_21", /* GMAC1_TXD0 */
+                              "GPIO2_22", /* GMAC1_TXD1 */
+                              "GPIO2_23", /* GMAC1_TXD2 */
+                              "GPIO2_24"; /* GMAC1_TXD3 */
+                       function = "gmac1";
+                       bias-disable;
+                       drive-strength = <25>;
+                       input-disable;
+                       input-schmitt-disable;
+                       slew-rate = <0>;
+               };
+
+               rx-pins {
+                       pins = "GPIO2_19", /* GMAC1_RX_CLK */
+                              "GPIO2_25", /* GMAC1_RXDV */
+                              "GPIO2_30", /* GMAC1_RXD0 */
+                              "GPIO2_31", /* GMAC1_RXD1 */
+                              "GPIO3_0",  /* GMAC1_RXD2 */
+                              "GPIO3_1";  /* GMAC1_RXD3 */
+                       function = "gmac1";
+                       bias-disable;
+                       drive-strength = <1>;
+                       input-enable;
+                       input-schmitt-disable;
+                       slew-rate = <0>;
+               };
+       };
+
+       mdio1_pins: mdio1-0 {
+               mdc-pins {
+                       pins = "GMAC0_MDC";
+                       function = "gmac1";
+                       bias-disable;
+                       drive-strength = <13>;
+                       input-disable;
+                       input-schmitt-disable;
+                       slew-rate = <0>;
+               };
+
+               mdio-pins {
+                       pins = "GMAC0_MDIO";
+                       function = "gmac1";
+                       bias-disable;
+                       drive-strength = <13>;
+                       input-enable;
+                       input-schmitt-enable;
+                       slew-rate = <0>;
+               };
+       };
+};


