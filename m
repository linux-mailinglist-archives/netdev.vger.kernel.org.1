Return-Path: <netdev+bounces-148311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA29E1164
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96B1B22557
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF8C13AA27;
	Tue,  3 Dec 2024 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIWS2hT+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA717555;
	Tue,  3 Dec 2024 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193433; cv=none; b=Q607tU4hMNIWRfRrhDygkhkeb9uCgYAaUSQWyLa6tHmMu6v5189yEWWh97z+NFeCZWG1c7n/68OqybTsEBGx8++IMM5YO8kJfY52O4Pz0nay6jtlubWziPdYb2jbcG23HWoP/kQeiSzZNYMUb+FXNwOsbmDjshsTSNq0J2LPO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193433; c=relaxed/simple;
	bh=6Ja4w+58kzvqSCMhVlQfCP1pDkXx6r+Q8RYdMY+p/rc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ki7NM2iLxwV6bC2cOmTDE/Vyz4XtHYj0VfqTgRnVPNdqsDWLDkX1sremirehpxXqp1KHslbXXvchLWRjyhN1fZsnnpMr25c7MRRC2ic708Uz8vxZGtv+uBNLJBMd+DRHTKf9IC03IGGE0vAL8TL6HgemmtmPn5hOTZtFtGq3mI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIWS2hT+; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4add8596cccso134806137.0;
        Mon, 02 Dec 2024 18:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733193431; x=1733798231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GtLF14vm7EJeeDXSwAcjR67YkypYDnF88/MBHtM834c=;
        b=gIWS2hT+sb/Y1ePZheApd1reoB3eADE5Fi03FRaRPrGBYwwxz6jhNiHFPH2qXH8YAr
         fRTz1NOGQZVwzLnRHiWNLS8PtnOAr+6ghe6WSsUk2qMvaRKQcwiae0zax/P8qy3bnPWP
         dqQl5OEgF827Caz+iYOQTt4EMIyZK5uMqAw3e/Uhc5+87eGEk1ILdHQ6JWRPU6QD0Hh6
         OLJfU19KnZU/EAeJ1yFOd5nY52Ta4jloZ3NgGnBrJbP38lY4ilsCkeHucwKp3YIOG/yE
         8n2yDYnfGGKtWAS+HpDJGHZK2V66Clu2dQ9/xmMS1K83qk4D2Q8B4xBx1sSyGnd8pc3H
         fM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733193431; x=1733798231;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtLF14vm7EJeeDXSwAcjR67YkypYDnF88/MBHtM834c=;
        b=nbJS3sUg7J4+90H0Nxhb+0i812ig2I51tFy69wRjHeU4c/2lUTaoRPhiC5FjHWjgrc
         tyXHlIzn9rLLX3j0STJs7m+UxHAVFF2zPbRDdL/5JvjQO6tXdUv6D0VlU2kgzRTPfkh/
         OwgRLEm2StZJGEm6Cw7fyYH0qBAk4H1i6pZsmwrJx4B41V4GV0cMC8EUOh1tjmHSzFUq
         Gjpuv/OhuydXS0bQNb8NYl3S3BsIr7G5l+OVmdij4Z1SsXYsXs8iz0qOT/7QWERDg83v
         GAXaE+lviUW0Oj9RI7huTJj85xhlGYYjQfl3866oMcBmqF+HGTSPRlkxnchxDW4g5CHz
         Z9nw==
X-Forwarded-Encrypted: i=1; AJvYcCVmE6dPiSSyMwb9IX+MM5OtA7U0FahpB6rZTFCZ6I7WqtgpIGDsMbATFSbogqbxHiaLF47EKgoeuzSt2BA=@vger.kernel.org, AJvYcCW6qPKh+8zxZcsoAV65BhPBNUAvXW7NTn5w13f/bVV9nH8DwWLKC8dqm/oKVtbvlEGuJe6Ab26q@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaDU6B0v++BdEGB9YcdtJ7cp+q7WcBN0PaF0rfeWG3djPI5Vk
	tCVbTfQlGd9EWqo/Qa4lJn3P7YCGllq/HuqTTJAmiUI85vMLeaIYxizFvx9DQz+B9/v04RtmGuR
	Jsu6v1u7Y+rIOewCw6qhviJZntVE=
X-Gm-Gg: ASbGncsXabeq/tLB+5ENSdyItTJdNvSYY3f0xsHF5TmsP+f71iYCn/aNYufkq530+Kd
	Cl6ytieb3Yg5NzgOPsm1fmjpivHkU9Dan+A==
X-Google-Smtp-Source: AGHT+IHReezRoW3eC5Hg8cWzDQ7b13LwHDtgUBT/+WZ1p3E0aok+cX8yIGzzysN0TH1L+BC/T0e88MLB9Q/MSYvGUJs=
X-Received: by 2002:a05:6102:3707:b0:4af:3d99:f591 with SMTP id
 ada2fe7eead31-4af97311588mr602372137.10.1733193430820; Mon, 02 Dec 2024
 18:37:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5LiH6Ie06L+c?= <kmlinuxm@gmail.com>
Date: Tue, 3 Dec 2024 10:37:01 +0800
Message-ID: <CAHwZ4N0gbTvXFYCawbOUFWk7yitTeAWwUmfmb7RU68n-md8x4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: phy: realtek: add dt property to disable
 broadcast PHY address
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Content-Type: text/plain; charset="UTF-8"

On 2024/12/3 8:04, Andrew Lunn wrote:
> On Tue, Dec 03, 2024 at 03:50:29AM +0800, Zhiyuan Wan wrote:
>> This patch add support to disable 'broadcast PHY address' feature of
>> RTL8211F.
>>
>> This feature is enabled defaultly after a reset of this transceiver.
>> When this feature is enabled, the phy not only responds to the
>> configuration PHY address by pin states on board, but also responds
>> to address 0, the optional broadcast address of the MDIO bus.
>>
>> But not every transceiver supports this feature, when RTL8211
>> shares one MDIO bus with other transceivers which doesn't support
>> this feature, like mt7530 switch chip (integrated in mt7621 SoC),
>> it usually causes address conflict, leads to the
>> port of RTL8211FS stops working.
>
> I think you can do this without needing a new property. The DT binding
> has:
>
>             reg = <4>;
>
> This is the address the PHY should respond on. If reg is not 0, then
> broadcast is not wanted.
>
First, broadcast has no relationship with PHY address, it allows MAC
broadcast command to all supported PHY on the MDIO bus.

I can't assume that there's no user use this feature to configure multiple
PHY devices (e.g. there's like 3 or more PHYs on board, their address
represented as 1, 2, 3. When this feature is enabled (default behavior),
users can send commands to address 0 to configure common parameters shared
by these PHYs) at the same time. And they can configure each PHY by it's
own address without influencing other PHY too.

> If reg is 0, it means one of two things:
>
> The DT author did not know about this broadcast feature, the PHY
> appeared at address 0, so they wrote that. It might actually be
> strapped to another address, but it does not matter.
>
Well, that's possible. A misconfiguration on DT with only ONE PHY may
just works, if we disable this feature by default, may cause some device
stops working.

> The DT author wants it to use the broadcast address, it might even be
> strapped to address 0.
>
Again, the broadcast address is shared by all PHYs on MDIO which
support this feature, it's handy for MAC to change multiple PHYs
setting at the same time. But each PHY must have their own address,
and the address usually can't be broadcast address (0).

> Am i missing anything?
>
>       Andrew

I would recommend to add this feature, because it doesn't change the
behavior of this driver, and allows this PHY works together with
other PHY or switch chip which don't support this feature, like mt7530 or
Marvell ones.

Sincerely,

Zhiyuan Wan

