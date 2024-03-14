Return-Path: <netdev+bounces-79885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFC87BD89
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06D9285E6F
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818D5BADF;
	Thu, 14 Mar 2024 13:18:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BBB5BACF
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422303; cv=none; b=dnJGGvPc9QkOFUXpWsLgfChaec+NRSHzZKs+AA8gskAjj9/ukhkFJ9Ox3zepgBhNDjboXPoKdEv+2licixBEcGF+lw4FVfoue/zBI+dXHwYWi6kiZIu0JWLe11B3Bo11iZqCLAJyaRzncTO5JH5mn/mZAYR0zh0UCpfzhtpDHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422303; c=relaxed/simple;
	bh=jjiYQmYQLc/wytD4RVza78k7w8DX3vSUHBAUCCajRh8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YK+E9Q2UoA6jPJRcZYyq3uH1g8w63z7YaORuS4SjolNM+fRzGbmndFoHuP4LTtN5WZHu2wD+NNbY2U6xwr7pXKgdYUKpKSC+2w6q3l+dF431Iy5GxTQBrH/40SRdInaajz2l2dsY5drEhbQstI+NDWfZ4uxJyxxjWPzpt/hfYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8AxqvAa+fJlgxoZAA--.60662S3;
	Thu, 14 Mar 2024 21:18:18 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx8OQX+fJlvh1aAA--.40597S3;
	Thu, 14 Mar 2024 21:18:17 +0800 (CST)
Message-ID: <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
Date: Thu, 14 Mar 2024 21:18:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
In-Reply-To: <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx8OQX+fJlvh1aAA--.40597S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF43Xr47Aw1UZry7Jw4rXrc_yoW7Zr4rp3
	y7Aas0kryDXr17Janaqw4UXFyF9a45KrWxuw4xtryagF9Fkr9aqryjgFW5CF1xur4kuFWa
	vr4j9ry7uFn8CacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==


在 2024/3/14 17:43, Yanteng Si 写道:
> 在 2024/2/6 05:55, Serge Semin 写道:
> > On Tue, Jan 30, 2024 at 04:48:20PM +0800, Yanteng Si wrote:
> >> Current GNET on LS7A only supports ANE when speed is
> >> set to 1000M.
> > If so you need to merge it into the patch
> > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support

>> Current GNET on LS7A only supports ANE when speed is
>> set to 1000M.

>If so you need to merge it into the patch
>[PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support

OK.

> >
> >> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
> >> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
> >> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
> >> ---
> >>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 +++++++++++++++++++
> >>   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++++++
> >>   include/linux/stmmac.h                        |  1 +
> >>   3 files changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> index 60d0a122d7c9..264c4c198d5a 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> @@ -344,6 +344,21 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
> >>   	.config = loongson_gmac_config,
> >>   };
> >>   
> >> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> >> +{
> >> +	struct loongson_data *ld = (struct loongson_data *)priv;
> >> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
> >> +	struct stmmac_priv *ptr = netdev_priv(ndev);
> >> +
> >> +	/* The controller and PHY don't work well together.
> > So there _is_ a PHY. What is the interface between MAC and PHY then?
> >
> > GMAC only has a MAC chip inside the chip and needs an external PHY chip; GNET 
> > has the PHY chip inside the chip.
> >> +	 * We need to use the PS bit to check if the controller's status
> >> +	 * is correct and reset PHY if necessary.
> >> +	 */
> >> +	if (speed == SPEED_1000)
> >> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
> >> +			phy_restart_aneg(ndev->phydev);
> > 1. Please add curly braces for the outer if-statement.
> OK,
> > 2. MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
>
> OK.
>
> if(speed==SPEED_1000){
> /*MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.*/
> if(readl(ptr->ioaddr+MAC_CTRL_REG) &(1<<15))
> phy_restart_aneg(ndev->phydev);
> }
>
> > 3. How is the AN-restart helps? PHY-reset is done in
> > stmmac_init_phy()->phylink_connect_phy()->... a bit earlier than
> > this is called in the framework of the stmmac_mac_link_up() callback.
> > Wouldn't that restart AN too?
>
> Due to a bug in the chip's internal PHY, the network is still not working after
> the first self-negotiation, and it needs to be self-negotiated again.
>
> >
> >> +}
> >> +
> >>   static struct mac_device_info *loongson_setup(void *apriv)
> >>   {
> >>   	struct stmmac_priv *priv = apriv;
> >> @@ -401,6 +416,7 @@ static int loongson_gnet_data(struct pci_dev *pdev,
> >>   	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
> >>   
> >>   	plat->bsp_priv = &pdev->dev;
> >> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
> >>   
> >>   	plat->dma_cfg->pbl = 32;
> >>   	plat->dma_cfg->pblx8 = true;
> >> @@ -416,6 +432,9 @@ static int loongson_gnet_config(struct pci_dev *pdev,
> >>   				struct stmmac_resources *res,
> >>   				struct device_node *np)
> >>   {
> >> +	if (pdev->revision == 0x00 || pdev->revision == 0x01)
> >> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> >> +
> > This should be in the patch
> > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> OK.
> >
> >>   	return 0;
> >>   }
> >>   
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> >> index 42d27b97dd1d..31068fbc23c9 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> >> @@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
> >>   		return 0;
> >>   	}
> >>   
> >> +	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, priv->plat->flags)) {
> > FIELD_GET()?
>
> OK,
>
> if (STMMAC_FLAG_DISABLE_FORCE_1000 & priv->plat->flags) {
>
> >
> >> +		if (cmd->base.speed == SPEED_1000 &&
> >> +		    cmd->base.autoneg != AUTONEG_ENABLE)
> >> +			return -EOPNOTSUPP;
> >> +	}
> >> +
> >>   	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
> >>   }
> >>   
> >> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> >> index dee5ad6e48c5..2810361e4048 100644
> >> --- a/include/linux/stmmac.h
> >> +++ b/include/linux/stmmac.h
> >> @@ -221,6 +221,7 @@ struct dwmac4_addrs {
> >>   #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
> >>   #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
> >>   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
> >> +#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
> > Detach the change introducing the STMMAC_FLAG_DISABLE_FORCE_1000 flag
> > into a separate patch a place it before
> > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> > as a pre-requisite/preparation patch.
> > Don't forget a _detailed_ description of why it's necessary, what is
> > wrong with GNET so 1G speed doesn't work without AN.
>
> OK.
>
>
> Thanks,
>
> Yanteng
>
> >
> > -Serge(y)
> >
> >>   
> >>   struct plat_stmmacenet_data {
> >>   	int bus_id;
> >> -- 
> >> 2.31.4
> >>


