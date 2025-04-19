Return-Path: <netdev+bounces-184279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713A8A942C7
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 12:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B085179238
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05019F40A;
	Sat, 19 Apr 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8VBtJ+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F7101E6
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745057874; cv=none; b=ghTwHzevD7Y6Z1O0nyxmDWr49Gsyvvas9HHNzT1FLae5YngV1VtMfpUiwV2dBt7sZunt0qMY5GccGlEM06FwMBx4aATifGPTREShiRg6Te7T3JtcCPid4aAlJbFxQv1/QKM0AyXvC4FpQ2/ExmF2DCBnOxjdTDsg+pbg2XF7IjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745057874; c=relaxed/simple;
	bh=DFmfQyjeHJ7bfiI36mFHgBSik06z7guSQcoYQuae2TE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Btbezgr6CG+HDPZflWy4ZrycFDh9zYrMZPiNsuHLGUiSs8QrzOVVJAqu7dQtwDHlTzJ1c/ve0GF3SdmskcGc7YTxgaRwoiQXOWnzQiXbGfaSEXyOB36k1bz2abWBk7x06Re9B24iULJYLKnkIyo07RdET29VSnGMipmL3UrucEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8VBtJ+W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so16265765e9.0
        for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745057871; x=1745662671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KSo1cNOJwPbZx1fX49/4EsgJSJq0HzRO+XW2qZMzTr0=;
        b=U8VBtJ+WASA3V3bbKlxLInV9zp67BoxOlUy849nCTrA7HSP+z3lGc3DoJ4J8I6ZRoX
         /9+2q42WuWXBrbvREBr4v4hbKa5I+sNAiDrdEm/Pzfe3OxYdaQGU0h4ZvRYttRQv9pIi
         ef7Q8AMWC2sYyKkbuE6N0kUTLeZLW9oqxkc2RoF3WWi4YyI22F5ned4Wuv4DQ5QaIs9a
         Cx0zhJjqQDtqZZzkWR+BBM/UJOdSlg6YCAzf0gKCueG718BaSLdEhCdpP9YrNjnFL3dw
         0bHpDiXvbcCEREkjsT5/ju4kZYPMz+baLC2ahSPukE6andf4I4TRRnehIgV6bap1nfzf
         5a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745057871; x=1745662671;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSo1cNOJwPbZx1fX49/4EsgJSJq0HzRO+XW2qZMzTr0=;
        b=ibfew1W6bGb+V3QJ57VW09NmKtp6tK5y4oYY6N4O3qztPiZfeHgZDE7VFKlaoYXycL
         8pRv7nK93SM0UMJr071thaXPhfP1f6nAaAXHd9deg0v8bHhx2JIFqyUJNcX/VPy9fuYh
         goO1tTe15PDKSsZwbl1OZF1O8CI2sOWpfxUphFZ1y8gmm9rT59AqAbYv7BzIvj/BGAez
         hwfOpaueSITQkeFRab0HEDYOP9RplkzrvIRVwNhUCcOMgTdp/rEVHQiX47c5z73Dcu3E
         Wit+5OCfBI0TatuLDxemLjDtPsDHn1l1P/EcJuhoHlWdpoiv3zK2qQATcK3rD2T5gSOc
         l4hQ==
X-Forwarded-Encrypted: i=1; AJvYcCU68g7P8bNOs9L+9IanQtKjDXgzVoaEQby3RhzI0o5EMGrbRiKOmcJ9eyJB2KD3flLJkCWN9DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWpOhLjgL5lpraYZgv/a52HU8j/7Zmkg/FKwnfO3BO+eAY+TH
	oQrM+mC7exsLNgP4G/4T/IOMUT5wv9HDc8B3eBryclJ1J9F3onAc
X-Gm-Gg: ASbGncs0BhBWJMuf9+QATvOWJr0SJF0eevzGo+26qCdm9QgevTc77F31aMpeV2MAfPV
	uz2cv0HUKBs2gf2jMo+Mo7gKR7CoH51mR9Y+mOrQZW1ry5s82uIbdf63YhUq2xvmYhBm2HK7p+8
	yUm1pWSnC3ZUWx9QH7RoPKZIUehCSVs823tjJnPRkTf/VOFtXm3TsPPYCkYQCm6pRU9WxSbJaMi
	QxKcSmOL1EsOUMnGYXFop6rTeqZ6vy4KblmEXxLzX158Epk+ZVvikPaG1PoVcyiG/Fkhep5n3ug
	7Wvz0d3mdyQzfuwiyaMeyY5nOicGOjDp63CzZfb3vXp9xGZ0aOaxjdpI0X6JBSgt9nPZM6Z48rE
	N+6QG55zp1OUj5BJ45On3v+tOrGcnGeWYz6us9UQ+6zkeS7PezG6dtYssuWW3nsHYabjA25ihlt
	DD3iYNJO6LtDv2W9ezWZ0FDAk5rlNHLQ==
X-Google-Smtp-Source: AGHT+IE5brrY5gOj5o9Aa4nj537HdzkAyEZRy5PWb6jRm/earssbV/qfrluL+F/AHiGpAJKI6tFFJQ==
X-Received: by 2002:a05:600c:510d:b0:43c:f78d:82eb with SMTP id 5b1f17b1804b1-4406abb2066mr50538745e9.15.1745057870853;
        Sat, 19 Apr 2025 03:17:50 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a996:b100:163:40c8:c663:6652? (dynamic-2a02-3100-a996-b100-0163-40c8-c663-6652.310.pool.telefonica.de. [2a02:3100:a996:b100:163:40c8:c663:6652])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d56328asm55583275e9.0.2025.04.19.03.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 03:17:49 -0700 (PDT)
Message-ID: <9e9854d5-1722-40f2-b343-97cf9b23a977@gmail.com>
Date: Sat, 19 Apr 2025 12:18:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com> <Z_-7I26WVApG98Ej@ryzen>
 <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
 <Z__U2O2xetryAK_E@ryzen>
 <jikqc7fz4nmwd3ol4f2uazcjc3zgtbtzcrudhsccmvfm3pjbfk@mkcj6gnkrljj>
 <74a498d0-343f-46f1-ad95-2651d960d657@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <74a498d0-343f-46f1-ad95-2651d960d657@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.04.2025 23:52, Heiner Kallweit wrote:
> On 18.04.2025 19:19, Manivannan Sadhasivam wrote:
>> On Wed, Apr 16, 2025 at 06:03:36PM +0200, Niklas Cassel wrote:
>>> Hello Krishna Chaitanya,
>>>
>>> On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
>>>> On 4/16/2025 7:43 PM, Niklas Cassel wrote:
>>>>>
>>>>> So perhaps we should hold off with this patch.
>>>>>
>>>> I disagree on this, it might be causing issue with net driver, but we
>>>> might face some other issues as explained above if we don't call
>>>> pci_stop_root_bus().
>>>
>>> When I wrote hold off with this patch, I meant the patch in $subject,
>>> not your patch.
>>>
>>>
>>> When it comes to your patch, I think that the commit log needs to explain
>>> why it is so special.
>>>
>>> Because AFAICT, all other PCIe controller drivers call pci_stop_root_bus()
>>> in the .remove() callback, not in the .shutdown() callback.
>>>
>>
>> And this driver is special because, it has no 'remove()' callback as it
>> implements an irqchip controller. So we have to shutdown the devices cleanly in
>> the 'shutdown' callback.
>>
> Doing proper cleanup in a first place is responsibility of the respective bus
> devices (in their shutdown() callback).
> 
> Calling pci_stop_root_bus() in the pci controllers shutdown() causes the bus
> devices to be removed, hence their remove() is called. Typically devices
> don't expect that remove() is called after shutdown(). This may cause issues
> if e.g. shutdown() sets a device to D3cold. remove() won't expect that device
> is inaccessible.
> 
> Another issue is with devices being wake-up sources. If wake-up is enabled,
> then devices configure the wake-up in their shutdown() callback. Calling
> remove() afterwards may reverse parts of the wake-up configuration.
> And I'd expect that most wakeup-capable device disable wakeup in the
> remove() callback. So there's a good chance that the proposed change breaks
> wake-up.
> 
> There maybe other side effects I'm not aware of.
> 
> IMO a controller drivers shutdown() shall focus on cleanup up its own resources.
> 
>> Also do note that the driver core will not call the 'remove()' callback unless
>> the driver as a module is unloaded during poweroff/reboot scenarios. So the
>> controller drivers need to properly power down the devices in their 'shutdown()'
>> callback IMO.
>>
>>> Doing things differently from all other PCIe controller drivers is usually
>>> a red flag.
>>>
>>
>> Yes, even if it is the right thing to do ;) But I agree that the commit message
>> needs some improvement.
>>
>> - Mani
>>
> 
+Bjorn, as this is primarily a PCI topic


