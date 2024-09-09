Return-Path: <netdev+bounces-126747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79699725F2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37616282DE2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3221118FC67;
	Mon,  9 Sep 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KJEuHZYD"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DF18A95F
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926033; cv=none; b=PvgzJhmcmVl03C+t53LePR2LSMPa4gPGky196C1VCPUxTrIE+F50U+U/edjcIaC0EHwVbeu/TgXUvRm1AZWxqRODsSo5TFipbkJ4fidtDJQnmPY4VBNRYhE8XbYyeXVo0IRp0xClExNbbEJfUkEpbJrzE65lmhu7mryUlxeSmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926033; c=relaxed/simple;
	bh=JEK3htBVwvUaO1imIyiZjFi3195gqFDk1GziVP71OT8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pTxnpoqsSng68+mJ/2L5gGghcjWGbnUtKF2lnIq7IKJz9yYEZylk+Q2oiHq//vukPgfpPzChoT1I0DWnH/7qg42c6QxvsYO8VkGbks2u42RrYTHP85ZZzLIlYOaeQqu0K5ieY+usbKCnsNg4ZewCQ9l7KmYe1OrKiVC4USnFOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KJEuHZYD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dce7dd7e-d5a6-4113-894a-022c1651b6b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725926028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uApDM6EE9wYD0yo8L2knVMnA0y6Fav4QSIjUi5lz1Y8=;
	b=KJEuHZYDNOk5AblmtX8ZcnoV47coznn+uzxj7N2bAveERUvDXMigoHvy2pMBAyKgeY8fzv
	7Khm/z7Kjstz0RS0O5CnRM5SR6hOKx44RFFP1uLlVqOEJOMeIHlzjWZj8VN9RjiCii1t0s
	Jt3PRJo1iZPFwz420+QTvJkFuP8GSoc=
Date: Mon, 9 Sep 2024 19:53:43 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet count
 overflow
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andy Chiu <andy.chiu@sifive.com>
References: <20240903180059.4134461-1-sean.anderson@linux.dev>
 <MN0PR12MB595374F39CB6F68958004A9DB79C2@MN0PR12MB5953.namprd12.prod.outlook.com>
 <4e0963f5-5c27-4d65-92d2-86249f4f0870@linux.dev>
Content-Language: en-US
In-Reply-To: <4e0963f5-5c27-4d65-92d2-86249f4f0870@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/5/24 10:55, Sean Anderson wrote:
> On 9/4/24 13:19, Pandey, Radhey Shyam wrote:
>>> -----Original Message-----
>>> From: Sean Anderson <sean.anderson@linux.dev>
>>> Sent: Tuesday, September 3, 2024 11:31 PM
>>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
>>> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>>> netdev@vger.kernel.org
>>> Cc: Simek, Michal <michal.simek@amd.com>; linux-arm-
>>> kernel@lists.infradead.org; Ariane Keller <ariane.keller@tik.ee.ethz.ch>;
>>> linux-kernel@vger.kernel.org; Daniel Borkmann <daniel@iogearbox.net>;
>>> Andy Chiu <andy.chiu@sifive.com>; Sean Anderson
>>> <sean.anderson@linux.dev>
>>> Subject: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet count
>>> overflow
>>> 
>>> If coalesce_count is greater than 255 it will not fit in the register and
>>> will overflow. Clamp it to 255 for more-predictable results.
>>> 
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet
>>> driver")
>>> ---
>>> 
>>>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>>> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>>> index 9aeb7b9f3ae4..5f27fc1c4375 100644
>>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>>> @@ -252,7 +252,8 @@ static u32 axienet_usec_to_timer(struct axienet_local
>>> *lp, u32 coalesce_usec)
>>>  static void axienet_dma_start(struct axienet_local *lp)
>>>  {
>>>  	/* Start updating the Rx channel control register */
>>> -	lp->rx_dma_cr = (lp->coalesce_count_rx <<
>>> XAXIDMA_COALESCE_SHIFT) |
>>> +	lp->rx_dma_cr = (min(lp->coalesce_count_rx, 255) <<
>>> +			 XAXIDMA_COALESCE_SHIFT) |
>>>  			XAXIDMA_IRQ_IOC_MASK |
>> 
>> Instead of every time clamping coalesce_count_rx on read I think better 
>> to do it place where it set in axienet_ethtools_set_coalesce()? It would
>> also represent the coalesce count state that is reported by get_coalesce()
>> and same is being used in programming.
> 
> The parameter which will be trickier is the timer, which is also clamped
> but depends on the (DMA) clock speed. So theoretically it may be
> different if the clock gets changed at runtime between when we set
> coalesce and when we apply it. But do we even support dynamic rate
> changes for that clock?
> 
> In either case, I think this will be easier to do as part of [1], since I
> am already rearranging the calculation in that patch.

Implemented as https://lore.kernel.org/netdev/20240909235208.1331065-6-sean.anderson@linux.dev/

--Sean

> --Sean
> 
> [1] https://lore.kernel.org/netdev/20240903192524.4158713-2-sean.anderson@linux.dev/
> 
>>> XAXIDMA_IRQ_ERROR_MASK;
>>>  	/* Only set interrupt delay timer if not generating an interrupt on
>>>  	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
>>> @@ -264,7 +265,8 @@ static void axienet_dma_start(struct axienet_local
>>> *lp)
>>>  	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>>> 
>>>  	/* Start updating the Tx channel control register */
>>> -	lp->tx_dma_cr = (lp->coalesce_count_tx <<
>>> XAXIDMA_COALESCE_SHIFT) |
>>> +	lp->tx_dma_cr = (min(lp->coalesce_count_tx, 255) <<
>>> +			 XAXIDMA_COALESCE_SHIFT) |
>>>  			XAXIDMA_IRQ_IOC_MASK |
>>> XAXIDMA_IRQ_ERROR_MASK;
>>>  	/* Only set interrupt delay timer if not generating an interrupt on
>>>  	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
>>> --
>>> 2.35.1.1320.gc452695387.dirty
>> 


