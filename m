Return-Path: <netdev+bounces-247802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A760CFED80
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 17:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77B7830012C5
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F1395240;
	Wed,  7 Jan 2026 15:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA87394488
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800063; cv=none; b=kRI0ewnt2znmB3pqcopK/F/+y/H4NVY88Gmb11Qt0dz9hxOL/A6tSetrZSmLEdfDHHbml5Ibhqe9AcG6QrncwdG1jsPyNpG1zcP4SQc4ee29tj1aBNQgKNTedry3L7gKf5K61X5VLZsaifpITbTYbzFgqjM2fipLjw5yQRy/bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800063; c=relaxed/simple;
	bh=+jcXT0Qd0MP/qXpaY/rIBJ8LHVp0WyD94cq6v1/lYNA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FROOJ2fwvrvBCqeWibtQaZhlxUovQ1+kf0BnfGX7/JhLnXuy0okRGaeAix531ozx1iR1OFDjUwbyXKErTKCt1BXtS5EaGtcmfwfG81HoX+Q2l2oGbR3y7rIOWEIAeJDMZT9AEl1WjG2A05GZrIiqwZ1Z8zBKGwPi5wCn7IYzLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65746235dd4so547835eaf.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 07:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800060; x=1768404860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFGKIQl/QbaqT2n6c9mJgM64BLFaT5MMFGibHivKdeQ=;
        b=CpZHlcYlqPafT6ieDiqRH6pS2vVKw/tIV28z0qKw7xFJylUgimg7DiBpaIsWReVoWP
         rwQlyMeIWFhOR0/yG4D01lYUwnDgPpnCRIOGD6pAWzQLUk3sY2l84h2F09O5/C9iCVpk
         DIKvSEtjuT1Hc3ZXrQk8aTc41RvzJq2csHVfQ6/Vscz5HRv1wVGjAaPALNUrtaiABnUB
         k9/bhwGY2O+p2Zm0sn43vfTrjBTR6SSaRnSZ83H3TFg5h+6oOHkx4Az2S7+br9t4kY5t
         cWCxjO1S8DaLesoOT4gT/gduNUgItfHWaujWM1JHq9j9xd95LW+xU4tpFAh8l0AITjG4
         8A4w==
X-Forwarded-Encrypted: i=1; AJvYcCWNgbUNUYrLXBeRFEdJhxYtOQSRuuynMZz7nNzSaVmNd9ZbpiJSPmQxqzWXdeuvpr+0JRUcjpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MLO41/CeJuDW3ldywQAaIHbWEglCk2aKjp8uYT0D4GdB9Nqa
	WxOFwEi2kn9QN8lyjM46WRwECeb7MOGV866sSUVpSy8dgTCaZ6WNgivqVpCoNohSkJcM/E5eswR
	TrCdhQtBmqgshQGPMid3WTlYGwSGKK+7iaRaDZItW2gIA+zLTG/5O/bModVY=
X-Google-Smtp-Source: AGHT+IGF2wQGBSRYfqIMGfsewhBc+zagOQzvOfUtyUbX89hNVPwEDqMoVzj0pFQ7GyGSefeBwC/Iqsq55wcl6bC4YMqkLBWgQBvM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1610:b0:65d:1636:5442 with SMTP id
 006d021491bc7-65f54f6b90amr1254931eaf.56.1767800059693; Wed, 07 Jan 2026
 07:34:19 -0800 (PST)
Date: Wed, 07 Jan 2026 07:34:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e7cfb.050a0220.1c677c.036b.GAE@google.com>
Subject: [syzbot] [afs?] [net?] KCSAN: data-race in rxrpc_peer_keepalive_worker
 / rxrpc_send_data_packet
From: syzbot <syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    30f09200cc4a Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13446e12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=655255e3ef31c19b
dashboard link: https://syzkaller.appspot.com/bug?extid=6182afad5045e6703b3d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/445be400b5e4/disk-30f09200.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8be295d83690/vmlinux-30f09200.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae2ac2a81686/bzImage-30f09200.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in rxrpc_peer_keepalive_worker / rxrpc_send_data_packet

write to 0xffff8881044ab560 of 8 bytes by task 4063 on cpu 1:
 rxrpc_send_data_packet+0x1593/0x1df0 net/rxrpc/output.c:714
 rxrpc_transmit_fresh_data net/rxrpc/call_event.c:255 [inline]
 rxrpc_transmit_some_data+0x63c/0x8b0 net/rxrpc/call_event.c:277
 rxrpc_input_call_event+0x8bb/0xf30 net/rxrpc/call_event.c:401
 rxrpc_io_thread+0x1c1e/0x21c0 net/rxrpc/io_thread.c:550
 kthread+0x489/0x510 kernel/kthread.c:463
 ret_from_fork+0x122/0x1b0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

read to 0xffff8881044ab560 of 8 bytes by task 3500 on cpu 0:
 rxrpc_peer_keepalive_dispatch net/rxrpc/peer_event.c:268 [inline]
 rxrpc_peer_keepalive_worker+0x44e/0x800 net/rxrpc/peer_event.c:341
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3346
 worker_thread+0x582/0x770 kernel/workqueue.c:3427
 kthread+0x489/0x510 kernel/kthread.c:463
 ret_from_fork+0x122/0x1b0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

value changed: 0x0000000000000000 -> 0x0000000000000029

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3500 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: krxrpcd rxrpc_peer_keepalive_worker
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

