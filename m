Return-Path: <netdev+bounces-80768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0960488101F
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F4A1C23151
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA18376F1;
	Wed, 20 Mar 2024 10:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5D376E2
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931333; cv=none; b=pHEQM9tgZFsgjKLcmCLv+IucUtWoAUyHUf8rGR2phP4laHS4musQLLtXwTSTKdSX3n6Cl+ROvKPcU/cnZLQdCqtwKOYN2IkQFt9AFiSjIVjHbC0R3tAP8tO5ESiSN88XGkcUN3aUH9034msSKJYBWTeatlOP7mLC1I4dKBH3WQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931333; c=relaxed/simple;
	bh=pzzx/rWpIlz5+Q6DNcOC9dRdg2Q3wHdnkEcuct/4MPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nG11IGif3mGMus4qsntyUJo4mAS9SnzZj+EYQbKuvHU1N9gKzFt9G47RceUN0UtoZymvwScbYic/GfGJvDpdZbb0RqUpxTe38qjYkFJoEYUxeYB/vOAgz1E7ZsKAHLmEY5D9lXN1/4W195r3tohpXPb2JS69yPws3Om82ruFTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8Ax++h_vfplKjkbAA--.45397S3;
	Wed, 20 Mar 2024 18:42:07 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc98vfplxlVeAA--.51884S3;
	Wed, 20 Mar 2024 18:42:05 +0800 (CST)
Message-ID: <f714e017-4016-4230-bb81-1a9cfb749844@loongson.cn>
Date: Wed, 20 Mar 2024 18:42:04 +0800
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
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxDc98vfplxlVeAA--.51884S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WrW8CrWfuw47Xw1UAF4kXwc_yoW3Cr17pw
	47Aa4qkrWDXr1xJwsaqw4UXFyFvry5tr4xuw47try2gF9Fyr9Iqr1jqFW5ury7ur4kuFW2
	vr4jkrW3uFn8CFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==


在 2024/3/20 01:02, Serge Semin 写道:
> On Thu, Mar 14, 2024 at 09:18:15PM +0800, Yanteng Si wrote:
>> 在 2024/3/14 17:43, Yanteng Si 写道:
>>> 在 2024/2/6 05:55, Serge Semin 写道:
>>>> On Tue, Jan 30, 2024 at 04:48:20PM +0800, Yanteng Si wrote:
>>>>> Current GNET on LS7A only supports ANE when speed is
>>>>> set to 1000M.
>>>> If so you need to merge it into the patch
>>>> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
>>>> Current GNET on LS7A only supports ANE when speed is
>>>> set to 1000M.
>>> If so you need to merge it into the patch
>>> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
>> OK.
>>
>>>>> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
>>>>> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
>>>>> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
>>>>> ---
>>>>>    .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 +++++++++++++++++++
>>>>>    .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++++++
>>>>>    include/linux/stmmac.h                        |  1 +
>>>>>    3 files changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> index 60d0a122d7c9..264c4c198d5a 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> @@ -344,6 +344,21 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>>>>>    	.config = loongson_gmac_config,
>>>>>    };
>>>>>    >> +static void loongson_gnet_fix_speed(void *priv, unsigned int
>>> speed, unsigned int mode)
>>>>> +{
>>>>> +	struct loongson_data *ld = (struct loongson_data *)priv;
>>>>> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
>>>>> +	struct stmmac_priv *ptr = netdev_priv(ndev);
>>>>> +
>>>>> +	/* The controller and PHY don't work well together.
>>>> So there _is_ a PHY. What is the interface between MAC and PHY then?
>>>>
>>>> GMAC only has a MAC chip inside the chip and needs an external PHY
>>> chip; GNET > has the PHY chip inside the chip.
> We are talking about GNETs in this method since it has the
> loongson_gnet_ prefix. You are referring to GMAC. I am getting
> confused about all of these. Based on the patch 06/11 of this series
> you call "Loongson GNET" of all the devices placed on the PCI devices
> with PCI ID 0x7a13. PCIe device with ID 0x7a03 is called "Loongson
> GMAC". Right?

ls2k is SOC, ls7a ls bridge:


device    type    pci_id    gmac_version
ls7a1000  gmac    7a03      0x37
ls2k1000  gmac    7a03      0x37
ls7a2000  gnet    7a13      0x37
ls2k2000  gnet    7a13      0x10
>
> Anyway no matter whether the PHY is placed externally or inside the
> chip. AFAIU as long as you know the interface type between MAC and PHY
> it would be better to have it specified.
>
>>>>> +	 * We need to use the PS bit to check if the controller's status
>>>>> +	 * is correct and reset PHY if necessary.
>>>>> +	 */
>>>>> +	if (speed == SPEED_1000)
>>>>> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
>>>>> +			phy_restart_aneg(ndev->phydev);
>>>> 1. Please add curly braces for the outer if-statement.
>>> OK,
>>>> 2. MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
>>> OK.
>>>
>>> if(speed==SPEED_1000){
>>> /*MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.*/
>>> if(readl(ptr->ioaddr+MAC_CTRL_REG) &(1<<15))
>>> phy_restart_aneg(ndev->phydev);
>>> }
>>>
>>>> 3. How is the AN-restart helps? PHY-reset is done in
>>>> stmmac_init_phy()->phylink_connect_phy()->... a bit earlier than
>>>> this is called in the framework of the stmmac_mac_link_up() callback.
>>>> Wouldn't that restart AN too?
>>> Due to a bug in the chip's internal PHY, the network is still not working after
>>> the first self-negotiation, and it needs to be self-negotiated again.
> Then please describe the bug in more details then.
>
> Getting back to the code you implemented here. In the in-situ comment
> you say: "We need to use the PS bit to check if the controller's
> status is correct and reset PHY if necessary." By calling
> phy_restart_aneg() you don't reset the PHY.
>
> Moreover if "PS" flag is set, then the MAC has been pre-configured to
> work in the 10/100Mbps mode. Since 1000Mbps speed is requested, the
> MAC_CTRL_REG.PS flag will be cleared later in the
> stmmac_mac_link_up() method and then phylink_start() shall cause the
> link speed re-auto-negotiation. Why do you need the auto-negotiation
> started for the default MAC config which will be changed just in a
> moment later? All of that seems weird.
>
> Most importantly I have doubts the networking subsystem maintainers
> will permit you calling the phy_restart_aneg() method from the MAC
> driver code.

I will reply to you tomorrow.


>
>>>>> +}
>>>>> +
>>>>>    static struct mac_device_info *loongson_setup(void *apriv)
>>>>>    {
>>>>>    	struct stmmac_priv *priv = apriv;
>>>>> @@ -401,6 +416,7 @@ static int loongson_gnet_data(struct pci_dev *pdev,
>>>>>    	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
>>>>>    >>   	plat->bsp_priv = &pdev->dev;
>>>>> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
>>>>>    >>   	plat->dma_cfg->pbl = 32;
>>>>>    	plat->dma_cfg->pblx8 = true;
>>>>> @@ -416,6 +432,9 @@ static int loongson_gnet_config(struct pci_dev *pdev,
>>>>>    				struct stmmac_resources *res,
>>>>>    				struct device_node *np)
>>>>>    {
>>>>> +	if (pdev->revision == 0x00 || pdev->revision == 0x01)
>>>>> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
>>>>> +
>>>> This should be in the patch
>>>> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
>>> OK.
>>>>>    	return 0;
>>>>>    }
>>>>>    >> diff --git
>>> a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>>>> index 42d27b97dd1d..31068fbc23c9 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>>>> @@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>>>>>    		return 0;
>>>>>    	}
>>>>>    >> +	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000,
>>> priv->plat->flags)) {
>>>> FIELD_GET()?
>>> OK,
>>>
>>> if (STMMAC_FLAG_DISABLE_FORCE_1000 & priv->plat->flags) {
> it's better to change the order of the operands:
> 	if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {

OK,


Thanks,

Yanteng

>
> -Serge(y)
>
>>>>> +		if (cmd->base.speed == SPEED_1000 &&
>>>>> +		    cmd->base.autoneg != AUTONEG_ENABLE)
>>>>> +			return -EOPNOTSUPP;
>>>>> +	}
>>>>> +
>>>>>    	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>>>>>    }
>>>>>    >> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>>>>> index dee5ad6e48c5..2810361e4048 100644
>>>>> --- a/include/linux/stmmac.h
>>>>> +++ b/include/linux/stmmac.h
>>>>> @@ -221,6 +221,7 @@ struct dwmac4_addrs {
>>>>>    #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
>>>>>    #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>>>>>    #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>>>>> +#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
>>>> Detach the change introducing the STMMAC_FLAG_DISABLE_FORCE_1000 flag
>>>> into a separate patch a place it before
>>>> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
>>>> as a pre-requisite/preparation patch.
>>>> Don't forget a _detailed_ description of why it's necessary, what is
>>>> wrong with GNET so 1G speed doesn't work without AN.
>>> OK.
>>>
>>>
>>> Thanks,
>>>
>>> Yanteng
>>>
>>>> -Serge(y)
>>>>
>>>>>    >>   struct plat_stmmacenet_data {
>>>>>    	int bus_id;
>>>>> -- >> 2.31.4
>>>>>


