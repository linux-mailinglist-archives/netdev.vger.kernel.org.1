Return-Path: <netdev+bounces-249568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB6D1B0D0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59F5D300503C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6336A01B;
	Tue, 13 Jan 2026 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOt6aTWB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAb7vt25"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B434F46D
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332637; cv=none; b=IcFgaSGj02Fj05lmedwOp5YyWkyNJP8i1Xl2QcSdwa/x+GGOVeJb4Sm385CF1LcCExzMxjaMwMjsnDZQ5wlfwmjM4TVfg/UIpWVij56XltZiMXsUiJFPgmFl7UlRkI2ZE3klkXICb8U2asq0mqrjM8oHcIvJRUcX0xU4Wxt6P1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332637; c=relaxed/simple;
	bh=+Hcnaa+R7DNh8jOuiEOM90xdRMeFLTVZ7LNYQpNNE7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IhWZu8cVvOyRWjyBFQHgDEqIaeHT1NXTgIxYsE9RuaKK/stinU2EB5kKsroCKfZ40s3kjktuQejlvC8PbdWF7suuaj6X6glXR6Yi8nyyAbnWxLQjramUzrKVmF16ubimy2kyVtSWFKrXeeHfSlikE8L+v00fiAh13Yk2VhDvMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOt6aTWB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAb7vt25; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768332634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqIxQHRJhD05AoUhatqlXLO+0tKODINJq0C8P4NUDkQ=;
	b=QOt6aTWBxVUcnOetH3w/UKYOQWyDzw2ETMT/dGHvBpmZByfrdQsnmFQxKoI6bSUPtPPcZf
	RWQrH9f/5iAYwRelCecfia2axmfZVbpaE6skm20hTWj0oD+Iyqu12Jz7P3dVyTy0T/aPWe
	qHw33DhAdE7oOFDY+FaVUdvrem6jAg8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-L9IcJx7qMp2TjO3hnG5-9A-1; Tue, 13 Jan 2026 14:30:33 -0500
X-MC-Unique: L9IcJx7qMp2TjO3hnG5-9A-1
X-Mimecast-MFC-AGG-ID: L9IcJx7qMp2TjO3hnG5-9A_1768332633
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fcf10280so5918831f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768332632; x=1768937432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqIxQHRJhD05AoUhatqlXLO+0tKODINJq0C8P4NUDkQ=;
        b=jAb7vt25mIGS6vPSkk5+GfCtCNFdM6U8fZ7WXFOKX5LnAd/7gWXJnUdYifrKu/5z0N
         MUTRAWghG6BA4t3f3vxOSf6e7r6FjtrVxpueHor4fPzM1sNkdAzHZV1wyEcc3dIKvqxR
         ARMix96AKq+uKkxNbO9sXnLZ1NCirymnxFrMj7VgOuJjXVHpB7aMAfWT6i5hqSuiY/D2
         pe4PoXSRdRTbUgDQZCAwYlZVNUfrpo77vzwtBdHzi6iBq+V0eSJnx/BqHDWhOg89XEGG
         7R0I7dvl0hEKPrexVMHKCRbHGVqfk947xQSAdu/XnhH7I8t0XERjcKYIcZtHmGG3kqKH
         k9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332632; x=1768937432;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YqIxQHRJhD05AoUhatqlXLO+0tKODINJq0C8P4NUDkQ=;
        b=HfpxwsBej5ldalOsTgj5jr/1Y108K9WJa706AmK57Kn4dU//FJ7yoGmQOD1AZbvv/s
         0EbpO9Ff0i4ixvysPumLR5ghgUTXhB04s0Ov6vN8DVNpX6783QkDTQxyeum9iOcd8sPG
         llwObfFpR0GOcVVQ+/Tik6u+dvGYu2HdZSTQJwMsJqjK9+EfgoeGekup4wWde+fFUcp8
         1sAYfIzQ1UGArnxSuUa/E3I9okZvcvUcXWVadnoo8s91r90o3feWtgmFeYO53ME71m2w
         CuZ5C2b6007RVM/TruHSEQqDrQu4uigtI6UHGx3S8evdksxGsB82Oy925uBFeL8NUX9w
         IyVg==
X-Forwarded-Encrypted: i=1; AJvYcCXiKrilwizKlXhTCj7jlOnTRaB2+8YB8CJBgk0tT25KbFg4kOaUZmCEWybXvuAdJKPuKENnW3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXWdQ0hOeGDuIq8crBubmjYAXQmJmO4FkHsZqb86kYt/Hoeyp
	qfVUql+5K1Y2f8Bmtv7ptSx60Qg399c+A3ALyr5SVt9otGkAUoZHCCTeVBuNsYPLXH3FEvHCIKC
	5MbHJH613Y5w5qGLpiYP54J2luavbrmjrSbMvtPTk6Kx8Sf5MNiTPFd4J6lZhl2zpEg==
X-Gm-Gg: AY/fxX5twzJWSHMENk1gKJR0w312FPGQRMsWJ+Yw/pIkRjII0OZbcmahdX+TJjJs8Dv
	aqtFAUIUkRBfQ+MYbMP7bCOBigDsmoiTrI42HstaYe4gfiizCAyHqr0KmhN9YhoPr7FdOQjPI54
	nuYlDPTKx7miJW+tpubdCs+VEEFFVoWbcRvCrHYtiU0tV06MqLD+bJlBUkkcxyQyY7PO2V7lloS
	nOzvVPGmDwkZF3F43th72LPYau3se6z8AIjNupvsOETCxK2B9ydhZUJNplz1BiEMuRq/xVBcgZq
	aHmM84CY4cfjLhO77LbTKQKzLHmSgK/VEMi9gliXfK1MLL62w6kw1Y75iee3ijTcv6MecfGduLf
	Qnqzl+7y8LK8nMv5PNpvGS7qwPPbLw31+qybEj7FCUYP0FdY=
X-Received: by 2002:a5d:5889:0:b0:430:f5ed:83d3 with SMTP id ffacd0b85a97d-4342c4f4d35mr57654f8f.5.1768332632152;
        Tue, 13 Jan 2026 11:30:32 -0800 (PST)
X-Received: by 2002:a5d:5889:0:b0:430:f5ed:83d3 with SMTP id ffacd0b85a97d-4342c4f4d35mr57636f8f.5.1768332631758;
        Tue, 13 Jan 2026 11:30:31 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee870sm46048574f8f.36.2026.01.13.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:30:31 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, =?utf-8?Q?Th?=
 =?utf-8?Q?=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>, netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Gregory Clement
 <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 3/8] cadence: macb: Add page pool
 support handle multi-descriptor frame rx
In-Reply-To: <DFNE7RIDJY1D.EON8I6D22R5@bootlin.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-4-pvalerio@redhat.com>
 <DFJBNAK0H1KV.1HVW5GR7V4Q2B@bootlin.com> <87jyxmor0n.fsf@redhat.com>
 <87344ahdtp.fsf@redhat.com> <DFNE7RIDJY1D.EON8I6D22R5@bootlin.com>
Date: Tue, 13 Jan 2026 20:30:09 +0100
Message-ID: <87h5spl39a.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13 Jan 2026 at 11:35:09 AM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> On Mon Jan 12, 2026 at 7:43 PM CET, Paolo Valerio wrote:
>> On 12 Jan 2026 at 03:16:24 PM, Paolo Valerio <pvalerio@redhat.com> wrote:
>>> On 08 Jan 2026 at 04:43:43 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.co=
m> wrote:
>>>> nit: while in macb_init_rx_buffer_size(), can you tweak the debug line
>>>> from mtu & rx_buffer_size to also have rx_headroom and total? So that
>>>> we have everything available to understand what is going on buffer size
>>>> wise. Something like:
>>>>
>>>> -       netdev_dbg(bp->dev, "mtu [%u] rx_buffer_size [%zu]\n",
>>>> -                  bp->dev->mtu, bp->rx_buffer_size);
>>>> +       netdev_info(bp->dev, "mtu [%u] rx_buffer_size [%zu] rx_headroo=
m [%zu] total [%u]\n",
>>>> +                   bp->dev->mtu, bp->rx_buffer_size, bp->rx_headroom,
>>>> +                   gem_total_rx_buffer_size(bp));
>>
>> I missed this before:
>> I assume so, but just checking, is the promotion from dbg to info also
>> wanted?
>
> Ah no it was a mistake. I was lazy during my testing: rather than
> `#define DEBUG` I changed netdev_dbg() to netdev_info().
>
> I wouldn't mind but that isn't the usual kernel policy wrt to logs.
> A working driver should be silent.
>

np, makes perfectly sense

> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


