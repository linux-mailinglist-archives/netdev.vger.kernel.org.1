Return-Path: <netdev+bounces-121907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360FC95F326
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71001F2590C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37221862B9;
	Mon, 26 Aug 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGeqF47X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39053139D
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679672; cv=none; b=V//ga2A8CRLhR/Scs5kjh3qgo4b+8XzHZZu7dssp8qO/08rnzZ+2ICohAwgtK2V9lC4/MV65e3Eurb0spfjilA8TnMq+Fgj3nklyJKMv0346c+oyidrouWUcDKr9wXr2jxWbH/YZ4bS6MhDujosTL3uQDaHN206syHCo1LOzY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679672; c=relaxed/simple;
	bh=Cpyfv7VUbOU93ueHV9tf4U76Ou561Alp9RzNgNiaM98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUq/cjcgV5H58J2S+gKtb3JuAATSe9aBJxm8HsTFFSmE7aP+s26yl8wJzx9MRKGszfsTRHlyTsTb6itPQgrJKm/Dlx1RPVRmiarwy/n7U9ouiIcUyqnHca6BsVuyCB30DPDsffWOivtyIpczJC+jg0oyPBcYNyH0A58fNzwDPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGeqF47X; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d37218c5cso14704465ab.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724679670; x=1725284470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiEeLYwXBIi31Mb8p+jGA/neq3F8LiEqk22jeOGVsgU=;
        b=PGeqF47X/qxxsyahiPlNBE3o8yM5nv05tqLMs19nKei7KOxatsN9jxf35T7SV2g+N4
         OfrznSMye76incWzPb4gaopV05H1wA9kM4eEiYgnKrvuQzfosx0hCl4StgDxIG/RUfi/
         nfygCsvNxb4S1R8t0qVGWEGOfKl8iz5bjfydAsofEWCodTe71yTjmRSKutUciQsJTMIr
         pHW2hmi/RCLXcOz/dbmaPBBfJKusr0HRNf2bcTPXC8BGv+rOR3QC80cC2rDlZxrivcBu
         9/G7xuR6ExE/PiOjDty0Pn4H/h6aUTmWS2Od+MzvtV2u++ZUiWLaJ6s3W+gSolQ7IpSy
         rg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724679670; x=1725284470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiEeLYwXBIi31Mb8p+jGA/neq3F8LiEqk22jeOGVsgU=;
        b=LgkW6++nSh1/OZDGyl48w4PPvXLfENottphcNsnEzlZpvxwZGTrviXV0eBM/G4MT7M
         3sKqz2gcMYLntp7r7VnHey1/djPa8VkskmbcOrVe41j7W5rx3DRo+4VvalxTXR7UVam8
         1OxB2jSV72IBE0Kn03uCWreb+nY8e9Gl1N7qRhZWFCe99ucwrSZRhrfnam8uk5/n4JqZ
         Sq2i7d4eg9b0prTklKVE4orFpBtkAs7mp+P6v1Wf3eZu/henhygzNKIFKe35zASpOWAK
         Gt8ubLfCQ3hNa0Zt7RDsJJMQbxl10va+9AemfD/P8CY43z3UhvlbX4Ofm17P5cA/l0gW
         m5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2qwF5+9kyZsMUooYFUeEj0kZGfk4JwiugLAKMcg/EQGGRq+d/cuBcqu6U5AiYyJBwWLFVVsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLehPrWVQ0jkZsFWkLXV4hzPDNjEcsXRRut7EvHg3j9RALnYk
	hYnSTZnOJaUnuirRynx3LgpLEuAxEhVONE5ZaBZOtMIenwdULkeirm3C+lIdndQsIovQidCpDNC
	13OqVZVfpvnMfJfJ9HuFbuNgUgeE=
X-Google-Smtp-Source: AGHT+IH5FYVxvJJ1b4g9ahiCAQXhE7T7H0eEXCHFBFXwwI2ZBY8fPbrwZYX6A7VUqCpz+L3oluS9Cbobc9A7beYwCHo=
X-Received: by 2002:a05:6e02:1c48:b0:39d:2124:d6d5 with SMTP id
 e9e14a558f8ab-39e3c9851a7mr119314655ab.10.1724679670161; Mon, 26 Aug 2024
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com> <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 26 Aug 2024 21:40:34 +0800
Message-ID: <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Willem,

On Mon, Aug 26, 2024 at 9:24=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Normally, if we want to record and print the rx timestamp after
> > tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_SOFTWARE
> > and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also can notice
> > through running rxtimestamp binary in selftests (see testcase 7).
> >
> > However, there is one particular case that fails the selftests with
> > "./rxtimestamp: Expected swtstamp to not be set." error printing in
> > testcase 6.
> >
> > How does it happen? When we keep running a thread starting a socket
> > and set SOF_TIMESTAMPING_RX_HARDWARE option first, then running
> > ./rxtimestamp, it will fail. The reason is the former thread
> > switching on netstamp_needed_key that makes the feature global,
> > every skb going through netif_receive_skb_list_internal() function
> > will get a current timestamp in net_timestamp_check(). So the skb
> > will have timestamp regardless of whether its socket option has
> > SOF_TIMESTAMPING_RX_SOFTWARE or not.
> >
> > After this patch, we can pass the selftest and control each socket
> > as we want when using rx timestamp feature.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 8514257f4ecd..49e73d66c57d 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const=
 struct sock *sk,
> >                       struct scm_timestamping_internal *tss)
> >  {
> >       int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> > +     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> >       bool has_timestamping =3D false;
> >
> >       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> > @@ -2274,14 +2275,19 @@ void tcp_recv_timestamp(struct msghdr *msg, con=
st struct sock *sk,
> >                       }
> >               }
> >
> > -             if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE=
)
> > +             /* skb may contain timestamp because another socket
> > +              * turned on netstamp_needed_key which allows generate
> > +              * the timestamp. So we need to check the current socket.
> > +              */
> > +             if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > +                 tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
> >                       has_timestamping =3D true;
> >               else
> >                       tss->ts[0] =3D (struct timespec64) {0};
> >       }
>
> The current behavior is as described in
> Documentation/networking/timestamping.rst:
>
> "The socket option configures timestamp generation for individual
> sk_buffs (1.3.1), timestamp reporting to the socket's error
> queue (1.3.2)"
>
> SOF_TIMESTAMPING_RX_SOFTWARE is a timestamp generation option.
> SOF_TIMESTAMPING_SOFTWARE is a timestamp reporting option.

Thanks for your review.

Yes, it's true.

>
> This patch changes that clearly defined behavior.

Why? I don't get it. Please see those testcase in
tools/testing/selftests/net/rxtimestamp.c.

>
> On Tx the separation between generation and reporting has value, as it
> allows setting the generation on a per packet basis with SCM_TSTAMP_*.

I didn't break the logic on the tx path. tcp_recv_timestamp() is only
related to the rx path.

Regarding the tx path, I carefully take care of this logic in
patch[2/2], so now the series only handles the issue happening in the
rx path.

>
> On Rx it is more subtle, but the two are still tested at different
> points in the path, and can be updated by setsockopt in between a
> packet arrival and a recvmsg().
>
> The interaction between sockets on software timestamping is a
> longstanding issue. I don't think there is any urgency to change this

Oh, now I see.

> now. This proposed change makes the API less consistent, and may
> also affect applications that depend on the current behavior.
>

Maybe. But, it's not the original design which we expect, right?

I can make sure this series can fix the issue. This series is trying
to ask users to use/set both flags to receive an expected timestamp.
The purpose of using setsockopt is to control the socket itself
insteading of interfering with others.

About the breakage issue, let me assume, if the user only sets the
SOF_TIMESTAMPING_SOFTWARE flag, he cannot expect the socket will
receive a timestamp, right? So what might happen if we fix the issue?
I think the logics in the rxtimestamp.c selftest are very clear :)

Besides, test case 6 will fail under this circumstance.

Thanks,
Jason

