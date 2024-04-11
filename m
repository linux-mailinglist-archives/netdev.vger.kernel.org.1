Return-Path: <netdev+bounces-86887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D08A09D3
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F671C228C3
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1813E05C;
	Thu, 11 Apr 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOp9BWkr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5D13E054
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820724; cv=none; b=GCQn/Ivel/DonApsT3pqR5lAaUh3u5tyE8U9ghzzOknFqcOCCDn+0yBD9RigZdtFVS/N+i2uznwXP+JT5gbRE24OxVM1xwJoi0fyHkAFSUUhdMcGNB67kVYgaC3KSoXjJfmzqpMPENtR1neNRPVLRItv1pd/mUbP+FPaDdlpRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820724; c=relaxed/simple;
	bh=Eh7Czu/OI4+eoP5b6Py8c0km0edprBBj5/JAaQTf7qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaZcO2lKAcLgrXcVVDvdeOK2q5f69yziaV40djOL5irkmvEF8HGfTxpBwQAEegFocl3eeyGx1oEcfxyznIRis01pVY7Qqs971MC8zGr5OnMUrPX+B7g5KVgIMjipGOu+llOqnKleLNw76kkouxC75iVGe4TIlDoKMu+fu9+FzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOp9BWkr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so5253234a12.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712820721; x=1713425521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si4TDT3Y3AiF/tXq2NpkocWPQXoKoUxu5ZhAZYhSVrk=;
        b=nOp9BWkru8pmvR6ut7ZJc5LVeVxfGwrgbRh76b97hwA/+ZTSI1bzwKzmtgrTqeRa8+
         /7Fu7dl4g3YqSy1rbM0XZPNwlkLARh4WrOVaFxtU8xrfPuQtWBgvDIrf+IK07QtRB0cA
         8+3DW8AAPnHVwzycHYIq9T/s9ypzFfb8vtDw2/G/It5AQrF6aY9i8zQl/tuEPwr3wYvy
         VO/nk0+VS5LOz13iogpH5AxiJLuns8eZOwahc7t+0l6vfLtijyLZr/D+9GKUF9U6plQR
         Sh1C/Qqzf9wgboy7lpRt+Mw4swENp/8EIsnQQMWnBqAdkHmhdjO+EIoN01KFsZt6HtE3
         N+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712820721; x=1713425521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si4TDT3Y3AiF/tXq2NpkocWPQXoKoUxu5ZhAZYhSVrk=;
        b=CZ6bLTl9C3573xgW2P0Suo49r3xCbgyN1ka6rE9F5lT7Jg7gzFQfQdLf3xwAaCqu7c
         HJ0zbFi8ijoL/bO0+Oy1O6nSgR7kQ7nBtJmgup0Srpr0e+ZhPRy8CQGc2Z4E6kpwJawl
         5ys4FhQPU14omEd+rpDJ6RGDYA1S5nI7h/BDfCak0wlL6a/9EEFmL0mpn3mbJhgW94ag
         qON8JUGIC/BkKMmpUBNEOXoklfvCPz7FMbV/Z+f1a9TG6J/dwXTgT+JA7n83QKbi850h
         HByH0beyfBq453ws1EacP30pJK+EL2Y2WO09Xmi+IhJwplidU5dCgfXdZqx/G//AF3BA
         WG6w==
X-Forwarded-Encrypted: i=1; AJvYcCUhH6CrNKgu9/eP4XLrmQ8w5iA2+/+jBY+E3tfeqpjM3XuetcqBUEjqy1PPODy6Cj/7I8PjyieRGw4YKOrSUffI1WDFAcDe
X-Gm-Message-State: AOJu0YzTA92MTrdIWZNi3aCzytz9m2EcmToeDHVjJf60ir1U77fNR7ZU
	swQwSyAnOKVQODKcsapzFkEjH2TMXysrM8g8myieNTFFv6YFBXrmhd23qzXIPelRCpd48E9Y/ge
	iM2kC3nnXN7xvxaBHZjlvIvwT0TA=
X-Google-Smtp-Source: AGHT+IExVWNIztD8HgKIB4s78Wv8qk6/AVU06c0vQC3FYNqJhCulW9FcI0wxTgXvnyViSXnWzrCAUzO9pOkOvHNYVCg=
X-Received: by 2002:a17:906:2c0a:b0:a4d:f5e6:2e34 with SMTP id
 e10-20020a1709062c0a00b00a4df5e62e34mr2937695ejh.19.1712820720899; Thu, 11
 Apr 2024 00:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411032450.51649-1-kerneljasonxing@gmail.com>
 <CANn89i+2XdNxYHFNwC5LHupT3je1EaZXMxMJG9343ZO9vCzAsg@mail.gmail.com>
 <CAL+tcoC2FW2_xp==NKATKi_QW2N2ZTB1UVPadUyECgYxV9jXRQ@mail.gmail.com> <CANn89i+6gWXDpnwM9aFtP_d_oTfQRDJdu+VMoDtvVcDrzBM_JA@mail.gmail.com>
In-Reply-To: <CANn89i+6gWXDpnwM9aFtP_d_oTfQRDJdu+VMoDtvVcDrzBM_JA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 11 Apr 2024 15:31:23 +0800
Message-ID: <CAL+tcoAZYeFsoPEFvWSFUTezofpkvwzggJd9zp81yTAy4PVOpw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: save some cycles when doing skb_attempt_defer_free()
To: Eric Dumazet <edumazet@google.com>
Cc: pablo@netfilter.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, horms@kernel.org, aleksander.lobakin@intel.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 3:12=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 11, 2024 at 8:33=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Apr 11, 2024 at 1:27=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 5:25=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Normally, we don't face these two exceptions very often meanwhile
> > > > we have some chance to meet the condition where the current cpu id
> > > > is the same as skb->alloc_cpu.
> > > >
> > > > One simple test that can help us see the frequency of this statemen=
t
> > > > 'cpu =3D=3D raw_smp_processor_id()':
> > > > 1. running iperf -s and iperf -c [ip] -P [MAX CPU]
> > > > 2. using BPF to capture skb_attempt_defer_free()
> > > >
> > > > I can see around 4% chance that happens to satisfy the statement.
> > > > So moving this statement at the beginning can save some cycles in
> > > > most cases.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/core/skbuff.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > index ab970ded8a7b..b4f252dc91fb 100644
> > > > --- a/net/core/skbuff.c
> > > > +++ b/net/core/skbuff.c
> > > > @@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *s=
kb)
> > > >         unsigned int defer_max;
> > > >         bool kick;
> > > >
> > > > -       if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
> > > > +       if (cpu =3D=3D raw_smp_processor_id() ||
> > > >             !cpu_online(cpu) ||
> > > > -           cpu =3D=3D raw_smp_processor_id()) {
> > > > +           WARN_ON_ONCE(cpu >=3D nr_cpu_ids)) {
> > > >  nodefer:       kfree_skb_napi_cache(skb);
> > > >                 return;
> > > >         }
> > >
> > > Wrong patch.
> > >
> > > cpu_online(X) is undefined and might crash if X is out of bounds on C=
ONFIG_SMP=3Dy
> >
> > Even if skb->alloc_cpu is larger than nr_cpu_ids, I don't know why the
> > integer test statement could cause crashing the kernel. It's just a
> > simple comparison. And if the statement is true,
> > raw_smp_processor_id() can guarantee the validation, right?
>
> Please read again the code you wrote, or run it with skb->alloc_cpu
> being set to 45000 on a full DEBUG kernel.
>
> You are focusing on skb->alloc_cpu =3D=3D raw_smp_processor_id(), I am
> focusing on what happens
> when this condition is not true.

Sorry. My bad. I put the wrong order of '!cpu_online(cpu)' and 'cpu >=3D
nr_cpu_ids'. I didn't consider the out-of-bound issue. I should have
done more checks :(

The correct patch should be:
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab970ded8a7b..6dc577a3ea6a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
        unsigned int defer_max;
        bool kick;

-       if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
-           !cpu_online(cpu) ||
-           cpu =3D=3D raw_smp_processor_id()) {
+       if (cpu =3D=3D raw_smp_processor_id() ||
+           WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
+           !cpu_online(cpu)) {
 nodefer:       kfree_skb_napi_cache(skb);
                return;
        }

I will submit V2 tomorrow.

Thanks,
Jason

