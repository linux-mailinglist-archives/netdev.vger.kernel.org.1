Return-Path: <netdev+bounces-227653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1367BB4E0A
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 20:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DF92A2964
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB429277CA5;
	Thu,  2 Oct 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKawoDk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666A276027
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429931; cv=none; b=RhJ3WOSVaH4f0A4g/HhqkWpraNzxyRH8BRPcCCek0orvXkadHaAMmz9Ts90norJ0ItRvUrct+V0bf2mspanIgK4UcxjWxATvkyvUB/X0Uo+wlYpVZOdVre7tUg6f/qh1EIvDWR/di15QZy7qTRYPl2YB6w1TaQ16Fz0+kNcJyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429931; c=relaxed/simple;
	bh=UyDRhwIZr0wQtDNdqpTYj4LFriGBJZRLGT/DA4pwCg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wgpj6FBiyk33mAe61RIu/gO0EhwfF+zvkmBxPP8sDHp1qkmw7+L87Ath9KUW4CldutqIWRA8dg8EPvuwLizroRLFcQFG/wZVdzLL0BxE5VUjUJQPXM6SM1nCZbh7y9qkxxGPqfwSlmA/g12CoeMtstMDe7PuEBwk1yNQUDJt85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKawoDk7; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5579235200so955366a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759429929; x=1760034729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xG0CcI6s1hgPAwUG8O/9m8f6+Wz/D5AR23LZQVr7Po=;
        b=eKawoDk7chzeMPvdMYx+EtN85XUFz1AnhawYii94uLI8U69nJZdhsz5cOGy0e0dCqm
         bF9Mc3oi3eZHN+6GJFX+Jb8p0fPXn53rAabYgOCn//KtA0iqSWgkMra+IqqMg/+QYDRS
         uR2OLvrNIgae1s8j2i24IydTAdOg239y3CeQ3Lz0jPs15cnN/Mjw8J6+W4fJHFGYjiLR
         A3ZPhmRpnQexXiQKZ2hZES7LmoCXWRGqU84aTdJyW85upg1axEl7ZtB53kJoihIuS4mb
         cP/wlx0GfLtSwCw2g3e8QOAyNeLiXXKC7O1DV/Tkt3Pygi6Qbr0bWScFJMxWTeG8gYW9
         6gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759429929; x=1760034729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xG0CcI6s1hgPAwUG8O/9m8f6+Wz/D5AR23LZQVr7Po=;
        b=IMWBt1PpfTSdyFC81pLLq2N74v8fDr2IoeHA/9FqIUwz5Zf143+bGOD8dlBGE0xGrD
         kZmlsG8AnQtbUvAUvFlGSdyel0MrvjF2Xnq/YJgy0k8VvpfM3WLdlA06ilivwEjyExOY
         UTYMR0dYlsMZ+vKb+PSwplL/mcCffgqufzBO6cKJF1KMxXws7kVMqJYYXmOu9+Cez2fl
         DZ+Y21QgTdQD0wUZVfs/G9aAgPqV8r6AUPGda4szwZdqOTjkwCZVWn9cPhvl0R/hVMpE
         /xMf48zVBceb/WMBnT1RUaa4F0qilZyvTi8fwckiuj2Hi6DMiI8wjvoimjSgqRzTtSfe
         sU4w==
X-Forwarded-Encrypted: i=1; AJvYcCXD64itvky50V+yyEdlMN+ZzJoGOzvsDW08BOhqudATw5jhw36wY7s/05wD3AVn9mgXwMYQ9zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrkEPotfVe4/7UiZ5ez0qXEV9zmdvHhHxQGzG27ApByoEpLCD+
	vgkrL5mvrqhVDfsuRrFDMuKegMq+X2ad+B/umMh1F4joFEeqZmroVoguiW1XwL3xZkglTPT5uwL
	N3HzUDe3scAiL6Z+hZkNazz0A9JX0ZF8=
X-Gm-Gg: ASbGncs5XhQWbcP0J3hC6m1LlsE86uSZW0MYvOzYLu4m2yfyv/MWbOCYJNbQVENohkk
	H/OQMHHeP9d4TcyZ8bSiPpmVt0bvKH/uj7VbmAx9wZgDQw/ex4RX3bRv87bT7SKKe4fJnS0XZFA
	auOTc5bJFxBJ7A1IzQh3fxvjEZ44RgbPQsPhuw1eZ5jjrfltKEhJ/dz8mY9fLrq/++EGcs1Hs8H
	oOFSjBA4bs4LnXSvpcvzcSFMotKk+dAbqB6ComCAuSnU4bUMFtNoBsNCJRhpfgfELrFJNkLHCJb
	68J6eltehMoDM8PBYg==
X-Google-Smtp-Source: AGHT+IEstN7kMZUYjY35DUMyOR6/5I8AHe5nv1wJrlRFIJk67TwL0o89K8lWPuQFmVis/Y7cpKJ9BygZB+7IHAI5vYo=
X-Received: by 2002:a17:903:4b08:b0:26a:f6e6:ef4f with SMTP id
 d9443c01a7336-28e9a65e62bmr2322505ad.60.1759429929219; Thu, 02 Oct 2025
 11:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com> <34901d4b-0fa9-4a86-b8b1-9c9dc5ed0e2e@gmail.com>
In-Reply-To: <34901d4b-0fa9-4a86-b8b1-9c9dc5ed0e2e@gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 00:01:57 +0530
X-Gm-Features: AS18NWBo8w6ka6isASgG_CEDtwSQpfX2F1TyKo17vjYa0mOH_V4nWvDlLzsdOF0
Message-ID: <CAL4kbRNZNYHdwy1jLREEU0Bt9Tsy7oS-LXU1oi33gNLBj-OUUw@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion. For this patch, I opted to handle the
fallback locally in ppp_cp_event to keep the change minimal and low
risk.

On Thu, Oct 2, 2025 at 11:46=E2=80=AFPM Dimitri Daskalakis
<dimitri.daskalakis1@gmail.com> wrote:
>
> On 10/2/25 11:05 AM, Kriish Sharma wrote:
>
> > Fixes warnings observed during compilation with -Wformat-overflow:
> >
> > drivers/net/wan/hdlc_ppp.c: In function =E2=80=98ppp_cp_event=E2=80=99:
> > drivers/net/wan/hdlc_ppp.c:353:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/wan/hdlc_ppp.c:342:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Introduce local variable `pname` and fallback to "unknown" if proto_nam=
e(pid)
> > returns NULL.
> >
> > Fixes: 262858079afd ("Add linux-next specific files for 20250926")
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> > ---
> >  drivers/net/wan/hdlc_ppp.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
> > index 7496a2e9a282..f3b3fa8d46fd 100644
> > --- a/drivers/net/wan/hdlc_ppp.c
> > +++ b/drivers/net/wan/hdlc_ppp.c
> > @@ -339,7 +339,9 @@ static void ppp_cp_event(struct net_device *dev, u1=
6 pid, u16 event, u8 code,
> >               ppp_tx_cp(dev, pid, CP_CODE_REJ, ++ppp->seq, len, data);
> >
> >       if (old_state !=3D OPENED && proto->state =3D=3D OPENED) {
> > -             netdev_info(dev, "%s up\n", proto_name(pid));
> > +             const char *pname =3D proto_name(pid);
> > +
> > +             netdev_info(dev, "%s up\n", pname ? pname : "unknown");
> >               if (pid =3D=3D PID_LCP) {
> >                       netif_dormant_off(dev);
> >                       ppp_cp_event(dev, PID_IPCP, START, 0, 0, 0, NULL)=
;
> > @@ -350,7 +352,9 @@ static void ppp_cp_event(struct net_device *dev, u1=
6 pid, u16 event, u8 code,
> >               }
> >       }
> >       if (old_state =3D=3D OPENED && proto->state !=3D OPENED) {
> > -             netdev_info(dev, "%s down\n", proto_name(pid));
> > +             const char *pname =3D proto_name(pid);
> > +
> > +             netdev_info(dev, "%s down\n", pname ? pname : "unknown");
> >               if (pid =3D=3D PID_LCP) {
> >                       netif_dormant_on(dev);
> >                       ppp_cp_event(dev, PID_IPCP, STOP, 0, 0, 0, NULL);
> Would it be better to return "unknown" in proto_name()'s default case?

