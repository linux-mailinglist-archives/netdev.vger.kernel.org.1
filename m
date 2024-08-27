Return-Path: <netdev+bounces-122327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE7E960BC0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E3B1C22F68
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD41C0DE2;
	Tue, 27 Aug 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd8xu4UZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC61BFE18
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764833; cv=none; b=m2u4/A3f6CXXYC2wQfJEl8RU2/Aiqug6Yl9ahgEgEuCEa3lXA23ZmGWhfBlAE0RovhU614V/AfTYuHgYus63FJGyv34H7OfmB3NhWh2h2tipDbBJFG/xMIzSKDkN87NAVPIzkHBpbbuIq36eZB6df/s2lUF+r0pHBX1bBbiNJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764833; c=relaxed/simple;
	bh=kPhGUUswZ7nnDIww9X7UQF9HuRp06rPRxfDzz5jPvhk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bBV6cNDOrwjSrj+YRXFg7Det1V93e4SbgYLxqRw25RsItFukQ8GOUyeF5uIuYt9qlgvx1sMMoZFsplYi12UELxy9DYr5TJwnxQUB9bCwbXjueQlEO6CmVuKedH/7aYpEiZZMZErH3I/FxaqwItUxpgjfYk84HqW5CbC4U+hrRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd8xu4UZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7ba05f75so46238336d6.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724764830; x=1725369630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYq1m+Feb9YLuVFcpqk/0e3cnLNfgwzvxphxiGsAZDM=;
        b=Yd8xu4UZ4bf4hIYMZlctC5+SGQ9m7luHCaXPOT0vvQLrM3EqQ0QNlMheYvkVxYV2jF
         7G7eAu/BXUUcmcUvMiKXQD4LP/cSjm4ay0hO+q5Za9fLQaKAHG0osL4bTpWjG8QjMOh3
         OLmoMU4gRNd5hWLtC7ApoW4E1/vgM0SY/62mjgIFttv/rb0qvVCDfjQdD+2txzZWLogB
         HJGGXsgIe6mqaDj4B7mBDS+hhYdpJAYqi8CHy4c/8Ny6GLq5/DI8pDpkxeewQ5H3dQx6
         U0Ps2ckIgn8XxVLexx3rOs0N/2ZFJRBniHIaq45mtaKVRNugn2Ec2HMX65NMJAc3/ZRp
         s10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764830; x=1725369630;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zYq1m+Feb9YLuVFcpqk/0e3cnLNfgwzvxphxiGsAZDM=;
        b=kfnSRaU4X1nc7Cant/UvS0PdJloI5xGWwX6N4/DOeqjEdQbFdeZW657J5v6AOc3EAH
         8FvVVeObwENpPAJWTifq5OPe4T1G50InXqpu1E2+8TK7E6dsWdLq+M5zDgRQUhC4ZlHW
         YOvBZRelxBg1cLTNM3/FBQ4SdfZfN9Z+xxu5ANGlFqTFKTXYqShDPKFuRRteeM9DQu38
         PmfnwiyA4eDIQkCq8OKtSrRBFWamryv2lZe715nIUJf2AGYrHoI63qdWwbpSUuVX1bjd
         V3CAFanjEtSfT2FR1hXfSvi7pJi9rvRD8bXYnitG1bTiaAmrc7THZLEggDITNIscSR8p
         /dIg==
X-Forwarded-Encrypted: i=1; AJvYcCUOSkaUHZ4E2T8kBCXGU8KCB9UeC1KqlYPzauAkh8uzw99m7v3b8tqV+6u9ps8BujohfEvG7Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YoJfDLHkfn0FzWCx+0iZEpJacVXxLRnwxTNwKAmDXFncwL81
	iLbkMhGx3Dyd1OaEfGYv7nldF9sH7cZsjhJyeQtvh8yonJh7VD+ec2eo8A==
X-Google-Smtp-Source: AGHT+IEDwwea1rJ6ZqmMDZiaHIzf4ZNZh0KbdCPLl2EUOjFLsdjKMs1QrrzJgVjvSdx/bE7+7hrI8g==
X-Received: by 2002:a05:6214:3991:b0:6bf:8f3c:2e6c with SMTP id 6a1803df08f44-6c32b1007e0mr42053486d6.27.1724764830047;
        Tue, 27 Aug 2024 06:20:30 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4fc76sm55944136d6.48.2024.08.27.06.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:20:29 -0700 (PDT)
Date: Tue, 27 Aug 2024 09:20:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66cdd29d21fc3_2986412942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDrQ4e7G2605ZdigchmgQ4YexK+co9G=AvW4Dug84k-bA@mail.gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com>
 <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
 <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
 <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
 <CAL+tcoCbCWGMEUD7nZ0e89mxPS-DjKCRGa3XwOWRHq_1PPeQUw@mail.gmail.com>
 <66ccccbf9eccb_26d83529486@willemb.c.googlers.com.notmuch>
 <CAL+tcoDrQ4e7G2605ZdigchmgQ4YexK+co9G=AvW4Dug84k-bA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Tue, Aug 27, 2024 at 2:43=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Tue, Aug 27, 2024 at 12:03=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > Hello Willem,
> > > > >
> > > > > On Mon, Aug 26, 2024 at 9:24=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > Normally, if we want to record and print the rx timestamp a=
fter
> > > > > > > tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_=
SOFTWARE
> > > > > > > and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also =
can notice
> > > > > > > through running rxtimestamp binary in selftests (see testca=
se 7).
> > > > > > >
> > > > > > > However, there is one particular case that fails the selfte=
sts with
> > > > > > > "./rxtimestamp: Expected swtstamp to not be set." error pri=
nting in
> > > > > > > testcase 6.
> > > > > > >
> > > > > > > How does it happen? When we keep running a thread starting =
a socket
> > > > > > > and set SOF_TIMESTAMPING_RX_HARDWARE option first, then run=
ning
> > > > > > > ./rxtimestamp, it will fail. The reason is the former threa=
d
> > > > > > > switching on netstamp_needed_key that makes the feature glo=
bal,
> > > > > > > every skb going through netif_receive_skb_list_internal() f=
unction
> > > > > > > will get a current timestamp in net_timestamp_check(). So t=
he skb
> > > > > > > will have timestamp regardless of whether its socket option=
 has
> > > > > > > SOF_TIMESTAMPING_RX_SOFTWARE or not.
> > > > > > >
> > > > > > > After this patch, we can pass the selftest and control each=
 socket
> > > > > > > as we want when using rx timestamp feature.
> > > > > > >
> > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > ---
> > > > > > >  net/ipv4/tcp.c | 10 ++++++++--
> > > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > > > index 8514257f4ecd..49e73d66c57d 100644
> > > > > > > --- a/net/ipv4/tcp.c
> > > > > > > +++ b/net/ipv4/tcp.c
> > > > > > > @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr=
 *msg, const struct sock *sk,
> > > > > > >                       struct scm_timestamping_internal *tss=
)
> > > > > > >  {
> > > > > > >       int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> > > > > > > +     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > > > >       bool has_timestamping =3D false;
> > > > > > >
> > > > > > >       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> > > > > > > @@ -2274,14 +2275,19 @@ void tcp_recv_timestamp(struct msgh=
dr *msg, const struct sock *sk,
> > > > > > >                       }
> > > > > > >               }
> > > > > > >
> > > > > > > -             if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMP=
ING_SOFTWARE)
> > > > > > > +             /* skb may contain timestamp because another =
socket
> > > > > > > +              * turned on netstamp_needed_key which allows=
 generate
> > > > > > > +              * the timestamp. So we need to check the cur=
rent socket.
> > > > > > > +              */
> > > > > > > +             if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > > > > > +                 tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
> > > > > > >                       has_timestamping =3D true;
> > > > > > >               else
> > > > > > >                       tss->ts[0] =3D (struct timespec64) {0=
};
> > > > > > >       }
> > > > > >
> > > > > > The current behavior is as described in
> > > > > > Documentation/networking/timestamping.rst:
> > > > > >
> > > > > > "The socket option configures timestamp generation for indivi=
dual
> > > > > > sk_buffs (1.3.1), timestamp reporting to the socket's error
> > > > > > queue (1.3.2)"
> > > > > >
> > > > > > SOF_TIMESTAMPING_RX_SOFTWARE is a timestamp generation option=
.
> > > > > > SOF_TIMESTAMPING_SOFTWARE is a timestamp reporting option.
> > > > >
> > > > > Thanks for your review.
> > > > >
> > > > > Yes, it's true.
> > > > >
> > > > > >
> > > > > > This patch changes that clearly defined behavior.
> > > > >
> > > > > Why?
> > > >
> > > > Because it repurposes generation flag SOF_TIMESTAMPING_RX_SOFTWAR=
E in
> > > > timestamp reporting.
> > > >
> > > > If a single flag configures both generation and reporting, why bo=
ther
> > > > with two flags at all.
> > >
> > > Thanks for your full and detailed explanation :)
> > >
> > > I probably understand what you're saying. You think we should stric=
tly
> > > distinguish these two concepts "generation" and "reporting".
> > >
> > > In my opinion, they are just concepts. We can make it clear by writ=
ing
> > > some sentences in the Documentation.
> > >
> > > >
> > > > > I don't get it. Please see those testcase in
> > > > > tools/testing/selftests/net/rxtimestamp.c.
> > > > >
> > > > > >
> > > > > > On Tx the separation between generation and reporting has val=
ue, as it
> > > > > > allows setting the generation on a per packet basis with SCM_=
TSTAMP_*.
> > > > >
> > > > > I didn't break the logic on the tx path. tcp_recv_timestamp() i=
s only
> > > > > related to the rx path.
> > > > >
> > > > > Regarding the tx path, I carefully take care of this logic in
> > > > > patch[2/2], so now the series only handles the issue happening =
in the
> > > > > rx path.
> > > > >
> > > > > >
> > > > > > On Rx it is more subtle, but the two are still tested at diff=
erent
> > > > > > points in the path, and can be updated by setsockopt in betwe=
en a
> > > > > > packet arrival and a recvmsg().
> > > > > >
> > > > > > The interaction between sockets on software timestamping is a=

> > > > > > longstanding issue. I don't think there is any urgency to cha=
nge this
> > > > >
> > > > > Oh, now I see.
> > > > >
> > > > > > now. This proposed change makes the API less consistent, and =
may
> > > > > > also affect applications that depend on the current behavior.=

> > > > > >
> > > > >
> > > > > Maybe. But, it's not the original design which we expect, right=
?
> > > >
> > > > It is. Your argument is against the current API design. This is n=
ot
> > > > a bug where behavior diverges from the intended interface. The do=
c is
> > > > clear on this.
> > > >
> > > > The API makes a distinction between generation and reporting bits=
. The
> > > > shared generation early in the Rx path is a long standing known i=
ssue.
> > > >
> > > > I'm not saying that the API is perfect. But it is clear in its us=
e of
> > > > the bits. Muddling the distinction between reporting and generati=
on
> > > > bits in one of the four cases makes the API less consistent and h=
arder
> > > > to understand.
> > > >
> > > > If you think the API as is is wrong, then at a minimum that would=

> > > > require an update to timestamping.rst. But I think that medicine =
may
> > > > be worse than the ailment.
> > >
> > > At least, I think it is against the use of setsockopt, that's the k=
ey
> > > reason: making people confused and thinking the setsockopt is not a=

> > > per-socket fine-grained design. Don't you think it's a little bit
> > > strange?
> >
> > That is moot. This design was made many years ago and is now expected=
.
> >
> > I also don't see it as a huge issue.
> =

> Sure, it's not a big problem.
> =

> >
> > The effect you point out in rxtimestamp.c was known and reported in
> > the test commit itself.
> >
> > Perhaps a more interesting argument would be
> > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE. But
> > spurious software rx timestamps are trivially ignored.
> >
> > > Besides those two concepts you mentioned, could you explain if ther=
e
> > > are side effects that the series has and what kind of bad consequen=
ces
> > > that the series could bring?
> >
> > It doesn't do the same for hardware timestamping, creating
> > inconsistency.

Taking a closer look at the code, there are actually already two weird
special cases here.

SOF_TIMESTAMPING_RX_HARDWARE never has to be passed, as rx hardware
timestamp generation is configured through SIOCSHWTSTAMP.

SOF_TIMESTAMPING_RX_SOFTWARE already enables timestamp reporting from
sock_recv_timestamp(), while reporting should not be conditional on
this generation flag.

        /*
         * generate control messages if
         * - receive time stamping in software requested
         * - software time stamp available and wanted
         * - hardware time stamps available and wanted
         */
        if (sock_flag(sk, SOCK_RCVTSTAMP) ||
            (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
            (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
            (hwtstamps->hwtstamp &&
             (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
                __sock_recv_timestamp(msg, sk, skb);

I evidently already noticed this back in 2014, when I left a note in
commit b9f40e21ef42 ("net-timestamp: move timestamp flags out of
sk_flags"):

    SOCK_TIMESTAMPING_RX_SOFTWARE is also used to toggle the receive
    timestamp logic (netstamp_needed). That can be simplified and this
    last key removed, but will leave that for a separate patch.

But I do not see __sock_recv_timestamp toggling the feature either
then or now, so I think this is vestigial and can be removed.

> >
> > Changing established interfaces always risks production issues. In
> > this case, I'm not convinced that the benefit outweighs this risk.
> =

> I got it.
> =

> I'm thinking that I'm not the first one and the last one who know/find
> this long standing "issue", could we at least documentented it
> somewhere, like adding comments in the selftests or Documentation, to
> avoid the similar confusion in the future? Or change the behaviour in
> the rxtimestamp.c test? What do you think about it? Adding
> documentation or comments is the simplest way:)

I can see the value of your extra filter. Given the above examples, it
won't be the first subtle variance from the API design, either.

So either way is fine with me: change it or leave it.

But in both ways, yes: please update the documentation accordingly.

And if you do choose to change it, please be ready to revert on report
of breakage. Applications that only pass SOF_TIMESTAMPING_SOFTWARE,
because that always worked as they subtly relied on another daemon to
enable SOF_TIMESTAMPING_RX_SOFTWARE, for instance.

> Thanks,
> Jason
> =

> >
> > > I tried to make it more logical and also don't want to break the
> > > existing use behaviour of applications.
> > >
> > > I believe that what I wrote doesn't have an impact on other cases a=
nd
> > > perfects what should be perfected. No offense. If the series does n=
o
> > > harm and we keep it in the right direction, are there other reasons=

> > > stopping it getting approved, I wonder.
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > > I can make sure this series can fix the issue. This series is t=
rying
> > > > > to ask users to use/set both flags to receive an expected times=
tamp.
> > > > > The purpose of using setsockopt is to control the socket itself=

> > > > > insteading of interfering with others.
> > > > >
> > > > > About the breakage issue, let me assume, if the user only sets =
the
> > > > > SOF_TIMESTAMPING_SOFTWARE flag, he cannot expect the socket wil=
l
> > > > > receive a timestamp, right? So what might happen if we fix the =
issue?
> > > > > I think the logics in the rxtimestamp.c selftest are very clear=
 :)
> > > > >
> > > > > Besides, test case 6 will fail under this circumstance
> > > >
> > > > Sorry about that. My team added that test, and we expanded it ove=
r
> > > > time. Crucially, the test was added well after the SO_TIMESTAMPIN=
G
> > > > API, so it was never intended to be prescriptive.
> > > >
> > > > Commit 0558c3960407 ("selftests/net: plug rxtimestamp test into
> > > > kselftest framework") actually mentions this issue:
> > > >
> > > >     Also ignore failures of test case #6 by default. This case ve=
rifies
> > > >     that a receive timestamp is not reported if timestamp reporti=
ng is
> > > >     enabled for a socket, but generation is disabled. Receive tim=
estamp
> > > >     generation has to be enabled globally, as no associated socke=
t is
> > > >     known yet. A background process that enables rx timestamp gen=
eration
> > > >     therefore causes a false positive. Ntpd is one example that d=
oes.
> > > >
> > > >     Add a "--strict" option to cause failure in the event that an=
y test
> > > >     case fails, including test #6. This is useful for environment=
s that
> > > >     are known to not have such background processes.
> >
> >



