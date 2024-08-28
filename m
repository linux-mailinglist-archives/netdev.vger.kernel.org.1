Return-Path: <netdev+bounces-122984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88089963634
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F455281A94
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91B1B010D;
	Wed, 28 Aug 2024 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jynUTNH7";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="AdUyM0zx"
X-Original-To: netdev@vger.kernel.org
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FD18C350
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888019; cv=none; b=XFZjAuBjgbV5UgBfbS37ryCFlBuMKOTapkfHLhdhRVtBN+kUL1nhgcSqZgl55oodue6uRzYybtgAVv3WSa6J1BTdrq/dwj+v6oN68C9SHu353MnkLLshTj/f+3A/G6iVw45XLdOg48tF4EBFd20oCBZFYSn2HFKC/D2qpsX7/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888019; c=relaxed/simple;
	bh=r2Zvo3io7roN+B8qUhcp9+EdRgsGXTR6CSB7jo++g54=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H+g/oZXUmJQHCSRdgoynpjeWN20gBts/Z9FvYXqYJZH8oBd1BliBPxF3tN43EjhhzvEKo39ziwxRAXoGv/Gb3wapxNHq3o3atyXnfRsQvf9vmVHTY6lPv7UalWmfSTXYYkAfeBe0BDxhKVM7yyemz37u1UQRh5XBbp5NZd1gJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jynUTNH7; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=AdUyM0zx; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888018; x=1756424018;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=r2Zvo3io7roN+B8qUhcp9+EdRgsGXTR6CSB7jo++g54=;
  b=jynUTNH7pVLHW/dIfLAPJe3Cmzb1aqLHOYbfJDu87Ir5lkc6Ss3PlT+j
   0R7UXolg9/+VqgJPq8q121tjLVaI9LsYGLZXpiDbEpcVKsOybKf+5p8LG
   p9d5ViOw/QLUPSHWfwFv5NQbmMKENm41P/W+lf4uch3Or1G6iPCH00aqS
   rA68TzqE+HQFanQlwQa+N9JJwE5NaXq1iivZifocxJCQ4pQX7C6L/LMVv
   xeuUG8MS1S/aLCZYvqdQnW6zP9ePYEb1aYkJ3mdoJp8B8oBd+jG7rB5en
   RTMA3ME57YSEny4UeGugPDI0i30E8JQbxTMRIbuE8nCqYkqtRj076QQ8X
   g==;
X-CSE-ConnectionGUID: r5LNzPzYQvu6oB+d/reR+w==
X-CSE-MsgGUID: DNGi2D3xTt2+wOzuxZIy3g==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:33:37 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d52097234so92238135ab.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888016; x=1725492816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wNKyWaUhz3700A5smaNHiPUEiJzsuVdD+kb9paUQlO0=;
        b=AdUyM0zx3kCnYCoSXuzdBUM+1FcNaSxltni1byv0jP1+Ox/voFdwgfj733ri6zRb1O
         N/QQ2aS4bGeZesnAlm+25kzhjM2QamO5Oqc3dMH547230LyJ6Y5Wpn5pCLa8gDQ/hLG2
         8RS8EAXL5IyZgBDOv8PWDHflB/qAuKYm1t2RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888016; x=1725492816;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNKyWaUhz3700A5smaNHiPUEiJzsuVdD+kb9paUQlO0=;
        b=esZCyB3sqoYapg2kZIXX9fIlg5iYOG+T82QIlQTIbKZYZXmWhSZB0ILpNYW9Y5TsU3
         /8qQxvSyeLKZpEim4zQ7tCpNzSgzjvX3L20xfHgAxkkvY7jwvfuXPX+DkEzqOeKmKltP
         Y0w5ihYmd80EpsxJ8pJsFnDrHe28vHDxV05hfG+TbP7hY6veZsy96qMUqfrxPjBCpbTi
         jLS8pup3SYqo6n08A2Ht+bWNqRrqd+PuLSGYrYVT7n19aza7RFdko8l2lc/NTpO4Y2Zu
         QJiTIzLUVzqZrnUrHJ/ryhZ3u6gb9nm+4P8DodqVdifsB4E4NEA0pw+LROL5p3wiBV0N
         2LLg==
X-Forwarded-Encrypted: i=1; AJvYcCXYLouAiLKtxw9M0sLm0duSC3W/kj284dIWpwGlEsMO0bwzduh4QjNo3Bx8HyHea7JPnb0TDJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLgubpsgxKIMyxfqI1q1CYjAbISvUJb+u0M+IGvyzoOQGKJHH
	AT+wunxDjqDV+0BflvwCV2yq8HKngyOEzck9go0VyZYZVTFWuuPjVhbZhgyeS3MlHHr1BdtHYSb
	qoxaXq5KzIApRaG4B7OT6PpA0Iz1oo7q4lWjARYRxw9u4bMIT2gTDGJA2ogPYHYBR3+KZ8F/K7Z
	rSNRSLV6c+a0rL248znCiU4AxspP+OwA==
X-Received: by 2002:a05:6e02:b46:b0:376:410b:ae67 with SMTP id e9e14a558f8ab-39f379376bamr13514485ab.16.1724888016347;
        Wed, 28 Aug 2024 16:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE68/y+AQm50xR+REHZRvnuhbrCU6dmIV07XzcAT3Z080vqkGGdbQDpsOKFPJX9jDv00w9+Q+eGQ6cXTym3C+k=
X-Received: by 2002:a05:6e02:b46:b0:376:410b:ae67 with SMTP id
 e9e14a558f8ab-39f379376bamr13514365ab.16.1724888015948; Wed, 28 Aug 2024
 16:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:33:25 -0700
Message-ID: <CALAgD-6hPeV-aawEsBujDdcdOB3PFjXU8kz9GxXE2xH5_ZNy0g@mail.gmail.com>
Subject: BUG: corrupted list in default_device_exit_batch
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, bigeasy@linutronix.de, 
	lorenzo@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted list  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
list_del corruption. prev->next should be ffff88803fda68c8, but was
0000000000000000. (prev=ffff88802dbac0c8)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 1076 Comm: kworker/u4:6 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__list_del_entry_valid_or_report+0x10a/0x120 lib/list_debug.c:62
Code: e8 bb ff 96 06 0f 0b 48 c7 c7 80 5b a9 8b 4c 89 fe e8 aa ff 96
06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96 06 <0f> 0b
48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 0f 0b
RSP: 0018:ffffc900047af650 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88802dbac0c8 RCX: 904aecab9713c100
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff8172e30c R09: 1ffff920008f5e68
R10: dffffc0000000000 R11: fffff520008f5e69 R12: dffffc0000000000
R13: ffff88803fda68c0 R14: ffff888043bd00c8 R15: ffff88803fda68c8
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd14ca4048 CR3: 000000003a7f0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 klist_release lib/klist.c:189 [inline]
 kref_put include/linux/kref.h:65 [inline]
 klist_dec_and_del+0x9a/0x410 lib/klist.c:206
 klist_put lib/klist.c:217 [inline]
 klist_del+0xa3/0x100 lib/klist.c:230
 device_del+0x4d4/0x940 drivers/base/core.c:3862
 unregister_netdevice_many_notify+0x11a3/0x16d0 net/core/dev.c:11249
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 default_device_exit_batch+0xa79/0xaf0 net/core/dev.c:11760
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x8ae/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x10a/0x120 lib/list_debug.c:62
Code: e8 bb ff 96 06 0f 0b 48 c7 c7 80 5b a9 8b 4c 89 fe e8 aa ff 96
06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96 06 <0f> 0b
48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 0f 0b
RSP: 0018:ffffc900047af650 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88802dbac0c8 RCX: 904aecab9713c100
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff8172e30c R09: 1ffff920008f5e68
R10: dffffc0000000000 R11: fffff520008f5e69 R12: dffffc0000000000
R13: ffff88803fda68c0 R14: ffff888043bd00c8 R15: ffff88803fda68c8
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd14ca4048 CR3: 000000003a7f0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


-- 
Yours sincerely,
Xingyu

