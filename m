Return-Path: <netdev+bounces-128318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A8978F5E
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C35DB245A6
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCABC1CCEFD;
	Sat, 14 Sep 2024 09:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC043ABD
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305034; cv=none; b=pH7lJGmi7K/KQbJiccEIyX7GtNHIPOZprrw7AXNw8B8JP4cfZ9L1wYsIzgDgaiapDoPAFuZmEDmfAAj1c3cHQZK68KiL6j+dv6utfd950uccpJ7AyQgryZstQXVAkQ2KZ2y4catwsnuuO7owZ7doEOqjRZFBbjrBxdAK0RvUcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305034; c=relaxed/simple;
	bh=b8gbFcdPg4SgZiH7k5BD6CY0rDrAN0e4BOAbPqeX640=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FwWbH9Rz1NZsQBsoNQA2+O10wqL+P9YxSXPSP7HNMIE9cqB0NXKE9P+wn8FDdqzuhAIVp2zXKika0YHCufrL51xtDq3oVljJakx8AkzVfcl8zHkvDfEbiG5sI5mNyEXu66s6/yAfobFWrI+WTs2KC9qSJmDxn754Mt95o/8+tWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso59715325ab.1
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 02:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726305032; x=1726909832;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ucFpJgZBDEvbayFGovsp4xwz0hvB2iTSA1f2jDtBTQ=;
        b=GZt3I2n3mWq0iwzLKmKTxDfo7YoJS++HW9gq+Tb2FILGMcnS/qqojf2dWnUs5rvp9W
         9S6G2lGM1eq2+u+2pky3e3BGsC7PmeyxYR9kmO1pNIHdqiUokhmr4dHJGYYssamQdi6c
         KTSuxGfcxMHFe8X6RCCQM94I/KW0Vvyvn7oRPYhqAi32p63/woUY9QWat5AoQyredpkd
         sHbG98893QffGow+IS7PehOI/CCutfbZ7xcKizF1cjfyaIyYB9ofKy+14/DU9v/d5mOH
         4VVm5v4dv1NwNFI2Tysh8IsIIts+DXdaTz+gOPf2sauOqg1szSlkBWc8fHrexkdFS3X/
         teTw==
X-Forwarded-Encrypted: i=1; AJvYcCX9yjRMbfa2wpFNfRwN3UOWDdp3a1rGD6MBK7IMeogBOwLKBxipQBjO2Hm8crmYVZCaicELIFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+SBE7j36Nixe+FeWcXSDh+9X/3FhZFP5OVbyIp2mhKpcFiVa
	xny998bxrSVh0qi83TuqBeOkG1+Nocfd/B0jSjZZ23WxL9uAupeFxLHKR2Lk/sG7wKby3S43pNw
	mKXRWkDl9Fo322C51IAxfAKMLCHa7JgS5LGRwi8xOrXA13nOz6J0hsPk=
X-Google-Smtp-Source: AGHT+IHHbna/iwJ27nJ6qU9seZDGQ6C8ywG3DkdgB2nAAawQLf9mITHYEvW3AZ2nT1GTszrXNx8LNXFWmcvSAb3WqjxyY//m2NjH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:870a:0:b0:3a0:533e:3c0a with SMTP id
 e9e14a558f8ab-3a084902a10mr80045435ab.7.1726305032394; Sat, 14 Sep 2024
 02:10:32 -0700 (PDT)
Date: Sat, 14 Sep 2024 02:10:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e55308.050a0220.1f4381.0004.GAE@google.com>
Subject: [syzbot] [net?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
From: syzbot <syzbot+74f79df25c37437e4d5a@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=141567c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74f79df25c37437e4d5a@syzkaller.appspotmail.com

F2FS-fs (loop3): Disable nat_bits due to incorrect cp_ver (10241045589465957861, 39874397669)
F2FS-fs (loop3): Try to recover 1th superblock, ret: 0
F2FS-fs (loop3): Mounted with checkpoint version = 48b305e5
BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 8464 Comm: syz.3.313 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 lookup_chain_cache_add kernel/locking/lockdep.c:3815 [inline]
 validate_chain kernel/locking/lockdep.c:3836 [inline]
 __lock_acquire+0x1fa0/0x779c kernel/locking/lockdep.c:5142
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 sb_mark_inode_writeback+0x80/0x47c fs/fs-writeback.c:1306
 __folio_start_writeback+0x630/0xac0 mm/page-writeback.c:3150
 set_page_writeback+0x5c/0x78 mm/folio-compat.c:45
 __write_node_page+0xa90/0x1ba0 fs/f2fs/node.c:1687
 f2fs_sync_node_pages+0x11ec/0x1a88 fs/f2fs/node.c:2057
 block_operations fs/f2fs/checkpoint.c:1290 [inline]
 f2fs_write_checkpoint+0xa5c/0x16f4 fs/f2fs/checkpoint.c:1665
 f2fs_issue_checkpoint+0x284/0x3b4
 f2fs_sync_fs+0x1f0/0x540 fs/f2fs/super.c:1708
 f2fs_create+0x3d8/0x494 fs/f2fs/namei.c:389
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0xfb4/0x29f8 fs/namei.c:3883
 do_filp_open+0x1bc/0x3cc fs/namei.c:3913
 do_sys_openat2+0x124/0x1b8 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1442
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


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

