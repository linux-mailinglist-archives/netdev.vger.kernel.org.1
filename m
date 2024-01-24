Return-Path: <netdev+bounces-65468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A883AB2D
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 14:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F1C1F21143
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1FA77F25;
	Wed, 24 Jan 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awa8UBBg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05F604B2
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104322; cv=none; b=Pd9kTmGmzU2HvJmyctYAf0TazJmG6wI7vsUQjtovFq6sBM3fDWkU8xeDaZ9kFjXzXnlknSt/LdLSJyZqu7ZDf6cQNowl5vt3KnJPASUnfDC1akCINrfs1l4oA3j0SFpoWSWkeh9PSuIjX5AUJYAuTCmKhJbtNcTPJdU+DjhIOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104322; c=relaxed/simple;
	bh=1JwdKaWiUyqJPNf/brUb66k+3hI36YBl4fIKq4tEYUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEBKyvDythqyIpn7IA+fSAUfi87sY/Mht8VZj/AJrgpPHV3k2/e7zBTAbsrq3tcdp5W9GPie1d3Lmg3XwAHZ/u1PmzxjZIbpjc3taQfPkxAHWrTYtOzgNXs98zrxkt7PqxZIYbj9VbKaT/1y74/swy9qdmtMMHSp/tUTA1/sJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awa8UBBg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5101055a16fso825623e87.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 05:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706104318; x=1706709118; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1LvZ70/OEpT9Lm3Q36tfDKXv4WnT+1b6JyPQ9Jq3mOM=;
        b=awa8UBBg77i586GYggLfyA88eZ/AOFYEUsmVPZzC4mGR9+PD7ZTLclxAhrRlSE5/Pj
         iUyeG7/eCjgVGQtNxzY1+Mxu1spSFxqy7puBbVbPbfDQy+fRFqb705IqZC4S41msbwfw
         on/jE/419nW4ZQmqp3mDKVc5oG6aH7nkg5WIMgur+Z+z5uZhKel68SaqDwd3N4PjckjY
         GylYa9It2f2PlzoGZIaBH+adtycie38H98EV1Xei7xisKOIXwKCjJ9rxT/nMujzMCID3
         1RH8cxN0FVCFaUhoagslnXBgoIku7AAA2Ksm3nz+uyWeiU0MmO/cg904bT5pKUHmbz8A
         uYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706104318; x=1706709118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LvZ70/OEpT9Lm3Q36tfDKXv4WnT+1b6JyPQ9Jq3mOM=;
        b=I+JoxRcHRW4xj+nnmYke71BByypmbA4+JSl0yicD/23jfR2sihOh5Cmyoht07U/VNx
         8OEnSSoF3yREksy681W6pyWSp9bhiZn6tUHAuU/L9Q/SN++wFs6v1DvOgo7kw/PBr8gU
         fc0S0N4LDo5EiFJDsEVKKofxle6iyvrOUyoL4QppGDivJYZuL84NPbQnY/l3FChd040R
         ilxdTb5PU6OhUSRHI7FXR3/LSuY9pL3E8ZAAlPbXd+e+GwQY6/y5LaKitFn+Bf57MrUE
         IXBpdMEM1EkcwSfDVozf59N7nmNljyGEoV+Sz1cyS4MuONVrqbQR631SZV2CyRfWGrh5
         H6ww==
X-Gm-Message-State: AOJu0Yx5S3NucsnOE44Sjx06+55waaMqoQA6cqI0CApCy0HuxU+3A07H
	4v2t1mR5q15PsFASDilIPb6OZXF6Q/S7uCt6TBzC3AhnSYKHIHdS
X-Google-Smtp-Source: AGHT+IECi5P+xskknoQVwLEmy6B/ULz7wQod04bgMlYifFrPsuHXmnjgyzCDoSsiEPtjeQ8VdroP9A==
X-Received: by 2002:ac2:4830:0:b0:510:b0b:1563 with SMTP id 16-20020ac24830000000b005100b0b1563mr1171446lft.119.1706104318241;
        Wed, 24 Jan 2024 05:51:58 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q7-20020a19a407000000b0050ffd09913esm847941lfc.162.2024.01.24.05.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 05:51:57 -0800 (PST)
Date: Wed, 24 Jan 2024 16:51:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 7/9] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <xrdvmc25btov77hfum245rbrncv3vfbfeh4fbscvcvdy4q4qhk@juizwhie4gaj>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
 <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
 <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
 <ce51f055-7564-4921-b45a-c4a255a9d797@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce51f055-7564-4921-b45a-c4a255a9d797@loongson.cn>

On Wed, Jan 24, 2024 at 05:21:03PM +0800, Yanteng Si wrote:
> 
> 在 2024/1/1 15:27, Yanteng Si 写道:
> > 
> > 在 2023/12/21 10:34, Serge Semin 写道:
> > > On Tue, Dec 19, 2023 at 10:26:47PM +0800, Yanteng Si wrote:
> > > > Add Loongson GNET (GMAC with PHY) support. Current GNET does not
> > > > support
> > > > half duplex mode, and GNET on LS7A only supports ANE when speed
> > > > is set to
> > > > 1000M.
> > > > 
> > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > ---
> > > >   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79
> > > > +++++++++++++++++++
> > > >   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++
> > > >   include/linux/stmmac.h                        |  2 +
> > > >   3 files changed, 87 insertions(+)
> > > > 
> > > > diff --git
> > > > a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > index 2c08d5495214..9e4953c7e4e0 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > @@ -168,6 +168,83 @@ static struct stmmac_pci_info
> > > > loongson_gmac_pci_info = {
> > > >       .config = loongson_gmac_config,
> > > >   };
> > > >   +static void loongson_gnet_fix_speed(void *priv, unsigned int
> > > > speed, unsigned int mode)
> > > > +{
> > > > +    struct net_device *ndev = dev_get_drvdata(priv);
> > > > +    struct stmmac_priv *ptr = netdev_priv(ndev);
> > > > +
> > > > +    /* The controller and PHY don't work well together.
> > > > +     * We need to use the PS bit to check if the controller's status
> > > > +     * is correct and reset PHY if necessary.
> > > > +     */
> > > > +    if (speed == SPEED_1000)
> > > > +        if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
> > > > +            phy_restart_aneg(ndev->phydev);
> > > {} around the outer if please.
> > OK.
> > > 
> > > > +}
> > > > +
> > > > +static int loongson_gnet_data(struct pci_dev *pdev,
> > > > +                  struct plat_stmmacenet_data *plat)
> > > > +{
> > > > +    loongson_default_data(pdev, plat);
> > > > +
> > > > +    plat->multicast_filter_bins = 256;
> > > > +

> > > > +    plat->mdio_bus_data->phy_mask = 0xfffffffb;
> > > ~BIT(2)?
> > I still need to confirm, please allow me to get back to you later.
> 
> Yes, that's fine.

Glad this part has been settled.)

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 
> 
> > > 
> > > > +
> > > > +    plat->phy_addr = 2;
> > > > +    plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
> > > > +
> > > > +    plat->bsp_priv = &pdev->dev;
> > > > +    plat->fix_mac_speed = loongson_gnet_fix_speed;
> > > > +
> > > > +    plat->dma_cfg->pbl = 32;
> > > > +    plat->dma_cfg->pblx8 = true;
> > > > +
> > > > +    plat->clk_ref_rate = 125000000;
> > > > +    plat->clk_ptp_rate = 125000000;
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > > +static int loongson_gnet_config(struct pci_dev *pdev,
> > > > +                struct plat_stmmacenet_data *plat,
> > > > +                struct stmmac_resources *res,
> > > > +                struct device_node *np)
> > > > +{
> > > > +    int ret;
> > > > +    u32 version = readl(res->addr + GMAC_VERSION);
> > > > +
> > > > +    switch (version & 0xff) {
> > > > +    case DWLGMAC_CORE_1_00:
> > > > +        ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
> > > > +        break;
> > > > +    default:
> > > > +        ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > Hm, do you have two versions of Loongson GNET? What does the second
> > Yes.
> > > one contain in the GMAC_VERSION register then? Can't you distinguish
> > > them by the PCI IDs (device, subsystem, revision)?
> > 
> > I'm afraid that's not possible.
> > 
> > Because they have the same pci id and revision.
> > 
> > 
> > Thanks,
> > 
> > Yanteng
> > 
> > > 
> > > -Serge(y)
> > > 
> > > > +        break;
> > > > +    }
> > > > +
> > > > +    switch (pdev->revision) {
> > > > +    case 0x00:
> > > > +        plat->flags |=
> > > > +            FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1) |
> > > > +            FIELD_PREP(STMMAC_FLAG_DISABLE_FORCE_1000, 1);
> > > > +        break;
> > > > +    case 0x01:
> > > > +        plat->flags |=
> > > > +            FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1);
> > > > +        break;
> > > > +    default:
> > > > +        break;
> > > > +    }
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > > +static struct stmmac_pci_info loongson_gnet_pci_info = {
> > > > +    .setup = loongson_gnet_data,
> > > > +    .config = loongson_gnet_config,
> > > > +};
> > > > +
> > > >   static int loongson_dwmac_probe(struct pci_dev *pdev,
> > > >                   const struct pci_device_id *id)
> > > >   {
> > > > @@ -318,9 +395,11 @@ static
> > > > SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
> > > >                loongson_dwmac_resume);
> > > >     #define PCI_DEVICE_ID_LOONGSON_GMAC    0x7a03
> > > > +#define PCI_DEVICE_ID_LOONGSON_GNET    0x7a13
> > > >     static const struct pci_device_id loongson_dwmac_id_table[] = {
> > > >       { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > > > +    { PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
> > > >       {}
> > > >   };
> > > >   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> > > > diff --git
> > > > a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > > index 8105ce47c6ad..d6939eb9a0d8 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > > @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct
> > > > net_device *dev,
> > > >           return 0;
> > > >       }
> > > >   +    if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000,
> > > > priv->plat->flags)) {
> > > > +        if (cmd->base.speed == SPEED_1000 &&
> > > > +            cmd->base.autoneg != AUTONEG_ENABLE)
> > > > +            return -EOPNOTSUPP;
> > > > +    }
> > > > +
> > > >       return phylink_ethtool_ksettings_set(priv->phylink, cmd);
> > > >   }
> > > >   diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > > index f07f79d50b06..067030cdb60f 100644
> > > > --- a/include/linux/stmmac.h
> > > > +++ b/include/linux/stmmac.h
> > > > @@ -222,6 +222,8 @@ struct dwmac4_addrs {
> > > >   #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING    BIT(11)
> > > >   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY    BIT(12)
> > > >   #define STMMAC_FLAG_HAS_LGMAC            BIT(13)
> > > > +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX    BIT(14)
> > > > +#define STMMAC_FLAG_DISABLE_FORCE_1000    BIT(15)
> > > >     struct plat_stmmacenet_data {
> > > >       int bus_id;
> > > > -- 
> > > > 2.31.4
> > > > 
> 

