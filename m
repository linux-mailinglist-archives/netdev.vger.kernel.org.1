Return-Path: <netdev+bounces-211493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130CB194CF
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9A93B32A2
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D881A08B8;
	Sun,  3 Aug 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJPYsnLd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324282E36E3;
	Sun,  3 Aug 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754246768; cv=none; b=oaKbfQhDPISot/UxVoBkGxtNnJ0JI061HDMMLSWX7aBYOjbOZG1HFmyLDcQPoEgmMuXyYIMkG6aCqiVtTQPwF8HnHh0A+6uqhf6ptiz5beag3H7yTOiSnPu1qKqWycWUaKsIu+gijfOY881iIR6ZJdz6Q85z56VQ7W7jRtUs3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754246768; c=relaxed/simple;
	bh=otAKeqlFXtkIQt27io/cIsPeuZzPBPKAvYiQNoQ3YCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM5TF3uedWpSBkyHeoxriZ7/3a5I8WfWfIT0VBEnI9OqDyydmRLNvWb3kI/UVAdCiuK53Q88Ft69l1m5TsjBhAYvUPWIbn+tQJONVpytbV8tF/PAoUkvBFurWNxb1rJ+SDCZ3DYnLQgNgYk+aBuOE4Yev3eKW48OlZ1vOIPpJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJPYsnLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CF1C4CEEB;
	Sun,  3 Aug 2025 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754246767;
	bh=otAKeqlFXtkIQt27io/cIsPeuZzPBPKAvYiQNoQ3YCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJPYsnLd8uSZeRjOt/Yd+mRmyOOQC247UfdgdYfR9pOvWudmYW5TMBA9Qc0rKhqCi
	 jpgZBWSLoRukVVKu9dFghpJZRK/ZF1cL5wpN8TzVK8eOrM4OcOjMPNx452eny3tBjP
	 U0lzTxYuzDnvLFwaCUTtkOcnclUGM69ZoHqAgba0h+f7mnrldwLxQCJ3Skux9CpdR+
	 NHwf4HU8osDsg0C7eHwpAfy+QhOxX3ZotZa4gIpp7REi3rCEMPxZXAjwH26XFP9Go1
	 HRbRuFqP66AK1HdT8QDglyqhEK4U84IU+b8zd90id+vS+T2wZ7q/HuHsIrvetnqRT1
	 XscfI0m3saNLw==
Date: Sun, 3 Aug 2025 11:46:05 -0700
From: Drew Fustini <fustini@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Guo Ren <guoren@kernel.org>,
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
Message-ID: <aI-ubdx3FJj_wm3a@gen8>
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

Good point, it should be devm_clk_get_enabled() otherwise the link speed
change bug will be possible. This series also changes the schema and dts
so I don't think compatibility is a problem.

Thanks,
Drew

