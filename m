Return-Path: <netdev+bounces-93312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6218BB228
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116642818E5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6CA15820C;
	Fri,  3 May 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAdShHaI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FD1BF24
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759705; cv=none; b=gTiB7DuIKo/yl28q3mavVHpXRFI9+9Zvhx+QLNadDb7XfqThsQUi+QQggW1vf5t3TB8JDRkAIWsB4ZIg3hi0WdTNibFzVTWm67KpSc8X9lZNCyw9KUZUI0E4CSeJGa26gLypAU4obN0+dC2UI/8uoSsfeRrSWbd/coWJWXcTjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759705; c=relaxed/simple;
	bh=k0cZVmW0r/OQh7284heE5kjeti8omy7OxmAn/y6XxlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq+vqDSw6qr2RwmFGBozLzKCa3cQap8GioDWAkgwYkIsYxA5+5Vqe9s4revltgPqyihEKqmLunBZCEy4Kfc1GI/+3Ee+3veK1H8OZ1pxcS3aWv/mq0seGZpnnnUiFmMgkNISUdLmq+lOps0/2SW7I8WO9IA5iRx2s+WuNu9s30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAdShHaI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51fb14816f6so818435e87.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714759701; x=1715364501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrzBRKrwlaLKjmnKE0p/O+Dhcgp4pyeofgboWhgqrYA=;
        b=CAdShHaIez8x7FaSFhbb+qV5Eqrb9s72s57E6WnmWMQPRgw/U/ifmAQXUHNREC3WCa
         Q6L9r6TLELstBb4ZXyTl1sYjx4RxhPYqyfNg0o44WQqfycpEl480YAC1YieF8khk+gAP
         YUJVWEqkddlaBjK00rZeSSpJxR9Waw8/xDTNy4VR3wW5q1L4/h4MsDscsDufuSyDmXaA
         B2JwQWXBCK4kHAhYUaxBope6ZL0zwTjpuYajmQw3S7kU48hsz9PO80K972wC8HS15yR4
         04+/bl9WfJoQqzV6GiehczdLtuf4ssPrs9BUKK0YdOwRjgF1Em5ZFRXlL8PWl1g9qqsw
         40/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714759701; x=1715364501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrzBRKrwlaLKjmnKE0p/O+Dhcgp4pyeofgboWhgqrYA=;
        b=KRLZn2HXqv+6o78NsuKl2MykngHTbSWT2ph1pOznukC1N3PtyB/eHM2eW+98MzGgis
         /j32wsqI6IxvNw7d8RiT76ciDq9yeYqTnzPFzBT79mdpytGgzJeFxImU2GY17jmp1sMu
         m8R07D2XxTgNTpziJlDTz3EFkPE7yP+edv1MI+TyCm9YQIHrLTHUGAdhC/Yh2TFD8Mvv
         fcfr1Sw+RVRQcAvBE4tnVZuuNj+jNR2XuHuXUQXmIDEdx7yKOYwsrTncT/w2le2IZlpi
         88WDYeBJCKBmozQs0+VHFnVgTWqhF8xUyxn6vAeomPA513SbAvvALdzsmllqY93aIkXL
         O+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUhX8M6xLDtvJq/f07BUh9sEEPpGF5rADoP20HfwKGTT2AhpY4MzcJji5X4dHxvSBijijhog4D6QaAiE8vQ2GDbMaVGFmi
X-Gm-Message-State: AOJu0YzNAPolpQOZ9/6nYpkiYTkWWrs4sXtEIGH5Usy/oWszTR3j8pZU
	fJxyTzzLYTbsfjX5TLYVpJVhfVuP2jAW55gtsK0mKZdTQJRxiQkH
X-Google-Smtp-Source: AGHT+IHcoSxK+2i1rLgy94/Z9r6s1NxM1alm5uihTJzLFqD564kM0I/I6oloiZDzWOt8OdA7S+hQwQ==
X-Received: by 2002:a05:6512:368d:b0:51e:fa8c:47cc with SMTP id d13-20020a056512368d00b0051efa8c47ccmr2510024lfs.30.1714759701130;
        Fri, 03 May 2024 11:08:21 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m19-20020a0565120a9300b0051f2738ba04sm599804lfu.254.2024.05.03.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:08:20 -0700 (PDT)
Date: Fri, 3 May 2024 21:08:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up
 the platform data initialization
Message-ID: <arxxtmtifgus4qfai5nkemg46l5ql5ptqfodnflqpf2eenfj57@4x4h3vmcuw5x>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <e0ea692698171f9c69b80a70607a55805d249c4a.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ea692698171f9c69b80a70607a55805d249c4a.1714046812.git.siyanteng@loongson.cn>

> [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up the platform data initialization

Please convert the subject to being more specific, like this:

net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init

On Thu, Apr 25, 2024 at 09:04:37PM +0800, Yanteng Si wrote:
> Based on IP core classification, loongson has two types of network

What is the real company name? At least start the name with the
capital letter.
* everywhere 

> devices: GMAC and GNET. GMAC's ip_core id is 0x35/0x37, while GNET's
> ip_core id is 0x37/0x10.

s/ip_core/IP-core

Once again the IP-core ID isn't _hex_, but a number of the format:
"v+Major.Minor"
so use the _real_ IP-core version number everywhere. Note mentioning
that some of your GNET device has the GMAC_VERSION.SNPSVER hardwired
to 0x10 is completely redundant in this and many other context. The
only place where it's relevant is the patch(es) where you have the
Snps ID override.

> 
> Device tables:
> 

> device    type    pci_id    snps_id    channel
> ls2k1000  gmac    7a03      0x35/0x37   1
> ls7a1000  gmac    7a03      0x35/0x37   1
> ls2k2000  gnet    7a13      0x10        8
> ls7a2000  gnet    7a13      0x37        1

s/gmac/GMAC
s/gnet/GNET
s/pci_id/PCI Dev ID
s/snsp_id/Synopys Version
s/channels/DMA-channels
s/ls2k/LS2K
s/ls7a/LS7A

* everywhere

> 
> The GMAC device only has a MAC chip inside and needs an
> external PHY chip;
> 
> To later distinguish 8-channel gnet devices from single-channel
> gnet/gmac devices, move rx_queues_to_use loongson_default_data
> to loongson_dwmac_probe(). Also move mac_interface to
> loongson_default_data().

Again. This is only a part of the reason why you need this change.
The main reason is to provide the two-leveled platform data init
functions: fist one is the common method initializing the data common
for both GMAC and GNET, second one is the device-specific data
initializer.

To sum up I would change the commit log to something like this:

"Loongson delivers two types of the network devices: Loongson GMAC and
Loongson GNET in the framework of four CPU/Chipsets revisions:

   Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
LS2K2000 CPU         GNET      0x7a13          v3.73a            8
LS7A2000 Chipset     GNET      0x7a13          v3.73a            1

The driver currently supports the chips with the Loongson GMAC network
device. As a preparation before adding the Loongson GNET support
detach the Loongson GMAC-specific platform data initializations to the
loongson_gmac_data() method and preserve the common settings in the
loongson_default_data().

While at it drop the return value statement from the
loongson_default_data() method as redundant."

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 4e0838db4259..904e288d0be0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -11,22 +11,20 @@
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>  
> -static int loongson_default_data(struct plat_stmmacenet_data *plat)
> +static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
>  	plat->force_sf_dma_mode = 1;
>  

> +	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
> +

I double-checked this part in my HW and in the databooks. DW GMAC with
_RGMII_ PHY-interfaces can't be equipped with a PCS (STMMAC driver is
wrong in considering otherwise at least in the Auto-negotiation part).
PCS is only available for the RTI, RTBI and SGMII interfaces.

You can double-check that by checking out the DMA_HW_FEATURE.PCSSEL
flag state. I'll be surprised if it's set in your case. If it isn't
then either drop the plat_stmmacenet_data::mac_interface
initialization or (as Russell suggested) initialize it with
PHY_INTERFACE_MODE_NA. But do that in a separate pre-requisite patch!

>  	/* Set default value for unicast filter entries */
>  	plat->unicast_filter_entries = 1;
>  
>  	/* Set the maxmtu to a default of JUMBO_LEN */
>  	plat->maxmtu = JUMBO_LEN;
>  
> -	/* Set default number of RX and TX queues to use */
> -	plat->tx_queues_to_use = 1;
> -	plat->rx_queues_to_use = 1;
> -
>  	/* Disable Priority config by default */
>  	plat->tx_queues_cfg[0].use_prio = false;
>  	plat->rx_queues_cfg[0].use_prio = false;
> @@ -41,6 +39,12 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  	plat->dma_cfg->pblx8 = true;
>  
>  	plat->multicast_filter_bins = 256;
> +}
> +
> +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> +{
> +	loongson_default_data(plat);
> +
>  	return 0;
>  }
>  
> @@ -109,11 +113,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	}
>  
>  	plat->phy_interface = phy_mode;
> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
>  
>  	pci_set_master(pdev);
>  
> -	loongson_default_data(plat);
> +	loongson_gmac_data(plat);
>  	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
> @@ -138,6 +141,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		goto err_disable_msi;
>  	}
>  

> +	plat->tx_queues_to_use = 1;
> +	plat->rx_queues_to_use = 1;
> +

You can freely move this to loongson_gmac_data() method. And then, in
the patch adding the GNET-support, you'll be able to provide these fields
initialization in the loongson_gnet_data() method together with the
plat->tx_queues_cfg[*].coe_unsupported flag init. Thus the probe()
method will get to be smaller and easier to read, and the
loongson_*_data() method will be more coherent.

-Serge(y)

>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_disable_msi;
> -- 
> 2.31.4
> 

