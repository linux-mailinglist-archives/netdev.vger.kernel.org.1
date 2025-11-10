Return-Path: <netdev+bounces-237265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C3C47CCE
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D1AD34A0B4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717927703E;
	Mon, 10 Nov 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJg/bx6Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88A2749E0
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791009; cv=none; b=a8R4dhOK/urCEPgRzacphHY0Y6zJMdReEN1pW+vRUliLaXf6k6H1hNe8B/tH9h73ZSZ63u/iO6w5Pg6ea9pX52c46QLebxPIGDHO8/cYPmnBopJLX2zDKvUyTZX+RDILKOEuf4DTddigAUCKR7oU4pWsAfjmgQMx3ur4mte43AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791009; c=relaxed/simple;
	bh=fd6DgtWYreXG8Ewqp8z3RyNBgjj2ALfi7k6H9GI7hJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUZPtCJaWOlVSfjt1f+aAY8ww+OGPC23AyJLpwKGOM/aRjs9Hy3HjNYLMm7Jj3tzP++6GltvLviGOdN3Pc1BL4zwCdo4r6zxvH0gZ5kCA459NvDsTcPPkbKUM3HouIEdVqYL15ll7wRUJ/FX+9brGzqnFBTaOpffoi0XnWRvvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJg/bx6Q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1973823a12.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762791007; x=1763395807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w7Jk9YDKfcszn45fhg/EFtez+/rPgvGoVqVgilqkwk=;
        b=IJg/bx6QDMWNUfnzAw8itRhtgYSQYt+p4fKtvuOotOmT2If2oxzWbvB7aITt+eJbp8
         QmHP6maaXBSdh5a46Nn/TDV9f8nfvCKhuGamODQzhU22ME124jrBny7jxieAzw8J4K2D
         11ee7EzvtHBr3KDOMmIAGdjJ81UwCdayO71ml8DcIMsHOk9ljnwXdF+iKCUN07Z4vX/N
         /xFRw7KXxYtYW6Kz+dvp9WpNNzxg60UiXiqqyM2h6I9tQYnqf3BnrBtWQ5hQfKmQIKSJ
         lJC9AJ5yxJgvYT8llP6K8CaxC6/GZby5EuvlGFwlc/0epgFzd+uGwhrwlztqtqMLUT2u
         9OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762791007; x=1763395807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9w7Jk9YDKfcszn45fhg/EFtez+/rPgvGoVqVgilqkwk=;
        b=V/pyczA30puyyWREyTixjEo8N59j2Wu9CfE81eGuMMNHEq8+2Syn4weeuV97hoJwkH
         odsgsUlaEHfOhgtSeJF/AFjqgt0VxElOcMkDo56jfIg3NtLFrfhbBDMCPkpkpJQhAExX
         HILNF9LRl3gBEfRwNLJXnFUpACBJK1pNR8E5BFzcSxPXyRJqJ1VdHdMNK5M2UaFjkjle
         99yiMFCSH8QT4V0YDDozna7W6TMImk6yHhuQI+MmHyvgCs/97bAy7yZAiiK2nsYoMoIz
         ShmchJ/CjdrJq6hCbjgKnu7JMcg5Xd43UvbXdFXFwJYjiBfcDaEyUuhaQ/NU9+z40ngm
         8V/w==
X-Forwarded-Encrypted: i=1; AJvYcCW0AAMz/mGjUsu2OzFAN75HBPc7KJgvvMDHQFv/5MwlsGdmqa2SWU22GNokPBhTt0FNp8kdCiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPrllnkTQGOtxQkR24M9FiLgrDRH1q6GUsCDg6DtbtBjLljOnD
	jI3i6EFNMo3BMKPrC5euf8zfqrTorzBXjqt449SkK/5yLaAaoHB/AHGDxbvTA6RP8yvVhO95mzi
	POYk2lGgtLEO1KNRYVsqPfzHBtRG+3LE=
X-Gm-Gg: ASbGncuItdq84cGWPIWzD7g7ZUPqim+ogbAC6BpNPib4afWBaWYmemWicFE3EtBeThF
	SpsUfFQgtoKei/sgLnE7FCiEPrxbsPLOHhcW/UwDsxkUnfdaiHz0k9gU0JGK3rmmPGWP8E35ewd
	n3figvTa+RPQc4Iqh01ME2aDTdUIhAM/hpoItIup+az6hn594iWHTDSP8jKKNZCgD5xKlgPPVF0
	C8wcy81aVqBicpVsYy3Z9ubuCcwV4MPiDcWeZUdQMO46Hje8NStFZfxZto4vGjtJYuU0eLPNtnY
	+YVCtIDfP+KsDkzTnA==
X-Google-Smtp-Source: AGHT+IH4ojjvQcs/UpKwM+/qpvHiRS+0WlI9TNFVx/r8vaeHA49i5XVfYyo5SJSI4H1NcrJnmaifXtaf5vF+fK6xRK0=
X-Received: by 2002:a17:902:ef52:b0:28e:9427:68f6 with SMTP id
 d9443c01a7336-297e5678930mr110555665ad.27.1762791007318; Mon, 10 Nov 2025
 08:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106111054.3288127-1-edumazet@google.com> <CADvbK_fZABufnbF9vsS_GZ6OgYfKb7nT3NDdT+iO-C7Rw9K6mw@mail.gmail.com>
 <CANn89iLUiYteUoLV_AiZeW8rJe5ns5uu5gmQHbjmdQPD3sZy5A@mail.gmail.com>
In-Reply-To: <CANn89iLUiYteUoLV_AiZeW8rJe5ns5uu5gmQHbjmdQPD3sZy5A@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Nov 2025 11:09:56 -0500
X-Gm-Features: AWmQ_bnd81VUCG-dAizHMqoXcZgC7UPpYcGmfz9JzxwmAlLLZUqacqCSy5EdCFo
Message-ID: <CADvbK_ec6_YZzZ8H+2PP+XV1Y0xE-SrTFbhf0aNspsr-N-0SDw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:42=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Nov 10, 2025 at 7:36=E2=80=AFAM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Thu, Nov 6, 2025 at 6:10=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > syzbot reported a possible shift-out-of-bounds [1]
> > >
> > > Blamed commit added rto_alpha_max and rto_beta_max set to 1000.
> > >
> > > It is unclear if some sctp users are setting very large rto_alpha
> > > and/or rto_beta.
> > >
> > > In order to prevent user regression, perform the test at run time.
> > >
> > > Also add READ_ONCE() annotations as sysctl values can change under us=
.
> > >
> > > [1]
> > >
> > > UBSAN: shift-out-of-bounds in net/sctp/transport.c:509:41
> > > shift exponent 64 is too large for 32-bit type 'unsigned int'
> > > CPU: 0 UID: 0 PID: 16704 Comm: syz.2.2320 Not tainted syzkaller #0 PR=
EEMPT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 10/02/2025
> > > Call Trace:
> > >  <TASK>
> > >   __dump_stack lib/dump_stack.c:94 [inline]
> > >   dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
> > >   ubsan_epilogue lib/ubsan.c:233 [inline]
> > >   __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
> > >   sctp_transport_update_rto.cold+0x1c/0x34b net/sctp/transport.c:509
> > >   sctp_check_transmitted+0x11c4/0x1c30 net/sctp/outqueue.c:1502
> > >   sctp_outq_sack+0x4ef/0x1b20 net/sctp/outqueue.c:1338
> > >   sctp_cmd_process_sack net/sctp/sm_sideeffect.c:840 [inline]
> > >   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1372 [inline]
> > >
> > > Fixes: b58537a1f562 ("net: sctp: fix permissions for rto_alpha and rt=
o_beta knobs")
> > > Reported-by: syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/690c81ae.050a0220.3d0d33.014e.=
GAE@google.com/T/#u
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > ---
> > >  net/sctp/transport.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/sctp/transport.c b/net/sctp/transport.c
> > > index 0d48c61fe6adefc1a9c56ca1b8ab00072825d9e6..0c56d9673cc137e3f1a64=
311e79bd41db2cb1282 100644
> > > --- a/net/sctp/transport.c
> > > +++ b/net/sctp/transport.c
> > > @@ -486,6 +486,7 @@ void sctp_transport_update_rto(struct sctp_transp=
ort *tp, __u32 rtt)
> > >
> > >         if (tp->rttvar || tp->srtt) {
> > >                 struct net *net =3D tp->asoc->base.net;
> > > +               unsigned int rto_beta, rto_alpha;
> > >                 /* 6.3.1 C3) When a new RTT measurement R' is made, s=
et
> > >                  * RTTVAR <- (1 - RTO.Beta) * RTTVAR + RTO.Beta * |SR=
TT - R'|
> > >                  * SRTT <- (1 - RTO.Alpha) * SRTT + RTO.Alpha * R'
> > > @@ -497,10 +498,14 @@ void sctp_transport_update_rto(struct sctp_tran=
sport *tp, __u32 rtt)
> > >                  * For example, assuming the default value of RTO.Alp=
ha of
> > >                  * 1/8, rto_alpha would be expressed as 3.
> > >                  */
> > > -               tp->rttvar =3D tp->rttvar - (tp->rttvar >> net->sctp.=
rto_beta)
> > > -                       + (((__u32)abs((__s64)tp->srtt - (__s64)rtt))=
 >> net->sctp.rto_beta);
> > > -               tp->srtt =3D tp->srtt - (tp->srtt >> net->sctp.rto_al=
pha)
> > > -                       + (rtt >> net->sctp.rto_alpha);
> > > +               rto_beta =3D READ_ONCE(net->sctp.rto_beta);
> > > +               if (rto_beta < 32)
> > Wouldn't be better to do:
> >
> > rto_beta =3D min(READ_ONCE(net->sctp.rto_beta), 31U); ?
> >
> > so that when rto_alpha >=3D 32, the update will not be skipped entirely=
.
>
> Skipping or not the update is a matter of taste really.
>
> If someone was setting 30 or more, it was expecting tp->rttvar and
> tp->srtt to not change at all,
>
But you do see (u32) >> 31 can be 1, that makes the tp->rttvar/srtt
change slightly.
So the 'expecting no change' is from practical experience, right?

>
> >
> > > +                       tp->rttvar =3D tp->rttvar - (tp->rttvar >> rt=
o_beta)
> > > +                               + (((__u32)abs((__s64)tp->srtt - (__s=
64)rtt)) >> rto_beta);
> > > +               rto_alpha =3D READ_ONCE(net->sctp.rto_alpha);
> > > +               if (rto_alpha < 32)
> > > +                       tp->srtt =3D tp->srtt - (tp->srtt >> rto_alph=
a)
> > > +                               + (rtt >> rto_alpha);
> > >         } else {
> > >                 /* 6.3.1 C2) When the first RTT measurement R is made=
, set
> > >                  * SRTT <- R, RTTVAR <- R/2.
> > > --
> > > 2.51.2.1026.g39e6a42477-goog
> > >

