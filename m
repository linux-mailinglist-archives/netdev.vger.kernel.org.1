Return-Path: <netdev+bounces-115172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD994559B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8AB1C22FF1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16BDDA6;
	Fri,  2 Aug 2024 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZwI7NPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05ADBE4F;
	Fri,  2 Aug 2024 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559062; cv=none; b=mmq/37ifod2hVK34K0JxwKD4r6VsTOqg34LUWA5tGRBATghO2PCH+lsj5Q9LZzqHtg/jdNxzywg5dxCau2ZG2hvSCQ5LJdMyEvJB2ERrrNzaaX+E1rYajINnngT6lpVkDIgVagV/04RyyRHg4cNwzZTlxo2aC4vhoMrrvsLODq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559062; c=relaxed/simple;
	bh=Oc0RKRV7Qy6RaugGqRZKS/u0ypfIzlrYBqdfH1TB1to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIplPhwLmFXOYz+6Otgm29ujAtK7stR8G5vw6G0i1CL3Qt5BfC6i6D+dHWGN3EjqAEzFSwhH86GviF5MLkEl4UmVFTAQVrzLNZXWc2lW42pfX4oeTXmRRkHr7L8xWmP7WLGIIlAdoGOPPk0sNpwDOm7stUluxpWDWW2gvHiIt+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZwI7NPd; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a130ae7126so5365302a12.0;
        Thu, 01 Aug 2024 17:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722559060; x=1723163860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L2A7NEDDRGInYEkQWLAcEXHZ7oVnJcLc8POataRsaog=;
        b=kZwI7NPdPx668CS+IYIHx0yVjZsNjYQuVUaMBLp887PeO/Xz0sZn8FkO6Wp0VdzyOK
         u81+ZqzDUVSDy1NgXoyl5QC6CpDHSfFGFj6QAM/kaZgRGgrFCoJMWRKm/3bi6t65pDz7
         K40NQYLLQ1or7g17kyfFBZng4Hd9SoZWaLyfoyRo1kndJw8mERnZ3Xj00qbB67f7UAEZ
         cnUMz+5Ts+SbH09pAKpxM6LMppKLzozBQ6VK4raI3Q1iOZEjXVocdnj6gtgA7hqL7UfF
         vJfaEa2sKEvmuLQEsgpWvTPx8IOKsO7SVRFZ0vtsCKZkRoA0sPtKGOt8eBr1pzpV1dwK
         IGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722559060; x=1723163860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2A7NEDDRGInYEkQWLAcEXHZ7oVnJcLc8POataRsaog=;
        b=pqtioyeZCCg+7FOwPwKhF8NNLOYXQjcKq8J1CRa9Vor3ypgqndBcw7dKsvL48yDlJp
         2v1eLc5Qr5optcqpGU/VJQQVlVH/KqwZ6e7zKb1v0BcBQ44CTB01ML5i4flANY5M0aB2
         B+9r9y6q1VQ70T8i0Q8Yulzci3c6WANv7eTxH7k06SheOsPd/Ylde0Mx6o2/OzPifwHH
         JgDNtFdS0AC22SNuYS+MX9zxkW/Iz5wYCXHOZJ/ad423c5yJ9ZaLl+MUzEE/jKI5XKZv
         alwPhKvjA7J8dNKf9X0uxxM1LlOeGR5eJpf5CdoUV4vUuNFlYB6O5aACD7md/EYzZgKC
         Np5A==
X-Forwarded-Encrypted: i=1; AJvYcCX6QbmXrS83Iug703gnKAZn32IdI+ER1xhxwJT1xn5WaQ6+X209bXhqMhx/6JZ5nClFlp5582ybkHpkwmf4wZNkHM7JI+5N8Wx7ONhT29hFXosE500FQcD4rtGPw2yODD53dr07
X-Gm-Message-State: AOJu0Yz1PPwaO/dKwPM0bkLPJT4SwsIb8mvFOQPWJF0L0bQ36A9s2gxr
	aTr4+4RKcfVHc+shsPv/NV0zOG9FtO+7UVHUgMld1qOy4I2kgApV4jvByMVrLIFas46kpQ8TcGy
	7wMb75tEEbhg8rok25noVcDCC+p8=
X-Google-Smtp-Source: AGHT+IEXeJ9cZb4o3bpwIYi3OLSlk3xw4wgg05RyGGyW6hz9lotbr6K6dXKzvKIiM9mA08Trb9XZtu5lNC21gQVcU7Q=
X-Received: by 2002:a05:6a21:3997:b0:1be:c4f9:ddd3 with SMTP id
 adf61e73a8af0-1c6995ab171mr2606139637.24.1722559059985; Thu, 01 Aug 2024
 17:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-tcp-ao-static-branch-rcu-v3-1-3ca33048c22d@gmail.com>
In-Reply-To: <20240801-tcp-ao-static-branch-rcu-v3-1-3ca33048c22d@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 2 Aug 2024 01:37:28 +0100
Message-ID: <CAJwJo6Z-qsZ9ZLV7qHrc=ujYT0Q2Ayod_C6e9kM+2QH48z650w@mail.gmail.com>
Subject: Re: [PATCH net v3] net/tcp: Disable TCP-AO static key after RCU grace period
To: 0x7f454c46@gmail.com
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Aug 2024 at 01:13, Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
[..]
> Happened on netdev test-bot[1], so not a theoretical issue:

Self-correction: I see a static_key fix in git.tip tree from a recent
regression, which could lead to the same kind of failure. So, I'm not
entirely sure the issue isn't theoretical.
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=224fa3552029

Yet, I guess it won't be any worse to fix this, even if it is theoretical.

> [] jump_label: Fatal kernel bug, unexpected op at tcp_inbound_hash+0x1a7/0x870 [ffffffffa8c4e9b7] (eb 50 0f 1f 44 != 66 90 0f 1f 00)) size:2 type:1
> [] ------------[ cut here ]------------
> [] kernel BUG at arch/x86/kernel/jump_label.c:73!
> [] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [] CPU: 3 PID: 243 Comm: kworker/3:3 Not tainted 6.10.0-virtme #1
> [] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [] Workqueue: events jump_label_update_timeout
> [] RIP: 0010:__jump_label_patch+0x2f6/0x350
> ...
> [] Call Trace:
> []  <TASK>
> []  arch_jump_label_transform_queue+0x6c/0x110
> []  __jump_label_update+0xef/0x350
> []  __static_key_slow_dec_cpuslocked.part.0+0x3c/0x60
> []  jump_label_update_timeout+0x2c/0x40
> []  process_one_work+0xe3b/0x1670
> []  worker_thread+0x587/0xce0
> []  kthread+0x28a/0x350
> []  ret_from_fork+0x31/0x70
> []  ret_from_fork_asm+0x1a/0x30
> []  </TASK>
> [] Modules linked in: veth
> [] ---[ end trace 0000000000000000 ]---
> [] RIP: 0010:__jump_label_patch+0x2f6/0x350
>
> [1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/696681/5-connect-deny-ipv6/stderr
[..]

Thanks,
             Dmitry

