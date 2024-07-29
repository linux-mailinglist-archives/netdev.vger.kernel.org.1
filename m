Return-Path: <netdev+bounces-113522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A351D93EDC4
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 09:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AFD1C21AF5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 07:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6426A8DB;
	Mon, 29 Jul 2024 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3SNZx4Ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22C43AAB
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236454; cv=none; b=jX9FgUIUXfCjrz21X8hvsc63wTvnYgyoD9Ai/89fBV6gkVH2qiLraYo0G12G3MUA5fW2bn1CTl3pvTfIXTylYwLo2sF2S7bimNfxYhr63lEH/qJPos9kamJvF9fPC4FdmmC1p5CAUJg4O0kOF+Mdr1IC2wiJKvDu3izpTiXHpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236454; c=relaxed/simple;
	bh=QC2zEFhg/lyU6R8nhPbQFI4czkLYimOe833OUC3aBR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ3Q2r1gra6k0JI8LxjfOkZ5idZButpoOtIY/8RyclBHr0tyozTs4UfQznQLqH7yz4vks7Mifg6qobH2YbQcQVvZyXPMdsyb3cbsZEMmVunZnXfC6gSyKYenq7n/6vX+Hf+0RWeYzmzosFpxL1XfaiARTxRfMZYmyrsbjQKsBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3SNZx4Ay; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427fc9834deso41435e9.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722236449; x=1722841249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyT10splMgtMw/AFP/gfQzuxNIy03OHVny+AJXPnBKs=;
        b=3SNZx4AytHU2UXj0sZd1RneFp7fMYKJAbDg0nncFpMhokgCPZxqezQBUC567B5I14T
         oZb15w1WI1wljq+x3xqxp3tI6CksW4mhPXWSR6OETSZSa7H6LeeUCzx+N5FJC5jH+nHt
         7Ia8C+EE3A84mFcMzlYJV6ziC9zsPLW0oti17EqsNNWqZRUCuhB5gcD/8CYQla5D4bOn
         IDE9MyT90ErvuxdDDgS+VxB5W6/IRKgiWPKUC6WLwPsJgfFX2gFSS004lQAikjNBfm3c
         XXhgWnsv0eCPK0vkBVYqV6C93t+W1MOX2TWSnv0qmijwVWBgAdLqrM0/jIGVJmVj+rdz
         arOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722236449; x=1722841249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyT10splMgtMw/AFP/gfQzuxNIy03OHVny+AJXPnBKs=;
        b=p96J4zVc8vfWc+wjQZPlG/Y84E9yoir1nZ0l/LC7chKd5Ybd5F8UeBcoVvsdrzafKa
         Ulw9izqwNro3wZkA/Ao0NDnUllfrHzbEEYoUsr412ju9Gs3S+/GTNaDxmjSxTNSfCJ3e
         yo55iw4IvnZnKCYfvBVsuYv8Zqcs4Mf6rCCyMAQojbgfY4gsH1NWSGYfXNaNa9QMSQeU
         e/K0Ijlneh2XHizMsu34Gcn/y8QNNpKmfxL21zmOxFbUcX9+au6YKpLfJr9TOjR96kCs
         pd/7Jvl8+6y4k375CXmNsV9U6NCK7r2uppZPvSwgJAkSwnRoGhlzai3fWAMgmxS1emro
         30AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEZRE8GbQK1WXSSTRypkbBSm8PvxAJ9r+b3yeOpy3N0GKiAeUnizRL/lvi0c4ovzunbJ6rDeK4/BfNusovjW+ZbnNz8RHj
X-Gm-Message-State: AOJu0Yw8NSTWhQAYE6ENY8du5arkAtp7nFYVdH7ES3VWLU8sTUHwFgji
	bKlm/oI0PQB+HHyDk1bcoA08xP9tx+FuJYfwSLwXS3NqGyqBlsnsrBTGqtyaUB7Kmayd29ijVwL
	FFi9ytxl9DITiLDWQD7MKKaQakvUbG0CYGJNdc0mQvYXu3K9CNQ==
X-Google-Smtp-Source: AGHT+IHvsSzJz9EtBDktbI85ocx6MHTolOoKpJRvV8XQ287h4mh4kZ99zdHYDANoZv/yOMcrJWWuHK8UYNNGMaDsEy8=
X-Received: by 2002:a05:600c:3542:b0:426:66fd:5fac with SMTP id
 5b1f17b1804b1-4280b0f0565mr4648255e9.2.1722236448699; Mon, 29 Jul 2024
 00:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722224415-30999-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1722224415-30999-1-git-send-email-alibuda@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jul 2024 09:00:37 +0200
Message-ID: <CANn89iLrazeVmu+vN8o8+kPoY0+Yf032G_J7GcfufUTRhyng2Q@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: prevent UAF in inet_create()
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:40=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> Following syzbot repro crashes the kernel:
>
> socketpair(0x2, 0x1, 0x100, &(0x7f0000000140)) (fail_nth: 13)
>
> Fix this by not calling sk_common_release() from smc_create_clcsk().
>
> Stack trace:
> socket: no more sockets
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
>  WARNING: CPU: 1 PID: 5092 at lib/refcount.c:28
> refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> Modules linked in:
> CPU: 1 PID: 5092 Comm: syz-executor424 Not tainted
> 6.10.0-syzkaller-04483-g0be9ae5486cd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 06/27/2024
>  RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> Code: 80 f3 1f 8c e8 e7 69 a8 fc 90 0f 0b 90 90 eb 99 e8 cb 4f e6 fc c6
> 05 8a 8d e8 0a 01 90 48 c7 c7 e0 f3 1f 8c e8 c7 69 a8 fc 90 <0f> 0b 90
> 90 e9 76 ff ff ff e8 a8 4f e6 fc c6 05 64 8d e8 0a 01 90
> RSP: 0018:ffffc900034cfcf0 EFLAGS: 00010246
> RAX: 3b9fcde1c862f700 RBX: ffff888022918b80 RCX: ffff88807b39bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000003 R08: ffffffff815878a2 R09: fffffbfff1c39d94
> R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: 00000000ffffffe9
> R13: 1ffff11004523165 R14: ffff888022918b28 R15: ffff888022918b00
> FS:  00005555870e7380(0000) GS:ffff8880b9500000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000140 CR3: 000000007582e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  inet_create+0xbaf/0xe70
>   __sock_create+0x490/0x920 net/socket.c:1571
>   sock_create net/socket.c:1622 [inline]
>   __sys_socketpair+0x2ca/0x720 net/socket.c:1769
>   __do_sys_socketpair net/socket.c:1822 [inline]
>   __se_sys_socketpair net/socket.c:1819 [inline]
>   __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbcb9259669
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffe931c6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
> RAX: ffffffffffffffda RBX: 00007fffe931c6f0 RCX: 00007fbcb9259669
> RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 0000000000000002 R08: 00007fffe931c476 R09: 00000000000000a0
> R10: 0000000020000140 R11: 0000000000000246 R12: 00007fffe931c6ec
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
>
> Link: https://lore.kernel.org/r/20240723175809.537291-1-edumazet@google.c=
om/
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

