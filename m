Return-Path: <netdev+bounces-121972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B244595F6F1
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C75B1F21819
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA174194C61;
	Mon, 26 Aug 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6x+x2NP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB7194AF4
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690505; cv=none; b=T13PyuEklFR85a/YIok5LVrMbD5d8bbs9lccDTgv8JeP//srQIw8kOjalin8VdZFo7ZT1WyU+gZJoeTw+5ZtqRL8kR/6Ao9psNUBZrp1fX2BzP6noMsoHBF2Pxa+TzGZLGbiQfX3LAdIcXLE2cREzLCamWM//zb45D0fiiAp2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690505; c=relaxed/simple;
	bh=nTeXu/Xhfy1vLvEGQy3QJlVAESU6F1W/zuQ1Awr1Iu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXhM+BxzNbNtWMT8ZxBksr+ySXCMkGscX9PBqAO7k6og/Ia/suNQdTENiqphEezHQ3z/HgMdtz004RgkWrula02o6sc+jyyXQxGilGO2N2s9z4Bu+1KzkrJFoozRvGeka3UGAX0g4UIQ71CCbPi4HO0UFxv9COpIFkA4QGr2KqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6x+x2NP; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d2ceca81cso16583365ab.3
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690503; x=1725295303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG/yK9Brsuhoox6hd+5+wu5ikppMkIviRc8Ct1nbUO8=;
        b=K6x+x2NPYMbgfar5L5CTvNBSWMHhH9GKfi4zkPYOK2tpXMR5MWDiuF3CzubTQe6z79
         sjeeyvIQXGyy9C7NwPYd84OTceqhPE0dCO7Wbne3pY9ycNXFk/5ZEmvEpMDe61CygRY/
         wH8S24a1+UL3ccvvkbWCKdjZDS/JXFnR3MUxuG76uG8xrE8nhEsg2NZwMuXXU7m5UhIF
         zYNGNV6EFJY9eux6nsNoZc+8d1C5vPeSZ/fzIa/GiY2NSGakCACEAjCsvIfG6ehrZ5SN
         mSDwS+28Wxg/zLCgteG1a48DroAj8Lb/shYgiZEQ9ZEazlSi6hE8V12HxLT+zKKYTIyI
         UrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690503; x=1725295303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nG/yK9Brsuhoox6hd+5+wu5ikppMkIviRc8Ct1nbUO8=;
        b=HLPHFwXuypEU2rz9kMXjRPhunkZUWVzlTRmBehf8mMLcq8Jrs/ZMMcn0zM+gxp/Gfo
         9884sXqjURdmf7qE8UUpblB03pJSBnkirx0Ztl2MYOJ4EvpejP51vZUSC532mybsavJr
         2ZPp8oxhPgsCdiOs4jUQhZi/yWrVa+RKOSmDGuPxCr0Lq1+mFBE7uV4HdtGubswJsiit
         wVrBHu3N+FKUXMqxgBcVudzTd0+etg1hCwuk2oJC9CWRHUg2EcmaJe3xmniZ+cVNdqaH
         ncUY30uFV8mf8N4kDApnLFYCNq0RsvZsq9gveS5ssMjFUFd3ut0wUzXnlXfS2LygnDMZ
         U+VA==
X-Forwarded-Encrypted: i=1; AJvYcCVmahyIDWON1PCFM3gUOElXefQsasYjHl+Hy6X1ncMyqSPylZHRB2qRMzkBFCXifxG5RAkPYbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVubh91BKOOAhnLO9bWuGXTihB3qsZJp3gsE+6JyGi6HIK80T
	s4WPLIQnTQGmWMU+RIWzsUEEsSw0cqhEmzb01LUGnkAcKIDOvW5Atc3t/+uOvkH9sbeGVKdj24i
	gUyUXmUJsgZ3KCk7UNBhD2aHX5FE=
X-Google-Smtp-Source: AGHT+IHDRiEGY7V1U46gP5iegMUdglZeDAx0L55lEACgntHnmxkLCgyYqnUyu9Wxqn1OZFzmyROByVR5QZfH7mXE/lE=
X-Received: by 2002:a05:6e02:12ee:b0:39d:3c85:9b0 with SMTP id
 e9e14a558f8ab-39e3c98c707mr117453255ab.15.1724690502966; Mon, 26 Aug 2024
 09:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com> <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
 <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com> <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
In-Reply-To: <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Aug 2024 00:41:06 +0800
Message-ID: <CAL+tcoCbCWGMEUD7nZ0e89mxPS-DjKCRGa3XwOWRHq_1PPeQUw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:03=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Hello Willem,
> >
> > On Mon, Aug 26, 2024 at 9:24=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Normally, if we want to record and print the rx timestamp after
> > > > tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_SOFTWARE
> > > > and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also can noti=
ce
> > > > through running rxtimestamp binary in selftests (see testcase 7).
> > > >
> > > > However, there is one particular case that fails the selftests with
> > > > "./rxtimestamp: Expected swtstamp to not be set." error printing in
> > > > testcase 6.
> > > >
> > > > How does it happen? When we keep running a thread starting a socket
> > > > and set SOF_TIMESTAMPING_RX_HARDWARE option first, then running
> > > > ./rxtimestamp, it will fail. The reason is the former thread
> > > > switching on netstamp_needed_key that makes the feature global,
> > > > every skb going through netif_receive_skb_list_internal() function
> > > > will get a current timestamp in net_timestamp_check(). So the skb
> > > > will have timestamp regardless of whether its socket option has
> > > > SOF_TIMESTAMPING_RX_SOFTWARE or not.
> > > >
> > > > After this patch, we can pass the selftest and control each socket
> > > > as we want when using rx timestamp feature.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/ipv4/tcp.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 8514257f4ecd..49e73d66c57d 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, c=
onst struct sock *sk,
> > > >                       struct scm_timestamping_internal *tss)
> > > >  {
> > > >       int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> > > > +     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > >       bool has_timestamping =3D false;
> > > >
> > > >       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> > > > @@ -2274,14 +2275,19 @@ void tcp_recv_timestamp(struct msghdr *msg,=
 const struct sock *sk,
> > > >                       }
> > > >               }
> > > >
> > > > -             if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFT=
WARE)
> > > > +             /* skb may contain timestamp because another socket
> > > > +              * turned on netstamp_needed_key which allows generat=
e
> > > > +              * the timestamp. So we need to check the current soc=
ket.
> > > > +              */
> > > > +             if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > > +                 tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
> > > >                       has_timestamping =3D true;
> > > >               else
> > > >                       tss->ts[0] =3D (struct timespec64) {0};
> > > >       }
> > >
> > > The current behavior is as described in
> > > Documentation/networking/timestamping.rst:
> > >
> > > "The socket option configures timestamp generation for individual
> > > sk_buffs (1.3.1), timestamp reporting to the socket's error
> > > queue (1.3.2)"
> > >
> > > SOF_TIMESTAMPING_RX_SOFTWARE is a timestamp generation option.
> > > SOF_TIMESTAMPING_SOFTWARE is a timestamp reporting option.
> >
> > Thanks for your review.
> >
> > Yes, it's true.
> >
> > >
> > > This patch changes that clearly defined behavior.
> >
> > Why?
>
> Because it repurposes generation flag SOF_TIMESTAMPING_RX_SOFTWARE in
> timestamp reporting.
>
> If a single flag configures both generation and reporting, why bother
> with two flags at all.

Thanks for your full and detailed explanation :)

I probably understand what you're saying. You think we should strictly
distinguish these two concepts "generation" and "reporting".

In my opinion, they are just concepts. We can make it clear by writing
some sentences in the Documentation.

>
> > I don't get it. Please see those testcase in
> > tools/testing/selftests/net/rxtimestamp.c.
> >
> > >
> > > On Tx the separation between generation and reporting has value, as i=
t
> > > allows setting the generation on a per packet basis with SCM_TSTAMP_*=
.
> >
> > I didn't break the logic on the tx path. tcp_recv_timestamp() is only
> > related to the rx path.
> >
> > Regarding the tx path, I carefully take care of this logic in
> > patch[2/2], so now the series only handles the issue happening in the
> > rx path.
> >
> > >
> > > On Rx it is more subtle, but the two are still tested at different
> > > points in the path, and can be updated by setsockopt in between a
> > > packet arrival and a recvmsg().
> > >
> > > The interaction between sockets on software timestamping is a
> > > longstanding issue. I don't think there is any urgency to change this
> >
> > Oh, now I see.
> >
> > > now. This proposed change makes the API less consistent, and may
> > > also affect applications that depend on the current behavior.
> > >
> >
> > Maybe. But, it's not the original design which we expect, right?
>
> It is. Your argument is against the current API design. This is not
> a bug where behavior diverges from the intended interface. The doc is
> clear on this.
>
> The API makes a distinction between generation and reporting bits. The
> shared generation early in the Rx path is a long standing known issue.
>
> I'm not saying that the API is perfect. But it is clear in its use of
> the bits. Muddling the distinction between reporting and generation
> bits in one of the four cases makes the API less consistent and harder
> to understand.
>
> If you think the API as is is wrong, then at a minimum that would
> require an update to timestamping.rst. But I think that medicine may
> be worse than the ailment.

At least, I think it is against the use of setsockopt, that's the key
reason: making people confused and thinking the setsockopt is not a
per-socket fine-grained design. Don't you think it's a little bit
strange?

Besides those two concepts you mentioned, could you explain if there
are side effects that the series has and what kind of bad consequences
that the series could bring?

I tried to make it more logical and also don't want to break the
existing use behaviour of applications.

I believe that what I wrote doesn't have an impact on other cases and
perfects what should be perfected. No offense. If the series does no
harm and we keep it in the right direction, are there other reasons
stopping it getting approved, I wonder.

Thanks,
Jason

>
> > I can make sure this series can fix the issue. This series is trying
> > to ask users to use/set both flags to receive an expected timestamp.
> > The purpose of using setsockopt is to control the socket itself
> > insteading of interfering with others.
> >
> > About the breakage issue, let me assume, if the user only sets the
> > SOF_TIMESTAMPING_SOFTWARE flag, he cannot expect the socket will
> > receive a timestamp, right? So what might happen if we fix the issue?
> > I think the logics in the rxtimestamp.c selftest are very clear :)
> >
> > Besides, test case 6 will fail under this circumstance
>
> Sorry about that. My team added that test, and we expanded it over
> time. Crucially, the test was added well after the SO_TIMESTAMPING
> API, so it was never intended to be prescriptive.
>
> Commit 0558c3960407 ("selftests/net: plug rxtimestamp test into
> kselftest framework") actually mentions this issue:
>
>     Also ignore failures of test case #6 by default. This case verifies
>     that a receive timestamp is not reported if timestamp reporting is
>     enabled for a socket, but generation is disabled. Receive timestamp
>     generation has to be enabled globally, as no associated socket is
>     known yet. A background process that enables rx timestamp generation
>     therefore causes a false positive. Ntpd is one example that does.
>
>     Add a "--strict" option to cause failure in the event that any test
>     case fails, including test #6. This is useful for environments that
>     are known to not have such background processes.

