Return-Path: <netdev+bounces-194447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA64FAC9886
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 01:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5F61C20E4F
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFAE28B7F5;
	Fri, 30 May 2025 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj5YOuXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6A2DCBE3;
	Fri, 30 May 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748649389; cv=none; b=t7ya3W3YrPg1Q9xrWknUOmEhkDeu7Q3RFmw5gBKcT3iOf7aVIkeKnVTkxBq4gMGFnnap2aYDboNPAVvZuHOHG5FH2qI6e71XxGIrjjyd2TjeErj7xo3S4cWTK2L7u/t4tT35gzfhnp0CVvek12HIYs6/iyz45DUBKcxKhhRlFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748649389; c=relaxed/simple;
	bh=KGsR6nTFKeHBuWscM0ej+HFNJljhuHIx/bH0e5Ph4zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzLaFj08bKefGXCTEEWeueeSC+o+vk9em8OGOhJ7Wk4ZopmYWCOQLiyxGIWqpj3S3s5pIPN0x+IxuuM194/BT1tnwY3LtPe6XEieMJmufGT5uOA0vZXOOUqEQWvKWdTOhwQZBLwT4hfsyjuOkcKlstD7ecYpiFTkUCw3+Mc0tRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj5YOuXK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742af848148so1701569b3a.1;
        Fri, 30 May 2025 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748649387; x=1749254187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UbCZyIkZ0m1blK4VZNRnnH4emBisfG3c94TVO1BUVgg=;
        b=Xj5YOuXKVzAZmQG00s00vKesxdhpuYqd1PerOvQQw0XuMKPau5I5T94qukB4ynMjXY
         jPIcEuXyqUzVGQeOGYS3zzvoLsbUCqV8CSAdEllEwCVi56/BacwBFN4S1+yO2uhkz3aw
         XNdvOoPASGZKXcBCkq1i3copbZ/ThJYKogBHpPP4BSRnvl3ZzXbSJtvHdBLC4O/ODJr4
         o7J4oJaOl1wyVy4GlgRdddElnNmpWSn2YULPMMbSPhh4OZEfZbetsL7aDJ+bx+ksoM71
         ejJXPOd+LTlPqhj54mlxZRLYeg20x3VBeKJYc8+4mHrhE4XJl5QXuXy8xitCMPe7333g
         gTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748649387; x=1749254187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbCZyIkZ0m1blK4VZNRnnH4emBisfG3c94TVO1BUVgg=;
        b=obupIyCwqqkl1qNp9KlOOgPzfozP3fSN69gYmEmbZLZ84hMGPy9UAEUCGAgVKW7mN1
         JNsMlKXyrb62LQOCoI5mWQPOrzukrw+FA/+nZ/QDm/WhjLuJIMytU97CdrGHMm+3sIVd
         cudygWxmnCL357WZVHePwgrtI2HfOPjj+j7Juukx4tWf42Ro816TpXhCuHlyCJIzJRM7
         CLCw2FS/2ac4dKW8QFDG4ktUJm6+e5jv5ddYMaX+ikWXAOu80AjLj7Yec78PJI0Z9CAo
         dUBjcvZGUeGsI7wu1IB0KZJJrTiNJfMr5k168UhvH5taMUPeqrEAfouHRNuoZ5A8zGLD
         Wjdw==
X-Forwarded-Encrypted: i=1; AJvYcCW4IR4oWIQt8mRkQZhaUBQ09WWmQOFjrp7W3imSygrcaOMga6KMPI6+30X2YrNs4KDny2Vrt2HVDlVv2K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5NA5QyLFLb+qE7ChRKEQg12eYtcAlcJ1GykbyzGmNhAWkmxs
	YW8mOzIFgTF6Iuo7NQt8s6gcFtDrlV0pwvXHinU6OmHpxpxIhAovhWYC
X-Gm-Gg: ASbGnctnGJNCMrBvO+PhdsQyBAPeFOiWGVw+aFkYNmAmJcfaPcjHINOxN83PS9HSiEo
	VuJad9zPCgd8QE9lm0Z667nXR/EZneTvwYHTHkbImgw6t7zkMvQVcG9O/KQYIRfnB+MQTf68HKo
	19yNFKXTmav7N/kOza26oM4TuJd4jW0+t9STKPeixVrdP0ENTh6W/MdVotdMjxqWfCqoOAhBUhQ
	wEuqYvImrVIFYQldYViEi9/xqNcSb6qrMH7YBESckMep2D94/hq3tQV9uI+V/moDP+6n7P/clD6
	vy9jyu45SxRMBebbVsFLtWfpDMAKOJKMXjdqz57aqXKI1GN9raaU0a++w1cg73xfyF1r7ZoZHf3
	yCaM=
X-Google-Smtp-Source: AGHT+IFu4j52ek9ISddZry4BH1QLbrMR9o7ktMi7lXXMpOaUy7V4nO7Soh+iiNBWYpP530mVx7wSRA==
X-Received: by 2002:a05:6a00:189c:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-747d181cb44mr632022b3a.3.1748649387295;
        Fri, 30 May 2025 16:56:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff723csm3581125b3a.164.2025.05.30.16.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 16:56:26 -0700 (PDT)
Message-ID: <e1f4e2b7-edf9-444c-ad72-afae6e271e36@gmail.com>
Date: Fri, 30 May 2025 16:56:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: James Hilliard <james.hilliard1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Furong Xu <0x1207@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch>
 <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
 <CADvTj4posNXP4FCXPqABtP0cMD1dPUH+hXcRQnetZ65ReKjOKQ@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <CADvTj4posNXP4FCXPqABtP0cMD1dPUH+hXcRQnetZ65ReKjOKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/25 16:46, James Hilliard wrote:
> On Tue, May 27, 2025 at 2:02 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> On Tue, May 27, 2025 at 01:21:21PM -0600, James Hilliard wrote:
>>> On Tue, May 27, 2025 at 1:14 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>>>
>>>> On Tue, May 27, 2025 at 11:55:54AM -0600, James Hilliard wrote:
>>>>> Some devices like the Allwinner H616 need the ability to select a phy
>>>>> in cases where multiple PHY's may be present in a device tree due to
>>>>> needing the ability to support multiple SoC variants with runtime
>>>>> PHY selection.
>>>>
>>>> I'm not convinced about this yet. As far as i see, it is different
>>>> variants of the H616. They should have different compatibles, since
>>>> they are not actually compatible, and you should have different DT
>>>> descriptions. So you don't need runtime PHY selection.
>>>
>>> Different compatibles for what specifically? I mean the PHY compatibles
>>> are just the generic "ethernet-phy-ieee802.3-c22" compatibles.
>>
>> You at least have a different MTD devices, exporting different
>> clocks/PWM/Reset controllers. That should have different compatibles,
>> since they are not compatible. You then need phandles to these
>> different clocks/PWM/Reset controllers, and for one of the PHYs you
>> need a phandle to the I2C bus, so the PHY driver can do the
>> initialisation. So i think in the end you know what PHY you have on
>> the board, so there is no need to do runtime detection.
> 
> Hmm, thinking about this again, maybe it makes sense to just
> do the runtime detection in the MFD driver entirely, as it turns
> out the AC300 initialization sequence is largely a subset of the
> AC200 initialization sequence(AC300 would just not need any
> i2c part of the initialization sequence). So if we use the same
> MFD driver which internally does autodetection then we can
> avoid the need for selecting separate PHY's entirely. This at
> least is largely how the vendor BSP driver works at the moment.
> 
> Would this approach make sense?

This has likely been discussed, but cannot you move the guts of patch #2 
into u-boot or the boot loader being used and have it patch the PHY 
Device Tree node's "reg" property accordingly before handing out the DTB 
to the kernel?

Another way to address what you want to do is to remove the "reg" 
property from the Ethernet PHY node and just let of_mdiobus_register() 
automatically scan, you have the advantage of having the addresses 
consecutive so this won't dramatically increase the boot time... I do 
that on the boards I suppose that have a removable mezzanine card that 
includes a PHY address whose address is dictated by straps so we don't 
want to guess, we let the kernel auto detect instead.
-- 
Florian

