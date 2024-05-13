Return-Path: <netdev+bounces-96063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B988C42CD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0722F1F20FC9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FC5153598;
	Mon, 13 May 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbhCkntq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034BB50279
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609105; cv=none; b=EhSU1cEd7jGnDL8wiGAeL9520ec7lm07SXdLo6cm9TT3tYzS5i86W/3/nkd2qadkaQ+EapPdoMsAtC3P/B0pYzZDRvqx5bisMM+yin5w1IDlqhAyyvO0LWBjPX5SgOSVcro1vCNS6VUxllJbNVbktMdbc5ud+78cIhMcty+W3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609105; c=relaxed/simple;
	bh=6YpPefT++BU73VU322yKI7AK3hERbw1pBdjyJMLC4AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5dblmpzFZU1UL8yaSqpXO2oUfz46ptk+gOaOFyvRD1OzNhFDYVZO74lcDa7H+bcA1vSCgnBiyg4AI0nnyMd2+ZF9JQ2r6bSPv4qpRhZSejHv5qjxNMWsI08dJyOzzGCn+tLhDRbb/oCyAYGFFs0HAR/YvHmW2MqSU+chGtwCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbhCkntq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5231efd80f2so1492385e87.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715609101; x=1716213901; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mdh+7E9xNyss9j3mQi3b/hBP5DQkosvR/Ua9IjYgvfo=;
        b=mbhCkntqfVs6AKUOV8DzB9wmCK3Kh7GkE72bNMeOUcEQaOddjRXmKpdD7AlEALg4x3
         wFm0YO9qubOjKch0PwwB0KRn8dfWck871OOe1H7umK/Pq6KhnIydZW/C6MVincQwdGxs
         Rb2hrmEUb8sat38WEdPlPA5MAisshgv1KWxwYZLHLakU1asFQdqZ/zEbq1EJs5kdaWeF
         dEq5yY307MSIQ9wb5xt5D23Ya5eHp8W7zeQSPkeRHGHkG312U9Bl1OYbYAb070rOTYXE
         eH/ueNorsUSRDVSgm/84hr08eZyBWPnDzjHaF+RbrT53e5mqM/xwhh3OYlI15dHDbPXl
         pyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715609101; x=1716213901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdh+7E9xNyss9j3mQi3b/hBP5DQkosvR/Ua9IjYgvfo=;
        b=doeAUq7klqIO8xuCdInG1/blcManjnbf8XzboU+Z9+PfkmS4vUdf4mEfLWeX9KDu0L
         n2N1RtuzIlF0pbA7IAX0ytG8TCGtJ/5vhAEgGT6YqqKjyxw/WpEwslA6m3heewyRbeEr
         GSdfS5yAyoR7fk3Ru8nWJiDsBe9ELSGCIOu5GR/edL0kMeOaoswikl2j44N2pghpX5FA
         aYHZk60vbVBrW6Kr+n6ljYQy5/TFX9JtvvGimD2k7jc5mtUWZnGK0LTMDSPJFNpNvPp/
         lP8rQhqUVGLdKyENT8lRHz+z2g5TnjfM5JKrLNO1wIK20TvkCCMgvgZLZ54ZmOpOJaHo
         GiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU0wbSF5N6rXa5PGNCPV09ouDOeG432sgElKpOsQgTtt2AEshzSKlz072jEdFa1/74D1kx7YGSBuV4ZWK/ztmEQbghxKdZ
X-Gm-Message-State: AOJu0Yx7ln0Dox6sHDaJjUOFWuNVWGX1ostc8FBjee1P9IAK1Qu5yWw3
	vHpvJCIUpLDngtKpppr0e43kAzC16umPGxZiUN9UdE1ZXJCXZsK5Po19gw==
X-Google-Smtp-Source: AGHT+IEnSF6rpaYgKb6fWKRG2RwSDg7ky+nvzXoxxGxCBi84gjU1kEA/yhGJgcKZhUzgPpVxH3E63w==
X-Received: by 2002:a05:6512:3103:b0:51a:c3f2:69a8 with SMTP id 2adb3069b0e04-522100749d1mr5693907e87.53.1715609100656;
        Mon, 13 May 2024 07:05:00 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2c38sm1774032e87.256.2024.05.13.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:04:59 -0700 (PDT)
Date: Mon, 13 May 2024 17:04:56 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>, chenhuacai@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org, 
	chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up
 the platform data initialization
Message-ID: <uy3pqd5zqpcdpny4jfdy2a4uwsrp22u755w5ukm3etqhyljr6i@ayup5ikrlx7g>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <e0ea692698171f9c69b80a70607a55805d249c4a.1714046812.git.siyanteng@loongson.cn>
 <arxxtmtifgus4qfai5nkemg46l5ql5ptqfodnflqpf2eenfj57@4x4h3vmcuw5x>
 <29f046d6-67a8-4566-be6a-e2ee73037a94@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29f046d6-67a8-4566-be6a-e2ee73037a94@loongson.cn>

On Mon, May 13, 2024 at 07:07:38PM +0800, Yanteng Si wrote:
> 
> 在 2024/5/4 02:08, Serge Semin 写道:
> > > [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up the platform data initialization
> > Please convert the subject to being more specific, like this:
> > 
> > net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
> > 
> > On Thu, Apr 25, 2024 at 09:04:37PM +0800, Yanteng Si wrote:
> > > Based on IP core classification, loongson has two types of network
> > What is the real company name? At least start the name with the
> > capital letter.
> > * everywhere
> OK,  LOONGSON
> > 
> > > devices: GMAC and GNET. GMAC's ip_core id is 0x35/0x37, while GNET's
> > > ip_core id is 0x37/0x10.
> > s/ip_core/IP-core
> > 
> > Once again the IP-core ID isn't _hex_, but a number of the format:
> > "v+Major.Minor"
> > so use the _real_ IP-core version number everywhere. Note mentioning
> > that some of your GNET device has the GMAC_VERSION.SNPSVER hardwired
> > to 0x10 is completely redundant in this and many other context. The
> > only place where it's relevant is the patch(es) where you have the
> > Snps ID override.
> OK.
> > 
> > > Device tables:
> > > 
> > > device    type    pci_id    snps_id    channel
> > > ls2k1000  gmac    7a03      0x35/0x37   1
> > > ls7a1000  gmac    7a03      0x35/0x37   1
> > > ls2k2000  gnet    7a13      0x10        8
> > > ls7a2000  gnet    7a13      0x37        1
> > s/gmac/GMAC
> > s/gnet/GNET
> > s/pci_id/PCI Dev ID
> > s/snsp_id/Synopys Version
> > s/channels/DMA-channels
> > s/ls2k/LS2K
> > s/ls7a/LS7A
> > 
> > * everywhere
> OK.
> > 
> > > The GMAC device only has a MAC chip inside and needs an
> > > external PHY chip;
> > > 
> > > To later distinguish 8-channel gnet devices from single-channel
> > > gnet/gmac devices, move rx_queues_to_use loongson_default_data
> > > to loongson_dwmac_probe(). Also move mac_interface to
> > > loongson_default_data().
> > Again. This is only a part of the reason why you need this change.
> > The main reason is to provide the two-leveled platform data init
> > functions: fist one is the common method initializing the data common
> > for both GMAC and GNET, second one is the device-specific data
> > initializer.
> > 
> > To sum up I would change the commit log to something like this:
> > 
> > "Loongson delivers two types of the network devices: Loongson GMAC and
> > Loongson GNET in the framework of four CPU/Chipsets revisions:
> > 
> >     Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> > LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> > LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> > LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> > LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> > 
> > The driver currently supports the chips with the Loongson GMAC network
> > device. As a preparation before adding the Loongson GNET support
> > detach the Loongson GMAC-specific platform data initializations to the
> > loongson_gmac_data() method and preserve the common settings in the
> > loongson_default_data().
> > 
> > While at it drop the return value statement from the
> > loongson_default_data() method as redundant."
> OK, Thanks!
> > 
> > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > ---
> > >   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 20 ++++++++++++-------
> > >   1 file changed, 13 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > index 4e0838db4259..904e288d0be0 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > @@ -11,22 +11,20 @@
> > >   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> > > -static int loongson_default_data(struct plat_stmmacenet_data *plat)
> > > +static void loongson_default_data(struct plat_stmmacenet_data *plat)
> > >   {
> > >   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
> > >   	plat->has_gmac = 1;
> > >   	plat->force_sf_dma_mode = 1;
> > > +	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
> > > +
> > I double-checked this part in my HW and in the databooks. DW GMAC with
> > _RGMII_ PHY-interfaces can't be equipped with a PCS (STMMAC driver is
> > wrong in considering otherwise at least in the Auto-negotiation part).
> > PCS is only available for the RTI, RTBI and SGMII interfaces.
> > 
> > You can double-check that by checking out the DMA_HW_FEATURE.PCSSEL
> > flag state. I'll be surprised if it's set in your case. If it isn't
> > then either drop the plat_stmmacenet_data::mac_interface
> > initialization or (as Russell suggested) initialize it with
> > PHY_INTERFACE_MODE_NA. But do that in a separate pre-requisite patch!
> OK.
> > 
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
> > > @@ -41,6 +39,12 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
> > >   	plat->dma_cfg->pblx8 = true;
> > >   	plat->multicast_filter_bins = 256;
> > > +}
> > > +
> > > +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> > > +{
> > > +	loongson_default_data(plat);
> > > +
> > >   	return 0;
> > >   }
> > > @@ -109,11 +113,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > >   	}
> > >   	plat->phy_interface = phy_mode;
> > > -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
> > >   	pci_set_master(pdev);
> > > -	loongson_default_data(plat);
> > > +	loongson_gmac_data(plat);
> > >   	pci_enable_msi(pdev);
> > >   	memset(&res, 0, sizeof(res));
> > >   	res.addr = pcim_iomap_table(pdev)[0];
> > > @@ -138,6 +141,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
> > >   		goto err_disable_msi;
> > >   	}
> > > +	plat->tx_queues_to_use = 1;
> > > +	plat->rx_queues_to_use = 1;
> > > +
> > You can freely move this to loongson_gmac_data() method. And then, in
> > the patch adding the GNET-support, you'll be able to provide these fields
> > initialization in the loongson_gnet_data() method together with the
> > plat->tx_queues_cfg[*].coe_unsupported flag init. Thus the probe()
> > method will get to be smaller and easier to read, and the
> > loongson_*_data() method will be more coherent.
> 
> As you said, at first glance, putting them in loongson_gnet_data() method is
> fine,
> 
> but in LS2K2000:
> 
>         plat->rx_queues_to_use = CHANNEL_NUM;    // CHANNEL_NUM = 8;
>         plat->tx_queues_to_use = CHANNEL_NUM;
> 
> So we need to distinguish between them. At the same time, we have to
> distinguish
> 
> between LS2K2000 in probe() method. Why not put them inside probe, which
> will
> 
> save a lot of duplicate code, like this:
> 
>     struct stmmac_resources res;
>     struct loongson_data *ld;
> 
> ...
> 
>     memset(&res, 0, sizeof(res));
>     res.addr = pcim_iomap_table(pdev)[0];
>     ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
> 
>     switch (ld->gmac_verion) {
>     case LOONGSON_DWMAC_CORE_1_00:
>         plat->rx_queues_to_use = CHANNEL_NUM;
>         plat->tx_queues_to_use = CHANNEL_NUM;
> 
>         /* Only channel 0 supports checksum,
>          * so turn off checksum to enable multiple channels.
>          */
>         for (i = 1; i < CHANNEL_NUM; i++)
>             plat->tx_queues_cfg[i].coe_unsupported = 1;
> 
>         ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
>         break;
>     default:    /* 0x35 device and 0x37 device. */
>         plat->tx_queues_to_use = 1;
>         plat->rx_queues_to_use = 1;
> 
>         ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>         break;
>     }
>     if (ret)
>         goto err_disable_device;
> 
> 
> What do you think?
> 
> 
> Of course, if you insist, I'm willing to repeat this in the
> 
> loongson_gnet_data() method.

Not necessarily. As Huacai earlier suggested you can keep the Loongson
ID in the platform private data and have it utilized in the local
sub-functions/routines. Like this:

struct loongson_data {
	u32 loongson_id;
};

static int loongson_gmac_data(struct pci_dev *pdev,
			      struct plat_stmmacenet_data *plat)
{
	struct loongson_data *ld = plat->bsp_priv;

	...

	plat->rx_queues_to_use = 1;
	plat->tx_queues_to_use = 1;

	return 0;
}

static int loongson_gnet_data(struct pci_dev *pdev,
			      struct plat_stmmacenet_data *plat)
{
	struct loongson_data *ld = plat->bsp_priv;

	...

	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
		plat->rx_queues_to_use = 8;
		plat->tx_queues_to_use = 8;

		/* Tx COE is supported by the channel 0 only */
		for (i = 1; i < 8; i++)
			plat->tx_queues_cfg[i].coe_unsupported = 1;
	} else {
		plat->rx_queues_to_use = 1;
		plat->tx_queues_to_use = 1;
	}

	return 0;
}

static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
{
	struct loongson_data *ld;
	...

	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
	if (!ld)
		return -ENOMEM;
	...
	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
	plat->bsp_priv = ld;
	...
	if (ld->loongson_id == DWMAC_CORE_LS2K2000)
		ret = loongson_dwmac_config_msi(pdev, plat, &res);
	else
		ret = loongson_dwmac_config_plat(pdev, plat, &res);

	if (ret)
		return ret;
	...
}

It's not "a lot" duplication code. Just two if-else statements, which
is fine. But the data-init methods will get to be fully coherent. It's
much more important.

* Note switch-case is redundant since you have a single case in there,
so if-else would be more than enough.

-Serge(y)

> 
> 
> 
> Thanks,
> 
> Yanteng
> 

