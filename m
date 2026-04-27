Return-Path: <netdev+bounces-281417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GmiHKuX72mLDAEAu9opvQ
	(envelope-from <netdev+bounces-281417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:06:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3533476D73
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80F90301B90B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263C3DC4D9;
	Mon, 27 Apr 2026 17:03:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985983DC4C6
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309385; cv=none; b=iZUyuCl7lpz4LmZ7hbi04CK5qZM6yooUEQBINEBO5KZocyiQpLGH78NCe8MhwT2twJHoICPcUSXsq2ilfgy94ROq54OK+lzjkqF4/gleBFv6JlICExgVT2WECXHd34NO+tynMGhPbPsvrlJmZDLtGRPx+JAsa+dva+SOLrfmAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309385; c=relaxed/simple;
	bh=luA2KX0Z34rhPkgzK7yNqNk7xkX7wwA6aGAVl+/mfao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fp/O0ICOIVvMJl5eofdTe1ScoAuRUVWMdf9BGLeCPJDao12fsfFz12KeClj6ms7Ix8ght+68BJBH1bGe5k4o9OLDxRoL1O/OBcSmTSzoOtcjxVI6mzmz5STED01sgzW2sjm8d3M1bs/67rBUFeJ9JlJDMiegpgFBNPv+p2CTTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso13175265a91.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 10:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309383; x=1777914183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqkLNi8dFGLs0xZQNCmzoFuZ2bTIPgGk7WM+gkuVShA=;
        b=MRyQDJAs/Ftqjzkd9JDgO6m+vselFqZjH61pX5xQcBcRd0aJiTUkr+ai+y0fx7uiF9
         GwVTaz0sRp2bcnuuPoXoTq4BrIOxzxIIzIpXa61MJMBJbuZrdVDnGH8myO5DefOl3UNh
         4X64Go/UES7vud3YJnEghIW65KGGpHf57CUe4D2j427jY5blEic0y0tr3v9j5XA9kJMg
         vNXDaMFYiZ2B5jYM5EP8uv6I8ohMsi4GqaWqdk+1d3/mddXdw2Vu2MxuYZmme2HFKPZH
         7g/YDJXva6jreQsVui/8XWEk58H1ni7D/72XkUMjCNM4tAV84OoSIKwH7MDmijLLSsFs
         KoxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7GXuY8Qv3XhBZCR+Q4vLkI43WAYGPp97Wa/SNLD+aOeiduYjYlsrDnSF2zm0ANo9dwZZ0Q9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/86aH0z7mQ8n+pfgIW5/5SxfV99dL3lvTWaLLswHNqZA6i+I
	5WwfgtAhuJml2PW3VdC9cqBWv69t6g/rp0JzLsZQInIfRNobNkGGqo+SCIHjZ1vbTAb3oQW9Eqk
	B/IgkqUSkl5p7SzQ6y8HPQn0oiMMyJ9nCHpCQAWtGrsIGlrigc7TOgLNLRaA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a20:4311:b0:39b:e40b:fcae with SMTP id
 adf61e73a8af0-3a398c0323fmr237146637.10.1777309382959; Mon, 27 Apr 2026
 10:03:02 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:03:02 -0700
In-Reply-To: <ae-MTiL0vf-y7Ygz@sgarzare-redhat>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ef96c6.a00a0220.38d690.0001.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] memory leak in __vsock_create (2)
From: syzbot <syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C3533476D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=dfcc8f993a958a78];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-281417-lists,netdev=lfdr.de,1b2c9c4a0f8708082678];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in prepare_creds

2026/04/27 17:01:37 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888103b7b900 (size 184):
  comm "syz-executor", pid 6458, jiffies 4294946243
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5efbd4bc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    kmem_cache_alloc_noprof+0x36c/0x480 mm/slub.c:4905
    prepare_creds+0x22/0x600 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x920/0x2cf0 kernel/fork.c:2123
    kernel_clone+0xde/0x700 kernel/fork.c:2723
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2864
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810ad103a0 (size 32):
  comm "syz-executor", pid 6458, jiffies 4294946243
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 56 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .V..............
  backtrace (crc 109407f3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:218
    lsm_cred_alloc security/security.c:235 [inline]
    security_prepare_creds+0x2d/0x290 security/security.c:2866
    prepare_creds+0x395/0x600 kernel/cred.c:215
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x920/0x2cf0 kernel/fork.c:2123
    kernel_clone+0xde/0x700 kernel/fork.c:2723
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2864
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888111516800 (size 1272):
  comm "kworker/1:3", pid 5684, jiffies 4294946243
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc 5e448183):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    kmem_cache_alloc_noprof+0x36c/0x480 mm/slub.c:4905
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2241
    sk_alloc+0x36/0x460 net/core/sock.c:2303
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:907
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1566 [inline]
    virtio_transport_recv_pkt+0x88d/0xfb0 net/vmw_vsock/virtio_transport_common.c:1693
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88812daab5e0 (size 32):
  comm "kworker/1:3", pid 5684, jiffies 4294946243
  hex dump (first 32 bytes):
    f8 56 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .V..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 79381f4a):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:218
    lsm_sock_alloc security/security.c:4478 [inline]
    security_sk_alloc+0x2d/0x290 security/security.c:4494
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2250
    sk_alloc+0x36/0x460 net/core/sock.c:2303
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:907
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1566 [inline]
    virtio_transport_recv_pkt+0x88d/0xfb0 net/vmw_vsock/virtio_transport_common.c:1693
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b1a75a0 (size 96):
  comm "kworker/1:3", pid 5684, jiffies 4294946243
  hex dump (first 32 bytes):
    00 68 51 11 81 88 ff ff 00 00 00 00 00 00 00 00  .hQ.............
    00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00  ................
  backtrace (crc 428f2031):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __kmalloc_cache_noprof+0x371/0x480 mm/slub.c:5410
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    virtio_transport_do_socket_init+0x2b/0xf0 net/vmw_vsock/virtio_transport_common.c:925
    vsock_assign_transport+0x3a3/0x460 net/vmw_vsock/af_vsock.c:656
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1582 [inline]
    virtio_transport_recv_pkt+0x8e5/0xfb0 net/vmw_vsock/virtio_transport_common.c:1693
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888111516300 (size 1272):
  comm "kworker/1:3", pid 5684, jiffies 4294946244
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc e1cd45d1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    kmem_cache_alloc_noprof+0x36c/0x480 mm/slub.c:4905
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2241
    sk_alloc+0x36/0x460 net/core/sock.c:2303
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:907
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1566 [inline]
    virtio_transport_recv_pkt+0x88d/0xfb0 net/vmw_vsock/virtio_transport_common.c:1693
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         39ff9a4a vsock/virtio: fix socket leak on close_timeou..
git tree:       https://github.com/stefano-garzarella/linux.git fix-syzbot-memleak-vsock-create
console output: https://syzkaller.appspot.com/x/log.txt?x=1742b896580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfcc8f993a958a78
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.

