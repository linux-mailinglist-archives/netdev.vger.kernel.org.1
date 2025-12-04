Return-Path: <netdev+bounces-243501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6275ACA28C7
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 07:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FA1F307BC4C
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2292D8DD9;
	Thu,  4 Dec 2025 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkyOcSjZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B226F476
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764829960; cv=none; b=BEn45YGxEbCC4M0gx1StzbrZN0Wda3cabTUAdVllIerqjBhne7QmpGMpbs/qA2Nl0HuAJ/XJwgGgYYAfrzQrYg4EWrxrzBXcZ/b8dj4Lb+8T7h7Wc60OLaQ1nMOFOu+HOMOrOdCHFSLNoYNutE0Uac4kT6wuWzFNo9EuycuJHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764829960; c=relaxed/simple;
	bh=a8NNE3YXoFFgNNe4qLNF0tslnTeheSqVsGWX1HHzCZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZdQV98ul9QxYfQpspsmfojwRiEBghF154cvMZV32FQi7eP9ll2w7n7caOJXavrNRnTqKS8vekCyZUuPBeg3IIUrduakZZSpKGe2vERPlIVQVeBBaiENXSYGutfhcLW5j7aEXJEktHJaUVvDZLkd0D7dAJigVCTYGJtJnLjDuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkyOcSjZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso309855f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 22:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764829957; x=1765434757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQBpNAxUDMYLSVsu/Ejv6FgyaL+p66l9fTuZowdXj3k=;
        b=BkyOcSjZ+buXRQ1SSvaJgfjJ6w0N9YsKA1cUCf1qN2eGEiuQz6RV/twE/TKjg3jhfc
         0X1DywEgBCuVNXgVo+OqNHTQXXcMZ48bdW+bQn5EhsHe0KBNl+kCxPhDhDb1sKiH8E9d
         Afal0lDPYW4PqX/YbzyVy3E/9Q5cV+p36UBDxRnciVXv4NJuLAnAJl7ser+YgP/psW5X
         yDBV7ULA79gpFejHPu/cAbPLnA4gQVXm5nsN9pOuQjGavwfJ1quzCUty1IjsHKBzwwHJ
         PXF/BguL7t+x5npvxvKPg59lrUx809qz+FHomBv1pfcMCS5EJFtql3VmaiFOApE05cLX
         PfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764829957; x=1765434757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQBpNAxUDMYLSVsu/Ejv6FgyaL+p66l9fTuZowdXj3k=;
        b=naHUtTMUKBLk3ckT8Q195hOZ9+uW3colvOmxEue0mRUDUD1U/zizyuHMu3PpPydLMy
         jjU9aHQ7Q/yZbNgERZmIoVs0P/28zqTsFzI1wB9sjYWWIX5lrAKgHxaJ+n/S0z7faVmh
         cXmBWtAq+Nm6VvIkrMhB/kXjL8cGoyXIMhPkp0sTRsYC8LFodBBGmJq354+SA+K94IG7
         J1bN6gJS9fH+i2n9a1OXPPZpDdcoiqll6cIqBl/bAPJBaOZjz1nqxGUm8LvkPx0V4JVm
         N0zRagM7AsDIrtyVM4duysnoA9YunlMjabNKwFSs2JF6muv6oITAY2qNdVWWIcb3+0DB
         S7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVfo7Cf829+HUnBPwG0AP0x43ZUmJjhnxh+IT5tRdSlcJUQ70e9uNY1ONkBRmK61GgaMeG6/Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuYb+vW4rPCmsFP8GzYk7vp/HVdeLUp/R91HaWw0yuo3fDiSE
	KZbmzm/W6eYG4jZXPT14crMXt3EoIYV0utFkH+vmikzZw1mZqnHAmNnh
X-Gm-Gg: ASbGncsHso8PaFvFJx/z0SxGDMXnU66Qx8vHrykTQJuj6fWhRYMwrz1yNGbZA1HLTXK
	HB1ppvvFxGoQW0qs/wZArALPUhCdUHuzpLrkVvCMNoJ7irBadQb4AlSKB2Ua/OWPr491GL1+FEC
	MDFM/xVLI9//fgR+ETlrjmVA8RrLGXEpMXUghfqRbzwWjAlDHZJBabmmdyOghujp1MSamAtVCYC
	jYqg4DyBwfH41VNeN8h1ghD3EX+BnpDGaI4mFlOobSMxEL7R1huTypmuxobI2qZLG45jsAgV4pJ
	opRmXirZ60MiLs0sNyKGGjPbl43xcpxYOS2nJ5JPKAvEYwVuleZ7lVbsdgPx1eame3kvmHVavj3
	MKP/besPBNxiooQNIPZSA8+sNE5na//NiyOYLLMwTvRnLhHIXHybQ68sUREdqOj4zScsRuxbq4D
	i/f1wGg8XlFYA2yZ0QhZHF7ZSU3y0VY0UJcaUcr17+CVpUeCqjxAApoT02b+FF5e4XXBt4Fk9zQ
	f2/g63kp5bVpj/Sl9HNzG6voYSBVdGcM7sVEH+hm72jNz2k0N5RLg==
X-Google-Smtp-Source: AGHT+IE99HTgxc4n/rY3EjbBxGAva5RcJIl/a0TdgKOoId53kwDAwvg3EKIhCRZxkFhRozAu1JpylQ==
X-Received: by 2002:a5d:5f50:0:b0:42b:3090:2680 with SMTP id ffacd0b85a97d-42f731678b9mr4863098f8f.10.1764829956390;
        Wed, 03 Dec 2025 22:32:36 -0800 (PST)
Received: from ?IPV6:2003:ea:8f3b:8b00:d534:4b21:f00b:33f0? (p200300ea8f3b8b00d5344b21f00b33f0.dip0.t-ipconnect.de. [2003:ea:8f3b:8b00:d534:4b21:f00b:33f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226c5sm1330473f8f.23.2025.12.03.22.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 22:32:35 -0800 (PST)
Message-ID: <bf7d441b-a15d-420e-a1b8-0946f9e918d5@gmail.com>
Date: Thu, 4 Dec 2025 07:32:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
 <aSDLYiBftMR9ArUI@google.com>
 <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
 <aSNVVoAOQHbleZFF@google.com>
 <0cacca03-6302-4e39-a807-06591bf787b1@gmail.com>
 <aSOgJ5VbluqPjV0l@google.com> <aTC1jz5cTmsrQxwA@google.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aTC1jz5cTmsrQxwA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 11:11 PM, Fabio Baltieri wrote:
> On Mon, Nov 24, 2025 at 12:00:39AM +0000, Fabio Baltieri wrote:
>> On Sun, Nov 23, 2025 at 11:54:41PM +0100, Heiner Kallweit wrote:
>>> Thanks a lot for the valuable feedback!
>>> I added the SDS PHY reset to the patch, and improved MAC EEE handling
>>> in a second patch, incl. what you mentioned.
>>> Patches should fully cover your use case now. Please give it a try.
>>
>> Good stuff, applied both patches, link is stable and link detection
>> works correctly.
> 
> Hey Heiner, were you planning on sending these out anytime soon? Just
> wondering if there was a chance of them getting in this merge window,
> though I guess you may want them to sit in net-next for a cycle.
> 
net-next is closed since release of 6.18 end of November.
It re-opens once 6.19-rc1 is out. Then SFP support will be submitted.

> Just curious, no pressure.
> 
> Cheers,
> Fabio

Heiner


