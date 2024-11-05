Return-Path: <netdev+bounces-141873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD39BC95E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD0D284F00
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7C71C9B81;
	Tue,  5 Nov 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKwS9yEI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7118132A
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799359; cv=none; b=q4VjGpsV2lA6G8oFX4CQVb0+hssZ+EujvGnHrTjgkw5aIHEJzpm1bvJ7VJqAVxTO2ZgZMAYi6sfV/FscQGcMR2Q2HfazYahHKZO5EEo2wu5Vo5i9e4OtK6ye4q70DeKpGbt50VtTSeZ+Ac+nipBn5YqMDxIiV0KX3HzXEAoeUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799359; c=relaxed/simple;
	bh=tbQ8e+LJhtkBO+9YK905UdN64gFIvP3xPnxXr6WGhl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVHU01H11dbUXJoStbM9HLjfsY7Ipkxtx2pwhEdKwJY9vuBM9jlJqosunt4kTvdISg8CxqD8K2Q1jpzk6zeHw81D4ze+IdAR4oJ6qp1w8vxG9Anb2FrJXOJGosX43hXlM6/FhgrxWGe54mEhqHkEc80vlcIxKDJCAArI0HR+YW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKwS9yEI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so664550566b.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730799356; x=1731404156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/ZYeSjAdTOfVnR8IYq8OB5GB/55Seqk85tFKOQM57c=;
        b=KKwS9yEIYclMh0lKZdmmCBjhMkuNNF1Nt7ZFNfgdA6qmPujwbVsfGFU8q6FEvx0LoI
         Q4fQ1Hby1kvKmvnFU91Aj61n/MaXzOhoF0x07dou3AZTJ+4daMa5xIAphcwqGv255zUS
         f4Mk/oDVrIXYdeDyVqPwNBbRjfwHDqyoegJ6/f7Z9NODrciGH2pUUchJYwB4K4JmhVy2
         GEEGwH7ZIISC1ry1mOHUd8V2R+L0Dx+RB74AwShK9flHOm6wi+32prnOXG02whKtao7m
         +87M5iuKzElRiI9OvPG86QuE3CgXBmBeL8Q/u/nra6CqDMb6fC82V6PIiDxhDixIrXNl
         yYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799356; x=1731404156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/ZYeSjAdTOfVnR8IYq8OB5GB/55Seqk85tFKOQM57c=;
        b=c4VeBS65c0XUvCdZWIov0O3RGmhXFUQsP+E9iA2t9wbIJKitcHQHk8DGxRb08ADo0d
         CBrZV4HSG6Etwn1Q9OFICTdX+gM6gqi4SssGRw+ANqAjzFUL6Ku8e+pgzkKNlCIMYEGX
         KhIy6OqPo4jbw8wCCQk191f1v3f5t6FaKomMNdDc2aLAE97rNG3yGt0rnQwh8jNd+IYI
         WIxN88s+/1nUyWDR4TI/U01WVgxoOTCk0Z5MMv2tLpIuUuHdX+JFlD00TClKYJomVB3V
         hzB+OydnY7TSKwRAJsNjMN2tfYkEDCgdD+t4LIAbd/IzK0/Zk/Eo3jk/L5QBIWqb2WrM
         X7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVc0AfCwUa+5+M9UCw4hYdiwpDBqnbgD5KjRMuMvu6ZphslcE5IX/1ouXUpxSY2g7ByawaJxeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/ypP3DLb+Iw2U/ciffxJoQ8/oTAV4SnM52HU5yXawqCsFS4m
	u/ispaTuDbIMr5trBl7vZ83esx9uEse75ctE630h60hGQ6x4m6pCWbDrmDCrHcYaiF0BfQ6hky3
	/JBzuLoMxFK5edojtAMZVc/ISbEfSEG3XyqlJ
X-Google-Smtp-Source: AGHT+IERmmP+85e5BT7fn4LYgOH++YsiaeYB0wX3nud7ma3CFQjMVEvcZ/He9RSgssAuy9uo3yr3V4Ft/v4rce+edbk=
X-Received: by 2002:a17:907:7e8b:b0:a9a:3cec:b322 with SMTP id
 a640c23a62f3a-a9e3a6c99e0mr2079740066b.45.1730799355759; Tue, 05 Nov 2024
 01:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <20241105074916.75107-1-kuniyu@amazon.com> <CAL+tcoAgSBMtFcDx6MfCAhYMVKERCx2d7YUjquT6Pa8jm0bXWA@mail.gmail.com>
In-Reply-To: <CAL+tcoAgSBMtFcDx6MfCAhYMVKERCx2d7YUjquT6Pa8jm0bXWA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 10:35:44 +0100
Message-ID: <CANn89iKhSnTJUadpEBpkKYoRVP2GEJZ1ftzH7AqF4oXMF3QEZA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, dsahern@kernel.org, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 10:08=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Nov 5, 2024 at 3:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
> >
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Date: Tue,  5 Nov 2024 10:55:11 +0800
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > We found there are rare chances that some RST packets appear during
> > > the shakehands because the timewait socket cannot accept the SYN and
> >
> > s/shakehands/handshake/
> >
> > same in the subject.
> >
> > > doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > >
> > > Here is how things happen in production:
> > > Time        Client(A)        Server(B)
> > > 0s          SYN-->
> > > ...
> > > 132s                         <-- FIN
> > > ...
> > > 169s        FIN-->
> > > 169s                         <-- ACK
> > > 169s        SYN-->
> > > 169s                         <-- ACK
> > > 169s        RST-->
> > > As above picture shows, the two flows have a start time difference
> > > of 169 seconds. B starts to send FIN so it will finally enter into
> > > TIMEWAIT state. Nearly at the same time A launches a new connection
> > > that soon is reset by itself due to receiving a ACK.
> > >
> > > There are two key checks in tcp_timewait_state_process() when timewai=
t
> > > socket in B receives the SYN packet:
> > > 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > > 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> > >
> > > Regarding the first rule, it fails as expected because in the first
> > > connection the seq of SYN sent from A is 1892994276, then 169s have
> > > passed, the second SYN has 239034613 (caused by overflow of s32).
> > >
> > > Then how about the second rule?
> > > It fails again!
> > > Let's take a look at how the tsval comes out:
> > > __tcp_transmit_skb()
> > >     -> tcp_syn_options()
> > >         -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb)=
 + tp->tsoffset;
> > > The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> > > other is tp->tsoffset. The latter value is fixed, so we don't need
> > > to care about it. If both operations (sending FIN and then starting
> > > sending SYN) from A happen in 1ms, then the tsval would be the same.
> > > It can be clearly seen in the tcpdump log. Notice that the tsval is
> > > with millisecond precision.
> > >
> > > Based on the above analysis, I decided to make a small change to
> > > the check in tcp_timewait_state_process() so that the second flow
> > > would not fail.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/ipv4/tcp_minisocks.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > index bb1fe1ba867a..2b29d1bf5ca0 100644
> > > --- a/net/ipv4/tcp_minisocks.c
> > > +++ b/net/ipv4/tcp_minisocks.c
> > > @@ -234,7 +234,7 @@ tcp_timewait_state_process(struct inet_timewait_s=
ock *tw, struct sk_buff *skb,
> > >       if (th->syn && !th->rst && !th->ack && !paws_reject &&
> > >           (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
> > >            (tmp_opt.saw_tstamp &&
> > > -           (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval)=
 < 0))) {
> >
> > I think this follows RFC 6191 and such a change requires a formal
> > discussion at IETF.
> >
> > https://datatracker.ietf.org/doc/html/rfc6191#section-2
> >
> > ---8<---
> >       *  If TCP Timestamps would be enabled for the new incarnation of
> >          the connection, and the timestamp contained in the incoming SY=
N
> >          segment is greater than the last timestamp seen on the previou=
s
>
> The true thing is that the timestamp of the SYN packet is greater than
> that of the last packet, but the kernel implementation uses ms
> precision (please see tcp_skb_timestamp_ts()). That function makes
> those two timestamps the same.
>
> This case happens as expected, so the second connection should be
> established. My confusion just popped out of my mind: what rules
> should we follow to stop the second flow?

Note that linux TCP stack can use usec resolution for TCP TS values.

You might adopt it, and no longer care about this ms granularity.

