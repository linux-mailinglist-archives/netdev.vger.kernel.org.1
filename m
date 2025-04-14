Return-Path: <netdev+bounces-182234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CA1A88468
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7067A32BF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E07296D07;
	Mon, 14 Apr 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyj4513e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474F2957D6;
	Mon, 14 Apr 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638982; cv=none; b=bgIjapD0N3+iHc97+2HczfyMto7wFwPpTOlOwCHEV5uWO6u1cedMzLEjun2s7mqo+Ekv+BT/GQKfHrIXDguK+iPV00u4PLaCctJcLs5d5Zk0LZ5HoQ7YIvjPuEZfRWT7cRq+H9jyVTwv2Ny/JAtf4Qd0Cbb3fnFw6aPPoIp5+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638982; c=relaxed/simple;
	bh=byjSjrxCbhU5uc7aHlaZTnC0DJF5shLq5b+r4tgNpok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0A69Anw0KTTDl9YQekvYT6SCZf666iz5i6rLjpNHQem8d09rpFEI86L/8gtVuHRVdJPvzYS1S1wpuVXZVGHt1VW6GIKwX+3ayOJl2zmsOzixFheoA/m8C6DAZ/8zEsxLFJp68xVATrLkktHrFRIwt40BZGrRerIDYs6MCrBW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyj4513e; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbb12bea54so868665166b.0;
        Mon, 14 Apr 2025 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744638978; x=1745243778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTeEt1RU6eyQY7vNutEMrHzrVqwSVTKDzRQxwATIcm8=;
        b=fyj4513eKAzRE2++cFFBP/ezTSebu2fuyb03TwCaTTAQeUDBGv4Vq1/4p+LHZ9x7Pp
         gMDLZDzcg8+VKTI/pgqJmuLczLvU2WsCdrMSPp0j/2grn5RI3N+P4dU/1spGIdQtylUV
         sh0dBZ1OSyEwKtDoQSRY1LBCoDa0VLc1cIU0Et51xBPoOwx+E5aumkELhKgmY+Wqheph
         25WDK2uaGV7wKKbtn3PftWUEqWWucxKDpX5XS850lOE6dOzV1M6gvZJ34JM2L6Wz5M1T
         0l08NGiITuvRzRnsJMSH7kGqzdeagByDhHOGHtLAUeYnbzuoK9BwGkXzWMq8YOVccXtz
         x3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638978; x=1745243778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTeEt1RU6eyQY7vNutEMrHzrVqwSVTKDzRQxwATIcm8=;
        b=koLZHG/JVoDeBVUkWlE0WOG9bfbFbbBm/2wNQvGXxU9N/QpqTpwvUcR2o56liIwbqP
         Vy5WtZB6joKcPNgpvaeAJd07W+xxQJYq3AxPh2nTnGD4qW3ip6f1qVB5PGfQQ4owshuO
         gEl7KSiZFTM8FEEPF/rd3KXKatMFvWdWyWSqF5bnvDSuP/iLxOpoolWAJxhReVyqfPp/
         rfGXkL6oGoMjdsP6dWFGP5GpWEbSN5nfguuXqNqM92IJwQ6THs98KXN9Vb4KNIJ2La6N
         Dl93mky2bSSd0LwGuON4mVWJZIIhDI0HrgqnJL2hhmFZ2Wkzgc9ZBtMQy3RQCjraOo3J
         F4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWHIKX/cVPLto8NTBjmWKuxfrY1qGit7aDleuCmUEVUhXaTE+Rvu1HPdOZWqmX3MeIjbPc74wcE@vger.kernel.org, AJvYcCWdPibqy8wjdwJbvoYO0V77XeJl1YV+Q9RhQIILZ6xaZU7RSJ+i6HM1bje4DjUt0ns5BAGjmQGioLAB@vger.kernel.org, AJvYcCWzk1gYspYURUmwgignkbVOXdhTiTMNspAY05UntrrBG166teEI01BXIHBwDWRB3hlRVMvR54gS5wPCyKfbYB7p@vger.kernel.org, AJvYcCXWu+f/xmmsfHDhgOy40h/b2l2JOttC7Q/pI2p1wMRGLePrq94Y+F60pXI1MWdaMQkfCH6YXEzSoJcw3Y1M@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4Pu2z6Q4Fs3EASZzJa+nK8FO0N0GmY0jFgwz8sthx2k/DnYE
	jgLlNERQrkm++6MZSDyPo/DqYl6mOMtMiDi7gqW4jPjU+BpvLBDtHw+JkHiYn1P6g8DQYlxXpzo
	1h6spczlCBFo++niexNqTLkN1LT4=
X-Gm-Gg: ASbGncs4an7WzsiapHDMMywd7dklSMGZ1ECh7GQWZLQzEdja+9PYg2qoVA1sTSV8pax
	p43Y5RaDynjtkqPFllpIL61aGSleYxeQf6hybX2CE3Zyx7UgUqvm9usyYKZuE8hSMA9V+z3oATR
	fvbYiy5lcoLyN9V7NApSm3+w==
X-Google-Smtp-Source: AGHT+IFUEu21Nbm/up+QwdSenWnwKsVw3A+E365YsrpZGwvNI/jyUUt21jdvv4Cojd3nbC1DCrPVyWKa+GqwZyFv1UU=
X-Received: by 2002:a17:907:2ce5:b0:ac3:49f0:4d10 with SMTP id
 a640c23a62f3a-acad359bc31mr910919266b.38.1744638977471; Mon, 14 Apr 2025
 06:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407172836.1009461-1-ivecera@redhat.com> <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com> <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
 <Z_ys4Lo46KusTBIj@smile.fi.intel.com> <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
 <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com>
In-Reply-To: <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 16:55:41 +0300
X-Gm-Features: ATxdqUHTg1jcbOzMa7pipDhqGfFcA0usaAkeGfTb7SQC00-heg8_75ap0kABLcc
Message-ID: <CAHp75VcumcH_9-2P2iayGWwD3Y87A7CZyO9vxqvbaUptS1FeQw@mail.gmail.com>
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

On Mon, Apr 14, 2025 at 2:52=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
> On 14. 04. 25 1:39 odp., Ivan Vecera wrote:
> > On 14. 04. 25 8:36 dop., Andy Shevchenko wrote:
> >>> What is wrong here?
> >>>
> >>> I have a device that uses 7-bit addresses and have 16 register pages.
> >>> Each pages is from 0x00-0x7f and register 0x7f is used as page select=
or
> >>> where bits 0-3 select the page.
> >> The problem is that you overlap virtual page over the real one (the
> >> main one).
> >>
> >> The drivers you mentioned in v2 discussions most likely are also buggy=
.
> >> As I implied in the above question the developers hardly get the
> >> regmap ranges
> >> right. It took me quite a while to see the issue, so it's not
> >> particularly your
> >> fault.
> > Hi Andy,
> >
> > thank you I see the point.
> >
> > Do you mean that the selector register should not be part of the range?
> >
> > If so, does it mean that I have to specify a range for each page? Like
> > this:
> >
> >      {
> >          /* Page 0 */
> >          .range_min    =3D 0x000,
> >          .range_max    =3D 0x07e,
> >          .selector_reg    =3D ZL3073x_PAGE_SEL,
> >          .selector_mask    =3D GENMASK(3, 0),
> >          .selector_shift    =3D 0,
> >          .window_start    =3D 0,
> >          .window_len    =3D 0x7e,
> >      },
> >      {
> >          /* Page 1 */
> >          .range_min    =3D 0x080,
> >          .range_max    =3D 0x0fe,
> >          .selector_reg    =3D ZL3073x_PAGE_SEL,
> >          .selector_mask    =3D GENMASK(3, 0),
> >          .selector_shift    =3D 0,
> >          .window_start    =3D 0,
> >          .window_len    =3D 0x7e,
> >      },

...

> Sorry,
> .window_len =3D 0x7f /* Exclude selector reg */

It actually will make things worse. If selector register is accessible
to all of the pages, it's better to include it in all pages.

--=20
With Best Regards,
Andy Shevchenko

