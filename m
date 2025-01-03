Return-Path: <netdev+bounces-154960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A8A007F8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FCC1883D5A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F21CEE82;
	Fri,  3 Jan 2025 10:43:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27E1B0F10
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735901003; cv=none; b=C2yf/Dk7N3zE38YOpFVAEt9tpn3oi4zGQmiF7tnbkAhfr0fY8oaG+N6shfuL2qrU60fsUunTFErgWSYCr2drEQ1Kxsv9mAHKsJDEjk/adFV7VaYE+dixzh6Uo53g3x90kgZg4erkV7C7SpLuAYvu1mcaExIlTgzp+YK6OXAXZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735901003; c=relaxed/simple;
	bh=pziRtZ7hlaYg+XzIO68q5bU4H2A/ucvPYkpa8CroKSM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nSIRMW6KN2XkJu4c5sziOHpl8Xyx9IY693cj9QtAUNX+JN8Anj4dOGSxMaKXmNsKtXuEH94J1iJknDxYvHpywuUuetyvGetY0kz1Qn7WF0ztk3QqqkB3Hl9v30Xr8CMbISnYtwr1bj0Kr89syRxTAJWfmxTPf0pEUmUJsUU02lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so120668385ab.1
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 02:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735901001; x=1736505801;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o41Fjl6hkNtY0kx62Q+YAuvs3iA6koqM2Y6qO7z9ehU=;
        b=uzVcwEafjmMF71g2osHXb+UZ8D1Eskjczh7I2ZXeizsFFT68mX+EPSYD2QjhUqJO//
         p8CVqUPmIdirixg76nvo0SC4IKcJQJ2T4EARzHVDUvlK2a9hVSeU874lQg4SRMFCXZmQ
         WAILD/V3I7SMfiU3VjTc26cLkbwA9Oyjf4CIgBgd1A/wLNjb2IyxaRPaL2BBXBrcZjtq
         1+7YBndHsV73sb60l2OXn/s9AqHaB+PiZ4c+J6K451V/0Sr3mzp0TL8+g//btHH9FJmW
         WoGC3S8YGZXxgR1Spa9orQSnE74Kc8RU03JB1bRmAqc/OMILOspURVdxgOTq8eIx6ahl
         g/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVRIW2chmuiN+mWmCiAD4Z9PzGwz5yviy3lSeA6r2DZ83h92ouY2VPNQypSeWxecgBCHH8k8tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBcvUnLW5kVbtIdqNP0JLeEdxF0jPEr5yF3t7vpXSP8mgKmRc
	vXqFLjpOqPcP7DaAHjKtRb8xJTTWSNoH+Kg6MJptlEO95M10TQt2OVlRpQwcxeeyzZJIf+CU8Ny
	bde7eSqNtlQwSlnE7f4v+rAAtyjdd8mLzJmxGLjyv074hlv76qGftpjE=
X-Google-Smtp-Source: AGHT+IHCADwRdrGMD48RP+vKGj2qOEUv27FLRgDVHvNdnBcz5amS4pH9rGBvcmbGSEcymGmTJWFiGx1YoC+rFZzSf69QPUy7MuyR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3284:b0:3a7:8208:b847 with SMTP id
 e9e14a558f8ab-3c2d58197b4mr352640465ab.22.1735901001025; Fri, 03 Jan 2025
 02:43:21 -0800 (PST)
Date: Fri, 03 Jan 2025 02:43:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6777bf49.050a0220.178762.0040.GAE@google.com>
Subject: [syzbot] [net?] UBSAN: shift-out-of-bounds in flow_classify
From: syzbot <syzbot+1dbb57d994e54aaa04d2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f619d518db9 net: wwan: t7xx: Fix FSM command timeout issue
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=171cb6df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=1dbb57d994e54aaa04d2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131abaf8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12227818580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7833c741299/disk-4f619d51.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5ca349f6388/vmlinux-4f619d51.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d85b222c4799/bzImage-4f619d51.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1dbb57d994e54aaa04d2@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in net/sched/cls_flow.c:329:23
shift exponent 9445 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.13.0-rc3-syzkaller-00180-g4f619d518db9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 flow_classify+0x24d5/0x25b0 net/sched/cls_flow.c:329
 tc_classify include/net/tc_wrapper.h:197 [inline]
 __tcf_classify net/sched/cls_api.c:1771 [inline]
 tcf_classify+0x420/0x1160 net/sched/cls_api.c:1867
 sfb_classify net/sched/sch_sfb.c:260 [inline]
 sfb_enqueue+0x3ad/0x18b0 net/sched/sch_sfb.c:318
 dev_qdisc_enqueue+0x4b/0x290 net/core/dev.c:3793
 __dev_xmit_skb net/core/dev.c:3889 [inline]
 __dev_queue_xmit+0xf0e/0x3f50 net/core/dev.c:4400
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:236
 iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
 udp_tunnel_xmit_skb+0x262/0x3b0 net/ipv4/udp_tunnel_core.c:173
 geneve_xmit_skb drivers/net/geneve.c:916 [inline]
 geneve_xmit+0x21dc/0x2d00 drivers/net/geneve.c:1039
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3606
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4434
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0x12c7/0x17b0 net/ipv6/ip6_output.c:141
 ip6_finish_output+0x41e/0x840 net/ipv6/ip6_output.c:226
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xb30/0x1450 net/ipv6/ndisc.c:511
 ndisc_send_ns+0xcc/0x160 net/ipv6/ndisc.c:669
 addrconf_dad_work+0xb45/0x16f0 net/ipv6/addrconf.c:4303
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

