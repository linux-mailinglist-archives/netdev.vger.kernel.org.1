Return-Path: <netdev+bounces-248998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C3DD127AE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69DB23038980
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CAA357724;
	Mon, 12 Jan 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaTSmOTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89F15665C
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219955; cv=none; b=CIaHxFzoCTBSyAgVJo9j0tdcLHwIoiVgHGZP+2TudFKL7pGnF1vbjAWOOAGVNRptGiFu28b+mhahmbY0KXQq7K+NkP+wWt+u+NgFXcnbqp+gml84DgRjBUMRD9NkelFi0gyv+5ZB8shS+aoB/ZN859Fh5PjZA63A+qqRAA1ibng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219955; c=relaxed/simple;
	bh=TWbhPBAIKAm5t8vyAUtw16r1eURjReug56t9Dx27Pl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYDmGoCri84MS3OGODQRy2fdlhZMgOaO/zqhDnJ/Tjg/zNmrhHlXEWgDW10/5O5iHbGbAS1q9cZJtV44YYtSm2qipDC5lZUEqpM7xsHsZkVfuE1K4Kwk7XcioDnRWoivxYtp3/cwJHcDbmuYD+z7hh5eVYD5JIZzgK/lwCZ0oDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaTSmOTx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc305552so4631984f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768219952; x=1768824752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zmg0YBnqbNA08twWWhFsABytT3ibNSR8wV2mBBA27+Q=;
        b=SaTSmOTxULg06bM6mXRgfJTzRh8LLk9WzqyvlG2wIWC2cY0Prk/CrqfOP9fjHBBQ/t
         nSNc4M/l8BWGJHUZ+dSC1HCiyuI4iDwmFlq89PfJgCk2Ya+7d9Y5iD8GHldMbjPeNmD4
         djJl6qY86gKKhysXFJwnkBVNL5/xj6rGYHHdfuk+5mvT+ndJEYuHQbew6s8TZA+WWNCP
         HvpWTXgsI3zRJNxo/398l5VeJYJaGvN2Rl/VFKsb4DWrjE8/n/1caaLX5+UKW8ByRZdZ
         eFMfz+yi9RRq/KmBrVyjBif7Us6BNdLbP4E9LgVOKszWztAypfVolNZ/YUuSKQQ5Grmo
         uEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768219952; x=1768824752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zmg0YBnqbNA08twWWhFsABytT3ibNSR8wV2mBBA27+Q=;
        b=WUgrDGIA2rlXnV0tIaaAGRvWkag8a6D/DZFOCX3VMcHHsfsW9k+nKQVl4yYYzQ4Qws
         A29OfS9hlE/PhEc8za3ggbq2361qagVOmFA4wJzbIrmC/fWt0DaUSkFgLApP7p3K8Jtg
         27pWdXfileNQtfXaRbtHPar52ep1uPO4N/T8yKcPwxz2OLscxaHcDkTsiZ8c0cfHo8uX
         4Z0yIsFJmb9LrHpfOqQsatfTuHGEJUeD/8hbTLQeMfZpqhtv65s5EMvnKpZmM+MrRKIv
         HIeknrVXQ654RgHU12mg9PVtGN+UDSZhE25Odwj6WGGMMclktBjJA5667Bvko5msggae
         7gtA==
X-Forwarded-Encrypted: i=1; AJvYcCUIiWb8RIAAR43WKxE9fDMRlsw2Iwmu5ogUzdLE3xQ/hKsQgaHQadS7uBH+L5v7mhuwn98YL+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3kjCWVQlZK65D6pWY08MRsDAh5s0DZ08v0t6tsjMYPDGtHsv
	vQ1/+SCQw/hu/L4R1sY+LEbXK4nTnfsyj+NJ998EKh7hz9oMO6K8IotKSRUxG0Thc972pBGT2Z+
	JiThzWuQXdmS9LxWWplK5YR1ytjS2dIE=
X-Gm-Gg: AY/fxX6yxroonit4+UOPlLUGSdsqKlCNyEGDcxgEPVZZp2MPxXjFaov0EnLxcvAlu02
	azqoTXKd4PgvFy9S8bgIz8UQ06eqFyiRJI+ddNKouEfnF+gF39sOdJZsUO4vgni3xOMFwFSuLCW
	vkJXTc4yKTm0xV2jqMy8Fg5azVLn+XYX9toC6O8sg4kVvV/jZwpoH7sCaBydAuDVLN9sOXy4s6t
	f+tFkT8pkzaZDW4507M/i3fUEwXhRhQlwzgVNR3hs3vJgrMr4H645vRczd7YXXclBlXADTUzB0Z
	p1ZzeuYptMxkP58SpcT98OGWOhLqOWLABXKthCZ/+z9zGMftSHp5M5w=
X-Google-Smtp-Source: AGHT+IHRMmRHG9WUlqGE0+jnqrwDoFHrXFSr0vLwiRkF3FJ3Rp4o3ftEq7KmOV6lEwv51HuXFQnfz/RdjAB+huyBZvg=
X-Received: by 2002:a05:6000:4301:b0:431:864:d48f with SMTP id
 ffacd0b85a97d-432c37746c9mr19467055f8f.27.1768219952334; Mon, 12 Jan 2026
 04:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109142250.3313448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260109142250.3313448-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <aWEj4py2Cv4tPu-5@shell.armlinux.org.uk>
In-Reply-To: <aWEj4py2Cv4tPu-5@shell.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 12 Jan 2026 12:12:05 +0000
X-Gm-Features: AZwV_Qj8cXWO3qJ8HGwK10MFwpC4teebKCl0mNxZqHOVldG2dsN40IyKGwpDyS8
Message-ID: <CA+V-a8vLfwr7gKruY-SOdBHUPmY5TgQ3vrSMkn+QF7LsphVxuA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: pcs: rzn1-miic: Add support for PHY
 link active-level configuration
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,

Thank you for the review.

On Fri, Jan 9, 2026 at 3:51=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jan 09, 2026 at 02:22:50PM +0000, Prabhakar wrote:
> > +static void miic_configure_phylink(struct miic *miic, u32 conf,
> > +                                u32 port, bool active_low)
> > +{
> > +     bool polarity_active_high;
> > +     u32 mask, val;
> > +     int shift;
> > +
> > +     /* determine shift and polarity for this conf */
> > +     if (miic->of_data->type =3D=3D MIIC_TYPE_RZN1) {
> > +             switch (conf) {
> > +             /* switch ports =3D> bits [3:0] (shift 0), active when lo=
w */
> > +             case MIIC_SWITCH_PORTA:
> > +             case MIIC_SWITCH_PORTB:
> > +             case MIIC_SWITCH_PORTC:
> > +             case MIIC_SWITCH_PORTD:
> > +                     shift =3D 0;
> > +                     polarity_active_high =3D false;
> > +                     break;
> > +
> > +             /* EtherCAT ports =3D> bits [7:4] (shift 4), active when =
high */
> > +             case MIIC_ETHERCAT_PORTA:
> > +             case MIIC_ETHERCAT_PORTB:
> > +             case MIIC_ETHERCAT_PORTC:
> > +                     shift =3D 4;
> > +                     polarity_active_high =3D true;
> > +                     break;
> > +
> > +             /* Sercos ports =3D> bits [11:8] (shift 8), active when h=
igh */
> > +             case MIIC_SERCOS_PORTA:
> > +             case MIIC_SERCOS_PORTB:
> > +                     shift =3D 8;
> > +                     polarity_active_high =3D true;
> > +                     break;
> > +
> > +             default:
> > +                     return;
> > +             }
> > +     } else {
> > +             switch (conf) {
> > +             /* ETHSW ports =3D> bits [3:0] (shift 0), active when low=
 */
> > +             case ETHSS_ETHSW_PORT0:
> > +             case ETHSS_ETHSW_PORT1:
> > +             case ETHSS_ETHSW_PORT2:
> > +                     shift =3D 0;
> > +                     polarity_active_high =3D false;
> > +                     break;
> > +
> > +             /* ESC ports =3D> bits [7:4] (shift 4), active when high =
*/
> > +             case ETHSS_ESC_PORT0:
> > +             case ETHSS_ESC_PORT1:
> > +             case ETHSS_ESC_PORT2:
> > +                     shift =3D 4;
> > +                     polarity_active_high =3D true;
> > +                     break;
> > +
> > +             default:
> > +                     return;
> > +             }
> > +     }
> > +
> > +     mask =3D BIT(port) << shift;
> > +
> > +     if (polarity_active_high)
> > +             val =3D (active_low ? 0 : BIT(port)) << shift;
> > +     else
> > +             val =3D (active_low ? BIT(port) : 0) << shift;
>
> Looking closer at this, I think this is confusing.
>
> The underlying purpose here is to set mask and val to change the state of
> a single bit in the PHY link register for each call to this function,
> accumulating the changes in your misnamed "struct phylink".
>
> Given that "mask" can be used to compute the value to describe the bit,
> and that is made up of "shift" that describes the start of the bitfield
> and "port" that describes the bit within the bitfield, then surely:
>
>         mask =3D BIT(port + shift);
>
> would be saner?
>
Agreed.

> Next, the creation of "val". This is either zero or the same value of
> mask depending on active_low and polarity_active_high. The truth table
> here is:
>
> polarity_active_high    active_low      result
> 0                       0               0
> 0                       1               mask
> 1                       0               mask
> 1                       1               0
>
> This is a classical an exclusive-or truth table in the world of logic,
> or could be regarded as an inquality relationship (result is mask
> when polarity_active_high differs from active_low, otherwise zero).
>
> Thus:
>
>         /* Set the bit when polarity_active_high differs from active_low =
*/
>         val =3D polarity_active_high !=3D active_low ? mask : 0;
>
> Or, even simpler, this could become overall:
>
>         mask =3D BIT(port + shift);
>
>         miic->phylink.mask |=3D mask;
>         if (polarity_active_high !=3D active_low)
>                 miic->phylink.val |=3D mask;
>         else
>                 miic->phylink.val &=3D ~mask;
>
Ack, this simplifies the code. I=E2=80=99ll rework the code along the lines
you suggested.

> > @@ -605,8 +698,15 @@ static int miic_parse_dt(struct miic *miic, u32 *m=
ode_cfg)
> >
> >               /* Adjust for 0 based index */
> >               port +=3D !miic->of_data->miic_port_start;
> > -             if (of_property_read_u32(conv, "renesas,miic-input", &con=
f) =3D=3D 0)
> > -                     dt_val[port] =3D conf;
> > +             if (of_property_read_u32(conv, "renesas,miic-input", &con=
f))
> > +                     continue;
> > +
> > +             dt_val[port] =3D conf;
> > +
> > +             active_low =3D of_property_read_bool(conv, "renesas,miic-=
phylink-active-low");
> > +
> > +             miic_configure_phylink(miic, conf, port - !miic->of_data-=
>miic_port_start,
> > +                                    active_low);
>
> I think this is also over-complicated. Wouldn't it be better to only
> deal with the miic_port_start at the one place that it matters?
>
>                 if (of_property_read_u32(conv, "reg", &port))
>                         continue;
>
>                 if (of_property_read_u32(conv, "renesas,miic-input", &con=
f))
>                         continue;
>
>                 dt_val[port + !miic->of_data->miic_port_start] =3D conf;
>
>                 active_low =3D of_property_read_bool(conv, "renesas,miic-=
phylink-active-low");
>
>                 miic_configure_phylink(miic, conf, port, active_low);
>
> ?
>
Agreed with your point about miic_port_start. Handling the offset only
at the point where dt_val[] is indexed, and passing the unmodified
port into miic_configure_phylink(), simplifies the flow and avoids the
current back-and-forth adjustments. I=E2=80=99ll restructure that part
accordingly.

I=E2=80=99ll post an updated version with these cleanups in the next revisi=
on.

Cheers,
Prabhakar

