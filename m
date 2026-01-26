Return-Path: <netdev+bounces-253349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNxDMUEUd2mHbwEAu9opvQ
	(envelope-from <netdev+bounces-253349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:14:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6359A84B98
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7C9F30010D8
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C61C28C037;
	Mon, 26 Jan 2026 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDo/Rk+U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9871A317D
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411646; cv=none; b=QsEKhJJLFd9nAH1pLnJ6rUg0UWtuxx2joeuc5T9qkjyz8jn1f1rTI1aOjtKAvWMfEgzpwlEg3xxQGBHs9KCmHcQTJqruwUGaSzWDMaHLFxzLIbJg5FVifAHwbGTn14CgSrs42RxrVl0H5gEebf+3fzLaIHersan2qUcLOGJjg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411646; c=relaxed/simple;
	bh=SjzB5OaKoF6oeTLjuhsLzIGn45qG6pg4bhuVet+nA/c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tF4eF4HccCAbDpM0VaKOb1CQsDHi1qunp291cdQ4BH1z2pZYS7H63t464F0qll6DCnROJbGNU6c5vbM0ui3rr6Zs+YtDRNTONLZids7fR1fRfl9RJP+0GPwC/3zmqDjZ/i/yxwJkRYDnj8B8m1c3nFs9dI/xTc9IAnACkf7ft4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDo/Rk+U; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-352e214cce9so3077836a91.1
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 23:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769411644; x=1770016444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yF56Y7+05srY9uPw4WuOY1IKfaY9wdwyVqLJPWhrb0Q=;
        b=SDo/Rk+UK68/9P9f0qTHXSzqr05z8VNQjoW1laBp4h0EI62+oJb3Z/ybzkQjDJZeSA
         SZnUMsqPpreN0SzFTubQYQgIZxW1ai4Ut6N9xZTOtbXOglNCwjh1iI9CQJIoM/lskSng
         W3PZksJVR6ahnpl98hhvsDTAT1XZEFXFOtnqVgB/hZw6pvIniutb0evVTG7F5v0E9Sbv
         61/I2TDrZDgR+CGC+1R4FFb7yBVFmkeOYOz2WJ8JKYuOzrjNXsF9pwf/P10ScyF61Hle
         ItaUAjMhXXgSmtViGukpFuhDHxqqzQ27EH6RZpN0sdt4VUi7XabTM4+ANXfBgWj/MyBm
         eIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769411644; x=1770016444;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yF56Y7+05srY9uPw4WuOY1IKfaY9wdwyVqLJPWhrb0Q=;
        b=oe1QtazFGHtGvEqciEnGi06kLERoAQKbxSgrwZQ9hoWjL8DoVr1Z5bL3rr5nGH8pKe
         SV7cT3o5NxHUWfkClhSCV6myJpQMU748UKZvnX3dJsH9Bz3ZdGr6dJKzbhfZLue5Ka8K
         7dv8wpQpvcp8xJ8L7o/x7yF+6AprRiH/WnMoDbcv9Svhzi3B6pWdKVOt5WM9Y+xRpRyX
         2VOcqoAmYyKQOalKPYap7emSeZlmsk6YH6qQDN7NpKjiiMruObDii/C4Rev6CPBmw1du
         L3xE7GD1FdQFDmF64M/ysBbt5HX/5JpeeIYLjz24wMni7VTLKLwSaZ1kw5hBf3RNTc/n
         staQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwjDegouHvcBeTB9PGTRc15KUk2to5zXFWlQd16owS9GK/3r1d5zP+B8JGi3mRsk/dZ06rq60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1WQWwKPJhji0p5BpP1LdUNKJR52mLjQE1keP/Yw+gy+HuCzf
	35S5WXXlUY4XvyDRvV9Y0wCVe/LkxtXKHDCp1Wy3UA3AnT/vOixdqF5wdiSlVqjitthhyRf4dLD
	h0rxAVA==
X-Received: from pjzb1.prod.google.com ([2002:a17:90a:e381:b0:34c:64ab:be12])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4f:b0:341:8ad7:5f7a
 with SMTP id 98e67ed59e1d1-353c4163c4fmr3010092a91.18.1769411644081; Sun, 25
 Jan 2026 23:14:04 -0800 (PST)
Date: Mon, 26 Jan 2026 07:13:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126071359.2693214-1-kuniyu@google.com>
Subject: [PATCH v1 net] nfc: nci: Fix race between rfkill and nci_unregister_device().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ilan Elias <ilane@ti.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+f9c5fd1a0874f9069dce@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253349-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ti.com,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,f9c5fd1a0874f9069dce];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6359A84B98
X-Rspamd-Action: no action

syzbot reported the splat below [0] without a repro.

It indicates that struct nci_dev.cmd_wq had been destroyed before
nci_close_device() was called via rfkill.

nci_dev.cmd_wq is only destroyed in nci_unregister_device(), which
(I think) was called from virtual_ncidev_close() when syzbot close()d
an fd of virtual_ncidev.

The problem is that nci_unregister_device() destroys nci_dev.cmd_wq
first and then calls nfc_unregister_device(), which removes the
device from rfkill by rfkill_unregister().

So, the device is still visible via rfkill even after nci_dev.cmd_wq
is destroyed.

Let's call nfc_unregister_device() first in nci_unregister_device().

[0]:
DEBUG_LOCKS_WARN_ON(1)
WARNING: kernel/locking/lockdep.c:238 at hlock_class kernel/locking/lockdep.c:238 [inline], CPU#0: syz.0.8675/6349
WARNING: kernel/locking/lockdep.c:238 at check_wait_context kernel/locking/lockdep.c:4854 [inline], CPU#0: syz.0.8675/6349
WARNING: kernel/locking/lockdep.c:238 at __lock_acquire+0x39d/0x2cf0 kernel/locking/lockdep.c:5187, CPU#0: syz.0.8675/6349
Modules linked in:
CPU: 0 UID: 0 PID: 6349 Comm: syz.0.8675 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4854 [inline]
RIP: 0010:__lock_acquire+0x3a4/0x2cf0 kernel/locking/lockdep.c:5187
Code: 18 00 4c 8b 74 24 08 75 27 90 e8 17 f2 fc 02 85 c0 74 1c 83 3d 50 e0 4e 0e 00 75 13 48 8d 3d 43 f7 51 0e 48 c7 c6 8b 3a de 8d <67> 48 0f b9 3a 90 31 c0 0f b6 98 c4 00 00 00 41 8b 45 20 25 ff 1f
RSP: 0018:ffffc9000c767680 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000040000 RCX: 0000000000080000
RDX: ffffc90013080000 RSI: ffffffff8dde3a8b RDI: ffffffff8ff24ca0
RBP: 0000000000000003 R08: ffffffff8fef35a3 R09: 1ffffffff1fde6b4
R10: dffffc0000000000 R11: fffffbfff1fde6b5 R12: 00000000000012a2
R13: ffff888030338ba8 R14: ffff888030338000 R15: ffff888030338b30
FS:  00007fa5995f66c0(0000) GS:ffff8881256f8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7e72f842d0 CR3: 00000000485a0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
 touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:3940
 __flush_workqueue+0x14b/0x14f0 kernel/workqueue.c:3982
 nci_close_device+0x302/0x630 net/nfc/nci/core.c:567
 nci_dev_down+0x3b/0x50 net/nfc/nci/core.c:639
 nfc_dev_down+0x152/0x290 net/nfc/core.c:161
 nfc_rfkill_set_block+0x2d/0x100 net/nfc/core.c:179
 rfkill_set_block+0x1d2/0x440 net/rfkill/core.c:346
 rfkill_fop_write+0x461/0x5a0 net/rfkill/core.c:1301
 vfs_write+0x29a/0xb90 fs/read_write.c:684
 ksys_write+0x150/0x270 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa59b39acb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa5995f6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa59b615fa0 RCX: 00007fa59b39acb9
RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000007
RBP: 00007fa59b408bf7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa59b616038 R14: 00007fa59b615fa0 R15: 00007ffc82218788
 </TASK>

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reported-by: syzbot+f9c5fd1a0874f9069dce@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/695e7f56.050a0220.1c677c.036c.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/nfc/nci/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index fc921cd2cdff..df8a2f97026f 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1303,6 +1303,8 @@ void nci_unregister_device(struct nci_dev *ndev)
 {
 	struct nci_conn_info *conn_info, *n;
 
+	nfc_unregister_device(ndev->nfc_dev);
+
 	/* This set_bit is not protected with specialized barrier,
 	 * However, it is fine because the mutex_lock(&ndev->req_lock);
 	 * in nci_close_device() will help to emit one.
@@ -1319,8 +1321,6 @@ void nci_unregister_device(struct nci_dev *ndev)
 		list_del(&conn_info->list);
 		/* conn_info is allocated with devm_kzalloc */
 	}
-
-	nfc_unregister_device(ndev->nfc_dev);
 }
 EXPORT_SYMBOL(nci_unregister_device);
 
-- 
2.52.0.457.g6b5491de43-goog


