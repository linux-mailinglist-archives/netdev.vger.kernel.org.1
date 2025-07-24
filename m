Return-Path: <netdev+bounces-209676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136D6B10536
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11254E0106
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B79274B5E;
	Thu, 24 Jul 2025 09:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647EF210F4A;
	Thu, 24 Jul 2025 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347984; cv=none; b=qSOfKJ+w9baJ6ci97x54J/8pRD0WD44KMrTssFR2pQnrk9LxXD/v6IojqyAELnAWIxUEtj3seyiOWwKNP+L2ARsdSFpW0CuqSuTPR1G0MCgQeWzfXZ3Pg9qAWQ0du9ynVoIBLuoojDaK5x/UoS15DtUS5PtqsuHDmEyQVSgo1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347984; c=relaxed/simple;
	bh=AcHqFhrAmveChkGt9Q9dhnxeDQVpdCur5t+Cqbhq4Yo=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J/2Q5TrGzrjQ+wXmgB4ICuQ8hz6ePCrRdA7OLjUXFZMUDwEvdLGbeknuVXnLkWbzvgO+AqY8+WPY1wqw1DcQsRDn3ZPPezIIjO30ZEykmzNa1oQbwTscK1H3NmZec5polzvTL1WqBHuLmkFXGuKrIIqyRPD3R4Giq3oO7RA1+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxJHB694FoDQoxAQ--.58208S3;
	Thu, 24 Jul 2025 17:06:02 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOR294FokHokAA--.57042S3;
	Thu, 24 Jul 2025 17:05:58 +0800 (CST)
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Return early if invalid in
 loongson_dwmac_fix_reset()
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723100056.6651-1-yangtiezhu@loongson.cn>
 <20250723100056.6651-2-yangtiezhu@loongson.cn>
 <f65deb0d-29d1-4820-95e9-f1dd94967957@lunn.ch>
 <b98a5351-f711-ecb1-75fa-68c69263e950@loongson.cn>
Message-ID: <5ef8ae99-256e-8ff7-861f-025e7b7cfb6f@loongson.cn>
Date: Thu, 24 Jul 2025 17:05:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b98a5351-f711-ecb1-75fa-68c69263e950@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOR294FokHokAA--.57042S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF17GFW7GFy5JF18ZFyxJFc_yoWrJFWkpr
	WfAa42qryDtr1fJw4Dtw1DZFyrC345K34kWFZ7A3Z3ua1YyFyjqr1YqFWjgr12yr48tF1a
	qr4Uur1UuF1DJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUU
	U==

On 2025/7/24 上午10:26, Tiezhu Yang wrote:
> On 2025/7/23 下午10:53, Andrew Lunn wrote:
>> On Wed, Jul 23, 2025 at 06:00:55PM +0800, Tiezhu Yang wrote:
>>> If the MAC controller does not connect to any PHY interface, there is a
>>> missing clock, then the DMA reset fails.

...

>>> +    if (value & DMA_BUS_MODE_SFT_RESET)
>>> +        return -EINVAL;
>>
>> What happens with this return value? Do you get an error message which
>> gives a hint the PHY clock is missing? Would a netdev_err() make sense
>> here?
> 
> Yes, I will use dev_err() rather than netdev_err() (because there is no
> net_device member here) to do something like this:
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 6d10077666c7..4a7b2b11ecce 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -513,8 +513,11 @@ static int loongson_dwmac_fix_reset(void *priv, 
> void __iomem *ioaddr)
>   {
>          u32 value = readl(ioaddr + DMA_BUS_MODE);
> 
> -       if (value & DMA_BUS_MODE_SFT_RESET)
> +       if (value & DMA_BUS_MODE_SFT_RESET) {
> +               struct plat_stmmacenet_data *plat = priv;
> +               dev_err(&plat->pdev->dev, "the PHY clock is missing\n");
>                  return -EINVAL;
> +       }
> 
>          value |= DMA_BUS_MODE_SFT_RESET;
>          writel(value, ioaddr + DMA_BUS_MODE);

Oops, the above changes can not work well.

It can not use netdev_err() or dev_err() to print message with device info
in loongson_dwmac_fix_reset() directly, this is because the type of "priv"
argument is struct plat_stmmacenet_data and the "pdev" member of "priv" is
NULL here, it will lead to the fatal error "Unable to handle kernel paging
request at virtual address" when printing message.

Based on the above analysis, in order to show an error message which gives
a hint the PHY clock is missing, it is proper to check the return value of
stmmac_reset() which calls loongson_dwmac_fix_reset().

With this patch, for the normal end user, the computer start faster with
reducing boot time for 2 seconds on the specified mainboard.

The final changes look something like this:

----->8-----
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index e1591e6217d4..6d10077666c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -513,6 +513,9 @@ static int loongson_dwmac_fix_reset(void *priv, void 
__iomem *ioaddr)
  {
         u32 value = readl(ioaddr + DMA_BUS_MODE);

+       if (value & DMA_BUS_MODE_SFT_RESET)
+               return -EINVAL;
+
         value |= DMA_BUS_MODE_SFT_RESET;
         writel(value, ioaddr + DMA_BUS_MODE);

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b948df1bff9a..1a2610815847 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3133,6 +3133,9 @@ static int stmmac_init_dma_engine(struct 
stmmac_priv *priv)

         ret = stmmac_reset(priv, priv->ioaddr);
         if (ret) {
+               if (ret == -EINVAL)
+                       netdev_err(priv->dev, "the PHY clock is missing\n");
+
                 netdev_err(priv->dev, "Failed to reset the dma\n");
                 return ret;
         }

I will wait for more comments and send v3 after the merge window.

Thanks,
Tiezhu


