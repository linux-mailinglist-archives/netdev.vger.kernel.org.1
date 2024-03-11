Return-Path: <netdev+bounces-79059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42517877A7E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 06:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55F9281915
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 05:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB3379CB;
	Mon, 11 Mar 2024 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcIe5QwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB9748F;
	Mon, 11 Mar 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710133254; cv=none; b=PD3E0o3jdO9/ddyy6gAx57MyJqLKCJmu7oJSQZYKbcsY8QwvXzGG3tGzRZik7ue6+NBl5jhkaO6dOdWL455tQqJCKMd6g8lHS3y1bh07XTndYxoXIW1VjfYhnIQU1F+pd0GXiw8RbfbFMlyOhQUWk1rgfPhv/gbtX4c8t/iHXRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710133254; c=relaxed/simple;
	bh=S8u9xOLGnfgzFHpsjcG6J/aSTopBIV/7Pt+dkFcWwoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bULgrYNdNWJqKZ6rFMauHWY3oCetN5P78a32x4pFZOhpb+8YVwnH0rF+WTqr1w+l+V2Hr3k6hE2nmWYxim0CpFhiDN9CC8H4QSzIL3U3lB+xQ2HbMgyahj1jRvo3bPd8ObDcYjygNqDWIBM1mV3aoNSFc9aQDKlR1rzXFhOtaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcIe5QwX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44665605f3so579949566b.2;
        Sun, 10 Mar 2024 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710133251; x=1710738051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWUIcX1SrQKdpKLtjjrw9GFImNpCrITqLblrxOdKflc=;
        b=XcIe5QwXIIX0mWYgIsMNTekICAP4wKvT4VLA3YNCQtYSYDgiBi3ohT1pEn6d+W4OrI
         usZIn5BLT371uJQAepNeEeq/oEYychQrSpg5WwqyGHWZI4kKMwjCtsms2+mRyel4e02U
         85MIsVSZ6unKkZXspVWgNwZzmX7VT6dwlB2tyyJKXA/052USyUvtLTloHJI8qzrWBzlq
         2iuOjBW4+ZrYFNdzVC6NDhpdYd5T9fzbHiiHH7pst8+9pIAlBRqsVTpkYmawrr6d33Yx
         v+2XvDlLqXE3k6W6lWNbKK8w9lQV3thT5616IQvWVnxxv33hhb8mk5UeLpcYYCDHVxYe
         Xtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710133251; x=1710738051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWUIcX1SrQKdpKLtjjrw9GFImNpCrITqLblrxOdKflc=;
        b=JL/R45MGYwhnPF4qTKpXWzrU8qj77OOaVt9NKUUsznI4Is6jD+3KHzvRD3c8hRbHRv
         JQ8XTX31FEzAHo6+DLMF68a0xqtNFtta8/shvyW7mSwpIeoz+4HnSa/lsBs8VZJsx6tG
         PghCZ7qT243c9ABM7dn5tXiaPOeKKW3gCgCGRiXVWQ3S5xifUe8H4FJoHNVhljcccSws
         2oZW7Hl3vjNf2TyCw3km8EuDeSRSnOiHnE6jnSkRApyKN71tQ4yZhLZ/QEWhQLJqdcLm
         Nv3ABDLRXHXitF91S3nqVp1XTNymDnbZgr1wbBIss8e1v9lH58hCVcJI6XuiwqDXwRZb
         421A==
X-Forwarded-Encrypted: i=1; AJvYcCWCbrjvoJje3Uv1AO7wVY2QgMT1SwuaJSnCB3XdfMlgg3IeHAWCGhIMDA+jnxuccYPnfCQQtt4hWlZooi7Hm6QBaZaaF7qYzhN/53lTCPoNVzBYxmAYlYpfJ7QN+fCVHm3lOhWTljpczfnr
X-Gm-Message-State: AOJu0YwXgieVj4TzHRKrGuUKUh0sXPr886k1nzRzSMFlzYz0d8nzYIvM
	HIh5DK2ge9YTQw2qdR7YQd68ZGy/xiPfmkbXpg6XTEbXxe0RMfFlwo+MWxF6exR2/+tVvLhPJTZ
	6U7Q/Ru/VLlbtRapt0UrVSP5U/JU=
X-Google-Smtp-Source: AGHT+IHSZwHtCT/SadJxWVUdfRzT6+JS+qXO0RoJETnRJaQiqxtnzb3HANVuctIR8Q9QVjxukOsYzsxzvf9RiqPcfuc=
X-Received: by 2002:a17:907:a0cc:b0:a46:134c:ae8d with SMTP id
 hw12-20020a170907a0cc00b00a46134cae8dmr2455898ejc.29.1710133251037; Sun, 10
 Mar 2024 22:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311024104.67522-1-kerneljasonxing@gmail.com>
 <20240311024104.67522-3-kerneljasonxing@gmail.com> <20240311032717.GB1241282@maili.marvell.com>
In-Reply-To: <20240311032717.GB1241282@maili.marvell.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 11 Mar 2024 13:00:14 +0800
Message-ID: <CAL+tcoD-2g2BTYOXfWEfrJ5DYh3PQcUn=Sk8_Zr6ZZLj6Pokzg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] trace: tcp: fully support trace_tcp_send_reset
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:27=E2=80=AFAM Ratheesh Kannoth <rkannoth@marvell=
.com> wrote:
>
> On 2024-03-11 at 08:11:04, Jason Xing (kerneljasonxing@gmail.com) wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Prior to this patch, what we can see by enabling trace_tcp_send is
> > only happening under two circumstances:
> > 1) active rst mode
> > 2) non-active rst mode and based on the full socket
> >
> > That means the inconsistency occurs if we use tcpdump and trace
> > simultaneously to see how rst happens.
> >
> > It's necessary that we should take into other cases into considerations=
,
> > say:
> > 1) time-wait socket
> > 2) no socket
> > ...
> >
> > By parsing the incoming skb and reversing its 4-turple can
> > we know the exact 'flow' which might not exist.
> >
> > Samples after applied this patch:
> > 1. tcp_send_reset: skbaddr=3DXXX skaddr=3DXXX src=3Dip:port dest=3Dip:p=
ort
> > state=3DTCP_ESTABLISHED
> > 2. tcp_send_reset: skbaddr=3D000...000 skaddr=3DXXX src=3Dip:port dest=
=3Dip:port
> > state=3DUNKNOWN
> > Note:
> > 1) UNKNOWN means we cannot extract the right information from skb.
> > 2) skbaddr/skaddr could be 0
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/trace/events/tcp.h | 39 ++++++++++++++++++++++++++++++++++++--
> >  net/ipv4/tcp_ipv4.c        |  4 ++--
> >  net/ipv6/tcp_ipv6.c        |  3 ++-
> >  3 files changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > index 2495a1d579be..6c09d7941583 100644
> > --- a/include/trace/events/tcp.h
> > +++ b/include/trace/events/tcp.h
> > @@ -107,11 +107,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb=
,
> >   * skb of trace_tcp_send_reset is the skb that caused RST. In case of
> >   * active reset, skb should be NULL
> >   */
> > -DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
> > +TRACE_EVENT(tcp_send_reset,
> >
> >       TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> >
> > -     TP_ARGS(sk, skb)
> > +     TP_ARGS(sk, skb),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(const void *, skbaddr)
> > +             __field(const void *, skaddr)
> > +             __field(int, state)
> > +             __array(__u8, saddr, sizeof(struct sockaddr_in6))
> > +             __array(__u8, daddr, sizeof(struct sockaddr_in6))
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->skbaddr =3D skb;
> > +             __entry->skaddr =3D sk;
> > +             /* Zero means unknown state. */
> > +             __entry->state =3D sk ? sk->sk_state : 0;
> > +
> > +             memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> > +             memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
> > +
> > +             if (sk && sk_fullsock(sk)) {
> > +                     const struct inet_sock *inet =3D inet_sk(sk);
> > +
> > +                     TP_STORE_ADDR_PORTS(__entry, inet, sk);
> > +             } else {
> > +                     /*
> > +                      * We should reverse the 4-turple of skb, so late=
r
> > +                      * it can print the right flow direction of rst.
> > +                      */
> > +                     TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, entry-=
>saddr);
> > +             }
> > +     ),
> > +
> > +     TP_printk("skbaddr=3D%p skaddr=3D%p src=3D%pISpc dest=3D%pISpc st=
ate=3D%s",
> Could you consider using %px ? is it permitted ? it will be easy to track=
 skb.

I prefer not to use %px because we cannot make use of the real address
of skb. Besides, using %px would leak kernel addresses.

Here is the Documentation (see Documentation/core-api/printk-formats.rst):
"Pointers printed without a specifier extension (i.e unadorned %p) are
hashed to give a unique identifier without leaking kernel addresses to user
space."

Perhaps, that's the reason why all the tracepoints didn't print in %px form=
at:)

Thanks,
Jason

>
> > +               __entry->skbaddr, __entry->skaddr,
> > +               __entry->saddr, __entry->daddr,
> > +               __entry->state ? show_tcp_state_name(__entry->state) : =
"UNKNOWN")
> >  );
> >
> >  /*
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index a22ee5838751..d5c4a969c066 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -868,10 +868,10 @@ static void tcp_v4_send_reset(const struct sock *=
sk, struct sk_buff *skb)
> >        */
> >       if (sk) {
> >               arg.bound_dev_if =3D sk->sk_bound_dev_if;
> > -             if (sk_fullsock(sk))
> > -                     trace_tcp_send_reset(sk, skb);
> >       }
> >
> > +     trace_tcp_send_reset(sk, skb);
> > +
> >       BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=3D
> >                    offsetof(struct inet_timewait_sock, tw_bound_dev_if)=
);
> >
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 3f4cba49e9ee..8e9c59b6c00c 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1113,7 +1113,6 @@ static void tcp_v6_send_reset(const struct sock *=
sk, struct sk_buff *skb)
> >       if (sk) {
> >               oif =3D sk->sk_bound_dev_if;
> >               if (sk_fullsock(sk)) {
> > -                     trace_tcp_send_reset(sk, skb);
> >                       if (inet6_test_bit(REPFLOW, sk))
> >                               label =3D ip6_flowlabel(ipv6h);
> >                       priority =3D READ_ONCE(sk->sk_priority);
> > @@ -1129,6 +1128,8 @@ static void tcp_v6_send_reset(const struct sock *=
sk, struct sk_buff *skb)
> >                       label =3D ip6_flowlabel(ipv6h);
> >       }
> >
> > +     trace_tcp_send_reset(sk, skb);
> > +
> >       tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
> >                            ipv6_get_dsfield(ipv6h), label, priority, tx=
hash,
> >                            &key);
> > --
> > 2.37.3
> >

