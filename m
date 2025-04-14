Return-Path: <netdev+bounces-182258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42541A88564
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34121670E9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9498D42A8F;
	Mon, 14 Apr 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4e+6L91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FFC2FD;
	Mon, 14 Apr 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640203; cv=none; b=BCN+BkYq2SktATsVQYTsxJHV9Ya/ZBf1NUYdZPMiasRjjrxmFrjxiFCLlICLd87spSRcDjBqa6iyk7xOqL42h3+s5ndl5tQG+6DXWVxqrkpr6Pw06N0xeoTjt44At4BUiTYydDguVtm1ppJLTQ9Qdy6awzFwpiJBvCUxALKHu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640203; c=relaxed/simple;
	bh=diwh9sJlAZ6JHvbBFHjJH33QtdeJPgUadGdsqmCAdfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpCc/+1irMEHTVNyb/AQ0AFGUcsxz6W+NLkf/PM/T75wAmoeW5IPc8t/ln+0cF5pVRBErzaUmq1Xo5crnTxl9c/kymFMHpzIfuXRRPWrYIm42HkRO6W7MAMhiA9DX+uqYkhao8kuE4SsNfepeSFG60H7GsyGp0bYLXU9exXkS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4e+6L91; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso690878166b.1;
        Mon, 14 Apr 2025 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744640200; x=1745245000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diwh9sJlAZ6JHvbBFHjJH33QtdeJPgUadGdsqmCAdfM=;
        b=b4e+6L91zeggrpOwJiiLJHlL2w7B2JppKvYy6VvGXWj8CkzHmjzTvpaEcSL4Nw4A5H
         /6KGD1JDcdKi0PWTNXYUzmEWjOAJ9I6YzSSvIy5w2g9OJEW8VyRvj1BPPPtaxoYu4YYo
         a+r17gOyd1iWQfJ093vOto+jxOe/EdDl+QkGWv/yqvKqi1J9WtPZeDeZwxq9HPjI2/Bz
         Q4yo+F/pn6CrEo3TMAW37Es4M80Io9qcxuVkxEaFP8eK9X3Tj9JAvNK8vEQFzTY7qOBc
         EX5QCZTK1snfTmWzjBODu57UAumdvZ3SE5Ev8q759t+HyqB4+wFyyfCgFBfY8XXqY0rb
         4rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640200; x=1745245000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diwh9sJlAZ6JHvbBFHjJH33QtdeJPgUadGdsqmCAdfM=;
        b=aLNxYG1rh3aY1Vu0BEalt4fcwTYQveUVnASW9Z/nOCERwTOx1tjh51XX3B0RQcihyu
         59Qqsves3oTLA22sNUriThaRqzEx2BIHBJ9Djox5KNQCgaq8eg9niTLa8K/NtR9RXGu1
         gnKRwpkB95jMrrhqkOp0hT/6O3VsFqUEUWA0lCydGJ+pGs7HgoiX19Od5X/3KvEB6WMW
         9e607bx5FpewMv+UTtusIMstMOEK6g4fMy3OZF002CYM679pDeHcQnNPgSBbWqEdsISw
         jQiXw8gRAs6CN0Ib39uHjCPKw4yIqKa4yxsDrSbZbWRaqoYnHBtcTVnlOrLSRj1lugsX
         UO2g==
X-Forwarded-Encrypted: i=1; AJvYcCU+93o06I3mpAf6VUoTQFPbKbQ56/Je2hrHMuhY0isP3oJVGdNLO3r5zP2ayFnaCPHx9wL5olrcGe67Bbbq@vger.kernel.org, AJvYcCVQDkxwqUyd0jqILg9OnpyaL2uexqlk7bfhq4yuCocr0tlDbLe54X0mEYua1mMoZ3bP17ED9q3Uh5p5PoFMzI00@vger.kernel.org, AJvYcCWNhdmLNjh1r3uc4zV7nKhvszRJng1WFow9UIpkowoirEXFGyyaKgLGms3JqLKXZKIVKfTOOw5ZKctw@vger.kernel.org, AJvYcCXrbQnitQX5gt/HM/2R9BJVBYYO8z/y1xC4DM2669etc9kNsD+N4vg9hwZ5qNkoe9v99pfnRxyA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3/lMLrioRodzvNRGkA5csD0T+aRwYHe5qcyDynXpXgv3M2uX
	PiNRhQ4ETHsYE4N30EpYt0EAJE0B74Cizdy6JlazSmXQYouo/zFZ5InoFED2CuSqdLMw91vH0Ga
	MYihFa5ddIL2BaQIpGEHOLuTcC8E=
X-Gm-Gg: ASbGncu4sxa14NMAtzXGUMJG1DmfFahCy9krXVjMXfad8FaLxFVgjFJLf2I8EZjHEgZ
	3hLooehrEjL9+iWPIkb2Fp+PDSqtTBp2pJaDKo6RbfP4o+GKTxyfsb3a21TEvwLc575SFt8h/5h
	rVZPN5zqMotRCzdKuc/gUn+A==
X-Google-Smtp-Source: AGHT+IF/dyYWGh6vTRn9WISWNs+JWALOiRcPmlW21EE0KFIxAgk2tzzM8tV4hVd0FH0lpQbw1g1Vk0LIeGq8/fYkMB0=
X-Received: by 2002:a17:906:9fcb:b0:ac3:f1dc:f3db with SMTP id
 a640c23a62f3a-acad3482777mr1214389166b.13.1744640199893; Mon, 14 Apr 2025
 07:16:39 -0700 (PDT)
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
 <CAHp75Ve2KwOEdd=6stm0VXPmuMG-ZRzp8o5PT_db_LYxStqEzg@mail.gmail.com> <CAHp75Vc0p-dehdjyt9cDm6m72kGq5v5xW8=YRk27KNs5g-qgTw@mail.gmail.com>
In-Reply-To: <CAHp75Vc0p-dehdjyt9cDm6m72kGq5v5xW8=YRk27KNs5g-qgTw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 17:16:02 +0300
X-Gm-Features: ATxdqUGEaankkXek3ZluXxWOTF2i2W4gz9IvUXvOR0KII6dhJTmYpm-3LghKjzo
Message-ID: <CAHp75Vej0MCAV7v7Zom8CXqh3F6f3QXevW93pOkXSLEZn7Yxfg@mail.gmail.com>
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

On Mon, Apr 14, 2025 at 5:13=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Apr 14, 2025 at 5:10=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Apr 14, 2025 at 5:07=E2=80=AFPM Ivan Vecera <ivecera@redhat.com=
> wrote:
> > > On 14. 04. 25 1:52 odp., Ivan Vecera wrote:

...

> > > Long story short, I have to move virtual range outside real address
> > > range and apply this offset in the driver code.
> > >
> > > Is this correct?
> >
> > Bingo!
> >
> > And for the offsets, you form them as "page number * page offset +
> > offset inside the page".
>
> Note, for easier reference you may still map page 0 to the virtual
> space, but make sure that page 0 (or main page) is available outside
> of the ranges, or i.o.w. ranges do not overlap the main page, even if
> they include page 0.

So, you will have the following layout

0x00 - 0xnn - real registers of page 0.

0x100 - 0xppp -- pages 0 ... N

Register access either direct for when direct is required, or as
0x100 + PageSize * Index + RegOffset


--=20
With Best Regards,
Andy Shevchenko

