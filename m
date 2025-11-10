Return-Path: <netdev+bounces-237250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE7C47C74
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA45A3B940D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E336257841;
	Mon, 10 Nov 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6gUDVfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079D26F443
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789356; cv=none; b=GHdxpymGHheGAOi/BYIOwuWHApqJLYTowXVSrIfxxd7Z9NfJc4Sx6v1yEOZNs2bX3SV11sLX2Z8iOrfDXnApKF+QFxflcmqplHpWwNx5rZ6Nqd+ZxKaJbnKPu+s2HoEtyugbL/dc9YYmbQv834Mi6UL3MQ/uqBq6UyiInAawupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789356; c=relaxed/simple;
	bh=Wk7OEAIm+YhJN0bl/25mfduKM6JkrL1iaxUr/xjPWV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5dB5EpaTtCrE7Hq7F3YKlFLfoperiLjTGLEXJ1y7S73Ml/94RiZHIVd7F0soizie/9p1DxirB+1+UVDuiMHFjzhrlKqhiRCk5708gKNQ8AeyHg8RQw3n7MYU5Tck4+fGVcRLtiDqNtL+SFt6rBwk28f8calqxvtmqqdOd1Mvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6gUDVfZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4edb2eef810so20769151cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 07:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789353; x=1763394153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naa0Xx0rF2nxqDQMqtUtFjK8ka1GPEo7lAdw6zaxtxk=;
        b=i6gUDVfZdxrlscKjOWHsVzpTsKbwe4zlytgYRVbQ3OSgNMAcE2DTimi+a71UJJRUU7
         ie1m6sVETNU4L6jTg4aZF4HqQ0jCyZAdDUeLFUaRfJ3/umQTeAg1NhFFSdatfKnZfkME
         Ni1TNFdtFSTmttqUZIW3HJYv9bMv45h7urG8odVUG0U771sh3Bo4YTZb3tEaKj26QRR0
         cSHPd07fP1UmZX8RvZyOJKxoMSnljCdajgfsMQDOd8C3WMBAOdVR6Yjczmj/t0/lm8SD
         o3Ezj4bdzwwD3eGXpU08E43/R82DfKJZDI6wiWWFyZsBcK+C5Y0m2/8Ww87bnw+X6mAt
         Di6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789353; x=1763394153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=naa0Xx0rF2nxqDQMqtUtFjK8ka1GPEo7lAdw6zaxtxk=;
        b=Ac8ZJn265oiPCBdVQKSOkwWxWgs1TISpfW7ST3OZCDOkL2tbWZjkhihrajsp+yq6yo
         ZADDMYG7BWB+1ZwvXvGHfLgX7UHCiP0GEH+BYTBldY+5Yepab+486DjlhhQx8tl0+Qp1
         8ez931smzEV2js+RM2i3Xu901NaQWHr0QeKbHiJW3DdTVB1aGsClpbxnITlHQXiOup7V
         ANrTtNeNp1k+PcsqPFYZKBQUd0I81WUjkPrf5yP5dCOcz4JNRAawv9Kz6hNDRVnhhvmz
         jf2D6ee2TjOWYbrrvayr0iv+A0+1rHsHm3p3i+/H8iWC2CTy+1UpHoYiZcvj5MiRf+oB
         +JDg==
X-Forwarded-Encrypted: i=1; AJvYcCVMRNvqwNpj+Zy+HjdWLh4jzTsd4jufBdGnsv23SfOJ1e8DYfbTUz3OaJ+1sCVb7ltCjWnGXiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZf/V8mSf8Vw8Xv+LR173HYb/l+z9u5NJT2xQ52jkgOhYOll/
	cxMwjmf1MVQ/Q7pbMfVmFiPLIxK2A2GrGn9rVfE9jhFmVqc6IL94oTKGI52gBhobZQacaDFW9TX
	6uhBrLq8mL2UL4GcDTe7BdO3qAAYuDTRM4EvZpBan
X-Gm-Gg: ASbGncs0a8R5A5K6eNuQmk0zuKAIUOIUGRJeepXB0LWGpeicuBr6N6h80z3DAX6itDR
	IgWicQQqX7+5x6OWr5b27LhXhTR0YU8MsuQ5bjJw3BRe20pVJP1ylc25Bl95X+kIEczRyJDSYOI
	u+lsCzSw3Olx+elVqc/mYSjWnk+Ew1i5NhbUNmwRoD3Gsjv+iW3ag3dbI7fIx6+uiq0dUJcedR9
	LVXnj71L3NyQQp8WP7VN4FsJ+rZythA0NBRO30tZPHyXWaLwpC9wtRh+SfT
X-Google-Smtp-Source: AGHT+IHx9zBMrTSRLei+eORgEhsgaG7T57bJ8DPsQIWX+vlhYmqpEpXN6LNtFzrWxdKz3Y/JdWfsPByW1Oxxztn/rTA=
X-Received: by 2002:a05:622a:1455:b0:4ec:fc63:2587 with SMTP id
 d75a77b69052e-4eda4f9a601mr97528851cf.50.1762789352746; Mon, 10 Nov 2025
 07:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106111054.3288127-1-edumazet@google.com> <CADvbK_fZABufnbF9vsS_GZ6OgYfKb7nT3NDdT+iO-C7Rw9K6mw@mail.gmail.com>
In-Reply-To: <CADvbK_fZABufnbF9vsS_GZ6OgYfKb7nT3NDdT+iO-C7Rw9K6mw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Nov 2025 07:42:21 -0800
X-Gm-Features: AWmQ_bnb48HN6WImp65bknk8b5x0uUR-FlpYmRF5IrKzW5EXrIowz5EZyy5EOvg
Message-ID: <CANn89iLUiYteUoLV_AiZeW8rJe5ns5uu5gmQHbjmdQPD3sZy5A@mail.gmail.com>
Subject: Re: [PATCH net] sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:36=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Thu, Nov 6, 2025 at 6:10=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > syzbot reported a possible shift-out-of-bounds [1]
> >
> > Blamed commit added rto_alpha_max and rto_beta_max set to 1000.
> >
> > It is unclear if some sctp users are setting very large rto_alpha
> > and/or rto_beta.
> >
> > In order to prevent user regression, perform the test at run time.
> >
> > Also add READ_ONCE() annotations as sysctl values can change under us.
> >
> > [1]
> >
> > UBSAN: shift-out-of-bounds in net/sctp/transport.c:509:41
> > shift exponent 64 is too large for 32-bit type 'unsigned int'
> > CPU: 0 UID: 0 PID: 16704 Comm: syz.2.2320 Not tainted syzkaller #0 PREE=
MPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/02/2025
> > Call Trace:
> >  <TASK>
> >   __dump_stack lib/dump_stack.c:94 [inline]
> >   dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
> >   ubsan_epilogue lib/ubsan.c:233 [inline]
> >   __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
> >   sctp_transport_update_rto.cold+0x1c/0x34b net/sctp/transport.c:509
> >   sctp_check_transmitted+0x11c4/0x1c30 net/sctp/outqueue.c:1502
> >   sctp_outq_sack+0x4ef/0x1b20 net/sctp/outqueue.c:1338
> >   sctp_cmd_process_sack net/sctp/sm_sideeffect.c:840 [inline]
> >   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1372 [inline]
> >
> > Fixes: b58537a1f562 ("net: sctp: fix permissions for rto_alpha and rto_=
beta knobs")
> > Reported-by: syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/690c81ae.050a0220.3d0d33.014e.GA=
E@google.com/T/#u
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  net/sctp/transport.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/sctp/transport.c b/net/sctp/transport.c
> > index 0d48c61fe6adefc1a9c56ca1b8ab00072825d9e6..0c56d9673cc137e3f1a6431=
1e79bd41db2cb1282 100644
> > --- a/net/sctp/transport.c
> > +++ b/net/sctp/transport.c
> > @@ -486,6 +486,7 @@ void sctp_transport_update_rto(struct sctp_transpor=
t *tp, __u32 rtt)
> >
> >         if (tp->rttvar || tp->srtt) {
> >                 struct net *net =3D tp->asoc->base.net;
> > +               unsigned int rto_beta, rto_alpha;
> >                 /* 6.3.1 C3) When a new RTT measurement R' is made, set
> >                  * RTTVAR <- (1 - RTO.Beta) * RTTVAR + RTO.Beta * |SRTT=
 - R'|
> >                  * SRTT <- (1 - RTO.Alpha) * SRTT + RTO.Alpha * R'
> > @@ -497,10 +498,14 @@ void sctp_transport_update_rto(struct sctp_transp=
ort *tp, __u32 rtt)
> >                  * For example, assuming the default value of RTO.Alpha=
 of
> >                  * 1/8, rto_alpha would be expressed as 3.
> >                  */
> > -               tp->rttvar =3D tp->rttvar - (tp->rttvar >> net->sctp.rt=
o_beta)
> > -                       + (((__u32)abs((__s64)tp->srtt - (__s64)rtt)) >=
> net->sctp.rto_beta);
> > -               tp->srtt =3D tp->srtt - (tp->srtt >> net->sctp.rto_alph=
a)
> > -                       + (rtt >> net->sctp.rto_alpha);
> > +               rto_beta =3D READ_ONCE(net->sctp.rto_beta);
> > +               if (rto_beta < 32)
> Wouldn't be better to do:
>
> rto_beta =3D min(READ_ONCE(net->sctp.rto_beta), 31U); ?
>
> so that when rto_alpha >=3D 32, the update will not be skipped entirely.

Skipping or not the update is a matter of taste really.

If someone was setting 30 or more, it was expecting tp->rttvar and
tp->srtt to not change at all,


>
> > +                       tp->rttvar =3D tp->rttvar - (tp->rttvar >> rto_=
beta)
> > +                               + (((__u32)abs((__s64)tp->srtt - (__s64=
)rtt)) >> rto_beta);
> > +               rto_alpha =3D READ_ONCE(net->sctp.rto_alpha);
> > +               if (rto_alpha < 32)
> > +                       tp->srtt =3D tp->srtt - (tp->srtt >> rto_alpha)
> > +                               + (rtt >> rto_alpha);
> >         } else {
> >                 /* 6.3.1 C2) When the first RTT measurement R is made, =
set
> >                  * SRTT <- R, RTTVAR <- R/2.
> > --
> > 2.51.2.1026.g39e6a42477-goog
> >

