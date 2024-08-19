Return-Path: <netdev+bounces-119681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2B956936
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE01F2242F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F591662EA;
	Mon, 19 Aug 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJY2FavS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA96160873
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066357; cv=none; b=YWJ+6i4D+/ccTZKuGbIJh958+S+X/gQfeG7g2EWCXEB/mVySa2lB1Kz04CMaMsGUhzcQPV7Wo2BCFIDu/1Td5ywzYJZhbqim1eCEbnm1NmoWUNqt4zZatHlQro4Zzo1CN+zcI/8qrT7TLLGLYy9Ija19bLB62bmgK/Ka340q2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066357; c=relaxed/simple;
	bh=46cWkGDo2Lqa7VWxv+DeSe8M2+LrvK6FfF/+VBw90uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eP9FJZzBufdzrI/JXbWYpSb17yxKrMOy/Hr3K8k1mV7cMqUp7j5Rt6kyNGr0yEWnCTu5OJCbpiObjUgKScSkRWhX6+KMqYArb2x6ObmmB30IVfDyWvPhz67rumMJOZsy0OxwUUutXNk4Ex+HYIg2ZiwoRLgABizmzPb6kDM1sLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJY2FavS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3b4238c58so3264330a91.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724066355; x=1724671155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHK6R/RvDW8CWcE0taWqbBxiWW9hnb+v42kzzHD0MlQ=;
        b=bJY2FavSkbypS3fQJI84DiKWYYA9EZVe9j1XQw5tjGPtWNlh9IPuqfCXN8jQgn+pV7
         i/RwygDRVA3ljhcbzBRgGXCdOqLmHQnM18xhgxdjHj2WDV36eXNpyPeBs7Jreqts9bHX
         8rIaoued5YxSxDAlIicix+wHbGSp5OWohbE24fXOl2oI3Oc401aJCityo/pJgwt+BPmj
         gUyMlPLD/CWSEykIcBFywe9ceaeGmp/8AuDYNw48vTbS7gYOi9m+5q+azs4ERjti95Pe
         1/DqRgyEZGDw4dOJiMEDPnmrG05M+j54bmqAFIEs85JJduIwrqfi9Kn17w7kO9HXZGwx
         qGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724066355; x=1724671155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHK6R/RvDW8CWcE0taWqbBxiWW9hnb+v42kzzHD0MlQ=;
        b=uaHA8TzcwnC9LkODXKKk/GP11MY2fUF0g6hdT6glPG5JxNnK3oyFtLt9Usa/1uvMoz
         6NGj2SsDqoXReFflnV7mLvpjQobnsqZkGRs+Ef7AUzFxAMwtrxQuj2aq8SVIZxgLYs7D
         TU6aY0O5pcOHliSM1TAdJKVgYukTkfYMhEDaaXUnT6QXo6f7xV1Yes0MkMnH40pNhb6D
         fLMvH+nwEAbOi6GdBtiOtAeWZQaLh+mjejcNUPJ26qRRKLJlkOsecUZ8nh2dsIXowMNl
         NDu2fQUY6HA2uktHne+wSUIu9yIyCofZW+ViiZxD5jTHKe7XaTMszYMPIEXIqwkGtz1E
         Ajyw==
X-Forwarded-Encrypted: i=1; AJvYcCWhq4WTxikTYCi85wQ5LR4XHK0hlOt40STeqQpWahoLCcPYAT0Eo4ClxQfOaCQVqr510Hg2p0+8E4ugwVEB4fGphh31BXd7
X-Gm-Message-State: AOJu0YwfZFUDGoG93vnCnfeM5ELMAKRlmYO4LA1TI8vw+DvRx3+zxEik
	5hqZKpeEARfcZTnOVUgZfRydniiNfpu1DMgIG9ujHrv/xC31UThJ9YIbEw44Syy7iWJN458znLy
	RF3rWKxGERf36uwwFxUJ5A5AbC6F4u2blixj8
X-Google-Smtp-Source: AGHT+IGgQqUyi2W70LdUKCYLxCDJfTw6Tx4QA8jq6q9ULEmgQnf5zwnyjEcBvdY/s9KhfXxxfZTCTOUcC+WYAQohIOQ=
X-Received: by 2002:a17:90a:c58f:b0:2d3:b55e:5f2 with SMTP id
 98e67ed59e1d1-2d3dfc4ac67mr11882750a91.14.1724066354447; Mon, 19 Aug 2024
 04:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000071e6110620064b4c@google.com>
In-Reply-To: <00000000000071e6110620064b4c@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 19 Aug 2024 13:19:02 +0200
Message-ID: <CANp29Y6xOzoQ4UKKta2_a6zaQv-xqadZD0q5QrLtVNj1uPe3BQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in cake_enqueue
To: syzbot <syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com>
Cc: cake@lists.bufferbloat.net, davem@davemloft.net, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz upstream

On Mon, Aug 19, 2024 at 11:54=E2=80=AFAM syzbot
<syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a99ef548bba0 bnx2x: Set ivi->vlan field as an integer
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10baacfd98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7229118d88b4a=
71b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7fe7b81d602cc1e=
6b94d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d555f757c854/dis=
k-a99ef548.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8e46d450e252/vmlinu=
x-a99ef548.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bc2197d1b6a7/b=
zImage-a99ef548.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in net/sched/sch_cake.c:1876:6
> index 65535 is out of range for type 'u16[1025]' (aka 'unsigned short[102=
5]')
> CPU: 0 UID: 0 PID: 5282 Comm: kworker/0:6 Not tainted 6.11.0-rc3-syzkalle=
r-00482-ga99ef548bba0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Workqueue: wg-crypt-wg0 wg_packet_tx_worker
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
>  cake_enqueue+0x785e/0x9340 net/sched/sch_cake.c:1876
>  dev_qdisc_enqueue+0x4b/0x290 net/core/dev.c:3775
>  __dev_xmit_skb net/core/dev.c:3871 [inline]
>  __dev_queue_xmit+0xf4a/0x3e90 net/core/dev.c:4389
>  dev_queue_xmit include/linux/netdevice.h:3073 [inline]
>  neigh_hh_output include/net/neighbour.h:526 [inline]
>  neigh_output include/net/neighbour.h:540 [inline]
>  ip6_finish_output2+0xfc2/0x1680 net/ipv6/ip6_output.c:137
>  ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>  ip6tunnel_xmit include/net/ip6_tunnel.h:161 [inline]
>  udp_tunnel6_xmit_skb+0x590/0x9d0 net/ipv6/ip6_udp_tunnel.c:111
>  send6+0x6da/0xaf0 drivers/net/wireguard/socket.c:152
>  wg_socket_send_skb_to_peer+0x115/0x1d0 drivers/net/wireguard/socket.c:17=
8
>  wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
>  wg_packet_tx_worker+0x1bf/0x810 drivers/net/wireguard/send.c:276
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> ---[ end trace ]---
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000071e6110620064b4c%40google.com.

