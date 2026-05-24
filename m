Return-Path: <netdev+bounces-291185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Kx7gJHkBE2od6AYAu9opvQ
	(envelope-from <netdev+bounces-291185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 15:47:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB845C29B3
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748E73006B76
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D13914FA;
	Sun, 24 May 2026 13:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247E514B977
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779630453; cv=none; b=DTmbBOHF9ZJK6FAJ/qzkrJFfxvziO7Z9Gct18pq6DOtWEDPdBGMIV+pORtvqs8uZI/hfQCDotyLYVl1CSjtpAegScdHWrd7lu3dk+SBK+qe3cdZ/hAW/rzwMHCVl62N+vJkn/Ezi5raLcMw5gSa6dQHhagWuf8VLW+8LS2Hq4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779630453; c=relaxed/simple;
	bh=PEoiGksD4PCpHHeWGx7lCAc83nCAE0fFh5EJ1yfU4xw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kzj7Sm3YqIqnSObjka3yu6a4htodyusH9WQptu77aowXX9gAFcK2wsu5kKt4W5YJkbNd4HOFPzHs289tPeTWeUNwHqzHvU3zbXZxhYIPCXWs+mt8mu2ZEB8MO3BHVYmEVusv0X8DYx75Bx5dxWcapUoWLRwgiPNvbFwRJjshGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69d874805edso2939454eaf.0
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 06:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779630451; x=1780235251;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unDDpMxZWZ7/9Ca9G/V+zP2bMO2BkOIgx4WOAU+NDpo=;
        b=qAIwJPPTpsFWY8xm2bHriUs3gKfH7PQ0sNviD1n1T5rq07N6N2ILsSdQLBh3oZzZim
         1mGlBMAHVeo0cCSH2C/5zHyi+9qzdFVOTQg2eXWv+EOdhgrwbCP3u7W+uJS3BOtCSs2I
         wZ11GFff9N/PtkWC5N1QFTKtDRqAbrK7CPtw8TC089K9PomeeWzkrUIa3RR3F0/pesYK
         OumMJQl4BmG+FuH4470P+0kRPRoNTmffTmbEec0+pKPzunCmmLJGxiWpGd7wEMyETrAD
         tD4/VTgl6pNWgq8yqjAp0lqty7peYKTOG92hBXC7EGKH3FDm6hrkJ/k+TeNIkymqWqtF
         5cKw==
X-Forwarded-Encrypted: i=1; AFNElJ8Jr/0DvaE0FC7g0DXWkbpgrGAaYAOjrRSQt+Xd3v9PCR2IuCVylHQPOLbTPavYlABAww6NyEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOVadzjhMtOvQI1rx2FkHV7Q31BTj485ll2sbS93MeiJD0GZJ
	cMxbxQBkAIVvvlUFWj4S9ypB5PSJ9ELYeGeGVQPpbjTShdnvz0rKU7k9NrUOOVZ278YoAiH3pbZ
	m7C9mmEdvbnSJAu9nBAzue35cZ6Mf6B1FIFnBCSlvmGR6kNG928hKETxUtj4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9f:b0:69d:9547:c963 with SMTP id
 006d021491bc7-69d9547d12bmr3179614eaf.27.1779630451049; Sun, 24 May 2026
 06:47:31 -0700 (PDT)
Date: Sun, 24 May 2026 06:47:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a130173.170a0220.35b2b7.0011.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in genl_rcv (4)
From: syzbot <syzbot+c4e9d077bcc86bee08dc@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e0299bf0261ddd5];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-291185-lists,netdev=lfdr.de,c4e9d077bcc86bee08dc];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,googlegroups.com:email]
X-Rspamd-Queue-Id: 5FB845C29B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    c1ecb239fa34 Add linux-next specific files for 20260522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e1bcec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0299bf0261ddd5
dashboard link: https://syzkaller.appspot.com/bug?extid=c4e9d077bcc86bee08dc
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8845b668755/disk-c1ecb239.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/517b638d908a/vmlinux-c1ecb239.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd5e3b587fce/bzImage-c1ecb239.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4e9d077bcc86bee08dc@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.3.4345/21265 is trying to acquire lock:
ffffffff8f3f0600 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217

but task is already holding lock:
ffff888037262058 (&pipe->mutex){+.+.}-{4:4}, at: splice_to_socket+0x15f/0x11f0 fs/splice.c:805

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&pipe->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       iter_file_splice_write+0x1f3/0x10f0 fs/splice.c:682
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0xef8/0x1940 fs/splice.c:1349
       __do_splice fs/splice.c:1431 [inline]
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice+0x353/0x490 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sb_writers#5){.+.+}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       kiocb_start_write include/linux/fs.h:2767 [inline]
       lo_rw_aio+0xb1b/0xf00 drivers/block/loop.c:401
       do_req_filebacked drivers/block/loop.c:433 [inline]
       loop_handle_cmd drivers/block/loop.c:1941 [inline]
       loop_process_work+0x637/0x11b0 drivers/block/loop.c:1976
       process_one_work+0x98b/0x1630 kernel/workqueue.c:3318
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #5 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x8d7/0x1630 kernel/workqueue.c:3294
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 ((wq_completion)loop0){+.+.}-{0:0}:
       touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:4033
       __flush_workqueue+0x14b/0x14f0 kernel/workqueue.c:4075
       drain_workqueue+0xd3/0x390 kernel/workqueue.c:4239
       __loop_clr_fd drivers/block/loop.c:1130 [inline]
       lo_release+0x287/0x8f0 drivers/block/loop.c:1767
       bdev_release+0x541/0x660 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:705
       __fput+0x461/0xa70 fs/file_table.c:510
       fput_close_sync+0x11f/0x240 fs/file_table.c:615
       __do_sys_close fs/open.c:1511 [inline]
       __se_sys_close fs/open.c:1496 [inline]
       __x64_sys_close+0x7e/0x110 fs/open.c:1496
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&disk->open_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       __del_gendisk+0x127/0x980 block/genhd.c:710
       del_gendisk+0xe7/0x160 block/genhd.c:823
       loop_remove+0x42/0xc0 drivers/block/loop.c:2136
       loop_control_remove drivers/block/loop.c:2195 [inline]
       loop_control_ioctl+0x4ba/0x5b0 drivers/block/loop.c:2237
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&set->update_nr_hwq_lock){++++}-{4:4}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1625
       blk_mq_update_nr_hw_queues+0xbf/0x1a80 block/blk-mq.c:5242
       nbd_start_device+0x17f/0xb20 drivers/block/nbd.c:1489
       nbd_genl_connect+0x1651/0x1c80 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
       __sock_sendmsg net/socket.c:812 [inline]
       ____sys_sendmsg+0x55c/0x870 net/socket.c:2716
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2770
       __sys_sendmsg net/socket.c:2802 [inline]
       __do_sys_sendmsg net/socket.c:2807 [inline]
       __se_sys_sendmsg net/socket.c:2805 [inline]
       __x64_sys_sendmsg+0x1c3/0x2a0 net/socket.c:2805
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (genl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       genl_lock net/netlink/genetlink.c:35 [inline]
       genl_lock_all net/netlink/genetlink.c:48 [inline]
       genl_register_family+0x7b9/0x17b0 net/netlink/genetlink.c:784
       vdpa_init+0x39/0x70 drivers/vdpa/vdpa.c:1565
       do_one_initcall+0x250/0x870 init/main.c:1347
       do_initcall_level+0x104/0x190 init/main.c:1409
       do_initcalls+0x59/0xa0 init/main.c:1425
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1658
       kernel_init+0x1d/0x1d0 init/main.c:1548
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (cb_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3167 [inline]
       check_prevs_add kernel/locking/lockdep.c:3286 [inline]
       validate_chain kernel/locking/lockdep.c:3910 [inline]
       __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
       down_read+0x97/0x200 kernel/locking/rwsem.c:1568
       genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
       __sock_sendmsg net/socket.c:812 [inline]
       sock_sendmsg+0x1ca/0x2d0 net/socket.c:835
       splice_to_socket+0xae5/0x11f0 fs/splice.c:884
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0xef8/0x1940 fs/splice.c:1349
       __do_splice fs/splice.c:1431 [inline]
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice+0x353/0x490 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  cb_lock --> sb_writers#5 --> &pipe->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pipe->mutex);
                               lock(sb_writers#5);
                               lock(&pipe->mutex);
  rlock(cb_lock);

 *** DEADLOCK ***

1 lock held by syz.3.4345/21265:
 #0: ffff888037262058 (&pipe->mutex){+.+.}-{4:4}, at: splice_to_socket+0x15f/0x11f0 fs/splice.c:805

stack backtrace:
CPU: 1 UID: 0 PID: 21265 Comm: syz.3.4345 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2045
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3167 [inline]
 check_prevs_add kernel/locking/lockdep.c:3286 [inline]
 validate_chain kernel/locking/lockdep.c:3910 [inline]
 __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 down_read+0x97/0x200 kernel/locking/rwsem.c:1568
 genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
 sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
 __sock_sendmsg net/socket.c:812 [inline]
 sock_sendmsg+0x1ca/0x2d0 net/socket.c:835
 splice_to_socket+0xae5/0x11f0 fs/splice.c:884
 do_splice_from fs/splice.c:936 [inline]
 do_splice+0xef8/0x1940 fs/splice.c:1349
 __do_splice fs/splice.c:1431 [inline]
 __do_sys_splice fs/splice.c:1634 [inline]
 __se_sys_splice+0x353/0x490 fs/splice.c:1616
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f599bdfce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f599a035028 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007f599c076090 RCX: 00007f599bdfce59
RDX: 0000000000000007 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f599be92d6f R08: 000000000004ffe2 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f599c076128 R14: 00007f599c076090 R15: 00007ffe56c36778
 </TASK>


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

