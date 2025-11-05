Return-Path: <netdev+bounces-235925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0ADC37342
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4829342429
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 17:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9E32E727;
	Wed,  5 Nov 2025 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI4rxAL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646D33DEC7
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365185; cv=none; b=hlu25plIVX+CfAk0Nmsu1zgL7z3qGbQO7QWt4eA4/pgArrIcacxZmlYy5iPXUjDYPr4B6qGmq/i3h45U4kXkNX4jijeDwP0iEPAE/vci/6EFWGeCkTKFBKyHFbYAzyHtjW6c5ImddzUp+5pHGMkLpI84tbvlq2ygBL+1GdnGNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365185; c=relaxed/simple;
	bh=PZdlsnPhYw4N7FRXdSz5JDrhXZB2el7w0h8zMCttJhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUUGdsgI+fTaLpQRetjcOqOKOYyMvGk1HEEEMlHbPuSP27yzPZoH1QIBMycs7i/uTFRG3ED6UJFI7lRh2RRYgY4VjmvVPTGmP/Fr4hOC+wGi3JvP+4MWg6LajAPy+AFIlWTg3LOwCTzGYXtKcHdiEYQpc+btBhP7G4sChOrPmtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI4rxAL8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710683a644so840935e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365179; x=1762969979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lEaSkrsIxTKbAaHCd/3CyW+N3+Pgj45RfOqjb4KQBw=;
        b=RI4rxAL8BNtyRQyDdw2iSIIx32Tyi6rkYiWnCZH55LkrL7GZW9oSA/HaZfrNfin2BT
         ehjO4rC2aUBDobMVhQIwazBj5KdzwaqjboZbfpvd39gcxNtmv3XApxpI09Gk6/bkqqOt
         nrI+bYIlGU/VyQdoQRK9VY9b49VwmWsUJvEqFgCt3MWwO+ip7o+izhYcX/vt8J5K1nGV
         HwfoU7t086N3LM9W3rXqg4QZFt0EGW+qmgPW1uMza3K2tb/36YPa0gBnbpW5ClScoP9W
         ro4erc3wl7ig2s8hRuOyHKA40pmxNvHGxC3uNmFDf9nMWSMLP2SORfEeN2DP0CovfRkG
         3YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365179; x=1762969979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lEaSkrsIxTKbAaHCd/3CyW+N3+Pgj45RfOqjb4KQBw=;
        b=kTmxu/E90aX9PBCyDS0zToh6uuJEt6gmsmbEIV1RYrw7Lo9pZmFwRaHenD9P5IUeOT
         6X1UoDUQqPXrQaRZaonVNcFLCc8fEzNjuYTH/RsEgdCRD9XseMue4gzQpIwHY2vqorJ5
         Rx2/Q138V1PmLMZSl6tzkXHWxNlrK8PhuUIiBz3A99+HNqEC1iarb6buUY0zuu5u4R8f
         f2LURTxiQFqfpDJKzwqQ5rpxag8JUd4lLX5cUf3SnUVzMCOoq3Wai5GFBa7Yccep11G8
         IVAlXnRikhGco6X4AxQc3cFeB6EfsD7NFsNxlB9YKJevsrydodTBzKalsbDtqAXzE5SV
         FDLw==
X-Forwarded-Encrypted: i=1; AJvYcCUL1Fo4EUKKDjry9EoPPRTewFDopfZ7Xuf4N36Eq5ijTsXIx2cKc9d1630yHP2syp/zXvblgro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmawwqWzFizHFJ1/rxKWUj5g9uNGJouDq3n8XgGJvyFnxQ5QV
	Zsf8saG7xj8ARsQsw7b+vuUbA4iQDRmmUccVJ1dzrLb8uJ1od3dD0X7TleUGYuSynNlUH4a/WRq
	sOV27CW+ZexBHPN15wG7wp18x+3iXty0=
X-Gm-Gg: ASbGnctdsO69Attrl5jfJTQqI7ilRtdqbx17Qlu5+V6SPiw610AR2rv1nobOAT08duf
	5vYINqQipQn9/s6bQGNJ1bWAztOgdU8xiqEJ7mqZFVjFzwdjvmoyN+DqqVdjKIUMOgdZizzRmQe
	FfoYb+CjmiZ7mYm8HWhW+0l/oHqljkYtcR4a1lsTy7Gm+S3hXxj/GXPPNqGKIehpKwg1yY+Jyph
	RhlnRLnKHXP7mCwjd7e3BMP2SojV8d/3xPP5K8k5fS0IGtRaHQ3Iz3kG869fpK+2w2BXBQ=
X-Google-Smtp-Source: AGHT+IGciUtkbOV4HrOjJ54HhPQ9XGY8dHvKr6+yENCZnZ2xoPxoPH34lAsKvfd+H5tVgcE/NCQ51bvKiJhj7scwarQ=
X-Received: by 2002:a05:600c:4c27:b0:477:14ba:28da with SMTP id
 5b1f17b1804b1-4776201cbb8mr1857495e9.5.1762365179165; Wed, 05 Nov 2025
 09:52:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210601005155.27997-1-kabel@kernel.org> <CA+V-a8tW9tWw=-fFHXSvYPeipd8+ADUuQj7DGuKP-xwDrdAbyQ@mail.gmail.com>
 <7d510f5f-959c-49b7-afca-c02009898ef2@lunn.ch> <CA+V-a8ve0eKmBWuxGgVd_8uzy0mkBm=qDq2U8V7DpXhvHTFFww@mail.gmail.com>
 <87875554-1747-4b0e-9805-aed1a4c69a82@lunn.ch> <CA+V-a8vv=5yRDD-fRMohTiJ=8j-1Nq-Q7iU16Opoe0PywFb6Zg@mail.gmail.com>
 <bd95b778-a062-47b1-a386-e4561ef0c8cd@lunn.ch> <CA+V-a8uB2WxU74mhkZ3SCpcty4T10Y3MOAf-SkodLCkp-_-AGA@mail.gmail.com>
 <CA+V-a8snRfFrZeuJ7QSt==B5vWAyTpHzdNj0Jx6oz_aaozbGYQ@mail.gmail.com> <b7454a3f-fac8-4789-a3ef-baf341aea8f0@lunn.ch>
In-Reply-To: <b7454a3f-fac8-4789-a3ef-baf341aea8f0@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 5 Nov 2025 17:52:32 +0000
X-Gm-Features: AWmQ_bmIpv8SkaaEilsxCChU_9NJf9Wu-EpY4_wdnpi5jkjBXVmxWrlfCpbMzck
Message-ID: <CA+V-a8v_1u2jGVRRKQCS7ZvvjKORrHjEBdTthjAF91LYEhvYYQ@mail.gmail.com>
Subject: Re: [PATCH leds v2 00/10] Add support for offloading netdev trigger
 to HW + example implementation for Turris Omnia
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	linux-leds@vger.kernel.org, netdev@vger.kernel.org, 
	Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Russell King <linux@armlinux.org.uk>, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Jacek Anaszewski <jacek.anaszewski@gmail.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Nov 5, 2025 at 3:49=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Sorry for the delayed response.
> >
> > I started investigating adding PHY leds. In page 53 section "4.2.27
> > LED Behavior" [0] we have an option for LED0/1 combine feature
> > disable. For this is it OK to add a new DT property?
>
> Why do you need a new property?
>
> You just need to set this bit depending on what has been selected via
> /sys/class/led.
>
Ahh I get you now. When I trigger the sysfs file I get the below files:

# ls
brightness  device  device_name  full_duplex  half_duplex  interval
link  link_10  link_100  max_brightness  offloaded  power  rx  rx_err
subsystem  trigger  tx  tx_err  uevent

As per HW manual [0] we have,
0: Combine enabled (link/activity, duplex/collision).
1: Disable combination (link only, duplex only).

# Combine DISABLED (link + duplex only)
echo netdev > trigger
echo 1 > link
echo 1 > full_duplex  # or half_duplex
echo 0 > rx
echo 0 > tx

# Combine ENABLED (link + activity + duplex + collision)
echo netdev > trigger
echo 1 > link
echo 1 > rx
echo 1 > tx

So to Enable/Disable LEDx combine feature we just need to write as
above. Is my understanding correct?

[0] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductD=
ocuments/DataSheets/VMDS-10513_VSC8541-02_VSC8541-05_Datasheet.pdf

> And if the user asks for a mode which the hardware does not supported,
> the core will fall back to use on/off and blink the LED itself.
>
Ok.

> PHY LEDs are the wild west. Every vendor has its own idea what is
> important, and adds features which other vendors don't have. But that
> does not mean we need to support all the features in Linux. So the
> core has a reasonable set of features which we expect most PHYs can
> support. I don't want to add more features unless you have a big
> business case it is needed, and other PHY also have the same feature.
>
Agreed.

Cheers,
Prabhakar

