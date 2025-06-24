Return-Path: <netdev+bounces-200859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE10AE71AD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D15A7AE14D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A224C07F;
	Tue, 24 Jun 2025 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMdinJ6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A50170A26
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801512; cv=none; b=ICWDSiWWkDXILt97RdtINrn9NzrYkFsLbfaVfSeBYAgbXhy35hGx/EKw38lo8s7xnS9lwQvUDCfl0wOD5aXW8f1aBSKEiXwlQTBIEQJSgodBdVw5A7O0dr/csjoFdWyB7qul9G3OIvkVEhbQEE/nCtB4Obap6xGpk0gXcT1Z0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801512; c=relaxed/simple;
	bh=CYH9X7LugOMJVDq30qnneSu/tLSKikGgtezH6ZrJJjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pm8b+BPZOmwzRzHRglZwemRyKBD8/j58X+/Fhid/ikT9UWxI0K0Y9ENqZVRa+JSrLm/SyAkoyCRhY6Q8a7uLo1MdXmgLvKfX5A2khP/IDoGJskwZvdEWA85f+uHmGRs5JgIngDWGqm8Aqytr4chz0mcaK9htKdBxAmbCGo2hWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMdinJ6T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234fcadde3eso82963365ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801510; x=1751406310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeW2UaPlWVPE0gTWH5sYapqNgKtGoWa6lpWy9vlvU0Q=;
        b=IMdinJ6TrYsgrHFdZEZ9BT8n2wG2LD3nd4oJrRl2pfjp4GTOWAa4tPPI/z2qzts+Zg
         wjfhcNxNyv/JtInwQTnIEUM0SbWH7iq9+yxGWeRxepoiwJYca+uPDZZtDXuqhiK1Y9mY
         ORhtsiViEnWkE84Bk0vGDWdRTW0vH3Adf2sopNAIB8uFUTY8Lekgn04QrIUtRF3e4JOH
         Kr7P2QMOvP8goimcinJ3cYaPEurp2FSFiQqzHUO3/M3KsE6F8gYHIMUGZnETFeIyjNBw
         sZyVmNGUJFtKRZp078FfSGMapfd99vD0K47wEO4CGZWaPwPGFALnqYpR7sRhM/rCC4L3
         wmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801510; x=1751406310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeW2UaPlWVPE0gTWH5sYapqNgKtGoWa6lpWy9vlvU0Q=;
        b=un4ujKgOAvLnA+gZ13tbRkxN13HSF0iYU08iCduU8XnQeC1D78etmRYTtyfpDlMhxA
         TbsjWi5VHJooowakcI/iPW7qwdb8t+vG2MCCNC+09K1AP5XdZsepPc3ntzgsWl39DFr4
         X0R4/DjoQw27XJQqKEiGe9IpR0NuJRKYdakvxiuaYTUhkL31Uz5eF1MYJHqU6nhZlFRu
         ocrJyzqD9byDB1iwt861Iaau8arUU4KFAtpK54/P7dRH5n65yeCcKHkNiQ6X6BXlLN4X
         gtBg67MpH1hc7VfAIAqPVgjGaSCRnwfF0i2U11eI1iH9hPiYI7NzHANSCJtlGH+QiYzf
         8qRw==
X-Forwarded-Encrypted: i=1; AJvYcCUDHlVU+xdkeu0itp1w5lBNhi9khF0vzMsGknDUZtRdwGahGxeayjfvHTMA3Z+kZ9kKNyJudjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJb7YTX+I6Bd0idgxK4mZupeC7jJzq97VuYSflUY25n6FyVdK7
	dY0f3tGD/io1fkwVvAO+HH131h0xuMyl2omFDayZvLowKVeq/eXIhiw=
X-Gm-Gg: ASbGncudlNwG9viP3X2Cj/fqJ5f0sIivZV4TU+DZkt/otF/6O1rvMprq2/EpQad0i1w
	WZCoIS+DuXJToPHc/2XNV7uICSCI5aiHY6P33JBewIOgdKGXo5QwY67S2R6GWVIh9kwMscgmO2a
	ih+NLIQs8Os9ViVzXberljBlwEZ3etz4ndcy9nOMltH2PBRKM+oflnaDmPRiRbr+72CSveDe+D6
	s+0Em2Dy6v/iq4QXESlyWAxr6TOu0wfpd5irNzUJjct45sE0wxx8ffjF9CKU0EuJQnMK9GQFYBx
	OB9GsRtt575amdpuOKreuv+O8JCYmQevqCUQIaY=
X-Google-Smtp-Source: AGHT+IGq7Xh6J/oAR/4SpXE+WyRFc0MDGlgCP3HRglxRpTSWP8Bq/kgo3CCIks5hdHMGnzEbDhXL8w==
X-Received: by 2002:a17:903:2407:b0:234:f580:a15 with SMTP id d9443c01a7336-23823fd0962mr12723315ad.14.1750801509963;
        Tue, 24 Jun 2025 14:45:09 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83d5c97sm119506575ad.70.2025.06.24.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:45:09 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Chas Williams <chas@cmf.nrl.navy.mil>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com
Subject: [PATCH v1 net] atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
Date: Tue, 24 Jun 2025 14:45:00 -0700
Message-ID: <20250624214505.570679-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

syzbot reported a warning below during atm_dev_register(). [0]

Before creating a new device and procfs/sysfs for it, atm_dev_register()
looks up a duplicated device by __atm_dev_lookup().  These operations are
done under atm_dev_mutex.

However, when removing a device in atm_dev_deregister(), it releases the
mutex just after removing the device from the list that __atm_dev_lookup()
iterates over.

So, there will be a small race window where the device does not exist on
the device list but procfs/sysfs are still not removed, triggering the
splat.

Let's hold the mutex until procfs/sysfs are removed in
atm_dev_deregister().

[0]:
proc_dir_entry 'atm/atmtcp:0' already registered
WARNING: CPU: 0 PID: 5919 at fs/proc/generic.c:377 proc_register+0x455/0x5f0 fs/proc/generic.c:377
Modules linked in:
CPU: 0 UID: 0 PID: 5919 Comm: syz-executor284 Not tainted 6.16.0-rc2-syzkaller-00047-g52da431bf03b #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:proc_register+0x455/0x5f0 fs/proc/generic.c:377
Code: 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 a2 01 00 00 48 8b 44 24 10 48 c7 c7 20 c0 c2 8b 48 8b b0 d8 00 00 00 e8 0c 02 1c ff 90 <0f> 0b 90 90 48 c7 c7 80 f2 82 8e e8 0b de 23 09 48 8b 4c 24 28 48
RSP: 0018:ffffc9000466fa30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817ae248
RDX: ffff888026280000 RSI: ffffffff817ae255 RDI: 0000000000000001
RBP: ffff8880232bed48 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888076ed2140
R13: dffffc0000000000 R14: ffff888078a61340 R15: ffffed100edda444
FS:  00007f38b3b0c6c0(0000) GS:ffff888124753000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f38b3bdf953 CR3: 0000000076d58000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 proc_create_data+0xbe/0x110 fs/proc/generic.c:585
 atm_proc_dev_register+0x112/0x1e0 net/atm/proc.c:361
 atm_dev_register+0x46d/0x890 net/atm/resources.c:113
 atmtcp_create+0x77/0x210 drivers/atm/atmtcp.c:369
 atmtcp_attach drivers/atm/atmtcp.c:403 [inline]
 atmtcp_ioctl+0x2f9/0xd60 drivers/atm/atmtcp.c:464
 do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
 sock_do_ioctl+0x115/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f38b3b74459
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38b3b0c198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f38b3bfe318 RCX: 00007f38b3b74459
RDX: 0000000000000000 RSI: 0000000000006180 RDI: 0000000000000005
RBP: 00007f38b3bfe310 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 65732f636f72702f R11: 0000000000000246 R12: 00007f38b3bcb0ac
R13: 00007f38b3b0c1a0 R14: 0000200000000200 R15: 00007f38b3bcb03b
 </TASK>

Fixes: 64bf69ddff76 ("[ATM]: deregistration removes device from atm_devs list immediately")
Reported-by: syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/685316de.050a0220.216029.0087.GAE@google.com/
Tested-by: syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/atm/resources.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/atm/resources.c b/net/atm/resources.c
index 995d29e7fb13..b19d851e1f44 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -146,11 +146,10 @@ void atm_dev_deregister(struct atm_dev *dev)
 	 */
 	mutex_lock(&atm_dev_mutex);
 	list_del(&dev->dev_list);
-	mutex_unlock(&atm_dev_mutex);
-
 	atm_dev_release_vccs(dev);
 	atm_unregister_sysfs(dev);
 	atm_proc_dev_deregister(dev);
+	mutex_unlock(&atm_dev_mutex);
 
 	atm_dev_put(dev);
 }
-- 
2.49.0


