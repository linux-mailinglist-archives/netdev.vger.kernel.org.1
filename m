Return-Path: <netdev+bounces-211855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B275DB1BEF7
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 05:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD131162963
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0DB49620;
	Wed,  6 Aug 2025 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Hdj7aSvw"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7B79F2;
	Wed,  6 Aug 2025 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449395; cv=none; b=t5SnNc0UGI8gsblMxfh0AuYlu9OVlkFb1hwezZ0pTVzrruxx0PTV5jc7OHcp7GhsSDJeTUqmfnrb3KzIuoVontCjqjG8YSgPVQEoYBVqRPIKhmZZemRyUuZgE0arUzO+rdsrycESpD9LpKQNxRXUEQDyOPdJaCLhtuFvN6WLJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449395; c=relaxed/simple;
	bh=fyIkXN5YxBF92Jk3fC3dvGetl4/UPKeitt9ZBL/oLWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t716SKwozL3TkLsiZWg2y5AjnhvHASW8FM7aYNIsV/q5mw8r07K3iB6rOO+X0E24lI+5GEmCIb0hgjTkIOZrNipeGUkEUoocc8IyuuGLpcguFbnB0ds6EJPvAMzO5PlVtvPPjlF8YCfHLntKMpTSZUNsN1QX9TS9feDmlDOFWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Hdj7aSvw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B5984206A5;
	Wed,  6 Aug 2025 05:03:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DiazYPl_U3fV; Wed,  6 Aug 2025 05:03:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754449383; bh=fyIkXN5YxBF92Jk3fC3dvGetl4/UPKeitt9ZBL/oLWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hdj7aSvwPl9zceSTDOp6/Ns1r+OOpra44MJmXsq39Mjf63o5V2uI9lLbYAU6KCf6s
	 s6qYgqE5FZTJzT9DCUkZH2Mh5WH4tw7OTHIcWpcOlpaDKotUBo3BVk+bkyWpfDDiKD
	 w+OrJYkDc+sDFG2WiBmivd1q4Ooq6ZMopyHa7x95KoRjhFXliP/4tYJAvfZ89YCSYR
	 NlLpc+XCQGuA7MaAGh+kgSOrYdzA3LHS3aaeGF+3RgeNoG9HseUgBy8Cs1APwH1Uys
	 sHrb05ZOsDzp3ou2CFUDEkaS2ypL1AxqwQPxy8At1PasNfyydI17yBn7yASO+hKJ9C
	 toKEEnEB9IA2w==
Date: Wed, 6 Aug 2025 03:02:43 +0000
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Guo Ren <guoren@kernel.org>,
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
Message-ID: <aJLF07Sw9IatHmUq@pie>
References: <20250801091240.46114-1-ziyao@disroot.org>
 <20250801091240.46114-3-ziyao@disroot.org>
 <20250803170206.GA525144-robh@kernel.org>
 <aJBBOptU4IXilK3I@pie>
 <aJDeZJrKkqH23V/V@x1>
 <aJJH6wLqMO5XRTeW@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJJH6wLqMO5XRTeW@x1>

On Tue, Aug 05, 2025 at 11:05:31AM -0700, Drew Fustini wrote:
> On Mon, Aug 04, 2025 at 09:23:00AM -0700, Drew Fustini wrote:
> > On Mon, Aug 04, 2025 at 05:12:26AM +0000, Yao Zi wrote:
> > > On Sun, Aug 03, 2025 at 12:02:06PM -0500, Rob Herring wrote:
> > > > On Fri, Aug 01, 2025 at 09:12:39AM +0000, Yao Zi wrote:
> > > > > It's necessary to adjust the MAC TX clock when the linkspeed changes,
> > > > > but it's noted such adjustment always fails on TH1520 SoC, and reading
> > > > > back from APB glue registers that control clock generation results in
> > > > > garbage, causing broken link.
> > > > > 
> > > > > With some testing, it's found a clock must be ungated for access to APB
> > > > > glue registers. Without any consumer, the clock is automatically
> > > > > disabled during late kernel startup. Let's get and enable it if it's
> > > > > described in devicetree.
> > > > > 
> > > > > Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
> > > > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > > > Reviewed-by: Drew Fustini <fustini@kernel.org>
> > > > > Tested-by: Drew Fustini <fustini@kernel.org>
> > > > > ---
> > > > >  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > > index c72ee759aae5..95096244a846 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > > @@ -211,6 +211,7 @@ static int thead_dwmac_probe(struct platform_device *pdev)
> > > > >  	struct stmmac_resources stmmac_res;
> > > > >  	struct plat_stmmacenet_data *plat;
> > > > >  	struct thead_dwmac *dwmac;
> > > > > +	struct clk *apb_clk;
> > > > >  	void __iomem *apb;
> > > > >  	int ret;
> > > > >  
> > > > > @@ -224,6 +225,11 @@ static int thead_dwmac_probe(struct platform_device *pdev)
> > > > >  		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> > > > >  				     "dt configuration failed\n");
> > > > >  
> > > > > +	apb_clk = devm_clk_get_optional_enabled(&pdev->dev, "apb");
> > > > 
> > > > The description sounds like this should not be optional. The binding 
> > > > change also makes it not optional.
> > > 
> > > Yes, it shouldn't be. But using the non-optional API will cause the
> > > driver fails to probe with the old (problematic) devicetree, IOW, it
> > > breaks the ABI. Comparing to unusable ethernet, failing to adjust the
> > > link speed sounds a minor point to me.
> > 
> > I've just read Conor's comment in the v1 again: 
> > 
> >  Nah, introduce the warnings. If the clock is required for operation, it
> >  should be marked as such. You've made it optional in the driver, which
> >  is the important part (backwards compatible) and you've got the dts
> >  patch in the series.
> > 
> > Thus I think the argument I made in my reply to this thread is
> > incorrect and the driver should remain backwards compatible.
> > 
> > > Maybe we could add a comment to explain why optional API is used, or
> > > just use the non-optional one if such ABI breakages are acceptable --
> > > for which I'd like to wait for more opinions.
> > 
> > I think a comment in the code about why it uses the optional variant of
> > the function is a good idea.
> 
> I was chatting on devicetree irc channel, and I think that it would be
> good to add something like this to the commit message:
> 
>  For the purposes of backwards compatibility, the probe will not fail if
>  'apb' is not found, but the link will break if the speed changes after
>  probe.
> 
> Also, if devm_clk_get_optional_enabled("apb") fails, then I think it
> would be a good idea to warn the user that changing the link speed will
> not be supported.

Both sound reasonable to me, and I'll add them in v3, thanks.

> Thanks,
> Drew

Best regards,
Yao Zi

