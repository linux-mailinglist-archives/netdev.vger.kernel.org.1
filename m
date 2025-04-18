Return-Path: <netdev+bounces-184239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0180FA93F90
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A1C1B604FD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C4223E344;
	Fri, 18 Apr 2025 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S89nhWD4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF42233128
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745013080; cv=none; b=IVFNQ+nmYBs4VEZA474Dz4HfKdkTL8TxvXFzJ97QYHvCfHIm9FO2mbxBfjnwZ41VpmOqrI7yyZqFewOC/f/8Z9MrgiW03xh4L2dH8fBiAAgtAub6jMnsWoO2cTh5xi791mSQ4PmcyB4FEE/rFXnowhOYHB0xdRVch++76Yej9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745013080; c=relaxed/simple;
	bh=GrsHBemAKcPjEp79d7q/z2T/hCj/jYS0Q5kxkPeU1X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAzzaqIx5f7oilxC8Xw5edWLNy4Jr9LgmZDtOELXCEo/YQ9Ue1JONcke6El8PNDS+zPxQQKBpa906EsOgkvUb3XB74WJA/3gXButMzoOHqsS+Dg+/ALLpPcae5A2Ol6fF6rmO968zZH1LdGNq4M75Ui5HoZQa7wnIa41NZSWp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S89nhWD4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac25d2b2354so344059066b.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745013077; x=1745617877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xnkI66AmqzeFP1DhNLV2M5NnL/MyznI/HJZBSUSjVOk=;
        b=S89nhWD4zZMnw46+FY5zys5/JJ5PpGPOB4zsegI9ZZeMxPsllGvDMz8X4sfrVC8oJo
         jWKYnJjX8L3UIoT8ZmAq524Pm8i4bgP3DoPYFEL5RmRrkpI5rKVWefsl2MiwPcEMWte3
         I08mYxBjOuPzzy8JkZXYqGRmcLJSKbn+ADyZ8XVqao9W9S78OLvG46gchqpOI1gQRvBu
         bFd6YqLtF2bsWFy4lXIPW29ZLpjBqbbiZ1bFgv4Xj75pTaTD+GDQnhMWPS//1Da8Nf0b
         Rnh7BDHoooy8d2antbf8g21/GqlPXu4GD/wDRWJuz4sh54RZOGVLV9xHI4xGFioqZmkO
         FfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745013077; x=1745617877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnkI66AmqzeFP1DhNLV2M5NnL/MyznI/HJZBSUSjVOk=;
        b=q4A5BizYDhEACBwmpVfgbXjUD6QOmCKff637hQ60A+N5hCq0RimXN1zdoTA0QgOhJc
         YlDp5pdp/qW9dBmKtkfP2JoQ07ZsvfY2LhYTvV8Ob3DTGVhELQooq6lOnK8PDww0bWKY
         18Jz3cgxnLTay4S5Y33c1rAjjKUsgDrt6xd0dpp3t4ZK+zimGCD+1+6TyEV6B55bts9I
         kjDFb8Abt+4TdMUhKRouPU7CpVPO3dhdujYugGzf+gQ26QMncopaaTcrKuftK+T5WdFy
         1+dWQhQbhndVF1cUhH6Qsbf5LJ4GS/qKqMK1ZF/62GyJEhXuu6hj1zBtn2Z5IYYvDmco
         CG1A==
X-Forwarded-Encrypted: i=1; AJvYcCUiKBlGzTiocWXekRopnyAEaFJzAPw5o/qoKnmAch3iW0Y2wyON/V4a29ameRBppqO1wf4BQKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpL5WqoTvUjOlwIMzU1/kCqvloPyJ5xNuq2CvopyLCumF1JZ7
	vITXEplYQ1tg/A3qWe3srO/sfYVy+dIBMgatddYOv00WLWo5IIUA
X-Gm-Gg: ASbGncu6wJFFwQZAxbbcsUdkLh6yFqbDMOWeRxFA66giBTCu793z5K8oZERjBmfEuBN
	FruokLHXyGA6u02S2NoGoaoAnis7ecZp5fCQ86ptkSJvrHMmHCNCTWkXsPX6elZfFi00qWHryNy
	j8J8fN+a0QXPfOap+kkyhYKuDKWmeYu1qIsgsTu6UymJDLEmaIUGuqmt0ZvUezsTAW6yUSy8IZe
	g/OvH3dulfXGPYG57ODOPfv9ygPc4SY0Kex5j1FOSrwah9zpYNz4EtYtBTrZSWvsA86El98efxs
	cLu8SRO4eznPtjKqvRQFESPG54GGV4Egb19vc0x4YJAZHJ3Miw8RhgEsrcaZ5ibjtci9h0kkwdy
	adrM6//uLag79QPnokaEvOR4QfDNgUSdFmQxhgaOcNKNPjOUYzBH8xQaLTNM3XBp/wcNvtb2v+9
	1ty97g890czooMxXYDCWimzemoLXmORev1P9ppvK7QOW0=
X-Google-Smtp-Source: AGHT+IG965aWjwot/tkHn0rcpwwRRjuq8Z0SBw25Nv196euYu+oku2K7RtK3EdmZS327/mXLNI0+Pg==
X-Received: by 2002:a17:907:3fa7:b0:ac7:1350:e878 with SMTP id a640c23a62f3a-acb74d83ca0mr342638466b.46.1745013076370;
        Fri, 18 Apr 2025 14:51:16 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a14c:6800:4989:13c4:80b7:6063? (dynamic-2a02-3100-a14c-6800-4989-13c4-80b7-6063.310.pool.telefonica.de. [2a02:3100:a14c:6800:4989:13c4:80b7:6063])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acb6ef475ccsm169382466b.137.2025.04.18.14.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 14:51:15 -0700 (PDT)
Message-ID: <74a498d0-343f-46f1-ad95-2651d960d657@gmail.com>
Date: Fri, 18 Apr 2025 23:52:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com> <Z_-7I26WVApG98Ej@ryzen>
 <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
 <Z__U2O2xetryAK_E@ryzen>
 <jikqc7fz4nmwd3ol4f2uazcjc3zgtbtzcrudhsccmvfm3pjbfk@mkcj6gnkrljj>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <jikqc7fz4nmwd3ol4f2uazcjc3zgtbtzcrudhsccmvfm3pjbfk@mkcj6gnkrljj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.04.2025 19:19, Manivannan Sadhasivam wrote:
> On Wed, Apr 16, 2025 at 06:03:36PM +0200, Niklas Cassel wrote:
>> Hello Krishna Chaitanya,
>>
>> On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
>>> On 4/16/2025 7:43 PM, Niklas Cassel wrote:
>>>>
>>>> So perhaps we should hold off with this patch.
>>>>
>>> I disagree on this, it might be causing issue with net driver, but we
>>> might face some other issues as explained above if we don't call
>>> pci_stop_root_bus().
>>
>> When I wrote hold off with this patch, I meant the patch in $subject,
>> not your patch.
>>
>>
>> When it comes to your patch, I think that the commit log needs to explain
>> why it is so special.
>>
>> Because AFAICT, all other PCIe controller drivers call pci_stop_root_bus()
>> in the .remove() callback, not in the .shutdown() callback.
>>
> 
> And this driver is special because, it has no 'remove()' callback as it
> implements an irqchip controller. So we have to shutdown the devices cleanly in
> the 'shutdown' callback.
> 
Doing proper cleanup in a first place is responsibility of the respective bus
devices (in their shutdown() callback).

Calling pci_stop_root_bus() in the pci controllers shutdown() causes the bus
devices to be removed, hence their remove() is called. Typically devices
don't expect that remove() is called after shutdown(). This may cause issues
if e.g. shutdown() sets a device to D3cold. remove() won't expect that device
is inaccessible.

Another issue is with devices being wake-up sources. If wake-up is enabled,
then devices configure the wake-up in their shutdown() callback. Calling
remove() afterwards may reverse parts of the wake-up configuration.
And I'd expect that most wakeup-capable device disable wakeup in the
remove() callback. So there's a good chance that the proposed change breaks
wake-up.

There maybe other side effects I'm not aware of.

IMO a controller drivers shutdown() shall focus on cleanup up its own resources.

> Also do note that the driver core will not call the 'remove()' callback unless
> the driver as a module is unloaded during poweroff/reboot scenarios. So the
> controller drivers need to properly power down the devices in their 'shutdown()'
> callback IMO.
> 
>> Doing things differently from all other PCIe controller drivers is usually
>> a red flag.
>>
> 
> Yes, even if it is the right thing to do ;) But I agree that the commit message
> needs some improvement.
> 
> - Mani
> 


