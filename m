Return-Path: <netdev+bounces-141881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89D19BC97C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFFF280FF6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0BE1D0784;
	Tue,  5 Nov 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnoHUFwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E61CEE88
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799737; cv=none; b=BYWsClhfw9+xnhqf3E1x6t8cDEGJCo+Yjs4aStxCdiQbX54IX8S7fWSjA2flDjJpQKBAOKLjn6PKUmmKtFDrHaKc2ifinWtiEonVXrzpXRsf0JJdlbnFOBi/y1ZsXKnNellsbggVRhpxM6Z4agQtjL1QhpFmuQ49o42zfJiCsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799737; c=relaxed/simple;
	bh=aSr0qjB2ATLX5WqXskqAfGck7dBLu96Tulml1zzcMZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT9mnTM5D0ijtKjNO/f2ickaGQBi+gCYZE25Ys3omGZtKiT+D7NP0t7Ik/CoI3byg9SL8FTHA7iEi9SwmfSJQ4ni5ozFVB1srKqUlAIkhoSBxf4dXdJSQNvFv6eZ6dldVn0Y34znGd6OMmzWFlEccLsS6WbGk/rXslCuh3X/qdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnoHUFwq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a6be9bd626so9400775ab.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730799735; x=1731404535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UQBPEet3PABk0fxmZnfkPFPiKPciUgyfXUgDaCNmvE=;
        b=nnoHUFwqyjywid+BtWN8YROldc3qIZgKo1ZacNAiX7hbU6SWoVZiFdRXh1TNmo/gHf
         Vfbhob2xOEcbmxZV4Elyw9qONF+EsfXCb49zUw/k9HtR2oL9pOjNHOyd+vxz9yFcfsWj
         f5nkCfBJSbujHr0veTEneOKx7md/pR568Dtaj94N+vcCVTJwRVHkkLLgxQEXjil4KWgU
         bp3Wdxs0+695PNwl4x50ctSpCuxg01r6YkXrn2yvJmlyvbXD03P2otA5qD5xmoWAu4/2
         7GJjpSwwgkDB+b+Fgu2ETWh7LcN2eyvjaywpGNs4V8Zj6CtJhq39aooJboyI2MtE3n5v
         5PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799735; x=1731404535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UQBPEet3PABk0fxmZnfkPFPiKPciUgyfXUgDaCNmvE=;
        b=IHyalAUylOsOt0oxxQm1hGQV45WSfjOLfvMrNRKLwdKymSXB5kXj1EPx5ERExWd555
         XBddASnxl/LlPpCfQa3AcILyz8He7ZAQdSjRgS3ejPwZ2YYyi2DyWE9A/L9tTD35d/mm
         c0mhXxXdKi4dY2XTiyGaGNZ61F1VPVmLnOkzfWIBF/zjo+KM2Oa75BAhaQUxKnZ7SeMZ
         B0JNcMMnjfgCtoRWWGW0tUSEFQMI/2ZhPBpcH1Lcod9Kvw07/gpi0UkyQy+VEK3ejRX/
         ugNxkGYmS3G34PYS4nP6pKEELYXRbjgLcYPxpGgqIrdsU9TrOAI6mPBjCgmLDMyh5Sm5
         WTXg==
X-Forwarded-Encrypted: i=1; AJvYcCV5mV0stWzEWfaOTm8r7ykEL6lBa9Qca7bIYBbQkM2U8evZG97kEcO1I8x4VDWpUfqxkHbxoQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+bB81KLd+T8AahykImw3zUnfe1ntEsiJGZQ30OzfSVx7UVpu
	fFfF9vl7weta9rgbxCRLXHqcRsHJft/J0qFdK5oTJsJ5HFHpqT5oPo4M8iCC4COYPKeat8/5bkD
	A0lm9vdeCHzNvyLT43cfSlJe7oRoA77WR
X-Google-Smtp-Source: AGHT+IF76jpUiIP7pzkY3rbkQUwFUyMIUPmrzRfNA8ckO32G87TYgdb5XfGyDdZS4fx5e5l9KxOlzMzt9OUMFdwG+KU=
X-Received: by 2002:a05:6e02:152e:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3a6b445dd34mr120660375ab.10.1730799734678; Tue, 05 Nov 2024
 01:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <20241105074916.75107-1-kuniyu@amazon.com> <CAL+tcoAgSBMtFcDx6MfCAhYMVKERCx2d7YUjquT6Pa8jm0bXWA@mail.gmail.com>
 <CANn89iKhSnTJUadpEBpkKYoRVP2GEJZ1ftzH7AqF4oXMF3QEZA@mail.gmail.com>
In-Reply-To: <CANn89iKhSnTJUadpEBpkKYoRVP2GEJZ1ftzH7AqF4oXMF3QEZA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 Nov 2024 17:41:38 +0800
Message-ID: <CAL+tcoCBvbR_=c_SxKmAyAE4U5wTgr=hp08yNxm0QUSWdgge5Q@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, dsahern@kernel.org, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:35=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Nov 5, 2024 at 10:08=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Tue, Nov 5, 2024 at 3:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Tue,  5 Nov 2024 10:55:11 +0800
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > We found there are rare chances that some RST packets appear during
> > > > the shakehands because the timewait socket cannot accept the SYN an=
d
> > >
> > > s/shakehands/handshake/
> > >
> > > same in the subject.
> > >
> > > > doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > > >
> > > > Here is how things happen in production:
> > > > Time        Client(A)        Server(B)
> > > > 0s          SYN-->
> > > > ...
> > > > 132s                         <-- FIN
> > > > ...
> > > > 169s        FIN-->
> > > > 169s                         <-- ACK
> > > > 169s        SYN-->
> > > > 169s                         <-- ACK
> > > > 169s        RST-->
> > > > As above picture shows, the two flows have a start time difference
> > > > of 169 seconds. B starts to send FIN so it will finally enter into
> > > > TIMEWAIT state. Nearly at the same time A launches a new connection
> > > > that soon is reset by itself due to receiving a ACK.
> > > >
> > > > There are two key checks in tcp_timewait_state_process() when timew=
ait
> > > > socket in B receives the SYN packet:
> > > > 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > > > 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> > > >
> > > > Regarding the first rule, it fails as expected because in the first
> > > > connection the seq of SYN sent from A is 1892994276, then 169s have
> > > > passed, the second SYN has 239034613 (caused by overflow of s32).
> > > >
> > > > Then how about the second rule?
> > > > It fails again!
> > > > Let's take a look at how the tsval comes out:
> > > > __tcp_transmit_skb()
> > > >     -> tcp_syn_options()
> > > >         -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts, sk=
b) + tp->tsoffset;
> > > > The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> > > > other is tp->tsoffset. The latter value is fixed, so we don't need
> > > > to care about it. If both operations (sending FIN and then starting
> > > > sending SYN) from A happen in 1ms, then the tsval would be the same=
.
> > > > It can be clearly seen in the tcpdump log. Notice that the tsval is
> > > > with millisecond precision.
> > > >
> > > > Based on the above analysis, I decided to make a small change to
> > > > the check in tcp_timewait_state_process() so that the second flow
> > > > would not fail.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/ipv4/tcp_minisocks.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > > index bb1fe1ba867a..2b29d1bf5ca0 100644
> > > > --- a/net/ipv4/tcp_minisocks.c
> > > > +++ b/net/ipv4/tcp_minisocks.c
> > > > @@ -234,7 +234,7 @@ tcp_timewait_state_process(struct inet_timewait=
_sock *tw, struct sk_buff *skb,
> > > >       if (th->syn && !th->rst && !th->ack && !paws_reject &&
> > > >           (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
> > > >            (tmp_opt.saw_tstamp &&
> > > > -           (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsva=
l) < 0))) {
> > >
> > > I think this follows RFC 6191 and such a change requires a formal
> > > discussion at IETF.
> > >
> > > https://datatracker.ietf.org/doc/html/rfc6191#section-2
> > >
> > > ---8<---
> > >       *  If TCP Timestamps would be enabled for the new incarnation o=
f
> > >          the connection, and the timestamp contained in the incoming =
SYN
> > >          segment is greater than the last timestamp seen on the previ=
ous
> >
> > The true thing is that the timestamp of the SYN packet is greater than
> > that of the last packet, but the kernel implementation uses ms
> > precision (please see tcp_skb_timestamp_ts()). That function makes
> > those two timestamps the same.
> >
> > This case happens as expected, so the second connection should be
> > established. My confusion just popped out of my mind: what rules
> > should we follow to stop the second flow?
>
> Note that linux TCP stack can use usec resolution for TCP TS values.
>
> You might adopt it, and no longer care about this ms granularity.

Right, I noticed this feature. I wonder if we can change the check in
tcp_timewait_state_process() like this patch if it has no side
effects? I'm worried that some programs don't use this feature. It's
the reason why I try to propose this patch to you.

Thanks,
Jason

