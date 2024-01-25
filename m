Return-Path: <netdev+bounces-65968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D183CB42
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C671C23270
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF841BDD3;
	Thu, 25 Jan 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axmpM1n/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E31BDD6
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207917; cv=none; b=W3Ix+c+7naxgCSz2Ru+ZGxfXDpL8JcpVLCCDiEwABr8CvElgVpl6RxBT8c+mXZdOtUmypus4vBvC7rQBtrLZH2ROgK7nEzbc5+uhxdokZbPnPxwR3PRnXcZC5qmVH9zhKc8r/jdmvpVG5QI2xwFDe07vD57ctdiyIfTqGoUzlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207917; c=relaxed/simple;
	bh=9+0VeliAnObZvWWq5LZklkhahP4Wf8pvMsb61FVE8qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX0X7OEZsNJ84FE8TSMk8DKWEiZw68MqMhqr+rwgL4LtNBMCN7f5ADV1bpc0OQss5hk1GuU9Op0yD0uc7TWibHtq3ZIclk7KdcIwrLpKtTmMLe/XqP/y0Y6Ag/wuN+OVRcxHy+GgqoWWTsqej/XcRvmkNetR7N9bM6YYhgu3j2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axmpM1n/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5100c2f7a16so1098760e87.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706207914; x=1706812714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sb11i3THl9Gt95Z0EANAriupw4JmoIZ2LRwLbPzYqUY=;
        b=axmpM1n/KaGukjRhX7lX226kdl+bi4r4oQOjIAJbq2bxWcFI8nq2SSPd4/97CS0Q3V
         Qo72ETk23znzOSWwNVG45rpH+NradVwtRLx6Y/Sadm/1FI2SJCoZUifpJrhKN1lQV9ji
         h0fHNWkXTilpJArf7FsX0sXn8DV1Yj61LzlPa5olqmm2u7aJa7jlwVipmdP3IoKV9RPV
         pniTLHf/CeU/UCTiZ85V/6HMC/kekxf9yUy7grIdxEUIn5P8KlUz1j282Xx8MNvPhhTX
         oSnIXSKZ6PJcM06fm3ooJyGc5Dzu3Ypd2snGhl1OMPH4fMjGBnKWtVg/2CnMah9Upe82
         iJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207914; x=1706812714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb11i3THl9Gt95Z0EANAriupw4JmoIZ2LRwLbPzYqUY=;
        b=rwIMniBdh6kBwi7WcKrU0natUMxqIGOVW9OLw/vWZfSU2MhUFwOt8hYm/5goAVX2Sg
         iAuuzByvc2lJSUlo6D5QSGp6goNgdYZe0NL30hTvXOLpVW4iZuJMR71vV8Y3pOEHJqmh
         O6qtQk0mF4vIexFnjbcatFlNkiccvp8EthFpYdAFlNIe/oDd1yynw70Phs3MGQ4GvCwH
         XrFFURWUgsM4UUipMuuBExujwJQT31DSKjRijOlgG33fF0pHgtqg2BlMxt6U448aA+H/
         sGSjeB7id9IzVP9r2gigqpEwNW6VsBO2zT/xWgI7iZ9AZtwx+ovUtTP9nxqU42HULKDP
         z/KA==
X-Gm-Message-State: AOJu0Yz/Uy3G8c5XUVj+eLrJ6fNt9xycpOvpfMfs7mX7hMTP+5tunL0W
	GAwDeEERvgYn29jnPsLQHI6OeAR8IpIQ0AJ6+DFC8xMLimLJ77dM
X-Google-Smtp-Source: AGHT+IGQ+l/LIDxFsnUgQpyBNQ4omIE8Xrk/Lf8mjyn6Ay9OKBhWCoAqJSW0bGeDhlfJnjGtdzpeQw==
X-Received: by 2002:a05:6512:3ba7:b0:50e:bc4f:19d3 with SMTP id g39-20020a0565123ba700b0050ebc4f19d3mr160407lfv.25.1706207913365;
        Thu, 25 Jan 2024 10:38:33 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24826000000b005101529beeesm426134lft.7.2024.01.25.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:38:32 -0800 (PST)
Date: Thu, 25 Jan 2024 21:38:30 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 7/9] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <72hx6yfvbxiuvkunzu2tvn6glum5rjrzqaxsswml2fe6j3537w@ahtfn7q64ffe>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
 <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
 <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
 <ce51f055-7564-4921-b45a-c4a255a9d797@loongson.cn>
 <xrdvmc25btov77hfum245rbrncv3vfbfeh4fbscvcvdy4q4qhk@juizwhie4gaj>
 <44229f07-de98-4b47-a125-3301be185de6@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44229f07-de98-4b47-a125-3301be185de6@loongson.cn>

On Thu, Jan 25, 2024 at 04:36:39PM +0800, Yanteng Si wrote:
> 
> 在 2024/1/24 21:51, Serge Semin 写道:
> > On Wed, Jan 24, 2024 at 05:21:03PM +0800, Yanteng Si wrote:
> > > 在 2024/1/1 15:27, Yanteng Si 写道:
> > > > 在 2023/12/21 10:34, Serge Semin 写道:
> > > > > On Tue, Dec 19, 2023 at 10:26:47PM +0800, Yanteng Si wrote:
> > > > > > Add Loongson GNET (GMAC with PHY) support. Current GNET does not
> > > > > > support
> > > > > > half duplex mode, and GNET on LS7A only supports ANE when speed
> > > > > > is set to
> > > > > > 1000M.
> > > > > > 
> > > > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > > > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > > > ---
> > > > > >    .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79
> > > > > > +++++++++++++++++++
> > > > > >    .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++
> > > > > >    include/linux/stmmac.h                        |  2 +
> > > > > >    3 files changed, 87 insertions(+)
> > > > > > 
> > > > > > diff --git
> > > > > > a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > > index 2c08d5495214..9e4953c7e4e0 100644
> > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > > @@ -168,6 +168,83 @@ static struct stmmac_pci_info
> > > > > > loongson_gmac_pci_info = {
> > > > > >        .config = loongson_gmac_config,
> > > > > >    };
> > > > > >    +static void loongson_gnet_fix_speed(void *priv, unsigned int
> > > > > > speed, unsigned int mode)
> > > > > > +{
> > > > > > +    struct net_device *ndev = dev_get_drvdata(priv);
> > > > > > +    struct stmmac_priv *ptr = netdev_priv(ndev);
> > > > > > +
> > > > > > +    /* The controller and PHY don't work well together.
> > > > > > +     * We need to use the PS bit to check if the controller's status
> > > > > > +     * is correct and reset PHY if necessary.
> > > > > > +     */
> > > > > > +    if (speed == SPEED_1000)
> > > > > > +        if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
> > > > > > +            phy_restart_aneg(ndev->phydev);
> > > > > {} around the outer if please.
> > > > OK.
> > > > > > +}
> > > > > > +
> > > > > > +static int loongson_gnet_data(struct pci_dev *pdev,
> > > > > > +                  struct plat_stmmacenet_data *plat)
> > > > > > +{
> > > > > > +    loongson_default_data(pdev, plat);
> > > > > > +
> > > > > > +    plat->multicast_filter_bins = 256;
> > > > > > +
> > > > > > +    plat->mdio_bus_data->phy_mask = 0xfffffffb;
> > > > > ~BIT(2)?
> > > > I still need to confirm, please allow me to get back to you later.
> > > Yes, that's fine.
> 

> Oops! A warning will be output:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c: In function
> 'loongson_gnet_data':
> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:463:41: warning:
> conversion from
> 
> 'long unsigned int' to 'unsigned int' changes value from
> '18446744073709551611' to '4294967291' [-Woverflow]
>   463 |         plat->mdio_bus_data->phy_mask = ~BIT(2);
>       |                                         ^
> 
> Unfortunately, we don't have an unsigned int macro for BIT(nr).

Then the alternative ~(1 << 2) would be still more readable then the
open-coded literal like 0xfffffffb. What would be even better than
that:

#define LOONGSON_GNET_PHY_ADDR		0x2
...
	plat->mdio_bus_data->phy_mask = ~(1 << LOONGSON_GNET_PHY_ADDR);
...

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 
> > 
> > -Serge(y)
> > 
> > > 
> > > Thanks,
> > > 
> > > Yanteng
> > > 
> > > 
> > > > > > +
> > > > > > +    plat->phy_addr = 2;
> > > > > > +    plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
> > > > > > +
> > > > > > +    plat->bsp_priv = &pdev->dev;
> > > > > > +    plat->fix_mac_speed = loongson_gnet_fix_speed;
> > > > > > +
> > > > > > +    plat->dma_cfg->pbl = 32;
> > > > > > +    plat->dma_cfg->pblx8 = true;
> > > > > > +
> > > > > > +    plat->clk_ref_rate = 125000000;
> > > > > > +    plat->clk_ptp_rate = 125000000;
> > > > > > +
> > > > > > +    return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int loongson_gnet_config(struct pci_dev *pdev,
> > > > > > +                struct plat_stmmacenet_data *plat,
> > > > > > +                struct stmmac_resources *res,
> > > > > > +                struct device_node *np)
> > > > > > +{
> > > > > > +    int ret;
> > > > > > +    u32 version = readl(res->addr + GMAC_VERSION);
> > > > > > +
> > > > > > +    switch (version & 0xff) {
> > > > > > +    case DWLGMAC_CORE_1_00:
> > > > > > +        ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
> > > > > > +        break;
> > > > > > +    default:
> > > > > > +        ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > > > Hm, do you have two versions of Loongson GNET? What does the second
> > > > Yes.
> > > > > one contain in the GMAC_VERSION register then? Can't you distinguish
> > > > > them by the PCI IDs (device, subsystem, revision)?
> > > > I'm afraid that's not possible.
> > > > 
> > > > Because they have the same pci id and revision.
> > > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > Yanteng
> > > > 
> > > > > -Serge(y)
> > > > > 
> > > > > > +        break;
> > > > > > +    }
> > > > > > +
> > > > > > +    switch (pdev->revision) {
> > > > > > +    case 0x00:
> > > > > > +        plat->flags |=
> > > > > > +            FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1) |
> > > > > > +            FIELD_PREP(STMMAC_FLAG_DISABLE_FORCE_1000, 1);
> > > > > > +        break;
> > > > > > +    case 0x01:
> > > > > > +        plat->flags |=
> > > > > > +            FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1);
> > > > > > +        break;
> > > > > > +    default:
> > > > > > +        break;
> > > > > > +    }
> > > > > > +
> > > > > > +    return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static struct stmmac_pci_info loongson_gnet_pci_info = {
> > > > > > +    .setup = loongson_gnet_data,
> > > > > > +    .config = loongson_gnet_config,
> > > > > > +};
> > > > > > +
> > > > > >    static int loongson_dwmac_probe(struct pci_dev *pdev,
> > > > > >                    const struct pci_device_id *id)
> > > > > >    {
> > > > > > @@ -318,9 +395,11 @@ static
> > > > > > SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
> > > > > >                 loongson_dwmac_resume);
> > > > > >      #define PCI_DEVICE_ID_LOONGSON_GMAC    0x7a03
> > > > > > +#define PCI_DEVICE_ID_LOONGSON_GNET    0x7a13
> > > > > >      static const struct pci_device_id loongson_dwmac_id_table[] = {
> > > > > >        { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > > > > > +    { PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
> > > > > >        {}
> > > > > >    };
> > > > > >    MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> > > > > > diff --git
> > > > > > a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > > > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > > > > index 8105ce47c6ad..d6939eb9a0d8 100644
> > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > > > > @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct
> > > > > > net_device *dev,
> > > > > >            return 0;
> > > > > >        }
> > > > > >    +    if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000,
> > > > > > priv->plat->flags)) {
> > > > > > +        if (cmd->base.speed == SPEED_1000 &&
> > > > > > +            cmd->base.autoneg != AUTONEG_ENABLE)
> > > > > > +            return -EOPNOTSUPP;
> > > > > > +    }
> > > > > > +
> > > > > >        return phylink_ethtool_ksettings_set(priv->phylink, cmd);
> > > > > >    }
> > > > > >    diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > > > > index f07f79d50b06..067030cdb60f 100644
> > > > > > --- a/include/linux/stmmac.h
> > > > > > +++ b/include/linux/stmmac.h
> > > > > > @@ -222,6 +222,8 @@ struct dwmac4_addrs {
> > > > > >    #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING    BIT(11)
> > > > > >    #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY    BIT(12)
> > > > > >    #define STMMAC_FLAG_HAS_LGMAC            BIT(13)
> > > > > > +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX    BIT(14)
> > > > > > +#define STMMAC_FLAG_DISABLE_FORCE_1000    BIT(15)
> > > > > >      struct plat_stmmacenet_data {
> > > > > >        int bus_id;
> > > > > > -- 
> > > > > > 2.31.4
> > > > > > 
> 

