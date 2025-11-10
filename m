Return-Path: <netdev+bounces-237268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD77BC47F71
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AF014F1FE1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F99279DB4;
	Mon, 10 Nov 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC9TjOHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7ED274671
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792117; cv=none; b=P/gg8nUCwxh+OljfmA23WdRD2KZio58n7O9PAl1nHw91SmGYj7K0b+6DmWpWWg8IgMzoXcdJEN52RHs3ZtZ4H1dCWfC5msknhweeq3mKUn4R+FaU94bGOc1ZqP0SR8qtapfM6RnBOJLPeZcObyL+8aRcAJrLsUdG8af64KqkOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792117; c=relaxed/simple;
	bh=kjIi1JHEbRwwJotEAt1pDvjpCJyt7G3kIMHYXFHcHUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F34z8NTkSy8Urh7j2C2txo3yYlbxnZdYShA6R31SV+Tmmg99g372+2zs5OEYTyggGevQ+LubTsdmc5xHR0WtoV+bmTvTTW+hd93L8wJVgUFUA0KeV7LN1eLfg2v/j1Tq59CyTnSccCsdWtJYi9bu309R8PsoheEr25dYJN3AnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC9TjOHa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2980d9b7df5so12611075ad.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792116; x=1763396916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53787g/x6T5HYi9G7xWPEMSHMKe/xwZXrkJzMhNqGNg=;
        b=VC9TjOHa80zVgIQgWzaGIBpxZDMlf6uj0JA+YwoYqDeXOmi2MmiiOx/iRLm/xKS7if
         gmyMVtDewcQ3lxqUms22mqaB7NhVlYLUK3ssF88pB+QdhUj8joNETShxqC7CBD1QqfN5
         ZQTyxZTcN4B8LQPLWfvzBVTuqykGlTpYH2At8dl51cgMY0Bz3tIf4vAaX1yTdq8NC4YY
         HXQkjOCRHRTtrpMjwskvmN5jdV36sOaypWRbvTuZy+AgEraVRqelQKId/43TmcuuDZu2
         NIff3rdN+R4onv5KbcPm/7NkqSJO4iTt5D71dDCwUsJz590ODiDiJ8gmJ13Fl3SjR+XZ
         xoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792116; x=1763396916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53787g/x6T5HYi9G7xWPEMSHMKe/xwZXrkJzMhNqGNg=;
        b=tzCN2Uz6Ko7JTghSSQ25kE1uN2zzo7gDD8xONIMtQCdCi++qKvTIemLjryBV9K4IF+
         psEHgfkFJawN9OWFF2n0VhEGbEYO3pfdTdhWLf2+0k7v/WmOuXR0Dgg2FklgSslq/NqE
         cO5UG6vhSz+iWVKhav3nvmesbZkNUjb5zlPhmbf6bALzpOMPlPjzMOoOuRPzwlQjimoA
         Nmy8/4gNp2LGSH/diGsrJgE7MtAGUCDkyx/Nw7BbX20TyG+mSFzFHdm8iU91C1YdWsW9
         QK2dnbrP7a9bv/GHa458OcLlJ8SHk/XfrfoKCpNZ6xg9xXzCZF08BAnW51yLNhzkkg5E
         UNjg==
X-Forwarded-Encrypted: i=1; AJvYcCXUOdo4ZKLoh71rtPoU1pW3DTBVmXlGoFcnPbNJICK54OOwUvgSKcwq3dwxVSrhJHbl9OlF8Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCpvfOFDNiJd3CDvpr65qhN+5lyXraUav7CQ8kb9HeLdBZGR/Y
	Zp0KPPuMEQDKuzc5ltBHZwJooPMxnYfiqsl7Ud2V72gGtTDoNEqHnHOhn7jEaq77behB9FnSF7i
	Tbxl8Xbqd31NTX2YmgFq/WL+afMrIlbA=
X-Gm-Gg: ASbGncsKXrIjYR9WJKTdHL7t2OZNec6aFcnKOuum251suns86JEQxi4DUe6/VFPYuix
	YrN6W+ZCuJ9cBMFPC3ukBM4i++iaKzVnzKeyZzvgvB0MCBPBVoFUsaFvDXbt8ttVHswIBybDMA0
	GRuVDDvPqrrIaRfJi1P0HAnKP7g9QZxSgrIQ7K8nnPh+KxdDoWczQoqj0Unhh2EXXSvjXwrAenL
	Y9Q75RKcDZd+6mQhXTZ2tZv18L+kkHQiqDiDeFQ06IqoF5o6dA1sqqNWGmmAwRcsIRNAOMRRvmM
	nOBRHFzkPcUX22JIlg==
X-Google-Smtp-Source: AGHT+IG5fnMEseAO8PLiGvwGfE2pG+CRxlRJLzFTIMGi0nE2aO/rMt4tPs6XW9ok5ycehG9lMwhHpC7YV1vPWVy03fI=
X-Received: by 2002:a17:902:e951:b0:298:ab7:85b3 with SMTP id
 d9443c01a7336-2980ab78690mr72154455ad.55.1762792115400; Mon, 10 Nov 2025
 08:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106111054.3288127-1-edumazet@google.com> <CADvbK_fZABufnbF9vsS_GZ6OgYfKb7nT3NDdT+iO-C7Rw9K6mw@mail.gmail.com>
 <CANn89iLUiYteUoLV_AiZeW8rJe5ns5uu5gmQHbjmdQPD3sZy5A@mail.gmail.com>
 <CADvbK_ec6_YZzZ8H+2PP+XV1Y0xE-SrTFbhf0aNspsr-N-0SDw@mail.gmail.com> <CANn89i+RuN43Gy6jgd9kW3kjGkzonx6-sP0QP6PNid4_9gP4RQ@mail.gmail.com>
In-Reply-To: <CANn89i+RuN43Gy6jgd9kW3kjGkzonx6-sP0QP6PNid4_9gP4RQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Nov 2025 11:28:24 -0500
X-Gm-Features: AWmQ_bnCDEzQ0WxMhwfFD_VHq5iUIZfziyK_86DelFrcH7Shjf88I2HY0CVjzwU
Message-ID: <CADvbK_f1sfYOxrgcoK-PhWy_vyG-jqRaO8F3CiB9xUTqu1D8pg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:13=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Nov 10, 2025 at 8:10=E2=80=AFAM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Mon, Nov 10, 2025 at 10:42=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Mon, Nov 10, 2025 at 7:36=E2=80=AFAM Xin Long <lucien.xin@gmail.co=
m> wrote:
> > > >
> > > > On Thu, Nov 6, 2025 at 6:10=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > > >
> > > > > syzbot reported a possible shift-out-of-bounds [1]
> > > > >
> > > > > Blamed commit added rto_alpha_max and rto_beta_max set to 1000.
> > > > >
> > > > > It is unclear if some sctp users are setting very large rto_alpha
> > > > > and/or rto_beta.
> > > > >
> > > > > In order to prevent user regression, perform the test at run time=
.
> > > > >
> > > > > Also add READ_ONCE() annotations as sysctl values can change unde=
r us.
> > > > >
> > > > > [1]
> > > > >
> > > > > UBSAN: shift-out-of-bounds in net/sctp/transport.c:509:41
> > > > > shift exponent 64 is too large for 32-bit type 'unsigned int'
> > > > > CPU: 0 UID: 0 PID: 16704 Comm: syz.2.2320 Not tainted syzkaller #=
0 PREEMPT(full)
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 10/02/2025
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >   __dump_stack lib/dump_stack.c:94 [inline]
> > > > >   dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
> > > > >   ubsan_epilogue lib/ubsan.c:233 [inline]
> > > > >   __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
> > > > >   sctp_transport_update_rto.cold+0x1c/0x34b net/sctp/transport.c:=
509
> > > > >   sctp_check_transmitted+0x11c4/0x1c30 net/sctp/outqueue.c:1502
> > > > >   sctp_outq_sack+0x4ef/0x1b20 net/sctp/outqueue.c:1338
> > > > >   sctp_cmd_process_sack net/sctp/sm_sideeffect.c:840 [inline]
> > > > >   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1372 [inline]
> > > > >
> > > > > Fixes: b58537a1f562 ("net: sctp: fix permissions for rto_alpha an=
d rto_beta knobs")
> > > > > Reported-by: syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.co=
m
> > > > > Closes: https://lore.kernel.org/netdev/690c81ae.050a0220.3d0d33.0=
14e.GAE@google.com/T/#u
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > > ---
> > > > >  net/sctp/transport.c | 13 +++++++++----
> > > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/net/sctp/transport.c b/net/sctp/transport.c
> > > > > index 0d48c61fe6adefc1a9c56ca1b8ab00072825d9e6..0c56d9673cc137e3f=
1a64311e79bd41db2cb1282 100644
> > > > > --- a/net/sctp/transport.c
> > > > > +++ b/net/sctp/transport.c
> > > > > @@ -486,6 +486,7 @@ void sctp_transport_update_rto(struct sctp_tr=
ansport *tp, __u32 rtt)
> > > > >
> > > > >         if (tp->rttvar || tp->srtt) {
> > > > >                 struct net *net =3D tp->asoc->base.net;
> > > > > +               unsigned int rto_beta, rto_alpha;
> > > > >                 /* 6.3.1 C3) When a new RTT measurement R' is mad=
e, set
> > > > >                  * RTTVAR <- (1 - RTO.Beta) * RTTVAR + RTO.Beta *=
 |SRTT - R'|
> > > > >                  * SRTT <- (1 - RTO.Alpha) * SRTT + RTO.Alpha * R=
'
> > > > > @@ -497,10 +498,14 @@ void sctp_transport_update_rto(struct sctp_=
transport *tp, __u32 rtt)
> > > > >                  * For example, assuming the default value of RTO=
.Alpha of
> > > > >                  * 1/8, rto_alpha would be expressed as 3.
> > > > >                  */
> > > > > -               tp->rttvar =3D tp->rttvar - (tp->rttvar >> net->s=
ctp.rto_beta)
> > > > > -                       + (((__u32)abs((__s64)tp->srtt - (__s64)r=
tt)) >> net->sctp.rto_beta);
> > > > > -               tp->srtt =3D tp->srtt - (tp->srtt >> net->sctp.rt=
o_alpha)
> > > > > -                       + (rtt >> net->sctp.rto_alpha);
> > > > > +               rto_beta =3D READ_ONCE(net->sctp.rto_beta);
> > > > > +               if (rto_beta < 32)
> > > > Wouldn't be better to do:
> > > >
> > > > rto_beta =3D min(READ_ONCE(net->sctp.rto_beta), 31U); ?
> > > >
> > > > so that when rto_alpha >=3D 32, the update will not be skipped enti=
rely.
> > >
> > > Skipping or not the update is a matter of taste really.
> > >
> > > If someone was setting 30 or more, it was expecting tp->rttvar and
> > > tp->srtt to not change at all,
> > >
> > But you do see (u32) >> 31 can be 1, that makes the tp->rttvar/srtt
> > change slightly.
> > So the 'expecting no change' is from practical experience, right?
>
> EWMA31 on rtt is a NOP, unless rtt is more than 2^31
>
> A - (A >> 31) + (RTT >> 31)   -> A
>
> Is SCTP dealing with this level of RTT ?
>
I would not think so, the connection must have broken before that :-)

Acked-by: Xin Long <lucien.xin@gmail.com>

THanks.

