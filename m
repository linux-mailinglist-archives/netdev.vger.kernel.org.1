Return-Path: <netdev+bounces-211770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC2CB1B9CD
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 20:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DEE1883B31
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9316D293C5C;
	Tue,  5 Aug 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op3YUS62"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D40173;
	Tue,  5 Aug 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754417133; cv=none; b=TPfIeESUevcVDVM0bspl/5DP3HsTkqcOSE7DZzey14vvYx7hlmRd4E25agnvsLZzmr5SqdoGQKboQ/TRjQ/O002H7L0AJ+9bzpC+fu9HAmYJQMSWOWt8uDGYzI0QVPTtD7zhR5oVgPbiWHYFs70/r3to26WYskm8DkgswzoAkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754417133; c=relaxed/simple;
	bh=I8l4aEPhunyIiXsphJiO2yvHDN3RGwpiOWAw7vGoz/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqN9umCU6a9Vk5fYr2DtpLQtazCDij0AELNNuGWuNP+XkfAQxAqsfXtt66Ef4LOvBLS0f9X3CDwXIvRVZZxwWI2gs5Q+rRqB4FPmntVS1YRLAzKw2r2cAzUc5VR3oxL193CtDmi2+6gkNrtJ5PjEiEvAVDnyD9Rvr/VTUu522pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op3YUS62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A6FC4CEF0;
	Tue,  5 Aug 2025 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754417133;
	bh=I8l4aEPhunyIiXsphJiO2yvHDN3RGwpiOWAw7vGoz/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=op3YUS6265cXhd+My1YsGad9AV27PDz+VTP8/WsrMWqFxSudtHzhe1ymMLrPBCBik
	 +qkk7L+idjGN7g/YtAAu2ijGybT+7CTujSy+PtoM5kMbFYqq4gUzh3GrfeDhSQond0
	 K3uOg46ik/Timi7wcdKGG6qMgHA+P0/Bpi1owj9NMV6Kw7nduenteMgGaZPFxTF7kk
	 azUJmbA15/O1c7WLaJiFLF5m6l6HmW/O5h3SrBX03joISlYjbbG3aa9uNVVuTljcys
	 qdnhEseGcyZCndLSLU28g9St7H5qtpMqy6aMsdRq0kTn2N+YmnKUYAirkv7/3IKYWZ
	 bAT7xnCh8yhqA==
Date: Tue, 5 Aug 2025 11:05:31 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
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
Message-ID: <aJJH6wLqMO5XRTeW@x1>
References: <20250801091240.46114-1-ziyao@disroot.org>
 <20250801091240.46114-3-ziyao@disroot.org>
 <20250803170206.GA525144-robh@kernel.org>
 <aJBBOptU4IXilK3I@pie>
 <aJDeZJrKkqH23V/V@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJDeZJrKkqH23V/V@x1>

On Mon, Aug 04, 2025 at 09:23:00AM -0700, Drew Fustini wrote:
> On Mon, Aug 04, 2025 at 05:12:26AM +0000, Yao Zi wrote:
> > On Sun, Aug 03, 2025 at 12:02:06PM -0500, Rob Herring wrote:
> > > On Fri, Aug 01, 2025 at 09:12:39AM +0000, Yao Zi wrote:
> > > > It's necessary to adjust the MAC TX clock when the linkspeed changes,
> > > > but it's noted such adjustment always fails on TH1520 SoC, and reading
> > > > back from APB glue registers that control clock generation results in
> > > > garbage, causing broken link.
> > > > 
> > > > With some testing, it's found a clock must be ungated for access to APB
> > > > glue registers. Without any consumer, the clock is automatically
> > > > disabled during late kernel startup. Let's get and enable it if it's
> > > > described in devicetree.
> > > > 
> > > > Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
> > > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > > Reviewed-by: Drew Fustini <fustini@kernel.org>
> > > > Tested-by: Drew Fustini <fustini@kernel.org>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > index c72ee759aae5..95096244a846 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > @@ -211,6 +211,7 @@ static int thead_dwmac_probe(struct platform_device *pdev)
> > > >  	struct stmmac_resources stmmac_res;
> > > >  	struct plat_stmmacenet_data *plat;
> > > >  	struct thead_dwmac *dwmac;
> > > > +	struct clk *apb_clk;
> > > >  	void __iomem *apb;
> > > >  	int ret;
> > > >  
> > > > @@ -224,6 +225,11 @@ static int thead_dwmac_probe(struct platform_device *pdev)
> > > >  		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> > > >  				     "dt configuration failed\n");
> > > >  
> > > > +	apb_clk = devm_clk_get_optional_enabled(&pdev->dev, "apb");
> > > 
> > > The description sounds like this should not be optional. The binding 
> > > change also makes it not optional.
> > 
> > Yes, it shouldn't be. But using the non-optional API will cause the
> > driver fails to probe with the old (problematic) devicetree, IOW, it
> > breaks the ABI. Comparing to unusable ethernet, failing to adjust the
> > link speed sounds a minor point to me.
> 
> I've just read Conor's comment in the v1 again: 
> 
>  Nah, introduce the warnings. If the clock is required for operation, it
>  should be marked as such. You've made it optional in the driver, which
>  is the important part (backwards compatible) and you've got the dts
>  patch in the series.
> 
> Thus I think the argument I made in my reply to this thread is
> incorrect and the driver should remain backwards compatible.
> 
> > Maybe we could add a comment to explain why optional API is used, or
> > just use the non-optional one if such ABI breakages are acceptable --
> > for which I'd like to wait for more opinions.
> 
> I think a comment in the code about why it uses the optional variant of
> the function is a good idea.

I was chatting on devicetree irc channel, and I think that it would be
good to add something like this to the commit message:

 For the purposes of backwards compatibility, the probe will not fail if
 'apb' is not found, but the link will break if the speed changes after
 probe.

Also, if devm_clk_get_optional_enabled("apb") fails, then I think it
would be a good idea to warn the user that changing the link speed will
not be supported.

Thanks,
Drew

