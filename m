Return-Path: <netdev+bounces-131599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449A98EFC9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3D41F21B25
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C5194C89;
	Thu,  3 Oct 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="tC0eJzdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F187155314;
	Thu,  3 Oct 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960145; cv=none; b=rqUh4F5JE0rgsLeRCjVebwGPmg0urWBQ5/ovVNXn9aj+hos3L2KTj6B+m3QOW/Lxdfk4aIBOyKW7z5y2p47keSaw14sI3SDWQys4a1F1AijQ4IR/d0uaBXlblZUOVNMaBK3JDlxXmZj+1EZFVDiNasN/jeG82OiqQdtIVpF4QZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960145; c=relaxed/simple;
	bh=LjfR+SYE+hz2dmL3UKiGMzVNe/wy/ithoAN26BYTKgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uECha5HZYVdhc4fLdOlzHv4wKUuMR1C4EC7d/i//6V7+Xa2XTryvoxETpCQ8BRZs5GY8SEdgUo1IKaN5wbcs7cirxbLjwGObqkfwhXqswrb8qWh/bp5ppvzqi44K+rlWLGH2y/PoyJs7otx0H0BSvs3nrF3VrQGOUIgRRV30vLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=tC0eJzdm; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0C6E340A1DCA;
	Thu,  3 Oct 2024 12:55:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0C6E340A1DCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727960139;
	bh=oLJL8Tnp+DfhiuU2GiH/IZbrs3LTGo8QpaQXCMytIiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tC0eJzdmuJvC/DH1tiyxqUicewD0SWtHDHqpn1RtDcFeB1CHK6pmWFV4ABQqlYW79
	 zLi5vJaLeowf1v0v72h7tkQHyxhQNzBy4SO8br+pRCjvQ0HxI4oMt/Gmlm4/cFbZWu
	 S2otj442VQalj9qtjQFxNPOMTvwu9DvUDa6OJAus=
Date: Thu, 3 Oct 2024 15:55:35 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Simon Horman <horms@kernel.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: Re: [PATCH net] stmmac: dwmac-intel-plat: fix call balance of tx_clk
 handling routines
Message-ID: <20241003-31f0aab72f4bccce9337303f-pchelkin@ispras.ru>
References: <20240930183715.2112075-1-mordan@ispras.ru>
 <20241003111811.GJ1310185@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003111811.GJ1310185@kernel.org>

Hello,

On Thu, 03. Oct 12:18, Simon Horman wrote:
> On Mon, Sep 30, 2024 at 09:37:15PM +0300, Vitalii Mordan wrote:
> > If the clock dwmac->tx_clk was not enabled in intel_eth_plat_probe,
> > it should not be disabled in any path.
> > 
> > Conversely, if it was enabled in intel_eth_plat_probe, it must be disabled
> > in all error paths to ensure proper cleanup.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with Klever.
> > 
> > Fixes: 9efc9b2b04c7 ("net: stmmac: Add dwmac-intel-plat for GBE driver")
> > Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> > ---
> >  .../ethernet/stmicro/stmmac/dwmac-intel-plat.c   | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> > index d68f0c4e7835..2a2893f2f2a8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> > @@ -108,7 +108,12 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
> >  			if (IS_ERR(dwmac->tx_clk))
> >  				return PTR_ERR(dwmac->tx_clk);
> >  
> > -			clk_prepare_enable(dwmac->tx_clk);
> > +			ret = clk_prepare_enable(dwmac->tx_clk);
> > +			if (ret) {
> > +				dev_err(&pdev->dev,
> > +					"Failed to enable tx_clk\n");
> > +				return ret;
> > +			}
> >  
> >  			/* Check and configure TX clock rate */
> >  			rate = clk_get_rate(dwmac->tx_clk);
> > @@ -117,6 +122,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
> >  				rate = dwmac->data->tx_clk_rate;
> >  				ret = clk_set_rate(dwmac->tx_clk, rate);
> >  				if (ret) {
> > +					clk_disable_unprepare(dwmac->tx_clk);
> >  					dev_err(&pdev->dev,
> >  						"Failed to set tx_clk\n");
> >  					return ret;
> 
> Hi Vitalii,
> 
> I think that unwinding using a goto label would be more idiomatic here
> and in the following changes to intel_eth_plat_probe().
> 
> > @@ -131,6 +137,8 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
> >  			rate = dwmac->data->ptp_ref_clk_rate;
> >  			ret = clk_set_rate(plat_dat->clk_ptp_ref, rate);
> >  			if (ret) {
> > +				if (dwmac->data->tx_clk_en)
> > +					clk_disable_unprepare(dwmac->tx_clk);
> >  				dev_err(&pdev->dev,
> >  					"Failed to set clk_ptp_ref\n");
> >  				return ret;
> > @@ -150,7 +158,8 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
> >  
> >  	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> >  	if (ret) {
> > -		clk_disable_unprepare(dwmac->tx_clk);
> > +		if (dwmac->data->tx_clk_en)
> > +			clk_disable_unprepare(dwmac->tx_clk);
> 
> Smatch warns that dwmac->data may be NULL here.

FWIW, there is a patch [1] targeted at net-next which removes the seemingly
redundant check for dwmac->data.

[1]: https://lore.kernel.org/netdev/20240930183926.2112546-1-mordan@ispras.ru/

At the moment device_get_match_data() can't return NULL in probe function
of this driver - it gets the data from static const intel_eth_plat_match[]
table where every entry has defined non-NULL .data.

It's not expected (at least currently) that there would be any code changes
to the driver match table so it looks worthwhile to remove the check in
order to reduce additional complexity in error paths and
intel_eth_plat_remove().

That said, maybe it would be more safe now to rearrange the check to fail
at probe stage in case dwmac->data is NULL. Just not to confuse the static
analysis tools :)

Thanks!

> 
> >  		return ret;
> >  	}
> >  
> > @@ -162,7 +171,8 @@ static void intel_eth_plat_remove(struct platform_device *pdev)
> >  	struct intel_dwmac *dwmac = get_stmmac_bsp_priv(&pdev->dev);
> >  
> >  	stmmac_pltfr_remove(pdev);
> > -	clk_disable_unprepare(dwmac->tx_clk);
> > +	if (dwmac->data->tx_clk_en)
> 
> And I wonder if it can be NULL here too.
> 
> > +		clk_disable_unprepare(dwmac->tx_clk);
> >  }
> >  
> >  static struct platform_driver intel_eth_plat_driver = {
> > -- 
> > 2.25.1
> > 
> > 

