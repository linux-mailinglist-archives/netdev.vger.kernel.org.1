Return-Path: <netdev+bounces-228960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2EABD696F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B0414E28E0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B02D8371;
	Mon, 13 Oct 2025 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHEDEbi7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376C1EFFB7
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393593; cv=none; b=jnQAGGye6v3Cok/ZR+y4CICZL+wDX7lxRUWPBh+aRHruDwIwPLYIyV4wgyzzrKmlieqADbbCbIUri7hDD8RbVvERVwA4OHCyYE36kAg7NYKOTQwo7u5kEQqRUvulFc34QAn88xI4Fq3KjHcf9Qq47O7jIxTUx9q2N//cNFD+1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393593; c=relaxed/simple;
	bh=4Molk1xkkd1VQX5HCIs/3EUOUQw+tGBcpgfsCvKlqlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isGQ0X5CqSHaRZShvzTCQ2SgVNioYWhEP9mkuCMXUI/ZmlQrOodv4cKSPgRNPEAdJfrWHcsRyZlrd3Gy9RY1o9B7xbXFXX1l/nPUprCBuV0cOsuiVEw8twQ9ZeRg5TuFXuL44NSe4j+9Bq+VL33nFViuah0oGxbF6FCbFUKC2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHEDEbi7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f04816589bso598711785a.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760393591; x=1760998391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTW8zWCmhkFsDvHLEmtdWPR1um6YpvYBI1AxP2w3ASE=;
        b=zHEDEbi7/sRIzQA1xaaIrcQ2otcT/8Me/XNJwo+EqbDiDzXg5zKNa1RJ2X4xsQkBKK
         VJ7yVYFiDkxwCevCdcEps87L7DGvjHzhwlo+21M84jg6+qxwqv7flhPxBKaja2TkRbgz
         ZSVEv9BJDmiEKk0WNmCZ5gw0BAyeWcARr1YCbE4hN8wYlqHJkkYVNufsvXL5d7LQGnD+
         80ShPjcEygeTFAM1ny5PPO9f1+SHHhBB8FStftP8kg+h3dhVecpTK+ejYYVxwQyyq5Ki
         HKTbkJqJMoD9QVHrNM85PkZmjzOW5pluOJEFBuvNoFfXqVqa03cK7Ccw8WP/7EwzBiW9
         KLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393591; x=1760998391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTW8zWCmhkFsDvHLEmtdWPR1um6YpvYBI1AxP2w3ASE=;
        b=n91sOvfJgmh7IGXt68h83pQjMYa5v/XGRj6bMvN3BQbF5sMc5LO4PL40+IJjggwQhG
         bsjNxzf0bnkT8I1xV0MhaSp2Wx35hH93vIra8YrL45xFb6d/x78wCDBdYdtP6KiO9Igf
         zMGGp2YsKclg4ezqDmT46hEJ0IABEoS/Vi1ZPgjAbdr8TdeX3hSZdpvHOiSMsm5sfG7w
         cAbuR8h9CUrbK8VYpfLm7c3piOCKRKx6p6ePin7pq5FdNJ7K71zi2VAjHAHaf3lyLJcb
         PZ9Yj2Sn4J+Q0qnJjkMkMYT0hQS5S9CIXMFRxw1xAwdZsh1IsaujCnh4TawLUgF1E9kM
         Z0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXvh+TZGO1OZ9ksa8SHwf6xZRVygv8niY/9SDpC1aa42Z4OTVdMVCjptlHWBUhJqc7VF2xM5qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjVpOHUxjN8KXNjUvRY7j2KSnJ5NAXIGInLOfBoWqlAg51iNg
	BxZB8PlRpZG2aoAlHYl9JAe3IqRyiM50xFyipit66r49hLJt9OuOLzh5EFJNYncKEEtNClZ4NTS
	AA1aNTnS9KCk7v6UL4TYeOCtFNw6KPbedB3lfdPNY
X-Gm-Gg: ASbGncuwvgcMOyo6Z+VUA5OR+JvvZz/BPszPkBGjmgNf1GMz9v6STOPTGX365uZr9lk
	+TEmxzb12rz/1SD3Uw75dZhKX5liD4qBDMIIoorUUr1Cs5PhpZCuYsMGCSKrYRy4Xm+3aZaU9Vx
	PeT3fcLzdoTiDo5Sw53eFB4gEU2RbdbZzeKpYFyTtjxYdTGwgH8wLJUysEQGAvI9ydr9EVDV4sE
	idtZYurSpbzXzguZ2Z8wuw98/p3eRO3
X-Google-Smtp-Source: AGHT+IG6XoB2yZElg7Hp3Rd27M+VPGZTqyHZsG4HxEGCGEXKfcKKJAzFnddJeVlt3TN4naLKs0ISTI/oDZZzzuRQeCA=
X-Received: by 2002:a05:622a:554:b0:4d7:7dc3:19f0 with SMTP id
 d75a77b69052e-4e6ead6f67fmr314020721cf.69.1760393590723; Mon, 13 Oct 2025
 15:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-11-edumazet@google.com>
 <gpjh4lrotyephiqpuldtxxizrsg6job7cvhiqrw72saz2ubs3h@g6fgbvexgl3r>
In-Reply-To: <gpjh4lrotyephiqpuldtxxizrsg6job7cvhiqrw72saz2ubs3h@g6fgbvexgl3r>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 15:12:59 -0700
X-Gm-Features: AS18NWAguNlnWcPWN2-ylVLfuInxoDb5FkjNtWmqivpON-p3uz6K0q9aQ825d8E
Message-ID: <CANn89iKN8Efr7VpW5g8Qu_3jZm+6LcvG+9EjZ286hWmF2FRwcQ@mail.gmail.com>
Subject: Re: [REGRESSION] xfrm issue bisected to 6471658dc66c ("udp: use skb_attempt_defer_free()")
To: Michal Kubecek <mkubecek@suse.cz>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:44=E2=80=AFPM Michal Kubecek <mkubecek@suse.cz> w=
rote:
>
> On Tue, Sep 16, 2025 at 04:09:51PM GMT, Eric Dumazet wrote:
> > Move skb freeing from udp recvmsg() path to the cpu
> > which allocated/received it, as TCP did in linux-5.17.
> >
> > This increases max thoughput by 20% to 30%, depending
> > on number of BH producers.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
>
> I encountered problems in 6.18-rc1 which were bisected to this patch,
> mainline commit 6471658dc66c ("udp: use skb_attempt_defer_free()").
>
> The way to reproduce is starting a ssh connection to a host which
> matches a security policy. The first problem seen in the log is hitting
> the check

Oops, thanks for the report. A secpath_reset() is missing I guess.

It is hard to believe we store skbs with expensive XFRM state in a
protocol receive queue.

This must have been a pretty high cost, even before my patch.

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f01b2dc31d9520b693f46400e545ff..dda944184dc2ae260de72a76c67=
038c20b0bae1b
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1744,6 +1744,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)

        atomic_add(size, &udp_prod_queue->rmem_alloc);

+       secpath_reset(skb);
        if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
                return 0;




>
>         WARN_ON(x->km.state !=3D XFRM_STATE_DEAD);
>
> in __xfrm_state_destroy() with a stack like this:
>
> [  114.112830] Call Trace:
> [  114.112832]  <IRQ>
> [  114.112835]  __skb_ext_put+0x96/0xc0
> [  114.112840]  napi_consume_skb+0x42/0x110
> [  114.112842]  net_rx_action+0x14a/0x350
> [  114.112846]  ? __napi_schedule+0xb6/0xc0
> [  114.112848]  ? igb_msix_ring+0x6c/0x80 [igb 65a71327db3d237d6ebd4db222=
21016aa90703c9]
> [  114.112854]  handle_softirqs+0xca/0x270
> [  114.112858]  __irq_exit_rcu+0xbc/0xe0
> [  114.112860]  common_interrupt+0x85/0xa0
> [  114.112863]  </IRQ>
>
> After that, the system quickly becomes unusable, the immediate crash
> varies, often it's in a completely different part of kernel (e.g. amdgpu
> driver).
>
> Tomorrow I'll try reproducing with panic_on_warn so that I can get more
> information.
>
> Michal
>
> >  net/ipv4/udp.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 7d1444821ee51a19cd5fd0dd5b8d096104c9283c..0c40426628eb2306b609881=
341a51307c4993871 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1825,6 +1825,13 @@ void skb_consume_udp(struct sock *sk, struct sk_=
buff *skb, int len)
> >       if (unlikely(READ_ONCE(udp_sk(sk)->peeking_with_offset)))
> >               sk_peek_offset_bwd(sk, len);
> >
> > +     if (!skb_shared(skb)) {
> > +             if (unlikely(udp_skb_has_head_state(skb)))
> > +                     skb_release_head_state(skb);
> > +             skb_attempt_defer_free(skb);
> > +             return;
> > +     }
> > +
> >       if (!skb_unref(skb))
> >               return;
> >
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
> >

