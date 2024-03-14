Return-Path: <netdev+bounces-79877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFADE87BD4A
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9991F21804
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D665A4CB;
	Thu, 14 Mar 2024 13:08:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37215A0F3
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421732; cv=none; b=ucQlKBBG+GXkYFgNys9x8NStu3dSH/VkSW+VkIxqh7axsJj/YFclany1ce0bKhxz9aDtgJX+3VJZOC8fjf4hrPKilQ1u2lanKm3+jwxaPcQZxAQA69nbp3nRHmCHpAFty1I3ldUdD3lx+qPWhmtYDKEYqTY0+6/l0LFroc1VPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421732; c=relaxed/simple;
	bh=X7zKzHmvhn6wsj8BPK9lIrj1uQfYI3dQU07btSOn/CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/evXW8RWUOpdj41vRTIPz0CPYLuok8KL8RxdOMtsRlOMRoCBuIg9E3IVICMznTdWyYDhFSq9vphF7cAkLmRDI35neYLiwXzFYSjyTctKVShiYSGLihGkDSnxvIQNJfDBKESBAlNmsIwL0EFDZKHhM5oCaw4EwLe1exgQ3yCfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8CxXOnd9vJl0BkZAA--.50862S3;
	Thu, 14 Mar 2024 21:08:45 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs_a9vJltBtaAA--.38630S3;
	Thu, 14 Mar 2024 21:08:43 +0800 (CST)
Message-ID: <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
Date: Thu, 14 Mar 2024 21:08:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs_a9vJltBtaAA--.38630S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFWruryUKw1fWFWfJF15KFX_yoW7uFW8pr
	W8Aa4j9a4ktr17Jw1vvw4DXFyYgFyUtrWUWFWxKrWS9FZFk34qqryjvFW5uFy7ur4kWFy2
	qrWj9r13uFn8GwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2G-eUUUUU


在 2024/3/13 18:21, Russell King (Oracle) 写道:
> On Wed, Mar 13, 2024 at 05:24:52PM +0800, Yanteng Si wrote:
>> 在 2024/2/6 06:06, Serge Semin 写道:
>>> On Tue, Feb 06, 2024 at 12:58:17AM +0300, Serge Semin wrote:
>>>> On Tue, Jan 30, 2024 at 04:49:14PM +0800, Yanteng Si wrote:
>>>>> Current GNET does not support half duplex mode.
>>>>>
>>>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>>>> ---
>>>>>    drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 ++++++++++-
>>>>>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  3 ++-
>>>>>    include/linux/stmmac.h                               |  1 +
>>>>>    3 files changed, 13 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> index 264c4c198d5a..1753a3c46b77 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> @@ -432,8 +432,17 @@ static int loongson_gnet_config(struct pci_dev *pdev,
>>>>>    				struct stmmac_resources *res,
>>>>>    				struct device_node *np)
>>>>>    {
>>>>> -	if (pdev->revision == 0x00 || pdev->revision == 0x01)
>>>>> +	switch (pdev->revision) {
>>>>> +	case 0x00:
>>>>> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000 |
>>>>> +			       STMMAC_FLAG_DISABLE_HALF_DUPLEX;
>>>>> +		break;
>>>>> +	case 0x01:
>>>>>    		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
>>>>> +		break;
>>>>> +	default:
>>>>> +		break;
>>>>> +	}
>>>> Move this change into the patch
>>>> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
>>>>
>>>>>    	return 0;
>>>>>    }
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> index 5617b40abbe4..3aa862269eb0 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> @@ -1201,7 +1201,8 @@ static int stmmac_init_phy(struct net_device *dev)
>>>>>    static void stmmac_set_half_duplex(struct stmmac_priv *priv)
>>>>>    {
>>>>>    	/* Half-Duplex can only work with single tx queue */
>>>>> -	if (priv->plat->tx_queues_to_use > 1)
>>>>> +	if (priv->plat->tx_queues_to_use > 1 ||
>>>>> +	    (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
>>>>>    		priv->phylink_config.mac_capabilities &=
>>>>>    			~(MAC_10HD | MAC_100HD | MAC_1000HD);
>>>>>    	else
>>>>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>>>>> index 2810361e4048..197f6f914104 100644
>>>>> --- a/include/linux/stmmac.h
>>>>> +++ b/include/linux/stmmac.h
>>>>> @@ -222,6 +222,7 @@ struct dwmac4_addrs {
>>>>>    #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>>>>>    #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>>>>>    #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
>>>>> +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
>>>> Place the patch with this change before
>>>> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
>>>> as a pre-requisite/preparation patch. Don't forget a thorough
>>>> description of what is wrong with the GNET Half-Duplex mode.
>>> BTW what about re-defining the stmmac_ops.phylink_get_caps() callback
>>> instead of adding fixup flags in this patch and in the next one?
>> ok.
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index ac1b48ff7199..b57e1325ce62 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -238,6 +234,13 @@ static int loongson_gnet_get_hw_feature(void __iomem
>> *ioaddr,
>>       return 0;
>>   }

Hi Russell,

>> +static void loongson_phylink_get_caps(struct stmmac_priv *priv)
>> +{
>> +    priv->phylink_config.mac_capabilities = (MAC_10FD |
>> +        MAC_100FD | MAC_1000FD) & ~(MAC_10HD | MAC_100HD | MAC_1000HD);
> Why is this so complicated? It would be silly if the _full duplex_
> definitions also defined the _half duplex_ bits. This should be just:
>
> 	priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD |
> 						MAC_1000FD;

Yes, you are right. Our gnet device (7a2000) does not support 
half-duplex, while the gnet device (2k2000) does.

I plan to use PCI IDand IP CORE as the condition to separate full-duplex 
and half-duplex.

>
> if that is all you support. Do you not support any pause modes (they
> would need to be included as well here.)

I have tested it and our gnet device supports MAC_ASYM_PAUSE and 
MAC_SYM_PAUSE, but gmac does not. I will fix this in the patch v9.

This is also easy to do because all GMAC devices have the same PCI ID.

>
> As to this approach, I don't think it's a good model to override the
> stmmac MAC operations. Instead, I would suggest that a better approach
> would be for the platform to provide its capabilities to the stmmac
> core code (maybe a new member in stmmac_priv) which, when set, is used
> to reduce the capabilities provided to phylink via
> priv->phylink_config.mac_capabilities.
>
> Why? The driver has several components that are involved in the
> overall capabilities, and the capabilities of the system is the
> logical subset of all these capabilities. One component should not
> be setting capabilities that a different component doesn't support.

Hi Serge,

It seems to be going back again, what do you think?

Thanks,

Yanteng

>


