Return-Path: <netdev+bounces-212302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2EB1F0FF
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 00:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9363B2CEA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BED299AA1;
	Fri,  8 Aug 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egzCnQlt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7212E299A96;
	Fri,  8 Aug 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692940; cv=none; b=g5XPwPyditCTLqS9uktsj6Os/H+QZB96Y0TV8ifi/vWwkQuUF5FY7GZbYaNux2KSkKImlQGB4q/FdeDG1VYT55/210/UqazpgbAUW1JU153aBVPYmzNGJs/yFL8BLL4XfVr84sWHqzGBxgkVKSxZad44AH/GAqGkplGLtXYVQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692940; c=relaxed/simple;
	bh=rLZBj+I02MJoP2e/2GvebvvCShxDWxP7isVZ958jGIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1XcGPKK35x/NMGxrUPc8adTDe9+oThfHyL6ddECRlEW+X0+hFlo0lE/IBoU8LkGapzglZsUXzgK6tUzgvdwLIl80TqvTkkyOmgkwg49U8uad8ZPpq/j7SBt1NyELX6MhZFo0YfimDyB5hK3mc3f9t7XUkKPx26IdXVkDcBbjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egzCnQlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B58C4CEF1;
	Fri,  8 Aug 2025 22:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754692940;
	bh=rLZBj+I02MJoP2e/2GvebvvCShxDWxP7isVZ958jGIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egzCnQltzQI4eH2ac1xfMp6bl4YDwg8TXYPhGh3XBShjOXHzkgVs04NeR+H+B4Yyy
	 PWMyRAw2yEDAtUxSXyr22tWISRoJquWCQ3NhwdOsfsqR2KD5wbj5wdd44bvmbixNCc
	 R3F7hu4zpJjEjb9swk1tbOH1jiu00afLtLVelssrkxLwlM7M5HY8nUD8qmc8ECbLKP
	 lvi4Ml/nTabT/U934nBBPQtdeZ+C8HwOZhIHS3ofZYMPB+nCnolUXAAWa3g7jHdFIl
	 06DLY2RrMv+gsYiapzFkFfQac/FiqnlKoopi87aLq6TM8BkluxTsmeXdFrw6vdb8hJ
	 KKuHLTsFYoWtg==
Date: Fri, 8 Aug 2025 15:42:18 -0700
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
Subject: Re: [PATCH net v3 2/3] net: stmmac: thead: Get and enable APB clock
 on initialization
Message-ID: <aJZ9SkeT56LFzIS2@x1>
References: <20250808093655.48074-2-ziyao@disroot.org>
 <20250808093655.48074-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808093655.48074-4-ziyao@disroot.org>

On Fri, Aug 08, 2025 at 09:36:55AM +0000, Yao Zi wrote:
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
> For backward compatibility with older devicetrees, probing won't fail if
> the APB clock isn't found. In this case, we emit a warning since the
> link will break if the speed changes.
> 
> Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> index c72ee759aae5..f2946bea0bc2 100644
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
> @@ -224,6 +225,19 @@ static int thead_dwmac_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
>  				     "dt configuration failed\n");
>  
> +	/*
> +	 * The APB clock is essential for accessing glue registers. However,
> +	 * old devicetrees don't describe it correctly. We continue to probe
> +	 * and emit a warning if it isn't present.
> +	 */
> +	apb_clk = devm_clk_get_enabled(&pdev->dev, "apb");
> +	if (PTR_ERR(apb_clk) == -ENOENT)
> +		dev_warn(&pdev->dev,
> +			 "cannot get apb clock, link may break after speed changes\n");
> +	else if (IS_ERR(apb_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(apb_clk),
> +				     "failed to get apb clock\n");
> +
>  	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
>  	if (!dwmac)
>  		return -ENOMEM;
> -- 
> 2.50.1
> 

Reviewed-by: Drew Fustini <fustini@kernel.org>

Thanks for improving the commit description and adding the warning.

Drew

