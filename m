Return-Path: <netdev+bounces-60831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07CA821A02
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550241F222C6
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8ACD28F;
	Tue,  2 Jan 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y23oMGeV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB0EAC0
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0EYHR5FQDx4qCuCQkrICDQTt0+NHfy0uXegQFSytOio=; b=Y23oMGeVkY2Cicz68YEXYRnZLD
	FeNLfajeAVs1TV0F1HrSWAjtAkdfFZr8bLwiofhyGYuebzCHhhelF5M4SlTSSZitH/hsPGkMTxSz4
	VgFwpmvsTpf8rDexdCBY7kmkFCraw2J5RrRbiZC1qyRnSmjzmtZc4bGY/21A7STZoXo3U1kRt+01r
	MkS4Ig7jxIC5K+v2uwScl/Wv1M5PsMREKVG+J0Id8oeRiDRPd0W6WhRvNnxVxIpQwcgfHQaYU+BAB
	esNEnPH+m1tuRgCVNosyMQIZTy+XwByCf3zh2OkHeAJcM+O+R7MD/8ShuyTSxaKELEh9k/zROkuRG
	VndqKiow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51712)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKc9L-0006Of-2q;
	Tue, 02 Jan 2024 10:37:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKc9M-0005BN-0m; Tue, 02 Jan 2024 10:37:32 +0000
Date: Tue, 2 Jan 2024 10:37:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 2/9] net: stmmac: dwmac-loongson: Refactor
 code for loongson_dwmac_probe()
Message-ID: <ZZPnaziDZEcv5GGw@shell.armlinux.org.uk>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <aee820a3c4293c8172edda27ad4eb9cf5eaead5e.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee820a3c4293c8172edda27ad4eb9cf5eaead5e.1702990507.git.siyanteng@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 19, 2023 at 10:17:05PM +0800, Yanteng Si wrote:
> Add a setup() function to initialize data, and simplify code for
> loongson_dwmac_probe().

Not all changes in this patch are described.

> +static int loongson_gmac_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
> +{
> +	loongson_default_data(pdev, plat);
> +
> +	plat->multicast_filter_bins = 256;
> +
> +	plat->mdio_bus_data->phy_mask = 0;
>  
> -	/* Default to phy auto-detection */
>  	plat->phy_addr = -1;
> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;

This presumably sets the default phy_interface mode?


> -	plat->bus_id = of_alias_get_id(np, "ethernet");
> -	if (plat->bus_id < 0)
> -		plat->bus_id = pci_dev_id(pdev);
> +	pci_set_master(pdev);
> +
> +	info = (struct stmmac_pci_info *)id->driver_data;
> +	ret = info->setup(pdev, plat);
> +	if (ret)
> +		goto err_disable_device;

loongson_gmac_data() gets called from here...

> +
> +	bus_id = of_alias_get_id(np, "ethernet");
> +	if (bus_id >= 0)
> +		plat->bus_id = bus_id;
>  
>  	phy_mode = device_get_phy_mode(&pdev->dev);
>  	if (phy_mode < 0) {

This gets the PHY interface mode, and errors out if it can't be found in
firmware.

> @@ -110,11 +137,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	}
>  
>  	plat->phy_interface = phy_mode;

So this ends up always overwriting the value written in
loongson_gmac_data(). So it seems to be that initialising
plat->phy_interface in loongson_gmac_data() is just patch noise and
serves no real purpose.

> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;

This has now gone - and is not described, and I'm left wondering what
the implication of that is on the driver. It also makes me wonder
whether loongson_gmac_data() should've been setting mac_interface
rather than phy_interface.

>  	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>  	if (res.wol_irq < 0) {
> -		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
> +		dev_info(&pdev->dev,
> +			 "IRQ eth_wake_irq not found, using macirq\n");

Whitespace cleanups should be a separate patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

