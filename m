Return-Path: <netdev+bounces-108957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 759C19265DA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC06BB24C8D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EBB18307B;
	Wed,  3 Jul 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIg9m7ca"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6218308A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023560; cv=none; b=VYjbZNAmZRCbWVel09Xm6MtT1xCLy9VWTVgrEs1zU9QWycsHgM3L01XSvVK+D6fN10zk6m2hFGylqj0naboQRC0t4fFnio1xjzcmAKaOoO/i7TmfONEbLuEGM2NeH/6aNX/f0ymvz372tX4PVZOlv6RpwOdHKi3IHfSPQK5NFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023560; c=relaxed/simple;
	bh=OrnBuWqkGC/SxYpNZXZN7OS11/YgLEAjJ1PmUUtZQWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxmVoAesnboSz6nHwuiM1DvihhPs+mT7K7AS/BO3ox3GT2CYI9b08hoqNe+Rp5qsQLjb2ZWj+/TMWRkSXCwPXenFkc8ZAhYarXrqRD2jvwjyjoO/xr2ipyO4vcgWiysMs03RK996ehVm5iO5aTyVR5ZI78Oyu8+qc5I3KsLcP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIg9m7ca; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso58919831fa.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720023557; x=1720628357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vUHTrKMcqYP0bBiD/Ixn8UKNaPDkfBR56HJg/FVEVLg=;
        b=WIg9m7cap/ALw+fYrY2kzZYil96FSWNNRRuRwZ2ZrNZm69FSI5JigovYPQKJctvKm0
         SQVWV0Po3Qs0/+MJTrE94dm3kRdWikJ0fR6XNy4AnTY+o155JZB8mZIkNOCfenU1Wdel
         yJuA5x1ks1X5NN+YRpCOXtsI+2QP4i+T53v3koUx2/TrYNawwyjZtrGlHmya26REQd3i
         ys0FUsJiyBMlQwicTkkeK2IyonKwOR2ZjMmJCsIyhYCiXHiYpSQI4z4ax+TCnAZF3Nfp
         HQjzhnRMso4LSdtzwAFtOn93UdM7qsKxicQVMS9UtZjW1XC2mD3fTelrAofTan4W++76
         jKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023557; x=1720628357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUHTrKMcqYP0bBiD/Ixn8UKNaPDkfBR56HJg/FVEVLg=;
        b=gZLqMgwzc+HHdBvQxKN1ZKAyBgJ2cl+2BToWkpNZr3D0PSY7dKQXMhHlEasUMpzPy2
         TyYW5+sK4jEK8DVABwdKHFKEDwQgTewVPu28knq/ywrRi6Tx9n1QueMdylcgAywf8vH8
         2DJdyd6PF4b1laseipwH5kBc2f/6gqOn98ivGw6DKgvB2/0fhvXjAQyECQZpayIYoY0z
         jnDSOth25aS7XOeDNq4AIdeV5+J9uXsot8ApbwHeTnAecMMFe1Sw3R99/h3EfdqMgfV6
         IzM5JwLgZdeHCwS1ry2tDEgeZYKwBvcDkxV/3pZS0uP5SDC9ZNsVdEX0iBbcrU70D5uN
         t5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWWV4+UFwdFTKJSMoeA8e/P6dtzVTfpe82ITXqfBPx428F9K761SW+Km6HgjqmWKtZ2dmIu7qaB5HJbS578xI80vHRJ+5DI
X-Gm-Message-State: AOJu0YyxTMMEo+sLp3bBhYt3LkjqK8PQiQHcs5w0+Uwsrj/KAszmNEcX
	0o422L8SNaMiPRnfMa/2ngxGR6FGwSYYVmhnbHB4Bm3g0Q8nhRgZ
X-Google-Smtp-Source: AGHT+IH/ZrR9FAAKxrE3FgUd9ZYgZVtYc/WWgfzNyVQOWZfozG10iEgKoqo7iu4rj16QUnhx9el/qg==
X-Received: by 2002:a2e:a98b:0:b0:2ee:4f22:33f9 with SMTP id 38308e7fff4ca-2ee5e38096fmr95838481fa.24.1720023554316;
        Wed, 03 Jul 2024 09:19:14 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee59fd21a5sm17229501fa.129.2024.07.03.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:19:13 -0700 (PDT)
Date: Wed, 3 Jul 2024 19:19:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
 <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
 <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>

On Wed, Jul 03, 2024 at 05:41:55PM +0800, Yanteng Si wrote:
> > > > > -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
> > > > >    	pci_set_master(pdev);
> > > > > -	loongson_default_data(plat);
> > > > > +	loongson_gmac_data(plat);
> > > > >    	pci_enable_msi(pdev);
> > > > >    	memset(&res, 0, sizeof(res));
> > > > >    	res.addr = pcim_iomap_table(pdev)[0];
> > > > > @@ -140,6 +142,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > > > >    		goto err_disable_msi;
> > > > >    	}
> > > > > +	plat->tx_queues_to_use = 1;
> > > > > +	plat->rx_queues_to_use = 1;
> > > > > +
> > > > Please move this to the loongson_gmac_data(). Thus all the
> > > > platform-data initializations would be collected in two coherent
> > > > methods: loongson_default_data() and loongson_gmac_data(). It will be
> > > > positive from the readability and maintainability points of view.
> > > OK, I will move this to the  loongson_default_data(),
> > > 
> > > Because loongson_gmac/gnet_data() call it.
> > It shall also work. But the fields will be overwritten in the
> > loongson_gmac_data()/loongson_gnet_data() methods for the
> > multi-channels case. I don't have a strong opinion against that. But
> > some maintainers may have.
> I see. I will move this to the loongson_gmac_data()/loongson_gnet_data().
> > 
> > > 
> > > > In the patch adding the Loongson multi-channel GMAC support make sure
> > > > the loongson_data::loongson_id field is initialized before the
> > > > stmmac_pci_info::setup() method is called.
> > > I've tried. It's almost impossible.
> > Emm, why is it impossible? I don't see any significant problem with
> > implementing that.
> Sorry, I've to take back my words.
> > 
> > > 
> > > The only way to do this is to initialize loongson_id again in
> > > loongson_default_data().
> > > 
> > > But that will add a lot of code.
> > Not sure, why? What about the next probe() code snippet:
> Full marks!
> > 
> > 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> > 	if (!plat)
> > 		return -ENOMEM;
> > 
> > 	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
> > 					   sizeof(*plat->mdio_bus_data),
> > 					   GFP_KERNEL);
> >          if (!plat->mdio_bus_data)
> >                  return -ENOMEM;
> > 
> > 	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> > 	if (!plat->dma_cfg)
> > 		return -ENOMEM;
> > 
> > 	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > 	if (!ld)
> > 		return -ENOMEM;
> > 
> > 	/* Enable pci device */
> >   	ret = pci_enable_device(pdev);
> >   	if (ret)
> > 		return ret;
> > 
> > 	// AFAIR the bus-mastering isn't required for the normal PCIe
> > 	// IOs. So pci_set_master() can be called some place
> > 	// afterwards.
> > 	pci_set_master(pdev);
> > 
> > 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > 		if (pci_resource_len(pdev, i) == 0)
> > 			continue;
> > 		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> > 		if (ret)
> > 			goto err_disable_device;
> > 		break;
> > 	}
> > 
> > 	memset(&res, 0, sizeof(res));
> > 	res.addr = pcim_iomap_table(pdev)[0];
> > 
> > 	plat->bsp_priv = ld;
> > 	plat->setup = loongson_dwmac_setup;
> > 	ld->dev = &pdev->dev;
> > 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
> > 
> > 	info = (struct stmmac_pci_info *)id->driver_data;
> > 	ret = info->setup(plat);
> > 	if (ret)
> > 		goto err_disable_device;
> > 
> > 	if (dev_of_node(&pdev->dev))
> >   		ret = loongson_dwmac_dt_config(pdev, plat, &res);
> > 	else
> 

> > 		ret = loongson_dwmac_acpi_config(pdev, plat, &res);
> 
> I don't know how to write this function, it seems that there
> 
> is no obvious acpi code in the probe method.

I've provided the method code here:
https://lore.kernel.org/netdev/glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlogkbim7gg@a3dxav5siczn/

It just gets the IRQ from the pci_device::irq field:

static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
				      struct plat_stmmacenet_data *plat,
				      struct stmmac_resources *res)
{
	if (!pdev->irq)
		return -EINVAL;

	res->irq = pdev->irq;

	return 0;
}

It implies that if there is no DT found on the platform or no DT-node
assigned to the device, the IRQ line was supposed to be detected via
the ACPI interface by the PCIe subsystem core. Just recently you said
that the Loongson platforms are either UEFI or U-boot based. So at
least the loongson_dwmac_acpi_config() method would imply that the IRQ
number was supposed to be retrieved by means of the ACPI interface.

> 
> > 
> > 	if (ret)
> > 		goto err_disable_device;
> > 
> > 	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
> > 		ret = loongson_dwmac_msi_config(pdev, plat, &res);
> > 		if (ret)
> > 			goto err_disable_device;
> > 	}
> 

> It seems that we don't need if else.
> 
> If failed to allocate msi,  it will fallback to intx.
> 
> so loongson_dwmac_msi_config also needs a new name. How about:
> 
> ...
> 
>     ret = loongson_dwmac_irq_config(pdev, plat, &res);
>     if (ret)
>         goto err_disable_device;

Well, I've been thinking about that for quite some time. The problem
with your approach is that you _always_ override the res->irq field
with data retrieved from pci_irq_vector(pdev, 0). What's the point in
the res->irq initialization in the loongson_dwmac_dt_config() method
then?

Originally I suggested to use the PCI_IRQ_INTX flag in the
loongson_dwmac_msi_config() method because implied that eventually we
could come up to some generic IRQs initialization method with no
IRQ-related code performed in the rest of the driver. But after some
brainstorming I gave up that topic for now. Sending comments connected
with that would mean to cause a one more discussion. Seeing we already
at v13 it would have extended the review process for even longer than
it has already got to.

So since the MSI IRQs are required for the multi-channels device it
would be better to allocate MSIs for that case only. Thus I'd preserve
the conditional loongson_dwmac_msi_config() execution and would drop
the PCI_IRQ_INTX flag seeing we aren't going to implement the generic
IRQ setup method anymore. Like this:

+static int loongson_dwmac_msi_config(struct pci_dev *pdev,
+				     struct plat_stmmacenet_data *plat,
+				     struct stmmac_resources *res)
+{
+	int i, ret, vecs;
+
+	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
+	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to allocate per-channels IRQs\n");
+		return ret;
+	}
+
+	res->irq = pci_irq_vector(pdev, 0);
+
+	for (i = 0; i < plat->rx_queues_to_use; i++) {
+		res->rx_irq[CHANNEL_NUM - 1 - i] =
+			pci_irq_vector(pdev, 1 + i * 2);
+	}
+	for (i = 0; i < plat->tx_queues_to_use; i++) {
+		res->tx_irq[CHANNEL_NUM - 1 - i] =
+			pci_irq_vector(pdev, 2 + i * 2);
+	}
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+
+	return 0;
+}

* Please note the pci_alloc_irq_vectors(..., vecs, vecs, PCI_IRQ_MSI) arguments.

Seeing the discussion has started anyway, could you please find out
whether the multi-channel controller will still work if the MSI IRQs
allocation failed? Will the multi-channel-ness still work in that
case?

If the IRQ events from _all_ DMA-channels would still be delivered via
the main MAC IRQ (AFAICS from the DW GMAC v3.73a HW databook it works
like that by default), then we could ignore the errors returned from
the loongson_dwmac_msi_config() method, and simplify the probe()
method like this:

	/* Fallback to the common MAC IRQ if MSIs allocation failed */
	if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH)
		loongson_dwmac_msi_config(pdev, plat, &res);

-Serge(y)

> 
>     ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> 
> ...
> 
> 
> 
> > 
> > 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> >   	if (ret)
> > 		goto err_clear_msi;
> > 
> > 	return 0;
> > 
> > 	...
> > 
> > The code allocates all the data, then enables the PCIe device
> > and maps the PCIe device resources. After that it calls all the setup
> > and config methods. Do I miss something?
> 
> You are right!
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
> > > > > 2.31.4
> > > > > 
> 

