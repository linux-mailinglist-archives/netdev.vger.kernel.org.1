Return-Path: <netdev+bounces-224556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344CAB862E2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F312F1CC136A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0233A25B31B;
	Thu, 18 Sep 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eCd8PvGi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC661C3314;
	Thu, 18 Sep 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215815; cv=none; b=S/21kpOFMh1tX/FtoqGYaOo0NnfXMSbYyfavDcZTBp1/vJ+S+9VR6qpeh7aFUYRH/XKOisa45MxWC+aaunW5DSplEF4BwhfLdSg9sXB5eL0TJ5vz7bNjDfzhVa1W3if8pKfxSisX0JcXargXc2PBOHlxljFYYPRIQe/KZCFHyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215815; c=relaxed/simple;
	bh=0+HS+1qpYkL2lUHeHkicL6gdDQ3Ypfdr3kGKZ1ZjVwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAVkjbAE3PJkUIYkMSIorLplaAvDdlb3t+6N7Zt+1XDJN6frTQPBWBE0g4DTFu6fcTvnc1taqB4JFHinCIuwL8CVL8OL4hN1vLeNYnoI4c8szZX/+1MBc8L/bnMwk3ruEl/xzFyFJDgF3C7ogIdkT7O5qem7mu9qP/qYFB3aI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eCd8PvGi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gy/Z85EpA6PtugEQo7tOjG3wD8Ws/VL623KxkN4uUxg=; b=eCd8PvGiIcC61VFrTKq+rfWTo4
	gXilCPqrrdDWsaBvaiItkZCGj7Q1Za0o8TQFPU3zmt5Kt4H8rpVqqWNoU/LIZ8BeatYHkJI+w5DsC
	IhX/tepsPjuCWaV5amxVMQX+HvAQZexJwq9qOAimbFI7GgaIQovNbXow32YnHE//WnlH67UPT9+4x
	L4oyXn8ciroToLCc5xN8Gs648B02kcw759/Kr1ONF2jXe123CVwvTL44+O26XGC2rfrfMqrofk/AM
	aIG3nx5MfhxEURDQ1stujVejjeWdTFVEdsHskp4QxNDPRsVd8WdCKAAGFOLFfqRJFq6r8plyJaERq
	rNd8F/aQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51190)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzIFS-000000001Vp-1DNL;
	Thu, 18 Sep 2025 18:16:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzIFL-000000001Lm-0Tdb;
	Thu, 18 Sep 2025 18:16:39 +0100
Date: Thu, 18 Sep 2025 18:16:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: weishangjuan@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	yong.liang.choong@linux.intel.com, anthony.l.nguyen@intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, jan.petrous@oss.nxp.com,
	jszhang@kernel.org, inochiama@gmail.com, 0x1207@gmail.com,
	boon.khai.ng@altera.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v7 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <aMw-dgNiXgPeqeSz@shell.armlinux.org.uk>
References: <20250918085612.3176-1-weishangjuan@eswincomputing.com>
 <20250918090026.3280-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918090026.3280-1-weishangjuan@eswincomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 18, 2025 at 05:00:26PM +0800, weishangjuan@eswincomputing.com wrote:
> +	plat_dat->clk_tx_i = stmmac_pltfr_find_clk(plat_dat, "tx");
> +	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
> +	plat_dat->bsp_priv = dwc_priv;
> +	plat_dat->clks_config = eic7700_clks_config;
> +	dwc_priv->plat_dat = plat_dat;
> +
> +	ret = eic7700_clks_config(dwc_priv, true);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				ret,
> +				"error enable clock\n");
> +
> +	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> +	if (ret) {
> +		eic7700_clks_config(dwc_priv, false);
> +		return dev_err_probe(&pdev->dev,
> +				ret,
> +				"Failed to driver probe\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static void eic7700_dwmac_remove(struct platform_device *pdev)
> +{
> +	struct eic7700_qos_priv *dwc_priv = get_stmmac_bsp_priv(&pdev->dev);
> +
> +	stmmac_pltfr_remove(pdev);
> +	eic7700_clks_config(dwc_priv, false);

It would be nice to see the above code cleaned up like I did for all
the other stmmac glue drivers recently.

However, this is not to say this shouldn't be merged - but please
consider this if you do another rework of these patches, if not as
a follow-up patch.

Essentially, you can use devm_stmmac_pltfm_probe(), populate the
plat_dat->init() and plat_dat->exit() methods to call the
clks_config function, but as you don't want these methods to be
called during suspend/resume (because plat_dat->clks_config() is
already called there), provide empty plat_dat->suspend() and
plat_dat->resume() methods.

Bonus points if you include a patch which provides this functionality
as library functions in stmmac_platform.c which can be used to
initialise ->init() and ->exit() for this behaviour, and check other
stmmac platform glue drivers to see if they would benefit from using
these.

Of course, it would be nice not to have to go to the extent of
adding empty functions for ->suspend() and ->resume(), but stmmac has
a lot of weirdo history, and there was no easy way to maintain
compatibility without doing that when I added these two new methods.

Lastly, please consider using "net: stmmac: <shortened-glue-name>: blah"
as the subject so there's a consistent style for stmmac patches.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

