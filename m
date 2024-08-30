Return-Path: <netdev+bounces-123688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EDB96622B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9681F255E0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F381A284C;
	Fri, 30 Aug 2024 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="F8T6J93n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1A19995B
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022705; cv=none; b=E0vTTRrpHTMSSr83N0K1++cSRn4r63t0+HxMRK/XI415oX+i4h0PHxCuMUYhf/U99mlNtOQaoyf5dDB6vWgOcVX+ijj+r8v0xwrixe9lP9UJXGuhOjH986+mQa2mFHZ+1/ZvmAkyB/gv1pUPQa4YqSf+jsqfhNHWNjNZaSdxqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022705; c=relaxed/simple;
	bh=q6C0QbwlZ8bWPzWNj5Wpp/Ls9Ao5dRgXaiIg0HeEQK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0cis0JnvrZwA6BKw1Hg5dzkB9UbYdm4D17fuxGMAVHJx7aqFhjYFXJYMU6npwvDeLyF7Jt9/yD1tJimpPgnu7mnPVRiysVPl016YwVCcxJaWvnJoLvew3akk4aPYHtsjHoQjwJKob0Pb5NRmW+mic1V6nb5SBvNy3i7uGu391E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=F8T6J93n; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45681098bbdso15873631cf.1
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1725022703; x=1725627503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHY2MAsMyPjJRozsNU6xOeZT7J7x2bfZTUu25H3K7VM=;
        b=F8T6J93nAmFKkJEnO3MazxELlP6cabGB/kMBuh+aao3/ZCexyvyDyr2i+2SG4dNtjx
         yE5AaKeh4H2q0OZxQpvWH30I2BR30waHjzAeamDIGFCMg9Wsj63JM6YMMBCufOrCA5ND
         4eEyZV+Ze1ZzIkugWBv+Te1gXZ6eKqH20VFOHPB84aiJrRdQNzsc1h2C5BouzZeo9GhA
         oaxLK0L/mx7xymmd1u1LNud1CYh7ojCrLPXy/qxsbWqP8Jn10owrOkUJBAIEvX4nSjc9
         TbIKo3zti0XAjcvfdi8kNFUv4HQpeganAI3qL7riCTnxH1FqEcYgrQcgzc6igL3B/yk5
         kw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022703; x=1725627503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHY2MAsMyPjJRozsNU6xOeZT7J7x2bfZTUu25H3K7VM=;
        b=Ut3a+rERkZDOM92I0t9am2WIYczNCSsrDsmcb9Hj/MsjZVkg5LDuhWvHJogIwYV6Nj
         i7oKmQ4mMb0aT/oVDHqVmNpDxIwNe9cXW3OfGLbxZgLNJMbm/uQeDvGbKbv4EAdkS7zx
         6pKUV5YQ8oCyr+cDFvQwuqvBhe1/AJZb38y+1+mBeAuEkB7XGWbnImpXGMrokaHUbJBD
         Wj9a1h36xFexF19jDXC0lQstIwbc5nJxnt1Q3kTQz6lN8GuTaYxT0KYCmOVxp2TfUe0r
         CVZkzQGa+VmpW7dL3KnXL5RGk7krR6R7lZiqNBMHwmInuwXkpcZZbtUESP4gnDyi+g3M
         O+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVD7FI+ibD629ux6mP58SSJ6gj4Jj+GK2FSE1PizXXHv4yBOuIH1ohQX5Wqb5QUT5e4/gSxMnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFqCe2LGlGjCantVKxPE+4X+ons3dHQlmKWgwH2hqO0gbysIT
	RxXwCUSq1TSVadBFKRagBz6PR6xLqLg3KKmOCqkJE5o68f1L9gL0EQhSs6saNBjUHJfyFyRGu8o
	39o67XAY4AtNTUPtz/WsPSe40F1lZDaW+vfMzaA==
X-Google-Smtp-Source: AGHT+IGLCbgTmLIdILs/Eg4Fdv4t8yyw4ppw3tOy7+4g4xz6Qly6CnuU3a8xlhW2KTgAvExXC4j2BRRVc83sBHot540=
X-Received: by 2002:ac8:7f0f:0:b0:447:f8b1:aeb9 with SMTP id
 d75a77b69052e-45680261b90mr95859631cf.16.1725022703058; Fri, 30 Aug 2024
 05:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240828214524.1867954-1-max@kutsevol.com>
 <20240828214524.1867954-2-max@kutsevol.com> <ZtGGp9DRTy6X+PLv@gmail.com>
In-Reply-To: <ZtGGp9DRTy6X+PLv@gmail.com>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Fri, 30 Aug 2024 08:58:12 -0400
Message-ID: <CAO6EAnUe5-Yr=TE4Edi5oHenUR+mHYCh7ob7xu55V_dUn7d28w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Breno,


On Fri, Aug 30, 2024 at 4:45=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Maksym,
>
> On Wed, Aug 28, 2024 at 02:33:49PM -0700, Maksym Kutsevol wrote:
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 9c09293b5258..e14b13a8e0d2 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/inet.h>
> >  #include <linux/configfs.h>
> >  #include <linux/etherdevice.h>
> > +#include <linux/u64_stats_sync.h>
> >  #include <linux/utsname.h>
> >
> >  MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
>
> I am afraid that you are not build the patch against net-next, since
> this line was changed a while ago.
Yes, that's true. Jacub sent me the link to the net-tree specific
contribution doc, I also found
that. Will fix it in the next set.

> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D10a6545f0bdc
>
> Please develop on top of net-next, otherwise the patch might not apply
> on top of net-next.
>
> > +/**
> > + * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that cou=
nts errors
> > + * @nt: target to send message to
> > + * @msg: message to send
> > + * @len: length of message
> > + *
> > + * Calls netpoll_send_udp and classifies the return value. If an error
> > + * occurred it increments statistics in nt->stats accordingly.
> > + * Noop if CONFIG_NETCONSOLE_DYNAMIC is disabled.
> > + */
> > +// static void netpoll_send_udp_count_errs(struct netpoll *np, const c=
har *msg, int len)
>
> Have you forgot to remove the line above?
Yes, thank you.

> > +static void netpoll_send_udp_count_errs(struct netconsole_target *nt, =
const char *msg, int len)
> > +{
> > +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > +     int result =3D netpoll_send_udp(&nt->np, msg, len);
> > +     result =3D NET_XMIT_DROP;
>
> Could you please clarify why do you want to overwrite `result` here with
> NET_XMIT_DROP? It seems wrong.
Unfortunately I sent this patch with my debugging addons, this is plainly w=
rong.
Will remove.

> > +     if (result =3D=3D NET_XMIT_DROP) {
> > +             u64_stats_update_begin(&nt->stats.syncp);
> > +             u64_stats_inc(&nt->stats.xmit_drop_count);
> > +             u64_stats_update_end(&nt->stats.syncp);
> > +     } else if (result =3D=3D -ENOMEM) {
> > +             u64_stats_update_begin(&nt->stats.syncp);
> > +             u64_stats_inc(&nt->stats.enomem_count);
> > +             u64_stats_update_end(&nt->stats.syncp);
> > +     };
> > +#else
> > +     netpoll_send_udp(&nt->np, msg, len);
> > +#endif
>
> I am not sure this if/else/endif is the best way. I am wondering if
> something like this would make the code simpler (uncompiled/untested):
Two calls in two different places to netpoll_send_udp bothers you or
the way it has to distinct cases for enabled/disabled and you prefer to
have it as added steps for the case when it's enabled?


> static void netpoll_send_udp_count_errs(struct netconsole_target *nt, con=
st char *msg, int len)
> {
>         int __maybe_unused result;
>
>         result =3D netpoll_send_udp(&nt->np, msg, len);
> #ifdef CONFIG_NETCONSOLE_DYNAMIC
>         switch (result) {
>         case NET_XMIT_DROP:
>                 u64_stats_update_begin(&nt->stats.syncp);
>                 u64_stats_inc(&nt->stats.xmit_drop_count);
>                 u64_stats_update_end(&nt->stats.syncp);
>                 breadk;
>         case ENOMEM:
>                 u64_stats_update_begin(&nt->stats.syncp);
>                 u64_stats_inc(&nt->stats.enomem_count);
>                 u64_stats_update_end(&nt->stats.syncp);
>                 break;
>         };
> #endif
>
> Thanks for working on it.
> --breno

