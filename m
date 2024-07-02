Return-Path: <netdev+bounces-108503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF29923FF0
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4543B1F21CB5
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA571B580F;
	Tue,  2 Jul 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce/nOE/3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7E1DDD6
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929368; cv=none; b=lTICZIdEcjsB3heVyCXCsNCPEKYjJITXm8wXv0lhFCNELf2mVzcmLWajAyUeBWh25h5LFrlcE+Vm4JvKr9NHmM6tN9lXlCUDB86gIrgy8C9rNh0FH4aLSfbpkhfHvD5zSAgIQLMYdPwV38MOxXzVfC3usW9EHH67zy4WvuGrozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929368; c=relaxed/simple;
	bh=xhlHllxL6Ugj0BPAxZb8Q9bLdgxr1mf3XJvuJ7RIVCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNw+7HjvTpR50zqbV3mv8MH7QlZzw4Z1F/+8ZJqehP3k2qIQOAbKZ5PtmpjgohHShAlc1YK7SBHUgPGx8vAaQ7zdokd4juNljBD7CpJPWqrEWNvTMhkQg1L9sMNOekw/pyHwUftEBZ55Gn3q0mQzYKmamK6Yycc3UOBkEa1dDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce/nOE/3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so59291481fa.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929364; x=1720534164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GveH1jdJEX5abJZDXwHDuGgSBcYe3bFFi3KUp+mwirw=;
        b=Ce/nOE/35NV83xQDbHF4YzdOv/GVwXLQqC/VLTC7fyfQCnB00C8ccjpcTHhhKHIUNo
         ROIiIDratrwPElV85qe0+nqDkgGHr5XcS07alD8oKDOB6gfpQY9GO0wPsXcm1tyjSWpD
         /xb+pQlFiMyGppc2kbBggrnCO5ZF3JGGQBN75n5Ofh3+FgxDOMGsZv81fpanansVABcK
         aKqY1Tn26QHclCdSYbzPZMT8Bpi5QzmV9O+20ZrZTKdp95OGUpswkHEi5SZJiFjT9L6h
         Ow+ceCjagHB+XSLL4ezJ8xLqC0TtnONIfvXjOFMJm8p1gnzS4QnpVPI+LYZm2onlnKVI
         K0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929364; x=1720534164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GveH1jdJEX5abJZDXwHDuGgSBcYe3bFFi3KUp+mwirw=;
        b=mZM+IyU6nbT8j2Q+RjKn8ETODvBu0pu6eKyN+mM4ieKjDY0ftY8gjuqqmTztg/goKx
         5QR3l0uZe9Kf9eZBt+sWomIM2tKNYP1a7bskDTi62fonEDSdwSxoX15DHTzOjG8IjwFj
         jiT+Y/BYOLtG3c+ZoaLqsGQEaYh3Rp1h3q4lC00ZZRqQz6rWm4j/KKy59O9kh9MSV0Lm
         GaF0Y8mFzZCXdlnclSEGoqsVpzxw5Xln01KZN83K2uSPqmJ17+z4JTmntruZ55vl4/rs
         EC+kOXk39hH3Ktivsp2uHEPcNCLGY+EY0F9PfqVTTOTOyj65dkAWEQoyvXcPtdcaydMr
         41pg==
X-Forwarded-Encrypted: i=1; AJvYcCV7lsELYeqxMh9SqG0KKBVZwNKDLPYglG7LWFWKjbQhfsa6Kd6wfuniqhFpgAgjIGoh5kRGbxT7jR0e418IkIDdIeE0xGer
X-Gm-Message-State: AOJu0Yzq2cEZrqX8iC91/owD95xErVdM+aeYRR6D1BT3eQzSf2EqSYif
	ue2K6rt1KHxHxnjylnbhRWXduMb2XsNyDV+nXfAF15GJxs7WiXhV
X-Google-Smtp-Source: AGHT+IE99WXUvsf4lyr/ln45UTEUm6ot1mZ2sy1XHZY9swHMDTUQC2HbnXmNWcESWgB4l47q/JyacQ==
X-Received: by 2002:a05:651c:90:b0:2ec:55b5:ed50 with SMTP id 38308e7fff4ca-2ee5e38097amr61087201fa.5.1719929363923;
        Tue, 02 Jul 2024 07:09:23 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e354sm16906381fa.19.2024.07.02.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:09:22 -0700 (PDT)
Date: Tue, 2 Jul 2024 17:09:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
 <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>

On Tue, Jul 02, 2024 at 09:14:07PM +0800, Yanteng Si wrote:
> 
> 在 2024/7/2 16:28, Serge Semin 写道:
> > On Wed, May 29, 2024 at 06:19:03PM +0800, Yanteng Si wrote:
> > > Loongson delivers two types of the network devices: Loongson GMAC and
> > > Loongson GNET in the framework of four CPU/Chipsets revisions:
> > > 
> > >     Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> > > LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> > > LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> > > LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> > > LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> > > 
> > > The driver currently supports the chips with the Loongson GMAC network
> > > device. As a preparation before adding the Loongson GNET support
> > > detach the Loongson GMAC-specific platform data initializations to the
> > > loongson_gmac_data() method and preserve the common settings in the
> > > loongson_default_data().
> > > 
> > > While at it drop the return value statement from the
> > > loongson_default_data() method as redundant.
> > Based on the last hardware setup insight Loongson GMAC with AV-feature
> > can be found on the LS2K2000 CPU. Thus the commit log should be:
> > 
> > "Loongson delivers two types of the network devices: Loongson GMAC and
> > Loongson GNET in the framework of four CPU/Chipsets revisions:
> > 
> >     Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> > LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> > LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> > LS2K2000 CPU         GMAC      0x7a03          v3.73a            8
> > LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> > LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> > 
> > The driver currently supports the chips with the Loongson GMAC network
> > device synthesized with a single DMA-channel available. As a
> > preparation before adding the Loongson GNET support detach the
> > Loongson GMAC-specific platform data initializations to the
> > loongson_gmac_data() method and preserve the common settings in the
> > loongson_default_data().
> > 
> > While at it drop the return value statement from the
> > loongson_default_data() method as redundant."
> OK, Thank you very much!
> > 
> > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > ---
> > >   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 ++++++++++++-------
> > >   1 file changed, 12 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > index 739b73f4fc35..ad3f44440963 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > @@ -11,7 +11,7 @@
> > >   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> > > -static int loongson_default_data(struct plat_stmmacenet_data *plat)
> > > +static void loongson_default_data(struct plat_stmmacenet_data *plat)
> > >   {
> > >   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
> > >   	plat->has_gmac = 1;
> > > @@ -20,16 +20,14 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
> > >   	/* Set default value for multicast hash bins */
> > >   	plat->multicast_filter_bins = 256;
> > > +	plat->mac_interface = PHY_INTERFACE_MODE_NA;
> > > +
> > >   	/* Set default value for unicast filter entries */
> > >   	plat->unicast_filter_entries = 1;
> > >   	/* Set the maxmtu to a default of JUMBO_LEN */
> > >   	plat->maxmtu = JUMBO_LEN;
> > > -	/* Set default number of RX and TX queues to use */
> > > -	plat->tx_queues_to_use = 1;
> > > -	plat->rx_queues_to_use = 1;
> > > -
> > >   	/* Disable Priority config by default */
> > >   	plat->tx_queues_cfg[0].use_prio = false;
> > >   	plat->rx_queues_cfg[0].use_prio = false;
> > > @@ -42,6 +40,11 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
> > >   	plat->dma_cfg->pbl = 32;
> > >   	plat->dma_cfg->pblx8 = true;
> > > +}
> > > +
> > > +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> > > +{
> > > +	loongson_default_data(plat);
> > >   	return 0;
> > >   }
> > > @@ -111,11 +114,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > >   	}
> > >   	plat->phy_interface = phy_mode;
> > > -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
> > >   	pci_set_master(pdev);
> > > -	loongson_default_data(plat);
> > > +	loongson_gmac_data(plat);
> > >   	pci_enable_msi(pdev);
> > >   	memset(&res, 0, sizeof(res));
> > >   	res.addr = pcim_iomap_table(pdev)[0];
> > > @@ -140,6 +142,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > >   		goto err_disable_msi;
> > >   	}
> > > +	plat->tx_queues_to_use = 1;
> > > +	plat->rx_queues_to_use = 1;
> > > +
> > Please move this to the loongson_gmac_data(). Thus all the
> > platform-data initializations would be collected in two coherent
> > methods: loongson_default_data() and loongson_gmac_data(). It will be
> > positive from the readability and maintainability points of view.
> 

> OK, I will move this to the  loongson_default_data(),
> 
> Because loongson_gmac/gnet_data() call it.

It shall also work. But the fields will be overwritten in the
loongson_gmac_data()/loongson_gnet_data() methods for the
multi-channels case. I don't have a strong opinion against that. But
some maintainers may have.

> 
> 
> > 
> > In the patch adding the Loongson multi-channel GMAC support make sure
> > the loongson_data::loongson_id field is initialized before the
> > stmmac_pci_info::setup() method is called.
> 
> I've tried. It's almost impossible.

Emm, why is it impossible? I don't see any significant problem with
implementing that.

> 
> 
> The only way to do this is to initialize loongson_id again in
> loongson_default_data().
> 
> But that will add a lot of code.

Not sure, why? What about the next probe() code snippet:

	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
	if (!plat)
		return -ENOMEM;

	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
					   sizeof(*plat->mdio_bus_data),
					   GFP_KERNEL);
        if (!plat->mdio_bus_data)
                return -ENOMEM;

	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
	if (!plat->dma_cfg)
		return -ENOMEM;

	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
	if (!ld)
		return -ENOMEM;

	/* Enable pci device */
 	ret = pci_enable_device(pdev);
 	if (ret)
		return ret;

	// AFAIR the bus-mastering isn't required for the normal PCIe
	// IOs. So pci_set_master() can be called some place
	// afterwards.
	pci_set_master(pdev);

	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
		if (pci_resource_len(pdev, i) == 0)
			continue;
		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
		if (ret)
			goto err_disable_device;
		break;
	}

	memset(&res, 0, sizeof(res));
	res.addr = pcim_iomap_table(pdev)[0];

	plat->bsp_priv = ld;
	plat->setup = loongson_dwmac_setup;
	ld->dev = &pdev->dev;
	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;

	info = (struct stmmac_pci_info *)id->driver_data;
	ret = info->setup(plat);
	if (ret)
		goto err_disable_device;

	if (dev_of_node(&pdev->dev))
 		ret = loongson_dwmac_dt_config(pdev, plat, &res);
	else
		ret = loongson_dwmac_acpi_config(pdev, plat, &res);

	if (ret)
		goto err_disable_device;

	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
		ret = loongson_dwmac_msi_config(pdev, plat, &res);
		if (ret)
			goto err_disable_device;
	}

	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
		goto err_clear_msi;

	return 0;

	...

The code allocates all the data, then enables the PCIe device
and maps the PCIe device resources. After that it calls all the setup
and config methods. Do I miss something?

-Serge(y)

> 
> 
> Hmm, how about:
> 
> 
> loongson_default_data() {
> 
>     plat->tx_queues_to_use = 1;
>     plat->rx_queues_to_use = 1;
> 
>     ...
> 
> }
> 
> 
> loongson_dwmac_probe() {
> 
>     ...
> 
>     if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
>         plat->rx_queues_to_use = CHANNEL_NUM;
>         plat->tx_queues_to_use = CHANNEL_NUM;
> 
>         /* Only channel 0 supports checksum,
>          * so turn off checksum to enable multiple channels.
>          */
>         for (i = 1; i < CHANNEL_NUM; i++)
>             plat->tx_queues_cfg[i].coe_unsupported = 1;
> 
>         ret = loongson_dwmac_msi_config(pdev, plat, &res);
>     } else {
>         ret = loongson_dwmac_intx_config(pdev, plat, &res);
>     }
> 
>     ...
> 
> }
> 
> 
> 
> Thanks,
> 
> Yanteng
> 
> > 
> > -Serge(y)
> > 
> > >   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> > >   	if (ret)
> > >   		goto err_disable_msi;
> > > -- 
> > > 2.31.4
> > > 
> 

