Return-Path: <netdev+bounces-236774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63BEC3FFEE
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 13:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E500E1894619
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75DC2BFC73;
	Fri,  7 Nov 2025 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S68T9SXm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D129A33E
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520015; cv=none; b=doNvRGuKsS9j/2WDNfskCGpIL0mccGC3yjXG+wLHM8CjrJJXiF4sxMUXqPMnn58agfJNwj8u09pc2wH3Uo830Wh4AKjhhAAcnTq/+RHqiqRca7XWE4vphDFgs4bS+1b23f8fmn1bnUgyVp+PvKyhNw0h9v6KugLSNs+XQ2TaBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520015; c=relaxed/simple;
	bh=q9zI20imONFJWSU4sMqHKWlXJSXQoDdH1EfvCNGQg/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wmvri8v2IAekbR2QmXoHK1hK/eNSDfUIA3FDaK3zZzwdUWyecIuRcF/pqe2FNkHDj0y0gCL60yZOGb0i8Q2FtiE1VtrSBDsinj9WLTp7cnjXPgj7Jvzm5CO5zSX2t3M2RKiqRV9Rm2YLNMKDuz1Ly5CKdP3jV/EV8XLnMiGN7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S68T9SXm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429bf011e6cso710120f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762520011; x=1763124811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDlLuo6EJhgu850xqILbV5yNVdL4jCP+h+T3UXQIKHE=;
        b=S68T9SXmVY0ln1g/kWggfz5YwBIwm/E3kWiNJ3xffzI4ujRuZTwf41a18I0Kh6mYez
         VeD0zV/XfUPKRGIUkWwAGvtM4pE+HYl++zu75eExnP/jHDiI2urxsMNXCu3z18D0I3Xx
         ue5/eVZ8z8cg4Cq2J1HLTjvhEyy3uEekR6iOsVeegLUcmqpYVFUk9I7eRiIbzWLj+MYg
         eR0NTZrbwV945q7OfDoi2HezQ/yCXaO1/9mwaFKXVqTjUdhuK/THoz66J7pZ9lPDLEGE
         lToNDMku/Y8DEWGnoj+rtmsHJZHuXio6tSpXOOq+CiM6+lVMwO6hEjt5pGJSX0AKnmQ0
         TZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520011; x=1763124811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDlLuo6EJhgu850xqILbV5yNVdL4jCP+h+T3UXQIKHE=;
        b=f5ukDEA73AdDzojuJooJLAdaMB1T27XpQOVrJXgXJ3yS6rY9HvHHsiGfM6sksWIsfP
         HfbGdz6S7Bx1A4p1Rzdno0NDAHgJlR6dpj1x2V2cN6UpAvsm+WoPCvoTl7LPqP+FHKtU
         dft9DvbjP/6S5F3C5sFWykDDLBdlQ4rWz8VB9abGYH0ayyMThuULKQpHcYd6RIuJemmS
         aQ5W+gqvfuGVawdUnSaFl4jsebDK5NGkhFNQ2cvK/VvvQn55LY6J+frDPzTiszuLfBhv
         G4g/S2nuAsKwMjUxwSMA/F2MSrWXMr/Rmx43JLMKDB9uFghAiM+6vebjxRdYNEAU290T
         3QLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeFCvnjD7vZ06+ldrPqJggNuKeQgZFf9jTLYdr7nqUgMnTMoR3H5WgOEQq9TIEFemMitukz7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKfvqy6foK5qtwBDf7NpwvROcHsb3fA6PpaOJtHaN5OssqPb+
	i48RJA3alA+w51XPwg2KpgwosCeKYgzb86M93ogsN0ZVoWnyXqREK744i9gBJvpEsqdXsTl9FsK
	SbObL9a7t5MZt4ecZcww1KbCMfneO/tE=
X-Gm-Gg: ASbGnctgLN9fXHq7h22Odvd7DihBVacKSlo5n9JfCLXi7FreH84VRtvLdpIDyByuCrQ
	EdiJIZ/Usrcv98IvfWnSnJOyWyjCXz5ZC0urN68ruMjszmyJNw+Lv9nqVDQ1zIPknyuKg9FVggD
	17+A00c/IE1VfQ2T1wK5NjaWohUNueM68B1W8d0NYl+nQB0WmIVzu138bZuTiGXwPSl/VsTFmJV
	mI+FQPFdv0L6GedEHqoDJ9MlgmC6oGu+EKIv6bhv8tIZN2mgRcOTtyNc7j3
X-Google-Smtp-Source: AGHT+IG6yhUODYDBTk6Lrrh+pvVh+60eCzotcas99DYAECkpeF5Yh70dbD/G1MsyWPValtLFpDByjP9p/OlZ21Ke3K4=
X-Received: by 2002:a05:6000:26cb:b0:426:ee08:8ea9 with SMTP id
 ffacd0b85a97d-42ae5ae8df3mr2412551f8f.44.1762520011307; Fri, 07 Nov 2025
 04:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106200309.1096131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ee6a79ae-4857-44e4-b8e9-29cdd80d828f@lunn.ch> <CA+V-a8vFEHr+3yR7=JAki3YDe==dAUv3m4PrD-nWhVg8hXgJcQ@mail.gmail.com>
 <aQ3mAhaZQa8_99Ah@shell.armlinux.org.uk>
In-Reply-To: <aQ3mAhaZQa8_99Ah@shell.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 7 Nov 2025 12:53:04 +0000
X-Gm-Features: AWmQ_bkc5ZITwYwrhmHJntA_VXUXf0KaiPeDByFVYyJYDlHbx_XXuZrOAdVOFD4
Message-ID: <CA+V-a8tswHeQfhPweDf=EeJ-pt=tzSHkevvOLdRuvkzyotnnhw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: mscc: Add support for PHY LEDs on VSC8541
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
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

Hi Russell,

Thank you for the review.

On Fri, Nov 7, 2025 at 12:28=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Nov 07, 2025 at 10:34:32AM +0000, Lad, Prabhakar wrote:
> > On Thu, Nov 6, 2025 at 8:45=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > > > +static int vsc85xx_led_cntl_set_lock_unlock(struct phy_device *phy=
dev,
> > > > +                                         u8 led_num,
> > > > +                                         u8 mode, bool lock)
> > > >  {
> > > >       int rc;
> > > >       u16 reg_val;
> > > >
> > > > -     mutex_lock(&phydev->lock);
> > > > +     if (lock)
> > > > +             mutex_lock(&phydev->lock);
> > > >       reg_val =3D phy_read(phydev, MSCC_PHY_LED_MODE_SEL);
> > > >       reg_val &=3D ~LED_MODE_SEL_MASK(led_num);
> > > >       reg_val |=3D LED_MODE_SEL(led_num, (u16)mode);
> > > >       rc =3D phy_write(phydev, MSCC_PHY_LED_MODE_SEL, reg_val);
> > > > -     mutex_unlock(&phydev->lock);
> > > > +     if (lock)
> > > > +             mutex_unlock(&phydev->lock);
>
> If you used the provided helpers rather than open-coding a read-modify-
> write, then you wouldn't even need this lock. Please use phy_modify().
>
Ok, I will drop this implementation and also drop the locks from
vsc85xx_led_cntl_set() and switch to phy_modify.

Cheers,
Prabhakar

