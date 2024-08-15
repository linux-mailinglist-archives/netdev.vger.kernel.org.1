Return-Path: <netdev+bounces-118888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217CE9536D7
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89D31F221F3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B49D1AC437;
	Thu, 15 Aug 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J2ulUT7I"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393EB1AAE07
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734890; cv=none; b=DeQBaCcZg3IdeJAUl4h1WdJ1Vi7HCJmFMpmZ12iy315TqZUg4b8NzFulla+W2jUEn9Rp3SQPuAxG5NwUh15urlEykLeNaZIpqLjon9ZOAyG0qsloxA+BX4IkFTpoaepQb5md3aVWziqTGeO6OfqknETiLfsIc48rfJJr4u//Qpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734890; c=relaxed/simple;
	bh=lATk9NyYj8KiOp9IYlQp+ixy+U51+JVo7B2PtSMiGwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBpFrnSl2WhmeRZySfuzbkMzRlUUiBsxSvFqMERYOu5KP4p5F2N+CUbMlkPCPeAQI8uUTRfXEFyEwDoqWqjzn+Iei05WF681eAcRruse0X6xy8zUWlFGQa2n9r8IR7BKHvJjlvlTSWBMaImVCI5wvGkpJmhclmVD05yO7I6yWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J2ulUT7I; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d67d2b0-e4bd-466a-ad60-e40d4b1fc4e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723734886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypH/0neTHZJ3Pfc3D7w4cPCJLE+iJfGOt4G/6i26Wa0=;
	b=J2ulUT7IVpaDBwKRuNBIsZQ8U0H6wXc1MsYkMQQiAUyGG3wSgUcYjWhW0HeuDBzxF1WgTq
	vDNgrW67em5uaDTBjMZHr68ZhcX6YZSz0PM26VTMiayHec07SlRSI3wuy0JJj6dvDUmN5f
	+IE98CpDJQkzv7ce733R8uA91BSnnWk=
Date: Thu, 15 Aug 2024 11:14:41 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/4] net: xilinx: axienet: Always disable
 promiscuous mode
To: Simon Horman <horms@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>,
 Ariane Keller <ariane.keller@tik.ee.ethz.ch>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
 <20240812200437.3581990-2-sean.anderson@linux.dev>
 <20240815145832.GG632411@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240815145832.GG632411@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/15/24 10:58, Simon Horman wrote:
> On Mon, Aug 12, 2024 at 04:04:34PM -0400, Sean Anderson wrote:
>> If prmiscuous mode is disabled when there are fewer than four multicast
>> addresses, then it will to be reflected in the hardware. Fix this by
>> always clearing the promiscuous mode flag even when we program multicast
>> addresses.
>> 
>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index ca04c298daa2..e664611c29cf 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -451,6 +451,10 @@ static void axienet_set_multicast_list(struct net_device *ndev)
>>  	} else if (!netdev_mc_empty(ndev)) {
>>  		struct netdev_hw_addr *ha;
>>  
>> +		reg = axienet_ior(lp, XAE_FMI_OFFSET);
>> +		reg &= ~XAE_FMI_PM_MASK;
>> +		axienet_iow(lp, XAE_FMI_OFFSET, reg);
>> +
> 
> Hi Sean,
> 
> I notice that this replicates code in another part of this function.
> And that is then factored out into common code as part of the last
> patch of this series.
> 
> I guess that it is in the wash, but perhaps it would
> be nicer to factor out the common promisc mode setting code
> as part of this patch.
> 
> Otherwise, this LGTM.

I thought about doing that, but it would have required changing the
indentation of ~10 lines and I thought it would be easier to review
the patch without that noise.

--Sean


