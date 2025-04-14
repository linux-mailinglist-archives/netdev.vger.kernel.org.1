Return-Path: <netdev+bounces-182374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63918A88965
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8353B1727
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01EB288CB1;
	Mon, 14 Apr 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiqoNO8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D6270EA4;
	Mon, 14 Apr 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650613; cv=none; b=eYHfZYBNnkLk2HcBbDTDRYNgtQF/G+u8WP0bByEIuecWMeXUroqNc0LrAg2WelTeTl+5w9n5fW0h2Yct4KtagSUqIUZ+vpK3h9TJU/rlzYC7ahyxFgDYVKic/gHZAT9AY4wQor/19KgMXGjvUKokg9yXwjMUM45GcZWDpdrAnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650613; c=relaxed/simple;
	bh=FAlvD9qGBi/bC3IDlLdVswbdnPKWhDIbA50Ndmh/eMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivPG7D/WmYNZ5FI4PDr9sQ9CdN/u50Lut7lO7c27twd/Gc7umIMCBq2/+VuDVd9+rSX4b3BsHCOD45n02OK06EpbFcAcYVJkuKxPP5IoIQJvFdkgHpVf8LL4x+mivt1oMXMaMnW/e29qN7o7CjUwbI4ixg87IB6jWRzl3tCP+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiqoNO8c; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so821626666b.1;
        Mon, 14 Apr 2025 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744650610; x=1745255410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptCoH/mbfNPZTY4S28oJpjLyfUNDXfkMFU+31cHM30U=;
        b=QiqoNO8cu/KHscIcPKEQ8JAlX09IRyr3Yd+g74Aaewpqgd4jZ6klgAbyjtCgMWkl8P
         RgoD0jSxUX2gP18p8FDh+5xjoJQJVgZVMs1wWtJG0lJmYe41QbJ34BaAEcjEadcnOs24
         QHvQ1j/kLmfkkj3yML/YhukyIkWk4i8k9uW1M0rJBJojyobfsc133kwlwc5XsRnO0Tdu
         KxG/KEc1DDKYzhZo5rD8MUDl1RJX9QO9G6Gs9+QGj05LlWyPJxH8ytppHIqaUv+QJg2D
         TaiKXJGjnB+TdA7+m6ZzwaJyYvC+R5hrdeVA7LG7yveqVR7RQnVfSMeKNyIWe8NVeTSs
         E1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744650610; x=1745255410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptCoH/mbfNPZTY4S28oJpjLyfUNDXfkMFU+31cHM30U=;
        b=IAALv1Z+cCX2HXqm5BaVwhiCMdFa1KRsz9WySvBJQnM9gAz8z4066eLB3zsGJF6KZU
         97/2l9hcPU1MqGVeKLOke/UUlwKDkc/xdk0nSBnu8nUQyo9FXscmssPvp8odg+If5D93
         b/RtW+MaS4Wsm0WXGeQQ+6uqEjcJVXiyr7el+EDTaBW3el3tzEO877OhumEX2uKkWEvs
         eEJ5P2Bmoalgw7Ms90dS89Wh2H7PBdmrW9pu+J4PvFvA3H0kcs3OeL41PED7OeNt96Ec
         wAQDTAiDn51QRwyqABFxTku+yPQPhL469GMP8wPCK660t9mzkVapsABoTKmRnq4bDFDn
         poxg==
X-Forwarded-Encrypted: i=1; AJvYcCV6A1ohmPbJQe7CqzUZrHHUMQg/tIxkZN6c3kvTRNMaBzMuTb2pNU76JReUyX+qaNdz5Eecj4PI@vger.kernel.org, AJvYcCVHtI8xzzmV2eSDW7bnxkZGrvQ9XS+I4soZoHDAqeJ9vQA0oihBvSfN7kZ3w8fZRqhXkBRXDAhXL/Li63PL@vger.kernel.org, AJvYcCWrmMMIlQMnlorpWCvr6+ZHO84mq1RTRJm1/0/EX5KXtHqSf3wMgnFgxUUwhpiSHnVClj0/LzMXF8jD@vger.kernel.org, AJvYcCXs4SbAGsE9g2f+eRKmyQn/Xpo2NCopNl/fgYT44ouvqhRIyuTQQWVspLGXf8lqv7lw+/TUgsa7fWYYpUldXyBZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNWe6eT2MAXHeqrfpvawTWVMVSj8xIrRQVC9Wrle67RgOLKMm
	6FZFfvP5q9cpDiCwopy6QLY6LXI4bf5+M8go0HNGbHA0NByZ+TYx+oqywBuBI4dYx2YAG+tUkXK
	6F9f70T4+wSnd4oncNH5BzldPGe0YgiXVLFQ=
X-Gm-Gg: ASbGncupgURfiLAMg+qTm9LT8p0Sq/bP3/pAqxuML8H0fANYv1Vlv1YmSNynj71fAiA
	Skim+Dx2fVZync1L/eyW1S4Cl/stwuZIQQD03fZMid6kCmonNeVpR5Ui2oMK7NdPsj/b7q1pkVd
	RkL1f6QwrO2eFoc+3Tq1fzHw==
X-Google-Smtp-Source: AGHT+IE10rNQRIF2h7h0sW56pVRl3UH9iw/JjGfWGqw2oImvoIxqgE+Ipm7pwF2M/aj/ZmbfUKqcTh8LUsJ7g7ChCEE=
X-Received: by 2002:a17:906:db05:b0:aca:c4a6:cd90 with SMTP id
 a640c23a62f3a-acad34395c7mr1288965866b.5.1744650609941; Mon, 14 Apr 2025
 10:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407172836.1009461-1-ivecera@redhat.com> <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com> <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
 <Z_ys4Lo46KusTBIj@smile.fi.intel.com> <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
 <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com> <b54e4da8-20a5-4464-a4b7-f4d8f70af989@redhat.com>
 <CAHp75Ve2KwOEdd=6stm0VXPmuMG-ZRzp8o5PT_db_LYxStqEzg@mail.gmail.com>
 <CAHp75Vc0p-dehdjyt9cDm6m72kGq5v5xW8=YRk27KNs5g-qgTw@mail.gmail.com>
 <CAHp75Vej0MCAV7v7Zom8CXqh3F6f3QXevW93pOkXSLEZn7Yxfg@mail.gmail.com> <ad5ada81-d611-41bb-8358-3675f90767f1@redhat.com>
In-Reply-To: <ad5ada81-d611-41bb-8358-3675f90767f1@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 20:09:32 +0300
X-Gm-Features: ATxdqUFYN8tmWUda0Ypk9VQ3-hD55ed-lfLUKHgTNK0s5T1fXVI2QCwvL3PGsTc
Message-ID: <CAHp75VdkLnm42DS2+kebYUWyXAhyNgswwDNynNJ-weo3DZ=G+Q@mail.gmail.com>
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

On Mon, Apr 14, 2025 at 5:53=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
> On 14. 04. 25 4:16 odp., Andy Shevchenko wrote:
> > On Mon, Apr 14, 2025 at 5:13=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Mon, Apr 14, 2025 at 5:10=E2=80=AFPM Andy Shevchenko
> >> <andy.shevchenko@gmail.com> wrote:
> >>> On Mon, Apr 14, 2025 at 5:07=E2=80=AFPM Ivan Vecera <ivecera@redhat.c=
om> wrote:
> >>>> On 14. 04. 25 1:52 odp., Ivan Vecera wrote:
> >
> > ...
> >
> >>>> Long story short, I have to move virtual range outside real address
> >>>> range and apply this offset in the driver code.
> >>>>
> >>>> Is this correct?
> >>>
> >>> Bingo!
> >>>
> >>> And for the offsets, you form them as "page number * page offset +
> >>> offset inside the page".
> >>
> >> Note, for easier reference you may still map page 0 to the virtual
> >> space, but make sure that page 0 (or main page) is available outside
> >> of the ranges, or i.o.w. ranges do not overlap the main page, even if
> >> they include page 0.
> >
> > So, you will have the following layout
> >
> > 0x00 - 0xnn - real registers of page 0.
> >
> > 0x100 - 0xppp -- pages 0 ... N
> >
> > Register access either direct for when direct is required, or as
> > 0x100 + PageSize * Index + RegOffset
>
> Now, get it...
>
> I was a little bit confused by code of _regmap_select_page() that takes
> care of selector_reg.
>
> Btw, why is this needed? why they cannot overlap?
>
> Let's say I have virtual range <0, 0xfff>, window <0, 0xff> and window
> selector 0xff>.
> 1. I'm calling regmap_read(regmap, 0x8f, ...)
> 2. The regmap looks for the range and it finds it (0..0xfff)
> 3. Then it calls _regmap_select_page() that computes:
>     window_offset =3D (0x8f - 0x000) % 0x100 =3D 0x8f
>     window_page =3D (0x8f - 0x000) / 0x100 =3D 0
> 4. _regmap_select_page() set window selector to 0 and reg is updated to
>     reg =3D window_start + window_offset =3D 0x8f
>
> And for window_selector value: regmap_read(regmap, 0xff, ...) is the
> same except _regmap_select_page() checks that the given address is
> selector_reg and won't perform page switching.
>
> When I think about it, in my case there is no normal page, there is only
> volatile register window <0x00-0x7e> and only single direct register
> that is page selector at 0x7f.

Because you are effectively messing up with cache. Also it's not
recommended in general to do such due to some registers that might
need to be accessed directly. And also note, that each time you access
this you will call a selector write _each_ time you want to write the
register in the map (if there is no cache, or if cache is messed up).

--=20
With Best Regards,
Andy Shevchenko

