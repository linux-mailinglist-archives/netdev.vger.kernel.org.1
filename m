Return-Path: <netdev+bounces-241980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C26C8B512
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5305235B32D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C13446AD;
	Wed, 26 Nov 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcAroEv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB54315776
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178955; cv=none; b=Z/EFYOjZCK/H9aNSiMuWkwd/ExEVPUjkxkhrRCbLsMg5NhuA/dn5pi+CAVQAfotFONZH3Aky51p1XEvLIEP/eYs5kej0+W0Ra7md5YXxqvnxIVt/VooeSniLmyIl/nQzZ1yZX1SwcsipUbCczvpswh3AoQ1W5KEXr3QqRvMkRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178955; c=relaxed/simple;
	bh=H45sT8ifW0O8vWCYPKJuUgHks2mEXGWB8Jd0Vqn88PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Raee0PPC9UYX/9bjDdUub/7cV3sZEkUQcZlKlfqgvBdVjCh4fsXSdyu9MA7s5d2txvhn882GDIvsgZXUEQDXJeawumY1EWIBGhwKSpUk+K+cOIXbttfxjhSFPYpphHP7XoRmA75BQBBEOOgM20OJJSrKpv5CWdr1WSX1D5wxbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcAroEv7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so40555465e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764178951; x=1764783751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H45sT8ifW0O8vWCYPKJuUgHks2mEXGWB8Jd0Vqn88PE=;
        b=NcAroEv7WHRM6fVZKueA6AsJXXFNUx4vKjsgGnow64+ziC3ZuhBOfkzR3H88UjZS/k
         SGAS9JaptHKCBPLYfGfCxZaiJLxDBpSvUlxfySydVen66Akew6OZMZfqQjgTVplDQ//c
         u7iFhb4nRh/xGhsSVXRoyGtMipZ3AUSLq/P6knWtkxaRphJhdP3Rj9REzJ/u2FwWQtP5
         VXvq3WqFasmz0xnFkzNv26FDjfsQ/cp3QklWxmELPjCSTxybrQ8ENgfs66zZ3SUMhZe5
         r7x+k7te4VRA6znZaKmSRTi+idImQfwB1SZnwmA4wasfQdkEKQ8nkzuNNtGW2M/7YkbZ
         yD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764178951; x=1764783751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H45sT8ifW0O8vWCYPKJuUgHks2mEXGWB8Jd0Vqn88PE=;
        b=D8rs+ZZDt8UNNXsD7sGOTmjxGmA7heSkWmYJfI84kwuj+WDx0QApp3JJq+qphNNKCn
         7Pd3RX+e0ZHPFZto0DzkT3ey4eECBb6D+0pzNHyedT51IhzoZ/0HdIzt8f7SpB6BGUxq
         4gP6OSOHjs5cWgqFclBuhBVyL9zuyVBH5gdwVTguLvAHz1P5uIgXTaQ7E7J+X3p+kT4H
         MqDvgak1uhn7NHKowVkKMjzbfEP+5OmDEG8khb+tfg4kp4f9dNwy6lZkE3DhEd/ZtvfW
         Cn5tsHTNGrvK2lNKYMu3ALcmPlLAXt8eAzS4T3pUW2pcvCnnnRLuNiiBqNdEJx8E44lx
         C3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzQODxf8fTozSoNTY8e+NNPegtwOYh7CjipoOJABJOJXN+q8pfWGwwSBZCusHGbaieGLmhVQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIht3MVpYSUyi5zbq1EEIWu7eyzzTsfyFSk6YFNqZJNS+Qo9eQ
	5EbMbv4RafkEZXkdFgD9dAeGOO7d0yYwbB4hhKljrAXVJ3vJ+ZydWShvroT1oezOJ10abmkU9S6
	2pFoQAFvlRrNMhDySI/KhV4VMF14EcKo=
X-Gm-Gg: ASbGncvX+Rd7Dp91XyfgvwIAt2D0V/ah2T6oIJAkUunWFXIZH0XoK6xYlKelXiumXr9
	qLEkvM1D0NhbrHoO9oZzcFFj38ZR7W4DsBR1lGI0wSS4irjP2rqFL5W1yaii+JtjdGOAmoIdvve
	PxJXdyYue1YxhPpiq6i6VFU4Cuz4gTgHpiahQsJlLmPMx2hak1BO9OA6DKbDK6nMrzD5bbud6XS
	9z/DgiYIQYH3m11LbU9P4vwiQH0BRDusf4JJEGNPw1HoB06yTyrElZmo4wVD1XgOVqhMR46cxiU
	vke+3+kEOnE0MKgUyiWHnootucxg
X-Google-Smtp-Source: AGHT+IEZ28WwikpNMp28f9cZ8FrUOzBbOzH12B9xnya/BVPaxQoXRRptgOSDjsEI4HuhukMbEvl6ukgR6fFwxUmEXSo=
X-Received: by 2002:a05:600c:3152:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-47904b24282mr78083805e9.29.1764178951003; Wed, 26 Nov 2025
 09:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251121193942.gsogugfoa6nafwzf@skbuf>
In-Reply-To: <20251121193942.gsogugfoa6nafwzf@skbuf>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 26 Nov 2025 17:42:05 +0000
X-Gm-Features: AWmQ_bkZJBm6Wozp4bZ86ADSwgEM8iq01qAWIsEYygFDAD9xEd_cYCJ2C4ftoDY
Message-ID: <CA+V-a8vAXg9GXn1ee0-02N7-ucHuivioTMLKFEiw1fO0nPQAzA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/11] net: dsa: rzn1-a5psw: Add support for
 optional timestamp clock
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

Thank you for the review.

On Fri, Nov 21, 2025 at 7:39=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Fri, Nov 21, 2025 at 11:35:32AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add support for an optional "ts" (timestamp) clock to the RZN1 A5PSW
> > driver. Some SoC variants provide a dedicated clock source for
> > timestamping or time synchronization features within the Ethernet
> > switch IP.
> >
> > Request and enable this clock during probe if defined in the device tre=
e.
> > If the clock is not present, the driver continues to operate normally.
> >
> > This change prepares the driver for Renesas RZ/T2H and RZ/N2H SoCs, whe=
re
> > the Ethernet switch includes a timestamp clock input.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
>
> What is the impact to the current driver if you get the clock and
> disable it? I'm trying to understand if it's possible to only enable it
> when using a feature that requires it.
I actually cannot test this by disabling the clock. As the clock for
TS is coming from the core clock which is always ON and we dont have
control for the ON/OFF for it.

Cheers,
Prabhakar

