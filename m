Return-Path: <netdev+bounces-88666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ECD8A8289
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D641F247D8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2978913D24A;
	Wed, 17 Apr 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3TrE+AuC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53C13C912
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354792; cv=none; b=NM5xFuUBmMdTB2V8cY1tsx/2JjHVNd8aDQhqPllfsfjV/1rVdcYXFuVLETfzyYJ6xsA7YeR2ZEQLFA0gh7bX0PRLTYRmofX/kXlNtIjTnK6C8tq807eCwvYZBTc+59qEk2pa2TnQZjcEtYJY9eoGA7MbYSFiQu2rWhD5udX7MGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354792; c=relaxed/simple;
	bh=cvay0J7d6+w5zTTJSAXYd0jHnKZ+RRFv3xL9x3j7DH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glyUlp4sn+q9sLUd6Eijskn/ZhU71SsBVLs9swOtNyEVERzhISqA5Dds06rBQxw+l/oeznn1bBK7UfpJp5SkfjLjcLgy/mg/CGCnL2+8nT6MC3bxng//K+JA3QXQVe4ABXzCffaJ4tmmw2ODQBgYH85uccmWRPmegFvUfW/45Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3TrE+AuC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so9820a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713354789; x=1713959589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2UbNTtwDyg5eVmNVe3yM0Jrp4kd3/qg1sndOqRKE0g=;
        b=3TrE+AuCJmPVTg9wfvZ5HxcNelOdmMRX3DNaj0eKnN8ROknQu8x44/baxdsUaNLTRw
         ai+l5dSeTnXw+AA4PQbHtTL0tnTsZNt/xf1U1xWxa7HwXcaQR7RKOXjSSb4wsF/tCyKP
         s5gpViCPPkb1lWRweDI2NGb2RTwj94Lac+x2cMZo7agHGH3Oqsu+xTZQqthX3twQ5oZg
         xseIcxWggIH4gh8YWitfl59dLE39GxqTj8ySJmcwt5Tv+Ne0FSyx9gIUE0afmKIilA/0
         InoSu9veq46hxuCGajXMVVsevllkH8y7o82lylvq12bvuxsvly1ikLtqYTU2Fcs9/U16
         gpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713354789; x=1713959589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2UbNTtwDyg5eVmNVe3yM0Jrp4kd3/qg1sndOqRKE0g=;
        b=iSkugYp70t+R87zAZDGjLRiPaS/XNTfC01aJYHz4WkUqi3p4P+dlALkqQfxh82UNni
         ygt/46Opv1DVxMoXr6zLXCqY0633IY7XWMlYVLRVvc9V2ibl3fZjjCaKp7w41797cWiY
         UFCueEPQs7btgvSLici630eqtTITmuozdcfeGTULsu6d6MTr/pxZxxE1UhVx7yil4CFS
         PWMO+WIDMlm9adwGbCTf6HGKcM+LYROxZ5HkCygT0uuWLPNAORL2itaFXYZWpo1BrHMI
         5MH8SwbKn+uM7pfQeQFcZ4EDnnTJvdm6rLwOMokWg1SKA5ZNscmsakA6flzOpkbdKhew
         7gkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNGxjRca2PVZf1Hfw6BuQmh9pSDhxlBjHocwvGBc8cTKsiRLTRHiBSBKcNKyqVQ4pEi72ZAQoQccUD12z1sd00PMBCFVYl
X-Gm-Message-State: AOJu0YxH5XaIWFPDJu2JSe6AKLxguu56uvLrxG05GIWwr12Ar5MtuDOB
	ZYl/7bUKhkcMyAKR0gWQsEeyB8Ezpd/aSSpB35Bsajz5jtjd1YKtKdUx1PZrT1tv+WOL2t6NlpA
	TF1PMBmHP/VniKg9PuTvNS9aUAM58XNvp0v+y
X-Google-Smtp-Source: AGHT+IGr6KyaTOQ0vVRcyPJCh478JQOqu4U6EHTGOeTqJNqOubDOvfyvJwPrUADqvx8nIwtyMRqPp6FMBwFyng6Ko2w=
X-Received: by 2002:aa7:cf0a:0:b0:570:5e84:5731 with SMTP id
 a10-20020aa7cf0a000000b005705e845731mr83883edy.1.1713354788453; Wed, 17 Apr
 2024 04:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417062721.45652-1-kerneljasonxing@gmail.com>
 <20240417062721.45652-3-kerneljasonxing@gmail.com> <CANn89iLKxuBcriFNjtAS8DuhyLq2MPzGdvZxzijzhYdKM+Cw6w@mail.gmail.com>
 <CAL+tcoBZ0MCntKO2POZ9g6kZ7euMXZY94FWN85siH1tZ6w5Lrg@mail.gmail.com>
In-Reply-To: <CAL+tcoBZ0MCntKO2POZ9g6kZ7euMXZY94FWN85siH1tZ6w5Lrg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 13:52:53 +0200
Message-ID: <CANn89iJovrpBc8vFadJZdA89=H5Qt8uvj2Cu3jr=HHP2pELw2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: rps: protect filter locklessly
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Apr 17, 2024 at 6:04=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Apr 17, 2024 at 8:27=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > As we can see, rflow->filter can be written/read concurrently, so
> > > lockless access is needed.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > I'm not very sure if the READ_ONCE in set_rps_cpu() is useful. I
> > > scaned/checked the codes and found no lock can prevent multiple
> > > threads from calling set_rps_cpu() and handling the same flow
> > > simultaneously. The same question still exists in patch [3/3].
> > > ---
> > >  net/core/dev.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 2003b9a61e40..40a535158e45 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -4524,8 +4524,8 @@ set_rps_cpu(struct net_device *dev, struct sk_b=
uff *skb,
> > >                         goto out;
> > >                 old_rflow =3D rflow;
> > >                 rflow =3D &flow_table->flows[flow_id];
> > > -               rflow->filter =3D rc;
> > > -               if (old_rflow->filter =3D=3D rflow->filter)
> > > +               WRITE_ONCE(rflow->filter, rc);
> > > +               if (old_rflow->filter =3D=3D READ_ONCE(rflow->filter)=
)
> >
> > You missed the obvious opportunity to use
> >
> >                if (old_rflow->filter =3D=3D  rc)
> >
> > Here your code is going to force the compiler to read the memory right
> > after a prior write, adding a stall on some arches.
>
> Thanks. I see. I will remove READ_ONCE() and then reuse 'rc'.
>
> I would like to ask one relational question: could multiple threads
> access the same rflow in set_rps_cpu() concurrently? Because I was
> thinking a lot about whether I should use the READ_ONCE() here to
> prevent another thread accessing/modifying this value concurrently.

READ_ONCE() would not prevent this.

> The answer is probably yes?

I think the answer is no.  rflow is located in
rxqueue->rps_flow_table, it is thus private to current thread.

Only one cpu can service an RX queue at a time.

I think you can scrap the patch series.

I will instead remove the not needed annotations :

diff --git a/include/net/rps.h b/include/net/rps.h
index a93401d23d66e45210acc73f0326087813b69d59..3f913464a2b321efe38a05dd107=
bf134fae6ad17
100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -134,7 +134,7 @@ static inline u32 rps_input_queue_tail_incr(struct
softnet_data *sd)
 static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
 {
 #ifdef CONFIG_RPS
-       WRITE_ONCE(*dest, tail);
+       *dest =3D tail;
 #endif
 }

diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d85b335a9158378ae0cca6dfbf8b36..d774e4009790c9af30d3c8f9a5e=
ab83e9cf01bd8
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4613,7 +4613,7 @@ static int get_rps_cpu(struct net_device *dev,
struct sk_buff *skb,
                if (unlikely(tcpu !=3D next_cpu) &&
                    (tcpu >=3D nr_cpu_ids || !cpu_online(tcpu) ||
                     ((int)(READ_ONCE(per_cpu(softnet_data,
tcpu).input_queue_head) -
-                     READ_ONCE(rflow->last_qtail))) >=3D 0)) {
+                     rflow->last_qtail)) >=3D 0)) {
                        tcpu =3D next_cpu;
                        rflow =3D set_rps_cpu(dev, skb, rflow, next_cpu);
                }
@@ -4668,7 +4668,7 @@ bool rps_may_expire_flow(struct net_device *dev,
u16 rxq_index,
                cpu =3D READ_ONCE(rflow->cpu);
                if (rflow->filter =3D=3D filter_id && cpu < nr_cpu_ids &&
                    ((int)(READ_ONCE(per_cpu(softnet_data,
cpu).input_queue_head) -
-                          READ_ONCE(rflow->last_qtail)) <
+                          rflow->last_qtail) <
                     (int)(10 * flow_table->mask)))
                        expire =3D false;
        }

