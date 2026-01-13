Return-Path: <netdev+bounces-249602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4FD1B71D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB37E30131FA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6234D4F9;
	Tue, 13 Jan 2026 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUtJyVo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5234AAFB;
	Tue, 13 Jan 2026 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340285; cv=none; b=ZhZaMf+Yen2QbBpKYSqZ2rECOrrR/ZOx/+p06g86w4+y0CJLXIYqLHJq4Bo39DIxj3ZRhzsELF5vnSDEgdau3RRrkqEbZYXim9FYwrNduWMZ7VI4galmwDu1RlQwp081Y9cOABCG+JD/Fb9ZFdE5SByb+7de7Jd/2/hLaGq5R9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340285; c=relaxed/simple;
	bh=Ue0kX6WDxmwPMCZ/GKz/k0/R9KvOYfmHiZqM0wnXDGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIhVcEwX7dhN2+qnNP/n+2JvD+XjVuhl9mBJ1o7bzfUhv8EWdnPjX3i9+yoPQ1HeoiQJdIeh2ZRULruSBtbdNIEo4kY6qqYj6NgS0z2MvkBmYfUn48jXwjsHPL3+ci+NDn4XgAuqvd+gnqfQgjO8dtA+BvZZ+3fJBUgWEqhLgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUtJyVo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A9C16AAE;
	Tue, 13 Jan 2026 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340285;
	bh=Ue0kX6WDxmwPMCZ/GKz/k0/R9KvOYfmHiZqM0wnXDGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HUtJyVo6tFy6D2+6OTOd9Tv6Ujj2G4eqP8Sqsp6CvXxIi0m6pfEMUN9iQxl2niTkb
	 MZaA2823gSY+QqfaKURHBIVDbZc6kHXd5Hsqd4GW/aUmuaqZ9Vea7JPQ94ATsXpG+Y
	 RAtRBh5tNZx6yt9jD7gISK/kxvrTOs0VHn/zOsN8sEa7+raVMmkzjhQIMdXZS2txTA
	 8s2gr8MCbCvgLXZdWwiugtv+zvnvfh45af0wunCFtZQ8R7v9V0Du6A+WQhnk1Yd8oS
	 tc7eRpVIAqyjS6oMMCbu1n7emEUzmAUwM2WG51axjcZknTaW+UKkGNvjFyCD2sQYjb
	 gaJE9bb5U6EGQ==
Message-ID: <a2dc72ae-0798-4baa-b4d2-fa66c334576a@kernel.org>
Date: Tue, 13 Jan 2026 15:37:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: stmmac: socfpga: add call to assert/deassert
 ahb reset line
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mamta Shukla <mamta.shukla@leica-geosystems.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 bsp-development.geo@leica-geosystems.com,
 Pengutronix Kernel Team <kernel@pengutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
 <20260108-remove_ocp-v3-1-ea0190244b4c@kernel.org>
 <aV_W2yLmnHrTvbTP@shell.armlinux.org.uk>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <aV_W2yLmnHrTvbTP@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/8/26 10:10, Russell King (Oracle) wrote:
> On Thu, Jan 08, 2026 at 07:08:09AM -0600, Dinh Nguyen wrote:
>> The "stmmaceth-ocp" reset line of stmmac controller on the SoCFPGA
>> platform is essentially the "ahb" reset on the standard stmmac
>> controller. But since stmmaceth-ocp has already been introduced into
>> the wild, we cannot just remove support for it. But what we can do is
>> to support both "stmmaceth-ocp" and "ahb" reset names. Going forward we
>> will be using "ahb", but in order to not break ABI, we will be call reset
>> assert/de-assert both ahb and stmmaceth-ocp.
>>
>> The ethernet hardware on SoCFPGA requires either the stmmaceth-ocp or
>> ahb reset to be asserted every time before changing the phy mode, then
>> de-asserted when the phy mode has been set.
> 
> This is not SoCFPGA specific. The dwmac core only samples its
> phy_intf_sel_i signals when coming out of reset, and then latches
> that as the operating mode.
> 
> Currently, the dwmac core driver does not support dynamically changing
> plat_dat->phy_interface at runtime. That may change in the future, but
> as it requires a hardware reset which will clear out the PTP state, it
> would need consideration of that effect.
> 
> The SoCFPGA driver only calls the set_phy_mode() methods from
> socfpga_dwmac_init(), which in turn is called from the plat_dat->init
> hook. This will be called from:
> 
> 1. When stmmac_dvr_probe() is called, prior to allocating any
>     resources, and prior to the core driver's first call to:
>     reset_control_deassert(priv->plat->stmmac_ahb_rst);
> 
> 2. As plat_dat->resume is not populated by the glue driver, the init
>     hook will also be called when resuming from stmmac_resume().
> 
> Lastly, nothing in the main driver corrently writes to ->phy_interface.
> 
> I would like to see the platform glue drivers using more of what is
> in the core driver, rather than re-inventing it, so I support the
> idea of getting rid of dwmac->stmmac_ocp_rst.
> 
> What I suggest is to get rid of dwmac->stmmac_ocp_rst now.
> devm_stmmac_probe_config_dt() will parse the device tree, looking for
> the "ahb" reset, and assigning that to plat->stmmac_ahb_rst. If it
> doesn't exist, then plat->stmmac-ahb_rst will be NULL.
> 
> So, in socfpga_dwmac_probe(), do something like this:
> 
> 	struct reset_control *ocp_rst;
> ...
> 	if (!plat_dat->stmmac_ahb_rst) {
> 		ocp_rst = devm_reset_control_get_optional(dev, "stmmaceth-ocp");
> 		if (IS_ERR(ocp_rst))
> 			return dev_err_probe(dev, PTR_ERR(ocp_rst),
> 					     "failed to get ocp reset");
> 
> 		if (ocp_rst)
> 			dev_warn(dev, "ocp reset is deprecated, please update device tree.\n");
> 
> 		plat_dat->stmmac_ahb_rst = ocp_rst;
> 	}
> 
> Then, change all remaining instances of dwmac->stmmac_ocp_rst to
> dwmac->plat_dat->stmmac_ahb_rst... and job done. You have compatibility
> with device trees that use "ahb", and with device trees that use
> "stmmaceth-ocp".
> 
> Given that struct socfpga_dwmac contains the plat_dat pointer, rather
> than copying plat_dat->stmmac_rst to your private structure, please
> use the one in the plat_dat structure.
> 
> The next question I have is - do you need to assert both the AHB reset
> and stmmac_rst to set the PHY interface mode? I don't see a dependency
> between these two resets in the socfpga code - the driver doesn't treat
> them as nested. It asserts the AHB reset _then_ the stmmac reset, and
> then releases them in the same order rather than reverse order. This
> suggests there's no interdependence between them, and probably it's
> only necessary to assert the stmmac core's reset (stmmac_rst).
> 
> So, maybe the driver can leave the handling of plat_dat->stmmac_ahb_rst
> to the stmmac core code?
> 

Thanks for the suggestion. According to this commit[1], it seems that 
both reset lines need to get toggled. But I'm going to run some test on 
HW and make the appropriate changes.

Dinh

[1] 
https://lore.kernel.org/all/20250205134428.529625725@linuxfoundation.org/


