Return-Path: <netdev+bounces-172603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C51A557BE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032367A4712
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA37B1FCF7C;
	Thu,  6 Mar 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPWSIqeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B92907
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294129; cv=none; b=t2gPv6C2xGUbXdgYJDuEF93+5elGNiSIq3Bjxv+qkrKkCaIxnKpS9CxmAbAeJ9dooTRztgXDt8r4HueXG7+98JDqx0mzKD63tXWPiGNN3ncXydIe/ntQNTWuIFHn6QWsmlGv1jP/f+YO9JTjoaS0WK55YjETYakPiRYSvE8hodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294129; c=relaxed/simple;
	bh=Fd0Biosx6kqIBMtJeFuBa0EjIyD6B6DSPc96Hb8V8tc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gMVrEaA5B5cRIbKFlaiBQP3TRIqpe1obitsfUyAFiegSUx7B3tEW8yBe68lRLv+DxsB4TAo3hyjibmADyRFutWrsbl/cDLXgJbG59Lw8aIuQ5vlT8iN6BOrQ8KndBNdMxT18gvfDh3D9pAyISUdMLFZuh/YU2v/3xJ9CbY+e1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPWSIqeO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-475038900b4so10863841cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741294127; x=1741898927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t6PqjADSQvvRE38351jKHjhxK9cNu9LvZB0GI1TtZU=;
        b=kPWSIqeO4fhSbaR+JxYM7bysqpJ64lpHF3UowP96CSvSRZXyReS9zmFQ2NCooGfnPU
         e6pi4I1uQ3SoTEwmQ95J+V4NsTF0fE5xE7Xo0IGD0TMtCZaCZXs5hAaqzQiSyckgOyF5
         s/r2/m7+Je9llnp89Rd93Z9aCyMpkhIl6Iidjytaq3vEb6l7hZd3WlZ8zXpRm6L4naVV
         ZinKAJfrwpSTTxrvQIQxORudWuMtCvClOhMPrtSsaaGTOOgtW6c0cy7id680HyOb06cZ
         LhZqM47XMLtlVwGeA5GZfzJNxPm8krWD42c+AS1a8pL+gtrQ2M6sJso7w3qfnacgedbg
         UNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741294127; x=1741898927;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+t6PqjADSQvvRE38351jKHjhxK9cNu9LvZB0GI1TtZU=;
        b=m6tGktoQC0XSIycbWX6LR3JxV9EcPfwcyUvJ1upn2mMp/UFmOeAyTrZ1p+2F3zeaTS
         BvaiRddY4kpW8wlAM7zdc9SQkTQJ/LI3yIZkqdJBhnn4mDgaEvBydVphjWBgNf38/zUk
         hutyoLwsedWjELnY74+h9h6d6M9vTlWOp+t+9zX13yfPE1UAg6W18WcXd7d7pTcUMnDf
         Fh+AVJCGAhRuaKRsqAFF3Z/0fe+BPUMUqAqZLz21VHEQjNq8OOFzSJiqRGDgS52vdRV7
         F2zYnYYXklLI4bTQVbD9em+oKir8Mp4MahGWPJv5PZrsgSzp4GmEG9koBfYHG1Tf6EYr
         QRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbgs9rGfMPYTgVw250TTQtq9WDCbC0iL3scpzx1XtFRe+V2HluUaXE7d8j9Z2x09hmFap9RUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3CWCT4h3jIm89ulb+tqsqeUh7tY0JS15x9HpLG517pc6IVQI
	ZTxOyXaDOqbsjwJCIzwd/GNIBcp6JEsPA/LO84TDI0j7NSfYFuYy
X-Gm-Gg: ASbGncuF5OJD+7AQ+UAxCzGTG/iY2u9diGeaACr/NNtbPIcYMCLbrt/C4zgkdep7lsj
	wRwMHC9hgjuOBGmi1EhpF8YRIiTWAXwRQpWCCcUVnmel/xHpEWVOrR8ftWpNsfKh5L3sYjlrrOn
	1AXzVqQY1o5atOgICflB4TKdThg9c/KDHYn+Xsqcc5p6mBKslrN+CnknWx91S85ommvgSVZx2mk
	gx6QfaVi4lV0AEUwXc/UfJmX3OstSCwgKba8CjRnsB95JPqtFk2IN0xBqWtVasnSkTBE+lwvKT1
	dUM1/VwuBuOU8mboFqUayOFeYlO+83uMwhuBvlcd3uHUVsBG8kV4WerAxuxlNk1KvYglMqyYA7g
	6qOYTWt2ejX860EN/xhMFIA==
X-Google-Smtp-Source: AGHT+IHgc4aJ/GQ2yr8EL72KLtAdKklD4mV7JxAYwC6lWswcYrAuO6v3mIoZC9Br0QBQr4s+av2vGw==
X-Received: by 2002:a05:622a:14d:b0:472:2d4:5036 with SMTP id d75a77b69052e-4751a4d8ca8mr59363361cf.2.1741294126778;
        Thu, 06 Mar 2025 12:48:46 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d9b3746sm11688101cf.48.2025.03.06.12.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:48:46 -0800 (PST)
Date: Thu, 06 Mar 2025 15:48:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <67ca0a2dea753_212e62946f@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iJi5GsaK6ZbuuiMDpHsWxj9fbAEG5Vj0CzoJeWFJvpj4Q@mail.gmail.com>
References: <20250306183101.817063-1-edumazet@google.com>
 <67c9f10e7f7e8_1580029446@willemb.c.googlers.com.notmuch>
 <CANn89i+QnSwxB33Hp48587EWAX=QYY0Msmv_bkfe_C1amk8Ftg@mail.gmail.com>
 <67c9fe2af078b_1bb0a2942a@willemb.c.googlers.com.notmuch>
 <CANn89iJi5GsaK6ZbuuiMDpHsWxj9fbAEG5Vj0CzoJeWFJvpj4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Thu, Mar 6, 2025 at 8:57=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > On Thu, Mar 6, 2025 at 8:01=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Eric Dumazet wrote:
> > > > > Use SKB_DROP_REASON_UDP_CSUM in __first_packet_length()
> > > > > and udp_read_skb() when dropping a packet because of
> > > > > a wrong UDP checksum.
> > > > >
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > ---
> > > > >  net/ipv4/udp.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > index 17c7736d8349433ad2d4cbcc9414b2f8112610af..39c3adf333b5f02=
ca53f768c918c75f2fc7f93ac 100644
> > > > > --- a/net/ipv4/udp.c
> > > > > +++ b/net/ipv4/udp.c
> > > > > @@ -1848,7 +1848,7 @@ static struct sk_buff *__first_packet_len=
gth(struct sock *sk,
> > > > >                       atomic_inc(&sk->sk_drops);
> > > > >                       __skb_unlink(skb, rcvq);
> > > > >                       *total +=3D skb->truesize;
> > > > > -                     kfree_skb(skb);
> > > > > +                     kfree_skb_reason(skb, SKB_DROP_REASON_UDP=
_CSUM);
> > > > >               } else {
> > > > >                       udp_skb_csum_unnecessary_set(skb);
> > > > >                       break;
> > > > > @@ -2002,7 +2002,7 @@ int udp_read_skb(struct sock *sk, skb_rea=
d_actor_t recv_actor)
> > > > >               __UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udpli=
te);
> > > > >               __UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite=
);
> > > > >               atomic_inc(&sk->sk_drops);
> > > > > -             kfree_skb(skb);
> > > > > +             kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
> > > > >               goto try_again;
> > > > >       }
> > > >
> > > > From a quick search for UDP_MIB_CSUMERRORS, one more case with re=
gular
> > > > kfree_skb:
> > > >
> > > > csum_copy_err:
> > > >         if (!__sk_queue_drop_skb(sk, &udp_sk(sk)->reader_queue, s=
kb, flags,
> > > >                                  udp_skb_destructor)) {
> > > >                 UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, i=
s_udplite);
> > > >                 UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_=
udplite);
> > > >         }
> > > >         kfree_skb(skb);
> > >
> > > Right, I was unsure because of the conditional SNMP updates.
> >
> > That seems to only suppress the update if peeking and the skb was
> > already dequeued (ENOENT).
> >
> > Frankly, we probably never intended to increment this counter when
> > peeking, as it is intended to be a per-datagram counter, not a
> > per-recvmsg counter.
> >
> > I think ever erring on the side of extra increments in the unlikely
> > case of ENOENT is fine.
> >
> > Cleaner is perhaps to have a kfree_skb_reason inside that branch and
> > a consume_skb in the else.
> =

> I think it should be a  kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM)=
,
> because only one real 'free' will happen, if two or more threads were
> using MSG_PEEK for this packet.

Oh right.
 =

> Using a consume_skb() would be racy, because if the skb refcount
> reaches 0, a wrong event would be generated.
> =

> I will squash in v2 :
> =

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 39c3adf333b5f02ca53f768c918c75f2fc7f93ac..d0bffcfa56d8deb14f38cc4=
8a4a2b1d899ad6af4
> 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2117,7 +2117,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr
> *msg, size_t len, int flags,
>                 UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udpl=
ite);
>                 UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplit=
e);
>         }
> -       kfree_skb(skb);
> +       kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
> =

>         /* starting over for a new packet, but check if we need to yiel=
d */
>         cond_resched();
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 3a0d6c5a8286b1685e8a1dec50365fe392ab9a87..024458ef163c9e24dfb37ae=
a2690b2030f6a0fbc
> 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -586,7 +586,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr
> *msg, size_t len,
>                 SNMP_INC_STATS(mib, UDP_MIB_CSUMERRORS);
>                 SNMP_INC_STATS(mib, UDP_MIB_INERRORS);
>         }
> -       kfree_skb(skb);
> +       kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
> =

>         /* starting over for a new packet, but check if we need to yiel=
d */
>         cond_resched();

Sounds good. Thanks Eric.

