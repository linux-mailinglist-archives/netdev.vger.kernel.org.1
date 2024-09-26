Return-Path: <netdev+bounces-130015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4541987936
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D3F1C21425
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE8173355;
	Thu, 26 Sep 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OGsInAtY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786015B96E;
	Thu, 26 Sep 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375988; cv=none; b=Hn6zLZ9KNx5Of647EjyjVwDGt8R1bPx16KfsdlHFNdRdsX/0qt9Bc1CedR5/J2bq7FDeLh1EOW44EballBGFZIqghusNlZFs/jEX8KvVl6lBe+vBsGKtmtoBcssSrkdPtFjTnPSkQGcNswMIzvM8PUAAFuCBsf3v25OTlbyVuss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375988; c=relaxed/simple;
	bh=eE5u2j2C+K9iLvMJT2upOmg3IJEUpwK2T0VUyCuZXkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T21K+IA/ITlM00Zu4MuhXN1lZz0kO+4/RAyePTn/HS2T2QECfnN7gFD0afXrY+FC6E5Jjv7/tbeK+gE3KCj4pHZyl+1M7PZGJlUx4a+mAs4RUNezK4swxTFC2FWquu8Ny/0fIp+ZFs/fDz5ZUYJtq+59cwmYgNnf7DsXTgeSm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OGsInAtY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V66/Bzro1T7ZAB1kueHnp/otNZSlwdgDsCDAFqLRcQI=; b=OGsInAtYTpLNQkj5oDDqLHUSxY
	XnQcY0X4AOCqhw5hWiFERR84HjQGRI0gwC/gPPAJFGjvbv+jN9myx4y2yZiRpaOoLmIscbSS5Q9K1
	ekiMGkVkjpBraCLyC7+1XqS/lt7IpPByCNxXz2C2wOVcOhbWV8WkTk7xrZdlwlnKMILE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sttOj-008P8u-4T; Thu, 26 Sep 2024 20:39:29 +0200
Date: Thu, 26 Sep 2024 20:39:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Drew Fustini <dfustini@tenstorrent.com>
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
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
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
Message-ID: <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>

> +&mdio0 {
> +	phy0: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +
> +	phy1: ethernet-phy@2 {
> +		reg = <2>;
> +	};
> +};

Two PHYs on one bus...

> +		gmac1: ethernet@ffe7060000 {
> +			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
> +			reg = <0xff 0xe7060000 0x0 0x2000>, <0xff 0xec004000 0x0 0x1000>;
> +			reg-names = "dwmac", "apb";
> +			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC_AXI>;
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
> +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC_AXI>;

And the MACs are listed in opposite order. Does gmac1 probe first,
find the PHY does not exist, and return -EPROBE_DEFER. Then gmac0
probes successfully, and then sometime later gmac1 then reprobes?

I know it is normal to list nodes in address order, but you might be
able to avoid the EPROBE_DEFER if you reverse the order.

     Andrew

