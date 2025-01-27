Return-Path: <netdev+bounces-161038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB8A1CF67
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 02:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2051886772
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 01:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EDB64D;
	Mon, 27 Jan 2025 01:18:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589CA25A643;
	Mon, 27 Jan 2025 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737940729; cv=none; b=tFse2HEY6mSk0CpRbngAT40zE6VU0Xn1E4qpxCCsB0YLpmvYkwv5O1q0xNenKIITwT3rcxDwurLTzDpqPcQPCYdzTC1qo6OEmBqSpvW8qCMsm2W9L8ByBcasPTsYV3nQFQxPF/Oj5t8KIvtBK9tinMq41KRFbU4x2unTm2kXcLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737940729; c=relaxed/simple;
	bh=c61dHan8hHE5acdNuCVj+0ufeH0Nd14tf6Lqc3OFmAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+YHTitZ7gW0L8G7+qoJVwywB+jym+3gbH8UNPkCUG1zTAl3fW+3Z1yfsbl5hkv7jjpHzZ491kjfzFDzO0iwy8KM5SqkTHj4/WmRYchkn6fyhbVSxJcA/IQXbxqeeMgdjjiZxzJNVxaQFPhkBmtDNNhgoA7AmwfJQwgiq+sxQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jan 2025 10:18:39 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B7431200C4F1;
	Mon, 27 Jan 2025 10:18:39 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 27 Jan 2025 10:18:39 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 06C8FAB186;
	Mon, 27 Jan 2025 10:18:39 +0900 (JST)
Message-ID: <bc3734ba-e68d-4700-8596-2710f6101f8f@socionext.com>
Date: Mon, 27 Jan 2025 10:18:38 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: stmmac: Limit the number of MTL queues to
 hardware capability
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250124101359.2926906-1-hayashi.kunihiko@socionext.com>
 <20250124101359.2926906-2-hayashi.kunihiko@socionext.com>
 <Z5N8-2XVAFBn1BCY@shell.armlinux.org.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z5N8-2XVAFBn1BCY@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/24 20:43, Russell King (Oracle) wrote:
> On Fri, Jan 24, 2025 at 07:13:57PM +0900, Kunihiko Hayashi wrote:
>> The number of MTL queues to use is specified by the parameter
>> "snps,{tx,rx}-queues-to-use" from stmmac_platform layer.
>>
>> However, the maximum numbers of queues are constrained by upper limits
>> determined by the capability of each hardware feature. It's appropriate
>> to limit the values not to exceed the upper limit values and display
>> a warning message.
>>
>> This only works if the hardware capability has the upper limit values.
>>
>> Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 7bf275f127c9..be1e6fa6d557 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -7232,6 +7232,21 @@ static int stmmac_hw_init(struct stmmac_priv
> *priv)
>>   	if (priv->dma_cap.tsoen)
>>   		dev_info(priv->device, "TSO supported\n");
>>   
>> +	if (priv->dma_cap.number_rx_queues &&
>> +	    priv->dma_cap.number_rx_queues < priv->plat->rx_queues_to_use)
> {
> 
> While this looks "nicer", which of these two do you think reads better
> and is easier to understand:
> 
> "If priv->dma_cap.number_rx_queues is set, and
>   priv->dma_cap.number_rx_queues is less than
>   priv->plat->rx_queues_to_use then print a message about
>   priv->plat->rx_queues_to_use exceeding priv->dma_cap.number_rx_queues"
> 
> "If priv->dma_cap.number_rx_queues is set, and
>   priv->plat->rx_queues_to_use is greater than
>   priv->dma_cap.number_rx_queues, then print a message about
>   priv->plat->rx_queues_to_use exceeding priv->dma_cap.number_rx_queues"
> 
> With the former one has to mentally flip the test around in the if
> statement to check that it does indeed match the warning that is
> printed.

This patch focuses only on the conditional lines, however, certainly
it's not good to have the meaning of the message and the condition
reversed.

I'll fix it next.

Thank you,

---
Best Regards
Kunihiko Hayashi

