Return-Path: <netdev+bounces-211500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0920B19B02
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 07:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4501754F8
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664142264A1;
	Mon,  4 Aug 2025 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KnFuzqsZ"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE4225417;
	Mon,  4 Aug 2025 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754284385; cv=none; b=lZCpE5PaAKyFyF+gN55AYiyIEi122LhV4jBeQjSbzx90bygHybtrruweZlRyNEK6UTebQpdEi/E7CwKdi1iET3RUGk1bJ0tV91+zdlIvDYfBuuCSoL83HV19J8OkO3YuaEI98AP7+KQmvJWTKsdLmJ1t7YBc1JPLle/Tjxv8H9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754284385; c=relaxed/simple;
	bh=SUW5D5b5WsWlP0YMXjvvOTVOjakybqdppS5vTfywQuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8yb6GdTbx+T+AIFGWiSDyu8NIr+N+VjAcSBChlc0t/wzNUTiyTuO+7PyxzppXfW4nN9xMZsbzHfdfD+H2s3LOl139o2TPC3xd8TGQGsVXHWgcRTLdf1T6k2kpL7d8DYRaiPv5wthQVBv5VHYBARCQ/NMFAR6Xj2ba/AeDQTH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KnFuzqsZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5F48320A6A;
	Mon,  4 Aug 2025 07:12:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJneWLsAwyEm; Mon,  4 Aug 2025 07:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754284373; bh=SUW5D5b5WsWlP0YMXjvvOTVOjakybqdppS5vTfywQuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KnFuzqsZn6Eu779yf9Zjp2zeH9TzXtH0ko/GWr/qkEkXclWSEbOcY7RI51Y3Q02tY
	 v+YDuPEz3tihyNqYug7+rVri3pLwnVEmaImpCGBao2hWTPC/XTEZVfetkvLNYgbsp2
	 Bm47ovlo1P9xSqxzVTabKRShhrSLx+oNtJzGY56dgdJQaPHT9lPR8yk1X49EXRqvK/
	 b/kGzebPdI83cxvfkSHPJzCbuHPA3wJ6Y1ZdTHE51/2vmPoQK/1LhRwPDTXgs49qcP
	 glOhiTuCkiv7ddJG7du/Wjd+a0pxoRfrGKUHvcz+N/k4Tf9SYfr2fmoRZIZgSVYmME
	 mkS+if9wO21pA==
Date: Mon, 4 Aug 2025 05:12:26 +0000
From: Yao Zi <ziyao@disroot.org>
To: Rob Herring <robh@kernel.org>
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
Message-ID: <aJBBOptU4IXilK3I@pie>
References: <20250801091240.46114-1-ziyao@disroot.org>
 <20250801091240.46114-3-ziyao@disroot.org>
 <20250803170206.GA525144-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803170206.GA525144-robh@kernel.org>

On Sun, Aug 03, 2025 at 12:02:06PM -0500, Rob Herring wrote:
> On Fri, Aug 01, 2025 at 09:12:39AM +0000, Yao Zi wrote:
> > It's necessary to adjust the MAC TX clock when the linkspeed changes,
> > but it's noted such adjustment always fails on TH1520 SoC, and reading
> > back from APB glue registers that control clock generation results in
> > garbage, causing broken link.
> > 
> > With some testing, it's found a clock must be ungated for access to APB
> > glue registers. Without any consumer, the clock is automatically
> > disabled during late kernel startup. Let's get and enable it if it's
> > described in devicetree.
> > 
> > Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > Reviewed-by: Drew Fustini <fustini@kernel.org>
> > Tested-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > index c72ee759aae5..95096244a846 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > @@ -211,6 +211,7 @@ static int thead_dwmac_probe(struct platform_device *pdev)
> >  	struct stmmac_resources stmmac_res;
> >  	struct plat_stmmacenet_data *plat;
> >  	struct thead_dwmac *dwmac;
> > +	struct clk *apb_clk;
> >  	void __iomem *apb;
> >  	int ret;
> >  
> > @@ -224,6 +225,11 @@ static int thead_dwmac_probe(struct platform_device *pdev)
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> >  				     "dt configuration failed\n");
> >  
> > +	apb_clk = devm_clk_get_optional_enabled(&pdev->dev, "apb");
> 
> The description sounds like this should not be optional. The binding 
> change also makes it not optional.

Yes, it shouldn't be. But using the non-optional API will cause the
driver fails to probe with the old (problematic) devicetree, IOW, it
breaks the ABI. Comparing to unusable ethernet, failing to adjust the
link speed sounds a minor point to me.

Maybe we could add a comment to explain why optional API is used, or
just use the non-optional one if such ABI breakages are acceptable --
for which I'd like to wait for more opinions.

> Rob
> 

Thanks,
Yao Zi

