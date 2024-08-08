Return-Path: <netdev+bounces-116715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF7894B6CB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C5A1C20C66
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701BA18784C;
	Thu,  8 Aug 2024 06:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2B13210D
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098865; cv=none; b=jl33AjkLf0yonCJRiPXfirfjmlwDsp/ghY44BSI9wndg4PM4w2Qutxla73QaClHRTfmVNlrEbU81I6ASLc6u2kjYGC0dVeuYWJrxWJaKBkJowgnmmTRiQgxCe7hq+PQhlxLxEBSH8dXti2GXva6rnndjHwBpPdXJuTorUbO4aFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098865; c=relaxed/simple;
	bh=X0Ywof9eKRr0mCWWZtzPcFfnMDsOZ7Px9FQfHnQkg2w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G63nvdd6ov67QGafyWzwzvnyfV63HaW2VmDLxrNbuM0AHdbbrKAb00wmPhbb1MGvvUpk+55f5t2J7YyR7RJ+gmWs5gOvHTfvQjTnEtNQ88lXjo0B2QNBeAeNCitv4Y+bIee6TEqnosRFofoPjQHa6C+FB4wI4cCNTIBQA9PSVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b3a9f9f5bso7831745ab.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 23:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723098863; x=1723703663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGCP6x6qpwug1AwJ39Kr2WZDwQ9R9XX2ZSoy2u5wdt0=;
        b=QFhJaRfEmULqvZSM9XuCT0IMXeUWotQNL9u6F8l3xfgZZ03koZTiN+5jxnRuNS3Qyx
         2J98n913LbugDMGJgI1MMRfMl+ODkX7KVn2kTkXL9rbB1mBeWiJ7gOV444ooLYbZRQrp
         v9zz3V2RfBYiLH5zkNNA7KF8Ecpo61EXashWyStVE5NuJUq03bRQe92k+Y2eqUGF4Hhh
         7mWROpo5Er9bNVAPCPx4EOIILs9ckypatcQGJl9f+kPi1eRt+t+I3ZLkm0ftv/tynzHB
         hwef9UlwFCgl4TQzuL6WphdZwMu+0yy8KXoInF59DmI572y0DbUAiH9eeVCL4WgDPUpg
         SpAg==
X-Forwarded-Encrypted: i=1; AJvYcCVGPjqaDK5pUfK0ofuWIsQNnU7OgpEmmjH/PkbpWFLGS2ZGL0Q6yNYmOQLM8itDP+y+sjK4dRuaHThBRpiIDLwOFepIxRiw
X-Gm-Message-State: AOJu0YyB9k3n4BX/qm0krY5WNgN343Ea1F+MmQBT5E3ULyjmRF2XFukC
	faExS342AJ0q4tRevFSp9+xzfwcjpgdlPlpUK7oOu1PLJGfSeO+l/2dM3xrQ827PfbtixjzO1lj
	XOfawLH14WVo/aYWw8kIko7v13EuzT1Ygq+F1ql9ZDxksVFcggryv038=
X-Google-Smtp-Source: AGHT+IEgtnjm28cVKYMmpwei9SVf9ut9VVrgjLyTXr1y/VqKia1zSODc6XrJopZUqNdHSESxjKSw0JYwLOaVgPChSPmMi1/lAw+n
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0d:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39b5edaacadmr654145ab.6.1723098863086; Wed, 07 Aug 2024
 23:34:23 -0700 (PDT)
Date: Wed, 07 Aug 2024 23:34:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5c527061f263729@google.com>
Subject: [syzbot] [ppp?] KMSAN: uninit-value in ppp_sync_receive (2)
From: syzbot <syzbot+d73ee3b9fbad2067c916@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    defaf1a2113a Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1034ded9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d6059ad10dde6fd
dashboard link: https://syzkaller.appspot.com/bug?extid=d73ee3b9fbad2067c916
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4b583db7f7f/disk-defaf1a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a61e18e13b2d/vmlinux-defaf1a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/386b01bc4565/bzImage-defaf1a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d73ee3b9fbad2067c916@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ppp_sync_input drivers/net/ppp/ppp_synctty.c:679 [inline]
BUG: KMSAN: uninit-value in ppp_sync_receive+0x56a/0xf10 drivers/net/ppp/ppp_synctty.c:334
 ppp_sync_input drivers/net/ppp/ppp_synctty.c:679 [inline]
 ppp_sync_receive+0x56a/0xf10 drivers/net/ppp/ppp_synctty.c:334
 tty_ldisc_receive_buf+0x202/0x290 drivers/tty/tty_buffer.c:391
 tty_port_default_receive_buf+0xdf/0x190 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x473/0xdb0 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
 __tty_buffer_request_room+0x36e/0x6d0 drivers/tty/tty_buffer.c:273
 __tty_insert_flip_string_flags+0x140/0x570 drivers/tty/tty_buffer.c:309
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x39e/0xa10 drivers/tty/serial/serial_core.c:3560
 serial8250_read_char+0x1a7/0x5d0 drivers/tty/serial/8250/8250_port.c:1743
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1760 [inline]
 serial8250_handle_irq+0x77a/0xb80 drivers/tty/serial/8250/8250_port.c:1924
 serial8250_default_handle_irq+0x120/0x2b0 drivers/tty/serial/8250/8250_port.c:1949
 serial8250_interrupt+0xc5/0x360 drivers/tty/serial/8250/8250_core.c:86
 __handle_irq_event_percpu+0x118/0xca0 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xef/0x2c0 kernel/irq/handle.c:210
 handle_edge_irq+0x340/0xfb0 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x97/0x1f0 arch/x86/kernel/irq.c:285
 common_interrupt+0x8f/0xa0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693

CPU: 1 UID: 0 PID: 3154 Comm: kworker/u8:16 Not tainted 6.11.0-rc1-syzkaller-00293-gdefaf1a2113a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound flush_to_ldisc
=====================================================


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

