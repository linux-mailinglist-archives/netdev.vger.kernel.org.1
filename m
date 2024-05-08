Return-Path: <netdev+bounces-94626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7EE8C0037
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00939B20C0E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD3E84A23;
	Wed,  8 May 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYf7XwnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350077624
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179139; cv=none; b=cShu0utGb+Wja2t9q0B0/+BvYdR9u0Ut5j8ZRURzUwYWrKRZpv4uNsF8DXdpeTS4WGP1h7gH1ZVFAF1YHh6pGYkE9XAm2lCXooCMK5v+fF+mrWB5r57B2XM/PXr4wnYUXyCa0pk3891cCMEz95IIkkiCv1e5NmVSZbjd/yzMZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179139; c=relaxed/simple;
	bh=vK2+ORZcFIFmbd5FcENZ1RSHVRnFdp/zpiWJuRzGdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHbMkzEwzZa0I4+6FU7qktg/MCGoKYZLcNBRzsm2RZfY9w2/J8lfyI9idL5ewCcgNfEm1GY/eIu52+yxntK/FQrS4kHcQBqZAoVFIqiGwBQk/+p9TUVqlOSMGlZVRTDSxqBAPvUEXPU28IrXbZitW2k2N3Qt8OhTfpukqY7C2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYf7XwnI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e1fa824504so64544081fa.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715179136; x=1715783936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q11mZhBQ5RCgyYqvf0ZT/Zqv/lkMsD/ZITIy8YN6jWA=;
        b=GYf7XwnI/pABKW8d8ad209OPtUaUSBu8VFgK52mdZFIF7HOvCgs/KGkMHdI2GJt76I
         9gqGiLEKv6c2zrhMz9lyMHVWu2rdrXfhNJXzVH3dz//+lhw/xYR3oCHwA7OuffEYhx3g
         owY5SpvEtB5Of6kt/FPjAzomooCxWZ+DRv5yhK0DJsMP1Fsw7qb8hxzXUpcBZeYRV3bn
         E0+4CL0qxJR5ajH5baHJaX8+zhZnkhvNlPtTIKTCESOjjEgrNRVXkQip4hZ4siCG6fbf
         NAWDxGVzox12O/inclY2b3yxX09RynkfKdQXsZLsUM93eXvJ1Wr41P1ygpSTgrz9uLH+
         Ur3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715179136; x=1715783936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q11mZhBQ5RCgyYqvf0ZT/Zqv/lkMsD/ZITIy8YN6jWA=;
        b=wu3hks3X62kVcE15EaAoHN/oFqGqeqAJXzNFL2/Veo+4EOwmf5twMajEf6SU5qTN3e
         l6wvgMZlRmwvNQ8K6jbuFSt0dTxbx423SeKQuvpDxUWaWimAaQAPLKzYhOVW/W/hJAfw
         JTPq3uK1kTbqibN2nzMocBVZ0YDATWP+pJUR10gzBxIM2n6bSeFTETCtWBG8+dUhoXwx
         3p84Bwsss+1E09+UQkY3kDfbF7KMTqR+u7CdPbaqZMfBHv02FOhwSRrTnSx0DzwdwvQa
         tCFoPKhHutFLEJ9YvIE0PjdR7plNUgLR9nxKOnKQkVMGF1fnWBBtpxdT8RQpF0YHN+i5
         jMrw==
X-Forwarded-Encrypted: i=1; AJvYcCV//7AxnhHxQTBFV7MlKWjKuEe+JYD3edV/xdeca8akLQGMEj4KOAD3Yxk17IEHYZq6MZz8ZfG4eA0BoOa4XmxDAMs6OLD0
X-Gm-Message-State: AOJu0Yz4O/MQwjK4tKfXdD9QaHBVXJZEWZ5BRg4E1Tv3ssNI+2J0FLfP
	eLizWcsBfsTIPVYfhwlqukworBzENQh0DG4XrOIyqyFclXtPlgrC
X-Google-Smtp-Source: AGHT+IFOhe5QF0yVSgeXHEwAsukGTr3pHaBUSDLhkIdstfu3cOrTtbtfbXVHDwyFM6iGFW+7xgzNqQ==
X-Received: by 2002:a2e:9906:0:b0:2db:77c7:c4aa with SMTP id 38308e7fff4ca-2e4476ad0e7mr15946551fa.41.1715179135787;
        Wed, 08 May 2024 07:38:55 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u19-20020a2e9f13000000b002dd847e16b5sm2430123ljk.70.2024.05.08.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:38:55 -0700 (PDT)
Date: Wed, 8 May 2024 17:38:52 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn>

On Tue, May 07, 2024 at 09:35:24PM +0800, Yanteng Si wrote:
> Hi Serge,
> 
> 在 2024/5/6 18:39, Serge Semin 写道:
> > On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
> > > ...
> > > +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> > > +				     struct plat_stmmacenet_data *plat,
> > > +				     struct stmmac_resources *res,
> > > +				     struct device_node *np)
> > > +{
> > > +	int i, ret, vecs;
> > > +
> > > +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > > +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> > > +	if (ret < 0) {
> > > +		dev_info(&pdev->dev,
> > > +			 "MSI enable failed, Fallback to legacy interrupt\n");
> > > +		return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > +	}
> > > +
> > > +	res->irq = pci_irq_vector(pdev, 0);
> > > +	res->wol_irq = 0;
> > > +
> > > +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > > +	 * --------- ----- -------- --------  ...  -------- --------
> > > +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > > +	 */
> > > +	for (i = 0; i < CHANNEL_NUM; i++) {
> > > +		res->rx_irq[CHANNEL_NUM - 1 - i] =
> > > +			pci_irq_vector(pdev, 1 + i * 2);
> > > +		res->tx_irq[CHANNEL_NUM - 1 - i] =
> > > +			pci_irq_vector(pdev, 2 + i * 2);
> > > +	}
> > > +
> > > +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > ...
> > >   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >   {
> > >   	struct plat_stmmacenet_data *plat;
> > >   	int ret, i, bus_id, phy_mode;
> > >   	struct stmmac_pci_info *info;
> > >   	struct stmmac_resources res;
> > > +	struct loongson_data *ld;
> > >   	struct device_node *np;
> > >   	np = dev_of_node(&pdev->dev);
> > > @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > >   		return -ENOMEM;
> > >   	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> > > -	if (!plat->dma_cfg) {
> > > -		ret = -ENOMEM;
> > > -		goto err_put_node;
> > > -	}
> > > +	if (!plat->dma_cfg)
> > > +		return -ENOMEM;
> > > +
> > > +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > > +	if (!ld)
> > > +		return -ENOMEM;
> > >   	/* Enable pci device */
> > >   	ret = pci_enable_device(pdev);
> > > @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > >   		plat->phy_interface = phy_mode;
> > >   	}
> > > -	pci_enable_msi(pdev);
> > > +	plat->bsp_priv = ld;
> > > +	plat->setup = loongson_dwmac_setup;
> > > +	ld->dev = &pdev->dev;
> > > +
> > >   	memset(&res, 0, sizeof(res));
> > >   	res.addr = pcim_iomap_table(pdev)[0];
> > > +	ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
> > > +
> > > +	switch (ld->gmac_verion) {
> > > +	case LOONGSON_DWMAC_CORE_1_00:
> > > +		plat->rx_queues_to_use = CHANNEL_NUM;
> > > +		plat->tx_queues_to_use = CHANNEL_NUM;
> > > +
> > > +		/* Only channel 0 supports checksum,
> > > +		 * so turn off checksum to enable multiple channels.
> > > +		 */
> > > +		for (i = 1; i < CHANNEL_NUM; i++)
> > > +			plat->tx_queues_cfg[i].coe_unsupported = 1;
> > > -	plat->tx_queues_to_use = 1;
> > > -	plat->rx_queues_to_use = 1;
> > > +		ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
> > > +		break;
> > > +	default:	/* 0x35 device and 0x37 device. */
> > > +		plat->tx_queues_to_use = 1;
> > > +		plat->rx_queues_to_use = 1;
> > > -	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > +		break;
> > > +	}
> > Let's now talk about this change.
> > 
> > First of all, one more time. You can't miss the return value check
> > because if any of the IRQ config method fails then the driver won't
> > work! The first change that introduces the problem is in the patch
> > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> OK!
> > 
> > Second, as I already mentioned in another message sent to this patch
> > you are missing the PCI MSI IRQs freeing in the cleanup-on-error path
> > and in the device/driver remove() function. It's definitely wrong.
> You are right! I will do it.
> > Thirdly, you said that the node-pointer is now optional and introduced
> > the patch
> > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > If so and the DT-based setting up isn't mandatory then I would
> > suggest to proceed with the entire so called legacy setups only if the
> > node-pointer has been found, otherwise the pure PCI-based setup would
> > be performed. So the patches 10-13 (in your v12 order) would look
> 
> In this case, MSI will not be enabled when the node-pointer is found.
> 
> .
> 
> 
> In fact, a large fraction of 2k devices are DT-based, of course, many are
> PCI-based.

Then please summarise which devices need the DT-node pointer which
don't? And most importantly if they do why do they need the DT-node?

AFAICS currently both LS2K1000 and LS7A1000 GMACs require the DT-node
to get the MAC and LPI IRQ signals. AFAICS from your series LS7A2000
GNET is also DT-based for the same reason. But the LS2K2000 GNET case
is different. You say that some of the platforms have the respective
DT-node some don't, but at the same time you submitting this patch
which permits the MSI IRQs only for the LS7A2000 GNET. It looks
contradicting. Does it mean that the GNET devices may generate the
IRQs via both legacy (an IRQ signal directly connected to the system
GIC) and the PCI MSI ways?

Let's get the question to the more generic level. Are the Loongson
GNET and GMAC controllers able to generate the IRQs via both ways:
physical IRQ signal and PCI MSI?

Please don't consider this as a vastly meticulous review. I am just
trying to figure out how to make things less complicated and fix the
driver to permitting only the cases which are actually possible.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 
> 

