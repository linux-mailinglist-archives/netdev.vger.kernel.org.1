Return-Path: <netdev+bounces-233067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A5DC0BB73
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB9EF4E8232
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94582D062E;
	Mon, 27 Oct 2025 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlRqLj2y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C32040B6
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533544; cv=none; b=nYGUP7zvcqSTj2X8f2h2ZdrpWo/b/6PAPy0igLx15zc3CkuWBAVq3BLj8YryQZol2KqDhm2BkGYkwJrYV9/2IphUOrcfP2YAGgA57hfFhSzmnfg775kZHgCbQf6kLVb4uKcb6tzuqBsRFpyjxiJ9qn3pZTda2AvVC/FWklNg2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533544; c=relaxed/simple;
	bh=ixZLGZjFry1T0cmh+FTStMPELYyw70sUjLfToqyoKUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU77wvnshO267I42zn1wSS9gDVUwxjoXoObvkVQb03p5HnA5AgzHYDCjy/XvguZNZdfSyAYRJ2Kw/lnUQONsh5uzrs43VkBHCo0sZEXsXktGXdOnK66l6A4STq4jDjZ/FULemi8x5x1yA157xWcvXhB+fiLFYowDqkJy7S8OF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlRqLj2y; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-9459db1337cso159387639f.0
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 19:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761533541; x=1762138341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE6y7O8WL73HJ3QvP/fJ3zDTO1kKIXbhxHyXNZ11HVg=;
        b=NlRqLj2y+VcuPpXF88Cdu51N3iaMtTqeTgYkkBy2qzw5FLugAAkyNP7t5tJiafmthS
         en6MT7fMf6OOhJatSE/enfjkLVxmILVFzg2c5DnDUjBsBPptRGZ9aM6Nyhg0fsEtdRh1
         wyKmYeuhdMS/fGvNxxkJ+DVyXmoK9+5EhVs4iiK6Q67WOucD5XZgVRmXUR7h5TSisXmD
         0noVH5DKNbECnCzT8b7KK8bcVRqPhskILePB/F96PpnolC4sKns3CJbC4pfE6VwzJdwz
         gIGONx7a05o64AXCGV0UXfeKtoDORKXp5tLCMZZN2eJaNGOX0DyfJdDyajO00zISTBlU
         4X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761533541; x=1762138341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE6y7O8WL73HJ3QvP/fJ3zDTO1kKIXbhxHyXNZ11HVg=;
        b=Zea4Ut/Rj+Deinnoo7xJsONmlP1BjWFnzKBj8IjD+E+I2SJ4ePMn3juIkGWazsPGHS
         XizK7V737MPlHpe48xBosLT2QOExQLVtmYSC99j1XwVCjOeM4YRKmwDEvD+FSB9TzuxQ
         yuWiJj8nh155PHCSNx1ZzCYFHrtONStN2T3CUqdywxHlOP5I0DL8CkjTun0J0/K9hJdf
         0Ggwi33O+DHbJW6qq0+aac0MWgOAIMxbEREPZVC1lZdnR0jbEC+xm8xeuD7lxQZb6Umr
         PTYKni7s4BIReR4u9mv3Kz2mC2PjIVRbr0HCFX0qfDD9imAKW3e4l+ABTEs5tFm1RXYv
         03Qw==
X-Gm-Message-State: AOJu0YwbBbulLzDwACkMVoTn693DSo0hM2i0401OJG1Q8KvW0HhgXKEV
	cykRtT8XEtza2kvUdH+rX3FdfMF/laPJ5xxy2ASAo8nED5EglnjtsiqetvN9UzKHaLCSeAGJLs8
	Thn7kfr45hDb+SAN53drjnIR/cL7ocVk=
X-Gm-Gg: ASbGncsbScxeLqEYPy3Rmq21JX3BI6ntfvYOcF7wCTXBtjwfdTnZic9oubH460lySz8
	dWOztbfYmGQn6mkgN9yKcE+o0YWGLZeaKxtUeR8N3geShHYXr8BoroEWa6MrJfGDdUVqRlDsDV0
	BML8QdLZy/10Hp23ROFkicJMJx90cyXbhHNwvCrie5SmSqYEFR/WaiacNEgm6dJ/PkH4Q9nM1JC
	BCCBmJtAJD+MuQ9bwfnMf2xUNSfUSnZgjTa6546zRZhtcPW4LVd88TK9F4gcStOH1g57xrCRrIH
	Bqgxl5x8
X-Google-Smtp-Source: AGHT+IG10Fz0lVpen9pTnjXcu8h81Dafdgs54J6+i61Y49zuCOckPnrbt30eiGcCoPzXPId17xhv8r975Vzt26iCPxs=
X-Received: by 2002:a05:6602:1508:b0:945:abea:9f6a with SMTP id
 ca18e2360f4ac-945abeaa434mr218426339f.19.1761533541221; Sun, 26 Oct 2025
 19:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025171314.1939608-1-mmyangfl@gmail.com> <20251025171314.1939608-2-mmyangfl@gmail.com>
 <cc89ca15-cfb4-4a1a-97c9-5715f793bddd@lunn.ch>
In-Reply-To: <cc89ca15-cfb4-4a1a-97c9-5715f793bddd@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 27 Oct 2025 10:51:45 +0800
X-Gm-Features: AWmQ_bmoPfYcUgstOTVsBidY-HlYrCdpiI4nXRFeg3ioqHavZdYa2xUj2m6lvcA
Message-ID: <CAAXyoMOa1Ngze9VwwUJy0E7U52=w=fQE8cxwAviGm53MSQXVEA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: yt921x: Fix MIB overflow
 wraparound routine
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:30=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Sun, Oct 26, 2025 at 01:13:10AM +0800, David Yang wrote:
> > Reported by the following Smatch static checker warning:
> >
> >   drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
> >   warn: was expecting a 64 bit value instead of '(~0)'
> >
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountai=
n/
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  drivers/net/dsa/yt921x.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> > index ab762ffc4661..97a7eeb4ea15 100644
> > --- a/drivers/net/dsa/yt921x.c
> > +++ b/drivers/net/dsa/yt921x.c
> > @@ -687,21 +687,22 @@ static int yt921x_read_mib(struct yt921x_priv *pr=
iv, int port)
> >               const struct yt921x_mib_desc *desc =3D &yt921x_mib_descs[=
i];
> >               u32 reg =3D YT921X_MIBn_DATA0(port) + desc->offset;
> >               u64 *valp =3D &((u64 *)mib)[i];
> > -             u64 val =3D *valp;
> > +             u64 val;
> >               u32 val0;
> > -             u32 val1;
> >
> >               res =3D yt921x_reg_read(priv, reg, &val0);
> >               if (res)
> >                       break;
> >
> >               if (desc->size <=3D 1) {
> > -                     if (val < (u32)val)
> > -                             /* overflow */
> > -                             val +=3D (u64)U32_MAX + 1;
> > -                     val &=3D ~U32_MAX;
> > -                     val |=3D val0;
> > +                     u64 old_val =3D *valp;
> > +
> > +                     val =3D (old_val & ~(u64)U32_MAX) | val0;
> > +                     if (val < old_val)
> > +                             val +=3D 1ull << 32;
> >               } else {
> > +                     u32 val1;
> > +
>
> What David suggested, https://lore.kernel.org/all/20251024132117.43f39504=
@pumpkin/ was
>
>                 if (desc->size <=3D 1) {
>                         u64 old_val =3D *valp;
>                         val =3D upper32_bits(old_val) | val0;
>                         if (val < old_val)
>                                 val +=3D 1ull << 32;
>                 }
>
> I believe there is a minor typo here, it should be upper_32_bits(),
> but what you implemented is not really what David suggested.
>
>         Andrew

I didn't find the definition for upper32_bits, so...

