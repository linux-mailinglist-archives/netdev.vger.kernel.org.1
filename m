Return-Path: <netdev+bounces-127345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 630499752AC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA1728287B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE0185B48;
	Wed, 11 Sep 2024 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9ABdE+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867042AA9
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058465; cv=none; b=l9AOsOZqeWqb0JK1siiFuFlJgFqPC+2bE3xokpi5NUBW0K5v0e02oXXJshy/2lXXprmosUq6Lp2RZ3ZZcglxmG/PTxWpoplzxQIiu5GwzqG4LbUMEokqbLzKIpZcTJA6nfccSB1YJyw/cLThzwtfRCN3NAmuLAOmVKlnvUSCQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058465; c=relaxed/simple;
	bh=wtxLoB4vPqYrdT/EYT8t2Xa0CqGkZfNrMbsI0noNrbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/65yXI7NpE86d61DQOpjS++9BOKvVb272Yc27E0AnACwoprHHJufjfTVM9ScfBizHXTMIXYu/QA+L3JXnahOk7/72QXHtBR0CU4d+xHIRP8rHRiskUT2/V2+do5/3pbW9ufBNXhNNc60/ay55EkQuIUl4vkL46qlf0pa8eZ4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9ABdE+8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso144604766b.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726058462; x=1726663262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKVy292doNLbN9I6GbrU5oq0mh9HaUJH9jCBxs6u1xk=;
        b=b9ABdE+84APD84FSEzB8Br+r8VpxKMKd+go7aaVJDsYFwvg7YFgXT5WNtf7PUrfeG0
         UM7Oyzp+RInSm7QB1nZJhqo7BpQ6oYK3cZGYID3pzol9LaRm/HIQPbaa16ZaZxxqpgUx
         JnUG8v/opIjNrebXsppTWPMOD4cCDkm9XhdM7dHnu9s/0UJvw9C+Z3LRKsjlgLnTN2yb
         86iukDyDjMYwaPnTeBP2rQPu5yf+P5/+UHrMIw84U0ovpjU3i/6WkAFxVGJqJYVmiUtA
         jgvHYHk/T/KZDpHFeJiNXxKZ3lCVnGNhUNS25z100veh/X8kzo7FcAc/VZFpL//dQK20
         +Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726058462; x=1726663262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKVy292doNLbN9I6GbrU5oq0mh9HaUJH9jCBxs6u1xk=;
        b=vgvJNproCRp2R22hH5zRrK90TwWl4BTo6Gs3WjyzCZmBvJaRTrocpErBKNaj7rTgrm
         ziwQ36lW6KlcKtMb51/nV5uU3p2xJ9A9aAZ96OUt2YsscMmskgFt8VRQbOwy5CrEhHtp
         OSszgTvyFm9fKXN/xt+yY67YR9nWrhuOsYzOxYs9kFBKMmh4m/DrZIlmTrrnBlzKxpUu
         P867ybYyFQG99ScbKua+DgVQ1nJmE/BVI8vUfiGXsR65o8umnle/u6W3t+AIgGHwNXA7
         2ph+iZxI4XmGikz3qC0gh4o/QTuAYvrJTXdZotTAAR2aN7GvL/UySIEAl0GUNWTUgHEp
         7+jA==
X-Forwarded-Encrypted: i=1; AJvYcCUK9Wyqz/KYzfWB7Var0v6Se6DBvuVgGOqvnuT8lzswkNxq7EsNsJmd3wA9EsIZ+ViSCQN4QEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWYwN3kNk7NeReiv4qEyqbqMMPkxIFw9kisCEEjBasSK9NmYM+
	HLdOgg/x3mLXG2BWUK41AMe2+A9WS5iCxEEQqTOybKrR/S0gcdVucpovn0w9FpoD+3s+YsMuAz5
	nySndFo4BypQKhfMCRo/PHBpemFuwGwlR3b/+
X-Google-Smtp-Source: AGHT+IFbWUhMgRXADba1zKZ2Sm/Cl1vs4wqI8zXUpGXpt82kSgwA6LanLYq6HBPG/igVcyCzEtAG2QyZ0s99mtsEu7g=
X-Received: by 2002:a17:907:9620:b0:a86:9e84:dddc with SMTP id
 a640c23a62f3a-a8ffae204b6mr397140166b.61.1726058461030; Wed, 11 Sep 2024
 05:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911050435.53156-1-qianqiang.liu@163.com> <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z> <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuFv88V0qhcwfOgP@iZbp1asjb3cy8ks0srf007Z>
In-Reply-To: <ZuFv88V0qhcwfOgP@iZbp1asjb3cy8ks0srf007Z>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 14:40:47 +0200
Message-ID: <CANn89i+zW+t1OEs2ut9Zm6FweY869Yrn-fnjq38tcmqqHLaTvA@mail.gmail.com>
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: Tze-nan.Wu@mediatek.com, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 1:14=E2=80=AFPM Qianqiang Liu <qianqiang.liu@163.co=
m> wrote:
>
> On Wed, Sep 11, 2024 at 11:12:24AM +0200, Eric Dumazet wrote:
> > On Wed, Sep 11, 2024 at 10:23=E2=80=AFAM Qianqiang Liu <qianqiang.liu@1=
63.com> wrote:
> > >
> > > > I do not think it matters, because the copy is performed later, wit=
h
> > > > all the needed checks.
> > >
> > > No, there is no checks at all.
> > >
> >
> > Please elaborate ?
> > Why should maintainers have to spend time to provide evidence to
> > support your claims ?
> > Have you thought about the (compat) case ?
> >
> > There are plenty of checks. They were there before Stanislav commit.
> >
> > Each getsockopt() handler must perform the same actions.
> >
> > For instance, look at do_ipv6_getsockopt()
> >
> > If you find one getsockopt() method failing to perform the checks,
> > please report to us.
>
> Sorry, let me explain a little bit.
>
> The issue was introduced in this commit: 33f339a1ba54e ("bpf, net: Fix a
> potential race in do_sock_getsockopt()")

Not really.

Code before this commit also ignored copy_from_sockptr() return code.

>
> diff --git a/net/socket.c b/net/socket.c
> index fcbdd5bc47ac..0a2bd22ec105 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2362,7 +2362,7 @@ INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getso=
ckopt(int level,
>  int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>                        int optname, sockptr_t optval, sockptr_t optlen)
>  {
> -       int max_optlen __maybe_unused;
> +       int max_optlen __maybe_unused =3D 0;
>         const struct proto_ops *ops;
>         int err;
>
> @@ -2371,7 +2371,7 @@ int do_sock_getsockopt(struct socket *sock, bool co=
mpat, int level,
>                 return err;
>
>         if (!compat)
> -               max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> +               copy_from_sockptr(&max_optlen, optlen, sizeof(int));
>
>         ops =3D READ_ONCE(sock->ops);
>         if (level =3D=3D SOL_SOCKET) {
>
> The return value of "copy_from_sockptr()" in "do_sock_getsockopt()" was
> not checked. So, I added the following patch:
>
> diff --git a/net/socket.c b/net/socket.c
> index 0a2bd22ec105..6b9a414d01d5 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2370,8 +2370,11 @@ int do_sock_getsockopt(struct socket *sock, bool c=
ompat, int level,
>         if (err)
>                 return err;
>
> -       if (!compat)
> -               copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> +       if (!compat) {
> +               err =3D copy_from_sockptr(&max_optlen, optlen, sizeof(int=
));
> +               if (err)
> +                       return -EFAULT;
> +       }
>
>         ops =3D READ_ONCE(sock->ops);
>         if (level =3D=3D SOL_SOCKET) {
>
> Maybe I missed something?
>
> If you think it's not an issue, then I'm OK with it.

It is not an issue, just adding extra code for an unlikely condition
that must be tested later anyway.

