Return-Path: <netdev+bounces-161789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28555A23FE9
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 16:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993D916493E
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367BB1CB9E2;
	Fri, 31 Jan 2025 15:54:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42820318;
	Fri, 31 Jan 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338866; cv=none; b=tAjEyuYZuOmV7uFzOkmlHzJ4I0HxeIwncT6e1E9BFa5tFxZNFldJN3vLxLcc5fbGd+KgX7RI4Z21FbMXKSn0vVT1Hd5UFGyCD05m2Pw+jtVA7jnUwYaaQLe7t2plNHRd7k+PXhMdb6NzhjNJGbaYQvS8u4B76EF1vIe36GPcfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338866; c=relaxed/simple;
	bh=BrN/3vTouMXuRIgIxwpHq2xTQPauqam0lRf3eS1eyLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDeR9G/QMBD2yLw5s1dpkoQN8tFuNUp5v6YmW9pU+vwDAg5yW2jewQjmv4lDRSaEzk3qg4i0kQ1I1hcZs5PiFzRx20Ry0MVWa6NUWyfVMXs8LSaHoD0l9N8nyCdo4RZJeiWcKSanxSfAlbBS8kTTvds0/STeQYDZso0EM6j15Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DA5B497;
	Fri, 31 Jan 2025 07:54:47 -0800 (PST)
Received: from [10.1.32.52] (e122027.cambridge.arm.com [10.1.32.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A175E3F694;
	Fri, 31 Jan 2025 07:54:18 -0800 (PST)
Message-ID: <915713e1-b67f-4eae-82c6-8dceae8f97a7@arm.com>
Date: Fri, 31 Jan 2025 15:54:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability value
 when FIFO size isn't specified
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Yanteng Si <si.yanteng@linux.dev>,
 Furong Xu <0x1207@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>
 <fc08926d-b9af-428f-8811-4bfe08acc5b7@lunn.ch>
 <f343c126-fed9-4209-a18d-61a4e604db2f@arm.com>
 <a4e31542-3534-4856-a90f-e47960ed0907@lunn.ch>
 <d6265f8e-51bc-4556-9ecb-bfb73f86260d@arm.com>
 <2ed9e7c7-e760-409e-a431-823bc3f21cb7@lunn.ch>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <2ed9e7c7-e760-409e-a431-823bc3f21cb7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2025 15:29, Andrew Lunn wrote:
> On Fri, Jan 31, 2025 at 03:03:11PM +0000, Steven Price wrote:
>> On 31/01/2025 14:47, Andrew Lunn wrote:
>>>>> I'm guessing, but in your setup, i assume the value is never written
>>>>> to a register, hence 0 is O.K. e.g. dwmac1000_dma_operation_mode_rx(),
>>>>> the fifosz value is used to determine if flow control can be used, but
>>>>> is otherwise ignored.
>>>>
>>>> I haven't traced the code, but that fits my assumptions too.
>>>
>>> I could probably figure it out using code review, but do you know
>>> which set of DMA operations your hardware uses? A quick look at
>>> dwmac-rk.c i see:
>>>
>>>         /* If the stmmac is not already selected as gmac4,
>>>          * then make sure we fallback to gmac.
>>>          */
>>>         if (!plat_dat->has_gmac4)
>>>                 plat_dat->has_gmac = true;
>>
>> has_gmac4 is false on this board, so has_gmac will be set to true here.
> 
> Thanks. Looking in hwif.c, that means dwmac1000_dma_ops are used.
> 
> dwmac1000_dma_operation_mode_rx() just does a check:
> 
> 	if (rxfifosz < 4096) {
> 		csr6 &= ~DMA_CONTROL_EFC;
> 
> but otherwise does not use the value.
> 
> dwmac1000_dma_operation_mode_tx() appears to completely ignore fifosz.
> 
> So i would say all zero is valid for has_gmac == true, but you might
> gain flow control if a value was passed.
> 
> A quick look at dwmac100_dma_operation_mode_tx() suggests fifosz is
> also ignored, and dwmac100_dma_operation_mode_rx() does not exist. So
> all 0 is also valid for gmac == false, gmac4 == false, and xgmac ==
> false.
> 
> dwmac4_dma_rx_chan_op_mode() does use the value to determine mtl_rx_op
> which gets written to a register. So gmac4 == true looks to need
> values. dwxgmac2_dma_rx_mode() is the same, so xgmac = true also need
> valid values.
> 
> Could you cook up a fix based on this?

The below works for me, I haven't got the hardware to actually test the 
gmac4/xgmac paths:

----8<----
From 1ff2f1d5c35d95b38cdec02a283b039befdff0a4 Mon Sep 17 00:00:00 2001
From: Steven Price <steven.price@arm.com>
Date: Fri, 31 Jan 2025 15:45:50 +0000
Subject: [PATCH] net: stmmac: Allow zero for [tr]x_fifo_size

Commit 8865d22656b4 ("net: stmmac: Specify hardware capability value
when FIFO size isn't specified") modified the behaviour to bail out if
both the FIFO size and the hardware capability were both set to zero.
However devices where has_gmac4 and has_xgmac are both false don't use
the fifo size and that commit breaks platforms for which these values
were zero.

Only warn and error out when (has_gmac4 || has_xgmac) where the values
are used and zero would cause problems, otherwise continue with the zero
values.

Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when FIFO size isn't specified")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d04543e5697b..821404beb629 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7222,7 +7222,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (!priv->plat->rx_fifo_size) {
 		if (priv->dma_cap.rx_fifo_size) {
 			priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
-		} else {
+		} else if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 			dev_err(priv->device, "Can't specify Rx FIFO size\n");
 			return -ENODEV;
 		}
@@ -7236,7 +7236,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (!priv->plat->tx_fifo_size) {
 		if (priv->dma_cap.tx_fifo_size) {
 			priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
-		} else {
+		} else if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 			dev_err(priv->device, "Can't specify Tx FIFO size\n");
 			return -ENODEV;
 		}
-- 
2.39.5



