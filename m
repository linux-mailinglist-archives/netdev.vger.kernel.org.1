Return-Path: <netdev+bounces-31063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B4178B345
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 16:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C360B280E5D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B912B82;
	Mon, 28 Aug 2023 14:38:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE112B7C
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 14:38:02 +0000 (UTC)
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E9DA
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 07:38:00 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-56c3a952aaeso2309161a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 07:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233480; x=1693838280;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmRiZBc5HCblJEbCIKWt1uD5ovx7rjelIR0f5QBCNxQ=;
        b=Q6oyrjxfX9zV37Kn+hR/KvZJCGFFRvHXt782lh+g9UTbONY9ekhYQIi4THjh6QjsBQ
         iht/AeR3osbf9yGphPS6Mn/pVP6nrRxOR3QMI8iKEA/L3u9/1il0rWHJWy3dQ6fONglN
         CS8PmX24rWztfXacipy5Sd/XNvxvoeWVi1+Ml23qty/uXRV0C33S67LDBXO57JZLvFEa
         3UMKvdFViczMkZ99Ci1RZULbOngtPrxowmVQtVD+71X5fbAXiDz6R2ptS3d7dc5zGYGf
         dwtePNVqTaa5m3B7LwmGtfi64c0HpLHyk21n86f44M93WQL71Yiin1iy8rbunH8+smkX
         kK9g==
X-Gm-Message-State: AOJu0Yz6QU5Cw+kqkFKux95RmprQYIfLS4euRX2rhar49/3b/gKvKHcu
	mN32CoIQkiRKaHPqJJjSzXsE/cUF1+GOwjLydOnfN0XpTZBI
X-Google-Smtp-Source: AGHT+IFaye4MByhCOewIGlSCwLtg8Z/vOBiPRuzRozvzwdGRCFy00QlSZCEtFTEW+JQW66o0KKkiwKnS+3XY8b/1/e5IzqXetTbA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:3409:0:b0:569:50e1:5469 with SMTP id
 b9-20020a633409000000b0056950e15469mr4313236pga.9.1693233479910; Mon, 28 Aug
 2023 07:37:59 -0700 (PDT)
Date: Mon, 28 Aug 2023 07:37:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000178d930603fca43b@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_packet_handshake_receive_worker
 / wg_packet_rx_poll (5)
From: syzbot <syzbot+80a98381230162731266@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    93f5de5f648d Merge tag 'acpi-6.5-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f3d75ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f12c32a009b80107
dashboard link: https://syzkaller.appspot.com/bug?extid=80a98381230162731266
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f2b512883ff/disk-93f5de5f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e10aeb67696c/vmlinux-93f5de5f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e95be907cb0/bzImage-93f5de5f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80a98381230162731266@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_packet_handshake_receive_worker / wg_packet_rx_poll

read-write to 0xffff88813939a178 of 8 bytes by interrupt on cpu 0:
 wg_packet_rx_poll+0xb43/0xf80 drivers/net/wireguard/receive.c:474
 __napi_poll+0x60/0x3b0 net/core/dev.c:6460
 napi_poll net/core/dev.c:6527 [inline]
 net_rx_action+0x32b/0x750 net/core/dev.c:6660
 __do_softirq+0xc1/0x265 kernel/softirq.c:553
 do_softirq+0x5e/0x90 kernel/softirq.c:454
 __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
 wg_packet_handshake_receive_worker+0x184/0x5d0 drivers/net/wireguard/receive.c:212
 process_one_work+0x434/0x860 kernel/workqueue.c:2600
 worker_thread+0x5f2/0xa10 kernel/workqueue.c:2751
 kthread+0x1d7/0x210 kernel/kthread.c:389
 ret_from_fork+0x2e/0x40 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

read-write to 0xffff88813939a178 of 8 bytes by task 8583 on cpu 1:
 update_rx_stats drivers/net/wireguard/receive.c:23 [inline]
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:198 [inline]
 wg_packet_handshake_receive_worker+0x4b2/0x5d0 drivers/net/wireguard/receive.c:213
 process_one_work+0x434/0x860 kernel/workqueue.c:2600
 worker_thread+0x5f2/0xa10 kernel/workqueue.c:2751
 kthread+0x1d7/0x210 kernel/kthread.c:389
 ret_from_fork+0x2e/0x40 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x00000000000077a0 -> 0x00000000000077c0

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 8583 Comm: kworker/1:14 Tainted: G        W          6.5.0-rc7-syzkaller-00024-g93f5de5f648d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: wg-kex-wg2 wg_packet_handshake_receive_worker
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

