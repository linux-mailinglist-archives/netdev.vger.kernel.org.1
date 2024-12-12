Return-Path: <netdev+bounces-151536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13BD9EFF30
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E62855B8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC51DE3B7;
	Thu, 12 Dec 2024 22:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83498199948
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042029; cv=none; b=Md/VeiFzYLhwGoa7dFy+F7Zr4jpNAY4qbP4iN1veHzEWDCGJJn+VcURZZaigcatsnfKAi42rJJ2X69Nwg/dXTvjgshFUviJr0zhq3l1srJBC1PBl50SaFzJS3ViPc/JgaukNVJIMdJNJPnPUZZ2/O+HaX53GNTP7vDjVtcCb6Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042029; c=relaxed/simple;
	bh=lfUzYuEvRyQfqlRRIjEGqBRMKyxrhcD3WK1nSCc9brU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jZoLojKlyDUaXx536hq2L/orJcGHOtOQrLQ+x3yoXneUszI2xHY1rC/GRJUUTRPIszGBYB5dvJlrqYoCediWDVmHlVs8+TwPp5FnbQcxks5ttbApP3Pam4TsfUbAgvABtvtMhXJAtaEB67iYWCNhnj/epDTUyEcek2OHrGRH1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ac005db65eso11550395ab.3
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042026; x=1734646826;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiJBO4YkDGjPUE2+2UYWhhTh96UUa4D1CK2SB4rQoOo=;
        b=Wzp4ZGVyw9+s3SDDFaxd8EaAbLrpxFYREX2y3/rJNfIV9iZ6mQm3viXwhFQ20xqEQJ
         sJb/buRdIQx1/jBrrWXkas29SndP+4Pravzcqa4IE03QjBFyzdFcHvkIcuehIuII3mq4
         T2Vdvj0dWb3HYLYCj03WCjWpqf1xbCqndmoTQQar8HcruDsVwvLo8Dc91pDgL/ucztH7
         PWHWwPKH/XNhR3WTfhB1Rfj0whi1X43JoI3gFiWAe9xqRKUmNiZ6dnxRb3ajSb2DjJGo
         W7gMLMX7vbORpPRxc9d6vBlLPyPEC+9eGqw5RzWkCtbeKTErGFZ2TCwIDHImK2iujpAQ
         ld5A==
X-Forwarded-Encrypted: i=1; AJvYcCVa9Lon8p32tg+nEg/RJWTsBefRZHv2ZfhxDchGOAzQB2kHew6EhOg4F4XjUmwJbk8/VDn8iBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywEEpglJc0hOBcVTud3x+H923LlLY/jtVozA1Zxwh5buxnfUkj
	wKQJWXrTwRFAYuDMNb1NlAGgtNRER0wgpFAguzgtwfaAE1RCYrarxQMLGvyXSJS6Tor3K4yCGBa
	vYbqBV14Mw4H3bB82Kia+Ux2+cTsm8ZftAI+Justi+nifyA/dHa158g8=
X-Google-Smtp-Source: AGHT+IFSqmfgaPcHWmpvTo/ao95n0hiJiZnAyatoM1E9PBANifFfvSujaEvVpNT3kyW8BlvCMuoBQYbvdFJX04kONrc828Ja8Yah
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:3a7:8720:9e9e with SMTP id
 e9e14a558f8ab-3aff6213742mr4733235ab.2.1734042026777; Thu, 12 Dec 2024
 14:20:26 -0800 (PST)
Date: Thu, 12 Dec 2024 14:20:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675b61aa.050a0220.599f4.00bb.GAE@google.com>
Subject: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
From: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a74d44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=4f66250f6663c0c1d67e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eb0730580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117844f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c62feec036f0/disk-96b6fcc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0dd481b2d92e/vmlinux-96b6fcc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f647dfdfac4/bzImage-96b6fcc0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:2849!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6230 Comm: syz-executor132 Not tainted 6.13.0-rc1-syzkaller-00407-g96b6fcc0ee41 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__pskb_pull_tail+0x1568/0x1570 net/core/skbuff.c:2848
Code: 38 c1 0f 8c 32 f1 ff ff 4c 89 f7 e8 92 96 74 f8 e9 25 f1 ff ff e8 e8 ae 09 f8 48 8b 5c 24 08 e9 eb fb ff ff e8 d9 ae 09 f8 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004cbef30 EFLAGS: 00010293
RAX: ffffffff8995c347 RBX: 00000000fffffff2 RCX: ffff88802cf45a00
RDX: 0000000000000000 RSI: 00000000fffffff2 RDI: 0000000000000000
RBP: ffff88807df0c06a R08: ffffffff8995b084 R09: 1ffff1100fbe185c
R10: dffffc0000000000 R11: ffffed100fbe185d R12: ffff888076e85d50
R13: ffff888076e85c80 R14: ffff888076e85cf4 R15: ffff888076e85c80
FS:  00007f0dca6ea6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0dca6ead58 CR3: 00000000119da000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_cow_data+0x2da/0xcb0 net/core/skbuff.c:5284
 tipc_aead_decrypt net/tipc/crypto.c:894 [inline]
 tipc_crypto_rcv+0x402/0x24e0 net/tipc/crypto.c:1844
 tipc_rcv+0x57e/0x12a0 net/tipc/node.c:2109
 tipc_l2_rcv_msg+0x2bd/0x450 net/tipc/bearer.c:668
 __netif_receive_skb_list_ptype net/core/dev.c:5720 [inline]
 __netif_receive_skb_list_core+0x8b7/0x980 net/core/dev.c:5762
 __netif_receive_skb_list net/core/dev.c:5814 [inline]
 netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x2b5/0x870 net/core/dev.c:6256
 napi_complete include/linux/netdevice.h:567 [inline]
 tun_get_user+0x2ea0/0x4890 drivers/net/tun.c:1982
 tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2057
 do_iter_readv_writev+0x600/0x880
 vfs_writev+0x376/0xba0 fs/read_write.c:1050
 do_writev+0x1b6/0x360 fs/read_write.c:1096
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dca751f69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0dca6ea218 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f0dca7dc438 RCX: 00007f0dca751f69
RDX: 0000000000000002 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00007f0dca7dc430 R08: 00007ffdc30a1047 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0dca7a92a4
R13: 006e75742f74656e R14: 74656e2f7665642f R15: 796c27468c04729a
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__pskb_pull_tail+0x1568/0x1570 net/core/skbuff.c:2848
Code: 38 c1 0f 8c 32 f1 ff ff 4c 89 f7 e8 92 96 74 f8 e9 25 f1 ff ff e8 e8 ae 09 f8 48 8b 5c 24 08 e9 eb fb ff ff e8 d9 ae 09 f8 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004cbef30 EFLAGS: 00010293
RAX: ffffffff8995c347 RBX: 00000000fffffff2 RCX: ffff88802cf45a00
RDX: 0000000000000000 RSI: 00000000fffffff2 RDI: 0000000000000000
RBP: ffff88807df0c06a R08: ffffffff8995b084 R09: 1ffff1100fbe185c
R10: dffffc0000000000 R11: ffffed100fbe185d R12: ffff888076e85d50
R13: ffff888076e85c80 R14: ffff888076e85cf4 R15: ffff888076e85c80
FS:  00007f0dca6ea6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0dca6ead58 CR3: 00000000119da000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

