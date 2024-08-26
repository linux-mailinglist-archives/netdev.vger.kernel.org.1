Return-Path: <netdev+bounces-121954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D619995F5FE
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFF1281586
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93713212B;
	Mon, 26 Aug 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DniKQ5eq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1148F47
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688234; cv=none; b=SrTz0zrilTcfmstEPDbh3/sotk7/2clfySARCt0KF2HbIVDHzeolLIjRwtEgIeiF1WwRyE48cE5fKkZxoOD5oIP+RxdpFPy9a5bWRZVmnuB69fSNB34sZFH/Yuuse0RsleMwHN2HZeKgsYopC/fkbvZK43331SvKQS51gcUR9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688234; c=relaxed/simple;
	bh=2HKg3jFL/6x8dzcNym/DMknh2Ztq0nkpCOjSrrBC84k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VqGHTlZmWVoyC4QM5+bKkfYHIMWqTeOEcqVPMzBK4r4/StYB6fZlyrxCuAW1XcJy8Sk8eTbMj7Gab5f4u3nk/5d7+EFnXIQgEuL5xQCnIM2xq9eFWtF3W7QbMl7lpkzIj0iMcNmQnWNcOMC7vS4pLG/k+n+JpFn9E5Pb5SY+5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DniKQ5eq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44fee8813c3so26683811cf.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724688232; x=1725293032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz4Ggvmj0jAeJsuBluXteOhu1473//u5Gpii8yZyPjY=;
        b=DniKQ5eqM9U40riKS10urR51nMXaut7xhEYTYZy7OQbTilI5aPiV+fEWjBJR1Hi1Nw
         bcT854dShvrTqjE/jUw0Do0lTA9gCJHMJkXooWGSTA7B9XRWwxY9x77f8y4QGdmnr56Z
         aNOwxm2+P+CEhdwB0xN3z7hXajJ9sBX3F2HFywH+6wRF8hwnEV4Hnd/PzRvrB30jMUO+
         fUnmRoONzWOwQFm/XpNlrOt+/rUyBo4V+CzC3yEEPEmsROO+WSGEnery9u7RTZ/yUv5y
         rwNhbN2uIo3ZBKVUgZLtoowYBIDPnHNiT0h2yRDCWwyHHCQ4kcNq2jKx2sgqa9a24eU+
         61JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724688232; x=1725293032;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nz4Ggvmj0jAeJsuBluXteOhu1473//u5Gpii8yZyPjY=;
        b=QKId89T1G3Xd2fgKdaLMz+geUE6W9c44JAIsirEp9FzDglr8m/1v9h0sZkGdFuZheL
         MxNIXi/fXb+HEIoDG6+wpXAZraAa7rqpheuuAugj1oTRblNaKd423AutFfG+zWskFGnd
         qtDB9xe1f1MtXx7SFB0HADoR6fnR5F73Ia9DaWMHbR36X+jL7oZ7rOn3f9heqCXUVsKs
         VXuvCUf3R/eOMdSjREZh0P1EGetlJZuLkzaOJ17EzlvLJSbO5A/jM9LrohzYiB4LCevN
         /e7+yLdIUG/rJpobfeIzYDQ48meWdEOFOZx6Pb2KS4JoU0dWQ9+N2PZBvyAWMEB6RpAa
         UjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHEig8Z7drTEFllRbLsP69tSU5iCiPKQmKh1zPsZjiVm8N+aTYfesEyaXrOPWz4GqqXUypqBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl03OMyd/LCQXJxfwKp7I5Y9FkGGmNuSCNFmh2+ixsTXke/HgY
	vT6F55vjxvEvLTYFYqDYyGZfuUsp2PCYFbkt5M2uXShNiEccOQ/A7tt12w==
X-Google-Smtp-Source: AGHT+IGtCsLGkgNJMG9BfY6WnDij8CJhz+F9ORKmifAW65S/s/f4bokX872ahe7TI8U4TSTvGMH8lw==
X-Received: by 2002:a05:622a:4015:b0:453:5d39:d124 with SMTP id d75a77b69052e-4550963291fmr147741051cf.18.1724688231365;
        Mon, 26 Aug 2024 09:03:51 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1c9bedsm44000791cf.95.2024.08.26.09.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:03:50 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:03:50 -0400
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
Message-ID: <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com>
 <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
 <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
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
> Hello Willem,
> =

> On Mon, Aug 26, 2024 at 9:24=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Normally, if we want to record and print the rx timestamp after
> > > tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_SOFTWARE=

> > > and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also can noti=
ce
> > > through running rxtimestamp binary in selftests (see testcase 7).
> > >
> > > However, there is one particular case that fails the selftests with=

> > > "./rxtimestamp: Expected swtstamp to not be set." error printing in=

> > > testcase 6.
> > >
> > > How does it happen? When we keep running a thread starting a socket=

> > > and set SOF_TIMESTAMPING_RX_HARDWARE option first, then running
> > > ./rxtimestamp, it will fail. The reason is the former thread
> > > switching on netstamp_needed_key that makes the feature global,
> > > every skb going through netif_receive_skb_list_internal() function
> > > will get a current timestamp in net_timestamp_check(). So the skb
> > > will have timestamp regardless of whether its socket option has
> > > SOF_TIMESTAMPING_RX_SOFTWARE or not.
> > >
> > > After this patch, we can pass the selftest and control each socket
> > > as we want when using rx timestamp feature.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/ipv4/tcp.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 8514257f4ecd..49e73d66c57d 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, c=
onst struct sock *sk,
> > >                       struct scm_timestamping_internal *tss)
> > >  {
> > >       int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> > > +     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > >       bool has_timestamping =3D false;
> > >
> > >       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> > > @@ -2274,14 +2275,19 @@ void tcp_recv_timestamp(struct msghdr *msg,=
 const struct sock *sk,
> > >                       }
> > >               }
> > >
> > > -             if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFT=
WARE)
> > > +             /* skb may contain timestamp because another socket
> > > +              * turned on netstamp_needed_key which allows generat=
e
> > > +              * the timestamp. So we need to check the current soc=
ket.
> > > +              */
> > > +             if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > +                 tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
> > >                       has_timestamping =3D true;
> > >               else
> > >                       tss->ts[0] =3D (struct timespec64) {0};
> > >       }
> >
> > The current behavior is as described in
> > Documentation/networking/timestamping.rst:
> >
> > "The socket option configures timestamp generation for individual
> > sk_buffs (1.3.1), timestamp reporting to the socket's error
> > queue (1.3.2)"
> >
> > SOF_TIMESTAMPING_RX_SOFTWARE is a timestamp generation option.
> > SOF_TIMESTAMPING_SOFTWARE is a timestamp reporting option.
> =

> Thanks for your review.
> =

> Yes, it's true.
> =

> >
> > This patch changes that clearly defined behavior.
> =

> Why?

Because it repurposes generation flag SOF_TIMESTAMPING_RX_SOFTWARE in
timestamp reporting.

If a single flag configures both generation and reporting, why bother
with two flags at all.

> I don't get it. Please see those testcase in
> tools/testing/selftests/net/rxtimestamp.c.
> =

> >
> > On Tx the separation between generation and reporting has value, as i=
t
> > allows setting the generation on a per packet basis with SCM_TSTAMP_*=
.
> =

> I didn't break the logic on the tx path. tcp_recv_timestamp() is only
> related to the rx path.
> =

> Regarding the tx path, I carefully take care of this logic in
> patch[2/2], so now the series only handles the issue happening in the
> rx path.
> =

> >
> > On Rx it is more subtle, but the two are still tested at different
> > points in the path, and can be updated by setsockopt in between a
> > packet arrival and a recvmsg().
> >
> > The interaction between sockets on software timestamping is a
> > longstanding issue. I don't think there is any urgency to change this=

> =

> Oh, now I see.
> =

> > now. This proposed change makes the API less consistent, and may
> > also affect applications that depend on the current behavior.
> >
> =

> Maybe. But, it's not the original design which we expect, right?

It is. Your argument is against the current API design. This is not
a bug where behavior diverges from the intended interface. The doc is
clear on this.

The API makes a distinction between generation and reporting bits. The
shared generation early in the Rx path is a long standing known issue.

I'm not saying that the API is perfect. But it is clear in its use of
the bits. Muddling the distinction between reporting and generation
bits in one of the four cases makes the API less consistent and harder
to understand.

If you think the API as is is wrong, then at a minimum that would
require an update to timestamping.rst. But I think that medicine may
be worse than the ailment.

> I can make sure this series can fix the issue. This series is trying
> to ask users to use/set both flags to receive an expected timestamp.
> The purpose of using setsockopt is to control the socket itself
> insteading of interfering with others.
> =

> About the breakage issue, let me assume, if the user only sets the
> SOF_TIMESTAMPING_SOFTWARE flag, he cannot expect the socket will
> receive a timestamp, right? So what might happen if we fix the issue?
> I think the logics in the rxtimestamp.c selftest are very clear :)
> =

> Besides, test case 6 will fail under this circumstance

Sorry about that. My team added that test, and we expanded it over
time. Crucially, the test was added well after the SO_TIMESTAMPING
API, so it was never intended to be prescriptive.

Commit 0558c3960407 ("selftests/net: plug rxtimestamp test into
kselftest framework") actually mentions this issue:

    Also ignore failures of test case #6 by default. This case verifies
    that a receive timestamp is not reported if timestamp reporting is
    enabled for a socket, but generation is disabled. Receive timestamp
    generation has to be enabled globally, as no associated socket is
    known yet. A background process that enables rx timestamp generation
    therefore causes a false positive. Ntpd is one example that does.

    Add a "--strict" option to cause failure in the event that any test
    case fails, including test #6. This is useful for environments that
    are known to not have such background processes.

