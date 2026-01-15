Return-Path: <netdev+bounces-250058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC85D23669
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF9B130EB08B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853C33446D8;
	Thu, 15 Jan 2026 09:15:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F8355807
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468525; cv=none; b=HZc7gmkiJPoaQCaslruJo5shxszPS7zjU4xeNO0awU7D28PnjX5Sl223S4Xx4T5fba1iuRxE8n98SyDXQogo/GJd2IZ81+j/0vz0nvBe2YUiN/drUNjWCifu5T9HY+iHHu+2lEaAiCQT0jtHHRB60CfcMT8f+nBmcB3/vrKmHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468525; c=relaxed/simple;
	bh=JO3r1AGUSaeclQ1le4igMTyX73HehkmcPf7CrCjlEhM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QoHD96j4xdo4603Siv62loEr9UPxcos6atqiLUUaoFcPAbHRX2u18PwfTueO/7WpnDEek9ABb8EByXSCLQFHDKTsLmtl+52v7iX1h0Ht7knXSVyOc8yUhmlo12JtyvvlhA9x1eiVPyxkh5VqCxSMGEV2feTAX48OkKEuZGiUWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-661125c8491so607920eaf.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768468521; x=1769073321;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdcygAQemIWGYaInbBbXcp/6UHNE5yO0hXqCDywHlzg=;
        b=D+XPFSKTWdu6l3Sj6AwsA3d7OKNy4J2XEKOWUSVdTemgGakgwtTlaQgtEMQrIg1039
         5hwMzA6sb1kV+drDEWug3qRTx0ACUEGWRGP7nOAD7wKXjpUjoLF4AJDgCNxVt6EoapE3
         gxb7q8nEeBhJIfUPmsuxpY54+rsqCAMbVYIh8yBZDmq3tBsUWuLQKFpAxE+3IIpPuuCj
         dHk4rN3JulLpSlVePscg/C2Bo1QR7UP0u8VXBuQ7Cn7hBpT43P5FDgb8jhrE+BLncA8k
         TtF5O+yvVd7PIwWsejVt40+KQp0nTU+ZkXUwh5BX3IsG07qzrOLAsOSBoTIrr0BUpMDT
         szNg==
X-Forwarded-Encrypted: i=1; AJvYcCWMZD/PJX+ij5BzcyLgIGMmQTb2CmV54QkkU335KjS9TN+sHJ/C3S+yEXup4G+z+imTw2LMv0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOi1Qb97zR+rYu6bzVgC25oMgn1pv4fNQRZVIaqShwGEJXuct
	/AzLnGqKWklv9uCBnkp1I+koHO0HBoMpPHmVV2PhCEiV617o7RsXjZ1zsvk5ZC5BrkKhg6B/+XY
	rkAHljJHc97OjmWFq95jzRk8Af3vD5QL2XXNQhNVDzrc2WMUUs5o24mtAmEQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2302:b0:65c:fff0:818e with SMTP id
 006d021491bc7-6610070654bmr3533105eaf.63.1768468521216; Thu, 15 Jan 2026
 01:15:21 -0800 (PST)
Date: Thu, 15 Jan 2026 01:15:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6968b029.050a0220.58bed.0016.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in l2tp_tunnel_del_work /
 sk_common_release (7)
From: syzbot <syzbot+7312e82745f7fa2526db@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3609fa95fb0f Merge tag 'devicetree-fixes-for-6.19-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17de2e9a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b319ff1b6a2797ca
dashboard link: https://syzkaller.appspot.com/bug?extid=7312e82745f7fa2526db
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3018b7ea95aa/disk-3609fa95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7f25f6e87af/vmlinux-3609fa95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13d7f9c6c13e/bzImage-3609fa95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7312e82745f7fa2526db@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in l2tp_tunnel_del_work / sk_common_release

write to 0xffff88811bce50e0 of 8 bytes by task 10132 on cpu 1:
 sk_set_socket include/net/sock.h:2092 [inline]
 sock_orphan include/net/sock.h:2118 [inline]
 sk_common_release+0xae/0x230 net/core/sock.c:4003
 udp_lib_close+0x15/0x20 include/net/udp.h:325
 inet_release+0xce/0xf0 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0x6b/0x150 net/socket.c:1455
 __fput+0x29b/0x650 fs/file_table.c:468
 ____fput+0x1c/0x30 fs/file_table.c:496
 task_work_run+0x131/0x1a0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0x1fe/0x740 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x1dd/0x2b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811bce50e0 of 8 bytes by task 6117 on cpu 0:
 l2tp_tunnel_del_work+0x2f/0x1a0 net/l2tp/l2tp_core.c:1418
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
 worker_thread+0x582/0x770 kernel/workqueue.c:3421
 kthread+0x489/0x510 kernel/kthread.c:463
 ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

value changed: 0xffff88811b477a80 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 6117 Comm: kworker/u8:55 Tainted: G        W           syzkaller #0 PREEMPT(voluntary) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: l2tp l2tp_tunnel_del_work
==================================================================


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

