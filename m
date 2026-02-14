Return-Path: <netdev+bounces-258694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8xjTChBLkGleYQEAu9opvQ
	(envelope-from <netdev+bounces-258694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 11:14:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48413B9F5
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 11:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC27D30066A9
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E0284896;
	Sat, 14 Feb 2026 10:14:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AC1519AC
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771064077; cv=none; b=kIBv32ttOVXcboE7bd9gA7PcJPlpYgOEw7ZWA10wtvhnmVmTE4Uy5mPVgnLPNmxWWRVmOVEQrsgHb0SVd4oJU74vhpJ6qIuamFWH4Ki60I98K/6DWxY1enZyexCoVrI3NiN0YWLjMfg4uDNaMg0tj5o6IoplVC3Ahlj/FRvDH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771064077; c=relaxed/simple;
	bh=yP7eb4HFtxtspRbsrbmIeY0lbE46j3slye4soDxFLnA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CefD7Vp5qnvBqFNIFJn+SaZT5dM1NzpIKNrtFNRivYpeo+hejx9QLO+KbNDW1Jj9fH/4Mc4kJI9YfkECwjo7ktIj1Dr4ZPRM1+weBYGicphGkudXRC5r0e3OM2yFWJyrKLa+XMx4FwJDJMR1UNnZe1FqCUqZ1KhaSrr2ADlIayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d49709f87aso12651227a34.1
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 02:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771064075; x=1771668875;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4H2pNmg8sAeM1P20GxHzdmGZKVIUdPkAubVCqbulsmU=;
        b=EMZETEMYLyc8+7ZbNPY2/qeoo4ROHhCx2Tp6UEkybZkV3lxUD0SvxMgb1+oQOk4rXE
         CTgb965LzjODzTA4els0RMak1yydnzKCdEfGPMTgfQGFeCdc+kZsfKSuocLJ4+1q6Wcn
         KtBbZ4kdnsRoJ8Z6UMuLhGdKuB6/kDwlfEe+neUPKjia2T1+RfEnr+CKSPmu6NCMUmtU
         slq+m6kQpulcXOZ9NdDYcF/FQY2ovZTjJZqRXORpzcI2l+ZSwArsjsG50jTdeuHQpQGF
         fWNmKtBP+wlyw8GjbfFn3k/zf2mVMlI3DRpM84NB++WDTvH00NdOPW8XmXswYViabxRI
         4Xmw==
X-Forwarded-Encrypted: i=1; AJvYcCXtXcOrO4V3+mrSp5tYmE8pJXDzMSxt8TTR8eqvlCyaaoMQJgb6S30DgVQugNnbsgraeMjuVsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdOowH6nQZoVqXYZI7mL8uDG+SS1/mlmMG3Nr33uBf1X2eYNi
	Ysz2O50SomHUY5sdkZBzgtc2DulnzoWN/FGegboK6/ptdwirs/tArt5fbD9+o6sXko3BlLz5M3h
	qPkdZAnNo1VeDuk/LHGJxdlDmw9gxc8W1pFXCnIgHodm3XdhU23Gl3a2hYOg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2913:b0:662:fef7:4dba with SMTP id
 006d021491bc7-6776757d58dmr2524360eaf.32.1771064075052; Sat, 14 Feb 2026
 02:14:35 -0800 (PST)
Date: Sat, 14 Feb 2026 02:14:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69904b0b.a70a0220.3c8f9c.008a.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __inet_bind
From: syzbot <syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=50148b563a4d5941];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258694-lists,netdev=lfdr.de,aae646f09192f72a68dc];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,goo.gl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: AC48413B9F5
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    cd7a5651db26 alpha: add missing address argument in call t..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bc7e5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50148b563a4d5941
dashboard link: https://syzkaller.appspot.com/bug?extid=aae646f09192f72a68dc
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122c0652580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f7e15a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23c623fcb1bf/disk-cd7a5651.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5128bb44f38d/vmlinux-cd7a5651.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a65d6b263e08/bzImage-cd7a5651.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com

wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
=====================================================
BUG: KMSAN: uninit-value in __inet_bind+0x8a4/0xf20 net/ipv4/af_inet.c:511
 __inet_bind+0x8a4/0xf20 net/ipv4/af_inet.c:511
 inet_bind_sk net/ipv4/af_inet.c:464 [inline]
 inet_bind+0x12c/0x1a0 net/ipv4/af_inet.c:469
 kernel_bind+0xd6/0x130 net/socket.c:3554
 rds_tcp_conn_path_connect+0x952/0xff0 net/rds/tcp_connect.c:175
 rds_connect_worker+0x353/0x4d0 net/rds/threads.c:176
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xae7/0x1d60 kernel/workqueue.c:3358
 worker_thread+0xede/0x1580 kernel/workqueue.c:3439
 kthread+0x53f/0x600 kernel/kthread.c:467
 ret_from_fork+0x20f/0x910 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 kernel_bind+0x92/0x130 net/socket.c:3552
 rds_tcp_conn_path_connect+0x952/0xff0 net/rds/tcp_connect.c:175
 rds_connect_worker+0x353/0x4d0 net/rds/threads.c:176
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xae7/0x1d60 kernel/workqueue.c:3358
 worker_thread+0xede/0x1580 kernel/workqueue.c:3439
 kthread+0x53f/0x600 kernel/kthread.c:467
 ret_from_fork+0x20f/0x910 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 rds_tcp_conn_path_connect+0xaf8/0xff0 net/rds/tcp_connect.c:174
 rds_connect_worker+0x353/0x4d0 net/rds/threads.c:176
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xae7/0x1d60 kernel/workqueue.c:3358
 worker_thread+0xede/0x1580 kernel/workqueue.c:3439
 kthread+0x53f/0x600 kernel/kthread.c:467
 ret_from_fork+0x20f/0x910 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4466 [inline]
 slab_alloc_node mm/slub.c:4788 [inline]
 kmem_cache_alloc_noprof+0x373/0x1200 mm/slub.c:4795
 rds_tcp_conn_alloc+0x7b/0xbb0 net/rds/tcp.c:376
 __rds_conn_create+0x267f/0x34e0 net/rds/connection.c:283
 rds_conn_create_outgoing+0x5d/0x80 net/rds/connection.c:377
 rds_sendmsg+0x2684/0x4d70 net/rds/send.c:1321
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xfe7/0x1080 net/socket.c:2592
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2681
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 1096 Comm: kworker/u8:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: krds_cp_wq#0/0 rds_connect_worker
=====================================================


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

