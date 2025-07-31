Return-Path: <netdev+bounces-211142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B709BB16E1D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC25A7A1EFD
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866827BF95;
	Thu, 31 Jul 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="H72m+yrc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C29242907
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952840; cv=none; b=VBPeNCGQaF5yynbVXbape52YDyCWs4gGZlbY1isRBrJ+OXSsLCY5c1UZO10vC8TUvCrnqZH8n07IVio4/0pPBQw9DeZWJ/bUYshiTI2FRCa1vYLjPEf5fbHlLPsoiCJcy0euaS9jJHOmS+VH9ZE4n4cOki4hmH2G4/7wa1iv3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952840; c=relaxed/simple;
	bh=WcDfXVLMMz8sgX9OeZwUfq7M7Rtbqrz5/Fp+VLACIiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbKXkldTskCvOeleUxNdfXHCTuUnS8HOGmUqL6UolAUGPkQbXcWC2LR88FV083ebY/FN8xXzkeKQypGPIZm1bMVAnpHpmIcNHJKH2puCBqp3kpObwQShVXfrpBePPMMg12aDMCrdYfPy0UPBqJN0fUITIoBcLN5hgv7SHKOVbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=H72m+yrc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so266409a12.2
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753952837; x=1754557637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9+jJCHRVMdv8TOL3dTnaLXuCseXbSFSKejYbGwQdjc=;
        b=H72m+yrcsqpi4jsG+QwMeObofFyiYX7ttOm8+J9gXpRPanemwTsBfHXV7h0qbUDn7j
         r9y7iLfvcjs7/OrS9q3pVj7n/0TWnoWTYFU4y0rJIHUcKhxPLrCWjXMbPnKSMYEaAXi+
         vHY51gPw0f/6PC4vemA1cTQAPUEkoChihOC9Lzky8dme/Ak2Ca/9b2fMc2G/bPvj3MWQ
         V/v0P0xCynXzbfEZm6vl+QvME7wxZuDhL1HIkq1pq0TpVV24c51xBUTKVaObUPIy8atD
         WQxFcgfZeK7Hb70n6EQuU0E3Zpd+K9ttPeV42ETqIl177SogsS+8+ljibZXDJXIPqOBG
         oa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952837; x=1754557637;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9+jJCHRVMdv8TOL3dTnaLXuCseXbSFSKejYbGwQdjc=;
        b=s/ob5EEnjABdqqCB599+E9j30XHs0Mje1mN32H9xbzYag7nOG2XJdDDpVX4FRT71NG
         +d65++iCLTaLwMcjc30CZHQzb7x8zbmMyKlhKErcadPbOvMHm9Ey5OHL82xkLdgZqjDG
         nPnsBlLYh1fnCOmdOpxB+yUG6ELzu0Ap2VFwbYTimV//TllJ9GEE7Q0T3oh5JFNKpdFQ
         nEvQkC2i4ptk82nxP0e8BtQFgU/hRFwaEgo31hwLOeWAsMw5ZtVyk5hCKPr+NyRGtPHa
         Hyen2eickhIV3Qe1vpdrSJX28tEAv+7zc1/JtqjnupFxpqTpJqNZDAB+YWy91oT10VV+
         f7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUsIFbmKJVbLz4IecG2B+OT/nzQJRog7jIs0vAYNu3rYJQJVJDgbMPvbi5LByPLvhIYUH2rdfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8ZisntJfzf/xqPfqyXJzgxmtepNd4dPVR5cDfvB96oP2/lQ8
	O1e642zVKM4Q3gklmeFNft9SUEq8rNa4bCzJOJMrbTND76TY2Un/TCurb79D6h5MR8A=
X-Gm-Gg: ASbGnctHvsac4+gAES6xbtDcrwUUxU0CglXCHwakV2XbqkUde5/QTCHPSlcaO/CsE82
	7VN2/gDcOE9DKriJEMhj30AXcVXqbLmeDSJRiNssNbfvPaG4OS+HnOIC9bWRM2iOebISZ1epJ5r
	wTV7ao2BpkLFQ9v0/HO6NEyS+HKZURatBu77DNzKJg4nI8jMYhS/cy2z074+qdKB0PW/C9iraMw
	hDR2H8xbNo9At9CkdKouURzw7J9iKndUziWJXn/S6kb1WiI6BthaKx/V5GHigrmJxxS63nSmErZ
	9DSoBByeoTABsjD+SFgjgefQiYe78WBtjsCMHTIT52j/vgp8yYnxF/FzpQ1ei9NOB641JZFgYqB
	kPP7pthqpuwLqr8uiYcgdnpdLLmwU0Q==
X-Google-Smtp-Source: AGHT+IE997x8nYTycvu/BnY+UyTrfIr0figlCHBXehZMXWgIeEYUDt6OKtoUMSjGpZcVTqZcAvbR1g==
X-Received: by 2002:a05:6402:2802:b0:615:f76:9408 with SMTP id 4fb4d7f45d1cf-6158727399bmr6963737a12.32.1753952836898;
        Thu, 31 Jul 2025 02:07:16 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7ac0sm797219a12.35.2025.07.31.02.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:07:16 -0700 (PDT)
Message-ID: <61d545dd-c32c-4cc3-94fb-53954eee365b@tuxon.dev>
Date: Thu, 31 Jul 2025 12:07:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE
 command offload support
To: "Karumanchi, Vineeth" <vineeth@amd.com>, vineeth.karumanchi@amd.com,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-4-vineeth.karumanchi@amd.com>
 <64481774-9791-4453-ab81-e4f0c444a2a6@tuxon.dev>
 <c296f03f-0146-4416-94ca-df262aa359d4@amd.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <c296f03f-0146-4416-94ca-df262aa359d4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29.07.2025 11:59, Karumanchi, Vineeth wrote:
> Hi Claudiu,
> 
> Thanks for the review.
> 
> On 7/26/2025 5:55 PM, claudiu beznea (tuxon) wrote:
>>
>>
>> On 7/22/25 18:41, Vineeth Karumanchi wrote:
>>> Implement Time-Aware Traffic Scheduling (TAPRIO) hardware offload for
> 
> <..>
> 
>>
>> as it is used along with conf->num_entries which has size_t type.
>>
>>> +
>>> +    /* Validate queue configuration */
>>> +    if (bp->num_queues < 1 || bp->num_queues > MACB_MAX_QUEUES) {
>>
>> Can this happen?
> 
> Yes, GEM in Zynq devices has single queue.

I was asking as it looked to me that this validates the number of queues
the IP supports, which should have already been validated in probe.

> 
> Currently, TAPRIO offload validation depends solely on the presence
> of .ndo_setup_tc. On Zynq-based devices, if the user configures the
> scheduler using tc replace, the operation fails at this point.

I can't see how. That should translate into:

if (1 < 1 || 1 > 8)

which is in the end:

if (0)

Maybe it fails due to some other condition?

> 
> <...>
> 
>>> +    /* All validations passed - proceed with hardware configuration */
>>> +    spin_lock_irqsave(&bp->lock, flags);
>>
>> You can use guard(spinlock_irqsave)(&bp->lock) or
>> scoped_guard(spinlock_irqsave, &bp->lock)
>>
> 
> ok, will leverage scoped_guard(spinlock_irqsave, &bp->lock).
> 
>>> +
>>> +    /* Disable ENST queues if running before configuring */
>>> +    if (gem_readl(bp, ENST_CONTROL))
>>
>> Is this read necessary?
>>
> 
> Not necessary, I thought of disabling only if enabled.
> But, will disable directly.
> 
>>> +        gem_writel(bp, ENST_CONTROL,
>>> +               GENMASK(bp->num_queues - 1, 0) <<
>>> GEM_ENST_DISABLE_QUEUE_OFFSET);
>>
>> This could be replaced by GEM_BF(GENMASK(...), ENST_DISABLE_QUEUE) if you
>> define GEM_ENST_DISABLE_QUEUE_SIZE along with GEM_ENST_DISABLE_QUEUE_OFFSET.
>>
> 
> I can leverage bp->queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET.
> And remove GEM_ENST_ENABLE_QUEUE(hw_q) and GEM_ENST_DISABLE_QUEUE(hw_q)
> implementations.
> 
>>> +
>>> +    for (i = 0; i < conf->num_entries; i++) {
>>> +        queue = &bp->queues[enst_queue[i].queue_id];
>>> +        /* Configure queue timing registers */
>>> +        queue_writel(queue, ENST_START_TIME,
>>> enst_queue[i].start_time_mask);
>>> +        queue_writel(queue, ENST_ON_TIME, enst_queue[i].on_time_bytes);
>>> +        queue_writel(queue, ENST_OFF_TIME, enst_queue[i].off_time_bytes);
>>> +    }
>>> +
>>> +    /* Enable ENST for all configured queues in one write */
>>> +    gem_writel(bp, ENST_CONTROL, configured_queues);
>>
>> Can this function be executed while other queues are configured? If so,
>> would the configured_queues contains it (as well as conf)?
>>
> 
> No, the tc add/replace command re-configures all queues, replacing any
> previous setup. Parameters such as START_TIME, ON_TIME, and CYCLE_TIME are
> recalculated based on the new configuration.
> 
>>> +    spin_unlock_irqrestore(&bp->lock, flags);
>>> +
>>> +    netdev_info(ndev, "TAPRIO configuration completed successfully: %lu
>>> entries, %d queues configured\n",
>>> +            conf->num_entries, hweight32(configured_queues));
>>> +
>>> +cleanup:
>>> +    kfree(enst_queue);
>>
>> With the suggestions above, this could be dropped.
>>
> 
> ok.

Please check the documentation pointed by Andrew. With that, my suggestion
here should be dropped.

Thank you,
Claudiu

> 
> 
>> Thank you,
>> Claudiu
>>
>>> +    return err;
>>> +}
>>> +
>>>   static const struct net_device_ops macb_netdev_ops = {
>>>       .ndo_open        = macb_open,
>>>       .ndo_stop        = macb_close,
>>
> 
> Thanks


