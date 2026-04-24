Return-Path: <netdev+bounces-281058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA3PHyzQ62nfRgAAu9opvQ
	(envelope-from <netdev+bounces-281058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:18:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7044632AF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526EC302AC0D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC2437B40E;
	Fri, 24 Apr 2026 20:17:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8A37C107
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061871; cv=none; b=bqq5lY8T+2WNbwYD2qaEmdMVByYgQXO4sFEZAFoHONBBfosoDxhz/IyEX5CzXrHvSs+TwuZN4FW+zizSIw15BcXhwALP+C7FCe7Ojatzpf4AITuoAhW4oYEc2RNDDvs2Xc6QiRIKF7cdduaDZUaVitFEF/aV+VlJDhoOkr7GD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061871; c=relaxed/simple;
	bh=qQxl11pEiuSHAksUCACQvi1ky2YjfwOu6r0yo/RCIFg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=H4sfRJNAqEodja+SGJxaQzRKMtgycAgibKUsg+drK8HKQCjp8JdVT0SVM6BdoWI/XnYZrI7dgZHZzaOJdPUzrgZnHbd0RruhJOadjyD/BjqAP69gzC4tyhp1opVOByKJaVEUTVTv4RxLp/MhzcgMI0angsNYFM/PoAdlydre3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c5ed0942so12591451eaf.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 13:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061868; x=1777666668;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtDPKkTm6UEDeYWPpWSRzW9tqH24Rk9NxnYdpKkM4Nc=;
        b=Z5li6iVc6ffgxRyIJSOkaxr157YPj/2DAEaez/hh/94sYHDIV9df4rzW0LWLq92VGJ
         UinTlexUDPM5RkZE5UP1HxZYdanZvbAJZlUFDSEvcaArgGAxRYxXruTFWSkFsn2jc3TZ
         rQhFYeBYN8AOoqM/P7zDtrrt9+dxJztIukKtGWqeL+jbDG5TbPJtKVg3Lew+71AefG7a
         RP2jVGMt5LmOQVPDgn3GnvOo03J0qvD3Ee4gglFNlONYj3+yfQl+t3LNv6pNtZ0Mv7Mv
         9RgzdTW6QfG1eG1OygqT27u2PJKNZTTmBLrZSMFHTSwepJBa0IYh35wGf/BmTY7Xb8bf
         qDWA==
X-Forwarded-Encrypted: i=1; AFNElJ/qOgCDrQq2r4e13srGU5OtyvZMNu0w39tSL03OIlFR8Q0L0rBTw0lXte2qqFOhY5MOnQKERak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLm/Xb3Sg12je7IXFDkhK8dlO6OgrNLUFohOxJ4y00BynarbX7
	xMLSPX8mgfHuRlcDu5aSdrSvtXlgrRFulTvw8ZbyXTJSWN8R+ZPoXNGi6x//kcUqyDNyGnPTXgr
	zZI3pn9SRyFk4Z+2nPJKQzSxXy1DRvJzthlqNsPEqv0Lbg5VacBjTFkIXrqM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ad0:b0:696:29be:abd9 with SMTP id
 006d021491bc7-69629beb9d6mr1743278eaf.22.1777061868159; Fri, 24 Apr 2026
 13:17:48 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:17:48 -0700
In-Reply-To: <20260424150310.57228-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ebcfec.a00a0220.7773.0006.GAE@google.com>
Subject: [syzbot ci] Re: vsock/virtio: fix memory leak in virtio_transport_recv_listen()
From: syzbot ci <syzbot+ciff083ac8f264c29f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kartikey406@gmail.com, kuba@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	stefanha@redhat.com, syzbot@syzkaller.appspotmail.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CF7044632AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281058-lists,netdev=lfdr.de,ciff083ac8f264c29f];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,vger.kernel.org,syzkaller.appspotmail.com,lists.linux.dev,linux.alibaba.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]

syzbot ci has tested the following series

[v1] vsock/virtio: fix memory leak in virtio_transport_recv_listen()
https://lore.kernel.org/all/20260424150310.57228-1-kartikey406@gmail.com
* [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen()

and found the following issue:
possible deadlock in virtio_transport_recv_listen

Full report is available here:
https://ci.syzbot.org/series/e5f3f5f1-8e83-492f-833b-dc526b61d0ef

***

possible deadlock in virtio_transport_recv_listen

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      e728258debd553c95d2e70f9cd97c9fde27c7130
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/bcc67f3f-b441-4d11-8573-f26ca268da65/config
syz repro: https://ci.syzbot.org/findings/fce9fa9b-692a-420c-956f-12c7e6d75e2e/syz_repro

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
kworker/1:5/6007 is trying to acquire lock:
ffff88817492e2a0 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
ffff88817492e2a0 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: virtio_transport_recv_listen+0x13a5/0x2230 net/vmw_vsock/virtio_transport_common.c:1593

but task is already holding lock:
ffff88817492e2a0 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
ffff88817492e2a0 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: virtio_transport_recv_pkt+0xfde/0x2bb0 net/vmw_vsock/virtio_transport_common.c:1671

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_VSOCK);
  lock(sk_lock-AF_VSOCK);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/1:5/6007:
 #0: ffff888112391940 ((wq_completion)vsock-loopback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3277 [inline]
 #0: ffff888112391940 ((wq_completion)vsock-loopback){+.+.}-{0:0}, at: process_scheduled_works+0xa35/0x1860 kernel/workqueue.c:3385
 #1: ffffc900030dfc40 ((work_completion)(&vsock->pkt_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3278 [inline]
 #1: ffffc900030dfc40 ((work_completion)(&vsock->pkt_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa70/0x1860 kernel/workqueue.c:3385
 #2: ffff88817492e2a0 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #2: ffff88817492e2a0 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: virtio_transport_recv_pkt+0xfde/0x2bb0 net/vmw_vsock/virtio_transport_common.c:1671

stack backtrace:
CPU: 1 UID: 0 PID: 6007 Comm: kworker/1:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: vsock-loopback vsock_loopback_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 lock_sock_nested+0x41/0x100 net/core/sock.c:3783
 lock_sock include/net/sock.h:1713 [inline]
 virtio_transport_recv_listen+0x13a5/0x2230 net/vmw_vsock/virtio_transport_common.c:1593
 virtio_transport_recv_pkt+0x174b/0x2bb0 net/vmw_vsock/virtio_transport_common.c:1695
 vsock_loopback_work+0x32c/0x3f0 net/vmw_vsock/vsock_loopback.c:142
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

