Return-Path: <netdev+bounces-203961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A5AF8591
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B276E3B60BB
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 02:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8741D86DC;
	Fri,  4 Jul 2025 02:26:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC8262A6;
	Fri,  4 Jul 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751596014; cv=none; b=VleraLPxHsE0BTAjzP1U/nuZ7LRorJvp5IVKLsB7HIPwJ9qC3cinFEq9y5FNFfdQ77ogAsRqosxKEZ9JwMQJrVLqQr1WOaXcEnkmZdzzXJtlfT7d9aC4aAu3kYDkh25ecKld5VbyeewKv8uMm5O3NcNkVERbm/fvcboWp+j0edw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751596014; c=relaxed/simple;
	bh=2Jvgtj5t3hZ5VQ36euT0z9PS2vO0mdNlfh7YaTvGcyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ys5hxJeFTk4hdBQJneEAhKSMWvPJh8l4PWMRP3PqiMQjMA5TchLy1Rhc0noJSoZtrBJVFVhvodcxeIyYpwy+r9BESh/ju2Arx1UqN6a+yRO9ULAao4hHLLfxyj1kPA6AFp1iNFzN1iGKBOq8H5+DegcmT0Ta2XmkbsoauUH/+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bYHYJ40KDzVmcW;
	Fri,  4 Jul 2025 10:25:40 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 17713180B2C;
	Fri,  4 Jul 2025 10:26:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 10:26:47 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH] atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
Date: Fri, 4 Jul 2025 10:39:14 +0800
Message-ID: <20250704023914.3876975-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: Oops: 0010 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5324 Comm: syz.0.0 Not tainted 6.15.0-rc6-syzkaller-00346-g5723cc3450bc #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000d3cf778 EFLAGS: 00010246
RAX: 1ffffffff1910dd1 RBX: 00000000000000c0 RCX: dffffc0000000000
RDX: ffffc9000dc82000 RSI: ffff88803e4c4640 RDI: ffff888052cd0000
RBP: ffffc9000d3cf8d0 R08: ffff888052c9143f R09: 1ffff1100a592287
R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff92001a79f00
R13: ffff888052cd0000 R14: ffff88803e4c4640 R15: ffffffff8c886e88
FS:  00007fbc762566c0(0000) GS:ffff88808d6c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000041f1b000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vcc_sendmsg+0xa10/0xc50 net/atm/common.c:644
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmmsg+0x227/0x430 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

atmarpd_dev_ops does not implement the send method, which may cause crash
as above.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e34e5e6b5eddb0014def@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/682f82d5.a70a0220.1765ec.0143.GAE@google.com/T
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/atm/clip.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index b234dc3bcb0d..c02ba9d64bc3 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -616,8 +616,15 @@ static void atmarpd_close(struct atm_vcc *vcc)
 	module_put(THIS_MODULE);
 }
 
+static int atmarpd_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+	return 0;
+}
+
 static const struct atmdev_ops atmarpd_dev_ops = {
-	.close = atmarpd_close
+	.close = atmarpd_close,
+	.send = atmarpd_send
 };
 
 
-- 
2.34.1


