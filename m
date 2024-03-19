Return-Path: <netdev+bounces-80625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40E880032
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC0283159
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FBB657A7;
	Tue, 19 Mar 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvuJUwcs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C2651AF
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860605; cv=none; b=e9hCuo2jomSRxJXs4k7b9j+GITTFooD+57aqpI6EjPuHhltxWXKWIR62SMhX2AKPJZ8CKANWeIt6Pp/6MJlCOn+I8RJfFwkD7DfXQxK2SRoqF7AsmRQQAeLqnS3ZUoa5bv1cdYEcNcohB1MiBm+hbPEaG74Vzw6S4yd8Lb7qwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860605; c=relaxed/simple;
	bh=XBOyyFD0waHOnE9MvYLW/Rtuvn3b0+DQAmryQEfNsQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHWUM6R/3XN5JYk5ZhcHbKd6UJaaFrO6/3ReiO/D3wUmAO42a5e1wXeAu+kYgBGttj8PZ6Ybtl7YDEsLfenzw8R960CoCt+rC2zxzAOX3zsH2B+Alxu0mhbtYjsQrraBZ5yCPSFN9SPJKMeabgxsJz/qB0T5jrgiYbBTGnOgwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvuJUwcs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512f892500cso6306962e87.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710860601; x=1711465401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HEtR1acEM0RSmUjC2yZzc1k5568OryBNcjVwrPXZP6E=;
        b=NvuJUwcspgbseG6jqd8kfz/AWtqylBAaCWwkBOIvy2rh5UIgcJpb+m9Vs7bDd2uX02
         frDA6Sur6OjsF2H4J/zrqQ3fxPHbVhBkVbthvwGzI4VaoQZN3SKPl2PrdgATEhrCesvk
         kdoxkEhWbqKwmX8XPX4ZNUFP4In+8Qt4wxQbr3EddCcrjOgwK0VH+4/NRrwAJUGd+5IJ
         eIRAyCG4ziP92wRqsdphDHtc0gMi+80pn9Yl0YMWX73H5fonwJOFCt9rjRD3DJhA7gmk
         hKCEqLGfWDDZwjCK4JqkEmfO8ud/4nwXoIzLQS4xacvBu6sv3pObC0IBd2zRnunCo7tQ
         ZZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710860601; x=1711465401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEtR1acEM0RSmUjC2yZzc1k5568OryBNcjVwrPXZP6E=;
        b=OJS/fopYMjVIwncHswk5ZuuVcuNT6yOX22hH+nzYqtK2gsbicU0d5UIXdN2a9GLncd
         HX2JdBBgYeN5MH0HujLofj5EPOB+1eaCx3o7Nly1YP5foQ/u0PacVazsWsQjXK9E84ys
         PrqTXfnFip9gebO9ucsk3mCnMfWJR7hwVcrviju6EU+ZrdKRhD0FcD1YjGjkXM+Wpfax
         Ldc9ulqH+PD3sKXfRCv6W0YCEjM+Ly5oQYhra6xMnDB4RG92iT7IrOvVS29CBKV89cIF
         0P8L56dmnuawwRo85ZVDDMlvKI13ZPsrKxUh/topp1xih3pWrq/u/ZG2s3+bMHeDO7he
         tRHw==
X-Forwarded-Encrypted: i=1; AJvYcCXihLzX4yUrmyJb65SuTrOvDbhVGAWUYTEVQm4aKqq69wkoodQRcuje+DkngIBOYtvnjTzUIRb4qHaj20V2MVPehxAc5mjk
X-Gm-Message-State: AOJu0YyBixz9tuvD/rQ6cVk+rvVZqnotH5oMBUqO9V7OXE3Bx5eYRdR/
	00o/9AslWVal3tKYygyORblbSSPvM2ZU6Yo99J/PcEATOmWgSg31
X-Google-Smtp-Source: AGHT+IG1gdW/LfPERXZXcdA6jxsfkWXPR8JG4STmOvylbJwjIF4fsqP/3/AUWSiltUu6VttBYBNbdw==
X-Received: by 2002:a19:8c17:0:b0:512:e02f:9fa7 with SMTP id o23-20020a198c17000000b00512e02f9fa7mr8031170lfd.1.1710860600895;
        Tue, 19 Mar 2024 08:03:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id p20-20020a056512313400b0051315216363sm1967531lfd.238.2024.03.19.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 08:03:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 18:03:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <x6wwfvuzqpzfzstb3l5adp354z2buevo35advv7q347gnmo3zn@vfzwca5fafd3>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <027b4ee29d4d7c8a22d2f5c551f5c21ced3fb046.1706601050.git.siyanteng@loongson.cn>
 <ftqxjh67a7s4iprpiuw5xxmncj3bveezf5vust7cej3kowwcvj@m7nqrxq7oe2f>
 <d0e56c9b-9549-4061-8e44-2504b6b96897@loongson.cn>
 <466f138d-0baa-4a86-88af-c690105e650e@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <466f138d-0baa-4a86-88af-c690105e650e@loongson.cn>

On Thu, Mar 14, 2024 at 09:12:49PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/14 16:27, Yanteng Si 写道:
> > 在 2024/2/6 04:58, Serge Semin 写道:
> > > On Tue, Jan 30, 2024 at 04:48:18PM +0800, Yanteng Si wrote:
> > >> Add Loongson GNET (GMAC with PHY) support, override
> > >> stmmac_priv.synopsys_id with 0x37.
> > > Please add more details of all the device capabilities: supported
> > > speeds, duplexness, IP-core version, DMA-descriptors type
> > > (normal/enhanced), MTL Tx/Rx FIFO size, Perfect and Hash-based MAC
> > > Filter tables size, L3/L4 filters availability, VLAN hash table
> > > filter, PHY-interface (GMII, RGMII, etc), EEE support,
> > > AV-feature/Multi-channels support, IEEE 1588 Timestamp support, Magic
> > > Frame support, Remote Wake-up support, IP Checksum, Tx/Rx TCP/IP
> > > Checksum, Mac Management Counters (MMC), SMA/MDIO interface,

> > The gnet (2k2000) of 0x10 supports full-duplex and half-duplex at 1000/100/10M.
> > The gnet of 0x37 (i.e. the gnet of 7a2000) supports 1000/100/10M full duplex.
> > 
> > The gnet with 0x10 has 8 DMA channels, except for channel 0, which does not
> > support sending hardware checksums.
> > 
> > Supported AV features are Qav, Qat, and Qas, and other features should be
> > consistent with the 3.73 IP.

Just list all of these features in the commit message referring to the
respective controller. Like this:
"There are two types of them Loongson GNET controllers:
Loongson 2k2000 GNET and the rest of the Loongson GNETs (like
presented on the 7a2000 SoC). All of them of the DW GMAC 3.73a
IP-core with the next features:
Speeds, DMA-descriptors type (normal/enhanced), MTL Tx/Rx FIFO size,
Perfect and Hash-based MAC Filter tables size, L3/L4 filters availability,
VLAN hash table filter, PHY-interface (GMII, RGMII, etc), EEE support,
IEEE 1588 Timestamp support, Magic Frame support, Remote Wake-up support,
IP Checksum, Tx/Rx TCP/IP Checksum, Mac Management Counters (MMC),
SMA/MDIO interface. 

The difference is that the Loongson 2k2000 GNET controller supports 8
DMA-channels, AV features (Qav, Qat, and Qas) and half-duplex link,
meanwhile the rest of the GNETs don't have these capabilities
available."

> > 
> > >
> > >> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
> > >> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
> > >> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
> > >> ---
> > >>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 44 +++++++++++++++++++
> > >>   1 file changed, 44 insertions(+)
> > >>
> > >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> index 3b3578318cc1..584f7322bd3e 100644
> > >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> @@ -318,6 +318,8 @@ static struct mac_device_info *loongson_setup(void *apriv)
> > >>   	if (!mac)
> > >>   		return NULL;
> > >>   >> +	priv->synopsys_id = 0x37;	/*Overwrite custom IP*/
> > >> +
> > > Please add a more descriptive comment _above_ the subjected line. In
> > > particular note why the override is needed, what is the real DW GMAC
> > > IP-core version and what is the original value the statement above
> > > overrides.
> > 

> > The IP-core version of the gnet device on the loongson 2k2000 is 0x10, which is
> > a custom IP.
> > 
> > Compared to 0x37, we have split some of the dma registers into two (tx and rx).
> > After overwriting stmmac_dma_ops.dma_interrupt() and stmmac_dma_ops.init_chan(),
> > the logic is consistent with 0x37,
> > 
> > so we overwrite synopsys_id to 0x37.

Yeah, something like that:
	/* The original IP-core version is 0x37 in all Loongson GNET
	 * (2k2000 and 7a2000), but the GNET HW designers have changed the
	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loongson
	 * 2k2000 MAC to emphasize the differences: multiple DMA-channels, AV
	 * feature and GMAC_INT_STATUS CSR flags layout. Get back the
	 * original value so the correct HW-interface would be
	 * selected.
	 */

> > 
> > >>   	ld = priv->plat->bsp_priv;
> > >>   	mac->dma = &ld->dwlgmac_dma_ops;
> > >>   >> @@ -350,6 +352,46 @@ static struct mac_device_info
> > *loongson_setup(void *apriv)
> > >>   	return mac;
> > >>   }
> > >>   >> +static int loongson_gnet_data(struct pci_dev *pdev,
> > >> +			      struct plat_stmmacenet_data *plat)
> > >> +{
> > >> +	loongson_default_data(pdev, plat);
> > >> +
> > >> +	plat->multicast_filter_bins = 256;
> > >> +
> > >> +	plat->mdio_bus_data->phy_mask =  ~(u32)BIT(2);
> > >> +
> > >> +	plat->phy_addr = 2;
> > >> +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
> > > Are you sure PHY-interface is supposed to be defined as "internal"?
> > 

> > Yes, because the gnet hardware has a integrated PHY, so we set it to internal，
> > 

Why do you need the phy_addr set to 2 then? Is PHY still discoverable
on the subordinate MDIO-bus?

kdoc in "include/linux/phy.h" defines the PHY_INTERFACE_MODE_INTERNAL
mode as for a case of the MAC and PHY being combined. IIUC it's
reserved for a case when you can't determine actual interface between
the MAC and PHY. Is it your case? Are you sure the interface between
MAC and PHY isn't something like GMII/RGMII/etc?

-Serge(y)

> > Correspondingly, our gmac hardware PHY is external.
> > 
> > >> +
> > >> +	plat->bsp_priv = &pdev->dev;
> > >> +
> > >> +	plat->dma_cfg->pbl = 32;
> > >> +	plat->dma_cfg->pblx8 = true;
> > >> +
> > >> +	plat->clk_ref_rate = 125000000;
> > >> +	plat->clk_ptp_rate = 125000000;
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static int loongson_gnet_config(struct pci_dev *pdev,
> > >> +				struct plat_stmmacenet_data *plat,
> > >> +				struct stmmac_resources *res,
> > >> +				struct device_node *np)
> > >> +{
> > >> +	int ret;
> > >> +
> > >> +	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > Again. This will be moved to the probe() method in one of the next
> > > patches leaving loongson_gnet_config() empty. What was the problem
> > > with doing that right away with no intermediate change?
> > 
> > No problem. My original intention is to break the patches down into smaller pieces.
> > 
> > In the next version, I will try to re-break them based on your comments.
> > 
> > >
> > >> +
> > >> +	return ret;
> > >> +}
> > >> +
> > >> +static struct stmmac_pci_info loongson_gnet_pci_info = {
> > >> +	.setup = loongson_gnet_data,
> > >> +	.config = loongson_gnet_config,
> > >> +};
> > >> +
> > >>   static int loongson_dwmac_probe(struct pci_dev *pdev,
> > >>   				const struct pci_device_id *id)
> > >>   {
> > >> @@ -516,9 +558,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
> > >>   			 loongson_dwmac_resume);
> > >>   >>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> > >> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
> > >>   >>   static const struct pci_device_id loongson_dwmac_id_table[] =
> > {
> > >>   	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > >> +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
> > > After this the driver is supposed to correctly handle the Loongson
> > > GNET devices. Based on the patches introduced further it isn't.
> > > Please consider re-arranging the changes (see my comments in the
> > > further patches).
> > 
> > OK.
> > 
> > 
> > Thanks,
> > 
> > Yanteng
> > 
> > 
> > >
> > > -Serge(y)
> > >
> > >>   	{}
> > >>   };
> > >>   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> > >> -- >> 2.31.4
> > >>
> 

