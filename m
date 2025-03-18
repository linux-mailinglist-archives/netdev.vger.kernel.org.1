Return-Path: <netdev+bounces-175810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4FFA678A9
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B7E883294
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EAE21019C;
	Tue, 18 Mar 2025 16:03:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865A20E33E
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313813; cv=none; b=aHlnxM7Lp0I51ERphfM9cq6NRu51P0yLlp2dpKmg6osmZ3HAigmA4ACvVEhnT4LX7jy32dEctZJtgBq000yQ36AAdOhv/SExXX9qEqD1Rp8ag3uGLANr17Hs0tDOmyugmEL91eC4bCayNnJ1yukesOtS9vloR2n7c+leLgiYf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313813; c=relaxed/simple;
	bh=jURps9XfVDNjPSE12cQMIWh27+hk1XzToM2NegaZYew=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SMKyMMtrLI9Oz4khBFbzuBVfIsrKhO8avgzz6j9zZ+kNQ7HOX1v2ha7X0lyHvi/NJU2YMKQyyiB4ACBwXgRfIpvFZYX1U11qg8CTnlgDKm+7IIafIRBkpytUwrHkB7KjZ5m1UIMHCgoPeBhGv6lrihSTCBnSqb/2wt/F1UHb1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d44a3882a0so56932445ab.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313810; x=1742918610;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeloYOLs0D1JA1CBe/PMpjdPAFnU6HAY2SyNmAlszfQ=;
        b=rFZjDx6YCCVBWvp8IaY21l+depoGDN1zmCHSb2gK5wTdLl1PWAgreUKgtSJW/1Bu+q
         38Ha3NA+51W1RMTF9bv2gWpnOa/KH9ID/ZdsxMP3+y7ZLovTwq0njcLHHkb8UQUA0PNS
         YFFYv3rnXYblHoidDmnp5E4Ged1A2ZIVFLlN+ja5Nq88CImXhyLOJVA6sKlORjwSv0yF
         td8NH7Ljdsxh0SW1ys3OnF382gDL/9v4pd+hb9xHxLVh9e/oYzneJXKlKEW5pK6VrxJZ
         6gqFL4znKwzTKYnhMbMOFTNFGKr4ll9IZV5Qd6v7av7znEdglF1Ah93uDIxsiJ6kTuY1
         TV4g==
X-Forwarded-Encrypted: i=1; AJvYcCVVjbwi1+5SmonFbAaWBRFTgw9Vt8t8DQQ8VTyTUw1SvkNX+ByZ0x1azLI1riUcSp9VEb6/MWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrYScetcwMSnQtfDQ6YEoVpYdXoKT1sIofxinUEqzOKBoiZg1
	EHD6uvnXLFfIa3cAPsmZRkY3KFo9X+k+r6fXOzUW7oZCIZ6X42JE6Fu/4PQ66ByC4ZenzND0TKW
	Uiax+gEp8nBt/zNHJXBNU+uXoJU10KGbs9Pp/rhng69c/gnoOfGWfU7Y=
X-Google-Smtp-Source: AGHT+IHfXIzxxGrTYq20Sf2RD/wOyWOOqFpGxCScbkT4s8e708uBs1g18RwBL8x5mjIEc6KA/3zGfFv5hCOLo4CvZx8lzkFFLvuR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378c:b0:3d3:d1a8:8e82 with SMTP id
 e9e14a558f8ab-3d57c31e058mr45132915ab.9.1742313809742; Tue, 18 Mar 2025
 09:03:29 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:03:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d99951.050a0220.3d01d1.013e.GAE@google.com>
Subject: [syzbot] [net?] WARNING in udp_tunnel_update_gro_rcv
From: syzbot <syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aedfbe251e1c Merge branch 'udp_tunnel-gro-optimizations'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177f45e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aeeec842a6bdc8b9
dashboard link: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18e6408e4123/disk-aedfbe25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1cdafe4afee8/vmlinux-aedfbe25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eda00f4a96d9/bzImage-aedfbe25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 24136 at net/ipv4/udp_offload.c:118 udp_tunnel_update_gro_rcv+0x31d/0x670 net/ipv4/udp_offload.c:118
Modules linked in:
CPU: 1 UID: 0 PID: 24136 Comm: syz.0.4789 Not tainted 6.14.0-rc6-syzkaller-01279-gaedfbe251e1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:udp_tunnel_update_gro_rcv+0x31d/0x670 net/ipv4/udp_offload.c:118
Code: 23 48 89 eb e8 14 47 4f f7 c7 05 ca a9 32 10 01 00 00 00 31 ed 45 31 ed e9 80 01 00 00 e8 fb 46 4f f7 eb 40 e8 f4 46 4f f7 90 <0f> 0b 90 e9 5a 02 00 00 e8 e6 46 4f f7 eb 2b e8 df 46 4f f7 eb 24
RSP: 0018:ffffc9000ad7fc50 EFLAGS: 00010293
RAX: ffffffff8a72ab0e RBX: 1ffff1100502bb6f RCX: ffff888020f55a00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: ffffffff86c2d1a0 R08: ffffffff8a72a6eb R09: 1ffffffff207a2ee
R10: dffffc0000000000 R11: fffffbfff207a2ef R12: dffffc0000000000
R13: 0000000000000004 R14: ffff88802815db78 R15: 0000000000000000
FS:  0000555582b32500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000040000001e030 CR3: 0000000034eca000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_tunnel_cleanup_gro include/net/udp_tunnel.h:220 [inline]
 udpv6_destroy_sock+0x230/0x2a0 net/ipv6/udp.c:1829
 sk_common_release+0x71/0x2e0 net/core/sock.c:3892
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:647 [inline]
 sock_close+0xbc/0x240 net/socket.c:1389
 __fput+0x3e9/0x9f0 fs/file_table.c:464
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3518f8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfbd8d008 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f35191a7ba0 RCX: 00007f3518f8d169
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f35191a7ba0 R08: 00000000000000e8 R09: 0000000cfbd8d2ff
R10: 00000000003ffcf4 R11: 0000000000000246 R12: 00000000000d64d1
R13: 00007f35191a6160 R14: ffffffffffffffff R15: 00007ffdfbd8d120
 </TASK>


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

