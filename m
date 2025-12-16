Return-Path: <netdev+bounces-244951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E5CC3C7D
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79BA231BA438
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09234D90C;
	Tue, 16 Dec 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iy7oveTE"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103A33D501
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896509; cv=none; b=Kq8sYI0WT/JHUINGJapDMdcGRXE768LrOjSXgOa5Lh/xBfeyROFVoBaR5RUW23zpoNddBmE76l4zYBRnTuqvHXBrQxCXbmYSWSUHBUVGJfx3l2WNBXqlRWskpocchnKOt2v4tcLkfb2iGZvygDxku5rHM0w5VH0RPyRwljgAnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896509; c=relaxed/simple;
	bh=TzHzxZtoxbC+9DYF3XhCgirxsG9smEHR7iYZ/6gtNQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDFNqnKDJiT44Gg/GgbFZpBYTCKSGE8n7r6RTlmr5YgxMsMIQ2M7yMP8dPBB1zLGnDdXYV6CAXR4QSwN/zAoObadBHa9lTypjz8rts7mqtAkzHvGy5in9pHlQsmHauazQ6ylwlcLcMG92HI8AZx0B5gLuW+aAbIKB6vaXe7/mG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iy7oveTE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <540737b2-f155-4c55-ab95-b18f113e0031@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765896492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2D/ob5yIVb7qub0SeY7blQIeUFxiZ9h57KLPeQrxZ/w=;
	b=iy7oveTEd8UA8a5GYnnZLI0WInS4zo1ZY/C3kCe/tTH/iv2V5fGlkFW+cGmKPtvkuIo6tu
	iio2LdBBgg7JjQ+NVZ6MnD2z87Kk+vp4xLR85gMQEHwARVKYb9+8I7JRYkB6ofQMZ7Gu6u
	YhMTfJeHRJ7Y7yv5CQBQMWd2Wsz+liQ=
Date: Tue, 16 Dec 2025 09:48:00 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 1/7] net: axienet: Fix resource release
 ordering
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Simek, Michal" <michal.simek@amd.com>, Leon Romanovsky <leon@kernel.org>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-2-sean.anderson@linux.dev>
 <9572f798-d294-4f24-8acb-c7972c1db247@lunn.ch>
 <SA1PR12MB6798CD01D26F4A68D6F7A214C9AAA@SA1PR12MB6798.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <SA1PR12MB6798CD01D26F4A68D6F7A214C9AAA@SA1PR12MB6798.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/16/25 06:53, Gupta, Suraj wrote:
> [Public]
> 
> Hi,
>> -----Original Message-----
>> From: Andrew Lunn <andrew@lunn.ch>
>> Sent: Wednesday, August 6, 2025 2:29 AM
>> To: Sean Anderson <sean.anderson@linux.dev>
>> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Andrew Lunn
>> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; Simek, Michal <michal.simek@amd.com>;
>> Leon Romanovsky <leon@kernel.org>; Gupta, Suraj <Suraj.Gupta2@amd.com>
>> Subject: Re: [PATCH net-next v4 1/7] net: axienet: Fix resource release ordering
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> > +static void axienet_disable_misc(void *clocks) {
>> > +     clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, clocks); }
>> > +
>>
>> ...
>>
>> >       ret = devm_clk_bulk_get_optional(&pdev->dev, XAE_NUM_MISC_CLOCKS,
>> lp->misc_clks);
>> >       if (ret)
>> > -             goto cleanup_clk;
>> > +             return dev_err_probe(&pdev->dev, ret,
>> > +                                  "could not get misc. clocks\n");
>> >
>> >       ret = clk_bulk_prepare_enable(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
>> >       if (ret)
>> > -             goto cleanup_clk;
>> > +             return dev_err_probe(&pdev->dev, ret,
>> > +                                  "could not enable misc. clocks\n");
>> > +
>> > +     ret = devm_add_action_or_reset(&pdev->dev, axienet_disable_misc,
>> > +                                    lp->misc_clks);
>>
>> It seems like it would be better to add
>> devm_clk_bulk_get_optional_enable(). There is already an
>> devm_clk_bulk_get_all_enabled() so it does not seem like too big a step.
>>
>>         Andrew
> 
> We are interested in this patch to fix AXI Ethernet probe path and can collaborate on upstreaming it.

Feel free to modify it as suggested by Andrew.

Unfortunately I have not had time to work on this series recently and probably
won't be able to return to it for another few months.

--Sean

