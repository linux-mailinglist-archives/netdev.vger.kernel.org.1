Return-Path: <netdev+bounces-160115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0EAA184AC
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0423A57E7
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1FB1F7071;
	Tue, 21 Jan 2025 18:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769101F75B0
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482964; cv=none; b=LwzYZfBf441noneC+8fC5h3LPU0pAfPLEBk8MSCyczSCbmLyEvgv9ELMg8yhUSFdVn5cgAxyEjT3CkXXQcyPceEvV1DVaa97qamoshtiUHw3ruGz8XypyqeAetretBiPE5vz2GK3o4/KQurtIQZRRfW9r4rQAZhFpdINZdblYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482964; c=relaxed/simple;
	bh=Fi9kNNP40OTrvx8igWFuuk8JKxWEym0BXSa8hJBEWKE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jxRESmvhIhncTN8YMKKwdA0Q07OMVQYYHamXDfGIcp+ZG6MTw23ptqD1Xakbz5sbhWduhlPMEyfyq3uY/6zNSJ0nctbUcs/hqFYZefwIM4JK5FvFQUHZS67qB61IEAyivlpAogDZEggu1qSHLPB/cWPJztPx8Ix4uanjIY8iHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-844ee1661c9so930374839f.1
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 10:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482961; x=1738087761;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clTvB4riTrNMALgN+9ORgKQM4qbmxrbiO9t6iyF5Vow=;
        b=Gppzu5DMhWy77/X92vMzSyHbvQU1nTv3SYXilJmETpqFLml7kU5mtdRoOtLlWRKCaz
         lvwWN6ijRetFEGlDL7pbUJiAm6+YcziMUymZXcmfCOudU5vQd/hXe+7JomkQzIsaAeY9
         PDbgjhoO2K/1GwpiCMI2msLk1FUpN1Oou2Dm1fCYphFzBOaQ+R+mvZ9BKcvZN3DdotmW
         lw7BDgHGBp9xe2sBZrdY+Jrip3fqA33tVuZLz30XbgDhLfN6vFqktYEnzZvbI8sNdtgD
         Ndy5n87qQM9s//ni9tnRbHLiHiASY+rMmv1iCZjhQOCi8ap7iLjTKFYrbQbMyjgVYmhs
         ARSA==
X-Forwarded-Encrypted: i=1; AJvYcCUqi+RSgj+TtGFBJvu8i6qJ8RTJ4jN+ISqw8ShwHT5zcrK0DB/nWegOs60smSkCw4uPEaFfWmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhe4pkF4vhQ+jc78Ev/LF4bWo6BTg3/kr6A/dj4zqRgn6n6HMt
	n7C14kzpm7kXw0/Bg1yQmUVjqaRgbuNMGQmQDgp9CYu7l0az/crReCkh5pU1e0qzlykTyjwRI6k
	CkI7rxPwuUP/BqCDlSMlcdgnyocBynttZIpc7uCpOLzpja6QxR+w7XcI=
X-Google-Smtp-Source: AGHT+IHpG1JtFAQLv/8QPMm35Z93aF/88slaxeTUhx5NjW8A++363KiMeFd/1vaDfsBcHWsBiK8o1puPL7lIQVWoyBztxcsLYMD/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:490b:b0:3cf:ae34:96ed with SMTP id
 e9e14a558f8ab-3cfae349940mr15758455ab.13.1737482961487; Tue, 21 Jan 2025
 10:09:21 -0800 (PST)
Date: Tue, 21 Jan 2025 10:09:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678fe2d1.050a0220.15cac.00b3.GAE@google.com>
Subject: [syzbot] [net?] UBSAN: array-index-out-of-bounds in mr_table_dump
From: syzbot <syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    573067a5a685 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12d70dc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd7202b56d469648
dashboard link: https://syzkaller.appspot.com/bug?extid=5cfae50c0e5f2c500013
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13770ef8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1647e4b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d3b5c855aa0/disk-573067a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c06fc1ead83/vmlinux-573067a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3390e59b9e4b/Image-573067a5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com

syz_tun: entered allmulticast mode
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/ipv4/ipmr_base.c:289:10
index -772737152 is out of range for type 'const struct vif_device[32]'
CPU: 1 UID: 0 PID: 6411 Comm: syz-executor937 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0xf8/0x148 lib/ubsan.c:429
 mr_mfc_uses_dev net/ipv4/ipmr_base.c:289 [inline]
 mr_table_dump+0x694/0x8b0 net/ipv4/ipmr_base.c:334
 mr_rtm_dumproute+0x254/0x454 net/ipv4/ipmr_base.c:382
 ipmr_rtm_dumproute+0x248/0x4b4 net/ipv4/ipmr.c:2648
 rtnl_dump_all+0x2e4/0x4e8 net/core/rtnetlink.c:4326
 rtnl_dumpit+0x98/0x1d0 net/core/rtnetlink.c:6790
 netlink_dump+0x4f0/0xbc0 net/netlink/af_netlink.c:2317
 __netlink_dump_start+0x4d8/0x720 net/netlink/af_netlink.c:2432
 netlink_dump_start include/linux/netlink.h:340 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6819 [inline]
 rtnetlink_rcv_msg+0x8fc/0xa9c net/core/rtnetlink.c:6886
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2542
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6948
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x668/0x8a4 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x7a4/0xa8c net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 sock_write_iter+0x2d8/0x448 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x920/0xcf4 fs/read_write.c:679
 ksys_write+0x15c/0x26c fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:739
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
---[ end trace ]---
Unable to handle kernel paging request at virtual address ffff5ffd9650c113
KASAN: maybe wild-memory-access in range [0xfffeffecb2860898-0xfffeffecb286089f]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001a5699000
[ffff5ffd9650c113] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6411 Comm: syz-executor937 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mr_mfc_uses_dev net/ipv4/ipmr_base.c:290 [inline]
pc : mr_table_dump+0x5a4/0x8b0 net/ipv4/ipmr_base.c:334
lr : mr_mfc_uses_dev net/ipv4/ipmr_base.c:289 [inline]
lr : mr_table_dump+0x694/0x8b0 net/ipv4/ipmr_base.c:334
sp : ffff8000a50c6e10
x29: ffff8000a50c6ed0 x28: fffeffecb2860898 x27: ffffffffd1f0f780
x26: ffffffffd1f0f780 x25: 0000000000000000 x24: fffeffecb2860898
x23: dfff800000000000 x22: 00000000d1f0f780 x21: ffff00009a3377c8
x20: dfff800000000000 x19: ffff0000c8428078 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008b5fe85c x15: ffff7000125d8a48
x14: 1ffff000125d8a48 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff7000125d8a48 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 1fffdffd9650c113 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a50c64f8 x4 : ffff80008fa8f840 x3 : ffff8000802f4dc8
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 00000000ffffffff
Call trace:
 mr_mfc_uses_dev net/ipv4/ipmr_base.c:290 [inline] (P)
 mr_table_dump+0x5a4/0x8b0 net/ipv4/ipmr_base.c:334 (P)
 mr_rtm_dumproute+0x254/0x454 net/ipv4/ipmr_base.c:382
 ipmr_rtm_dumproute+0x248/0x4b4 net/ipv4/ipmr.c:2648
 rtnl_dump_all+0x2e4/0x4e8 net/core/rtnetlink.c:4326
 rtnl_dumpit+0x98/0x1d0 net/core/rtnetlink.c:6790
 netlink_dump+0x4f0/0xbc0 net/netlink/af_netlink.c:2317
 __netlink_dump_start+0x4d8/0x720 net/netlink/af_netlink.c:2432
 netlink_dump_start include/linux/netlink.h:340 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6819 [inline]
 rtnetlink_rcv_msg+0x8fc/0xa9c net/core/rtnetlink.c:6886
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2542
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6948
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x668/0x8a4 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x7a4/0xa8c net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 sock_write_iter+0x2d8/0x448 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x920/0xcf4 fs/read_write.c:679
 ksys_write+0x15c/0x26c fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:739
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 97759d2c d343ff08 d2d00017 f2fbfff7 (38746908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97759d2c 	bl	0xfffffffffdd674b0
   4:	d343ff08 	lsr	x8, x24, #3
   8:	d2d00017 	mov	x23, #0x800000000000        	// #140737488355328
   c:	f2fbfff7 	movk	x23, #0xdfff, lsl #48
* 10:	38746908 	ldrb	w8, [x8, x20] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

