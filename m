Return-Path: <netdev+bounces-205181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F7AFDB60
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF7F48083D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C7E230274;
	Tue,  8 Jul 2025 22:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28122330F
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015094; cv=none; b=d2H3VUJlSenW7XQ4d4ZghQ8U1Z1JXM/zTzrChIbEqQgyErz/jocK8O3hRNgo0bOJY0IdGiCJzcPT9Qa1VT6GXaZZsDIJXLZmLGylFyHeO6dFIGcPjRNR751gHYaEyak0FSjHPOQdueEgcmoDq4gMCTfDz4Ew7KWikYcCU401Xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015094; c=relaxed/simple;
	bh=P3OOo8EI1eAgBbwdAuez5mFwulPlxWZr+9DKamiMyKo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h5Sv1Z9XJYRSjFLNy1zt/HQMFD/dz7MgJZJLrxqkRoeVCMuBl0cvzSPg36wWS6MdB/za3cs0GIttIYtQobqWLx9w5OSOmMdZO98gJt/ApYLlktiY6uqiP7sANY0esIf0ukHMRFBG84f5ThYo7TL9n9G+h0HpBIqTrrPDNuA3MxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cff1087deso1031615539f.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 15:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752015091; x=1752619891;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NIMBFX9a7AB2yIzerp0W7zLz4BACj0/iNWxmFyr+2I=;
        b=hWho4kfIvwDCPl9VEZOzJ+rt62TiYQ+d24F2at+gBeVYy4ioixpknvucScJ8Mr/BrO
         q/kptZR25NlEcV3G6prFlT35v3fBqvYRKOrQBv7knBnmPPkI/zY4XYA9XOLyEjSyGXqa
         2vyZ86Y3ysXvAvgu+l6CQL+8cUscBV9i36UF6TGxmUPRkZWUEp4IbIZYzIuG5tv2WPaU
         eKfFfeoIzm9tn4AWNhNbF1aIsD7/kuvpRkEpYl50pzb3cXG4n/yKeujHOh1bFVJHB7p2
         BQiL9/91OR+PYpbEz3xDzNmo86vk3PV+wgAS9xUnEmdG1dGXXDKi1iSLxIlbX7OUP5wE
         bLEg==
X-Forwarded-Encrypted: i=1; AJvYcCWuYm0M3Jf3IH38OnI410pyMEolfZL+TG5TtuS3YZIT3InTzsW8Coat/f14arKCKzc8piB3c/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjYnOjtdm5But46enjHYYxyhGrbpFQRSW1tbC7OfQ8CcuXL44
	nv1zdTK0dQjMx2xiFYR+07sc4DhSHsqn5c4yVBYRHPsXe0vs5XVgUNeqx5eO/HDJCR13CXyefdI
	5FU0LjzICcdgfQA+mvIdhcZPhIdF29KZoSiYngmT02h65PSHtLYV2vR9bbyA=
X-Google-Smtp-Source: AGHT+IH9LUqYZosv7vKmWeT5GMvKXiD3Tj9NW06SqqQBT9g9KPFMkPbSTbFfUAc1By40vxMM7IXHjDO+p8rzFNMklFAUnh2gPIdV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4748:b0:864:a228:92b4 with SMTP id
 ca18e2360f4ac-8795b11cdf3mr58323339f.7.1752015091593; Tue, 08 Jul 2025
 15:51:31 -0700 (PDT)
Date: Tue, 08 Jul 2025 15:51:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686da0f3.050a0220.1ffab7.0022.GAE@google.com>
Subject: [syzbot] [lsm?] [net?] Unable to handle kernel write to read-only
 memory at virtual address ADDR (2)
From: syzbot <syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13c82bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
dashboard link: https://syzkaller.appspot.com/bug?extid=f22031fad6cbe52c70e7
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f623d741d651/disk-7482bb14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483e23ae71b1/vmlinux-7482bb14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79b5baaa1b50/Image-7482bb14.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com

Unable to handle kernel write to read-only memory at virtual address ffff8000891ac9a8
KASAN: probably user-memory-access in range [0x0000000448d64d40-0x0000000448d64d47]
Mem abort info:
  ESR = 0x000000009600004e
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x0e: level 2 permission fault
Data abort info:
  ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
  CM = 0, WnR = 1, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000207144000
[ffff8000891ac9a8] pgd=0000000000000000, p4d=100000020f950003, pud=100000020f951003, pmd=0040000201000781
Internal error: Oops: 000000009600004e [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6946 Comm: syz.0.69 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvfree_call_rcu+0x31c/0x3f0 mm/slab_common.c:1971
lr : add_ptr_to_bulk_krc_lock mm/slab_common.c:1838 [inline]
lr : kvfree_call_rcu+0xfc/0x3f0 mm/slab_common.c:1963
sp : ffff8000a28a7730
x29: ffff8000a28a7730 x28: 00000000fffffff5 x27: 1fffe00018b09bb3
x26: 0000000000000001 x25: ffff80008f66e000 x24: ffff00019beaf498
x23: ffff00019beaf4c0 x22: 0000000000000000 x21: ffff8000891ac9a0
x20: ffff8000891ac9a0 x19: 0000000000000000 x18: 00000000ffffffff
x17: ffff800093363000 x16: ffff80008052c6e4 x15: ffff700014514ecc
x14: 1ffff00014514ecc x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700014514ecc x10: 0000000000000001 x9 : 0000000000000001
x8 : ffff00019beaf7b4 x7 : ffff800080a94154 x6 : 0000000000000000
x5 : ffff8000935efa60 x4 : 0000000000000008 x3 : ffff80008052c7fc
x2 : 0000000000000001 x1 : ffff8000891ac9a0 x0 : 0000000000000001
Call trace:
 kvfree_call_rcu+0x31c/0x3f0 mm/slab_common.c:1967 (P)
 cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: aa1f03e2 52800023 97ee1e8d b4000195 (f90006b4) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa1f03e2 	mov	x2, xzr
   4:	52800023 	mov	w3, #0x1                   	// #1
   8:	97ee1e8d 	bl	0xffffffffffb87a3c
   c:	b4000195 	cbz	x21, 0x3c
* 10:	f90006b4 	str	x20, [x21, #8] <-- trapping instruction


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

