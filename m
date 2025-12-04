Return-Path: <netdev+bounces-243674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C954DCA5562
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 21:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 360C6320D601
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596431ED7A;
	Thu,  4 Dec 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRXAcEVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E431ED77
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879544; cv=none; b=Q8xoUqN2nc5nrQdl8AUg686F+V/qsvTB+A94hj3u5493fT3vVip2KaoncHxf1R41Z+kaZxt+8KiA4fkB18wkw1AEST+eGJwTNV7E60wlpuhT741x/ehodpe1kkHqSn/3LxLmWB+a5v4Suq0K5QpSqkTtumGLvfTseraMoYcrgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879544; c=relaxed/simple;
	bh=FqECIFzimQFLDo553Kuio3LnpAOxlwgFBuOe37zk2r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MmM94PiRXkBu/fRdWBRIFgOYk6FGJ/pdpj8NgohlADX5VZH+l0VRlncTvIKFZRW4vw+AqDw0x1aGo0RSLSOkHJW5QnTyu18/AViBzHKxLUiMm2d5TxgxX5r4sBkxiv/JfG8i/sF3/eyPtu9uHnO7SszhK4Y2FlfWz3IlkBHOhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRXAcEVk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632b0621so9653045e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 12:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764879541; x=1765484341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LpCDQ/db8LJcYR39Q7NPIwmJrDQEsN3xPH9fje0B20g=;
        b=JRXAcEVkSUtNSVDYDhYuZhqCje8ROMg0CeS3X2xE+XSE6ATPW/1+ehinWYgE1/abTW
         WqdS76IczL4Cw2fBRVZMmbjMKNgeZspMn7F8AX/yxI+8KH7uolEjK8KwXiYjlyQhdmMT
         aHGXQdrl/VuS5fhFfYralrWL2/KW9zp+pkYZi365ACUH9B5oDA013gf2jWp6z4NQRl2a
         HND6cxXfLPvFcEeno1pEsGSYYl4bMNcwlt4iK5aWvd3XyiQqcPg4+M8/fjl0oHPNgBdg
         eDSJTbhHi3G9asKzOqMDmj5SeLlP7Zsapn1QV5K9wk0U7xndOBFuvAIZeGcFnBPX5KfK
         sj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764879541; x=1765484341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpCDQ/db8LJcYR39Q7NPIwmJrDQEsN3xPH9fje0B20g=;
        b=SmRI1BE5ELjqVyvQ/r8s+6Cl1vR2UpnWSiK+gl/wHmR87nm/ydtqrkqOK29qI2kIJf
         /kXFZ3AMdVWDcIQpOJIzsahPIRFzdbHt99jlOVR/q5WJoEwK7N4OgzTxmysBKSAhclQy
         F2e7AWz+QPnmodE2dHgbnkAtXEKfXWkGgswFqzszGPr5SViMQwoOgYA3phzLALf36vIx
         QX/rsfW1tHsh/P190WIl9Q+H+Nd1utJqIx87Wy3mRjBZxWeCpQ2cW5C3PY7lTLVwniDc
         2ItH89HCog4zw+45agP47lGSr1cE2EpaAfkZsr/IcgMieAoi3LPobmZrnD0OyBpT+vPb
         7Ubg==
X-Forwarded-Encrypted: i=1; AJvYcCU39pT8GjFMuIo2k5qT/W4pFJYZsdVa8cw3tXI6UPzWpLHc5vLZ9JPDB8KP9DXjp4XrHe4DIB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbxUCHkaUPJGRI5XfujG89mgnUaUwMsluAkUeaqq3vTu0Rs9fk
	W33pbGfS2PjxHkADrIXakkE8JQKNKu0kBW6aCa+chku9lZvAaGB6xaBB
X-Gm-Gg: ASbGncsO+Rb7jY16W4gSTQcPuQpbZ/PD9jmqLa3oipwdVqGLq07xWhLC3JlfzaueXgw
	cgWlDF5fOTVfcRQMeOgHE9xnJU3hvf7nV3g21k3Iyp54OCi0VII9EzaWR2fzQ66NeYwWJ/Ki3YS
	C611cUzkKajm4pqI+HwHbZk9E551/N4htQiSBB68In3baz0yghFtYCcrPtp/UQEglIuGHkDLoK3
	+rZ1wEVvdxxrrvVqSQu4AO2mMsDZdoo+Stq/WucWxq6iU9K/OpuOu5Ze3Afhy9Vui8iiPk7kXvc
	KYXOWddtSn2Q9uNrbr+gdrn2RXONv6JFosc//hJwzOwyHg7HXROcCMhZHtPrRBnbq7mHg5ooODY
	lf2i3LGRXCOfZxCxy2GwA29sQiPeshMzH7KnnK/ckg4T07IYBLEHLfnecfWC0LdFrpjLBSVZnpQ
	bLt4zJ6wiJDdbQ7bkcokfMmXDyiQbJDBuZxaN1lQ9Kx85Nsw2pgNUoAy1bx1UlKj8gUWaj7RwvA
	uIndP5WE1U8ESVS7dBmVsnoSWqFiJONkiCPTj+A76qAQIxBGp/Vvw==
X-Google-Smtp-Source: AGHT+IHrNC9OdUQrhQ8nBiv9qzQ+KjxxeXpPSuxWRiF6f+odXex6LxY097hRNZmDyfbc9xuawp6mSg==
X-Received: by 2002:a05:6000:26cd:b0:42b:3ded:298d with SMTP id ffacd0b85a97d-42f7319b321mr8106325f8f.32.1764879540953;
        Thu, 04 Dec 2025 12:19:00 -0800 (PST)
Received: from ?IPV6:2003:ea:8f3b:8b00:ac52:b5ce:438d:dc86? (p200300ea8f3b8b00ac52b5ce438ddc86.dip0.t-ipconnect.de. [2003:ea:8f3b:8b00:ac52:b5ce:438d:dc86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe90f0sm4938840f8f.9.2025.12.04.12.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 12:19:00 -0800 (PST)
Message-ID: <b9e48b10-6654-4239-a170-8cd7bf77fe0b@gmail.com>
Date: Thu, 4 Dec 2025 21:18:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
To: Phil Sutter <phil@nwl.cc>, =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>,
 netdev@vger.kernel.org, nic_swsd@realtek.com
References: <20251202.161642.99138760036999555.rene@exactco.de>
 <8b3098e0-8908-46cc-8565-a28e071d77eb@gmail.com>
 <20251202.184507.229081049189704462.rene@exactco.de>
 <b25d0f31-94ef-4baa-9cbb-a949494ac9a7@gmail.com>
 <aTGpceAK0CRgKDPG@orbyte.nwl.cc>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aTGpceAK0CRgKDPG@orbyte.nwl.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/4/2025 4:32 PM, Phil Sutter wrote:
> On Tue, Dec 02, 2025 at 07:06:02PM +0100, Heiner Kallweit wrote:
>> On 12/2/2025 6:45 PM, René Rebe wrote:
>>> On Tue, 2 Dec 2025 18:19:02 +0100, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> [...]
>>>> - cc stable
>>>
>>> I was under the impression this is automatic when patches are merged
>>> with Fixes:, no? Do I need to manually cc stable? Nobody ever asked me
>>> for that before.
>>>
>> https://docs.kernel.org/process/maintainer-netdev.html
>> See 1.5.7
> 
> Which points to
> https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-rules
> and the Option 1 instructions read: "Note, such tagging is unnecessary
> if the stable team can derive the appropriate versions from Fixes:
> tags."
> 
This is about something different. "such tagging" refers to providing
applicable kernel versions like in the example:
Cc: <stable@vger.kernel.org> # 3.3.x

> Cheers, Phil


