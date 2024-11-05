Return-Path: <netdev+bounces-141889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA439BC9C5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FE11F2341A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018181D1E79;
	Tue,  5 Nov 2024 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdKz8vFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4C18BC37
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800654; cv=none; b=G0GLXSHplj2+VK74lik7dmT+HSY93GM1GNYYF13tK5/fU0X3gMtPKA9Fefb/f0FRyjdmcPXAGzKQve4Ge/lAAvgJNhqtLVixWhMKNQnDpKxB2kcKqv14qI1LS9wruFDGfxJCGQHo1Hyc/cJEQveBMVlueefhMUVfXJMuEVNXckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800654; c=relaxed/simple;
	bh=nNVGc/rhRklZRqYSV1oE4AGTffLhZg2PzPVzkoe02jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1Ve5fAcatAqFV/q4+5AtvhrG/yD1cT8QdWOlcFutS2ESZrADm0Fv2iD654lecRUZbGz6/bgZd1acWA8hPpPfIHyuhN12f5epuyyaq4ewEknkjh8cbsC/NzMCngrL8u6ik44kXRggo+sMtDkBsrHhUjM+tdgl6qMZu+deGm0JoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdKz8vFM; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so244758839f.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730800652; x=1731405452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeL6fcN9rRSq3sdQ+Z+wb9j0vzRd9WimUVH85Elv+88=;
        b=KdKz8vFMRd8GEFrJzUjwXJzIo8Nj+HbV6LH7EBGUieX83ZxaIqA1ZCFDmvRGJq90uO
         48eA7tCHYRHfw67VRvdNbdkcgnU1K3DTo2XjBibvVcUpZ3b/kMukXBuzFI+vnF+eSOqZ
         wHpUCSMSk9RogZ1I3GU5owCbyZ0PelMRCkBSZVDPAjbu0iszORXBtrdGfc5kj4aSzdCV
         oUjaDwwd8i6eME8RqHUl/hxF0r/xxV1BSD9Kn93p3LOPsezNqNemBagL+lWQghZbJ0S5
         Dag/k3YnixOoAgSMrqGOj+nYP2ummM/Anx50l2BWAiQfJckrQjtsa75MERwgbTkKxnUu
         0KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800652; x=1731405452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeL6fcN9rRSq3sdQ+Z+wb9j0vzRd9WimUVH85Elv+88=;
        b=NQSMIvCp7w9UkhsGOUpgvPNVdvn3bOkhR7vbOh+JX8StOZKp4HCOlIZgyiGMgoRbZg
         sBAks2xy1UK2K/DUZGneWOulfTPwllb1ZhX7EZUmUJriSscx05pFiZOE/qnmpeeFn8+7
         1WTzmfPkcNf3q189aMpE3iqm3vwdkA6Oe7+m8MCT6ER5kcp0fKUdxwI7VM5LO+MU8AMG
         RzFoqOyE4kLnjaZmdUDQ5vFm+HeMHhgmj65eZzEWF6YkS7cbWfFLCeUZEhAwX14xKVkM
         jC0EoijpK2O5m7Myh82zttVU+6jz90akkg9xQs3PtYYMsHmexRVjxHuDTm33RdlYkBcO
         JOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdUR/UhvacODclXiUXd5jEBG4EK0oXYiXEadi6uBpqxjiTNRzdYP4fZkaH0ILqn8m0vTY3Dtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1mmMbP/LbBXGKlSeLSrxaA+Nb8z/J8d1UeyKY27ezUBoIvxo
	ZuDkIBBLBsUWF1SW+YnLVopWpKaN1/3R6/0JVLyJ3THS6toTlnELLzO3anWeIpIknwpod5J1BJq
	apPo9gjEbE3ptlg8k9KtfldRe/ow=
X-Google-Smtp-Source: AGHT+IEi0ZSNWt4gs1LkprwdYUKHDCuKG0t2k3/YBUeIpAqP3nPnbfHlaEx6Zbz2y/MygF0Lkz8pRv/OIYXumsH15sE=
X-Received: by 2002:a05:6e02:1b07:b0:3a5:e5cf:c5b6 with SMTP id
 e9e14a558f8ab-3a5e5cfc68bmr221263265ab.10.1730800652151; Tue, 05 Nov 2024
 01:57:32 -0800 (PST)
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
Date: Tue, 5 Nov 2024 17:56:55 +0800
Message-ID: <CAL+tcoBV2AYZwjVFEEfPahKnFKJ-tZmkUCKF0k0hy6iFnCQWAQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, dsahern@kernel.org, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Oh right, I just can't figure it out why since we've already lost the
fine-grained timestamp in each skb. I spent a few days investigating
the bad cases this patch may bring, but I failed.

> Instead, use a usec clock and voila, the problem is solved.

Sure, it can work :)

Thanks,
Jason

