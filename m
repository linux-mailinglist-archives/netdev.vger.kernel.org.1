Return-Path: <netdev+bounces-161780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315BA23F2D
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB5518830C0
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C261A1C549F;
	Fri, 31 Jan 2025 14:33:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179E145324;
	Fri, 31 Jan 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334017; cv=none; b=a/lARPn/pNdJEBb95UsjkDQ3Ao3vJqdeifa69rQOWjvXAEBLIcXWE7kLbjK4Y+gD8Br+YUXXkHhlzwS8EQx9AETd54rWAvRn0P2NCIuf9/LeQgJ+twi2LYqKftMbo9QaHtNBEXBq8TfeKXCbtxPu/g3U9r89lTOuBy58CHI0hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334017; c=relaxed/simple;
	bh=sfuDMHK03L+lxZO9cgvV2b65w1whAGRAJRKpHZPv1qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPsdHFwUEaX0rcboZuNDcscpKf07VRcH3bden1iGPwr4ggNkm2y2WJ0/i0l+i5CUbb4hq3EeWXfSSvcblAenw+DEDqexKGj2JqGzz0/E92gCvKsgjL3YMqK0i3HddlWz/hw72i+5Sx8L8G5SSt64/KJ7nYwE1t8xCIIYdy/GdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB58497;
	Fri, 31 Jan 2025 06:33:59 -0800 (PST)
Received: from [10.1.32.52] (e122027.cambridge.arm.com [10.1.32.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6109E3F63F;
	Fri, 31 Jan 2025 06:33:30 -0800 (PST)
Message-ID: <f343c126-fed9-4209-a18d-61a4e604db2f@arm.com>
Date: Fri, 31 Jan 2025 14:33:28 +0000
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
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <fc08926d-b9af-428f-8811-4bfe08acc5b7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2025 14:15, Andrew Lunn wrote:
> On Fri, Jan 31, 2025 at 09:46:41AM +0000, Steven Price wrote:
>> On 27/01/2025 01:38, Kunihiko Hayashi wrote:
>>> When Tx/Rx FIFO size is not specified in advance, the driver checks if
>>> the value is zero and sets the hardware capability value in functions
>>> where that value is used.
>>>
>>> Consolidate the check and settings into function stmmac_hw_init() and
>>> remove redundant other statements.
>>>
>>> If FIFO size is zero and the hardware capability also doesn't have upper
>>> limit values, return with an error message.
>>
>> This patch breaks my Firefly RK3288 board. It appears that all of the 
>> following are true:
>>
>>  * priv->plat->rx_fifo_size == 0
>>  * priv->dma_cap.rx_fifo_size == 0
>>  * priv->plat->tx_fifo_size == 0
>>  * priv->dma_cap.tx_fifo_size == 0
>>
>> Simply removing the "return -ENODEV" lines gets this platform working 
>> again (and AFAICT matches the behaviour before this patch was applied).
>> I'm not sure whether this points to another bug causing these to 
>> all be zero or if this is just an oversight. The below patch gets my 
>> board working:
> 
> Thanks for the quick report of the problem.
> 
> Your 'fix' basically just reverts the patch. Let first try to
> understand what is going on, and fix the patch. We can do a revert
> later if we cannot find a better solution.

Sure thing - I wasn't entirely sure if the patch was just to 'tidy up'
the code (in which case my code keeps the consolidation). I'm not
familiar with this area so I'll let you figure out if there's a better
solution.

> I'm guessing, but in your setup, i assume the value is never written
> to a register, hence 0 is O.K. e.g. dwmac1000_dma_operation_mode_rx(),
> the fifosz value is used to determine if flow control can be used, but
> is otherwise ignored.

I haven't traced the code, but that fits my assumptions too.

> We should determine which versions of stmmac actually need values, and
> limit the test to those versions.

If you want me to try out a patch or do any more investigations then
just let me know.

Thanks,

Steve


