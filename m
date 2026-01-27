Return-Path: <netdev+bounces-253695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIoMAU05eGmmowEAu9opvQ
	(envelope-from <netdev+bounces-253695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:04:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07C8FC8C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8243012C6D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78B318ED0;
	Tue, 27 Jan 2026 04:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhurNVN3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3D318ED7
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486664; cv=none; b=fBDEG+eWuVl1mioHPIAOXeHSlQnA4WaVaRsaUiI+HZrQM94xfPwlijeJetNv50BfV4HzQmFlvH/VFcAhNkM6C3WQPt/jw8vGnK+AmVuYOCW4NO24IJ1bpjpkm6I4Bbzf1nY++6dHiVSYwDmVBbnZ83+pUUltQg1FWZTIgSZI/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486664; c=relaxed/simple;
	bh=RCQj/53nweyIZws3MLltyC5xmW3bCbeOhLzxg2Hx/j0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V4CB2COzbXRZyEt1umW8pVL0wG2sdOZ0psVCfOIsf3guCWfCc2fFjBUc8alv9SfjKG6cCT1v7SILhhJLeMIiecfmSSMdzlvkk1Tb721wAsKYUxhxc5o1MdZjL/L2GfSDGq2W1xZwGNjHnpocMdU1eopjgwdBTbEhlNIDH5E4+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhurNVN3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c213419f5so3500845a91.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769486662; x=1770091462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FaCTgZNQ9XcjHrnOAQlcjLaq10rO1dKr0I1Lvn1NMVU=;
        b=GhurNVN3qL+44Iz3ZB+X46WJJ/fyzH58GbrJsx1wMhab0QaU4dntgXOKRrTAZEL23p
         mH9xwPwC3BKbfKks9RONxghnHFFJpQUjKftQtl2/AeQT3xGUgfqXzlTB7n2Rz3U9Z8JY
         V2hnN0lr8VteeSdzLpiyCXu4lX2ImmK/+PFnNEuh7F/X7aov6K1zYCKJO719oJIB03i4
         v97/6tUyYXfAlrYS/iw0wAj3iNW1wgbjQ0Ee1wBfcIVLCWWzyfUShdF3/pZMwkfE0Tlo
         pzpTTIQr1FdoiqBj+YVPpQqjnLQFHCO4CfJjXII7CA+Pc+8vlryeaxqQ8SF1WqhFuFhP
         L5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769486662; x=1770091462;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaCTgZNQ9XcjHrnOAQlcjLaq10rO1dKr0I1Lvn1NMVU=;
        b=PY7mxJcs7WAit2kQQQBAtPIr/OpAiFN4xih2AJwa1mlc75GdBGc8v6+ULK/q2gYB43
         W1Xih7e+N1O4ms7auZit6wKa+wHWBpgFQiSVW2FiCbJObTUZnrML0R3Sly7zLGnXEJV+
         SWYCDW1nS46NHdLD2uDjN+/047pN4OQvqlxjOR8gmKhkzqJK4CTxpQYZIlfDCbRNMhyR
         tzt/RfXOyZJcNmxmUey6rpvJwV3yeZn+8vm2u7EqZM87VnWArlFw0KGaGLPU8DKoQ889
         Tl6rk6XXoElwbUtqarc1dPP2mdgMydt0txCmShvX7OmF6PaSdzZ8BXJyzcJ8+pcA0XrV
         Kgmg==
X-Forwarded-Encrypted: i=1; AJvYcCWbYiPfqMmeQlHiIcGiyRPetYZfvqUfXCChsB9n3jm9Rk9sHOEI4xC8VCMj2GnyoGBIuzwaHFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40uJVd5yVvoCy84oEE3Eoob3hOhkLEVKzufY8ZcbhwpaIkG5M
	s6o3GWB0auP+OU/s38WKmcnegMqCceKF4bTKbJGdzuj7EEJF685IJO/hTAA6wyzCEQU65cGM2Wo
	M6Z4WqA==
X-Received: from pjxd17.prod.google.com ([2002:a17:90a:c251:b0:32e:ca6a:7ca9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8c:b0:33f:f22c:8602
 with SMTP id 98e67ed59e1d1-353fed88e82mr515009a91.26.1769486662570; Mon, 26
 Jan 2026 20:04:22 -0800 (PST)
Date: Tue, 27 Jan 2026 04:03:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127040411.494931-1-kuniyu@google.com>
Subject: [PATCH v2 net] nfc: nci: Fix race between rfkill and nci_unregister_device().
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,ti.com,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253695-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,f9c5fd1a0874f9069dce];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A07C8FC8C
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

Let's unregister the device from rfkill first in nci_unregister_device().

Note that we cannot call nfc_unregister_device() before
nci_close_device() because

  1) nfc_unregister_device() calls device_del() which frees
     all memory allocated by devm_kzalloc() and linked to
     ndev->conn_info_list

  2) nci_rx_work() could try to queue nci_conn_info to
     ndev->conn_info_list which could be leaked

Thus, nfc_unregister_device() is split into two functions so we
can remove rfkill interfaces only before nci_close_device().

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
v2:
  * Split nfc_unregister_device() and remove rfkill only
    before nci_close_device()

v1: https://lore.kernel.org/netdev/20260126071359.2693214-1-kuniyu@google.com/
---
 include/net/nfc/nfc.h |  2 ++
 net/nfc/core.c        | 27 ++++++++++++++++++++++++---
 net/nfc/nci/core.c    |  4 +++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 127e6c7d910d..c54df042db6b 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -219,6 +219,8 @@ static inline void nfc_free_device(struct nfc_dev *dev)
 
 int nfc_register_device(struct nfc_dev *dev);
 
+void nfc_unregister_rfkill(struct nfc_dev *dev);
+void nfc_remove_device(struct nfc_dev *dev);
 void nfc_unregister_device(struct nfc_dev *dev);
 
 /**
diff --git a/net/nfc/core.c b/net/nfc/core.c
index 82f023f37754..f50e5bab35d8 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1147,14 +1147,14 @@ int nfc_register_device(struct nfc_dev *dev)
 EXPORT_SYMBOL(nfc_register_device);
 
 /**
- * nfc_unregister_device - unregister a nfc device in the nfc subsystem
+ * nfc_unregister_rfkill - unregister a nfc device in the rfkill subsystem
  *
  * @dev: The nfc device to unregister
  */
-void nfc_unregister_device(struct nfc_dev *dev)
+void nfc_unregister_rfkill(struct nfc_dev *dev)
 {
-	int rc;
 	struct rfkill *rfk = NULL;
+	int rc;
 
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
@@ -1175,7 +1175,16 @@ void nfc_unregister_device(struct nfc_dev *dev)
 		rfkill_unregister(rfk);
 		rfkill_destroy(rfk);
 	}
+}
+EXPORT_SYMBOL(nfc_unregister_rfkill);
 
+/**
+ * nfc_remove_device - remove a nfc device in the nfc subsystem
+ *
+ * @dev: The nfc device to remove
+ */
+void nfc_remove_device(struct nfc_dev *dev)
+{
 	if (dev->ops->check_presence) {
 		timer_delete_sync(&dev->check_pres_timer);
 		cancel_work_sync(&dev->check_pres_work);
@@ -1188,6 +1197,18 @@ void nfc_unregister_device(struct nfc_dev *dev)
 	device_del(&dev->dev);
 	mutex_unlock(&nfc_devlist_mutex);
 }
+EXPORT_SYMBOL(nfc_remove_device);
+
+/**
+ * nfc_unregister_device - unregister a nfc device in the nfc subsystem
+ *
+ * @dev: The nfc device to unregister
+ */
+void nfc_unregister_device(struct nfc_dev *dev)
+{
+	nfc_unregister_rfkill(dev);
+	nfc_remove_device(dev);
+}
 EXPORT_SYMBOL(nfc_unregister_device);
 
 static int __init nfc_init(void)
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index fc921cd2cdff..e419e020a70a 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1303,6 +1303,8 @@ void nci_unregister_device(struct nci_dev *ndev)
 {
 	struct nci_conn_info *conn_info, *n;
 
+	nfc_unregister_rfkill(ndev->nfc_dev);
+
 	/* This set_bit is not protected with specialized barrier,
 	 * However, it is fine because the mutex_lock(&ndev->req_lock);
 	 * in nci_close_device() will help to emit one.
@@ -1320,7 +1322,7 @@ void nci_unregister_device(struct nci_dev *ndev)
 		/* conn_info is allocated with devm_kzalloc */
 	}
 
-	nfc_unregister_device(ndev->nfc_dev);
+	nfc_remove_device(ndev->nfc_dev);
 }
 EXPORT_SYMBOL(nci_unregister_device);
 
-- 
2.52.0.457.g6b5491de43-goog


