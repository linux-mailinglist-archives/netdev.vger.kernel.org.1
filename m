Return-Path: <netdev+bounces-199213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F965ADF725
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764051BC2A5D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9705D218EBA;
	Wed, 18 Jun 2025 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOf0ucIg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172E211A2A;
	Wed, 18 Jun 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276057; cv=none; b=Nnzjt0Bpp2rZr7yV9HZ4m1S92x4Kr0zlrDilvrhFLyDjsfDNkOHqEstmMN4iDv7u6T3z2fl0zwZ+G5a10WaAlz8hNbrXpcwqWc2uA8a4d/GXrBYJfECy2BXZhfaaQFp+rnBMW4l5xT9sb60/UjQj2um2S0GbDj4d5VjA+xodWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276057; c=relaxed/simple;
	bh=deAaHkl21h0ohvn8v3N4Fp2M9e5xG02VmKncezoInZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzO5Qi90xMDz0JE0/BAL+coLCuUkF0oH6FoDWLCLhKlDKijFBKeEtCW9zrKaFFATlRWm4/jf69gOJifj414kCmzX0p3ENi8z5Qaop+z/wleIOhyrCOD/SyaKsetOCwqdTtwu0tQCVygExYFc4DYMIH688mcwhyYOBGGQDVXyxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOf0ucIg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2f62bbb5d6so85562a12.0;
        Wed, 18 Jun 2025 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750276055; x=1750880855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf8eeO+2z/7Pg7trXIafCOB1C7MRwn5GKRlRkhdvSUU=;
        b=OOf0ucIgXXhyoiFt3gJRwZmc1GLEOaBLh22VCKFYLZ4AdKsyMz2BOxkedIL9zfTAnd
         rmwpdG/tgQO8eRdvTb+WOXOtjEqr9rjE9mVp1tbwY8qetSKWVydhEWOPD9UwW4isYbvS
         OaJZNzN50qEbS+h0/Ju093rvc7CXz9ZD0u4i8Z3nyckkaBCcBY73zw9FgpUO7x6zF5GU
         gki2uQru07gg+JDC14l8IZsXA7g9hJ9qmonhcEx2DACdy7IVjVGKYWCsk5KtnIlzTglI
         YVNG9j7owROH84YQYrtCwlAlkJyFwF0H/RkY/5m0sWz9oXyyFP7y9BE6kzOO84PHJUdT
         K1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750276055; x=1750880855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf8eeO+2z/7Pg7trXIafCOB1C7MRwn5GKRlRkhdvSUU=;
        b=KuaJLZpo/yKSDf92tcBLFeXGcfmJeWE8PuJ7Edf2EwzizrC+D3nCE0utn0l6lu+XkR
         nvlb+VsPqx3tS2sNmonenIVBmxUK+F0mWst7ee3z88yDFIAx2YESy0o1RWpd1G7Mcqgc
         rdIknlTbWNJEbVrgjMbWG3G2lv+KDpker4O96BUQ3BX/uPhY35/gheKBNQbjImzuWqUb
         53IGb7AcGEAIaXpSEFzGNIwMHVXDxsdiTqZCqc5FibaFzdCko8XkfdOsORWS2mymcxP5
         BFgI6aS9/L2JMDoXDhsubCMyBkft7Iybnr8GPugRC3FnfOI6RGwTSMBhu5zahCEb/yMf
         fxRw==
X-Forwarded-Encrypted: i=1; AJvYcCWACiDFfi46bN0VtgicIVCNKg/0UI3Pw7l7Y/VRPWi4O5vNlvMSUFO8xMXRktHoIPEtzyewaCkP2qD2Zx8=@vger.kernel.org, AJvYcCWAd72rd4kpcC0kuQL3YmDM99APMX67Dm6b5/y2EM3Q2dXl9F/KWReVytNFv5TSmY8Xj/6Q4v+g@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZwEDGvXdNK1+UQkfjlsLHgHCR4/G883s+nFYd5yyeIh7/JMg
	sDeSUuVC96w++vlOpP9ZoCG6zy5Bsva8kpxrZA9LI3lfehtKf0Z5qmk=
X-Gm-Gg: ASbGncup85QVFbXacVK8T8Q5P2LQi7FHJc06xJSn5fEU6M7gJfUNAGwHafRJ7KFdfoF
	8uQunIz2qXLI8lYYhFRlLGAsk7toQ0k2jH4c0pppBH+vk6Pm5MnOZq2S0N9nm3mERnVqEtR40kd
	cr9Hvipl9609D6czmE0b/Yxuh0XvW58+fdsc8LVTLPcrVWayK6cUBphUWIk4/iKTtpF4uXmPwBL
	JZ3QAQxgr44GoJTHvMjDkoGjlicZG28/VoNBskIicFuGHqYBZvVBQ0Mu+hfT7oEYg6MmI+azNja
	sjeQHWUpDyj8nSyv+cin0Jv+HSwymplsdt09jJQ=
X-Google-Smtp-Source: AGHT+IHXfNbvE/9DUQAoYQBRUh4sg9zogi2Yk6H45aA2EA4INQqptGqC/088JwMW4pvwRnMQLqOVSg==
X-Received: by 2002:a05:6a20:a123:b0:1f5:8de8:3b1a with SMTP id adf61e73a8af0-21fbd5239a0mr29193354637.13.1750276054940;
        Wed, 18 Jun 2025 12:47:34 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe16805c8sm9713109a12.44.2025.06.18.12.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:47:33 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	kuniyu@google.com
Subject: Re: [syzbot] [net?] WARNING: proc registration bug in atm_dev_register
Date: Wed, 18 Jun 2025 12:47:25 -0700
Message-ID: <20250618194732.835401-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <685316de.050a0220.216029.0087.GAE@google.com>
References: <685316de.050a0220.216029.0087.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: syzbot <syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com>
Date: Wed, 18 Jun 2025 12:43:26 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    52da431bf03b Merge tag 'libnvdimm-fixes-6.16-rc3' of git:/..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17c7de82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4130f4d8a06c3e71
> dashboard link: https://syzkaller.appspot.com/bug?extid=8bd335d2ad3b93e80715
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175835d4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a7f90c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/876c709c1090/disk-52da431b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/05dc22ed6dd4/vmlinux-52da431b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/564136f4ae57/bzImage-52da431b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> proc_dir_entry 'atm/atmtcp:0' already registered
> WARNING: CPU: 0 PID: 5919 at fs/proc/generic.c:377 proc_register+0x455/0x5f0 fs/proc/generic.c:377
> Modules linked in:
> CPU: 0 UID: 0 PID: 5919 Comm: syz-executor284 Not tainted 6.16.0-rc2-syzkaller-00047-g52da431bf03b #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:proc_register+0x455/0x5f0 fs/proc/generic.c:377
> Code: 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 a2 01 00 00 48 8b 44 24 10 48 c7 c7 20 c0 c2 8b 48 8b b0 d8 00 00 00 e8 0c 02 1c ff 90 <0f> 0b 90 90 48 c7 c7 80 f2 82 8e e8 0b de 23 09 48 8b 4c 24 28 48
> RSP: 0018:ffffc9000466fa30 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817ae248
> RDX: ffff888026280000 RSI: ffffffff817ae255 RDI: 0000000000000001
> RBP: ffff8880232bed48 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff888076ed2140
> R13: dffffc0000000000 R14: ffff888078a61340 R15: ffffed100edda444
> FS:  00007f38b3b0c6c0(0000) GS:ffff888124753000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f38b3bdf953 CR3: 0000000076d58000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  proc_create_data+0xbe/0x110 fs/proc/generic.c:585
>  atm_proc_dev_register+0x112/0x1e0 net/atm/proc.c:361
>  atm_dev_register+0x46d/0x890 net/atm/resources.c:113
>  atmtcp_create+0x77/0x210 drivers/atm/atmtcp.c:369
>  atmtcp_attach drivers/atm/atmtcp.c:403 [inline]
>  atmtcp_ioctl+0x2f9/0xd60 drivers/atm/atmtcp.c:464
>  do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
>  sock_do_ioctl+0x115/0x280 net/socket.c:1190
>  sock_ioctl+0x227/0x6b0 net/socket.c:1311
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f38b3b74459
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f38b3b0c198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f38b3bfe318 RCX: 00007f38b3b74459
> RDX: 0000000000000000 RSI: 0000000000006180 RDI: 0000000000000005
> RBP: 00007f38b3bfe310 R08: 65732f636f72702f R09: 65732f636f72702f
> R10: 65732f636f72702f R11: 0000000000000246 R12: 00007f38b3bcb0ac
> R13: 00007f38b3b0c1a0 R14: 0000200000000200 R15: 00007f38b3bcb03b
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>

#syz test

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

