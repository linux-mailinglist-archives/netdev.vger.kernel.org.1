Return-Path: <netdev+bounces-89345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052118AA156
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3028E1C20CEB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D741175552;
	Thu, 18 Apr 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRzXQHdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFC1EA8F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462505; cv=none; b=nX5d6VR9qa8iRzgBb3juH0lgVO1Z20v6etQcJgnkL0uLC3k5Nf0ugC6foRwN0dch69rLjQCWvEy2QgKpKkaIjWbf+7O3fUPx2iobY74YKlXVEulxOLVAnUBIJ8ufltwUnXlBCaa0lA9Ya7+YiZ72Z4GGU1B0DdgDdq3h1IwZr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462505; c=relaxed/simple;
	bh=f76I9qm9ixVzIAOtxGZUfkt56m6lnXvWzNveKSJspIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izHbO0L/C1SvTvL7z0YP8k7aVH8lrwQPfsJvGkILq4h++73k2Ido716ydS5UwFUGqfkub+cTQcl9gh0K5cxF17xhstg2IhhLSZ3NSUM2q75QG02NSw/XrR2ItMD8rM8QZO1CNB3BqXEyu14vV9ut3klxZxFyQJB7tzeOL+sG8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRzXQHdu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so1433a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713462502; x=1714067302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcGoKURjzhYHjQE5mjGIjBwQUlGDndsd9afFNL3Lq3A=;
        b=KRzXQHduNLnx14y5sAVC1n7IwWGr8vnGQ9uKZSleDcpecmKbrJospm0Wh78o1PgkRH
         tC1GtFf9hx9CqkisXan+LUtAcveDwJJVT6pKgLQu7qz4Z2GRyfpEr2G/6D8JBpAv/n+8
         1sqWj9Eb7/RcbPyAD1bVD0WatLK3uNTCvmyP69zq+514TuZGVn7guQ6pZ5/DJMOlfTJq
         M4TYl2MoMUhwZOG8xhZq6XWSWE34/dQl9eE0jtrwrm8JrNy9YkggVkJzFsR7gOlH9wIL
         p/H+U/Kl91ajzeFEiUgrSNn+qaRXbgAA2ZoGW+SiMkYm+DqRqpEKFp+R15pOod3bPwoe
         //1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462502; x=1714067302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcGoKURjzhYHjQE5mjGIjBwQUlGDndsd9afFNL3Lq3A=;
        b=MshcLf49s7FG2CkQ0IEsmQL8U7PyV3vwm+OOxBJgkLyDhtXtikatQ6Tkp0SJ7jjLPU
         KS+7/j8t3CJkGJ5flBtVTVB/wYZaAl7s5rABFe3ZMVqb+xPartzJWRXvKmvsb5LAdH4g
         zcY4F8zcSnFQ4fqwyLssiIF7qlVJC7s8wFrlDPJXCYcIlk5DGj1QSkGcz/biABPENOzJ
         5kyQ+DC8c4HokUfqZs1IiYdMtp/YGqCAA/uhn6WR5wkZ9OUuvI6b+yxzHFSqBhDtkJPp
         7fhUqss/T75Yzn5YaZEHwgvFW4zfNWUveoQqwmlIonAn7UTS70XJWt03Pz8wiYpeBBmN
         1vJg==
X-Forwarded-Encrypted: i=1; AJvYcCWRw80+TXCdkZEiyXX5LVvCaUKdFN5dSY1STXnE8jvXRszwHFr/YKE0rwocJFaYwhYpWsTOGYkeYDd9jVqANywJ2/W4BIkB
X-Gm-Message-State: AOJu0Ywa8wmBQ/53nIwmh6pAbGMU6bpb4GHIn3g43PhU5wD+HITnLVhf
	afgZwLxc4jdVo679D2giMVwGD5RjqAdZo3TuDb0QyHqU4oULQDkt5ou/F62W0Wk/e90PSvjihm8
	JVzXwEQna8ZAqcEtQ27Tx/zRwdJaYWkej2Wuh
X-Google-Smtp-Source: AGHT+IF0lF78Z2QSIcW8PHui/c0uCywUQh41qeXzGAPou1WDQP/BmuVaCNnZ5gDWGyLv9w2ZUg98PRI65FpK70K1OgA=
X-Received: by 2002:a05:6402:26cb:b0:570:fa4:97d6 with SMTP id
 x11-20020a05640226cb00b005700fa497d6mr16763edd.0.1713462501880; Thu, 18 Apr
 2024 10:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
 <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
 <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com> <274d458e-36c8-4742-9923-6944d3ef44b5@kernel.org>
In-Reply-To: <274d458e-36c8-4742-9923-6944d3ef44b5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 19:47:51 +0200
Message-ID: <CANn89iJOLPH72pkqLWm-E4dPKL4yWxTfyJhord0r_cPcRm9WiQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 7:46=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 4/18/24 4:15 AM, Eric Dumazet wrote:
> >
> > Thanks Paolo
> >
> > I found that the following patch is fixing the issue for me.
> >
> > diff --git a/tools/testing/selftests/net/nettest.c
> > b/tools/testing/selftests/net/nettest.c
> > index cd8a580974480212b45d86f35293b77f3d033473..ff25e53024ef6d4101f251c=
8a8a5e936e44e280f
> > 100644
> > --- a/tools/testing/selftests/net/nettest.c
> > +++ b/tools/testing/selftests/net/nettest.c
> > @@ -1744,6 +1744,7 @@ static int connectsock(void *addr, socklen_t
> > alen, struct sock_args *args)
> >         if (args->bind_test_only)
> >                 goto out;
> >
> > +       set_recv_attr(sd, args->version);
> >         if (connect(sd, addr, alen) < 0) {
> >                 if (errno !=3D EINPROGRESS) {
> >                         log_err_errno("Failed to connect to remote host=
");
>
> You have a kernel patch that makes a test fail, and your solution is
> changing userspace? The tests are examples of userspace applications and
> how they can use APIs, so if the patch breaks a test it is by definition
> breaking userspace which is not allowed.

I think the userspace program relied on a bug added in linux in 2020

Jakub, I will stop trying to push the patches, this is a lost battle.

