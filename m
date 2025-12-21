Return-Path: <netdev+bounces-245665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72567CD47A6
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 00:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9DDB3005FFC
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052132DC77E;
	Sun, 21 Dec 2025 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov9VM3ol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FA2DCF72
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766361061; cv=none; b=USJbX9ZBxdC/hrA0xbd11t9tBMEwRJqd782NsJRdAWlb08rnYW8/6qLQcyLhtEqJhazdNq3GhCzWp8uwCmYTF28S3xYh86zV3SdDM5TXhEva4oWnF8lfeK1pdBEVnI6ug5oriub3lHOpEAUg2WKsKpkwTvbrl3dFtRmv3Fj3JMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766361061; c=relaxed/simple;
	bh=UHUSk6IlQkgaPX0gSqu9fEXMfnJ5VOTMeH/+8DAFLYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=PWT3uBWq12dE7/tbl1r1mTI66d6FQJGcMQHgn8YEVLFBCF46EpbodeMcxhAvBS7Qdf1rpFAjWMmJe/F72dU+dtfhmSuoQaLEzYRARD/RqiQINFTcZjsWZXL7hDWW/ehZ3jIQ00rEKU3iWEnUuJf5nljN/USkRRCmuQsI/gEa/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov9VM3ol; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4edb6e678ddso50077661cf.2
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766361057; x=1766965857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z2S2s+uKqhgB3zsJAyAhxwuX4Wuy3l8oX0/z7zKD3Q=;
        b=Ov9VM3ol6haYc2K1upysWo04RSLM7kjG1TspXaAiFDyUef9CI0QrnQM1/OzUE82SwP
         94gOALnJZQCaq/hOScFHj8TRty3HYy6WZxsVkWyZq8k/txWsoRO55NWkBQVGf6qTqAdb
         u81pMkw/0042N2X7V8+B1VjvPgluJ37wk+r9tyvm1cfi9kCcZGOPkDKPzpDtlIlGroyT
         zCeGNXGOsmcDvKVRuLXWB6zcXPtqtZO3L9Ty3eGlrsdNvnF7XgnheMxTbtAPmQodDDNF
         xUGcwsDJqahd7auPc5ve/tOO7Wb2E/xq0yzM3mbUVh/USeM0GejnhlWXwekSji5VF0YX
         O/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766361057; x=1766965857;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4z2S2s+uKqhgB3zsJAyAhxwuX4Wuy3l8oX0/z7zKD3Q=;
        b=qtZrkbZFSKHU10MtBEoSUs6K/NhUXMJBlbGYa5CH9XUeOHc6581eCyOyNhDNj3cSyZ
         GEsrNUk13qiTFC17jzEdY9sGGFzUnJGefrX1zkCQ8Hisiwn4obrr0stSVHPITxIYhpjM
         V6QBAKVH2VwV2s662Tcs32mNkDQIor7B2TtU9/ISlJ+EEZ8tnOHGi4gQhR7eJcNApclg
         kxOdClmGX2bw8GP4TQ+35lUiAT1572akLlFjOT6pXJWoRy8XuXTQWRD9cFEhupW/lj6H
         rS8xWPu4s9fYmffIwv6Pth+4pq9s2TixO4/qE1V2GThmEzA8nJBONv6yu/NRByH897ed
         kRew==
X-Gm-Message-State: AOJu0YxR1KymT+UpwORRgmvKLvFNbOSao+GKD33Cry2YJW8/LwmrDR6H
	vnwcNJ19g94mcf/+VX2MCV0rqXrdh7DoYo+i9/v2u3bVzZH/+NBIGYbJ3CB7C6+F9j75Kgk5s7C
	+ZXcQbhbXYrw3ZR+ZlDTr2U4SOW5TDREkQgVXcnKYbg==
X-Gm-Gg: AY/fxX5s43uHa25EZRcz0zwNCnGmFK5szSjf9YzH4o/Ep28lb1JUOlvYITn5SVt9mIq
	C5SZNMNV9TgytsBxkAWAUMWcjf6kpzMwZImIfkbSy4vCpzfDLhL7Oo+J6uj1bkpSbPf987UhVkt
	v5Ux7SeOgCv61qcU2rIbwovLrN/RnojA9YjFMAbSSH6wLQWXd97l3iAq1YnZ2sqtaM6k4SeJsWa
	AJP+/81n0Yk3Dj3TyQ7wdJWHxkAPsDFfV0/Qh6Swj8K4wBQYlCJHZpiKEbHH3HlPV8MPI6eMZxL
	mY4FDHiK13Ub78MIMvzGbdOSWeQjHkbdAeGK8LNbTRSbv+Yln9DnGk+ZJEtlHsLQoxDh
X-Received: by 2002:ac8:5c81:0:b0:4ed:44a7:cf78 with SMTP id
 d75a77b69052e-4f4abcfc08cmt159003421cf.34.1766361056666; Sun, 21 Dec 2025
 15:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221082400.50688-1-enelsonmoore@gmail.com> <4eb474ac-5e12-4237-bec8-f0cc08b00bb1@lunn.ch>
In-Reply-To: <4eb474ac-5e12-4237-bec8-f0cc08b00bb1@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 21 Dec 2025 15:50:45 -0800
X-Gm-Features: AQt7F2pXNxOlIsQWNGzsoeXHoTrwDKsapHLuZqv309p4Ul6_qfoeSkBW-saZodQ
Message-ID: <CADkSEUgX5FN6kgs5FSZGRoF6icXmUyp67y55=sRAXzWnsHGzEQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: sr9700: fix incorrect command used to write
 single register
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew,

The other two are correct because they intend to write multiple
registers - they are used with a length parameter.

Ethan

On Sun, Dec 21, 2025 at 4:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Dec 21, 2025 at 12:24:00AM -0800, Ethan Nelson-Moore wrote:
> > This fixes the device failing to initialize with "error reading MAC
> > address" for me, probably because the incorrect write of NCR_RST to
> > SR_NCR is not actually resetting the device.
> >
> > Fixes: c9b37458e95629b1d1171457afdcc1bf1eb7881d ("USB2NET : SR9700 : On=
e chip USB 1.1 USB2NET SR9700Device Driver Support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> > ---
> >  drivers/net/usb/sr9700.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
> > index 091bc2aca7e8..5d97e95a17b0 100644
> > --- a/drivers/net/usb/sr9700.c
> > +++ b/drivers/net/usb/sr9700.c
> > @@ -52,7 +52,7 @@ static int sr_read_reg(struct usbnet *dev, u8 reg, u8=
 *value)
> >
> >  static int sr_write_reg(struct usbnet *dev, u8 reg, u8 value)
> >  {
> > -     return usbnet_write_cmd(dev, SR_WR_REGS, SR_REQ_WR_REG,
> > +     return usbnet_write_cmd(dev, SR_WR_REG, SR_REQ_WR_REG,
> >                               value, reg, NULL, 0);
> >  }
> >
> > @@ -65,7 +65,7 @@ static void sr_write_async(struct usbnet *dev, u8 reg=
, u16 length,
> >
> >  static void sr_write_reg_async(struct usbnet *dev, u8 reg, u8 value)
> >  {
> > -     usbnet_write_cmd_async(dev, SR_WR_REGS, SR_REQ_WR_REG,
> > +     usbnet_write_cmd_async(dev, SR_WR_REG, SR_REQ_WR_REG,
> >                              value, reg, NULL, 0);
> >  }
>
> I don't know anything about this hardware, but there are four calls using=
 SR_WR_REG:
>
> https://elixir.bootlin.com/linux/v6.18.2/source/drivers/net/usb/sr9700.h#=
L157
>
> You only change two here? Are the other two correct?
>
> It might be worth while also changing the name of one of these:
>
> #define SR_WR_REGS              0x01
> #define SR_WR_REG               0x03
>
> to make it clearer what each is actually used for, so they don't get
> used wrongly again.
>
>         Andrew

