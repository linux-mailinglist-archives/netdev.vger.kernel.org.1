Return-Path: <netdev+bounces-236881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB31C415B5
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 19:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23694188ABCC
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629B32860F;
	Fri,  7 Nov 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdoTi6BG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A033B6DE
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541735; cv=none; b=AXluwnpq/QJxP880bj422+zMLbjnop30I1tqtrY+XTToFZBE3pkg8vxnNt8kv6y+t6hX3TuRAuceL6+NjwWLcqeyp1rKH93jgkvcYFydWBj38LivsitnwM/K7XGWtmnFe0JsQXfckligSF0eX/lrEbMx3lNfMyN0g1gmL6Tcxxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541735; c=relaxed/simple;
	bh=IdtM5FvAG0CA3/E9xLGv8ZkSNkz0C6s2910O2wI6WPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsFRRQluqhkc9IhiA/K07eDGLVo6TVlvEATNf/zWpUecgw8SWukCtF/sCmBzY19/GXbSkvWNr9FW38EQuvGQjAyVuz6LJCvtIurMomVQ1zbaYhP0vtqBa1hsGtnPiUUixF9/CyiWyuCjnjQQtYGynZOif9DPwcIPwDmXlbt+0Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdoTi6BG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4774f41628bso5157245e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541732; x=1763146532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYOFjOauC9uTwp6iLyWT9D/OqXU3tri/WbPZz+gGnEI=;
        b=XdoTi6BGPJHgh8HuCKKgiZgd+1b066E9SePyQ9tPFBGkk0fnKYhhuk6u5VYahSojLD
         zX8xHiO7Z7fm376QDK4qsL+gYRzffUIPcXLKmKb9OnD4poYo7F0NZJssI7Iz5Dfzpbyl
         4kDM6dnd4Dy4qYUeNKv8jTLIHPiSmMnxstIGcz8lQKwxTjgWW/XYY7YptDmSfrialHN7
         D+A42kfndtnO0UUd5wxuq+ocD+/ZA28QqmM10DsVzRwoVEBgRgHAZ1WTFAwql1Ehenxk
         a2FlJL/AL3YYhNJIaUtNCn7wgJ1BZ3dZn/jhUzZwE+PkjsGFAgcVMOkxqzU6MB0o1BlR
         wxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541732; x=1763146532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYOFjOauC9uTwp6iLyWT9D/OqXU3tri/WbPZz+gGnEI=;
        b=SXRc/u9ifJR8Hxxqg2J/rb2zzE+wGMmCGWvoXiosX04gMlsbxGNbx8oad7PLTVGdzy
         KUWDmRd33PNxQSn+fkgfDB6hVNkUKQbRaHu0DEPR2x87x7OSuUozKT9eLCHVAAzpJVtm
         cpOvWs8YBYSGDeEfzTE4o99Ld7cpjYPliYU77aJKop31+wLs4J1HmNGjV2Xdr6qfMf7c
         rNkfXyP5ra2mFxrCzIzP+YsrAOBtswpYn+vI+97WvybSeD355a8zON7yBUjGOW2Qm2CB
         Y9hv/HgGMUde0FlVSnJum1qQe4/tOVNa/NyOkJ4Hfop2KK10r1mv2qOo305vPICtDA3H
         rFsg==
X-Forwarded-Encrypted: i=1; AJvYcCWMLaetoFC8DRiIeonB4qhvmNtF4d3SK1dNapNiWgOIdHzih64Jb0IEiyGPn9FZt3VuzGR+Yig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllbpxQ+KN4BMn5SfrIob+0qsCRxmaKJ4N/Son22yw2CJEaFgC
	MuPqmv5INJc2VdQwW9nTNu6FTc8/Ir6dx9lFuYf+qtwNTOwg36unhWHMQTzUzoZg8Vlsct921Vk
	J2z0FerGk3+CqX9PPAlZIohbV2xZbnFE=
X-Gm-Gg: ASbGncsAhe+9bNoSIsG0pZmi6bO71rp1N9v5c+F5t/Agz72R4j+JmtQaNZO2vxsvUNS
	eWkITsQjU/LAEZfMvihBlBDIbuAEhJuDmjS4GHEgRkK7LcNwfqXxU0ktsxs5KObUM0zzS11/dvU
	5vTp+z4uqvPzzP74hQnJpjbHPEt3aLa39+TSFaAZ2lg9T6/fhj3rZMQY75ydMYTiN5BT6C3rsvG
	uiFUECEd/qaiGijt9w/sbJJlFBQedIReE3r08h4im+rH/b+2I+9RXaG2zTi
X-Google-Smtp-Source: AGHT+IHRiq8LOI7XDfcnPBif5Be5tlbEofXfFjh2SF9CKa5iZ2LCl/Y697lC6+uXYXH4qXNN3Gqe5tbSe6dhD42hJjI=
X-Received: by 2002:a05:600c:1d0d:b0:477:bf1:8c82 with SMTP id
 5b1f17b1804b1-47772dfba72mr4536435e9.15.1762541732159; Fri, 07 Nov 2025
 10:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106200309.1096131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ee6a79ae-4857-44e4-b8e9-29cdd80d828f@lunn.ch> <CA+V-a8vFEHr+3yR7=JAki3YDe==dAUv3m4PrD-nWhVg8hXgJcQ@mail.gmail.com>
 <2dabb0d5-f28f-4fdc-abeb-54119ab1f2cf@lunn.ch>
In-Reply-To: <2dabb0d5-f28f-4fdc-abeb-54119ab1f2cf@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 7 Nov 2025 18:55:05 +0000
X-Gm-Features: AWmQ_bnn3KbAT4rF9IvIcF36WFZWDqZECyk5JzQF2JLVOWx3xWwFfMtNq7cdMzE
Message-ID: <CA+V-a8uk-9pUrpXF3GDjwuDJBxpASpW8g5pHNBkd44JhF8AEew@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: mscc: Add support for PHY LEDs on VSC8541
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Nov 7, 2025 at 1:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > @@ -2343,6 +2532,26 @@ static int vsc85xx_probe(struct phy_device *=
phydev)
> > > >       if (!vsc8531->stats)
> > > >               return -ENOMEM;
> > > >
> > > > +     phy_id =3D phydev->drv->phy_id & phydev->drv->phy_id_mask;
> > > > +     if (phy_id =3D=3D PHY_ID_VSC8541) {
> > >
> > > The VSC8541 has its own probe function, vsc8514_probe(). Why is this
> > > needed?
> > >
> > vsc85xx_probe() is used for other PHYs along with VSC8541 hence this
> > check, vsc8514_probe() is for 8514 PHY.
>
> Ah, sorry. I was looking at 8514, not 8541. So yes, this is needed.
>
> However, i think all the current probe functions could do with some
> cleanup. There is a lot of repeated code. That could all be moved into
> a vsc85xx_probe_common(), and then a vsc8514_probe() added, which uses
> this common function to do most of the work, and then handles LEDs.
>
Certainly the probes can be simplified into a single function. I'll
create a patch for this.

> Also, is the LED handling you are adding here specific to the 8541? If
> you look at the datasheets for the other devices, are any the same?
>
Looking at the below datasheets the LED handlings seem to be the same.
Do you want me to add this for all the PHYs? Note I can only test this
on 8541 PHY only.

VSC8541: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/VMDS-10496.pdf
VSC8502: https://ww1.microchip.com/downloads/en/DeviceDoc/VSC8502-03_Datash=
eet_60001742B.pdf
VSC8514: https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10446.pdf
VSC8501: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/VSC8501-03_Datasheet_60001741B.pdf
VSC8504: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/60001810A.pdf
VSC8530: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/VMDS-10516.pdf
VSC8584: https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10455.pdf
VSC8582: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/VMDS-10421.pdf
VSC8575: https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10457.pdf
VSC8574: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/60001807A.pdf
VSC8572: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/60001808A.pdf
VSC8562: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/VMDS-10475.pdf
VSC8552: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/60001809A.pdf

Cheers,
Prabhakar

