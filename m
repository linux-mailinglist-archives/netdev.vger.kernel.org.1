Return-Path: <netdev+bounces-80654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CA18802F2
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D48C28242D
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6061119F;
	Tue, 19 Mar 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TilyYzXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15817BA4
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867768; cv=none; b=b73e1kb5Xv85SoCKv23bD1ms7uX7+m3nF9ZpPGyeBWbNT9XdeFdQ5HVX3n2XaxDdC39PP67m4xZSfKExHSuBq8UZHEhfcU+c6phYrbiLcSvjpobcGu4zQhGCpyZHwoP4a6PKEx4j1ElHygLQ5l0G8/9Wlcmu4GNPHF+Qxnz2KyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867768; c=relaxed/simple;
	bh=zsKcOvsS2b1+fDsPHO+aRIgd9FsLUi1Q484TpAtuE/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTMIZJWILALmwFzAAeKWeTOsCamhyJeWPhnZk1Oxx8isE8JZcWoJ4s/7N7CVSbi1s4a6clk+BQxnr8qCUmSDcvE8z+lHL4WlRL11T1YpuNvrDmkyGg6fBLRDJwDcQkLgwFTcg+JBLy2LWD+J3sWNOdJa+LZT+KTSFg+EKi8rw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TilyYzXL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513a08f2263so6001147e87.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710867764; x=1711472564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b8Lkh7vqPREWoOCsEaQ/jKHtViUjvYrtzzcGbPvG5U4=;
        b=TilyYzXLt3He87yvGcEKEWm4yM9ZH2Cm5pMZcw6DVvSFXZTW1wVvt/qkEwpprRHMdJ
         SgcioRWN1m9pEt/3CwVh4cSpWsMv2g6iPa71Si1/XaLTotAvVSE70PhFpif7fLDruy/V
         MIeAsgcDPTK/wVFQFnZ5ZIwlSlO25Qgenq1jdq20M6G50pSsx6NtPsYhFO1ciuvlhQBB
         dD5ll8l6QuUHYXmpkF3ZKSvI6LUSfRfCRWAZy2bz5mWi6fk8S01WhJwlmKqVKrHfcU6d
         hn2MNms+0qdtB3XH/3uIIuzVBA4wmNjAtQw7NhtLtPfdeXab11KJq87HUFlSmpsbCNn3
         aqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867764; x=1711472564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8Lkh7vqPREWoOCsEaQ/jKHtViUjvYrtzzcGbPvG5U4=;
        b=vW+g7+k4Ax4q7X5wY0xUqpCAt0+9jnkSJo9erQu4dib9jYcjNCRXUueGSUPsyvX7Ly
         GiRZZOBjQtsnvMKWvZmrPY1kokxL73YFU8bqcq14tR4AU/Hsr0566HXCWNsOWl9oeqX7
         gBKc9Vy7632dkFQhmtqKAHsruXrAOliIEFBVfW7i4oEuXbuhabzaR381kWaTfHYlDDZv
         dfepz17aTP/Z7X4JlS6W/zZ1AY6tSnNEKf+KoUG1+k4g1uCBpiouNahH5ASbXs/O5Qvb
         uR4UUlfYJQON7Ta/u+T09UYZrjE3rd3c2+kUiNPDZ2Hae/Ni667W0krQAmwKUHbhxm6d
         H5sw==
X-Forwarded-Encrypted: i=1; AJvYcCXtVjtdAA09bE+Lz/RyP908XuugkSUtREYU5U9CflWxCWmUOySRCjTsxIijmQaBaJTfPOHP1DxbJ0enVMh+Om+ght5wzAe/
X-Gm-Message-State: AOJu0YzS7ox0cMjmw57W9BQ5JMO7898y95XO+Lz7K2NN1THzMqfmY/EU
	2ycEy3oFAIooGXq66teK82AZSmESawNwoRu0F++c9pUxKoRAKFbm
X-Google-Smtp-Source: AGHT+IEBDRirn44dKqhkRDV2sY4g0aj2QY1gp1ERCnIJb3MIycYVWvcz0T/xVOfuQDz29hykIqy/hg==
X-Received: by 2002:ac2:592c:0:b0:513:cf5e:f2ad with SMTP id v12-20020ac2592c000000b00513cf5ef2admr2443338lfi.60.1710867763788;
        Tue, 19 Mar 2024 10:02:43 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a4-20020a19ca04000000b00513d3cb2d15sm1878182lfg.68.2024.03.19.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:02:41 -0700 (PDT)
Date: Tue, 19 Mar 2024 20:02:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Message-ID: <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>

On Thu, Mar 14, 2024 at 09:18:15PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/14 17:43, Yanteng Si 写道:
> > 在 2024/2/6 05:55, Serge Semin 写道:
> > > On Tue, Jan 30, 2024 at 04:48:20PM +0800, Yanteng Si wrote:
> > >> Current GNET on LS7A only supports ANE when speed is
> > >> set to 1000M.
> > > If so you need to merge it into the patch
> > > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> 
> > > Current GNET on LS7A only supports ANE when speed is
> > > set to 1000M.
> 
> > If so you need to merge it into the patch
> > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> 
> OK.
> 
> > >
> > >> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
> > >> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
> > >> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
> > >> ---
> > >>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 +++++++++++++++++++
> > >>   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++++++
> > >>   include/linux/stmmac.h                        |  1 +
> > >>   3 files changed, 26 insertions(+)
> > >>
> > >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> index 60d0a122d7c9..264c4c198d5a 100644
> > >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> @@ -344,6 +344,21 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
> > >>   	.config = loongson_gmac_config,
> > >>   };
> > >>   >> +static void loongson_gnet_fix_speed(void *priv, unsigned int
> > speed, unsigned int mode)
> > >> +{
> > >> +	struct loongson_data *ld = (struct loongson_data *)priv;
> > >> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
> > >> +	struct stmmac_priv *ptr = netdev_priv(ndev);
> > >> +
> > >> +	/* The controller and PHY don't work well together.
> > > So there _is_ a PHY. What is the interface between MAC and PHY then?
> > >
> > > GMAC only has a MAC chip inside the chip and needs an external PHY
> > chip; GNET > has the PHY chip inside the chip.

We are talking about GNETs in this method since it has the
loongson_gnet_ prefix. You are referring to GMAC. I am getting
confused about all of these. Based on the patch 06/11 of this series
you call "Loongson GNET" of all the devices placed on the PCI devices
with PCI ID 0x7a13. PCIe device with ID 0x7a03 is called "Loongson
GMAC". Right?

Anyway no matter whether the PHY is placed externally or inside the
chip. AFAIU as long as you know the interface type between MAC and PHY
it would be better to have it specified.

> > >> +	 * We need to use the PS bit to check if the controller's status
> > >> +	 * is correct and reset PHY if necessary.
> > >> +	 */
> > >> +	if (speed == SPEED_1000)
> > >> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
> > >> +			phy_restart_aneg(ndev->phydev);
> > > 1. Please add curly braces for the outer if-statement.
> > OK,
> > > 2. MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
> > 
> > OK.
> > 
> > if(speed==SPEED_1000){
> > /*MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.*/
> > if(readl(ptr->ioaddr+MAC_CTRL_REG) &(1<<15))
> > phy_restart_aneg(ndev->phydev);
> > }
> > 
> > > 3. How is the AN-restart helps? PHY-reset is done in
> > > stmmac_init_phy()->phylink_connect_phy()->... a bit earlier than
> > > this is called in the framework of the stmmac_mac_link_up() callback.
> > > Wouldn't that restart AN too?
> > 

> > Due to a bug in the chip's internal PHY, the network is still not working after
> > the first self-negotiation, and it needs to be self-negotiated again.

Then please describe the bug in more details then.

Getting back to the code you implemented here. In the in-situ comment
you say: "We need to use the PS bit to check if the controller's
status is correct and reset PHY if necessary." By calling
phy_restart_aneg() you don't reset the PHY.

Moreover if "PS" flag is set, then the MAC has been pre-configured to
work in the 10/100Mbps mode. Since 1000Mbps speed is requested, the
MAC_CTRL_REG.PS flag will be cleared later in the
stmmac_mac_link_up() method and then phylink_start() shall cause the
link speed re-auto-negotiation. Why do you need the auto-negotiation
started for the default MAC config which will be changed just in a
moment later? All of that seems weird.

Most importantly I have doubts the networking subsystem maintainers
will permit you calling the phy_restart_aneg() method from the MAC
driver code.

> > 
> > >
> > >> +}
> > >> +
> > >>   static struct mac_device_info *loongson_setup(void *apriv)
> > >>   {
> > >>   	struct stmmac_priv *priv = apriv;
> > >> @@ -401,6 +416,7 @@ static int loongson_gnet_data(struct pci_dev *pdev,
> > >>   	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
> > >>   >>   	plat->bsp_priv = &pdev->dev;
> > >> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
> > >>   >>   	plat->dma_cfg->pbl = 32;
> > >>   	plat->dma_cfg->pblx8 = true;
> > >> @@ -416,6 +432,9 @@ static int loongson_gnet_config(struct pci_dev *pdev,
> > >>   				struct stmmac_resources *res,
> > >>   				struct device_node *np)
> > >>   {
> > >> +	if (pdev->revision == 0x00 || pdev->revision == 0x01)
> > >> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> > >> +
> > > This should be in the patch
> > > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> > OK.
> > >
> > >>   	return 0;
> > >>   }
> > >>   >> diff --git
> > a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > >> index 42d27b97dd1d..31068fbc23c9 100644
> > >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > >> @@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
> > >>   		return 0;
> > >>   	}
> > >>   >> +	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000,
> > priv->plat->flags)) {
> > > FIELD_GET()?
> > 
> > OK,
> > 

> > if (STMMAC_FLAG_DISABLE_FORCE_1000 & priv->plat->flags) {

it's better to change the order of the operands:
	if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {

-Serge(y)

> > 
> > >
> > >> +		if (cmd->base.speed == SPEED_1000 &&
> > >> +		    cmd->base.autoneg != AUTONEG_ENABLE)
> > >> +			return -EOPNOTSUPP;
> > >> +	}
> > >> +
> > >>   	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
> > >>   }
> > >>   >> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > >> index dee5ad6e48c5..2810361e4048 100644
> > >> --- a/include/linux/stmmac.h
> > >> +++ b/include/linux/stmmac.h
> > >> @@ -221,6 +221,7 @@ struct dwmac4_addrs {
> > >>   #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
> > >>   #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
> > >>   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
> > >> +#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
> > > Detach the change introducing the STMMAC_FLAG_DISABLE_FORCE_1000 flag
> > > into a separate patch a place it before
> > > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> > > as a pre-requisite/preparation patch.
> > > Don't forget a _detailed_ description of why it's necessary, what is
> > > wrong with GNET so 1G speed doesn't work without AN.
> > 
> > OK.
> > 
> > 
> > Thanks,
> > 
> > Yanteng
> > 
> > >
> > > -Serge(y)
> > >
> > >>   >>   struct plat_stmmacenet_data {
> > >>   	int bus_id;
> > >> -- >> 2.31.4
> > >>
> 

