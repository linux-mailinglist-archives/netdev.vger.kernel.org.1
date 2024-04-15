Return-Path: <netdev+bounces-88136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F75B8A5E37
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 01:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6775EB21C4B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE9158D8B;
	Mon, 15 Apr 2024 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp9syHKt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5B156977
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223299; cv=none; b=S0KAY4wyY180pm5is7jFle5AgzGrku8mwrCmhaIRjNuvM80yryE5Ih4NTuEtKcAERHPq7lkcncdJgvEiQufq0OkwzljiUCsPQQQV/4SO1MMRBH3MZ2MLZYh+B2E5VO/X1C0IQh0huNX9hQTgPQahxaN3495Bw2B+k72Uf6aLwp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223299; c=relaxed/simple;
	bh=aE7AAWJlZQUGn/v+AM46GE7UujvJFD0hmUG3Pnsseog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHkn1B4YyVSVVfl/uIcb5BOQfJbozuMTMthzkyso5QkjziUydiGTmmjylUIW2j2JzrqhnHNxICiOEBmTehbP8BtzfPlGidWuWDHbskVS7XATA6fFOs6zdK/tfDuHlQrwjkU8x4UfuGJ1KZ3Ib0UGnjdLnMMKkcVvXmltJ0Idqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp9syHKt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a536b08d63so2240422a91.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713223298; x=1713828098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zE/T7Yy9/aCC5Yw2JeJyn0Jy3nmwADwyeSftZnYhtBU=;
        b=Pp9syHKtS8ykCSabv+10L3MRqLGH0JsKleck9lQu691hg4Qx/5rbHFRBkoOhIAPWIs
         RDrA8AKLox6qO+EMFBLGjZkVlRc0HPFplGe1mJCjICZHBlV10Muwmm2q2TuMn2B4QmSN
         mrAfTJ5w5+sRH3JL4yKSDaKtwB+eEc8Paa3E8ZUAlUSES3VZL3RNSKE/zInVpNUpiDvN
         7qTGOrWq/z2JgAjkavYJFfKCHnnKNBkBXbJADNKquOtyIa/beWyvfH5c3ppLPmO8HAua
         1a/ap6uO+f4wpIgHROhoX4aD7baGlNaJrhWe60ZK6ZzW1epNpRVLr2wCN0yK6AJHqJta
         Cj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713223298; x=1713828098;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE/T7Yy9/aCC5Yw2JeJyn0Jy3nmwADwyeSftZnYhtBU=;
        b=ubBd3/ZJsCkgG3Q3RtZMGIMCdcgrGH+5JqD7Bw+yGdtmJrfoo2++58erqvXgw6Yn1s
         2+lW788o5P52Tn6Pla/yaeQVnGmkSEWYrN0PIp33FrizvVl+KmIsMX2DP5MdcKhJKwUo
         VqwJW6Sc8MrfIwseFIfcyNNadrMZkq0rx1qNplhU0fTPoo7DEADtSyuPAl5SjbPMUMGY
         gDATo/a+AbCoZry3O6gzTZ7f89HdpWPWw6bFMPnfUNcWeJJWAjPF88rc6zZuYXmq356M
         27hamHlqvlfYF+GoRr8ET0bPuK1p+E/t+g8TooU94A4JCoZ1OCgHJxbd13CHTcwqfXDY
         O3qA==
X-Forwarded-Encrypted: i=1; AJvYcCV+RaT9UWyjUb5e0r+GM2BEGxS9DVcdG/UJk4Z4VphqAA99dJVSzE8xw/Ri1xDwVZZ0GT+lLTuuUFi9H6eFHK1nJF+T5cVO
X-Gm-Message-State: AOJu0YyyRSeT2QciKRCkzjWaaYWg4FsNm6zPzAHxQeI6UwGe7dNRYcyw
	l34lglOwE9WaJfV1eiyGwrmZGRM2aXBy24u09NX8+nztvyz0uMfbrdHf5A==
X-Google-Smtp-Source: AGHT+IHm8aE/yXT36bMLVAr3G7+av/uAh4AH5jWaZBkTWI24yFFADXdEi/zIoQH/VN4OFfCbRH4TqQ==
X-Received: by 2002:a17:90a:fd14:b0:2a2:ddc0:4bf8 with SMTP id cv20-20020a17090afd1400b002a2ddc04bf8mr9407730pjb.31.1713223297655;
        Mon, 15 Apr 2024 16:21:37 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090a2f0600b00299101c1341sm8591472pjd.18.2024.04.15.16.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 16:21:37 -0700 (PDT)
Message-ID: <e9506345-8245-4b3c-83a1-9425e0b37136@gmail.com>
Date: Mon, 15 Apr 2024 16:21:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/5] add ethernet driver for Tehuti Networks
 TN40xx chips
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240415104352.4685-1-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fujita-san,

On 4/15/2024 3:43 AM, FUJITA Tomonori wrote:
> This patchset adds a new 10G ethernet driver for Tehuti Networks
> TN40xx chips. Note in mainline, there is a driver for Tehuti Networks
> (drivers/net/ethernet/tehuti/tehuti.[hc]), which supports TN30xx
> chips.
> 
> Multiple vendors (DLink, Asus, Edimax, QNAP, etc) developed adapters
> based on TN40xx chips. Tehuti Networks went out of business but the
> drivers are still distributed with some of the hardware (and also
> available on some sites). With some changes, I try to upstream this
> driver with a new PHY driver in Rust.
> 
> The major change is replacing a PHY abstraction layer with
> PHYLIB. TN40xx chips are used with various PHY hardware (AMCC QT2025,
> TI TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
> MV88E2010). So the original driver has the own PHY abstraction layer
> to handle them.
> 
> I'll submit a new PHY driver for QT2025 in Rust shortly. For now, I
> enable only adapters using QT2025 PHY in the PCI ID table of this
> driver. I've tested this driver and the QT2025 PHY driver with Edimax
> EN-9320 10G adapter. In mainline, there are PHY drivers for AQR105 and
> Marvell PHYs, which could work for some TN40xx adapters with this
> driver.
> 
> The other changes are replacing the embedded firmware in a header file
> with the firmware APIs, handling dma mapping errors, removing many
> ifdef, fixing lots of style issues, etc.
> 
> To make reviewing easier, this patchset has only basic functions. Once
> merged, I'll submit features like ethtool support.

Thanks a lot for attempting to upstream support for the TN40xx chips, 
those are extremely popular 10GbE PCIe cards under USD 100. Last I 
checked the vendor driver, it was not entirely clear however whether it 
would be possible to get the various PHY firmwares included in 
linux-firmware, that is the licensing was not very specific either way 
(redistribution allowed or not).
-- 
Florian

