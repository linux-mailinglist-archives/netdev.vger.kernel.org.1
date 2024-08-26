Return-Path: <netdev+bounces-122011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EE895F919
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AF2B21DA5
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388321925B7;
	Mon, 26 Aug 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVw5zMXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382D19342A
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697796; cv=none; b=pFtzI38ntH92HJb9L7C4DmlU5OWB+4asjHGyQWZ8HZu5OzSFqrXQQXq2p5NKssf8Ij7vzHmeTSTbLmIaLZNAra+fo/AfTjC+eafgIsXcOnPwDzZ46w2+vDBGUT3qAyOZS+HKAQlWZWqVZtW8VzXS9KlvMDORXWtTzmo3rBfZR6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697796; c=relaxed/simple;
	bh=Z6RiqEd1xSY3rHc5YTglEE7jxryDj2ae6ZMcbVcGNGQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z20wRoAV9bG/fqiTwc1Pv/IReto93d6uvg683ELRgjDx+t9x33Bmz7ImHO+DGI5JoBRedLV+BDfXFCV0Ho6jj5QeePVO/fQHtq9bVQxp4CpAxnHS+FSw6v38ftob8E4dKvRRlLHBlZ/h+NgG0jW0o2pjD5zCdQjnu2yUFHpJ2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVw5zMXI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a3574acafeso304322885a.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724697793; x=1725302593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULwNmerzpM24eKUTH078qMvlfUIqC1LoIwiamLDqGc4=;
        b=lVw5zMXIEXUI8yN+ozDBwKcalCN/osHJZe0Xs5l3XApZkeKs67cevhuNwuHYt2DXMq
         R8roNKF5gpcEuPOalYRoR4KQzT55KRxiPkLMcGly2umv7IoKGte9pXCwE2xQ9S55TZkV
         C5R+Lr2e09pWMYbpkVxZMusNyCqsUlqFssRMQZlWHKcZGbPon7o/nXYEOj4xfgkiN7E9
         0OR5KwSJccPOSMYxflZzAYTdWO3d/FYpC2cfBrf3l+s4s1OcZYf3FXQxsd5nE60OsH2r
         Uhh7N5u1NCgASZbk9X0PunfYM7BwjORH2cCLthfLhMw/1GSEXpoPy8O32rsBPk/qWWnU
         QMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724697793; x=1725302593;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULwNmerzpM24eKUTH078qMvlfUIqC1LoIwiamLDqGc4=;
        b=ZjGLrU0IpieLTFV6owbLxS95lw+BryGus1A0mKO40ZxQ3VD1I0iA+itd2FQ3Th+prC
         nVJf+vodvZfThbSIqKZ3v/uvdq2+TaQZhyk3xDgGrL07i7Lrpy3rX6bTjgtrmRmERsqN
         oH+TkxvjRPYU8y3VjWHUqbpmXzdDtCrzJIerKohhDDMKqxS5E4iczKOTgdKeurxMjxHf
         248LSOadYrTIYz1uDuU7F589kUp6lwrHuANfre/WI2vmbuExfSGLFm0dX9UZVqYGnwNa
         4SmKKdq628qpJxATzt04mJNQnmTRBHRt4mgeWz2uecOT+7JfkCk36+WODqHih4kPqlc4
         tt7g==
X-Forwarded-Encrypted: i=1; AJvYcCUiuUdoTqfmoBVOCaSAo+kxv1jFsJt4Ivzf1Bc2gct00PN+hk+oyRk6QODRTpbiLaudhAmk4zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTU9kGqh4iG45bZCJ9Jx3sdGfh4MJgcFAvOhsI/7DnsmoukXKB
	mQ2TNgfn2GlPf2m+arlzRwmiL5jH7+IWv/ZHnpQNB7hOsUn0PzbJ
X-Google-Smtp-Source: AGHT+IGezRmavaYAHJFCWvrnr3vJm5S+r+LK11/Pl6DC4HERup8+fQKY5qya1tTrmmDLmPyDxRkojw==
X-Received: by 2002:a05:620a:1a23:b0:7a3:505f:6300 with SMTP id af79cd13be357-7a7e4dc6f76mr60642885a.16.1724697792578;
        Mon, 26 Aug 2024 11:43:12 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f40759fsm482287585a.123.2024.08.26.11.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 11:43:12 -0700 (PDT)
Date: Mon, 26 Aug 2024 14:43:11 -0400
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
Message-ID: <66ccccbf9eccb_26d83529486@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCbCWGMEUD7nZ0e89mxPS-DjKCRGa3XwOWRHq_1PPeQUw@mail.gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com>
 <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
 <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
 <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
 <CAL+tcoCbCWGMEUD7nZ0e89mxPS-DjKCRGa3XwOWRHq_1PPeQUw@mail.gmail.com>
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
> On Tue, Aug 27, 2024 at 12:03=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > Hello Willem,
> > >
> > > On Mon, Aug 26, 2024 at 9:24=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Normally, if we want to record and print the rx timestamp after=

> > > > > tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_SOFT=
WARE
> > > > > and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also can =
notice
> > > > > through running rxtimestamp binary in selftests (see testcase 7=
).
> > > > >
> > > > > However, there is one particular case that fails the selftests =
with
> > > > > "./rxtimestamp: Expected swtstamp to not be set." error printin=
g in
> > > > > testcase 6.
> > > > >
> > > > > How does it happen? When we keep running a thread starting a so=
cket
> > > > > and set SOF_TIMESTAMPING_RX_HARDWARE option first, then running=

> > > > > ./rxtimestamp, it will fail. The reason is the former thread
> > > > > switching on netstamp_needed_key that makes the feature global,=

> > > > > every skb going through netif_receive_skb_list_internal() funct=
ion
> > > > > will get a current timestamp in net_timestamp_check(). So the s=
kb
> > > > > will have timestamp regardless of whether its socket option has=

> > > > > SOF_TIMESTAMPING_RX_SOFTWARE or not.
> > > > >
> > > > > After this patch, we can pass the selftest and control each soc=
ket
> > > > > as we want when using rx timestamp feature.
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/ipv4/tcp.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > index 8514257f4ecd..49e73d66c57d 100644
> > > > > --- a/net/ipv4/tcp.c
> > > > > +++ b/net/ipv4/tcp.c
> > > > > @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *ms=
g, const struct sock *sk,
> > > > >                       struct scm_timestamping_internal *tss)
> > > > >  {
> > > > >       int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> > > > > +     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > >       bool has_timestamping =3D false;
> > > > >
> > > > >       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> > > > > @@ -2274,14 +2275,19 @@ void tcp_recv_timestamp(struct msghdr *=
msg, const struct sock *sk,
> > > > >                       }
> > > > >               }
> > > > >
> > > > > -             if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_=
SOFTWARE)
> > > > > +             /* skb may contain timestamp because another sock=
et
> > > > > +              * turned on netstamp_needed_key which allows gen=
erate
> > > > > +              * the timestamp. So we need to check the current=
 socket.
> > > > > +              */
> > > > > +             if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > > > +                 tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
> > > > >                       has_timestamping =3D true;
> > > > >               else
> > > > >                       tss->ts[0] =3D (struct timespec64) {0};
> > > > >       }
> > > >
> > > > The current behavior is as described in
> > > > Documentation/networking/timestamping.rst:
> > > >
> > > > "The socket option configures timestamp generation for individual=

> > > > sk_buffs (1.3.1), timestamp reporting to the socket's error
> > > > queue (1.3.2)"
> > > >
> > > > SOF_TIMESTAMPING_RX_SOFTWARE is a timestamp generation option.
> > > > SOF_TIMESTAMPING_SOFTWARE is a timestamp reporting option.
> > >
> > > Thanks for your review.
> > >
> > > Yes, it's true.
> > >
> > > >
> > > > This patch changes that clearly defined behavior.
> > >
> > > Why?
> >
> > Because it repurposes generation flag SOF_TIMESTAMPING_RX_SOFTWARE in=

> > timestamp reporting.
> >
> > If a single flag configures both generation and reporting, why bother=

> > with two flags at all.
> =

> Thanks for your full and detailed explanation :)
> =

> I probably understand what you're saying. You think we should strictly
> distinguish these two concepts "generation" and "reporting".
> =

> In my opinion, they are just concepts. We can make it clear by writing
> some sentences in the Documentation.
> =

> >
> > > I don't get it. Please see those testcase in
> > > tools/testing/selftests/net/rxtimestamp.c.
> > >
> > > >
> > > > On Tx the separation between generation and reporting has value, =
as it
> > > > allows setting the generation on a per packet basis with SCM_TSTA=
MP_*.
> > >
> > > I didn't break the logic on the tx path. tcp_recv_timestamp() is on=
ly
> > > related to the rx path.
> > >
> > > Regarding the tx path, I carefully take care of this logic in
> > > patch[2/2], so now the series only handles the issue happening in t=
he
> > > rx path.
> > >
> > > >
> > > > On Rx it is more subtle, but the two are still tested at differen=
t
> > > > points in the path, and can be updated by setsockopt in between a=

> > > > packet arrival and a recvmsg().
> > > >
> > > > The interaction between sockets on software timestamping is a
> > > > longstanding issue. I don't think there is any urgency to change =
this
> > >
> > > Oh, now I see.
> > >
> > > > now. This proposed change makes the API less consistent, and may
> > > > also affect applications that depend on the current behavior.
> > > >
> > >
> > > Maybe. But, it's not the original design which we expect, right?
> >
> > It is. Your argument is against the current API design. This is not
> > a bug where behavior diverges from the intended interface. The doc is=

> > clear on this.
> >
> > The API makes a distinction between generation and reporting bits. Th=
e
> > shared generation early in the Rx path is a long standing known issue=
.
> >
> > I'm not saying that the API is perfect. But it is clear in its use of=

> > the bits. Muddling the distinction between reporting and generation
> > bits in one of the four cases makes the API less consistent and harde=
r
> > to understand.
> >
> > If you think the API as is is wrong, then at a minimum that would
> > require an update to timestamping.rst. But I think that medicine may
> > be worse than the ailment.
> =

> At least, I think it is against the use of setsockopt, that's the key
> reason: making people confused and thinking the setsockopt is not a
> per-socket fine-grained design. Don't you think it's a little bit
> strange?

That is moot. This design was made many years ago and is now expected.

I also don't see it as a huge issue.

The effect you point out in rxtimestamp.c was known and reported in
the test commit itself.

Perhaps a more interesting argument would be
SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE. But
spurious software rx timestamps are trivially ignored.

> Besides those two concepts you mentioned, could you explain if there
> are side effects that the series has and what kind of bad consequences
> that the series could bring?

It doesn't do the same for hardware timestamping, creating
inconsistency.

Changing established interfaces always risks production issues. In
this case, I'm not convinced that the benefit outweighs this risk.

> I tried to make it more logical and also don't want to break the
> existing use behaviour of applications.
> =

> I believe that what I wrote doesn't have an impact on other cases and
> perfects what should be perfected. No offense. If the series does no
> harm and we keep it in the right direction, are there other reasons
> stopping it getting approved, I wonder.
> =

> Thanks,
> Jason
> =

> >
> > > I can make sure this series can fix the issue. This series is tryin=
g
> > > to ask users to use/set both flags to receive an expected timestamp=
.
> > > The purpose of using setsockopt is to control the socket itself
> > > insteading of interfering with others.
> > >
> > > About the breakage issue, let me assume, if the user only sets the
> > > SOF_TIMESTAMPING_SOFTWARE flag, he cannot expect the socket will
> > > receive a timestamp, right? So what might happen if we fix the issu=
e?
> > > I think the logics in the rxtimestamp.c selftest are very clear :)
> > >
> > > Besides, test case 6 will fail under this circumstance
> >
> > Sorry about that. My team added that test, and we expanded it over
> > time. Crucially, the test was added well after the SO_TIMESTAMPING
> > API, so it was never intended to be prescriptive.
> >
> > Commit 0558c3960407 ("selftests/net: plug rxtimestamp test into
> > kselftest framework") actually mentions this issue:
> >
> >     Also ignore failures of test case #6 by default. This case verifi=
es
> >     that a receive timestamp is not reported if timestamp reporting i=
s
> >     enabled for a socket, but generation is disabled. Receive timesta=
mp
> >     generation has to be enabled globally, as no associated socket is=

> >     known yet. A background process that enables rx timestamp generat=
ion
> >     therefore causes a false positive. Ntpd is one example that does.=

> >
> >     Add a "--strict" option to cause failure in the event that any te=
st
> >     case fails, including test #6. This is useful for environments th=
at
> >     are known to not have such background processes.



