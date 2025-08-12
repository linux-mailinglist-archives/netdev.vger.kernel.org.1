Return-Path: <netdev+bounces-212843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEEEB22400
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4716A3AE99F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891D2EA750;
	Tue, 12 Aug 2025 10:03:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC82EA722
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992985; cv=none; b=HvIg/KHDlA2vaaT4tP9GfgVy+EQfkjAUsWMC5Jof/6HzHCDHsjeyF4OvFX3A1AutMxrXvviwgT3gDrpWP8QLXILCRJ5LrCPMQ/5sdxfVEvizX5N5ZhMlMDkYmh0Lnv6bQ2gADixfRAjHaccnSq/JcJcrP0zGKK41tsTB44UpalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992985; c=relaxed/simple;
	bh=V8Td4yiIhp1fByfK4cfqghrB3LJC7VilyAq40eVW1Zw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LGrs00N7NTzHWLRXyVEbWs/pFrGkb+YfDlGjOWKfOTAuyzNpv+c6URa/TVqkUw/d9fDnGCmOcCqFhAeDVsi3KhPmEQTSWSFWMU+6lHu9Z13wVhdXMFW6hWy4P0sMOdL0voCL9npGK+d6fRziSDTP9S00clGbtUoBG3u+/WX723Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88174f2d224so519472539f.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 03:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992982; x=1755597782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZKDF37TU1lzwfEknu372ML6nocSlXYGlciy4tYV/pM=;
        b=QQlY91YDF/TCkaKbgzgyICMOKf3dkbZR6rdpTXi/e8dlYEH5qUX/Tfmvgu5zYNLQbJ
         1W9//WFBYqCFQIGmfLTaSdxGTI6HrfyHVhq1ECDjrR0zoA/9yei07nBPpfi3IjzhPVzH
         joxYq/xKlswjQbbUZRkJ885zBr+BSAw7BXec7lLM8iIVKtpq/fJR4HXEkUGaSwy6H+ce
         OJGGjyEtmwJQTL6pcbtVNdKgbBkIoiHdapEiHcgU1QszSSZBkIHpfSi2ZkqQnKBI9gqh
         u18j3TKhVfm/xOvRr+lv0MydSJPF8uUB/vYnp8shIv2L9F8SLXpiz/Q46ol372ht6+JT
         ZedQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHQg1ESXLI4G0T9ov4YGFAQsnqyYuxrK7u1jaDFQwl3fB81ZzQEFykaejhFYptFcJqnhAr+EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRk3r0CYbmIwnv+tr7ffpncxjM26QTTIQhCvhtIDL5yMr0geqz
	3mO7SZeG0JdCCVdITLmNMNWj1RHr4eA1pwWA8tEzsUFOBgWiaQiH2t5COqugNCiSXqg4DBdcx+a
	rF/dSZ2OJy/HaXH9wHbdSyASf9y4own3uL4Tkq3+3bSYzIai0Evs/6dxjyjk=
X-Google-Smtp-Source: AGHT+IFPQxJ8w6GgR1zw+Su3jgAnPf07mS294rHJhZt5m0Fy8wL2C6nVhzgXe8eriyaH9+BNt9BM+YdACJ8PiU06S1BEQxBPMvWK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7416:b0:881:7627:b0a3 with SMTP id
 ca18e2360f4ac-8841bf8bd7fmr613040739f.14.1754992982677; Tue, 12 Aug 2025
 03:03:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 03:03:02 -0700
In-Reply-To: <20250812052645-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b1156.050a0220.7f033.011c.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in virtio_transport_send_pkt_info

------------[ cut here ]------------
'send_pkt()' returns 0, but 65536 expected
WARNING: CPU: 0 PID: 5936 at net/vmw_vsock/virtio_transport_common.c:428 virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:426
Modules linked in:
CPU: 0 UID: 0 PID: 5936 Comm: syz.0.17 Not tainted 6.16.0-rc6-syzkaller-00030-g6693731487a8 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:426
Code: 0f 0b 90 bd f2 ff ff ff eb bc e8 2a 15 74 f6 c6 05 17 6f 40 04 01 90 48 c7 c7 00 4b b7 8c 44 89 f6 4c 89 ea e8 e0 f7 37 f6 90 <0f> 0b 90 90 e9 e1 fe ff ff e8 01 15 74 f6 90 0f 0b 90 e9 c5 f7 ff
RSP: 0018:ffffc9000cc2f530 EFLAGS: 00010246
RAX: 72837a5a4342cf00 RBX: 0000000000010000 RCX: ffff888033218000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffffff8f8592b0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa6ec R12: dffffc0000000000
R13: 0000000000010000 R14: 0000000000000000 R15: ffff8880406730e4
FS:  00007fc0bd7eb6c0(0000) GS:ffff88808d230000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd5857ec368 CR3: 00000000517cf000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 virtio_transport_stream_enqueue net/vmw_vsock/virtio_transport_common.c:1111 [inline]
 virtio_transport_seqpacket_enqueue+0x143/0x1c0 net/vmw_vsock/virtio_transport_common.c:839
 vsock_connectible_sendmsg+0xac4/0x1050 net/vmw_vsock/af_vsock.c:2123
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmmsg+0x227/0x430 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc0bc98ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc0bd7eb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fc0bcbb5fa0 RCX: 00007fc0bc98ebe9
RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007fc0bca11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000024008094 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc0bcbb6038 R14: 00007fc0bcbb5fa0 R15: 00007ffdb7bf09f8
 </TASK>


Tested on:

commit:         66937314 vsock/virtio: Allocate nonlinear SKBs for han..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=159d75bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84141250092a114f
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.

