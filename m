Return-Path: <netdev+bounces-83229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A741A8916B2
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1D91F23577
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B01535B4;
	Fri, 29 Mar 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLg4l/Ql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C741535D0;
	Fri, 29 Mar 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707789; cv=none; b=GdHh4g9yzfnpKxe7cG2pzh3Td1b0ZmUlvvkGi0Kqk2ZDuOULv3uzebEbN0puQ24f0rOHOywYf2h4fPt4PHz1a75nwy4rDByyHBZbcRxjfyrVNGO4JpJb7VJFyK+VWh54mNTh13JvpK71uYwLtymKujt+4u0W0Tyf9z4hm0iqXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707789; c=relaxed/simple;
	bh=m5vhWQy+PY6+1d7TO9Fvs0/o49rPQMvxSJXHB6kgO00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTjH72D2Ig8hhqpcfzxC9/+2hMsiK5V1pA0HWTWrWJ+5eHYO1XqKMBvDkHYIuyvcOE53uIpo/4YWJkZbm2+n67iaZwz4jIOg8TaSfskJXvCYGlcn7F6rjdiNokxsBesl9xfYgScoLfLSlna4iU/RZPVPi0j+SpFnCE3vqljoaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLg4l/Ql; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so338199166b.1;
        Fri, 29 Mar 2024 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711707786; x=1712312586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TUuNHvMMKVcm/3UfHRwY6GOFwJQHmIlXuumJcrhUmc=;
        b=DLg4l/QlMccvDPYL2XBfTlC2LoNL8GdOmNj7aXrctPM4knQMrLEzMZIMBQP4muAUyf
         LPbPO6ZcqwZIUcy6LRYfUWSw/Tblv3LANbroch9staXUrRbVW20Paox6DUgLoi9sGkVY
         HoEfdUnkgUiCrdwh5wipvz/ajWcrUBEUq9EMqKzanzVr+3cYEU5KHthR04HPNysDrHjU
         MJSdZ5jRh6Tl75s376gefHJc31Ft+Y8GOxabpLM7L+JFKdc3boxqyCH64RzdegYQVbTi
         DMsVnnpbDli8IYpWmozESyggJCWOvefmXJSZUHzLjfWr+tVSxI/lPwFdnmaN+tuNZBDF
         fY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711707786; x=1712312586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TUuNHvMMKVcm/3UfHRwY6GOFwJQHmIlXuumJcrhUmc=;
        b=h01Laec7Nez8Ovih3ZORcAUeofJ5Nez+1EN1TFA9KWwXZn14+0vhbkU/jXOfZE7HIk
         9aBWF+G4yaN9F31OdkVkCn44sK1kUMNOkGcV0ShxsWCsOl00FEpkjbS+zUKy0IFor2Fd
         NsAnuFn58kTlMJ9L4Y7KzFA+4Re1wUJGbMmuwWsyNTH9+q1Fe9T8U3JlyhX4RoX9PPgT
         jumDScgr+6sbxeRreygCkQB5SA2H5ozJ0T2MOo2kyXc1E6hx9CgVPn8wKQXlEMyZ4IEY
         lg9IJdjS3FBki3TCOW8UAt6MvtOF94vzAYKYmGpO7eFLoX5FNVjibRq1g2PFWCDH81Fo
         WWdg==
X-Forwarded-Encrypted: i=1; AJvYcCXAtAO+TpM8veCjl3eQbH7KpEn6skrikH5hZ8get2wOyKlnFh3o0d5gm0r7if3R88yrI5+UucGfdEkzQFBdshBDoRd0Pe0jOyvKP1kkyxsB/KgVUzkMCBacw28pIrqa3YoV8Y7FQAHMHk9n
X-Gm-Message-State: AOJu0YzQXjrhxfjbIDLevU3jOMLeRjMqz8gcjR34cxD/y1fpbh4ykDCh
	D+KbqefFaEXiFUasscYscOUk0fjKhUQ6aZvWXLs2oNxu0r4t1jAWTa/BwhgFs6m3+MVFXRtU5FM
	CI2JKBprSuJkvORevdTr+mmLzcBY=
X-Google-Smtp-Source: AGHT+IEM9j09EY9K64dThaPlzNEMucWJvjtsaSQQpo3iufZFv63EqCRunseFvN9pd0WyrZgZ0pmZNqaxK2eYcKhD9t4=
X-Received: by 2002:a17:906:d95:b0:a44:e5ed:3d5d with SMTP id
 m21-20020a1709060d9500b00a44e5ed3d5dmr1815750eji.9.1711707785510; Fri, 29 Mar
 2024 03:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com>
 <20240329034243.7929-3-kerneljasonxing@gmail.com> <CANn89iK35sZ7yYLfRb+m475b7kg+LHw4nV9qHWP7aQtLvBoeMA@mail.gmail.com>
In-Reply-To: <CANn89iK35sZ7yYLfRb+m475b7kg+LHw4nV9qHWP7aQtLvBoeMA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 29 Mar 2024 18:22:28 +0800
Message-ID: <CAL+tcoBt0DxdSbb5PES8uYgeyBqThUyS_J4d3hUuxZv8=J0H9A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] trace: tcp: fully support trace_tcp_send_reset
To: Eric Dumazet <edumazet@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
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
> > By parsing the incoming skb and reversing its 4-tuple can
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
> > index 194425f69642..289438c54227 100644
> > --- a/include/trace/events/tcp.h
> > +++ b/include/trace/events/tcp.h
> > @@ -78,11 +78,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
> >   * skb of trace_tcp_send_reset is the skb that caused RST. In case of
> >   * active reset, skb should be NULL
> >   */
> > -DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
> > +TRACE_EVENT(tcp_send_reset,
> >
> >         TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> >
> > -       TP_ARGS(sk, skb)
> > +       TP_ARGS(sk, skb),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(const void *, skbaddr)
> > +               __field(const void *, skaddr)
> > +               __field(int, state)
> > +               __array(__u8, saddr, sizeof(struct sockaddr_in6))
> > +               __array(__u8, daddr, sizeof(struct sockaddr_in6))
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->skbaddr =3D skb;
> > +               __entry->skaddr =3D sk;
> > +               /* Zero means unknown state. */
> > +               __entry->state =3D sk ? sk->sk_state : 0;
> > +
> > +               memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> > +               memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
> > +
> > +               if (sk && sk_fullsock(sk)) {
> > +                       const struct inet_sock *inet =3D inet_sk(sk);
> > +
> > +                       TP_STORE_ADDR_PORTS(__entry, inet, sk);
> > +               } else {
>
> To be on the safe side, I would test if (skb) here.
> We have one caller with skb =3D=3D NULL, we might have more in the future=
.

Thanks for the review.

How about changing '} else {' to '} else if (skb) {', then if we go
into this else-if branch, we will print nothing, right? I'll test it
in this case.

>
> > +                       /*
> > +                        * We should reverse the 4-tuple of skb, so lat=
er
> > +                        * it can print the right flow direction of rst=
.
> > +                        */
> > +                       TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, entr=
y->saddr);
> > +               }
> > +       ),
> > +
> > +       TP_printk("skbaddr=3D%p skaddr=3D%p src=3D%pISpc dest=3D%pISpc =
state=3D%s",
> > +                 __entry->skbaddr, __entry->skaddr,
> > +                 __entry->saddr, __entry->daddr,
> > +                 __entry->state ? show_tcp_state_name(__entry->state) =
: "UNKNOWN")
> >  );
> >
> >  /*
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index a22ee5838751..d5c4a969c066 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -868,10 +868,10 @@ static void tcp_v4_send_reset(const struct sock *=
sk, struct sk_buff *skb)
> >          */
> >         if (sk) {
> >                 arg.bound_dev_if =3D sk->sk_bound_dev_if;
> > -               if (sk_fullsock(sk))
> > -                       trace_tcp_send_reset(sk, skb);
> >         }
>
> Remove the { } ?

Yes, I forgot to remove them.

Thanks,
Jason

>
>
> >
> > +       trace_tcp_send_reset(sk, skb);
> > +
> >         BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=3D
> >                      offsetof(struct inet_timewait_sock, tw_bound_dev_i=
f));
> >
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 3f4cba49e9ee..8e9c59b6c00c 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1113,7 +1113,6 @@ static void tcp_v6_send_reset(const struct sock *=
sk, struct sk_buff *skb)
> >         if (sk) {
> >                 oif =3D sk->sk_bound_dev_if;
> >                 if (sk_fullsock(sk)) {
> > -                       trace_tcp_send_reset(sk, skb);
> >                         if (inet6_test_bit(REPFLOW, sk))
> >                                 label =3D ip6_flowlabel(ipv6h);
> >                         priority =3D READ_ONCE(sk->sk_priority);
> > @@ -1129,6 +1128,8 @@ static void tcp_v6_send_reset(const struct sock *=
sk, struct sk_buff *skb)
> >                         label =3D ip6_flowlabel(ipv6h);
> >         }
> >
> > +       trace_tcp_send_reset(sk, skb);
> > +
> >         tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
> >                              ipv6_get_dsfield(ipv6h), label, priority, =
txhash,
> >                              &key);
> > --
> > 2.37.3
> >

