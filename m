Return-Path: <netdev+bounces-96003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED6C8C3F68
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93C11F20F8F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F9E14AD1E;
	Mon, 13 May 2024 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGknNCZi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9214A623
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597826; cv=none; b=LNkPokmkgybgCdvaPqds/ldAucj+FFYqJUKnKzdL0gCRo4brS+whpXIee4e8cPWjfPIGN4pZcherHRR1iNudOvAUUsTPZcDEtWdnF+meVthPJ0PGiYms4dwB6FGkOzqPXF7obeY8zuj8jrToEcnqbVTlEtjrQO1RSOOlepOHOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597826; c=relaxed/simple;
	bh=+8TQSwMULX0wjKqdFuaRDZj5UuEcIFBnFV7+u3fZh+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3T+VRdZDZCokOWcAKKmKWZvnjWESX1iSEUoUbc/8dxoDSS1r4/1dqUesXfplQNOrP4g1nPhhW2+0Xy4k43I2w08e2TJj9KjamJO0Iqs1kp0leGkBzD/UZSzzdwtkRNaNtqZFRPfBqX51SjGF9WQ3d55ZA6IuPcR8IKiEv++ars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGknNCZi; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e576057c06so20317701fa.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715597822; x=1716202622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kugewWFtKsS2PSv79+BF0l8CgJEGlH9/Oyy17X+DA6c=;
        b=GGknNCZiKQj7UvRS+jdxG+y8DEo00NetNWMMqIxppKr7koldzEPgDg729Ydqye3mja
         edJYl5VgsrNVLl2LEjkhKbFmZpG5JEXHDCGwelpHsKilpkV/43gOtcoL9qiSQeE1o+Ru
         LKNHKY9csLStl1eA3aum/KzxIdUm/+5m4/z70ktikgqJ6aOXQfe79RBfNOio7xhrX7Ot
         58rzIvrL3/1SnJ98cYKOI3drHX+gw/QaL49WIhO/330DWEwLn8iQbaqvO5y/cPXyWa+h
         57lQF7lQUEgeqfo/6kdn3LPj+vjDUlNxvaHsZ8I9Lh4YcA2FfP1u+SKkFmLTccd1Frt5
         bybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715597822; x=1716202622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kugewWFtKsS2PSv79+BF0l8CgJEGlH9/Oyy17X+DA6c=;
        b=O48R1S/SYg2MNrmkvRxrvm5h3pjNuLjho4l9RpaW2GfqHZFCtAdpO8h6ONW4fkWFgH
         g8U6DJEqs2c6V+EN+Q9w3oROwdrpeqZPm5UPCCn51Ury3OFvVpdo7IzrniBQc0Fwio9p
         fH+yiTOFOym6HWNFO5GCP8SiQ9xGQQHmpLFM7xMhIuL17KiqPhQhoM/ElCVfCrA2tq1+
         Xe50n6EhwYRSX0YViwJHcO3hEx8xSp8CYJeXvxC5xkA0MQV5XVArEU6RswJ3KdRXwpBb
         A/GZZegK07735RHCSLXMZc35kS+J4Ndmh1y4XmtL24g/JMnWdAdrrAiNtKeeMTb90+1w
         utYg==
X-Forwarded-Encrypted: i=1; AJvYcCXKYHsUQn9+zffiG3cQVXZn1o6EO0/iyNxpcAtMklf24Q6GqYwF+xkjdSwfdjzThEZHIKYt2pvjb1eMLoTkPiblcaEU3r0c
X-Gm-Message-State: AOJu0Yw4Bq1FTihkxH4zgHkzcnV8OMIo8okMH8qRyiGDF+T5OTuQvUse
	XrtuVIqHqyFcUsOyx4bbN5r4z49V1uJlSuODxuu3ejLK48pDj+Zv
X-Google-Smtp-Source: AGHT+IFwGSNBeba7jm0uqtPi/dmB5KrcATT/RVk6uTFtnWfoPcaYLKIRqzGZfC8gkHp5Eo8aliGkVA==
X-Received: by 2002:a2e:b609:0:b0:2d8:8b44:8ce with SMTP id 38308e7fff4ca-2e5204b1e4cmr60244591fa.46.1715597822083;
        Mon, 13 May 2024 03:57:02 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ce3a00sm14190541fa.48.2024.05.13.03.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:57:01 -0700 (PDT)
Date: Mon, 13 May 2024 13:56:58 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn>
 <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
 <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>

On Thu, May 09, 2024 at 04:57:44PM +0800, Yanteng Si wrote:
> Hi Serge
> 
> 在 2024/5/8 23:10, Serge Semin 写道:
> > On Wed, May 08, 2024 at 10:58:16PM +0800, Huacai Chen wrote:
> > > Hi, Serge,
> > > 
> > > On Wed, May 8, 2024 at 10:38 PM Serge Semin<fancer.lancer@gmail.com>  wrote:
> > > > On Tue, May 07, 2024 at 09:35:24PM +0800, Yanteng Si wrote:
> > > > > Hi Serge,
> > > > > 
> > > > > 在 2024/5/6 18:39, Serge Semin 写道:
> > > > > > On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
> > > > > > > ...
> > > > > > > +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> > > > > > > +                              struct plat_stmmacenet_data *plat,
> > > > > > > +                              struct stmmac_resources *res,
> > > > > > > +                              struct device_node *np)
> > > > > > > +{
> > > > > > > + int i, ret, vecs;
> > > > > > > +
> > > > > > > + vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > > > > > > + ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> > > > > > > + if (ret < 0) {
> > > > > > > +         dev_info(&pdev->dev,
> > > > > > > +                  "MSI enable failed, Fallback to legacy interrupt\n");
> > > > > > > +         return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > > > > > + }
> > > > > > > +
> > > > > > > + res->irq = pci_irq_vector(pdev, 0);
> > > > > > > + res->wol_irq = 0;
> > > > > > > +
> > > > > > > + /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > > > > > > +  * --------- ----- -------- --------  ...  -------- --------
> > > > > > > +  * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > > > > > > +  */
> > > > > > > + for (i = 0; i < CHANNEL_NUM; i++) {
> > > > > > > +         res->rx_irq[CHANNEL_NUM - 1 - i] =
> > > > > > > +                 pci_irq_vector(pdev, 1 + i * 2);
> > > > > > > +         res->tx_irq[CHANNEL_NUM - 1 - i] =
> > > > > > > +                 pci_irq_vector(pdev, 2 + i * 2);
> > > > > > > + }
> > > > > > > +
> > > > > > > + plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > > > > > +
> > > > > > > + return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > ...
> > > > > > >    static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > > > > >    {
> > > > > > >            struct plat_stmmacenet_data *plat;
> > > > > > >            int ret, i, bus_id, phy_mode;
> > > > > > >            struct stmmac_pci_info *info;
> > > > > > >            struct stmmac_resources res;
> > > > > > > + struct loongson_data *ld;
> > > > > > >            struct device_node *np;
> > > > > > >            np = dev_of_node(&pdev->dev);
> > > > > > > @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > > > > > >                    return -ENOMEM;
> > > > > > >            plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> > > > > > > - if (!plat->dma_cfg) {
> > > > > > > -         ret = -ENOMEM;
> > > > > > > -         goto err_put_node;
> > > > > > > - }
> > > > > > > + if (!plat->dma_cfg)
> > > > > > > +         return -ENOMEM;
> > > > > > > +
> > > > > > > + ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > > > > > > + if (!ld)
> > > > > > > +         return -ENOMEM;
> > > > > > >            /* Enable pci device */
> > > > > > >            ret = pci_enable_device(pdev);
> > > > > > > @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > > > > > >                    plat->phy_interface = phy_mode;
> > > > > > >            }
> > > > > > > - pci_enable_msi(pdev);
> > > > > > > + plat->bsp_priv = ld;
> > > > > > > + plat->setup = loongson_dwmac_setup;
> > > > > > > + ld->dev = &pdev->dev;
> > > > > > > +
> > > > > > >            memset(&res, 0, sizeof(res));
> > > > > > >            res.addr = pcim_iomap_table(pdev)[0];
> > > > > > > + ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
> > > > > > > +
> > > > > > > + switch (ld->gmac_verion) {
> > > > > > > + case LOONGSON_DWMAC_CORE_1_00:
> > > > > > > +         plat->rx_queues_to_use = CHANNEL_NUM;
> > > > > > > +         plat->tx_queues_to_use = CHANNEL_NUM;
> > > > > > > +
> > > > > > > +         /* Only channel 0 supports checksum,
> > > > > > > +          * so turn off checksum to enable multiple channels.
> > > > > > > +          */
> > > > > > > +         for (i = 1; i < CHANNEL_NUM; i++)
> > > > > > > +                 plat->tx_queues_cfg[i].coe_unsupported = 1;
> > > > > > > - plat->tx_queues_to_use = 1;
> > > > > > > - plat->rx_queues_to_use = 1;
> > > > > > > +         ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
> > > > > > > +         break;
> > > > > > > + default:        /* 0x35 device and 0x37 device. */
> > > > > > > +         plat->tx_queues_to_use = 1;
> > > > > > > +         plat->rx_queues_to_use = 1;
> > > > > > > - ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > > > > > +         ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > > > > > > +         break;
> > > > > > > + }
> > > > > > Let's now talk about this change.
> > > > > > 
> > > > > > First of all, one more time. You can't miss the return value check
> > > > > > because if any of the IRQ config method fails then the driver won't
> > > > > > work! The first change that introduces the problem is in the patch
> > > > > > [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
> > > > > OK!
> > > > > > Second, as I already mentioned in another message sent to this patch
> > > > > > you are missing the PCI MSI IRQs freeing in the cleanup-on-error path
> > > > > > and in the device/driver remove() function. It's definitely wrong.
> > > > > You are right! I will do it.
> > > > > > Thirdly, you said that the node-pointer is now optional and introduced
> > > > > > the patch
> > > > > > [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> > > > > > If so and the DT-based setting up isn't mandatory then I would
> > > > > > suggest to proceed with the entire so called legacy setups only if the
> > > > > > node-pointer has been found, otherwise the pure PCI-based setup would
> > > > > > be performed. So the patches 10-13 (in your v12 order) would look
> > > > > In this case, MSI will not be enabled when the node-pointer is found.
> > > > > 
> > > > > .
> > > > > 
> > > > > 
> > > > > In fact, a large fraction of 2k devices are DT-based, of course, many are
> > > > > PCI-based.
> > > > Then please summarise which devices need the DT-node pointer which
> > > > don't? And most importantly if they do why do they need the DT-node?
> > > Whether we need DT-nodes doesn't depend on device type, but depends on
> > > the BIOS type. When we boot with UEFI+ACPI, we don't need DT-node,
> > > when we boot with PMON+FDT, we need DT-node. Loongson machines may
> > > have either BIOS types.
> > Thanks for the answer. Just to fully clarify. Does it mean that all
> > Loongson Ethernet controllers (Loongson GNET and GMAC) are able to
> > deliver both PCI MSI IRQs and direct GIC IRQs (so called legacy)?
> 

> No, only devices that support multiple channels can deliver both PCI MSI
> IRQs
> 
> and direct GIC IRQs, other devices can only deliver GIC IRQs.
> 
> Furthermore, multiple channel features are bundled with MSI. If we want to
> 
> enable multiple channels, we must enable MSI.

Sadly to say but this information changes a lot. Based on that the
only platform with optional DT-node is the LS2K2000 GNET device. The
rest of the devices (GMACs and LS7A2000 GNET) must be equipped with a
node-pointer otherwise they won't work. Due to that the logic of the
patches
[PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
[PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
is incorrect.

1. [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
So this patch doesn't add a pure PCI-based probe procedure after all
because the Loongson GMACs are required to have a DT-node. AFAICS
pdev->irq is actually the IRQ retrieved from the DT-node. So the "if
(np) {} else {}" clause doesn't really make sense.

2. [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
First of all the function name is incorrect. The IRQ signal isn't legacy
(INTx-based), but is retrieved from the DT-node. Secondly the
"if (np) {} else {}" statement is very much redundant because if no
DT-node found the pdev->irq won't be initialized at all, and the
driver won't work with no error printed.

All of that also affects the patch/commit logs. Glad we figured that
out at this stage. Seeing there have been tons of another comments
let's postpone the discussion around this problem for v13 then. I'll
keep in mind the info you shared in this thread and think of the way
to fix the patches after v13 is submitted for review.

Thanks
-Serge(y)

> 
> Thanks,
> 
> Yanteng
> 

