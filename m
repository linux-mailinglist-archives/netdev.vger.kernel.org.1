Return-Path: <netdev+bounces-88703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567DF8A8502
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882241C20849
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C3D13BAFB;
	Wed, 17 Apr 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuiMdD9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFD13EFEC
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361311; cv=none; b=lGmkrsimzDZMMk7obKlJq9VR5xCowgp2+JQ37y/DhCfBqYPsDs/L0yU9qKNy7lUbTybwcMMXjQE7ottXIzJ/uMWKtqXaMgbPpWjZ3eb3xSx7skPHF6Rlczk4qNdw6taZjnVEHZ011xqfYsk5KxJWEdQUR+Bv84RDH8z5zzOsh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361311; c=relaxed/simple;
	bh=X+/cfiR4iNqSKXq8lW33tt99/MeuzNZg7ukPyI8/gjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qklUocw1P31ps8kmPjP1QtpzwaM+SMYo3KrcuSLZC4ZXToPH4bSupzeLKHe0S8RDRnZZpWtWwA0EgIRgf3JnXsvcD+7JRRf5B+r/JL8AaYq5sg0Hw1v70v/qln8+ikrHqd6fsPDtwqqxSJgIJNZ0xRp4eE6dhQNVsVyLjosYmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuiMdD9m; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5700ed3017fso13967a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713361308; x=1713966108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir6mAZ6zXQKjXFH2S4EFREhOkP7PFDaMNclShTW76p0=;
        b=MuiMdD9mlCspBTSbizzONZA33owHoLbDeRPYP5/5bRng7hGTXflhzo5BFlLguHJ9No
         x17V8QVolqFHfdDpbCecNFNUaZ207zNGsHaTFKl4zGeB0LB/9pFzja1Xaccpg6ug9P0r
         zeA9RAH2m3QBEZzBi7Jm/U32BcCWo3ELznRsi+kwYNPgBvS3ShZamRPCmBZLb0j4kuRs
         5di0l0dENZoSSYRqeyO0jO7KbL83k/e7dB1V6XoX+dG5j2bPmVWz+2UCpWth8Ck+y4/x
         KZwui+cb/8UKWV47c1OfUfYKk/XVkOP5wOfktUQB9vYraq6gSs9NCPRxSv2nh4Qg+sT+
         LJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713361308; x=1713966108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ir6mAZ6zXQKjXFH2S4EFREhOkP7PFDaMNclShTW76p0=;
        b=xIJxF86mDIyMDQCYhJIkQajDxa2mtmFeUuz3EjiLVZyHCzhDQYL/ueAWZFLX5I1kWE
         HGvYxV5xrKvSq5hw6408+4wVNFq1C5gaet4wHE1o8CagewULrZyceL+aBd2quq2/2CHG
         C5d+40uoDk27FMXkLlsXiQVL5aucbPzV5L0IrEpZAu3QxkmU/DvAn2ZteRe7vZVr9h9S
         Addi8fXrqj8oLqr3ZrmnuP4OnARNqnL00ikFlcMIJdjtUFsSdkHHhbVcFjU8CVLRTAze
         ZH5ZwTvqaaZTMBp5VJhnRtNnGC0izNi28VEEKesMVDPkPSoErtyiLcDEtA1TrjhxVzu0
         GV7w==
X-Forwarded-Encrypted: i=1; AJvYcCUijYThXFtLPB0cw2lenm0B7KbOXVj1co/xxD7QOcktsIRQAMhexW/kh2GX3M72cT1hx4L629OXxCTBF51/gLDhhlT3N5S/
X-Gm-Message-State: AOJu0YwFFxRQM+yKjNpgBtmUt9KYeFXPQ69gA5t9W98LWg4fGWtdAt0T
	hlRSQ8Pvi3NPqmyLP2k26L6RkX5FmsY9FzZIUkR9aQc3C2/khDEhArwVLNVc98PSqEi3twyTLV0
	1Os3nSTtw/qgrFy0OlfEgCtAOcgUGE/iKQc8o
X-Google-Smtp-Source: AGHT+IFsb715k64J9SwPrrrSA5GdkhJwQXlEH6djqerBuf23jjhspvA88wftknnWwOnPxpMx54ju/XCyqWdsb2plHeU=
X-Received: by 2002:aa7:d749:0:b0:570:320c:821a with SMTP id
 a9-20020aa7d749000000b00570320c821amr212557eds.2.1713361307496; Wed, 17 Apr
 2024 06:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-5-edumazet@google.com>
 <20240417131404.GX2320920@kernel.org>
In-Reply-To: <20240417131404.GX2320920@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 15:41:36 +0200
Message-ID: <CANn89iJkEzcU1-8yJF6AvYUqiE1U8-4oUcLOe73EtV=sHHnjZw@mail.gmail.com>
Subject: Re: [PATCH net-next 04/14] net_sched: sch_choke: implement lockless choke_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:14=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 15, 2024 at 01:20:44PM +0000, Eric Dumazet wrote:
> > Instead of relying on RTNL, choke_dump() can use READ_ONCE()
> > annotations, paired with WRITE_ONCE() ones in choke_change().
> >
> > Also use READ_ONCE(q->limit) in choke_enqueue() as the value
> > could change from choke_change().
>
> Hi Eric,
>
> I'm wondering if you could expand on why q->limit needs this treatment
> but not other fields, f.e. q->parms.qth_min (aka p->qth_min).

Other fields got their WRITE_ONCE() in red_set_parms()

+       WRITE_ONCE(p->qth_min, qth_min << Wlog);
+       WRITE_ONCE(p->qth_max, qth_max << Wlog);
+       WRITE_ONCE(p->Wlog, Wlog);
+       WRITE_ONCE(p->Plog, Plog);


>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/red.h     | 10 +++++-----
> >  net/sched/sch_choke.c | 23 ++++++++++++-----------
> >  2 files changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/net/red.h b/include/net/red.h
>
> ...
>
> > @@ -244,7 +244,7 @@ static inline void red_set_parms(struct red_parms *=
p,
> >               max_P =3D red_maxp(Plog);
> >               max_P *=3D delta; /* max_P =3D (qth_max - qth_min)/2^Plog=
 */
> >       }
> > -     p->max_P =3D max_P;
> > +     WRITE_ONCE(p->max_P, max_P);
> >       max_p_delta =3D max_P / delta;
> >       max_p_delta =3D max(max_p_delta, 1U);
> >       p->max_P_reciprocal  =3D reciprocal_value(max_p_delta);
>
> A little further down in this function p->Scell_log is set.
> I think it also needs the WRITE_ONCE() treatment as it
> is read in choke_dump().
>

I will squash in v2 the missing WRITE_ONCE(), thanks !

diff --git a/include/net/red.h b/include/net/red.h
index 7daf7cf6130aeccf3d81a77600f4445759f174b7..802287d52c9e37e76ba9154539f=
511629e4b9780
100644
--- a/include/net/red.h
+++ b/include/net/red.h
@@ -257,7 +257,7 @@ static inline void red_set_parms(struct red_parms *p,
        p->target_min =3D qth_min + 2*delta;
        p->target_max =3D qth_min + 3*delta;

-       p->Scell_log    =3D Scell_log;
+       WRITE_ONCE(p->Scell_log, Scell_log);
        p->Scell_max    =3D (255 << Scell_log);

        if (stab)

