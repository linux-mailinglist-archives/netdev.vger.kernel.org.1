Return-Path: <netdev+bounces-217943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B002FB3A7AF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B65E3A257D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25115335BAE;
	Thu, 28 Aug 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qVEWwtd9"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2BB335BAD
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401598; cv=none; b=Vr6t9otUjTSFWMNHGsXWAbHJYDgtQ+k59kycNjs4iW3956jyki+xk4/R9lPGrRgN9ypb79pbLOJeMeHpq/hshLB/xKk8k8RGPTVIv4I5ZYlNa8VBIxM8ak0D5YnP7L/OG44XEGfHK3tI7VZQI+pZOE+0rEYDiBKrMB1hG012k0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401598; c=relaxed/simple;
	bh=VNDRFOm6iD0Frw1D88ZQaVB/vKrn9vS5tlXTgHOkvcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2PU+YMsjxER0P0g1cPT2H9njVrw5hYPWVF9PNQhbu4gTa89goNOBZWSfJ81as77r1HvbqOetdLjAoy79fKoeadkuzHk7eWccffDyL1ql+BkDvTP87CtS0jlXRb4Fqd+XowOrc/d05lUYM3N7oF/ipbutcEAczyyEsTaIZ/H9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qVEWwtd9; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4e5cc2c-ca62-467c-9b58-52831ebeb032@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756401593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyHKGykIxOwM8LqQ483zBF7dyZd7CrXVY89y5CfS7A4=;
	b=qVEWwtd9ZgjaNvp1q7hz6fuVvkWUE4DwWZ8LuGnemPwGykGEdnZNZNU5JsDgD8ECKrThYt
	lQVxHozdOUCM8EN2pRumAHq1oVP8vyJ2tY+gwmtXm9PVGpLIFo/w46urDhYk8hawvzdIR2
	+kb+jtWv8PTdwJETT3GLjh6Mw7jC9Lo=
Date: Thu, 28 Aug 2025 13:19:41 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: macb: Fix tx_ptr_lock locking
To: Robert Hancock <robert.hancock@calian.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Cc: "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "efault@gmx.de" <efault@gmx.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>
References: <20250828160023.1505762-1-sean.anderson@linux.dev>
 <382f53239ff21a050089bcabb38d31329836ad98.camel@calian.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <382f53239ff21a050089bcabb38d31329836ad98.camel@calian.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 12:13, Robert Hancock wrote:
> On Thu, 2025-08-28 at 12:00 -0400, Sean Anderson wrote:
>> macb_start_xmit can be called with bottom-halves disabled (e.g.
>> transmitting from softirqs) as well as with interrupts disabled (with
>> netpoll). Because of this, all other functions taking tx_ptr_lock
>> must
>> disable IRQs, and macb_start_xmit must only re-enable IRQs if they
>> were already enabled.
>> 
>> Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
>> Reported-by: Mike Galbraith <efault@gmx.de>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/net/ethernet/cadence/macb_main.c | 25 ++++++++++++----------
>> --
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 16d28a8b3b56..b0a8dfa341ea 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1228,7 +1228,7 @@ static int macb_tx_complete(struct macb_queue
>> *queue, int budget)
>>         int packets = 0;
>>         u32 bytes = 0;
>> 
>> -       spin_lock(&queue->tx_ptr_lock);
>> +       spin_lock_irq(&queue->tx_ptr_lock);
>> 
> 
> Hm, I think I used a non-IRQ lock here to avoid potentially disabling
> interrupts for so long during TX completion processing. I don't think I
> considered the netpoll case where start_xmit can be called with IRQs
> disabled however. Not sure if there is a better solution to satisfy
> that case without turning IRQs off entirely here?

Well, we have a single producer (macb_start_xmit) so we don't need to
take a lock to enqueue anything as long as we add barriers in the right
places.

--Sean

