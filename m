Return-Path: <netdev+bounces-116216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EAE94981B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9A528410B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71178762EF;
	Tue,  6 Aug 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFuyiYPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78847F4D
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971873; cv=none; b=eDsSQ0w9zqoPz1ecmpoO1mgk/iyt+mzN7/FRgCmsyHysGS/eE66G/b0NUn/gFlXeuu6DT+HeqhgUhBy/+AZsUFY0PP3hBC9SxPoQkGtETjegoVv+yO358FvmelEHsja8OMSw4KGGHL5Q3RCS8GSneXxmdVGfgSzjq0/t6lqhx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971873; c=relaxed/simple;
	bh=K6r04cfZWd81jij0gpWlWnc87KCXxNpGOAlrbquaN10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6M4rx/HV4DFaoRvy3IhEh1gaT0s9Dn0zT8aUoPCYAXmDt4+9aDe4BuFgntPzif7VpVtZedKz2yaoCL8XAyyfDiOIQp3BFjokzfl4i0xCQhYPzQ5rjtuznJZVHIiWbgD9JiGtUj5jpLSH7B+nikcZYfNusZhd4Kb5rwSbbHE7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFuyiYPj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f183f4fa63so1501911fa.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722971869; x=1723576669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VxCfjkj2JxpqrXRWGKs1SQ6eKO0hr0YIpfCGb2VPms=;
        b=JFuyiYPjDgb5y7qk7fftWcvjA0F/ZpaN4tq+nIJqz0684sh+uN/8QkZkQM7OJ0x0Fl
         yaEk4W/r2gwPN0E7f309txhaQH9wpPP8kgYB7iNzUD70ov0Wtf8d2Qvqd1xLt+QXoonS
         em/cvIMPl+OEh/UK2D07VIyvitRxOGcUjudDHwRO8IGASCzvotRlzt2sX7gM7EumLZLB
         H4XhzikebDQH+AvK1qTz91lsupw+rs/vI56GP4IY3CFRoTqPExHzXNQUCTmNcWsacnUu
         jtbGyAnX7/dtHtHakzq/AVUugAVxGUSRRHB3BfQj0zWEVsbULTAIz/KStPHolV+OpIby
         7pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722971869; x=1723576669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VxCfjkj2JxpqrXRWGKs1SQ6eKO0hr0YIpfCGb2VPms=;
        b=QiJsNwtNt/R6BfR/xEctC+5INaIGZyOfCklGJ0iKrk2o6jUgIau5R55rdn959fyDhj
         ZYCLtQJti4PzoevM8mLJ6rJk7+Dl24sEcGfMPcGO8MsZtmPNTwXxHv4URdEKFu5PaWmy
         d93rt7CKjAuWbn4H2lX6F0pv6V3QhOmTmSPuViBohij/q5pCIZGql4Y9nNDz0upVMvku
         Og2S0FGng8+N498j/e5GZTWft4WE+ifrT0zaL642vk4DPKachCvshwhj6rspTwO5I6xc
         t6BRzHqctaUyMQnOFcG4YiJNgPt3wRAhnq/rxQN007EFuMRI2xiv1spifFRRB1lgz47+
         tk1g==
X-Forwarded-Encrypted: i=1; AJvYcCUpEVFQBv9QY2Tl1je7/kFOJZUT295suINyXkRhnbnMUIg846ohNX9upSKfW70o8JWEIYyiXjCBp9Dr9ECOHFzsIoMRFjIC
X-Gm-Message-State: AOJu0Yz96L7O/IF/j11+f8p8gbKvst03iTS7uVUa7HMbYbZOIK4DfzJC
	z9dc/BzLeOgRjlbhAbtTziWSiOvshlwyrFQSqnOQHjTn1IgyitIe
X-Google-Smtp-Source: AGHT+IF6e05TECRr+31AeYF8WD6Y2olqbD5rvLeB2K2awee7Tzb5LBwo6SdHtz6G/wh17KVxEsv6Sw==
X-Received: by 2002:a2e:824c:0:b0:2f1:6519:4000 with SMTP id 38308e7fff4ca-2f165194143mr36435171fa.23.1722971868802;
        Tue, 06 Aug 2024 12:17:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c623csm15167781fa.63.2024.08.06.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:17:48 -0700 (PDT)
Date: Tue, 6 Aug 2024 22:17:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, diasyzhang@tencent.com, 
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v16 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
Message-ID: <4hqv526s32ldakdd3f6ue26q2sajdreyfdrivlwpmhpovwcjns@n7t7u2yqceaw>
References: <cover.1722924540.git.siyanteng@loongson.cn>
 <bd73bc86c1387f9786c610ab55b3c4dd47b907c2.1722924540.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd73bc86c1387f9786c610ab55b3c4dd47b907c2.1722924540.git.siyanteng@loongson.cn>

On Tue, Aug 06, 2024 at 07:00:22PM +0800, Yanteng Si wrote:
> The Loongson DWMAC driver currently supports the Loongson GMAC
> devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
> LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
> LS2K2000 SoC was released with the new version of the Loongson GMAC
> synthesized in. The new controller is based on the DW GMAC v3.73a
> IP-core with the AV-feature enabled, which implies the multi
> DMA-channels support. The multi DMA-channels feature has the next
> vendor-specific peculiarities:
> 
> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>        Name              Tx          Rx
>   DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>   DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>   DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>   DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>   DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
> field. It's 0x10 while it should have been 0x37 in accordance with
> the actual DW GMAC IP-core version.
> 3. There are eight DMA-channels available meanwhile the Synopsys DW
> GMAC IP-core supports up to three DMA-channels.
> 4. It's possible to have each DMA-channel IRQ independently delivered.
> The MSI IRQs must be utilized for that.
> 
> Thus in order to have the multi-channels Loongson GMAC controllers
> supported let's modify the Loongson DWMAC driver in accordance with
> all the peculiarities described above:
> 
> 1. Create the multi-channels Loongson GMAC-specific
>    stmmac_dma_ops::dma_interrupt()
>    stmmac_dma_ops::init_chan()
>    callbacks due to the non-standard DMA IRQ CSR flags layout.
> 2. Create the Loongson DWMAC-specific platform setup() method
> which gets to initialize the DMA-ops with the dwmac1000_dma_ops
> instance and overrides the callbacks described in 1. The method also
> overrides the custom Synopsys ID with the real one in order to have
> the rest of the HW-specific callbacks correctly detected by the driver
> core.
> 3. Make sure the platform setup() method enables the flow control and
> duplex modes supported by the controller.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>
> ...
>
> +
> +static int loongson_dwmac_msi_config(struct pci_dev *pdev,
> +				     struct plat_stmmacenet_data *plat,
> +				     struct stmmac_resources *res)
> +{
> +	int i, ret, vecs;
> +
> +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		dev_warn(&pdev->dev, "Failed to allocate MSI IRQs\n");
> +		return ret;
> +	}
> +
> +	res->irq = pci_irq_vector(pdev, 0);
> +
> +	for (i = 0; i < plat->rx_queues_to_use; i++) {
> +		res->rx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 1 + i * 2);
> +	}
> +
> +	for (i = 0; i < plat->tx_queues_to_use; i++) {
> +		res->tx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 2 + i * 2);
> +	}
> +
> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +
> +	return 0;
> +}
> +
> +static void loongson_dwmac_msi_clear(struct pci_dev *pdev)
> +{
> +	pci_free_irq_vectors(pdev);
> +}
> +
>  static int loongson_dwmac_dt_config(struct pci_dev *pdev,
>  				    struct plat_stmmacenet_data *plat,
>  				    struct stmmac_resources *res)
> @@ -146,6 +450,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
> +	struct loongson_data *ld;
>  	int ret, i;
>  
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> @@ -162,6 +467,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (!plat->dma_cfg)
>  		return -ENOMEM;
>  
> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> +	if (!ld)
> +		return -ENOMEM;
> +
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
>  	if (ret) {
> @@ -184,6 +493,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> +	plat->bsp_priv = ld;
> +	plat->setup = loongson_dwmac_setup;
> +	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
> +
>  	info = (struct stmmac_pci_info *)id->driver_data;
>  	ret = info->setup(pdev, plat);
>  	if (ret)
> @@ -196,6 +509,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (ret)
>  		goto err_disable_device;
>  
> +	/* Use the common MAC IRQ if per-channel MSIs allocation failed */
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +		loongson_dwmac_msi_config(pdev, plat, &res);
> +
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_plat_clear;
> @@ -205,6 +522,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  err_plat_clear:
>  	if (dev_of_node(&pdev->dev))
>  		loongson_dwmac_dt_clear(pdev, plat);

> +	loongson_dwmac_msi_clear(pdev);

Em, why have you dropped the if-statement here? That has caused the
Simon note to be posted. Please get it back:
+	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+		loongson_dwmac_msi_clear(pdev);

>  err_disable_device:
>  	pci_disable_device(pdev);
>  	return ret;
> @@ -214,12 +532,15 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct loongson_data *ld;
>  	int i;
>  
> +	ld = priv->plat->bsp_priv;
>  	stmmac_dvr_remove(&pdev->dev);
>  
>  	if (dev_of_node(&pdev->dev))
>  		loongson_dwmac_dt_clear(pdev, priv->plat);

> +	loongson_dwmac_msi_clear(pdev);

Ditto. Please get back the conditional MSI-clear method execution:
+
+	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+		loongson_dwmac_msi_clear(pdev);

* Note the empty line above the if-statement. 

-Serge(y)

>  
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (pci_resource_len(pdev, i) == 0)
> -- 
> 2.31.4
> 

