Return-Path: <netdev+bounces-200545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5FAE603C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FEC4C103D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38D27A445;
	Tue, 24 Jun 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRx2hDm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA819CD01
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756053; cv=none; b=Cd2wmH0iEfn0ZaGHvFZjCPbKDG+aEg5h+8P9+8JY3Tj8vHE+ZHRLEiRjOSTqanzt7ck1IsnMwlieHQbcx9WtDnRKwRL4TNfAACpYok7Z3LCUb9qdKadk56nSypOg2LoLMhS37wODTULoj+DU8wKvLczFWHaZvCbYZhZGOzevVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756053; c=relaxed/simple;
	bh=/+oFva9BAMPIUaaePpc0bX11cPgvD5Vr0m/U5RUCT7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtYdF71zYD3K+neHhbaI65C+LI+Equ57XEF/6LjDzt5rzgF27tIJRfWxOSVDGBy08nXbce8l/G7CyrYEb7/T34Pd5ckq9choNfkWUBj1zZ9shj/o3vUcE3ozmfjDQDzdniwSRpzt5xBQktO5zSTQrQ/WfjtFeTX9nCkk4QkKxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vRx2hDm4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32ade3723adso60713911fa.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750756048; x=1751360848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEkjORmLKCGHcTPv1I+arAaNEGLpp2uwOI99NBj0S1k=;
        b=vRx2hDm42aRkhp3WfnExlng6M15Pb/z0CSMkvXnNYiE/Of0ZSX4S1bDxkiFnwivhXz
         +CHf8CKbe4eN0OKNejaU8RXENzGrt+u+PSaU85WWr2ntDbD7sOiQpNawCkEYLco/Hq3c
         IXmZwoMNpcP7syxmgIGgMBcIlFIVoVxLaCrUI8NUY2R2NUY5TOEmQaWuAJiRmVvHG3N+
         kE6ohM89AeRYvUjddqVI0nIacweaeW21l2I8g/Htvm2aQlkKXfpQPJhFiE3Tkf9AZ9ad
         8uFTyPCUPR41M3LJvPYHOX3wigbSkrteCDkAO+mbzaugIuuispiSUfzWcRUXHHm9ATqs
         f68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750756048; x=1751360848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEkjORmLKCGHcTPv1I+arAaNEGLpp2uwOI99NBj0S1k=;
        b=DwSORZEqqtkKFTFJxWet1X+KMMLo0XcVCbE7o6GgYrbR64tJNfI/cHTBD4NXBplesy
         y91fstNmifvNp14/ekdoJHOEHU7TjTHWJkWxT+GypS0je80L+n3pmO/WWTCuFfO2NGAu
         vjIDv3Q8PFj46Y3qWc23zRbsz6refQpgXZrks46F6LML7C9snjB80f2z4NVzK/g2Ex1H
         wQgp5qNjX29rw/bdxt2bxGtZzN2e0+yaHKq3vFfnaaoFenClbZF7sxrZrAuTGByzPpEA
         /S093IB4nPv5FWsF/7tBexAEsFqcz5Be8UlGr19WEKZfEr1I2J7SO+gehDH+zNnh5VNs
         y2bA==
X-Forwarded-Encrypted: i=1; AJvYcCXUAXBt7ILDPbT0GGCSqPUR1eVgrjnagJJYXL2X/2Q+SM+lSrKb7VIb3W3lZ3shbL66mf9aVPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6E1WpTOJPeqCmrI3qGI6jR8uH+jGI6tlv9xESXyLVi6LL287+
	QNzm6Y6WgULt13bT1FS2PfpLQIqU3meRzgtVdvosE/5iyeswf8hrjWOsn5j9L1acN4KTmdF1jQO
	RZaykZVezabnY0+zsoo9Ay1P0zHkeixErSds9FrIjMA==
X-Gm-Gg: ASbGncukQi0qgFyCKUwssrYQDA9QeGg8bETVpERakItvT50U7uik0p+iOtQELSMCCVe
	fP0YeimkcBMKjTnV8B46glO1S14AyAdVmCjcz7byrAsp3xcoAQxDZeIL1OYtmSS1tneABJnmmve
	XomT3cCb+gkFqyKA5MSVJ9JMQYYhr28E30S4SqdHPTIPs=
X-Google-Smtp-Source: AGHT+IH7NkkqE0u1Pl2ganomiNqMqAhRg3C9WLn7TyJZFZs+q4IPIwIOvcAx25Ana4p0OU4o4Gq4cJf2y3C5mcoaVGc=
X-Received: by 2002:a05:651c:2203:b0:32a:8086:cf7 with SMTP id
 38308e7fff4ca-32b98f93a35mr55314771fa.29.1750756048004; Tue, 24 Jun 2025
 02:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-ks8995-dsa-bindings-v1-0-71a8b4f63315@linaro.org>
 <20250624-ks8995-dsa-bindings-v1-2-71a8b4f63315@linaro.org> <08531445-a27d-413f-96de-81087d6f61e1@lunn.ch>
In-Reply-To: <08531445-a27d-413f-96de-81087d6f61e1@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Jun 2025 11:07:16 +0200
X-Gm-Features: AX0GCFu4xk6sV-XT4-gtoBmw_KE6a5a_5-qZmVHj_0_F3IuNErxg7GOMvfHwbPw
Message-ID: <CACRpkdbr8-0=bZ0mRkZ9DnWrKZbQM3AuNdzbxyWTX1qiEAgJjw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] ARM: dts: Fix up wrv54g device tree
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Imre Kaloz <kaloz@openwrt.org>, Frederic Lambert <frdrc66@gmail.com>, Gabor Juhos <juhosg@openwrt.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:16=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
> On Tue, Jun 24, 2025 at 09:41:12AM +0200, Linus Walleij wrote:

> > +                             ethernet-port@0 {
> > +                                     reg =3D <0>;
> > +                                     label =3D "1";
> > +                                     phy-mode =3D "rgmii";
>
> If this is an internal PHY, it would be better to use 'internal'. I
> would like to avoid all the issues around 'rgmii' vs 'rgmii-id'.

OK you're right, I'll rewrite this and the example in the binding
to use "internal", as this is what it is.

The fifth PHY is inside the switch, yet "external" in a way.
They are all managed by external MDIO though, see below.

> > +                             ethernet-port@4 {
> > +                                     reg =3D <4>;
> > +                                     ethernet =3D <&ethb>;
> > +                                     phy-mode =3D "rgmii-id";
> > +                                     fixed-link {
> > +                                             speed =3D <100>;
> > +                                             full-duplex;
> > +                                     };
>
> That is a bit odd, rgmii-id, yet speed limited to 100. It would be
> good to add a comment about this.

Copy/paste error when working with old code :(

It's good old "mii"

> This is all confusing. Do you have the board, or a schematic for it?

I was confused because I managed to find phonto of thePCB
for the board in question:
https://real.phj.hu/wrv54g/

If you look on the bottom of the image, there is a component
to the LAN ports, chip tag reads: "SWAP net NS604009" (made 0421)
but I think it's just one of these isolation transformers so the
PHYs are indeed internal (the KS8995 is the component above
with the heat sink mounted on top).

> >                       mdio {
> >                               #address-cells =3D <1>;
> >                               #size-cells =3D <0>;
> >
> > -                             /* Should be ports 1-4 on the KS8995 swit=
ch */
> > +                             /* Should be LAN ports 1-4 on the KS8995 =
switch */
> > +                             phy1: ethernet-phy@1 {
> > +                                     reg =3D <1>;
> > +                             };
> > +                             phy2: ethernet-phy@2 {
> > +                                     reg =3D <2>;
> > +                             };
> > +                             phy3: ethernet-phy@3 {
> > +                                     reg =3D <3>;
> > +                             };
> >                               phy4: ethernet-phy@4 {
> >                                       reg =3D <4>;
> >                               };
>
> This node is the SoC interface MDIO bus. Why would the internal PHYs
> of switch bus on the SoC MDIO bus? I would expect the switch to have
> its own MDIO bus and place its PHYs there.

This switch is so old that in difference from other DSA switches it does
not have its own internal MDIO bus... I know for sure because I'm working
on another device and I can access all PHY:s over MDIO. It depends
on an external MDIO connection.

Here is a datasheet:
https://docs.rs-online.com/0889/0900766b81385414.pdf

On page 45 it says:
"A standard MIIM interface is provided for all five PHY devices in the
 KS8995MA/FQ. An external device with MDC/MDIO capability is able
 to read PHY status or to configure PHY settings."

I'll update and repost so it makes more sense!

Yours,
Linus Walleij

