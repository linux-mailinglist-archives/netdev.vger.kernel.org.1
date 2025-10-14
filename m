Return-Path: <netdev+bounces-229074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3794BD7FA5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B49A3A96CE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE311F5827;
	Tue, 14 Oct 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uECDcAbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2736124
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427811; cv=none; b=PFYt7QyDt4ZiYu62sJqnQXNrLh/1a9mpYgA4KBnubSWXCIynCz+fUy5aFQEVu2aSl6OuAjcr0USzIWYEz92t5CQitsN6vLmqyzMAjsNrwaDLTcZZsC5dNR03ioOMCXO2SthCXBvZvEOKaT7lMAVuQvnrfhw5ZP6eMQWRLJZbmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427811; c=relaxed/simple;
	bh=42P1kCG7sKFMRUcGQewaF3DOUWQg9RO73Qyc0dUZybY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV7Md8Mg6BiOeBUJbpncXUXFDKOk2TW+IbdMoS4UFWXucFt2nIwZRrGTZK9/dYRXs7hk5n1SoCyapEo2NqcwNW/bLJRH57/3t54/mGym07DqIJrzv4p2oI3pCR50DxAUqZlEZPVHNUzkXM/u1O4FYXkCIPpCUVlL4jwZwo4q9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uECDcAbw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7ea50f94045so74295606d6.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760427808; x=1761032608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j8ZumiiE6yqqT31yE8qQmGQWZVs7OruvschjBNgluA=;
        b=uECDcAbwpRYX6HCeVPQ8Gxv0Yp2GMTB0du5OmfZde+YhfzWBbpkdz9tm7FpZyE2j0K
         94qgscPMbmCLaiC6ljNzKMAAmLZQnYSQev7VRCOeoUtmVI1t2shBjhoEopc9UXdjhnJw
         MzO824fDpbr7+cA/pSB7TVApk8RUlinaiI8MzWOWbjM93D7eR/NaVjjxmJyVBXALSmiM
         Q7WD6alofBluu54LhnvncvnnofSvDfhSVNReJdk7QW0Wv0r+Yx1sy/1Y3pz8xHthhOZU
         kAMC1/Rv9BK/DbvdYq5GhQIWtV5VW+0nipO0Lqw6lXsHZZPCEX9gIeRXZDbusru71Bmf
         zv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427808; x=1761032608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j8ZumiiE6yqqT31yE8qQmGQWZVs7OruvschjBNgluA=;
        b=RQqBg2UIdWdWX2VOHQBh7pXBsvtxHd8pG1w74ya1TS21JgrImKZ4TDNvjHnj8//shX
         8/iN6xwd8LNAswvw44m+zVaVbzPU9upO77n2FY1oeZZfuZKuBLZMzfEJezGSJ7ej6ZEl
         xAIO6G1M6nXk9nUUEb2Vm4xCeemWbbJnbH67vag7SEPD77UnI0QpaRWt14EmKEM26NbZ
         eY6DpzMOp4I6u/iZYwgz2YsjGYUrPce0lnvzz8cZyhheYZoa7QW+3ZP67aC03+eC0TlK
         vUAKjfEcJwoIWq5fHLQSAcF65dGdlMLYgu4xE4x5oi0xCDrrnl4biq5wyFsiJj9sPuzI
         JXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWEuk1N29/CZAc9a8YLh2BEGKqLeCf7aJcZCNi+Kc1ZYaB04va9NAZ56t/I+hkNrF10ej8hxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6RrL4ymCz685x97tpCd9K/6nk7RlieFWdbVuFDncxqy7QjMhM
	zhhD98wnvtutBBEMqMdFQFErAJachqJE6WCjNnVTQG1LcLhY6RzkFGasPXZwL69xEfplLz6S4qR
	RghpxxXAvXYHnljbIHGYAIDd3EjRJop9BwAjbLBCj
X-Gm-Gg: ASbGncvuL57EiZb04TrUH3oH1f/nYkCL8ap9RL7rOSPGPQu1lP2WqGEm4P3QFCxAU1q
	ECo4JLNAo2jm34hdkIVJOXEtckPXbXWTU/pc/G+5s0MZp6vPcitwnEJvJYZiesPfIsORJcX5e7E
	RYA3JKlhQrKcCkyU0c85ttG5Y0RbOjqi1CMHbWqvZSCfssBLkjig1sAWEAX1fK77k/XWY0ApdAB
	/hX1VtF8qKfkv25FxJWK3vc5QYcYMb1
X-Google-Smtp-Source: AGHT+IGFHCDzjk/fI0j/642hi+8sVnDx4OuBWsZOpwRpgzWF7o8PPfSJhhDGHJ7k08TXra4JLeYbY41BRe9dkAwDEk0=
X-Received: by 2002:ac8:5d87:0:b0:4e7:24df:920f with SMTP id
 d75a77b69052e-4e724df9439mr80099421cf.27.1760427808070; Tue, 14 Oct 2025
 00:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014060454.1841122-1-edumazet@google.com> <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
In-Reply-To: <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 00:43:16 -0700
X-Gm-Features: AS18NWApnIRWtWh0ZQGp1kO7jvlOrNAT999dvRQbZz4Vv68xutYuSslivT00kck
Message-ID: <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive queue
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
>
>
> On 10/14/25 8:37 AM, Sabrina Dubroca wrote:
> > 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> >> Michal reported and bisected an issue after recent adoption
> >> of skb_attempt_defer_free() in UDP.
> >>
> >> We had the same issue for TCP, that Sabrina fixed in commit 9b6412e697=
9f
> >> ("tcp: drop secpath at the same time as we currently drop dst")
> >
> > I'm not convinced this is the same bug. The TCP one was a "leaked"
> > reference (delayed put). This looks more like a double put/missing
> > hold to me (we get to the destroy path without having done the proper
> > delete, which would set XFRM_STATE_DEAD).
> >
> > And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
> > x->tunnel as we delete x").
>
> I think Sabrina is right. If the skb carries a secpath,
> UDP_SKB_IS_STATELESS is not set, and skb_release_head_state() will be
> called by skb_consume_udp().
>
> skb_ext_put() does not clear skb->extensions nor ext->refcnt, if
> skb_attempt_defer_free() enters the slow path (kfree_skb_napi_cache()),
> the skb will go through again skb_release_head_state(), with a double fre=
e.
>
> I think something alike the following (completely untested) should work:
> ---
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 95241093b7f0..4a308fd6aa6c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
> sk_buff *skb, int len)
>                 sk_peek_offset_bwd(sk, len);
>
>         if (!skb_shared(skb)) {
> -               if (unlikely(udp_skb_has_head_state(skb)))
> +               if (unlikely(udp_skb_has_head_state(skb))) {
>                         skb_release_head_state(skb);
> +                       skb->active_extensions =3D 0;

Wait, what, skb_ext_put() can not be called twice ?

Because we prefer not dirtying skb in skb_release_head_state() ?

Perhaps add a big comment in skb_release_head_state() to avoid mistakes.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..8d274ddd54ad4c59cc29f821fc3=
71c89052bf875
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1141,6 +1141,10 @@ void skb_release_head_state(struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
        nf_conntrack_put(skb_nfct(skb));
 #endif
+
+       /* Note: we do not call skb_ext_reset() to avoid dirtying
+        * a cache line. Callers might have to clear skb->active_extensions=
.
+        */
        skb_ext_put(skb);
 }

