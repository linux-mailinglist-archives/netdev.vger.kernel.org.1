Return-Path: <netdev+bounces-119647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A917956796
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460531F22670
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D615D5B9;
	Mon, 19 Aug 2024 09:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D915B14E
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061270; cv=none; b=a100SXjk2BKmbiG1kQFV/Tub9udS5RKh72lOQyU1zypC+pIHx3UG3LObw+ZL2jOZAAU5stqWgv3k+1J754ZpBxoNo3cUXsuJs5bUwBWEMg758eESFFmTa50wkFyWVhDF9k+Qvl1T3B3dvPH9rq3xM/yTgV55yVXcWFNlbLcXqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061270; c=relaxed/simple;
	bh=RrBDJWHpAdg8rHCT7wqN9mYcvi7P6l2XJi9pE83m3Po=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Eq09iDo+WFkNW2dzALYV1VHbkZfEAHIHgiIaCCvIwWL2Fd/FonkglEHf/PQ4icVti4OzaEkgFqk0o0rXrgzIiNkj85YewwI/USwQwCu48jQQ1gbpvTV048DnIQsVjAJ5beUVcbw2ge/VZw1iOF3kdr3dPsg4sKhzzO2Ty514sOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so12138445ab.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724061268; x=1724666068;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljoxjEh8WVeAm+Ar8EhWx4Gr/MVmjd/vL3IPlzOkBQQ=;
        b=YFoMLmBHVW1wUWwodpytvTz78xPCdpXMXiEYY0j6o3QNhP42zaUCM7fOSPNUQ5vWyz
         bAT/BIdoCDwSJSs3lbdO36a7Nj5wsWR4qMBwuG7iBw5MHNY0e2vluWIClEDWS36mx2xc
         70lpyS5a0DaWWEhkohoHIWziHKiluUSKaoY6n2BxHQhGgkObkRwx9D6l/vwgf09nv1tM
         VanjU9Wg2xEK+1SgFBkcw2L7rylTqesz6euz04qnrW+UoTle7klQmeCoA4PcdRJiLbN2
         l8KudVNMQLty04Egp5EI5vt1sTXS+KLejLDaUI3h+sbnLHMQ/evt1rZNvTAPRSGXPlFh
         du2w==
X-Forwarded-Encrypted: i=1; AJvYcCUVgm3dYV2wIK+UYDiX/DwZvtrZ9yvF+69vTXlgftYdAaCUQUB/P3JZLBBOcFwCZwrOsNa2iWtehxjy3UoOoCZ4h5datLXo
X-Gm-Message-State: AOJu0Yz0C0AOLU8whGkSCzisZZjdz26CWs3nTWx6J6zLKM31K8wyG6FR
	lrsudNG3aEUz2bJwwCbG1qfvWlk+ocgzCpB/ZeHmrtc97VSOQGSOyC6pww+uaWUKfUTJSvHvIkn
	fMAe9mfNZKJzL6h2QTlvJbjr3/T7DSFg7H+3Ezb+6rwUx/fyONHIYWEg=
X-Google-Smtp-Source: AGHT+IGusgAhpaztFb4Cz/QXiMdd2iNt9riXqvTXGegIT00KvyvIGKZkvzs4V0hWcySYLtbe64orgUFjLr+blFoGDHQGYoYc8dwo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170e:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-39d26c46d13mr11064825ab.0.1724061267907; Mon, 19 Aug 2024
 02:54:27 -0700 (PDT)
Date: Mon, 19 Aug 2024 02:54:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071e6110620064b4c@google.com>
Subject: [syzbot] [net?] UBSAN: array-index-out-of-bounds in cake_enqueue
From: syzbot <syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com>
To: cake@lists.bufferbloat.net, davem@davemloft.net, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a99ef548bba0 bnx2x: Set ivi->vlan field as an integer
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10baacfd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=7fe7b81d602cc1e6b94d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d555f757c854/disk-a99ef548.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e46d450e252/vmlinux-a99ef548.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc2197d1b6a7/bzImage-a99ef548.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/sched/sch_cake.c:1876:6
index 65535 is out of range for type 'u16[1025]' (aka 'unsigned short[1025]')
CPU: 0 UID: 0 PID: 5282 Comm: kworker/0:6 Not tainted 6.11.0-rc3-syzkaller-00482-ga99ef548bba0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 cake_enqueue+0x785e/0x9340 net/sched/sch_cake.c:1876
 dev_qdisc_enqueue+0x4b/0x290 net/core/dev.c:3775
 __dev_xmit_skb net/core/dev.c:3871 [inline]
 __dev_queue_xmit+0xf4a/0x3e90 net/core/dev.c:4389
 dev_queue_xmit include/linux/netdevice.h:3073 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip6_finish_output2+0xfc2/0x1680 net/ipv6/ip6_output.c:137
 ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
 ip6tunnel_xmit include/net/ip6_tunnel.h:161 [inline]
 udp_tunnel6_xmit_skb+0x590/0x9d0 net/ipv6/ip6_udp_tunnel.c:111
 send6+0x6da/0xaf0 drivers/net/wireguard/socket.c:152
 wg_socket_send_skb_to_peer+0x115/0x1d0 drivers/net/wireguard/socket.c:178
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1bf/0x810 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

