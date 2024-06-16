Return-Path: <netdev+bounces-103819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDD9909AE1
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 02:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1362829A2
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6019D883;
	Sun, 16 Jun 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi1ZCA3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC11847
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718499582; cv=none; b=NozKpG+dLKL5FCZpk/TeEvfIQbeJM6Ksj+VchRnse/RmNDnPx/LHmLBZjtFbxUguFNOq2k2zA8AADqONf32WnwGr0AnGrWM80tB+U9KQ4WHhUVQIMHD/AW53HafoWvaEltg6a9Pz6ZWNyeACwRE18DrJ7OczGEY646KDadaSQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718499582; c=relaxed/simple;
	bh=bczbtfmuUFuzwcB/Jva6HuCWrmCYtSqfqx8XaoUW1uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrcpbrKdmk3hPzPhHUGC1D89EuEzQvXZS4nlYrxT2BlCZmxl/LMFIZ53TQ9Q1xMamEZdJ78le0jmCgUPdFyHVfuEMciYewKVGopFxZUQ5jb9wCKN1Hz1ciSNihG/Ddxj3oLOgzoy9Jbvb2kTkYm2BavOwxVv9q38AoJcVENdTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi1ZCA3j; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c6011d75dso3994015a12.3
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 17:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718499579; x=1719104379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oitD049c3ru4Mw040oUrvTlgnNPnCqDCXvuuTGbKCA=;
        b=gi1ZCA3jWgxoLzUwhz1kEUz0pFNyiob7ZOU6kBl3Snn3f7ZKy+RwbRT+heCKcwIKic
         OsPId9YMBC4kDQVqnlfhbRFVIYjWKiRzdW2hrbyhwopOSE8E4/F0VcDW3JDVrlOMylzg
         FvQep+oZ0sKNglNXJ89gTa3OebUcb2K6a0JubYhMaeg0fENfrdr1uVWE7tiYcvBz1rY/
         y4jD2DROFFYNGkdGZALp7miK0v+Zd+0D6ZesmdO4H2X+1RQUqA+Iv0TJlKd6dBBwUAO/
         53Rm3VjQ2pwJAqUmku4g3qqS5r8GSxdoN8Mje85ZMKIXLmuRo+gSMsF21k0VIY8Ks5R9
         MoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718499579; x=1719104379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oitD049c3ru4Mw040oUrvTlgnNPnCqDCXvuuTGbKCA=;
        b=IkFjfLMkDieWQOLOw9l/I5H6u82ZeEBLkC7KMMph9vaHSVosAXxSiCB1iP8TNpaw0s
         w3TSVW0gKUH/z4kQdEWwvx5/nUSOxC2C3ZescySlGYnKwf7zTfsHZ2CUGHdx1ZGFOWHn
         Gid3FMSvQSQ/ZQsS/rQc1/S7PeLxOwC4JPTEWFDT3tnWCOri+mLd0P+cld8TJkdLNE9N
         IDO0wc9DL7hNDRWeDJyaGjK4ivwk+pYNdHWo7TdtpYwbrE87DhmE23/h978kTzfMQP0O
         G8PHXBqkUvP2jdkVgj3eUTkWMmJXBs1IkjHPNYJjibpV/5de98Gq+NCVDE0ftOCp9ahW
         vUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX16+Fe77iR9cC9cRSa9AqyXiKqd+IyvG6LskugisHlXsuUm8I1eBAMZyqVgk8ugoayUkszGT8gST11X2O8CTmdZXKRXcNs
X-Gm-Message-State: AOJu0YwqtT3nvpOrf6HzTidZ+K30/gQ9H7sqGC3iwC8wV+qCXzKblIj1
	3WQkFcWI9907MypZYQ9vzjrHEWeyUpmV7SCDeVb9oTVEfK6b0hWE7BUfGX9MSkd6Gos/PzFstkA
	Rom70N4HNFEdv/kt9Ces4mUY14Uo=
X-Google-Smtp-Source: AGHT+IGmNsFShYM/M3EGHpmA9ji0HYxvWTDpD/jatTRiID+f2mwigBCkqxDsy+2qE/7chb7UhocsOV9y6TtJzeGWeFk=
X-Received: by 2002:a50:ed82:0:b0:57c:bf3b:76f8 with SMTP id
 4fb4d7f45d1cf-57cbf3b7900mr3981481a12.1.1718499578431; Sat, 15 Jun 2024
 17:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615151454.166404-1-edumazet@google.com>
In-Reply-To: <20240615151454.166404-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Jun 2024 08:59:00 +0800
Message-ID: <CAL+tcoBkzoehNPvjVe89to7fBqaFdh2Wo5VZF=o54cprJtr6aw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: prevent possible NULL dereference in rt6_probe()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 11:15=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> syzbot caught a NULL dereference in rt6_probe() [1]
>
> Bail out if  __in6_dev_get() returns NULL.
>
> [1]
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc00000000cb: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000658-0x000000000000065f]
> CPU: 1 PID: 22444 Comm: syz-executor.0 Not tainted 6.10.0-rc2-syzkaller-0=
0383-gb8481381d4e2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/02/2024
>  RIP: 0010:rt6_probe net/ipv6/route.c:656 [inline]
>  RIP: 0010:find_match+0x8c4/0xf50 net/ipv6/route.c:758
> Code: 14 fd f7 48 8b 85 38 ff ff ff 48 c7 45 b0 00 00 00 00 48 8d b8 5c 0=
6 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48=
 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 19
> RSP: 0018:ffffc900034af070 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90004521000
> RDX: 00000000000000cb RSI: ffffffff8990d0cd RDI: 000000000000065c
> RBP: ffffc900034af150 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000002 R12: 000000000000000a
> R13: 1ffff92000695e18 R14: ffff8880244a1d20 R15: 0000000000000000
> FS:  00007f4844a5a6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31b27000 CR3: 000000002d42c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   rt6_nh_find_match+0xfa/0x1a0 net/ipv6/route.c:784
>   nexthop_for_each_fib6_nh+0x26d/0x4a0 net/ipv4/nexthop.c:1496
>   __find_rr_leaf+0x6e7/0xe00 net/ipv6/route.c:825
>   find_rr_leaf net/ipv6/route.c:853 [inline]
>   rt6_select net/ipv6/route.c:897 [inline]
>   fib6_table_lookup+0x57e/0xa30 net/ipv6/route.c:2195
>   ip6_pol_route+0x1cd/0x1150 net/ipv6/route.c:2231
>   pol_lookup_func include/net/ip6_fib.h:616 [inline]
>   fib6_rule_lookup+0x386/0x720 net/ipv6/fib6_rules.c:121
>   ip6_route_output_flags_noref net/ipv6/route.c:2639 [inline]
>   ip6_route_output_flags+0x1d0/0x640 net/ipv6/route.c:2651
>   ip6_dst_lookup_tail.constprop.0+0x961/0x1760 net/ipv6/ip6_output.c:1147
>   ip6_dst_lookup_flow+0x99/0x1d0 net/ipv6/ip6_output.c:1250
>   rawv6_sendmsg+0xdab/0x4340 net/ipv6/raw.c:898
>   inet_sendmsg+0x119/0x140 net/ipv4/af_inet.c:853
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg net/socket.c:745 [inline]
>   sock_write_iter+0x4b8/0x5c0 net/socket.c:1160
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0x6b6/0x1140 fs/read_write.c:590
>   ksys_write+0x1f8/0x260 fs/read_write.c:643
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 52e1635631b3 ("[IPV6]: ROUTE: Add router_probe_interval sysctl.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

