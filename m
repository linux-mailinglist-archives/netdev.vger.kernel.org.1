Return-Path: <netdev+bounces-141851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DB39BC8A9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1A51F2258B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750EC1CEAA6;
	Tue,  5 Nov 2024 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScuOgpoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B618F2F7
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797723; cv=none; b=GnAjlLBhU4B37F7Rk+V2MdbBw5SGw/aaHyVL2Fg3Ry9coJGSEDe3S9D3ZO/QnlPD003g3Y0LIVZpmzcF0g88ICdz2lmKr40qBuSmEJI42NI31eYXLRvH4NDYIKqK/dq/g0wXWbm7k84BfGZs9kQ7U0HXeiTOBsCmWttV4lX6GIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797723; c=relaxed/simple;
	bh=zPvE8EdRblsdpmW+G7eyIPzlmbgI6znlhowpahOObRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ujn6gxuBfqUIpec7AVZYnOZMx7/XszgeUIHQHZTPSYi6upxugBSHVMdnSMiMP6PQmdCzHXQUlYZLD/dbqJPPQM7Y035RHnQfMRCbpzKJsIh/+g59UIBiTDYWtB/JrY2wbecP6fSKIiGFVnnf+T4tAHPsW8lN4KYHeH+kTC4GMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScuOgpoC; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a4e5a7b026so18513095ab.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730797721; x=1731402521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvAsQThm39d7VA9jZ0qB3ixxljt9TZXncNnRcrDcdSo=;
        b=ScuOgpoCq7SsTATCgV112anxBIlSQ7ESvQT19NYm/+8mbh4kbrJrO5o8UI8XkivH5X
         Teeo5bEQv/ULkL3u2J+YXF91YS9VERKDax30aTxvU3C88/7z+yLp0PqNh02YLIBpOZK3
         Dn0GVkt+GSdQmqZM0Q9XHH69wLqzFn/ujJJxIytn3Hn0I9Qdod1CsqiAiaNVho5EVZmB
         MvYr9csI504DgQY7Njje4PwNtLRwUsBOef40hnx4aiafQYLs6wudnFIItgqzP/W8zPpz
         OS9bKRNt0hkKzco+DZKsq0t3XCw008OeuSAtG4mcyEq8FpDhcUTvAveT/bXgL9+cLaXB
         6Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730797721; x=1731402521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvAsQThm39d7VA9jZ0qB3ixxljt9TZXncNnRcrDcdSo=;
        b=eJah2ZTQ/iDedsUmmyJoyU+5a4bHrA8Dxo+2rviVYRQcHtld052WrA15Hxr0LmhyrR
         7hLgxs7bah/aOi7qKphm7tUFZ9F+OA4af7o1NgObwod9jsdXICKt1sFksN+y1ecubAQb
         qcmppKJEEc0czD1nM2+mFfRO7zprAjoFUOKXjYkb5AUg2ds41uIlQxE3k60jTo/n6NcT
         YtZAMvPsL1cB5oRasepseOzwZmJoDzI0BViCxsSjBYzjoDuZUAy/pj7FUEjdIC6Zsu5H
         FYjpouLoscix02tilcdkElUXF9dn4pndrVcsT+3cEU0gb3jf+T0kUUQkh4EB4kZd4aEv
         ZeMw==
X-Forwarded-Encrypted: i=1; AJvYcCUlxcs5Ovo/NAn4mRGCwGkOaV2pfEZSdz84wlyolVLZV9yxHrcGliY8DChTenLtQTywzAKi/hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydusOWOqOLE2mt9Z8PsICMrdZPhz37rO5qdFWHwjneGFMD/5Cd
	CAv+yNCpA1LT/rF8jxVz2EijHer886X5KGOQlXDHICz5/Mj/wOn9p4Wy4eR4E2+RcaoKwlJDZgJ
	T40g6phOtFL9aybhQeyKcXq4GP0c=
X-Google-Smtp-Source: AGHT+IH//tMSLhoiFDyDJMmgtzpEW0uhpBtbj+cES6tKfKzZvNzneQYn3R73E5C1k7YKunagUn9NABdRu5kxDglnuqk=
X-Received: by 2002:a05:6e02:16cb:b0:3a6:b0d0:ee2d with SMTP id
 e9e14a558f8ab-3a6b0d0f518mr128303565ab.9.1730797720587; Tue, 05 Nov 2024
 01:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com> <20241105074916.75107-1-kuniyu@amazon.com>
In-Reply-To: <20241105074916.75107-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 Nov 2024 17:08:04 +0800
Message-ID: <CAL+tcoAgSBMtFcDx6MfCAhYMVKERCx2d7YUjquT6Pa8jm0bXWA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Tue,  5 Nov 2024 10:55:11 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We found there are rare chances that some RST packets appear during
> > the shakehands because the timewait socket cannot accept the SYN and
>
> s/shakehands/handshake/
>
> same in the subject.
>
> > doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> >
> > Here is how things happen in production:
> > Time        Client(A)        Server(B)
> > 0s          SYN-->
> > ...
> > 132s                         <-- FIN
> > ...
> > 169s        FIN-->
> > 169s                         <-- ACK
> > 169s        SYN-->
> > 169s                         <-- ACK
> > 169s        RST-->
> > As above picture shows, the two flows have a start time difference
> > of 169 seconds. B starts to send FIN so it will finally enter into
> > TIMEWAIT state. Nearly at the same time A launches a new connection
> > that soon is reset by itself due to receiving a ACK.
> >
> > There are two key checks in tcp_timewait_state_process() when timewait
> > socket in B receives the SYN packet:
> > 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> >
> > Regarding the first rule, it fails as expected because in the first
> > connection the seq of SYN sent from A is 1892994276, then 169s have
> > passed, the second SYN has 239034613 (caused by overflow of s32).
> >
> > Then how about the second rule?
> > It fails again!
> > Let's take a look at how the tsval comes out:
> > __tcp_transmit_skb()
> >     -> tcp_syn_options()
> >         -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) +=
 tp->tsoffset;
> > The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> > other is tp->tsoffset. The latter value is fixed, so we don't need
> > to care about it. If both operations (sending FIN and then starting
> > sending SYN) from A happen in 1ms, then the tsval would be the same.
> > It can be clearly seen in the tcpdump log. Notice that the tsval is
> > with millisecond precision.
> >
> > Based on the above analysis, I decided to make a small change to
> > the check in tcp_timewait_state_process() so that the second flow
> > would not fail.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp_minisocks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > index bb1fe1ba867a..2b29d1bf5ca0 100644
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -234,7 +234,7 @@ tcp_timewait_state_process(struct inet_timewait_soc=
k *tw, struct sk_buff *skb,
> >       if (th->syn && !th->rst && !th->ack && !paws_reject &&
> >           (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
> >            (tmp_opt.saw_tstamp &&
> > -           (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) <=
 0))) {
>
> I think this follows RFC 6191 and such a change requires a formal
> discussion at IETF.
>
> https://datatracker.ietf.org/doc/html/rfc6191#section-2
>
> ---8<---
>       *  If TCP Timestamps would be enabled for the new incarnation of
>          the connection, and the timestamp contained in the incoming SYN
>          segment is greater than the last timestamp seen on the previous

The true thing is that the timestamp of the SYN packet is greater than
that of the last packet, but the kernel implementation uses ms
precision (please see tcp_skb_timestamp_ts()). That function makes
those two timestamps the same.

This case happens as expected, so the second connection should be
established. My confusion just popped out of my mind: what rules
should we follow to stop the second flow?

Thanks,
Jason

