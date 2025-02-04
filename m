Return-Path: <netdev+bounces-162740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED9A27C84
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1815C3A3DB8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A186218E81;
	Tue,  4 Feb 2025 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xis+jjnE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FC21770E
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699874; cv=none; b=QoKJA6waJj4rWz21XAtZ2IAVblv7a+ZDB3EOz+kkGc0zhlxet8Yi7WabkKlL9KJYdAfHekXOp5I7BJh4G/vmO7fv8cVjuBxJeTPBf4wKCh0wzLPO2kE2U0J42ZvCY3WY2rar/MuhHOKUUhCcHcmrW/k+VG6HgUq6daLlmKefriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699874; c=relaxed/simple;
	bh=WsrPXnM6PNvN34Z8zs3+2y6NFrXkyse+DS/6xw0lBY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1V3ju1507hKHpEhsrGWCz49Cp8zztm5//u+wVbQoGhnWTC65+7tSofzLIhNUZtDq5oA+cAr7+DCPnwUbCCV9Eb7wlMA2wff3CbdaAzDZbWxX/+3/ZwX32JON9BVEqnfCxLoNbeD25xOeld7xjhJ86Qv2k5fGl5DmE6EuJkAItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xis+jjnE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab68a4ab074so731145266b.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738699871; x=1739304671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qto3MTRCj9/6vU00cfUF/BCQhzpteH8UN5nSCKpTBJY=;
        b=xis+jjnEYj1qh6J0vh/YYOXo/FodpGqNC1lG3BolPrDhC9dqF5hP+42vYQ3VUKprz+
         02LPuk2m4eASldgmEFfqrhRE2l3SF6E4oL/OTCsy0aTxBFwVuJqWLrvz9Mg6PolKwTel
         lmoG/qiYv0YWYERavfxf+nsz2JD/wYNrb9qmkc+jV/lycgB2FRbzebK90Tjug/UCxvCX
         hIZnALmfcoydhnUF0W1+QOP5MVtXeVrcJR0Am2ehOZRfnrcuj7i49Q45JrgCZc7/JJ0u
         pXD0yb+y5hEHckO/wk+U3yqoL2kw5rVn3nlM6WFY22cTjH/L4CXMcx5zyjil4s5mLlzI
         AUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738699871; x=1739304671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qto3MTRCj9/6vU00cfUF/BCQhzpteH8UN5nSCKpTBJY=;
        b=fjeZKe74YK0FtLnFLLif1OsTka9gA7XA8eV67J53jKwcb9giRdniNyM/y0r6mtYljO
         huJRU2yqRe1scFdkniDgAqGXLPOapfvgaH2RfKRays9Rld0lgEC2jAq9DJ6hjbA3E9po
         jYJuRmKgihvZZFhBo/X8XgoxQ35aHacHi1tIg6BW6fti6/FKa6Jfq+XNsXGQ0IEV94vO
         QuY+fGgc9gu1rW9cK9Pz15iyIvqAXUBqcFAPyD+gl840PwAC0eS8ekK/hIkP9CW2CAgV
         yrX85evV+dBNpNjj7v7BFXrdQmvEwINJGTr2ezeOGVwsbmgM6+zNFGKnEACMVQQlieHL
         ZarQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQIZ43s2yj1CwNVRkdDIZ4EcR/gLStQL8YD84ExZTG0zYGkoZ41jpco4Cmk5DDY+mTwDzIKWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVsF/x7z3o2GMhhXDumzEy3WZ0UYgdWVyN2P6sYNGd5cQXsiS
	wDo2yc6TalmPv51Ito+i4ffLNUCX1heu0kRR33rkJaBR2M6n5JnX3+UI6dndkjNHZUBvOF0iwJ4
	rNFLcs85pchFMH7jDmxJITh+WK196BYyYc9mt
X-Gm-Gg: ASbGnctUjAr97uaWQlpWqKE021ocaFYw8MZaaNB7+uwM8FyDr4Qydaqjnr96a69BI0/
	wluZTptFytc4vu49BDzJ5U/OgEMRu+d/dLtaXwZ18BPD56+HMOJcqrJ8q7bAOibDEowaZeNM=
X-Google-Smtp-Source: AGHT+IHMhqkv6lKEfNTL+he4FKoQnE1rfVU2/ZdP4J9UneDWcHja0XlO+sAlmBiI6yxfpFC2WRYrsHwk3TUw9mznlaE=
X-Received: by 2002:a05:6402:234e:b0:5dc:7374:261d with SMTP id
 4fb4d7f45d1cf-5dcdb6f9f81mr912712a12.7.1738699870599; Tue, 04 Feb 2025
 12:11:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com> <20250204132357.102354-12-edumazet@google.com>
 <20250204120903.6c616fc8@kernel.org>
In-Reply-To: <20250204120903.6c616fc8@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 21:10:59 +0100
X-Gm-Features: AWEUYZm-h8K5nde5GRBHncwy1Mqs7qtxS-BH5oU6JlDpaa2y8pQ9Fh0V76ECUOs
Message-ID: <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  4 Feb 2025 13:23:52 +0000 Eric Dumazet wrote:
> > @@ -488,7 +488,7 @@ static int ip6_input_finish(struct net *net, struct=
 sock *sk, struct sk_buff *sk
> >  int ip6_input(struct sk_buff *skb)
> >  {
> >       return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
> > -                    dev_net(skb->dev), NULL, skb, skb->dev, NULL,
> > +                    dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
> >                      ip6_input_finish);
> >  }
> >  EXPORT_SYMBOL_GPL(ip6_input);
>
> One more here:
>
> [ 4326.034939][   T50] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 4326.035125][   T50] WARNING: suspicious RCU usage
> [ 4326.035299][   T50] 6.13.0-virtme #1 Not tainted
> [ 4326.035955][   T50] -----------------------------
> [ 4326.036124][   T50] ./include/net/net_namespace.h:404 suspicious rcu_d=
ereference_check() usage!
> [ 4326.036398][   T50]
> [ 4326.036398][   T50] other info that might help us debug this:
> [ 4326.036398][   T50]
> [ 4326.036684][   T50]
> [ 4326.036684][   T50] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [ 4326.036910][   T50] 2 locks held by kworker/2:1/50:
> [ 4326.037111][   T50]  #0: ffff8880010a9548 ((wq_completion)events){+.+.=
}-{0:0}, at: process_one_work+0x7ec/0x16d0
> [ 4326.037439][   T50]  #1: ffffc9000036fd40 ((work_completion)(&trans->w=
ork)){+.+.}-{0:0}, at: process_one_work+0xe0b/0x16d0
> [ 4326.037741][   T50]
> [ 4326.037741][   T50] stack backtrace:
> [ 4326.037930][   T50] CPU: 2 UID: 0 PID: 50 Comm: kworker/2:1 Not tainte=
d 6.13.0-virtme #1
> [ 4326.037935][   T50] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [ 4326.037937][   T50] Workqueue: events xfrm_trans_reinject
> [ 4326.037947][   T50] Call Trace:
> [ 4326.037949][   T50]  <TASK>
> [ 4326.037952][   T50]  dump_stack_lvl+0xb0/0xd0
> [ 4326.037963][   T50]  lockdep_rcu_suspicious+0x1ea/0x280
> [ 4326.037975][   T50]  ip6_input+0x262/0x3e0
> [ 4326.038009][   T50]  xfrm_trans_reinject+0x2a2/0x460
> [ 4326.038055][   T50]  process_one_work+0xe55/0x16d0
> [ 4326.038098][   T50]  worker_thread+0x58c/0xce0
> [ 4326.038121][   T50]  kthread+0x359/0x5d0
> [ 4326.038141][   T50]  ret_from_fork+0x31/0x70
> [ 4326.038150][   T50]  ret_from_fork_asm+0x1a/0x30
>
> Test output:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/61-l2tp-sh/
> Decoded:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/vm-crash-th=
r2-0

Oh well. So many bugs.

