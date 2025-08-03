Return-Path: <netdev+bounces-211490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C75B1949B
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 19:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE901894392
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C01E149DF0;
	Sun,  3 Aug 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/Df5T8M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8922EE5;
	Sun,  3 Aug 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754240527; cv=none; b=PPYlIzcVbtPBJ24XiI7IhNByJz37vR4At7jo54hVGp0Nmh/i0KjqlrXbzNsUNPwH7d+L27ctvgnXuHQFGe6dIO24DM+SjNDKDBeiPXpApNrSV9obKQ30gr9jd0Snh0k1Iix0zdF5pqk5w9NKpRiJIWMETiRPqjmpqjGPR1FV0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754240527; c=relaxed/simple;
	bh=yeMd9S61zQJBzdMgfsYSWmeH8iA/N3MjZcTgFm57cVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idCOoiL8jCiixYJzkJHkx+MTP1tZWaRW0vMwe/4KW+C5bxzkV4OaO/z5HG5snoewpOlHiOnf7Fzi7M5utdee97B5+Jt2mBFPvHVcB5nDMdaQQ7Ox7tUPm387oFg8Diymc+lSY6giIx3d7LGv2LqJ0Vyrvt+oazOtgOdQuZX+oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/Df5T8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13550C4CEEB;
	Sun,  3 Aug 2025 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754240527;
	bh=yeMd9S61zQJBzdMgfsYSWmeH8iA/N3MjZcTgFm57cVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/Df5T8MFbtXlP/svzW+LiMDaNunwgHen4dZ+lQobRJLDTWFQP56YOYFoGu3zJGpu
	 k26k+Zyh17a7lHe78llTk1oV9o8FhnghYz1D85DkY9wmrCFQkjitx7GwxQ9L0G8v2F
	 UHuha7W8laInDknD2T7FlS7d/7sq/H3poduKHeZJj37K934kw8wQIo8DGcie2AyVpU
	 bxOIIYv//jiptUr5gDINeNd3Ax8oMEVTKZmP1eOhcIOiyGGYuFOtBnQsfD8KCB8j9K
	 iNtwWb1rDT9KWVDvTHl7pRznXwMbInPxHcUKnQZ/UIz6jJ0qjVTKxOuuQGjINOEIto
	 uuwMy798nza+Q==
Date: Sun, 3 Aug 2025 12:02:06 -0500
From: Rob Herring <robh@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] net: stmmac: thead: Get and enable APB clock
 on initialization
Message-ID: <20250803170206.GA525144-robh@kernel.org>
References: <20250801091240.46114-1-ziyao@disroot.org>
 <20250801091240.46114-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801091240.46114-3-ziyao@disroot.org>

On Fri, Aug 01, 2025 at 09:12:39AM +0000, Yao Zi wrote:
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
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
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

The description sounds like this should not be optional. The binding 
change also makes it not optional.

Rob


