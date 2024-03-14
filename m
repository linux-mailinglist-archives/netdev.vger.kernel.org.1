Return-Path: <netdev+bounces-79882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06CE87BD63
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BDA1C20D44
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56415A11A;
	Thu, 14 Mar 2024 13:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FDA5811C
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422049; cv=none; b=SHUNkjzyItuFwijqAahENJlJi3elWHh4n9xNFcs+mJlFsEqONrZCvWpLoASOKa0zRt3jbKsMRU115BK8CWNBNzyg39wD86WqEK5YmxofiMjnDIGhBOrGJW55cBjmGP0QzIe/Ra7ZTIMjfch9k/Al75cdtdE7tbdCP/nLUNatCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422049; c=relaxed/simple;
	bh=nF33gnFkDMmYaJGi5zw2ff2GBVZgINRh9XfAG1anKi4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vzs9izQvrqoqj34V14vHJNh4AVADNu1NVq9IP5jltIb6JD5Lg/OHFd+HYT/kRz7IOY2IOIdTz88uvIOODSCzhYmwopdu8kMiE/aulW4w8aN5IS1KL7gMZ2DfaItsviq51iIHjoYZfsDN3AktFUOCvwCe2FGEpiFfDaLmXZF5GL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8Axuugb+PJlPRoZAA--.40894S3;
	Thu, 14 Mar 2024 21:14:03 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf88W+PJl8BxaAA--.39924S3;
	Thu, 14 Mar 2024 21:14:01 +0800 (CST)
Message-ID: <f9c5c697-6c3f-4cfb-aa60-2031b450a470@loongson.cn>
Date: Thu, 14 Mar 2024 21:13:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add
 multi-channel supports for loongson
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
 <eqecwmi3guwda3wloxcttkx2xlteupvrsetb5ro5abupwhxqyu@ypliwpyswy23>
 <e1c7b5fa-f3f8-4aa3-af4d-ca72b54d9c8c@loongson.cn>
In-Reply-To: <e1c7b5fa-f3f8-4aa3-af4d-ca72b54d9c8c@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxf88W+PJl8BxaAA--.39924S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw48ZryxXFy7WFW3Ar4UZFc_yoWxAF17pr
	W3CayakrWjqry3WanFva15WF1YyrZxtrWxWr43tw1ru3yqyr9FqryUKayjk3yxCrZ8JF18
	Zr48CFs7uFn8ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==


在 2024/3/14 17:33, Yanteng Si 写道:
> 在 2024/2/6 05:28, Serge Semin 写道:
> > On Tue, Jan 30, 2024 at 04:48:19PM +0800, Yanteng Si wrote:
> >> Request allocation for MSI for specific versions.
> >>
> > Please elaborate what is actually done in the patch. What device
> > version it is dedicated for (Loongson GNET?), what IRQs the patch
> > adds, etc.
> gnet_device   core IP    IRQ
> 7a2000        0x37    legacy
> 2k2000        0x10    multi_msi
> >
> > BTW will GNET device work without this patch? If no you need to either
> > merge it into the patch introducing the GNET-device support or place
> > it before that patch (6/11).
> OK, GNET device work need this patch.
> >   
> >> Some features of Loongson platforms are bound to the GMAC_VERSION
> >> register. We have to read its value in order to get the correct channel
> >> number.
> > This message seems misleading. I don't see you doing that in the patch below...
> Because part of our gnet hardware (7a2000) core IP is 0x37
> >
> >> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
> >> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
> >> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
> >> ---
> >>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 57 +++++++++++++++----
> >>   1 file changed, 46 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> index 584f7322bd3e..60d0a122d7c9 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> @@ -98,10 +98,10 @@ static void dwlgmac_dma_init_channel(struct stmmac_priv *priv,
> >>   	if (dma_cfg->aal)
> >>   		value |= DMA_BUS_MODE_AAL;
> >>
> >   
> >> -	writel(value, ioaddr + DMA_BUS_MODE);
> >> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
> >>   
> >>   	/* Mask interrupts by writing to CSR7 */
> >> -	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_INTR_ENA);
> >> +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_CHAN_INTR_ENA(chan));
> > Em, why is this here? There is a patch
> > [PATCH net-next v8 05/11] net: stmmac: dwmac-loongson: Add Loongson-specific register definitions
> > in this series which was supposed to introduce the fully functional
> > GNET-specific callbacks. Move this change in there.
> OK.
> >
> >>   }
> >>   
> >>   static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
> >> @@ -238,6 +238,45 @@ static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
> >>   	return 0;
> >>   }
> >>   
> >> +static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
> > This method seems like the GNET-specific one. What about using the
> > appropriate prefix then?
> OK. loongson_gnet_config_multi_msi()
>
> >
> >> +					   struct plat_stmmacenet_data *plat,
> >> +					   struct stmmac_resources *res,
> >> +					   struct device_node *np,
> >> +					   int channel_num)
> > Why do you need this parametrization? Since this method is
> > GNET-specific what about defining a macro with the channels amount and
> > using it here?
>
> OK.
>
> #define CHANNEL_NUM    8
>
> >
> >> +{
> >> +	int i, ret, vecs;
> >> +
> >> +	vecs = roundup_pow_of_two(channel_num * 2 + 1);
> >> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> >> +	if (ret < 0) {
> >> +		dev_info(&pdev->dev,
> >> +			 "MSI enable failed, Fallback to legacy interrupt\n");
> >> +		return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > In what conditions is this possible? Will the
> > loongson_dwmac_config_legacy() method work in that case? Did you test
> > it out?
> Failed to apply for msi interrupt when the interrupt number is not enough，For
> example, there are a large number of devices。
> >> +	}
> >> +
> >> +	plat->rx_queues_to_use = channel_num;
> >> +	plat->tx_queues_to_use = channel_num;
> > This is supposed to be initialized in the setup() methods. Please move
> > it to the dedicated patch.
> No, referring to my previous reply, only the 0x10 gnet device has 8 channels,
> and the 0x37 device has a single channel.
> >
> >> +
> >> +	res->irq = pci_irq_vector(pdev, 0);
> >> +	res->wol_irq = res->irq;
> > Once again. wol_irq is optional. If there is no dedicated WoL IRQ
> > leave the field as zero.
> OK.
>
> res->wol_irq = 0;
>
> >
> >> +
> >> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> >> +	 * --------- ----- -------- --------  ...  -------- --------
> >> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> >> +	 */
> >> +	for (i = 0; i < channel_num; i++) {
> >> +		res->rx_irq[channel_num - 1 - i] =
> >> +			pci_irq_vector(pdev, 1 + i * 2);
> >> +		res->tx_irq[channel_num - 1 - i] =
> >> +			pci_irq_vector(pdev, 2 + i * 2);
> >> +	}
> >> +
> >> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> >> +	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
> > What's the point in printing this message especially with the __func__
> > prefix?  You'll always be able to figure out the allocated IRQs by
> > means of procfs. I suggest to drop it.
>
> OK.
>
> >
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>   static void loongson_default_data(struct pci_dev *pdev,
> >>   				  struct plat_stmmacenet_data *plat)
> >>   {
> >> @@ -296,11 +335,8 @@ static int loongson_gmac_config(struct pci_dev *pdev,
> >>   				struct stmmac_resources *res,
> >>   				struct device_node *np)
> >>   {
> >> -	int ret;
> >> -
> >> -	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> >>   
> >> -	return ret;
> >> +	return 0;
> >>   }
> >>   
> >>   static struct stmmac_pci_info loongson_gmac_pci_info = {
> >> @@ -380,11 +416,7 @@ static int loongson_gnet_config(struct pci_dev *pdev,
> >>   				struct stmmac_resources *res,
> >>   				struct device_node *np)
> >>   {
> >> -	int ret;
> >> -
> >> -	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> >> -
> >> -	return ret;
> >> +	return 0;
> >>   }
> > Here you are dropping the changes you just introduced leaving the
> > config() methods empty... Why not to place the
> > loongson_dwmac_config_legacy() invocation in the probe() method right
> > at the patches introducing the config() functions and not to add the
> > config() callback in the first place?
> OK, I will try.
>
> Thanks,
>
> Yanteng
>
> >
> > -Serge(y)
> >
> >>   
> >>   static struct stmmac_pci_info loongson_gnet_pci_info = {
> >> @@ -483,6 +515,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
> >>   		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
> >>   
> >>   		plat->setup = loongson_setup;
> >> +		ret = loongson_dwmac_config_multi_msi(pdev, plat, &res, np, 8);
> >> +	} else {
> >> +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> >>   	}
> >>   
> >>   	plat->bsp_priv = ld;
> >> -- 
> >> 2.31.4
> >>


