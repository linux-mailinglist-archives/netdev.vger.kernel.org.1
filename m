Return-Path: <netdev+bounces-162896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EDDA2852A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 08:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058657A24A0
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CE12288EB;
	Wed,  5 Feb 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/cNl1Ow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6352139C9
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742241; cv=none; b=TsC8Af8WRovEzgJFR61Fds6v8RjIFc28o8iCSchvzGltjTn29ntYpBCBnaqrXxxd+qs4Negqq3IbtO8BRS+KDdfduxGCSEt2hHKs2o5YE7DGTii1Y3suJcd4pCp/2diq/3TEFKlfWkLtSBuUalDEfrjqewxd/HRtpk24Mn5RFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742241; c=relaxed/simple;
	bh=uJCJoXaIceeUOx7uPX2U7F+kJtLIbsGT9PC55HpSSoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS/2CahAVRY6Sj1Fc3Vmpfe5fXdsNG8ZbCjoquUa+6ntqSOU+A3LyBQ+zMBMu/DuBkcaSVkte2PbMc5c5McVzo1pVyoN2CL/5JlU/fO0gjP/RMKCfywYaRstCgA8UaA8Br0+1errvlNQBA2yQTcwHMW3iWrbaC6c7nWG7vSFvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/cNl1Ow; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5db6890b64eso12736381a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 23:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738742237; x=1739347037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPQ45o6GxZmuNIcqeDr+LwklxlIy2EcQQETBSNhoeZw=;
        b=o/cNl1OwB4Agy1Pp1QBMB6X4RZY1F/YI8jmqaz4khrWkgi9xYrTfQK8xn2RNISzHcP
         xznJcI1U+Q72Dic2UVqxMV4p8QOFBnJoqbxIyHb6dcys2p2SVthXC1pjM27AxvnreDTD
         kScbfkThS0zIVjZmK2zGixfJxRqiOQXoRaS+D/HpFairYig5Cq5f9uICYpya5i7okfSN
         +EK1PobZJEH2i366d8y0Wecl3wp2WnhTACZS/lTpZyNQ1J04jy58EIPuOjkLqpo7TZmY
         ZLBKmgCVg8ZXBYgKId2/KaF1+MplmbmXla9fX6wH9q4ctfHHB8wRXckLuoYGtMWDFLL9
         kNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742237; x=1739347037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPQ45o6GxZmuNIcqeDr+LwklxlIy2EcQQETBSNhoeZw=;
        b=F8bz3E73m2MCoZMgmsw3S9NafK9G0GRL/Y9DRKHZW58RVKcbK6SkB0S+PkCWXeTqcb
         nLRHiOv/iRpk8xj4LNhflKk3itaGMrmjH9l1etYDHJ4HYnc7QyqrGOOAsd/AIuD1Wldl
         sOTa883Zk/vq4+PqNB+P2WfFiBVmFvQapoVdaae54LkEekH3vhK+KnfCkvYQgeRfQkoy
         LCiAGd6CBqTBmRPY6N5bfu8QFfQgzAmorZmP3ml4xvjS6Cq89ilXIGwvR90JtJ1Dv0JR
         FdqjPjB2Hrqk37LqZbV0X2FjKBJ31KX9DiXJ/Kq3bSF7ZdKsKLsrnM1MwpEJd7Ugwnng
         I9EA==
X-Forwarded-Encrypted: i=1; AJvYcCXUe69Ubfyc8p3hYNj4wjkxsmffibYgHI4OkiHX0i4eID0GxeZQ6ZQheyNPvWDwuqN720ljd+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2LcV7KAyZCrA3PlHWGqLDtr3W7EEfI99I9ZjRQY2H8ns+y/E
	R+ldbex13CHfvSTiBi0HiM4KxBJQ7kt8TOeCC3WCUS5BWSyYl9oEhGhbkFdf8zggsWkimnkMeMs
	/CMGBMrG+4bvRm5rcdD+gnk5z0AnC1HAnklN5
X-Gm-Gg: ASbGncu2vReSm5Pl1WlreUEzAm6411QhKTdqZPLzTVln2ui3Elst4DM0yWIsPRxS//k
	OMFgj0nRzUKt2gc873nw325lznOW9TvrxnwInt/Q5XtDeG9u6IbgaXEptBULH+jrYTvAZQpU=
X-Google-Smtp-Source: AGHT+IF42kGdt3W89ZlIif5gI9zTVay8hB8q4hXlUr7ZH/inOaMzt+i5WRt04SxMmmK4e4sdUzF5crttdHY+pNqtxAg=
X-Received: by 2002:a05:6402:4308:b0:5dc:7425:ea9b with SMTP id
 4fb4d7f45d1cf-5dcdb76453fmr1840955a12.25.1738742237482; Tue, 04 Feb 2025
 23:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com> <20250204132357.102354-12-edumazet@google.com>
 <20250204120903.6c616fc8@kernel.org> <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
 <20250204130025.33682a8d@kernel.org> <CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>
 <39a1fde2-63f7-4092-870f-ae20156fbb9e@paulmck-laptop> <20250204133025.78c466ec@kernel.org>
In-Reply-To: <20250204133025.78c466ec@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 08:57:06 +0100
X-Gm-Features: AWEUYZmf-hkK5S-4cTzXYSKvaPn4vDvYROBq0moc-474cU0yHwAgjs53TxCGO80
Message-ID: <CANn89i+AozhFhZNK0Y4e_EqXV1=yKjGuvf43Wa6JJKWMOixWQQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 4 Feb 2025 13:17:08 -0800 Paul E. McKenney wrote:
> > > > TBH I'm slightly confused by this, and the previous warnings.
> > > >
> > > > The previous one was from a timer callback.
> > > >
> > > > This one is with BH disabled.
> > > >
> > > > I thought BH implies RCU protection. We certainly depend on that
> > > > in NAPI for XDP. And threaded NAPI does the exact same thing as
> > > > xfrm_trans_reinject(), a bare local_bh_disable().
> > > >
> > > > RCU folks, did something change or is just holes in my brain again?
> > >
> > > Nope, BH does not imply rcu_read_lock()
> >
> > You are both right?  ;-)
> >
> > The synchronize_rcu() function will wait for all types of RCU readers,
> > including BH-disabled regions of code.  However, lockdep can distinguis=
h
> > between the various sorts of readers.  So for example
> >
> >       lockdep_assert_in_rcu_read_lock_bh();
> >
> > will complain unless you did rcu_read_lock_bh(), even if you did someth=
ing
> > like disable_bh().  If you don't want to distinguish and are happy with
> > any type of RCU reader, you can use
> >
> >       lockdep_assert_in_rcu_reader();
> >
> > I have been expecting that CONFIG_PREEMPT_RT=3Dy kernels will break thi=
s
> > any day now, but so far so good.  ;-)
>
> Thanks Paul! So IIUC in this case we could:
>
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 0f5eb9db0c62..58ec1eb9ae6a 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -401,7 +401,7 @@ static inline struct net *read_pnet(const possible_ne=
t_t *pnet)
>  static inline struct net *read_pnet_rcu(possible_net_t *pnet)
>  {
>  #ifdef CONFIG_NET_NS
> -       return rcu_dereference(pnet->net);
> +       return rcu_dereference_check(pnet->net, rcu_read_lock_bh_held());
>  #else
>         return &init_net;
>  #endif
>
> Sorry for the sideline, Eric, up to you how to proceed..

I will squash this diff to the following iteration, and keep rcu_dereferenc=
e()

Note that nf_hook() also grabs rcu_read_lock().

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 4030527ebe098e86764f37c9068d2f2f9af2d183..ee5a69fdc67a30e55c5a073455e=
1d7299f168f34
100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -477,9 +477,7 @@ void ip6_protocol_deliver_rcu(struct net *net,
struct sk_buff *skb, int nexthdr,
 static int ip6_input_finish(struct net *net, struct sock *sk, struct
sk_buff *skb)
 {
        skb_clear_delivery_time(skb);
-       rcu_read_lock();
        ip6_protocol_deliver_rcu(net, skb, 0, false);
-       rcu_read_unlock();

        return 0;
 }
@@ -487,9 +485,14 @@ static int ip6_input_finish(struct net *net,
struct sock *sk, struct sk_buff *sk

 int ip6_input(struct sk_buff *skb)
 {
-       return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
-                      dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
-                      ip6_input_finish);
+       int res;
+
+       rcu_read_lock();
+       res =3D NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
+                     dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
+                     ip6_input_finish);
+       rcu_read_unlock();
+       return res;
 }
 EXPORT_SYMBOL_GPL(ip6_input);

