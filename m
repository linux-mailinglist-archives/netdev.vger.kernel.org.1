Return-Path: <netdev+bounces-176870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D811A6CA37
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5D1B63670
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C655A20F093;
	Sat, 22 Mar 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y53UdMRo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379D19ADB0;
	Sat, 22 Mar 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742648691; cv=none; b=XEpNlhGC/8MchFqJ0iKPauP/bohTGLDDqeZ9hB97ve275k3B0ZWcQrWjCuLTv/1ybUzEXRyuePGFFE1ZecZgR0RwSiZmBdHxuvSlNPDZbLUKnD0zBrJxM6hFVC8241qStXMBnocYTI/fstZ1AnS4svm6Hkd/vcjqiKr4DLxypLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742648691; c=relaxed/simple;
	bh=RZ+jYa9PZnK7gXxaGCOT7RsXcLOCULh7AKTxHgp4nj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0u+9ztHxbb+/N/2XD0P9N92u0Q4jlOIpnCf6W6PzXam9lG7KTNWYWtWHvihVsuBP7WtUshTH3Fdoyhq5Zbbat8NxrnBHNC3olbl1EBt4GqtCqKNK7SwJh4Og8fz1BCj+UbTL7X0aeOnp98OU7/a9fXy7nFmJlEbCF5An4nVsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y53UdMRo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so30647255e9.3;
        Sat, 22 Mar 2025 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742648688; x=1743253488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ekuk/TZA/Qs60RPfApigfWuxRGaq8teVnOmN64jELUk=;
        b=Y53UdMRorc9VfPdZrvz8ch157k4rKVmB27wl67frM6viMP4IuY4K6Zum6R5VGM3o4e
         4OwzAnLU3Fmx9RY3cWCCHw30B+Kt6bTiofvRNmdnbkVBCFNTUflr8iW+cl/F0/14urLQ
         jQbGLM8FVkBnIoKXjn1qp8pjhu85L1WEyEhCZEcaHpTq8lYOMeHdcGaFnU0XQMAx6NMk
         7QxpYYaHvBFMm49bvxdbhY7ruQ84OC28N1uxqf/s5G5SPnyGz31VBZqSYihQD7e3Gs9t
         9AQyzkOJ9dhKbpw45UVF61IwDLrl9M9HGiBAK0YtpXhZQ6TcnFNEpl0Evzlot5TwRmrt
         kgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742648688; x=1743253488;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ekuk/TZA/Qs60RPfApigfWuxRGaq8teVnOmN64jELUk=;
        b=LMv2P2LaDfvuur9WHrieXhunozsnIla5BHEkzgwNvAMU3ZxVYG8JKa5Qh28Ynb0cgu
         eNZaZIhmugjc2zfgfxKf2xKuZ/3xyfU2NYox0S7npI+MmNnKirD6+w13CR5KLmu55/3e
         OKwzha8olFKtJ57b4TjCAzqVW9BTzdCZ8hQYStoFkTRSIs6J7QBd3feu5yJr/+1KhyAz
         jRBThrnEdJh6P/hUitESiIOCw2LC5wTafM210WxBOdcCaiocBBe3ES/Wob8C9z/oEPjx
         2Vl/G5mh5E+Y8289U4LIrTagSCJWYZMPObN/EmdDruh0o+8T0zGvBbJV6wQyJJpc/7lC
         YkhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTC1mLz8pGRWwAYNopKEjPKHNbes3c7CmBTIN5VRC2loeJAH7rqj41Y5cuyS/oZIq0KmJe5A0H77Wm618=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPjpnAClB2uzBsuLaEjQr9NmkWtAn/5yKojOp8OGXVNSWLgcl
	ljkithJsF5ByFqecoGNpsaAznVcIdNIvUw8CXRpQEu8RqvtrsfGh
X-Gm-Gg: ASbGncuw3/bK4rVhY6Ue1JT7VmS1vgx/XB5/xfyuoXrbt13byjGTt9qy3eimMUs87lm
	i4AV4udCJ6qo7QkWmlAWGrcolmb0mO8gPIxLEAztPvIGZv2TTmzC1/vre2ZGdPrIctYiB44Zfxv
	/B8XzFM7IpE4OHQkgOuzpEUkynbGAErysH46Yl6bmswkSj4OCAvMRmU0H01FHaQMspgIgV4bA0g
	CfeqQcjnGmaJbVNojkc20ZR+ZlH9N6JVUmdl2U5wzKtUdiegXwumvuWUJBshmFoBMliL5UPRiMW
	3kHgSoQK1YNO2Sh47WOEpUi4/6UWS81+GXLnr0ZIA0x8+RpQYAPBEJo20IMN1y87JGjyheyZvHj
	8N8oQen8PkPxCiQfxta1FUiZwJtSGEX3YHgLlPio8fBoYcqaoNepi6+a2tGwt/jVozzmk9TJq/N
	GojQjHPCofb5lOjXg9riSlq794UdnXidst9w==
X-Google-Smtp-Source: AGHT+IHdwfM4OmZ62TWRl/yvOuW1Qs7yWRMeOyXGCLfbuZ+hYNE2TKeiL5JqvQAs4RC9Lrs/FLpLVA==
X-Received: by 2002:a05:600c:1989:b0:43c:ebc4:36a5 with SMTP id 5b1f17b1804b1-43d509e9dd0mr59980705e9.7.1742648687905;
        Sat, 22 Mar 2025 06:04:47 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a13e:400:6542:26c1:ff20:2eac? (dynamic-2a02-3100-a13e-0400-6542-26c1-ff20-2eac.310.pool.telefonica.de. [2a02:3100:a13e:400:6542:26c1:ff20:2eac])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d4fd2798bsm57854535e9.20.2025.03.22.06.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 06:04:47 -0700 (PDT)
Message-ID: <065dabff-dfcc-4a86-ba0e-e3d6de2d21fc@gmail.com>
Date: Sat, 22 Mar 2025 14:04:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: MAC address programmed by coreboot to onboard RTL8111F
 does not persist
To: Paul Menzel <pmenzel@molgen.mpg.de>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Keith Hui <buurin@gmail.com>
References: <49df3c73-f253-4b48-b86d-fa8ec3a20d2c@molgen.mpg.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <49df3c73-f253-4b48-b86d-fa8ec3a20d2c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.03.2025 09:50, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Keith Hui reported the issue *MAC address programmed by coreboot to onboard RTL8111F does not persist* [1] below when using coreboot:
> 
Why do you consider this a bug? IOW: Where is it specified otherwise?

>> I am producing a coreboot port on Asus P8Z77-V LE PLUS on which this
>> issue is observed. It has a RTL8111F ethernet controller without
>> EEPROM for vital product data.
>>
>> I enabled the rtl8168 driver in coreboot so I can configure the LEDs
>> and MAC address. Lights work great, but the MAC address always
>> revert to 00:00:00:00:00:05 by the Linux r8169 kernel module. I
>> would then have to reassign its proper MAC address using ip link
>> change eno0 address <mac>.
>>
r8169 in a first place reads the factory-programmed MAC from the chip.
If this is 00:00:00:00:00:05, then this seems to be an issue with your
board.

>> The device appears to be taking the address I programmed, but r8169
>> reverts it both on init and teardown, insisting that
>> 00:00:00:00:00:05 is its permanent MAC address.
>>
>> Survival of coreboot programmed MAC address before r8169 driver is
>> confirmed by a debug read back I inserted in the coreboot rtl81xx
>> driver, as well as by temporarily blacklisting r8169.
>>
>> Vendor firmware is unaffected.
> 
What do you mean with this? What vendor firmware are you referring to?

> Do you have an idea, where in the Linux driver that happens?
> 
See rtl_init_mac_address() in r8169, and rtl8168_get_mac_address()
in Realtek's r8168 driver.

> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://ticket.coreboot.org/issues/579#change-2029


