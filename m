Return-Path: <netdev+bounces-210897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89994B1556E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 00:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD2718A78DC
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52727FD40;
	Tue, 29 Jul 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtyfdu20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA41D54F7;
	Tue, 29 Jul 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829468; cv=none; b=nOMUAGtYqyrHBLMMeuIVL/Kq5I/dnNn3DKvGROzLvWTPul0EEXGGoRxVijJagkSKC998q5cirMxCBeWVToywD3J1dRpBWjAvijmkLMoFlTZSXIHeVvMzwOSscXA6JBM98TMneBv2B0bF/2z/oxz2+NTE4QfMHmgLSbJFdLMJ/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829468; c=relaxed/simple;
	bh=OM3Q7mjzFS6WpKuFOdQ8rpL1svxcPBy75KNBmRDUGPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRBh/KdfCpvhn3wMyFjxsWIjHBFNXMwTLkZa8LNuGmcNsPseztUH0jNZfoIqbHgylPBd3bKmVlZyedlY5WeQU5VOtZXoNaVhBBLYbB6Mrpg1wOSyNaEGrSShh58na6Zt2gNKkpFa82EU3MEP3Oh1JPbW3+6B0X5UaDlKrLnxfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtyfdu20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9581C4CEEF;
	Tue, 29 Jul 2025 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829468;
	bh=OM3Q7mjzFS6WpKuFOdQ8rpL1svxcPBy75KNBmRDUGPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtyfdu20PeMusrQZMS2tyBqPUBo99pb2+uNdjGk3I0ARdUqX33ozFPZk0/Myejbja
	 moC/ZVnAwNLMGLLzBPNL4xq3JureGn9EE94SIUyeadtqDOD61kRKrub2QUHE4nV8jX
	 5wBX59KQdxOWNYxjUwc9U9RWUJhnthmVfwoLGDO9izDN6WPt1YGgnYng3olcqNKzIi
	 XyixxBfCpjODfLmd1DFOuhCAwi4PuaG1XdQQF8iNxlHLIQI8xlawjlz1Xj88JnmqPJ
	 mIhRLrcWeu/rb16F7DDCDInwsFlJkBH+1+j5g3aASaoEKqdmE3LuEnax1HLYfrDonR
	 MchH7pwg8plhg==
Date: Tue, 29 Jul 2025 15:51:06 -0700
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
Subject: Re: [PATCH net 2/3] net: stmmac: thead: Get and enable APB clock on
 initialization
Message-ID: <aIlQWmKY4Hhe/erO@x1>
References: <20250729093734.40132-1-ziyao@disroot.org>
 <20250729093734.40132-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729093734.40132-3-ziyao@disroot.org>

On Tue, Jul 29, 2025 at 09:37:33AM +0000, Yao Zi wrote:
> It's necessary to adjust the MAC TX clock when the linkspeed changes,
> but it's noted such adjustment always fails on TH1520 SoC, and reading
> back from APB glue registers that control clock generation results in
> garbage, causing broken link.
> 
> With some testing, it's found a clock must be ungated for access to APB
> glue registers. Without any consumer, the clock is automatically
> disabled during late kernel startup. Let's get and enable it if it's
> described in devicetree.
> 
> Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> index c72ee759aae5..95096244a846 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> @@ -211,6 +211,7 @@ static int thead_dwmac_probe(struct platform_device *pdev)
>  	struct stmmac_resources stmmac_res;
>  	struct plat_stmmacenet_data *plat;
>  	struct thead_dwmac *dwmac;
> +	struct clk *apb_clk;
>  	void __iomem *apb;
>  	int ret;
>  
> @@ -224,6 +225,11 @@ static int thead_dwmac_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
>  				     "dt configuration failed\n");
>  
> +	apb_clk = devm_clk_get_optional_enabled(&pdev->dev, "apb");
> +	if (IS_ERR(apb_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(apb_clk),
> +				     "failed to get apb clock\n");
> +
>  	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
>  	if (!dwmac)
>  		return -ENOMEM;
> -- 
> 2.50.1
> 

Thank you for tracking down root cause and fixing it.

Reviewed-by: Drew Fustini <fustini@kernel.org>

