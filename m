Return-Path: <netdev+bounces-206032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C233B0114F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 04:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DE31C24C6F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7E18A93C;
	Fri, 11 Jul 2025 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVEyvQwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6A185955
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201571; cv=none; b=n+psw6zZ9H2OTfi3QJo53FwFvWYVIb+00USzgfxubaN/+EsRIBc7irJoi9GHx4kHR9MfIvWGJIcZCcPZR284OG0zlaNzz6hxQQ7VtsENoLZDWsnph8kWpGSmR+qR0GubnpMiPLQ7zRLM4ML64jfKMZJKqn/kzpQ0sMJjZ3YKplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201571; c=relaxed/simple;
	bh=KgGRC5RoNcM0kSr7oGDRJgAEFtUY3NCUMt+gWjWaNFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faOXnIJ7EtM1V3QGajbE6SxQgFabwxXPKwCREzIZUOwMxAE1ZjyBI9uyzJv9reMrFrmefqjXcy929eqSKsdMDL2FiZCCz1wGR30kgvlQFWiC+dCOSnBKYDAmFE8WXTjZnfKzwILiRLw8Y5jT+vu47ZUZQSj8DqoZGcQ4htWdguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVEyvQwC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31c978688dso1037095a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752201569; x=1752806369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZL5PFrII+eMnthqSWAjFrcUUl74o/UEzDavdEnu3s8=;
        b=jVEyvQwC+l9VifjEU+ie7ZD9nehjh3C0OLG1LRp70okJls+khCBuokxmnPVJZAVSTP
         ftMlYd8Kr6Bm0N6axH217PehsCnFAnGwdCY0RweM3tp9gAEfpN50XHkxlq5cdb2/oFmr
         /5Z+0yBs2XZyLpm/OGu8FBhlQkJnmLzUsxznRSzWVY0VxF93Tl9NUsfJd8no3Z7yaWlS
         KartHZ0mxdESI/GomAkA+eES+SVA9duaXdLxM5hfIUASdJr8i5KEbjz1UTbCYmaYGYDl
         yhhAJJf/d0IK4l/HLswrGUZ1lyWSyn5pi44QO2JbyTNKTFK9uOYaUZPtM7qnTSf6+Mk8
         yM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752201569; x=1752806369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZL5PFrII+eMnthqSWAjFrcUUl74o/UEzDavdEnu3s8=;
        b=TLx54u+DKGYdLQlGkVQjxKybZskNgtRHisI1z+dU1p/J1sfMoGKk8mJ0GXbAvWpUMG
         8Tq6ro6pf6M3qkUU/ArzZBmeDtaHUDvybLIaVY0l6H5mQpjBgl2f0/lJyZrT0U28NiDg
         OAhj/nTqBTS5Bjy+r6BdJ35TPSsz0oBdye+1bSuy5Y0xrrjmYTcCMUTEdsbnUO5ikcq7
         ATApaabhFzTJoIAo803yKIiPepBdvbo3XJhOOAEf+0aCScve3ndGIgff39cm2+ShmD9h
         jqwcDcudvOC55VhIYiCzkgvuDwzBeYJGMSyVCgUUC9usTHZHQFlXiNB4DfAdKuGNHP6Z
         dzLg==
X-Forwarded-Encrypted: i=1; AJvYcCVNMdzshIQ/pKoGJ/7fJrED3SoK2WeM6/NmoUAJLatpFJNTC/3X/pWed9eCWBjEHdEKmo/AKn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzRDRl9NgKKV62FSZzjh1IbHuV7WHL92AY+n+CAnYwEhRAk1+
	ffByhnwszei40n84uMXCiugpVzQHiKPOCPYrPBVwXsXoir04acm8vKLqoOtuXEM8LQsIaJan7lg
	Rv/8vFVD8qVm5EoQIO0w5vvz+7sT488wnpQmvByLN
X-Gm-Gg: ASbGncvfzemFip8e+7O7W7Di5Muz9L4wx4Fu9Ndv/gkNB2fQGF6DTvhMUwg0x2oTzSG
	P7/QGatPmU9ErfMj/kKU7c0zHXOwXvGeee84oNA50wMsMTWhsCMqWoL7p0wx8+mLDurJYHPAPMD
	j/rYcgqK1cF9CCSkHMAa0qnIlTraFF9O4xr7QWg94Kg4V9ADjkA+TKCdB9C7KwPO2fEgm4IJqOl
	HaDkJetuIt/v0w5cRXkRWFJ0/d68SfCsPYLkIrDCSt2W6IPUps=
X-Google-Smtp-Source: AGHT+IEjAbHUx9oL5gKdiuOHQyBImqx/LHOoACB8q/e9Hx17czomqGQuOtyvho534tz+IEFlaq+AL00qAyHn52j688Y=
X-Received: by 2002:a17:90a:d88f:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-31c50d7b0e2mr835773a91.8.1752201568569; Thu, 10 Jul 2025
 19:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711001121.3649033-1-kuba@kernel.org>
In-Reply-To: <20250711001121.3649033-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 10 Jul 2025 19:39:16 -0700
X-Gm-Features: Ac12FXxiXJQ9-97tcaym3-Pb9NEG02NWjGIJXctEgilcbMyHy4GR3IUU-uki80Q
Message-ID: <CAAVpQUBAC754ht-EJJpcBBf3HB3h_W500KFeUgtUPpm2AmmDkw@mail.gmail.com>
Subject: Re: [PATCH net] netlink: make sure we allow at least one dump skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Commit under Fixes tightened up the memory accounting for Netlink
> sockets. Looks like the accounting is too strict for some existing
> use cases, Marek reported issues with nl80211 / WiFi iw CLI.
>
> To reduce number of iterations Netlink dumps try to allocate
> messages based on the size of the buffer passed to previous
> recvmsg() calls. If user space uses a larger buffer in recvmsg()
> than sk_rcvbuf we will allocate an skb we won't be able to queue.
>
> Make sure we always allow at least one skb to be queued.
> Same workaround is already present in netlink_attachskb().
> Alternative would be to cap the allocation size to
>   rcvbuf - rmem_alloc
> but as I said, the workaround is already present in other places.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/9794af18-4905-46c6-b12c-365ea2f05858@samsun=
g.com
> Fixes: ae8f160e7eb2 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for the quick fix!

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

> ---
> CC: kuniyu@google.com
> ---
>  net/netlink/af_netlink.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 79fbaf7333ce..aeb05d99e016 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2258,11 +2258,11 @@ static int netlink_dump(struct sock *sk, bool loc=
k_taken)
>         struct netlink_ext_ack extack =3D {};
>         struct netlink_callback *cb;
>         struct sk_buff *skb =3D NULL;
> +       unsigned int rmem, rcvbuf;
>         size_t max_recvmsg_len;
>         struct module *module;
>         int err =3D -ENOBUFS;
>         int alloc_min_size;
> -       unsigned int rmem;
>         int alloc_size;
>
>         if (!lock_taken)
> @@ -2294,8 +2294,9 @@ static int netlink_dump(struct sock *sk, bool lock_=
taken)
>         if (!skb)
>                 goto errout_skb;
>
> +       rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
>         rmem =3D atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
> -       if (rmem >=3D READ_ONCE(sk->sk_rcvbuf)) {
> +       if (rmem !=3D skb->truesize && rmem >=3D rcvbuf) {
>                 atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
>                 goto errout_skb;
>         }
> --
> 2.50.0
>

