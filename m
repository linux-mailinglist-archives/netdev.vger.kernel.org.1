Return-Path: <netdev+bounces-160480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE708A19DFD
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 06:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927843AD3C9
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 05:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2001C3C1D;
	Thu, 23 Jan 2025 05:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958031BFE05;
	Thu, 23 Jan 2025 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737609928; cv=none; b=dGcVQRtc0/JfONttqpm+p3lSVkiHdJ30ccv1lIMOA7ni7B019YZYbuWyyOSFPOj+DKTLYWEpBuKCQ8seQPHIFBT/N77EWRCOJrE3FynogruyNvb6tuSIWaqj8MBHvZdrXAzHonE01JCJz+sojoyEtgH1ildII2j8BalT4TTS/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737609928; c=relaxed/simple;
	bh=+Zl4xmaZ+uLTF4f7Dv295CFK71yoc1Ns/h18QlGPMm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZgOmNae8ke2d/uQBhhYU8paW7R+fPae4lTXHmCKyyHXcCFXXVaAU8gQiwqC8WrksacKFybAcjdOtUc8qACf63hSAlIoCP65xJbiNockFnC63v1F0Mf39fQ28+sUQw1adWQqqKX+inupmcP/i4HQe5ugVRke8vobOyZ1zDxJDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Jan 2025 14:25:20 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 43D572006E93;
	Thu, 23 Jan 2025 14:25:20 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 23 Jan 2025 14:25:20 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 89253AB183;
	Thu, 23 Jan 2025 14:25:19 +0900 (JST)
Message-ID: <c2aa354d-1bd5-4fb0-a8b8-48fcce3c1628@socionext.com>
Date: Thu, 23 Jan 2025 14:25:19 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net: stmmac: Limit FIFO size by hardware
 capability
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Yanteng Si <si.yanteng@linux.dev>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Vince Bridgers <vbridger@opensource.altera.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
 <20250121044138.2883912-3-hayashi.kunihiko@socionext.com>
 <07f2f6d0-e025-4b21-ac41-caaf71bb6fff@linux.dev>
 <Z4_ZilVFKacuAUE8@shell.armlinux.org.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z4_ZilVFKacuAUE8@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2025/01/22 2:29, Russell King (Oracle) wrote:
> On Wed, Jan 22, 2025 at 01:14:25AM +0800, Yanteng Si wrote:
>> 在 1/21/25 12:41, Kunihiko Hayashi 写道:
>>> Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
>>> stmmac_platform layer.
>>>
>>> However, these values are constrained by upper limits determined by the
>>> capabilities of each hardware feature. There is a risk that the upper
>>> bits will be truncated due to the calculation, so it's appropriate to
>>> limit them to the upper limit values and display a warning message.
>>>
>>> Fixes: e7877f52fd4a ("stmmac: Read tx-fifo-depth and rx-fifo-depth from
>>> the devicetree")
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 251a8c15637f..da3316e3e93b 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -7245,6 +7245,19 @@ static int stmmac_hw_init(struct stmmac_priv
>>> *priv)
>>>    		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
>>>    	}
>>
>>> +	if (priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
>>
>>> +		dev_warn(priv->device,
>>> +			 "Rx FIFO size exceeds dma capability (%d)\n",
>>> +			 priv->plat->rx_fifo_size);
>>> +		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
>> I executed grep and found that only dwmac4 and dwxgmac2 have initialized
>> dma_cap.rx_fifo_size. Can this code still work properly on hardware other
>> than these two?
> 
> Looking at drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:
> 
>          /* Compute minimum number of packets to make FIFO full */
>          pkt_count = priv->plat->rx_fifo_size;
>          if (!pkt_count)
>                  pkt_count = priv->dma_cap.rx_fifo_size;
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:
> 
>          int rxfifosz = priv->plat->rx_fifo_size;
>          int txfifosz = priv->plat->tx_fifo_size;
> 
>          if (rxfifosz == 0)
>                  rxfifosz = priv->dma_cap.rx_fifo_size;
>          if (txfifosz == 0)
>                  txfifosz = priv->dma_cap.tx_fifo_size;
> 
> (in two locations)
> 
> It looks to me like the intention is that priv->plat->rx_fifo_size is
> supposed to _override_ whatever is in priv->dma_cap.rx_fifo_size.
> 
> Now looking at the defintions:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_RXFIFOSIZE
> GENMASK(4, 0)
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h:#define
> XGMAC_HWFEAT_RXFIFOSIZE GENMASK(4, 0)
> 
> So there's a 5-bit bitfield that describes the receive FIFO size for
> these two MACs. Then we have:
> 
> drivers/net/ethernet/stmicro/stmmac/common.h:#define DMA_HW_FEAT_RXFIFOSIZE
> 0x00080000       /* Rx FIFO > 2048 Bytes */
> 
> which is used here:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:
> dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
> 
> which is only used to print a Y/N value in a debugfs file, otherwise
> having no bearing on driver behaviour.
> 
> So, I suspect MACs other than xgmac2 or dwmac4 do not have the ability
> to describe the hardware FIFO sizes in hardware, thus why there's the
> override and no checking of what the platform provided - and doing so
> would break the driver. This is my interpretation from the code alone.

Surely, other MACs than xgmac2 and dwmac4 don't have hardware capability
values, and the variables from the capabilities will have zero.
I can add a check whether a capability value is zero or not like that:

If priv->plat->rx-fifo-size is not specified:

     if (priv->dma_cap.rx_fifo_size)
         priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
     else
         return; (with an error value and a message)

If priv->plat->rx-fifo-size is specified:

     if (priv->dma_cap.rx_fifo_size &&
         priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size)
         priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;

Same as others.

Thank you,

---
Best Regards
Kunihiko Hayashi

