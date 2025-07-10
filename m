Return-Path: <netdev+bounces-205607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F20AFF675
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882EF1C47F81
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6F26C3BC;
	Thu, 10 Jul 2025 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zj56J/Kg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A7846C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752111525; cv=none; b=VBn4ehc+ZLBmrYioZWu40VGkm6fjefPFDC7reZ7xwEWH0ptYfcuggrkDx1SSULjtTAYwjKbSxzpYK8ieWHeO97s+5saLUOc/TPQQ2S5dGE/CK+q+dHtyP1vC/tw9Rqt1xLQeTcMpOuyF8CElsL29jalLhbb+fWN1ueO0Jl5uM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752111525; c=relaxed/simple;
	bh=dhG5r4gGPnPt7Q6mdgZiENB6AdEWFnht3eiASqy1e1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHJd4mtFTIpyXzOvnTqUXNetIbnPsx/1OLxjEeUZoeUycz6zESFebigMNExtrukNmtQ0pSazrLyp/f/4Lov/6KMU/E4wlDSXMBm4PxsvLGspuiBYdPzgkCy1Ebz/BVq7HAYGKuip16slxLxanUSjVEdzhoC+nm6nl4TRV/s65d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zj56J/Kg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2349f096605so5901585ad.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752111523; x=1752716323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An4fnUSNjs3mDky/hECOqjnFt3MHXnn9hr9hH2fPQEw=;
        b=zj56J/Kg+jkjLyqzevTMcSZ7c7v/iVmI1ELTUU28doDviBIlSczLmLfbK8jOT7nZ3M
         xQSHnNv6EiKKwOrE28ZlN2pB+66PXutv9TT4CgQaUXyDvXddrRU1dCB2cYY08QgAmnrP
         CiGBJNyN7OmW/kX23PF6RWgoWp3w8aee3GF+K5/1G2IhTCG1HTmlizHD8xuyHqEGPp6o
         PvWs922Yj3mQX5RJbUD1EvRG83yLAVXavAtlVIoglEvGdDFNZQfLo02U7bOKxGHSRjCW
         nsKHcuEZC93mDF4zNqzxmQfk4vSmool+oKXkPk3WLq5SWrkwl4dDIdNAPSdd/5eb9VwP
         LD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752111523; x=1752716323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An4fnUSNjs3mDky/hECOqjnFt3MHXnn9hr9hH2fPQEw=;
        b=CDhvrg/warNnDBidWu6qPByLZlrBodgaN4TrMF7fppjAEmbGywr1UZAc6z9XhUg+/5
         Nx1fdwv+vSYjkPljiNdzBUXA2ZtpuvBlAUagzpCWRByg7HGH+G+uHfoDa7F6exSdQ+WR
         tJT++o7p/9r5UwMZhfS/7ky1ivuXoK21n1bQaImCG8zlgTqkMDfRvyu3skqo+F0WVmJe
         x3q6JjrFhhHNeLn4NUP0kRC9ZCfsLxeBbuFSG8GF4Q7LZPgU7jItqhtciKCbkd0+wlVl
         QWFeGZZXryNi3Dxvl7NTO7HbrzOtJp4LK72MEO8TwDFB0eNGPwvFEuQvUCpyor+KaSVk
         ZOew==
X-Forwarded-Encrypted: i=1; AJvYcCVXTNGgrb7PU3Y5xJYWINFtnw6cT3TGPcadR2sgQUwbEGkw9FBvlJ/G7pslWFJawp7QKFYXS+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVedpAXAJIOZYI0uF89ToCTMVRFKHTDm46gbsBTMeMWtq4nfRI
	6c0APbG4Yjyebt4XDjoj0X89ArDjY9NxOgAPe15pl3W/0X/gU7GCr3Ysdg1VrUyJdNC4V2U3O6n
	tuwV0LESO+xaPoal9oy8fRTAUQ5J9F34wgG6zxY3JuG1nRDs2esKHBLKVaKJtPg==
X-Gm-Gg: ASbGncuM+PMS+wDdLvzaVS7BvH9HJN8IVTWNpPPo1d3esWs38s8yj+wUgprJwymZAXO
	j4iPhgZPFpzjq7q7LSRoCrqyPdVsvrhD7oE9aqV3tRqkouwVoANOkKxkKHttNPmUSUW1CwxHZEG
	GuJS1mkDlPg03LnCcgEx81otyVwJsTdXG5jTt7fZzE9zSPrLYd68jl8/ebX/s2uyQqGajC6CjU5
	uFXRNvobxnlAQ==
X-Google-Smtp-Source: AGHT+IFLYh3QxPQLnaHXZoBgbuishr9MOu6bbv3Jf1fguHYZG463Zwq9mI2ebtyADJ+uF5r2mgO1J2DM6SwPZ6WZZmk=
X-Received: by 2002:a17:903:1446:b0:23d:dcf5:47e1 with SMTP id
 d9443c01a7336-23de486547fmr9651535ad.31.1752111522713; Wed, 09 Jul 2025
 18:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709190144.659194-1-kuniyu@google.com> <20250709171641.721b524a@kernel.org>
In-Reply-To: <20250709171641.721b524a@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Jul 2025 18:38:30 -0700
X-Gm-Features: Ac12FXyFKgTfuViEDp1k_RQnFW1uUcK3X7oTBHmAG7eRoXUPO8_DezODEtsPP-A
Message-ID: <CAAVpQUAocrVbJTk08_VxThuNpgXAC7Zvcn4OHM6FdNKXbs6k2A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] dev: Pass netdevice_tracker to dev_get_by_flags_rcu().
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  9 Jul 2025 19:01:32 +0000 Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> > index 53cf68e0242bf..fa7f0c22167b4 100644
> > --- a/net/ipv6/anycast.c
> > +++ b/net/ipv6/anycast.c
> > @@ -69,6 +69,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, c=
onst struct in6_addr *addr)
> >       struct ipv6_pinfo *np =3D inet6_sk(sk);
> >       struct ipv6_ac_socklist *pac =3D NULL;
> >       struct net *net =3D sock_net(sk);
> > +     netdevice_tracker dev_tracker;
> >       struct net_device *dev =3D NULL;
> >       struct inet6_dev *idev;
> >       int err =3D 0, ishost;
> > @@ -112,8 +113,8 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex,=
 const struct in6_addr *addr)
> >                       goto error;
> >               } else {
> >                       /* router, no matching interface: just pick one *=
/
> > -                     dev =3D dev_get_by_flags_rcu(net, IFF_UP,
> > -                                                IFF_UP | IFF_LOOPBACK)=
;
> > +                     dev =3D netdev_get_by_flags_rcu(net, &dev_tracker=
, IFF_UP,
> > +                                                   IFF_UP | IFF_LOOPBA=
CK);
> >               }
> >               rcu_read_unlock();
> >       }
> > @@ -159,7 +160,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex,=
 const struct in6_addr *addr)
> >  error_idev:
> >       in6_dev_put(idev);
> >  error:
> > -     dev_put(dev);
> > +     netdev_put(dev, &dev_tracker);
>
> Hmmm.. not sure this is legal.. We could have gotten the reference from
> dev_get_by_index() or a bare dev_hold() -- I mean there are two other
> ways of acquiring dev in this function. Either all or none of them
> have to be tracker aware, we can't mix?

Oh sorry, I totally forgot to update other parts..
Will squash this in v2.

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index fa7f0c22167b4..f8a8e46286b8e 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -80,7 +80,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex,
const struct in6_addr *addr)
  return -EINVAL;

  if (ifindex)
- dev =3D dev_get_by_index(net, ifindex);
+ dev =3D netdev_get_by_index(net, ifindex, &dev_tracker, GFP_KERNEL);

  if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE)) {
  err =3D -EINVAL;
@@ -105,7 +105,7 @@ int ipv6_sock_ac_join(struct sock *sk, int
ifindex, const struct in6_addr *addr)
  rt =3D rt6_lookup(net, addr, NULL, 0, NULL, 0);
  if (rt) {
  dev =3D dst_dev(&rt->dst);
- dev_hold(dev);
+ netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
  ip6_rt_put(rt);
  } else if (ishost) {
  rcu_read_unlock();

