Return-Path: <netdev+bounces-78661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D958760DB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FB81F21D92
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8074EB33;
	Fri,  8 Mar 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1UwDKtL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC9524C3
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889711; cv=none; b=nNHtUxbWbbUMI7DbDfvkBsuLtK7gcWJrEDcSPNiQDPJXpBe+rzXngp7oTRTH+7CrmjZifUwQ6Kxk4O9Ij7438UPmlBSyfQ/WMqHmosKiU6Kk3vmRs/KrzTEM7yq1RlgWCTpDBfcGCiiDHZtGX4lktyXy8wrU0fn5EMxEuJVEQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889711; c=relaxed/simple;
	bh=N/oj1/W/akq0Z+nes2NXCpwl0RnQLHgb2Z6uCI8NyQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTYaWFBJpYS9u5Q+mw4dRQU+c+w51iq8NRHyT5BbHfJ49EapJkE9Uy9yjElpbChEB9nHSNxwO/remK91V3ueHg08BSVXFkYAD4wPerwGARCUejggj3oVFTIlJXQQykGM1WnVgneytxxB1VhB72Brrh8YDhB6aooKlOmVRN3KRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1UwDKtL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5682df7917eso5114a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 01:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709889708; x=1710494508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaBAE8rznBKSCbfCBUBhKMUoV24PKPkaVPHJNA9r4C8=;
        b=O1UwDKtLWTACzGMD9542767tjJ+o3Mn5HfQuWbac7gI+PWo8T5xm+Dp3bAzTIzXvw/
         RJy/uGAkKcB3SneXEDGlyVFeJkz7EyWRNPyyb3Yp/0/i12ffQodlbNZQwg+39PF7hAS6
         SbIDqXmpIWjf8slsC80A07Gts45RgHmqCCKS4VjEIT31IXkZDdYJo12obG3r2crXQNRN
         H8cDhWzJRtFmKlx4cnoSNanNkcbainwVsYl58wCUFeYz9650yo+0SW59eZEvRyrvKYYJ
         ED5Y/4oMLFCE8gdCDB9uQfCvfjcke8pCz5Uqrb2LHiSFu0mEjgQ1YKYe4YqE7Yd9rUwP
         42rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709889708; x=1710494508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaBAE8rznBKSCbfCBUBhKMUoV24PKPkaVPHJNA9r4C8=;
        b=efh/a1dgAxEDYhSRJ6208Km17t+zQRuCsmPg/QucarqqydJSY5J1JCtofvPHw6vMRL
         QH51fz+kNdomWIRJeEkOl9JmghvJPZ9xnaUwwd47I/ZhdtQZGAwJ5taEWfyyuLqP+9PU
         P+9e+E7kXsiLlJ69VQBIhodTL9IfYwFW32JKEKLY+QjbyiueaOhoDxClC7+K3Bcn1WSA
         V0yKHa1w+HoNP+Ws5W4fOhpKs3NBEOrMP05QWLtOMjyRK/ynLhNZT9FbBq/baZScLgZ/
         +5ftIgmdrWnCWpKt1zg6K13kRWUtJK9bIesgs1lvA83pdRdlTBdXC4TSRe/YDZvvjjEy
         FoJA==
X-Forwarded-Encrypted: i=1; AJvYcCW5/u5qVQTAVIQNyZmpY2UlAleOdZm/RPoH2tRnQe9iOGVukahOPLAOkkTWmMZvpSG5GQVSFG/z7Uk23/HzTGICyPtGy2gu
X-Gm-Message-State: AOJu0Yzyhe6FvF0z+9IIobDtxBpsn5lMo9MYO23kTyDY6vOBsj/DuX5w
	XgYmyPgeaXNq0hG6Cs0pzgbHvIUBSfjrUFLwJn4Jt8sXEoDtUF0cv2a62h21Mb9IfYjJSRq1IAo
	PtQ3T3QGkkpAinpGMp90elMMFKRVy0VrinvUZ/TTYgjP9BAls3Q==
X-Google-Smtp-Source: AGHT+IFNWbYLqv5gOk+zQPrb4n3YgvkJV+pfVUXBNnVrhcNdvm7T5fdwV3HGnl6yZnlAlp7mUs9TRqYOpEfi6O6pTnY=
X-Received: by 2002:a50:ee90:0:b0:565:ad42:b97d with SMTP id
 f16-20020a50ee90000000b00565ad42b97dmr423504edr.0.1709889707456; Fri, 08 Mar
 2024 01:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307220016.3147666-1-edumazet@google.com> <d149f4511c39f39fa6dc8e7c7324962434ae82e9.camel@redhat.com>
In-Reply-To: <d149f4511c39f39fa6dc8e7c7324962434ae82e9.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 10:21:33 +0100
Message-ID: <CANn89iJ+1Y9a9DmR54QUO4S1NRX_yMQaJwsVqU0dr_0c5J4_ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: no longer touch sk->sk_refcnt in early demux
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Martin KaFai Lau <kafai@fb.com>, Joe Stringer <joe@wand.net.nz>, 
	Alexei Starovoitov <ast@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2024-03-07 at 22:00 +0000, Eric Dumazet wrote:
> > After commits ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")
> > and 7ae215d23c12 ("bpf: Don't refcount LISTEN sockets in sk_assign()")
> > UDP early demux no longer need to grab a refcount on the UDP socket.
> >
> > This save two atomic operations per incoming packet for connected
> > sockets.
>
> This reminds me of a old series:
>
> https://lore.kernel.org/netdev/cover.1506114055.git.pabeni@redhat.com/
>
> and I'm wondering if we could reconsider such option.
>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Joe Stringer <joe@wand.net.nz>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/udp.c | 5 +++--
> >  net/ipv6/udp.c | 5 +++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index a8acea17b4e5344d022ae8f8eb674d1a36f8035a..e43ad1d846bdc2ddf576760=
6b78bbd055f692aa8 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -2570,11 +2570,12 @@ int udp_v4_early_demux(struct sk_buff *skb)
> >                                            uh->source, iph->saddr, dif,=
 sdif);
> >       }
> >
> > -     if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
> > +     if (!sk)
> >               return 0;
> >
> >       skb->sk =3D sk;
> > -     skb->destructor =3D sock_efree;
> > +     DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
> > +     skb->destructor =3D sock_pfree;
>
> I *think* that the skb may escape the current rcu section if e.g. if
> matches a nf dup target in the input tables.

You mean the netfilter queueing stuff perhaps ?

This is already safe, it uses a refcount_inc_not_zero(&sk->sk_refcnt):

if (skb_sk_is_prefetched(skb)) {
    struct sock *sk =3D skb->sk;

    if (!sk_is_refcounted(sk)) {
             if (!refcount_inc_not_zero(&sk->sk_refcnt))
                   return -ENOTCONN;

        /* drop refcount on skb_orphan */
        skb->destructor =3D sock_edemux;
    }
}

I would think a duplicate can not duplicate skb->sk in general, or must als=
o
attempt an refcount_inc_not_zero(&sk->sk_refcnt) and use a related destruct=
or.

>
> Back then I tried to implement some debug infra to track such accesses:
>
> https://lore.kernel.org/lkml/cover.1507294365.git.pabeni@redhat.com/
>
> which was buggy (prone to false negative). I think it can be improved
> to something more reliable, perhaps I should revamp it?
>
> I'm also wondering if the DEBUG_NET_WARN_ON_ONCE is worthy?!? the sk is
> an hashed UDP socket so is a full sock and has the bit SOCK_RCU_FREE
> set.

This was mostly to catch any future issues and related to my use of sock_pf=
ree()

DEBUG_NET_WARN_ON_ONCE() is a nop, unless you compile a DEV kernel.

>
> Perhaps we could use a simple 'noop' destructor as in:
>
> https://lore.kernel.org/netdev/b16163e3a4fa4d772edeabd8743acb4a07206bb9.1=
506114055.git.pabeni@redhat.com/
>

I think we need sock_pfree() for inet_steal_sock(), I might be wrong.

