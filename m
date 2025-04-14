Return-Path: <netdev+bounces-182236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A01A884CC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2DE1617B2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE45A2750F2;
	Mon, 14 Apr 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO13bMva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E17274FE8;
	Mon, 14 Apr 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639148; cv=none; b=GjkVLBqDBYbxbjH1895C84PHWndhIwQZhsOGXt9FqSfAPsDHB1eQ0QbPivlaf5hvWsK60FavavGKwx3lMFIFM8uh7guoGYDRzng86BJdDJdGH7aNqVqzdmag1ahgH1gi0fVMqmtLbQ4fjwa/pAGWxdiubkx0GfdluaDUYMhfOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639148; c=relaxed/simple;
	bh=VEDOUNMnaxbsrmXycxHqrWIoLhEOlcx/tiT9QK99SsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFF8nNz+WPIibxvrVLMkS7WLE73KQLyeGhKrZ4bH3DJG9gKwC5oL9ET0lhmaW8jB64asyU9vnaEaVIbfzQtjmcSmNqsoq9pbzoTf46SVPiaXp8NUudZitK7aE73LaTYtqzxH+rOAl6mChc1djTqkbUQGLUVoCkfEEQDmYoqdkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO13bMva; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so111936a12.1;
        Mon, 14 Apr 2025 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744639145; x=1745243945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QacIaZLbaqsscws1AyL4TMSihH9iJ/fQvcmBOW8YP9Q=;
        b=YO13bMvaNcXOSax82FCmOREJtfu7fUWhSu/pEex4Rokgu4wlBbrrC8bzzeyDhAB8Hg
         1I8OGlkU6OSMUNJSHO/Lgpi3TOc7x6SOda+/Fj+ckZa9qUoN5syEohHXhz390gAapoDC
         8Cxx6TzW3FAXZPyCvJvk5PxGj9uqZClkC9KV+JQEAWCoZ73HsBddPKMgxvqpeZgxyHNp
         rfLm1jq4UHfB+c0fzsxLB+CInTVF/F6ZSgRmBdZYM0Rw4UaMtXjlNtSGuqctaHI7Cbyz
         GMNgg8ElqNylgvxeWjc16eTa1TjIwS3Emg7mfKX2jSAxS0o4hEzMKr3m4gCiTXi++Llu
         D7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639145; x=1745243945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QacIaZLbaqsscws1AyL4TMSihH9iJ/fQvcmBOW8YP9Q=;
        b=XNvzQ4TNFhTuLuzxNI/LHpTwT8zmMte59VRh/BQWtqXOd9KCFDDhNk8AvTBLYczXsZ
         8yUGr+umjOcZq8s62h6IGXLv4xk6zFLXNdsmcXPefGx3xZfCqB8rrEig9A76dhlwBywP
         56w/yYBkt2Lc9EDoktPTPyZ/l06bNamrQA/YYUvO1MpJdsQCTSRyGAg7FFPtYU5yfu7k
         12u0a/APWt00YHRY9supNfQ0CAc8SaaruowHFXApOXCZcTGeOOUwX5SNV+0lJ/SppunC
         J4HM01hH9De2SvE/h/CTEYAfNCaeJSzRoLX9i87R4ngTvXe3Hv3lqXpI18DfPrD7Nqsi
         0zjA==
X-Forwarded-Encrypted: i=1; AJvYcCVX57dfQE8Ew/rjh0yfvC1Yf8zhzQoxSEZCDBEwt4EZzjX/J3myEnNXJypZv+3jZPVo4aoXj1gA4A76UguF0g9d@vger.kernel.org, AJvYcCWO15AcfrJP9oISMgNr8dpxh7erR83J3/xeesmaJrs2vz2JKMRhesFoJdOQtd5iIReUEQMNuYKf@vger.kernel.org, AJvYcCWsLMRj130aECT77eikrcxXHNtDzao2oFBV+/0vkw+BOTjUFa03tSL4OyFCZ6N2ExVQE3vJPsi0EDrQ@vger.kernel.org, AJvYcCXpKLbApKM7VGbsfwlRCKzFvosGRuybVbtLyVBuks4E6y2/RmwzRJDTjDLXa1SmzP3qcmWnF922qfB1ox0z@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJUy3OvM2loSz63Z3iFBB2qFNrZBPHotZSFQ4zg74IWicNTtq
	I419A9bUUvTxVyDZcwdFxch4etzDnj/P5mSlhMIoIMJWv6RJnBukL5BqJohdIiiBUjkHfWaB4Y9
	3b+6KR3eMaZOX9cIo/0AeFl0gmKw=
X-Gm-Gg: ASbGncuEKG49eiVaFeN0TMh69s9HDd6mfCq3NkbVJVICHfmeDaYdSZWBE4btJJ8W1HO
	vSkmhLJnEAPmWn+aTW3e8xhMgFAOMor6Nhi6SxY9aZYG0uZ3kO5RPsrYQr/YolYIUpgBduKOUWq
	i6BEmNttllx31TlnJiFO0G4g==
X-Google-Smtp-Source: AGHT+IFuXaUtcb1kNEwtSt0eSq3r2v9Vpj1oFgxM95yLqytmSAvykRAVk7wzhna1x5muWsxUC7LbOy0f3db5f9H++iw=
X-Received: by 2002:a17:907:3d9f:b0:ac7:18c9:2975 with SMTP id
 a640c23a62f3a-acad36a5dc4mr1100303566b.48.1744639145054; Mon, 14 Apr 2025
 06:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407172836.1009461-1-ivecera@redhat.com> <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com> <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
 <Z_ys4Lo46KusTBIj@smile.fi.intel.com> <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
In-Reply-To: <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 16:58:28 +0300
X-Gm-Features: ATxdqUEVdYSimMgT8azBcfe7VnpzDgPZRtxxbhfjgZ33xxF6MeE0FgTvH7anJts
Message-ID: <CAHp75VcZrop0tvyX4Z-Gm3uOUKMbrAWxir2THuBqg8DfhN=hmQ@mail.gmail.com>
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, netdev@vger.kernel.org, 
	Michal Schmidt <mschmidt@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 2:40=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
> On 14. 04. 25 8:36 dop., Andy Shevchenko wrote:

...

> >> What is wrong here?
> >>
> >> I have a device that uses 7-bit addresses and have 16 register pages.
> >> Each pages is from 0x00-0x7f and register 0x7f is used as page selecto=
r
> >> where bits 0-3 select the page.
> > The problem is that you overlap virtual page over the real one (the mai=
n one).
> >
> > The drivers you mentioned in v2 discussions most likely are also buggy.
> > As I implied in the above question the developers hardly get the regmap=
 ranges
> > right. It took me quite a while to see the issue, so it's not particula=
rly your
> > fault.

> thank you I see the point.
>
> Do you mean that the selector register should not be part of the range?

No.

> If so, does it mean that I have to specify a range for each page? Like th=
is:

No.

Yes, tough thingy :-)

>         {
>                 /* Page 0 */
>                 .range_min      =3D 0x000,
>                 .range_max      =3D 0x07e,
>                 .selector_reg   =3D ZL3073x_PAGE_SEL,
>                 .selector_mask  =3D GENMASK(3, 0),
>                 .selector_shift =3D 0,
>                 .window_start   =3D 0,
>                 .window_len     =3D 0x7e,
>         },

Page 0 shouldn't exist in your case in the *virtual* ranges. And this
struct defines the *virtual* ranges.

>         {
>                 /* Page 1 */
>                 .range_min      =3D 0x080,
>                 .range_max      =3D 0x0fe,
>                 .selector_reg   =3D ZL3073x_PAGE_SEL,
>                 .selector_mask  =3D GENMASK(3, 0),
>                 .selector_shift =3D 0,
>                 .window_start   =3D 0,
>                 .window_len     =3D 0x7e,
>         },

--=20
With Best Regards,
Andy Shevchenko

