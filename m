Return-Path: <netdev+bounces-203753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD8AF6FD4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC3A4A16C0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06FC290BB4;
	Thu,  3 Jul 2025 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeIjA+5J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CA239E63
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537860; cv=none; b=BDW0tH4A6dHtBh2e9jYYpXc/Vh9TLDXTcpJV3xMKkq6BulcWXzZ34po+cFMGJGo2i9jTvLqTYCzl92CivpUJydkDGCAgnBlrXh1PLm4cXXNqyCtSTZhfydzrd3d27p4hmixjCW7TQO2vez5n/g1wtY3Nj2gYEFHo10Df/RSh28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537860; c=relaxed/simple;
	bh=7FiUXG03y5bMSiB9VO4YZAgtye/Y2LylQnBEoNChdBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laXWZJkppXgCGJsPBWUUVMX/WyXV1ET/BhN6LV8Z3FKwFv/aCokRrCWVyAg3gPBeslWUPlVs9CV93M2/UkAP2SzTbqf4g70jTLP6s+3xXT7yHD+QVX/H26gxVY35s+qUKvaC8NdU9FK12FF1/Bn7kLCAPFqrHWLwmXNpNRiRurs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeIjA+5J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751537858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfQsXeetvvPPzsJ3/8ZSvfFMQdwAGhV0ruew1VUXFPQ=;
	b=LeIjA+5JP/HPAsjP1xKQLE9rD3aJDh2K3qh/2QaY+rQ+teomhnJnvfBOuejAmCu2B6BxPF
	pvdp3buuU5K9JO7OSK5NH49MV0BLKKLlQX8uPLz4K/yzs0l7rKq8NNRY+n66p6u83qE6+B
	mCv7I3SYWnC7xw6X+DpRepwstukK4vw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-BiGWmbr5NgijJ40Nre2B0w-1; Thu, 03 Jul 2025 06:17:37 -0400
X-MC-Unique: BiGWmbr5NgijJ40Nre2B0w-1
X-Mimecast-MFC-AGG-ID: BiGWmbr5NgijJ40Nre2B0w_1751537856
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso4628685e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 03:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751537856; x=1752142656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfQsXeetvvPPzsJ3/8ZSvfFMQdwAGhV0ruew1VUXFPQ=;
        b=S/EjAP1hhmSmwKX975+fWiNPzvew6/H2Ve/miBpR5M4LowPw4fgKi0Bu77zSk500tI
         sX1xqw4P7p+c36EZKNLCPW7jwuo2pqQPvXN05bGPsGIdEy8rO1WVmeNdjj8hNVHhO3ih
         gbNZ6vJewOy9T0IahL11Rrxi+FUTeOru36VT+BD7qvD5enXsIBKYMsvyBS8fwv0PCief
         Zy6FrCY7dxC2WZ/5/FfzgPjy2RYUTBnFNtruS0ORh7BhZpw4VAikkmnpoh72b3rssyhh
         8QCTPAe+FYin652AmkOtYEaeax0bXSJGbMzPIb2Lf3SPNQwGhQkk2JBXZ3n+EaYwh4eu
         Qn8w==
X-Forwarded-Encrypted: i=1; AJvYcCU7nCPnqo/TrYgQKCnQYx30wBUr2A3SNagKqs5NoDbzT8MsnEFkpWvY311AoXkpG/9Gkyc7gQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETavn3llfHE6NhW1biSbzNL/CD7hNKROc1H27yLxjDQYnNoVJ
	+BHiHKEIfPFjXM8jn+yGbGH07zsY9IlMYNRn0jIabKZTo9WceEotdU+NbGOycMI8AT329cIe82y
	9fuNjRDyYG7odI6q1SM1ZEZZ5BbMbZ4vhM5AjaEYgkLCtAK4w2IIX43kI2w==
X-Gm-Gg: ASbGncuRYSIFFagLCbW6DMIXShP/YsbhRGYcv/ncEtifJWUd2NFHR4rS5bYgixt0bgQ
	FY+hSIBgfTCXNMxUC4jgUjyUL2gLg6A/3uR4gJ+QJCuSA+R16OOXuxmdfML1QMNVh3YNEHBjWp7
	O0JISwRLyfGSicoYDSilAX0fLxtyiHTs819ok07d9WHzebxh5DSfLM9QDXcHifidJhGeRbkFYu7
	tXefCcTiH8vdtfF4UVIVri/1ZKhJr/6szcnvyZNMvgVSUWIBUy7TuA8ussYYlS6HmyOfuVYl+8m
	hOq3/9ftjaY+qEZOV0Fo2onFc5FmGLSdVUz4sCOMK3/HZucPmrsHn6JMyH//7JvN7HA=
X-Received: by 2002:a05:600c:a104:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-454ab31f49cmr17484675e9.8.1751537855713;
        Thu, 03 Jul 2025 03:17:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzsDilheHoSsZdDQok8pr2Px2x0eKxdKvVnOdfVvAvRP1Jm7fZHNWlhFagRLLbenLbksn8tA==
X-Received: by 2002:a05:600c:a104:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-454ab31f49cmr17484295e9.8.1751537855244;
        Thu, 03 Jul 2025 03:17:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e597a8sm18185205f8f.70.2025.07.03.03.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 03:17:34 -0700 (PDT)
Message-ID: <1982e894-b61f-48c9-90a0-00e0236aa6be@redhat.com>
Date: Thu, 3 Jul 2025 12:17:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 4/4] net: phy: smsc: Disable IRQ support to prevent
 link state corruption
To: Lukas Wunner <lukas@wunner.de>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, Andre Edich <andre.edich@microchip.com>
References: <20250701122146.35579-1-o.rempel@pengutronix.de>
 <20250701122146.35579-5-o.rempel@pengutronix.de> <aGPba6fX1bqgVfYC@wunner.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aGPba6fX1bqgVfYC@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 2:58 PM, Lukas Wunner wrote:
> On Tue, Jul 01, 2025 at 02:21:46PM +0200, Oleksij Rempel wrote:
>> Disable interrupt handling for the LAN87xx PHY to prevent the network
>> interface from entering a corrupted state after rapid configuration
>> changes.
>>
>> When the link configuration is changed quickly, the PHY can get stuck in
>> a non-functional state. In this state, 'ethtool' reports that a link is
>> present, but 'ip link' shows NO-CARRIER, and the interface is unable to
>> transfer data.
> [...]
>> --- a/drivers/net/phy/smsc.c
>> +++ b/drivers/net/phy/smsc.c
>> @@ -746,10 +746,6 @@ static struct phy_driver smsc_phy_driver[] = {
>>  	.soft_reset	= smsc_phy_reset,
>>  	.config_aneg	= lan87xx_config_aneg,
>>  
>> -	/* IRQ related */
>> -	.config_intr	= smsc_phy_config_intr,
>> -	.handle_interrupt = smsc_phy_handle_interrupt,
>> -
> 
> Well, that's not good.  I guess this means that the interrupt is
> polled again, so we basically go back to the suboptimal behavior
> prior to 1ce8b37241ed?
> 
> Without support for interrupt handling, we can't take advantage
> of the GPIOs on the chip for interrupt generation.  Nor can we
> properly support runtime PM if no cable is attached.
> 
> What's the actual root cause?  Is it the issue described in this
> paragraph of 1ce8b37241ed's commit message?
> 
>     Normally the PHY interrupt should be masked until the PHY driver has
>     cleared it.  However masking requires a (sleeping) USB transaction and
>     interrupts are received in (non-sleepable) softirq context.  I decided
>     not to mask the interrupt at all (by using the dummy_irq_chip's noop
>     ->irq_mask() callback):  The USB interrupt endpoint is polled in 1 msec
>     intervals and normally that's sufficient to wake the PHY driver's IRQ
>     thread and have it clear the interrupt.  If it does take longer, worst
>     thing that can happen is the IRQ thread is woken again.  No big deal.
> 
> There must be better options than going back to polling.
> E.g. inserting delays to avoid the PHY getting wedged.

I agree the solution proposed by this patch looks too rough. I think
more effort should be invested to at least understand why the phy got stuck.

@Oleksij: possibly you could re-submit patch 1-3 only while you keep
investigating the issue addressed here.

/P


