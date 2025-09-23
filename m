Return-Path: <netdev+bounces-225465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180DDB93D57
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1756D190540C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8411F4295;
	Tue, 23 Sep 2025 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhIkwzcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8D20C00E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590807; cv=none; b=taUoVsXT29OQR9f6aROfKiDsuNmR3AhS3ym8enoQt/7gwe922Zx4EGM0z4MpqNZ8g9zj0yd1rCoo2mBSMyGPn5JdO6ucCEBVT9sB9Uh6eSOSCs2bX8pXOJky/vbejD2B0VGAGawn5LGUswPARoY2kzE6Ij3Qm56oo3Zv+WvMo/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590807; c=relaxed/simple;
	bh=dCD2y8Kss29LTF1G7u8h8qxVQPiTY1vvsH2bIj6Npa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2wPl4EK6nYHN7vDrBz62XqRv0sZNI9Mr3N38Yjj2d/K4hlAjqOfgu3YgwaV2R3Kg5ov9rzMSOWTYqPwDDVOQKaHlKv4AXROKTfgsD/CZO8td38eF8ArPWV37t8Oqdn1nm4s8mYJBiEJ72uhXejqpRwx8O6GX6NtB8hEpzraf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhIkwzcx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-269af38418aso54045795ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758590805; x=1759195605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISpOOB0/l1DAWofm5fktjmzhE+vFFaPgdP7ZYeFC00Y=;
        b=rhIkwzcxj0VQlp5CpKFdQo3AIRUs08eahvgKWXvCMcHOjUyk6LPQNBJ6lEAtWvXBfA
         BKmk6YWTzUkaLe+FlUmrew3dpkx/SdLnEqI42qL4vs8TGOih3jdLl3j8ceDq994DFNqP
         7rBMRlragsnC4vxTUaUjr9UEjrYPVGBu5yj+d4uUoTfCLGOXFnwmVPoY+FllG6Sr1zZM
         ZUBDygy+hMVzGjIoyQMPScsgqy3vADkdOyjNSp3JKvdCnp4s02mbSDCQppuDHO06XuOx
         goDONIYPKY+WENkc9urBNzno+7li6SEomsBiXKpE5qtm3TR6XQ1gQJym2tyAcKMiVrin
         b+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590805; x=1759195605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISpOOB0/l1DAWofm5fktjmzhE+vFFaPgdP7ZYeFC00Y=;
        b=PCymdUgRJ28QaCWsMbnuIlqk/iTu/xzJmkzlV43IfJGvniqAvfCdb6w0gkcwO009g6
         zk0JiA8ffPZFapUMa9BDpvZWPVelfM1/PmZB0yNPt6SB4N1b/P8/QYb3+jMzBVp0szjG
         Ofj4qgYz9cf9gpRB5E0dUSdh26Ac4VZv6M0Eka9ZFax2UhQypS/YTzhDU4hpjdPdRT7/
         YrhMSqh2hpYDr+uovd5dcgKYFNxdeUh0uPdIRdaG6T29sxFnRdqJKj9aWW/GM4Ion1QM
         9XoY1CShDz2VSaNx+bSUxmRkHhjLOfifTPfcYCgAEHckKWahTuojBNbSMVGV3ziQ6RtZ
         P8zw==
X-Forwarded-Encrypted: i=1; AJvYcCUZq/+E405o0zbORQv3VyR46ZgBBNdCe8e2XO9ZOFjVMYS80Zl7gOhL6heICkp9mS0JowHSNUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQR2yKpIDkhLOfT9jVjmWtm/fNkR9yUrPAXbol1egF8Q8sqfQ
	UEVNCg8z8/N6CxTuaNl446r0Z77WRH7WUdnd9Er6AeNGyqTyomFK3VWkLXdlxwvFP6XVOsDRPwQ
	YMmLUvS/hipjIxiZlpPwE83qZ3TcOghoD9Lds7ucN
X-Gm-Gg: ASbGncvI27K4WhkzbneXSwVNvbYOgBrrZjRkgpUBVNTm2ENG1nJvyLkhpbNpZkbT2c3
	RAmNvSfHrZmR/68v1dy8KkFI1AHcADqyaTFxhIUGVG4HDs7pZ+NyAnVzj1qoaV0+oO2AVPex8Qb
	jV07iS8nrdJ5CAw9WGbCAHe8jvC8BKYRe0R3GyBEwjngouFVxRu2nYcqCeyjUG+MmszdhB3gptc
	UuNkjTCm0FU7nqokvNP8LKMF/0KeiNIYNFQhROrDwfFqM7dzZg=
X-Google-Smtp-Source: AGHT+IH8We4aa6A1R60oPOHiyTQjJ6+7Np229xRD678dB0KwKZjs/Y+tueOLGbVz/vFv5eM0cJOwwMwsk6STQprEpqA=
X-Received: by 2002:a17:902:da84:b0:26c:2e56:ec27 with SMTP id
 d9443c01a7336-27cc20ffc29mr9429885ad.19.1758590805122; Mon, 22 Sep 2025
 18:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com> <20250920000751.2091731-4-kuniyu@google.com>
 <pmti7ebtl7zfom5ndqcvpdwjxlkrvmly2ol64llabcwfk7bdg2@mc3pigkg2ppq> <CAAVpQUBZSK6ptrRgruj0BGXBqDUOu3MKYKfD9FkWFn55OduwOw@mail.gmail.com>
In-Reply-To: <CAAVpQUBZSK6ptrRgruj0BGXBqDUOu3MKYKfD9FkWFn55OduwOw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 18:26:33 -0700
X-Gm-Features: AS18NWBPGjKPjLNlAh9my6zm9bVl-xQHVzTgkDrB6wJ1tjl_Scrt3a9mHUnweWI
Message-ID: <CAAVpQUA+6BQhCt01AgEnST3=K46jbeRpPvYMrk_Fu8OhtHrP7A@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:03=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Mon, Sep 22, 2025 at 5:54=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Sat, Sep 20, 2025 at 12:07:17AM +0000, Kuniyuki Iwashima wrote:
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 814966309b0e..348e599c3fbc 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -2519,6 +2519,7 @@ struct sock *sk_clone_lock(const struct sock *s=
k, const gfp_t priority)
> > >  #ifdef CONFIG_MEMCG
> > >       /* sk->sk_memcg will be populated at accept() time */
> > >       newsk->sk_memcg =3D NULL;
> > > +     mem_cgroup_sk_set_flags(newsk, mem_cgroup_sk_get_flags(sk));
> >
> > Why do you need to set the flag here? Will doing in __inet_accept only
> > be too late i.e. protocol accounting would have happened?

Oh no, this is because I used newsk in __inet_accept(), and
we can use sock->sk in __inet_accept() and remove the inheritance
in sk_clone_lock() like this,

flags =3D mem_cgroup_sk_get_flags(sock->sk);

but I think using newsk reduces one cache miss.  Also, we touch the
parent sk_memcg during sock_copy() in sk_clone_lock().

