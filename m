Return-Path: <netdev+bounces-70674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2E84FF58
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB7E1F24F34
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F080218623;
	Fri,  9 Feb 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llR4UHFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B4210EE
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516091; cv=none; b=DqZcgZY8ZcX1TILbJKtgcOqcOMJ/NgSIOO3bYm2jNNyDq81kHVMTLHHbjLwFVYB8jwBBNdYMWsH6lbCJCNtyqoYxPltc3aVVB+c045JZcZdGBFvh8NB/f91DGjsBeu/M0/JCaWNWM5amsLefcI8YwkbsmfozXKtbH8VmtssWqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516091; c=relaxed/simple;
	bh=mjxe8Bf4GnEis+w0+f9BtbSfKgM7JwfzOnI6uiZZTeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8pfHsfBfAgmzm4aOI7k+FnYhhaXKQzPKPB1+7I29tR1HHTlaGThsGZ3knaLWFp+4hjfHM3AOPU0AiTcIQwEJdaZEguhYErWA/ZdnhWHhhiF5j3gIva6oUInOL7+5yShedvflf2VjcYOWpOxfBpl8+QwHyFDHQB52IpqJAYjtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llR4UHFz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5610b9855a8so4033261a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707516088; x=1708120888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QcaLjpriWJeRwjIE2f+41YuRg7sdPirAe2arF5EaKTA=;
        b=llR4UHFztHhsCxBnEna101+AZNHiYkNFF9EnLPlwJDAuHiXLzlW5ryUo54vSYV0AaF
         e60F8bFLOQAl4iYG1Xdkw9Xxo9YETL3VNZK+a2chMiV5Le2ygTP/FR6/GzuNctOBvwpv
         g+YeBKAlni6y9jy5pWtU1s1vsHfIrURdzq7n8oWRLEHfkSc6NuWim/s38OJt8/S32PKw
         vA9tgasvnIes7lEFSqbbmBEaG3UqgMBQ8NGkSPczyijFo8oPWoW5OX1sNbso8TcVwD2y
         PDYmLlzmsDQ1JpsFwzW4nEcwcDbWBsqqviCEsa4tGN10Mos8tP4nbpRSlYzzv3ee1MTe
         NiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707516088; x=1708120888;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcaLjpriWJeRwjIE2f+41YuRg7sdPirAe2arF5EaKTA=;
        b=sA6xK8lK9+vnLtYckM+DuI46OP3JmcHkAaaDUV3IHIihLNH98Y1yJ52bgvjkaCaVUg
         dtbFtAWyv2Zos7Wps9b7sAFu68IaxgQ7hIxqletUn+SXDNsc2cauk5yl5swhb79luZZ3
         LhvpqkEVdE+RF6CX+DjsqkehGJ4v4T1FplFhcqsYj/5afZ3xiXV3TgUyNCj6Z85iBm6y
         9wJDtTHdLN8VPcIbac7mhakUHPlxH6JWfwiVdRfnd2dPFjr9T/EGj4ZFQsMrVDYwX/YK
         bbCUX4fOhn7F4wREPm1xBaiBmk65IfLGG+p89v/PCeX8l30Vw4vNngttREYQHiOkOnQT
         tIEQ==
X-Gm-Message-State: AOJu0YztoMdnqzy1smvVT7NsTtSJ94cFB13ZQJrzAT/zODTzX0nj/fBz
	dbKOUqLU12jeYoKOM4xzbhjZE768XU71JdZH7PVqQtHF0vbL+woi
X-Google-Smtp-Source: AGHT+IGwZE8wydilAquefkkH5Mj/PAJGTBImap1Ru3FbZtS4aww569wl9EU7zm6mBTSYF18BmYG59w==
X-Received: by 2002:a17:906:f247:b0:a38:5cce:1ba6 with SMTP id gy7-20020a170906f24700b00a385cce1ba6mr376120ejb.26.1707516088177;
        Fri, 09 Feb 2024 14:01:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwsK3FrwqupKVfV7uQhXgYB7+h5zjIfOCAxLqka/sKJivjj0D9Igy0TlSmxnmvSjM4aeV5wmTez8BqghCU/r6xCCubuX+N2OnnLtrGGBEAboWhvnJfJA==
Received: from ?IPV6:2a01:c22:7ac0:d000:598b:3a52:3b70:92ae? (dynamic-2a01-0c22-7ac0-d000-598b-3a52-3b70-92ae.c22.pool.telefonica.de. [2a01:c22:7ac0:d000:598b:3a52:3b70:92ae])
        by smtp.googlemail.com with ESMTPSA id m9-20020a1709061ec900b00a3bb6de59b0sm1161137ejj.95.2024.02.09.14.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:01:27 -0800 (PST)
Message-ID: <c60e31ad-ddc6-4c93-83d3-d1255927c5d4@gmail.com>
Date: Fri, 9 Feb 2024 23:01:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Module r8169 and the Realtek 8126 PCIe 5 G/bps WIRED
 ethernet adapter
To: Takashi Iwai <tiwai@suse.de>
Cc: Joe Salmeri <jmscdba@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tiwai@suse.com
References: <edabbc1f-5440-4170-83a4-f436a6d04f76@gmail.com>
 <64b65025-792c-43c9-8ae5-22030264e374@gmail.com>
 <208a69de-af5b-4624-85d5-86e87dfe6272@gmail.com>
 <55163a6d-b40a-472d-bacb-bb252bc85007@gmail.com>
 <f344abc6-f164-46d9-b9d1-405709b77bba@gmail.com>
 <7ee3893f-8303-46a1-a303-7a009031ca4e@gmail.com>
 <e7092019-dfe0-4d6c-96f2-2a1b909dc130@gmail.com>
 <87cytg1wiz.wl-tiwai@suse.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <87cytg1wiz.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01.02.2024 08:19, Takashi Iwai wrote:
> On Thu, 01 Feb 2024 08:09:21 +0100,
> Heiner Kallweit wrote:
>>
>> On 01.02.2024 00:36, Joe Salmeri wrote:
>>> You mentioned support showing up in the 6.9 kernel.   Was that correct or did you mean 6.8 which comes out in March ?
>>>
>> 6.8 is already in rc phase and closed for new features.
> 
> As those are rather trivial changes, I can backport the stuff to
> openSUSE Tumbleweed kernel if the changes are accepted by the
> subsystem.
> 
> Heiner, did you already submit the patch for r8169, too?
> I couldn't find it, only I saw a realtek phy patch in
>   https://lore.kernel.org/netdev/0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com
> 
Meanwhile all relevant patches for RTL8126A support have been applied and are
available in linux-next.

net: phy: realtek: add 5Gbps support to rtl822x_config_aneg()
net: phy: realtek: use generic MDIO constants
net: mdio: add 2.5g and 5g related PMA speed constants
net: phy: realtek: add support for RTL8126A-integrated 5Gbps PHY

r8169: add support for RTL8126A

> 
> thanks,
> 
> Takashi

Heiner

