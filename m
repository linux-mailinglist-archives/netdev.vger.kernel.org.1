Return-Path: <netdev+bounces-224046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 050D0B7FF45
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BD11C229F0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB963245014;
	Wed, 17 Sep 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgWyI8bw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084324729D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118345; cv=none; b=hEm1V1pLa6D1MlAxHBcIW88uBiBJXOBh4Dx3b69Hhr0cgCts6vFfoNd7Swn7N/r6dRI2/kPZLqVFUdZ6ilhEBuf+iE0eQhFBfVOCTy1eL/aKb5VGV3+f8yfd/lTAGJXJKg/KlUQhjGbCXXqM7YofI62CjHFOZenTu1UW32x51U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118345; c=relaxed/simple;
	bh=Ab4CNF2QWjHdBs7Psg2vmzKqO6db6NFzh5f/DjKl0CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMzjjiYElMNVraIXxCQ3XtvqnftsBXxFbysPIBiHJO/Jlx1uQJgFMIBS9V73chZhOncljdQ6SSqqnX1b+mgI49HoK07WZiY4oe0ZYZngL/xn4beUDRDyEcJoXBNJ0i/aRsD//MlKYTdJ+xL47Ay2hlcfP82QXSwFZgnzFYj7Ne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgWyI8bw; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-60f45afcc50so1618244d50.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758118343; x=1758723143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab4CNF2QWjHdBs7Psg2vmzKqO6db6NFzh5f/DjKl0CA=;
        b=pgWyI8bwE0EnJ54KxNOUB5iUlNBJESuE4phoXeWJofIjDusDgI6VYJWZWzXL6pcArN
         obhoyV6Ag2/qGtc4GambGUwWcMot7WpItorkikoHDxgt5+db/usziA675OlKvUOFXsSY
         e8yCvqSh7OAGGSNvwQzxDUZYSqP8EOMTlgsgDsxbSAqlsB3GQD/ROflFjN5n7Lk6wfb9
         +0B0WIFdurd8Y1KE1aJDBxkMb7+1tJOP4/6OnkRPndFqpN1GK8cFpfOEI8zuxdJu8lzx
         wRGnzw8UV00XCeJAGwd77zdGblOBaueT0QeVaAyEEf15UnDdaNw3FvVTBxW9K2jT/2i8
         6KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118343; x=1758723143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab4CNF2QWjHdBs7Psg2vmzKqO6db6NFzh5f/DjKl0CA=;
        b=k+1O1Lz3D9/z0mysYpX/kKjv1hQj2LbXUe/p5FLM4cC6sqkbIvwaqJW7o/31YSvpUC
         F3i3MmcNyX+x+gILjYTU42Q2kbI7HTs4+h1WD0geli14PsNoZXS9Wz8nz2G3Hhi+WHjA
         +i7JpKBQu3OTyyQR1eSueaC7j0lzXoRekbj94EfY0MpgOEyC1P1laJ9VFQMUhA2lwXZK
         +tytvGYgYMZ1gAk9vFRjT57D921nbTo5KBe/OE978itsYCfX18C54vsESvw3HGBUcm1m
         CmiyttcfoLiCkX2d5c6/JGLKQitmeEwST9l5G4VDhQKfsMIHBFLsmyjH6+sLyLazgLmT
         DcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBe43AJpA1bgve35vUTzyyDv3QRNSzA7W2CvfO9mhwpVDLRJSYF7qh7c/EiomFmRjGmTRz7bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhPSt+z3uaEF59nt9fh2htQlQczAZR6PosVnh4G0UBHvff93L
	fqKjKGTngMTNGcgRP4VjvIngGJ5ZDjM+z0rlUxHZy7f/6XnJOiSuBv4dG3MOMCXdJ80BNLDohKo
	lbCUN1e0B/yPh+l72JsNiuDSHHWw2oU/c6QpGKyzS
X-Gm-Gg: ASbGncuvpcoMP9a11A5fgCnC5CB247xBpsNsqzJUE/xUXCWH9lTK/mlYP9MjdGPxZtD
	EG8Qn8d4KknRNGstCjI91oyG0dyyS1LtaVzPO+i5uEq8zcFPq28C65riUxI6G9D+nzkaGf3jfsB
	UYn6BNwa64/qTXrtIJ4iZT3ZbAHS4MjMCBnvL0cter5BE7Byqxp1CN7qFpD/RmaduReHE1eQrxB
	7T4+r2p4FZw
X-Google-Smtp-Source: AGHT+IHk6OEYksmQhfBYJUSL/+AbRrAtRie8NE9/9ePC6C0XvQE+PVFBkLLFDLSF/UVK9we8fm+KzZ7/dJgmrgUXXqE=
X-Received: by 2002:a53:b9cd:0:b0:630:e716:e358 with SMTP id
 956f58d0204a3-633b05fadcemr1500548d50.14.1758118342898; Wed, 17 Sep 2025
 07:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-3-kuniyu@google.com>
In-Reply-To: <20250916214758.650211-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 07:12:10 -0700
X-Gm-Features: AS18NWCAau_ISCJW2NiisMP2MdTsQUD7E0XFOZ9_YIDB3ZtJtTZASFjxfnUN0ok
Message-ID: <CANn89iKRUecXnVQYw+oDM78z5-sE3M4ZoJzGtpWWmEfZVdALdA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/7] smc: Use __sk_dst_get() and dst_dev_rcu()
 in in smc_clc_prfx_set().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> smc_clc_prfx_set() is called during connect() and not under RCU
> nor RTNL.
>
> Using sk_dst_get(sk)->dev could trigger UAF.
>
> Let's use __sk_dst_get() and dev_dst_rcu() under rcu_read_lock()
> after kernel_getsockname().
>
> Note that the returned value of smc_clc_prfx_set() is not used
> in the caller.
>
> While at it, we change the 1st arg of smc_clc_prfx_set[46]_rcu()
> not to touch dst there.
>
> Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

