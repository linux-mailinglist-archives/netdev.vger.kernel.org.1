Return-Path: <netdev+bounces-83942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A438894EF1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2041F218A7
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C8358203;
	Tue,  2 Apr 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXNRyBrm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0847A53
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051049; cv=none; b=kFWA+Wv17yaPECHML/ySt6QQTrGp54Pn0C62R47PGolpDuO7knJjSJxplQMY/xyTigfpbY6j+9GoqgMGw0vhhu2VBcmu8x9S9v/fqXcEUXC1vSmuPoKOqP6xuTUFoT4E3FPynuD9Xd1eOZTVV15RGaVtfSMIfCrR7V4Cp7yStxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051049; c=relaxed/simple;
	bh=1nbyZ7+9SpgY593Qq1WCH+zJ79nvBInwvRDFndmHnfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjYWmEpFdMRDlOy4ymF1HUhqyxyDcF4KZZc4ofBvUYcdNCxejgGsTPkwtp1ZkLO7e1k5bj75/1nq2HaB2UGZHYzlf0NKzuYTwnTvYL9BZDA2EYTlkNdPi13btrDzJLJukdqTM6/Z6hhG6oHF7g2SxvQkVNbglilpD+zjgC/jBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXNRyBrm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56dec96530bso4612a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712051046; x=1712655846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpSM8hFsyo5Obyhrx854SpDzmsBWUlzyTmjUnSt2t8Y=;
        b=PXNRyBrm0ZHYODCH3qKMo3LFmLXq9s4Or/96pH9sXcKy5ADJqNGlnW6yyhlg0a1afr
         gNahkwjzTbg0ot28uHDxs77T+Xozi4lHZ0Ws0kQhp2Dzs1ok1rJixAae8h9Sf0K5/S35
         hyy3GxvKLGltVkS65vpozPzrDKE7O3B+Fxdks/dwMC+j743lfOzGOsFq7SGVth4hnSM+
         UnAqDDT7wlbCS/T/NQcyt9buGegydBLoTL0AyFk+UuR4crCG60ubdypR3sMSxARULQEn
         lo607IJO2NUkrLPjF2kAgQeosolBAILoRZ9OMZcZ0iCUakWcoevdXmGbnwILOEt4vn7C
         yatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051046; x=1712655846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpSM8hFsyo5Obyhrx854SpDzmsBWUlzyTmjUnSt2t8Y=;
        b=upyYXmBu8K1a4Bn/86OyzUP6Wp/B05KU1xJZI5c5qxyUQCXDJMfDIGFXERdHEQRVHv
         NZBVSJ6GicXkG2vk6nSzPQseJ/kdpK2ZtIsHjZxw7+7ShE2EADK3XQ4UP6ZE+dDm/qgz
         9Qkbko68nnncpFD1g6PBhG0zCXYrANq7kPvH+M9r3S1hHjV6tIJejmVkVAv7jCZCFEwS
         2T27n+M2Lq7kt6vnjCalFVd9IojA5CHe4ZDTp6hiahW+Xtn3mOEJFjq9S4NoAFbjeOvH
         Vp2cu5/extDzEUdXWwtkQPyARXf/ozCDFlYY/fV7pNpqUP+P0MSJMkC0IMTtiWh/M0VG
         GqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV32zmuGnXx6diBghmCcUCuug/q6KCG/z1VmhMLLiBRgeWbJmIzGY70qp6NTpvSXjbhGgrQse9O93YXZrgn7Jj5Td9pw+Xq
X-Gm-Message-State: AOJu0Yx7fPJljDKX560mikqP3BYJfgThh7rn32+UH0LLOV7zNKnHderU
	PyXPQ9dMXe1wETiDvPWP3QxkM+oQ3TzaM27oa4dTfhIF2V+xFYlSCyNPJRfmFOGk1cOUoOHnzSA
	xXWMR9G5kSujLEO4Z/8CHixl6f+UhNfq1SdPj
X-Google-Smtp-Source: AGHT+IHSdicgtaGtIHgXLgCtu9lak9iy9Sn9Th+YwvL2uit/nzKJ/4W0z9bJqO3PI3uuakBvj9PszgLY8VfEjFHD90Y=
X-Received: by 2002:a05:6402:430b:b0:56d:cb23:e043 with SMTP id
 m11-20020a056402430b00b0056dcb23e043mr386732edc.5.1712051045632; Tue, 02 Apr
 2024 02:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401211003.25274-1-kuniyu@amazon.com>
In-Reply-To: <20240401211003.25274-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 11:43:51 +0200
Message-ID: <CANn89iKD8MhvSWySOUiteh=mxjt6uB6ZzRco1W-LMWWRD4K1PQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] ipv6: Fix infinite recursion in fib6_dump_done().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported infinite recursive calls of fib6_dump_done() during
> netlink socket destruction.  [1]
>
> From the log, syzkaller sent an AF_UNSPEC RTM_GETROUTE message, and then
> the response was generated.  The following recvmmsg() resumed the dump
> for IPv6, but the first call of inet6_dump_fib() failed at kzalloc() due
> to the fault injection.  [0]
>
>   12:01:34 executing program 3:
>   r0 =3D socket$nl_route(0x10, 0x3, 0x0)
>   sendmsg$nl_route(r0, ... snip ...)
>   recvmmsg(r0, ... snip ...) (fail_nth: 8)
>
> Here, fib6_dump_done() was set to nlk_sk(sk)->cb.done, and the next call
> of inet6_dump_fib() set it to nlk_sk(sk)->cb.args[3].  syzkaller stopped
> receiving the response halfway through, and finally netlink_sock_destruct=
()
> called nlk_sk(sk)->cb.done().

It was not clear to me why we call inet6_dump_fib() a second time
after the first call returned -ENOMEM

It seems to be caused by rtnl_dump_all(), if the skb had info from
IPv4 (skb->len !=3D 0)

"ip -6 ro" alone is not triggering the bug.

>
> fib6_dump_done() calls fib6_dump_end() and nlk_sk(sk)->cb.done() if it
> is still not NULL.  fib6_dump_end() rewrites nlk_sk(sk)->cb.done() by
> nlk_sk(sk)->cb.args[3], but it has the same function, not NULL, calling
> itself recursively and hitting the stack guard page.
>
> To avoid the issue, let's set the destructor after kzalloc().
>
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

