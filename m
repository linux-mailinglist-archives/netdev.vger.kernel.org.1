Return-Path: <netdev+bounces-122409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187F961253
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4DF280BE2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D20A1C93B6;
	Tue, 27 Aug 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAZUdgOY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15211C942C
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772464; cv=none; b=cofjBCyBm7j7C6XRLgwY/JJrYXGBToFo4U/04pxomjlHEh1MbkhSDA3Z6WxIZmh8pUfW/HreEMY31KarUDS94HeLmxfhySwJjataC1HOcjvZK2HCtpY3GRacsG9IMk1X3jYVgBBTR/7zV7K3SdqYhz8nVUGXV4Vw2Z3xcwq7oDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772464; c=relaxed/simple;
	bh=Ykqtali5cI5c8Xx+4X6Rirphdy6ymJ2kgAGM8UU0GYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/QlWOU6n/lSE2XlgriqRRxOjleeTcewdaoEpEmL3ets1Zd2pTCuYZfs7z/L1hZicrDrjCnhIg1MbwDmbqMfep6moStW/z8+2tUcOwHiOY65Xj0QmEPk6QUZGSK1ltZP1USw7R44YJ+I9p50sxQXY8q7HKZPPsVNtb8f7mGzgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAZUdgOY; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39e6a32ae1aso961465ab.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724772462; x=1725377262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UirOiEI+Dp2u55Vnw4iicsKn+PTKMlShBq9QvVZz2Yk=;
        b=EAZUdgOYvL+d7TWCknJch+lIQ7KXutulsoOVtNrK/PoU4O42khHonfmlpYdRQAPcsm
         tqGMprHYgL64/qQK5OdhXJZUoPixvxUejPkM0fWy5yBKo4tfUYM73WrkOe6qWwhcqEE4
         F/FpyL6gKuH53/sXZjxyiJTFMfOaZC5OYjlRspb/6B4+NtJgawRnsn1IM+sqRe/vg/8V
         12X2tDf96O3w0y8fF7fCwWiSyJdvhgjicOkalTEnavyNmqqjLmDAO2s8xSLIEka8IYcS
         t/IsoZXr+eQtHCzEu9ggFFoenFa3EmAjWSS6O2tDvNg2Ph4R01IlCYh0dINU6zHcVdrx
         Aytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772462; x=1725377262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UirOiEI+Dp2u55Vnw4iicsKn+PTKMlShBq9QvVZz2Yk=;
        b=Lbff5qvvwgfcLPSEQlTZQcz11MBoMkAdtK9YmSTyGo6DLhvpjwzum2djM7O//Q5l8J
         oDuphLL2zvL+VxOhTuTbYiv8IMs/tS/LqYW5kfs3cT7XtbLiFSOmwvhMeXwJsU3JkWOe
         3y8wC9QofXYKKTCemQicxANdv+Hd9wlBxMV3NmGsD9xxOhvzvTVDZ1pOYxGHGy9tSCoE
         JL36eJm4It9Ycho1AL9gjCFVVgjUlEIrcIZtyMHO2PibGVI0JOkEMzJD52Mu5p0JhyKT
         N/TxltUBM+1fUrMVXd1KQNRi3Av12HPAOLBEnSV8DKDbMx0O7ibstM7A7kkVGRYd/Szd
         vivA==
X-Forwarded-Encrypted: i=1; AJvYcCVPzfeQT1SgQNGxy++pjetUkNoKu3fvvEytP+gae7yMjau52nJaZtTt6me005VCuGtJVKVEzZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvpOQyPGmAT9zVZlw62EAKsUaW0xESnKx1oqOAJ5QBNwflN8gQ
	cNUeGA/YIcxUwMkZCs89DBEB7imSbjaP006wGhA2LUqLHQOnCawsSXRWbe/yNKrWy9Or90HqfZn
	QwFdbYZh/e9t6aWPqS219sNeC2CM=
X-Google-Smtp-Source: AGHT+IGo9aOu1FaJaT1Ov5qN5vBp57pQBnD1MsIi4fwrZGA6/NiiLEgpuMzBahRiCCMI4W7qgTD1ONpHzRmUFLHYTDU=
X-Received: by 2002:a05:6e02:1b08:b0:39b:17c1:fc66 with SMTP id
 e9e14a558f8ab-39e63ef8f9fmr38332625ab.22.1724772461747; Tue, 27 Aug 2024
 08:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com> <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
 <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
 <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
 <CAL+tcoCbCWGMEUD7nZ0e89mxPS-DjKCRGa3XwOWRHq_1PPeQUw@mail.gmail.com>
 <66ccccbf9eccb_26d83529486@willemb.c.googlers.com.notmuch>
 <CAL+tcoDrQ4e7G2605ZdigchmgQ4YexK+co9G=AvW4Dug84k-bA@mail.gmail.com> <66cdd29d21fc3_2986412942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <66cdd29d21fc3_2986412942f@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Aug 2024 23:27:05 +0800
Message-ID: <CAL+tcoCZhakNunSGT4Y0RfaBi-UXbxDDcEU0n-OG9FXNb56Bcg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Willem,

On Tue, Aug 27, 2024 at 9:20=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Aug 27, 2024 at 2:43=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Tue, Aug 27, 2024 at 12:03=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > Hello Willem,
> > > > > >
> > > > > > On Mon, Aug 26, 2024 at 9:24=E2=80=AFPM Willem de Bruijn
> > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > Jason Xing wrote:
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > Normally, if we want to record and print the rx timestamp a=
fter
> > > > > > > > tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_=
SOFTWARE
> > > > > > > > and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also =
can notice
> > > > > > > > through running rxtimestamp binary in selftests (see testca=
se 7).
> > > > > > > >
> > > > > > > > However, there is one particular case that fails the selfte=
sts with
> > > > > > > > "./rxtimestamp: Expected swtstamp to not be set." error pri=
nting in
> > > > > > > > testcase 6.
> > > > > > > >
> > > > > > > > How does it happen? When we keep running a thread starting =
a socket
> > > > > > > > and set SOF_TIMESTAMPING_RX_HARDWARE option first, then run=
ning

Sorry, I found one mistake I made, it should be "and set
SOF_TIMESTAMPING_RX_SOFTWARE".

> > > > > > > > ./rxtimestamp, it will fail. The reason is the former threa=
d
> > > > > > > > switching on netstamp_needed_key that makes the feature glo=
bal,
> > > > > > > > every skb going through netif_receive_skb_list_internal() f=
unction
> > > > > > > > will get a current timestamp in net_timestamp_check(). So t=
he skb
> > > > > > > > will have timestamp regardless of whether its socket option=
 has
> > > > > > > > SOF_TIMESTAMPING_RX_SOFTWARE or not.
> > > > > > > >
> > > > > > > > After this patch, we can pass the selftest and control each=
 socket
> > > > > > > > as we want when using rx timestamp feature.
> > > > > > > >
> > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > ---
> > > > > > > >  net/ipv4/tcp.c | 10 ++++++++--
> > > > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > > > > index 8514257f4ecd..49e73d66c57d 100644
> > > > > > > > --- a/net/ipv4/tcp.c
> > > > > > > > +++ b/net/ipv4/tcp.c
> > > > > > > > @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr=
 *msg, const struct sock *sk,
> > > > > > > >                       struct scm_timestamping_internal *tss=
)
> > > > > > > >  {
> > > > > > > >       int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> > > > > > > > +     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > > > > >       bool has_timestamping =3D false;
> > > > > > > >
> > > > > > > >       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> > > > > > > > @@ -2274,14 +2275,19 @@ void tcp_recv_timestamp(struct msgh=
dr *msg, const struct sock *sk,
> > > > > > > >                       }
> > > > > > > >               }
> > > > > > > >
> > > > > > > > -             if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMP=
ING_SOFTWARE)
> > > > > > > > +             /* skb may contain timestamp because another =
socket
> > > > > > > > +              * turned on netstamp_needed_key which allows=
 generate
> > > > > > > > +              * the timestamp. So we need to check the cur=
rent socket.
> > > > > > > > +              */
> > > > > > > > +             if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > > > > > > +                 tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
> > > > > > > >                       has_timestamping =3D true;
> > > > > > > >               else
> > > > > > > >                       tss->ts[0] =3D (struct timespec64) {0=
};
> > > > > > > >       }
[...]
> > >
> > > > Besides those two concepts you mentioned, could you explain if ther=
e
> > > > are side effects that the series has and what kind of bad consequen=
ces
> > > > that the series could bring?
> > >
> > > It doesn't do the same for hardware timestamping, creating
> > > inconsistency.
>
> Taking a closer look at the code, there are actually already two weird
> special cases here.
>
> SOF_TIMESTAMPING_RX_HARDWARE never has to be passed, as rx hardware
> timestamp generation is configured through SIOCSHWTSTAMP.

Do you refer to the patch [1/2] I wrote? To be more specific, is it
about the above wrong commit message which I just modified?

Things could happen when other unrelated threads set
SOF_TIMESTAMPING_RX_SOFTWARE instead of SOF_TIMESTAMPING_RX_HARDWARE.

Sorry for the confusion.

>
> SOF_TIMESTAMPING_RX_SOFTWARE already enables timestamp reporting from
> sock_recv_timestamp(), while reporting should not be conditional on
> this generation flag.

I'm not sure if you're talking about patch [2/2] in the series. But I guess=
 so.

I can see what you mean here: you don't like combining the reporting
flag and generation flag, right? But If we don't check whether those
two flags (SOF_TIMESTAMPING_RX_SOFTWARE __and__
SOF_TIMESTAMPING_SOFTWARE) in sock_recv_timestamp(), some tests in the
protocols like udp will fail as we talked before.

netstamp_needed_key cannot be implemented as per socket feature (at
that time when the driver just pass the skb to the rx stack, we don't
know which socket the skb belongs to). Since we cannot prevent this
from happening during its generation period, I suppose we can delay
the check and try to stop it when it has to report, I mean, in
sock_recv_timestamp().

Or am I missing something? What would you suggest?

>
>         /*
>          * generate control messages if
>          * - receive time stamping in software requested
>          * - software time stamp available and wanted
>          * - hardware time stamps available and wanted
>          */
>         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
>             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
>             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
>             (hwtstamps->hwtstamp &&
>              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
>                 __sock_recv_timestamp(msg, sk, skb);
>
> I evidently already noticed this back in 2014, when I left a note in
> commit b9f40e21ef42 ("net-timestamp: move timestamp flags out of
> sk_flags"):
>
>     SOCK_TIMESTAMPING_RX_SOFTWARE is also used to toggle the receive
>     timestamp logic (netstamp_needed). That can be simplified and this
>     last key removed, but will leave that for a separate patch.
>
> But I do not see __sock_recv_timestamp toggling the feature either
> then or now, so I think this is vestigial and can be removed.

I'm not so sure about the unix case, I can see this call trace:
unix_dgram_recvmsg()->__unix_dgram_recvmsg()->__sock_recv_timestamp().

The reason why I added the check in in __sock_recv_timestamp () in the
patch [2/2] is considering the above call trace.

One thing I can be sure of is that removing the modification in
__sock_recv_timestamp in that patch doesn't affect the selftests.

Please correct me if I'm wrong.

>
> > >
> > > Changing established interfaces always risks production issues. In
> > > this case, I'm not convinced that the benefit outweighs this risk.
> >
> > I got it.
> >
> > I'm thinking that I'm not the first one and the last one who know/find
> > this long standing "issue", could we at least documentented it
> > somewhere, like adding comments in the selftests or Documentation, to
> > avoid the similar confusion in the future? Or change the behaviour in
> > the rxtimestamp.c test? What do you think about it? Adding
> > documentation or comments is the simplest way:)
>
> I can see the value of your extra filter. Given the above examples, it
> won't be the first subtle variance from the API design, either.

Really appreciate that you understand me :)

>
> So either way is fine with me: change it or leave it.
>
> But in both ways, yes: please update the documentation accordingly.

Roger that, sir. I will do it.

>
> And if you do choose to change it, please be ready to revert on report
> of breakage. Applications that only pass SOF_TIMESTAMPING_SOFTWARE,
> because that always worked as they subtly relied on another daemon to
> enable SOF_TIMESTAMPING_RX_SOFTWARE, for instance.

Yes, I still chose to change it and try to make it in the correct
direction. So if there are future reports, please let me know, I will
surely keep a close eye on it.

Thanks,
Jason

