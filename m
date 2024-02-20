Return-Path: <netdev+bounces-73379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D642885C349
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 19:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42877B23481
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F0779F0;
	Tue, 20 Feb 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3/CJn6nK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7C77621
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452236; cv=none; b=I6sAsUHuDqzdtT6cbYvYtcxPk5QHYyrvxEcnFqKDswBQg4tNbZgir6LM2wB0ocLN51WgwayJBy5XUeNjsLHa8egl4laDU//hAdRuQQY4G409712G/NVUEnxWby6uABcn6gaRr6L23CopIuwmWGq78ISTnI/UePIVAIjPlK3Vd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452236; c=relaxed/simple;
	bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbATFxVz+dszDmZNO5GuXx16cvdyjE6rqEscCV0qdTPqKHoIK84rn3rtpyeDqQ9dBwihM4sbkzdKJNhPOrX9dgzeah5/uXr92MlNeqRbeTrv+PgrK3jB8vU3/T8/fGc+C2FqBhYR8y2+g9rO9gd+e9Z9myqZYSpE3TYvyVNlgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3/CJn6nK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564d311513bso963a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708452233; x=1709057033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
        b=3/CJn6nKud0v2xAGVIYe5baXdR2Ueut4CiNC7Eq+CdK/HTCgeWAhLJNQ9YSZrlihSw
         +mM3X2+RxFG+U4oAPjuPiS8R0LbRn6S4Y8pCTLoqNs7S5v1u7fpkNzSYMtWBn/X9D1PF
         FnxQ3r+ZvdTz2GVJYmvYaB24ijfnD89BV1rH82z0BuzXUvEPhJxWIoC4u3Yt5T72aeTe
         qYIGjYNb8ft5j8LPUvtGqVSAJRSZ2X4VPIe73KRHWHjFKBrKXoWc1FKcuzTcVIt9dF8r
         tL8WYVdqLYYP2Hu+0UL2PZbpsVD3fz/jm2ijVeqMBAnyticRSKwJvQYWyGe0lHn/KMg3
         Ak7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452233; x=1709057033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
        b=GP7AKddMzGj7ZQfQJ/TVbWH06kjlyaacGJa1xzrmc2K3fOEzaEQPzgKPPjOejLKs3X
         ouQRWFMDUY9Ejy02KzvoyVNboY06aoHs5Fl//iYFGWerX4/5V+hSNwvvLt4BErJjOXcQ
         2JUjgzqorJnNEt+OLn0mpuxyvvbAXNVE1in2ZkVDYtF36M7J894Zq9GQspGiy0L5ujoU
         r3xMwptGE7EesLj8DTE4K870nqbNaeqJz/LYOQU7TFB/sTmlboXnZa4gUtbrlMZN3HxS
         5u8rK0mnDzkCcfPjzoFY5sOKNBF39rKR6a10rTk9CJ4CLNjkIHYAqhY9Lctf7krRo5KG
         vAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvvZ7NYXIRatsqbJ6jWP1mzsEG2+YEJ4l0XmV/PiF3bsIk+D59l5fe13iLICaxAYzkIlnuLnT7C/idavr0IuffwGA18HoD
X-Gm-Message-State: AOJu0YxOLnoW/VFqLodkOrqjJZKGolmzRl42IhNJgXQ/flVubk1PXpWG
	j/wm1ued4qwH4WkTN0NQaUn739VYkSjb7gS6pP2un5LackZgTUMmetl7LEF+Nc1Cub8vLXOUnPW
	lLG2DA49LRUWxSzAPjgMUjkF3owCJ65DadrY+
X-Google-Smtp-Source: AGHT+IHw5T91YrU9Maq/ZbuDhD+cF96pVCL0Q7L/zZJ2yh3VVoEnWRHnH3fhRfCS0slaDzwuX66xPIpbpON2ixt2PFU=
X-Received: by 2002:a50:8d12:0:b0:563:f48f:a5bc with SMTP id
 s18-20020a508d12000000b00563f48fa5bcmr441060eds.5.1708452233017; Tue, 20 Feb
 2024 10:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
 <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
 <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com>
 <278c26d6f4042dc6dadb9742afe11b7fa610f0b2.camel@redhat.com>
 <CANn89iK72hE16sQcGPUFG6Am_V-77PNJOYHgeAA6M+SD5UO13A@mail.gmail.com> <28a1a98c757e4a15b7eecdeae563a17fa5cb45cf.camel@redhat.com>
In-Reply-To: <28a1a98c757e4a15b7eecdeae563a17fa5cb45cf.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 19:03:41 +0100
Message-ID: <CANn89iKn1U14L1u2w3VwenRt0S4QnXJhiA5PvMF0s41d8nS6Tw@mail.gmail.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-02-19 at 19:33 +0100, Eric Dumazet wrote:
> > On Mon, Feb 19, 2024 at 7:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > > Thanks for the head-up. This later option looks preferable, to avoid
> > > quit a bit of noise with _ONCE annotation. Is there a syzkaller splat=
 I
> > > could look at? if it landed on the ML, I missed it.
> > >
> >
> > Not landed yet, here is the splat :
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.2/24141 is trying to acquire lock:
> > ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
> > tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
> > ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
> > tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
> >
> > but task is already holding lock:
> > ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
> > include/linux/spinlock.h:351 [inline]
> > ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
> > inet_diag_dump_icsk+0x39f/0x1f80 net/ipv4/inet_diag.c:1038
>
> [Sorry for the latency]. Yes it looks like that checking the listener
> status will work. I can test and send the formal patch - with the due
> credits! - or do you prefer otherwise?

Sure, please send the formal patch, thank you.

