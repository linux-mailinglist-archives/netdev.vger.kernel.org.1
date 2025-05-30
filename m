Return-Path: <netdev+bounces-194446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9DBAC9873
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 01:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6543BE82C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A06229B39;
	Fri, 30 May 2025 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn/uB6Jo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A11F4E2;
	Fri, 30 May 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648804; cv=none; b=u4RE/V9UBcFtyoiQD71/8ecFhwKJqO6UYS9r7TLVRVdGWcDeF5Imzyqv7sCunodLTdsK7S0yLfBjZ6ZZFfVenxYEP3QCK115YxtHWyIPl+s3tRWrlQHYb2v0DPZeETh4oeUi3iUQj76Ui1HHcmpjbLUbLgrzz0YKNLXyZN1aVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648804; c=relaxed/simple;
	bh=f/RgEcBhBOkPZPGEoH8L5VEwKbNgnJK3zfEBTZ2DxGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNpcfNKOx2Jxhc/No74TGcNucZ+KDTsMFYy9Zfyu/lRjklgB/B7++tukS4ISyON374IroVBP1CevFJ7Qjz96a9mQJuadJmqDG7/NnpH1nSQIq7a6xHQLfMHAL8pODoPXiY4s3kLI/jNDbp0bDFk/itAPFbSVoDR2L2kByLa1jm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn/uB6Jo; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e290e420eeso812139137.0;
        Fri, 30 May 2025 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748648802; x=1749253602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8r1VhQxE8YGMw2E+RF6ib2Y5lg3+2mjo9SImYhpolU=;
        b=kn/uB6JoPHJEBKIjJtWKnz5EWIUJDAEysSVOfDU4iScgPtfYAjTHAyLaeYTBYbknmG
         YN3UYlubP0UKCPqj7wUbEQc2bOzX07pqVh/3ZqPbHeUpn9yO7rTCfzeMaGrKkzSF0Ro7
         v6EeCsZhz6TsMPctK1HxZeo7vWbfvvIf6WwkVXgsEQqdXIqYhgD1SNyza5D4MUiH3R2p
         MWNyz/pHoU28sE20xlD1n6tsMeZIJHldorP9LoEWMoJnc2yqMxpPNZsY8+ppzZ/j3ASM
         c6R6nKIIH1FchZIrm6KMizCaiEWX8I9UdF7jM7x3jLLOLtN5bhUxxPPVZ5cHZpYrFwR3
         N3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748648802; x=1749253602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8r1VhQxE8YGMw2E+RF6ib2Y5lg3+2mjo9SImYhpolU=;
        b=YJJDqTm4oSeUF6rDxB9xLWhE8cI0hN7V5HTn8/dfdefPygEkk2nYQPXfIE+1SmNV2h
         0xopdm0+xvLWHsRdHgWalu05QvvQE4gHQisQPtg1RT616sLuIOpNb9k0qQi7EBILegUg
         CvX8NJBmsU44irPURjY4bTY6NpFGVd0v80k4+mz8HrgPxekX0jMf04j2xe8IJ5UYCXkE
         82j8XSOlojPfMNMNtBjCVzjnMIdOIeDE0lsEqRp4jL49kdf5usFijFwFj0v8KfXjisny
         qAl0CBA/T1s0LVKEUGJcNYq8hBCOvJnlMf48AhcvYm7z8bd5x1pe2DT5GOy5418t8TP4
         R0UA==
X-Forwarded-Encrypted: i=1; AJvYcCVG/fV9UtzP29ec3sIjNwiLqTsNhxM7UnXnzzHesGQjEyXLuk84bbbS/vXRex5ExxGzvMamX6/NogVd80k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJR8iUyrcsdq4/V7L/BFzrZRJOO6BL5EsTEBn7NHYd7FO+bvk
	nHhEo6aQbGQMtNr/vIlhH7KMtsQu5f3IxB74AunGNTD69eEKnRIQv/yYJRnIHRpO0fcZCQwVY2C
	tDgcC3VIhpPCF3zB7WxB/exnvGk7DD88=
X-Gm-Gg: ASbGncsBtbJbfZqWNWSghvBkBEGu/PGku55j4+nwN9pgz7/Py2caQHuF06c2A0D1bY/
	xi0c8fH1PN9joN7mE8X3AsBtTRoFJjihPZAU2W6snvanbeXpK6Opl8nUTZlZWNwegzdYXhYHfDl
	/2ney4CpZ92Ek+1/fq3pIm5FKu/C+SbyCJ6g==
X-Google-Smtp-Source: AGHT+IGWYRqljBTNqRjcHJ1Qx5MgLEMU3w+EcX3w2i25x1ph1+e4wdYuKsPwq6FXpfXezjeuLLMkh2UEwUEoxLdnS0I=
X-Received: by 2002:a05:6102:41ab:b0:4e6:1a8c:13dd with SMTP id
 ada2fe7eead31-4e701bcd515mr59445137.7.1748648802024; Fri, 30 May 2025
 16:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch> <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
In-Reply-To: <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 30 May 2025 17:46:30 -0600
X-Gm-Features: AX0GCFsAv-uR3T4qW04ZGESiTbXNp1RMaFKH2XrMAyyDm-M83KQe_2yzaPmKFXE
Message-ID: <CADvTj4posNXP4FCXPqABtP0cMD1dPUH+hXcRQnetZ65ReKjOKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 2:02=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, May 27, 2025 at 01:21:21PM -0600, James Hilliard wrote:
> > On Tue, May 27, 2025 at 1:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Tue, May 27, 2025 at 11:55:54AM -0600, James Hilliard wrote:
> > > > Some devices like the Allwinner H616 need the ability to select a p=
hy
> > > > in cases where multiple PHY's may be present in a device tree due t=
o
> > > > needing the ability to support multiple SoC variants with runtime
> > > > PHY selection.
> > >
> > > I'm not convinced about this yet. As far as i see, it is different
> > > variants of the H616. They should have different compatibles, since
> > > they are not actually compatible, and you should have different DT
> > > descriptions. So you don't need runtime PHY selection.
> >
> > Different compatibles for what specifically? I mean the PHY compatibles
> > are just the generic "ethernet-phy-ieee802.3-c22" compatibles.
>
> You at least have a different MTD devices, exporting different
> clocks/PWM/Reset controllers. That should have different compatibles,
> since they are not compatible. You then need phandles to these
> different clocks/PWM/Reset controllers, and for one of the PHYs you
> need a phandle to the I2C bus, so the PHY driver can do the
> initialisation. So i think in the end you know what PHY you have on
> the board, so there is no need to do runtime detection.

Hmm, thinking about this again, maybe it makes sense to just
do the runtime detection in the MFD driver entirely, as it turns
out the AC300 initialization sequence is largely a subset of the
AC200 initialization sequence(AC300 would just not need any
i2c part of the initialization sequence). So if we use the same
MFD driver which internally does autodetection then we can
avoid the need for selecting separate PHY's entirely. This at
least is largely how the vendor BSP driver works at the moment.

Would this approach make sense?

> What you might want however is to validate the MTD device compatible
> against the fuse and return -ENODEV if the compatible is wrong for the
> fuse.
>
>         Andrew

