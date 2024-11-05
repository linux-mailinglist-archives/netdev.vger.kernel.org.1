Return-Path: <netdev+bounces-141947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4855D9BCC26
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6E5B23016
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D731D5159;
	Tue,  5 Nov 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU/Uc4zn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C871D45EF
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807331; cv=none; b=NaLvaotpOKw0uYGWnNCYVksDxJ8ScbY704xroHW4PF4zwY+/ZH/FpUX8ubnJE409/dgbhZhSRtv9edzWzLR0jS0HROFTeL2NfNQywSRAUOrFSy7Wj+l4XYrvkae3mpmvFFY48Jl6PZDSgBmZkPRyYxwi8izBzD0JlUkxFjqGCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807331; c=relaxed/simple;
	bh=xxMH70Lth7P7/I57PA9uHTmoxZrexSifPU1Cs0oebsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1vKsEYeoGPujnxIkoDiIW6wM/iC1IkOfk0Fo2KqKAGF0KpMJ6UP9rEbczf7yTTzMkHy6VZDGK30B4cIsOvlBEVp2kOKY9XhahqQRfaPJ/RS+3Ht6P1Tfoa8B/VWt/3EyXvY9kk3nY+iQYOC50ksJ+UlOxvhVlEjSWerWGlUHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU/Uc4zn; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83abcfb9f39so154658139f.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730807329; x=1731412129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amUSUVKnbmHOvo0eMlcPK5IbGzdzqhYeiSYK4D5HEDk=;
        b=hU/Uc4znEGPCF9o1LR269y6eY/DI+MfTDSIJr6UJJY3gHz7mxqmY8oY7ssJlBG7uEZ
         SVA5qZqUv/H3y8hoyzLcP9tnufbrIKazeQLzuNhx0o4YRcz3bQXNHBgswMCPO6CTROSJ
         yN1zuCeoxK2DxBFvwu0hx5dNvIseK25JQ4JI5rkLyKnG0o4iN4gg28VaiDAe6bdNR7WD
         kM6XtQR2JdW/ZcGZ1J2OUe6gV0yGop6ukOyzPP1tce89UYqDD1e9OQylbqWZ8lvOZLKr
         YpAunZQCjgwv/iXzoT+pM/fbjBzokl3V0QH7SsBLJLxsXsbd3Kdj6dmI09JuDBzKc6/Z
         F7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730807329; x=1731412129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amUSUVKnbmHOvo0eMlcPK5IbGzdzqhYeiSYK4D5HEDk=;
        b=rmju9qKulqqCAzSzJfwE9p6Ml2KSnRgva+zCU5XfDLeoGAaU8eDdNUTx7vx7IgBfNV
         TFZ2a83Ld+/G314z8zDdi/Bb0D9QjX5aFSwAwrMil0aaLWkAon1E3SVHgabylMx8bkdn
         cRKLGZ/YS8LD2uv3tlJ6dwKWGvsKrO6Zzdd0eUdHS6nhcWrcjwHUuH0sta+rWC5bogJ7
         ADA/mSSeP/XuuDfxMgKADZWYybw990F1Nzpl8Kc8hTK7hRU2EudL2GMvwPqlAeCAGw9w
         X8DpK7rVhkxK01dmDHEuJPe9SZAuHyOSSJUHEDy1hPZRy/Vw0jjbrPikaRKLzKWNuMMF
         Dg5w==
X-Forwarded-Encrypted: i=1; AJvYcCX6ci4HQixVaCPWb/gL5GVToNbzaGj4RR6Vv5fvTLKNy0u2Ram7lcQcQk1iSTG8ZPH5wWMJlZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TQsJ0r7nHvNLiWV5VMphALqxmKV0w9qagCIExDI+k3a14hfM
	5yCKxT144UimNcRoDjyjK26rI1qSTOfxhAVwAtZKRoZrNrtJFdFivnVt03rkDp/FWLCUkJ2JOBY
	xp586LZeE1emsZzGYAUSD39zW6Y0=
X-Google-Smtp-Source: AGHT+IEB8wibB6PaBTfIIcujwOAKk7FEMnaWRr0/CtTyJ9kOcenZZS4n2dzMxWabLvOSL8UUjI8E8gQKX7YNS0MSEZw=
X-Received: by 2002:a05:6e02:308c:b0:3a6:c000:4490 with SMTP id
 e9e14a558f8ab-3a6c0004a17mr96029275ab.1.1730807328781; Tue, 05 Nov 2024
 03:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <20241105074916.75107-1-kuniyu@amazon.com> <CAL+tcoAgSBMtFcDx6MfCAhYMVKERCx2d7YUjquT6Pa8jm0bXWA@mail.gmail.com>
 <CANn89iKhSnTJUadpEBpkKYoRVP2GEJZ1ftzH7AqF4oXMF3QEZA@mail.gmail.com>
 <CAL+tcoCBvbR_=c_SxKmAyAE4U5wTgr=hp08yNxm0QUSWdgge5Q@mail.gmail.com> <CANn89i+h4zbgju1KSfTZi2R1bnQ4=Q1EThJ9y8e5XCOocLNzMw@mail.gmail.com>
In-Reply-To: <CANn89i+h4zbgju1KSfTZi2R1bnQ4=Q1EThJ9y8e5XCOocLNzMw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 Nov 2024 19:48:12 +0800
Message-ID: <CAL+tcoBVbL+tRsHZpLQro1gEoAUn11ZWG3=AL-5XxFVCAxZ5fg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Eric Dumazet <edumazet@google.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, dsahern@kernel.org, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric, Martin

On Tue, Nov 5, 2024 at 5:50=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Nov 5, 2024 at 10:42=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Tue, Nov 5, 2024 at 5:35=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Tue, Nov 5, 2024 at 10:08=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Tue, Nov 5, 2024 at 3:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@am=
azon.com> wrote:
> > > > >
> > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > Date: Tue,  5 Nov 2024 10:55:11 +0800
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > We found there are rare chances that some RST packets appear du=
ring
> > > > > > the shakehands because the timewait socket cannot accept the SY=
N and
> > > > >
> > > > > s/shakehands/handshake/
> > > > >
> > > > > same in the subject.
> > > > >
> > > > > > doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > > > > >
> > > > > > Here is how things happen in production:
> > > > > > Time        Client(A)        Server(B)
> > > > > > 0s          SYN-->
> > > > > > ...
> > > > > > 132s                         <-- FIN
> > > > > > ...
> > > > > > 169s        FIN-->
> > > > > > 169s                         <-- ACK
> > > > > > 169s        SYN-->
> > > > > > 169s                         <-- ACK
> > > > > > 169s        RST-->
> > > > > > As above picture shows, the two flows have a start time differe=
nce
> > > > > > of 169 seconds. B starts to send FIN so it will finally enter i=
nto
> > > > > > TIMEWAIT state. Nearly at the same time A launches a new connec=
tion
> > > > > > that soon is reset by itself due to receiving a ACK.
> > > > > >
> > > > > > There are two key checks in tcp_timewait_state_process() when t=
imewait
> > > > > > socket in B receives the SYN packet:
> > > > > > 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > > > > > 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < =
0)
> > > > > >
> > > > > > Regarding the first rule, it fails as expected because in the f=
irst
> > > > > > connection the seq of SYN sent from A is 1892994276, then 169s =
have
> > > > > > passed, the second SYN has 239034613 (caused by overflow of s32=
).
> > > > > >
> > > > > > Then how about the second rule?
> > > > > > It fails again!
> > > > > > Let's take a look at how the tsval comes out:
> > > > > > __tcp_transmit_skb()
> > > > > >     -> tcp_syn_options()
> > > > > >         -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts=
, skb) + tp->tsoffset;
> > > > > > The timestamp depends on two things, one is skb->skb_mstamp_ns,=
 the
> > > > > > other is tp->tsoffset. The latter value is fixed, so we don't n=
eed
> > > > > > to care about it. If both operations (sending FIN and then star=
ting
> > > > > > sending SYN) from A happen in 1ms, then the tsval would be the =
same.
> > > > > > It can be clearly seen in the tcpdump log. Notice that the tsva=
l is
> > > > > > with millisecond precision.
> > > > > >
> > > > > > Based on the above analysis, I decided to make a small change t=
o
> > > > > > the check in tcp_timewait_state_process() so that the second fl=
ow
> > > > > > would not fail.
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  net/ipv4/tcp_minisocks.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.=
c
> > > > > > index bb1fe1ba867a..2b29d1bf5ca0 100644
> > > > > > --- a/net/ipv4/tcp_minisocks.c
> > > > > > +++ b/net/ipv4/tcp_minisocks.c
> > > > > > @@ -234,7 +234,7 @@ tcp_timewait_state_process(struct inet_time=
wait_sock *tw, struct sk_buff *skb,
> > > > > >       if (th->syn && !th->rst && !th->ack && !paws_reject &&
> > > > > >           (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
> > > > > >            (tmp_opt.saw_tstamp &&
> > > > > > -           (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_=
tsval) < 0))) {
> > > > >
> > > > > I think this follows RFC 6191 and such a change requires a formal
> > > > > discussion at IETF.
> > > > >
> > > > > https://datatracker.ietf.org/doc/html/rfc6191#section-2
> > > > >
> > > > > ---8<---
> > > > >       *  If TCP Timestamps would be enabled for the new incarnati=
on of
> > > > >          the connection, and the timestamp contained in the incom=
ing SYN
> > > > >          segment is greater than the last timestamp seen on the p=
revious
> > > >
> > > > The true thing is that the timestamp of the SYN packet is greater t=
han
> > > > that of the last packet, but the kernel implementation uses ms
> > > > precision (please see tcp_skb_timestamp_ts()). That function makes
> > > > those two timestamps the same.
> > > >
> > > > This case happens as expected, so the second connection should be
> > > > established. My confusion just popped out of my mind: what rules
> > > > should we follow to stop the second flow?
> > >
> > > Note that linux TCP stack can use usec resolution for TCP TS values.
> > >
> > > You might adopt it, and no longer care about this ms granularity.
> >
> > Right, I noticed this feature. I wonder if we can change the check in
> > tcp_timewait_state_process() like this patch if it has no side
> > effects? I'm worried that some programs don't use this feature. It's
> > the reason why I try to propose this patch to you.
>
> Breaking RFC ? I do not think so.
>
> Instead, use a usec clock and voila, the problem is solved.

I wonder if it is necessary to use BPF to extend the usec clock. Since
I started investigating the BPF part, I found it can help us extend
many useful features in TCP to the most extent.

Using it with the BPF program can make the feature take effect and
widely used in future.

I'm asking because I somehow have a feeling that someday the majority
of traditional sockopts could be replaced by BPF. After all, requiring
application modification for those kernel features is a bit heavy. I'm
not sure if I'm right about it :S

Thanks,
Jason

