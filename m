Return-Path: <netdev+bounces-210859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D0EB15251
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5925554277E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FADD22DA0C;
	Tue, 29 Jul 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Svszja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048801A2390;
	Tue, 29 Jul 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811157; cv=none; b=CF8Ud+gIWT652tgaBMO9Lo0OwSe1jK8MPzxWyzitRlmtRywM0j18FWHHfpRxnT9k5TDxsgVeWFEvPXvPaDDtj2LYI2MAvStxh3PRRuDx+0vN/UFMhONwm9+oPIDN5SwV2TIucMCPZqQVT/FlMnhK040qUFMVTkI1PL2MRAU8cwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811157; c=relaxed/simple;
	bh=6qjTRlNG6mWLFC8VSGcpPLF+CAKlIypJQcDcbXR/Otw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmGa0OYc1pFAOx8CohIBdagUp51W73ubtMzzV/YThjcQspoghfTJotjVJyu0rwrNxBNJSVQaFrg7vpgI7dkO0q5+AAUYwJm4sKGbQpDLEpe7Zo+DQZH1rxzGitCgOCdrMTyPczLtwD2hYfKvZw1ZcO3513oF+OEbCFzcIY3qIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Svszja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEF0C4CEF4;
	Tue, 29 Jul 2025 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753811156;
	bh=6qjTRlNG6mWLFC8VSGcpPLF+CAKlIypJQcDcbXR/Otw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3SvszjaScYVH2cxvcbjgFbZsEdyFYQ5VRKpfVXyjtjpt0htJIN4mtK1PpeCjDaTh
	 /46k3styG6mmy/i/SG4QDXuWKob0spuXN4wa2XligKXGNHgB96bSxGvYpmq6t8R4lQ
	 3LGJp2bUsAMQnQP3EpveRTed/HN+jVc+RK5Axje7AwxBXFws9gYtiLeuLNzj5ly+gV
	 uF3n3MzkE5o6wlBHY3SHVPJTNsIdjDQ7x+AOQ6MLwrKSSv6sRiRAOhiPeIHS6WkQRB
	 e9BWt/aD9VViGsaHwERb/lX7n67N7yX90TBLYrc9+y6SYEJx8Lmceif5xxNW4b++Vj
	 0fP4QaRafx0fg==
Date: Tue, 29 Jul 2025 10:45:54 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] riscv: dts: thead: Add APB clocks for TH1520
 GMACs
Message-ID: <aIkI0vHDD1CfxAkl@x1>
References: <20250729093734.40132-1-ziyao@disroot.org>
 <20250729093734.40132-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729093734.40132-4-ziyao@disroot.org>

On Tue, Jul 29, 2025 at 09:37:34AM +0000, Yao Zi wrote:
> Describe perisys-apb4-hclk as the APB clock for TH1520 SoC, which is
> essential for accessing GMAC glue registers.
> 
> Fixes: 7e756671a664 ("riscv: dts: thead: Add TH1520 ethernet nodes")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 42724bf7e90e..03f1d7319049 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -297,8 +297,9 @@ gmac1: ethernet@ffe7060000 {
>  			reg-names = "dwmac", "apb";
>  			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "macirq";
> -			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC1>;
> -			clock-names = "stmmaceth", "pclk";
> +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC1>,
> +				 <&clk CLK_PERISYS_APB4_HCLK>;
> +			clock-names = "stmmaceth", "pclk", "apb";
>  			snps,pbl = <32>;
>  			snps,fixed-burst;
>  			snps,multicast-filter-bins = <64>;
> @@ -319,8 +320,9 @@ gmac0: ethernet@ffe7070000 {
>  			reg-names = "dwmac", "apb";
>  			interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "macirq";
> -			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC0>;
> -			clock-names = "stmmaceth", "pclk";
> +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC0>,
> +				 <&clk CLK_PERISYS_APB4_HCLK>;
> +			clock-names = "stmmaceth", "pclk", "apb";
>  			snps,pbl = <32>;
>  			snps,fixed-burst;
>  			snps,multicast-filter-bins = <64>;
> -- 
> 2.50.1
> 

Thank you for determining that this clock is needed for the GMAC.

Reviewed-by: Drew Fustini <fustini@kernel.org>

