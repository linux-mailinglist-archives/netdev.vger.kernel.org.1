Return-Path: <netdev+bounces-172586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AFFA55754
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18DC7A6ADB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0D2702D6;
	Thu,  6 Mar 2025 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vd00UXZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF842A8C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292109; cv=none; b=j3IaZO5dIUMH9E5xyw3/258YlYxYmPG7ZGzVDOx156bSmEBwstJSCLDKPali71CV4FvtmHPsfHDmMdWYEYirBuIfBRWtSibTNpmRrpJgaDHYMprpeQMv91o+0bTywzlVPOy8/aun/96aemkZ5BS+xHC9T/Efcc62y3LwtZGDQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292109; c=relaxed/simple;
	bh=bFJMZEx96Ql0Kw2JTwB7c9FTIFV7IfnoUuBTspqGm8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNq54t3MqvnEt0eB8XF2HEBY8n6IXsbh+h5Noo3+55kpkuw54QqqomEjG7BcAaJsvCYeFCztD4fwthIpSxYaKO0klIo/g6/8k4pDPgiWwrqtrOZAnsOzYfZ/OZzdWSnm/ngJu0/1YqVMIOqpvBds/1CP2SyFRI20gyxwBCCKXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vd00UXZF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so7822716d6.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741292107; x=1741896907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ef1Fclr81ZVjX9jtguwD6ejsAi9gXl6B/HalLOlbJE=;
        b=vd00UXZFgjicGk7x6jFk5vMZDIRBYERGu8waLJ4YduR3+uK/AU+yb/MeKITARiXlvR
         KXLBEJaic4CTmQUzGdwGz/H/TqbaZZqcvldiOI5v6D3tG9rIUJ9Wl+uQyiEHU7AP+QsJ
         IBmNP4TOLR81bkfqHINho1W6rSjmq3SpOsf+B/T5aK2Ssy8TayeHqPoVF0ZGXXuy7xvv
         f2n40hXCzhN7Z2Laq8jQ+zVXPkR6umIu5g69wpnTC9D45FdCXlRBSBGtIRLNUhyDSSdY
         zXXaSARHDabZPOPDV9gyGODytShUHUQiFBLl/5Xtc5b3joez+7cgs/zH0rq8XtezU5C9
         FahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292107; x=1741896907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ef1Fclr81ZVjX9jtguwD6ejsAi9gXl6B/HalLOlbJE=;
        b=RBwfGSECuzEdBpDXoBHzSXaZQS0EmhVn5R4YrJK2JYyopwVBR7/1morDdd4EZFnnlb
         2fvw52+10V+bkiJ65AQvyk5dATJAAAAQgd/LHjbsbYWdRLkd+kOuhX+q5BaeHI+h4tFp
         +L+Fixld1rmspkxfOyNGhOprxYgaZzd8reWEbJPmj+WCNqyPNI7ZDvAH3x9buZjlmfOZ
         Wfjc86bGYYUMeeGpBsZuJwUMeAGQIV2bK/mSwTFGbLTj2wqULixOVcy7Le0quQreGNDU
         WrbOHpn21eewHuwyDd3NbGxd6018SAZ+rk7Paaf+ITLrahi4N1uY6cob5elQt/4sckqS
         P4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7oWUEfZibHRgbL6oNM3VTg2rmQsH+GkroMzT2r7V1NoD4yarlZBiWsvA2V6EL3jEOlzhbVHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDjlsMmYc3qZkgb3/NmcroUjD8bjKLYGDXvRMRe0PPaaFScAx0
	ssRy3r03QU5ujmMQwYZN8kC1ZHwj8txWB/SGOOfL+R8rNxcBgc6ApJoBv7IpK4QyN3jlZQYSj4t
	6rH5NI82nJQt3OR5iTCVhNZyFULKc/6ZkiBie
X-Gm-Gg: ASbGncuRiVBB6e/XDxwDulnBFVWKch1WInUQKoJ9dc1H2pcRXzWmENvGR/Uif5mZ/im
	crIHd4WsoHJNscf/HQmepITHtINfkKe3Rb6cCXd58KjGoW4t5iLBMANQm2WvEWMB9V9ugr2CVvK
	ZzVuurA42m+qMSLmYYCe2wgDYlV8U=
X-Google-Smtp-Source: AGHT+IFCiBiyWAF0ulMN+ynaK89LvEOVytGQ+T63z3mZ2mLUyORRge8r1OlqdCFMq8wWxIzfrv1gyhxtD13HjGM6k7g=
X-Received: by 2002:a05:622a:18a7:b0:475:531:9b1a with SMTP id
 d75a77b69052e-47610952122mr6471131cf.10.1741292106764; Thu, 06 Mar 2025
 12:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306183101.817063-1-edumazet@google.com> <67c9f10e7f7e8_1580029446@willemb.c.googlers.com.notmuch>
 <CANn89i+QnSwxB33Hp48587EWAX=QYY0Msmv_bkfe_C1amk8Ftg@mail.gmail.com> <67c9fe2af078b_1bb0a2942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <67c9fe2af078b_1bb0a2942a@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 21:14:55 +0100
X-Gm-Features: AQ5f1JqcIMqOYBntvHmSZWFbOH1XGOHvpKENIdz2AqvrhL5sAGxKn1ELxfsc690
Message-ID: <CANn89iJi5GsaK6ZbuuiMDpHsWxj9fbAEG5Vj0CzoJeWFJvpj4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 8:57=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > On Thu, Mar 6, 2025 at 8:01=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Eric Dumazet wrote:
> > > > Use SKB_DROP_REASON_UDP_CSUM in __first_packet_length()
> > > > and udp_read_skb() when dropping a packet because of
> > > > a wrong UDP checksum.
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > ---
> > > >  net/ipv4/udp.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > index 17c7736d8349433ad2d4cbcc9414b2f8112610af..39c3adf333b5f02ca53=
f768c918c75f2fc7f93ac 100644
> > > > --- a/net/ipv4/udp.c
> > > > +++ b/net/ipv4/udp.c
> > > > @@ -1848,7 +1848,7 @@ static struct sk_buff *__first_packet_length(=
struct sock *sk,
> > > >                       atomic_inc(&sk->sk_drops);
> > > >                       __skb_unlink(skb, rcvq);
> > > >                       *total +=3D skb->truesize;
> > > > -                     kfree_skb(skb);
> > > > +                     kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSU=
M);
> > > >               } else {
> > > >                       udp_skb_csum_unnecessary_set(skb);
> > > >                       break;
> > > > @@ -2002,7 +2002,7 @@ int udp_read_skb(struct sock *sk, skb_read_ac=
tor_t recv_actor)
> > > >               __UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);
> > > >               __UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
> > > >               atomic_inc(&sk->sk_drops);
> > > > -             kfree_skb(skb);
> > > > +             kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
> > > >               goto try_again;
> > > >       }
> > >
> > > From a quick search for UDP_MIB_CSUMERRORS, one more case with regula=
r
> > > kfree_skb:
> > >
> > > csum_copy_err:
> > >         if (!__sk_queue_drop_skb(sk, &udp_sk(sk)->reader_queue, skb, =
flags,
> > >                                  udp_skb_destructor)) {
> > >                 UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_ud=
plite);
> > >                 UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udpl=
ite);
> > >         }
> > >         kfree_skb(skb);
> >
> > Right, I was unsure because of the conditional SNMP updates.
>
> That seems to only suppress the update if peeking and the skb was
> already dequeued (ENOENT).
>
> Frankly, we probably never intended to increment this counter when
> peeking, as it is intended to be a per-datagram counter, not a
> per-recvmsg counter.
>
> I think ever erring on the side of extra increments in the unlikely
> case of ENOENT is fine.
>
> Cleaner is perhaps to have a kfree_skb_reason inside that branch and
> a consume_skb in the else.

I think it should be a  kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM),
because only one real 'free' will happen, if two or more threads were
using MSG_PEEK for this packet.

Using a consume_skb() would be racy, because if the skb refcount
reaches 0, a wrong event would be generated.

I will squash in v2 :

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 39c3adf333b5f02ca53f768c918c75f2fc7f93ac..d0bffcfa56d8deb14f38cc48a4a=
2b1d899ad6af4
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2117,7 +2117,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr
*msg, size_t len, int flags,
                UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite)=
;
                UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
        }
-       kfree_skb(skb);
+       kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);

        /* starting over for a new packet, but check if we need to yield */
        cond_resched();
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3a0d6c5a8286b1685e8a1dec50365fe392ab9a87..024458ef163c9e24dfb37aea269=
0b2030f6a0fbc
100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -586,7 +586,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr
*msg, size_t len,
                SNMP_INC_STATS(mib, UDP_MIB_CSUMERRORS);
                SNMP_INC_STATS(mib, UDP_MIB_INERRORS);
        }
-       kfree_skb(skb);
+       kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);

        /* starting over for a new packet, but check if we need to yield */
        cond_resched();

