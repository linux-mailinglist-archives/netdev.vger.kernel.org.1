Return-Path: <netdev+bounces-147135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4E9D79E6
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 02:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F98CB21442
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACD6B666;
	Mon, 25 Nov 2024 01:59:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA3291E
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732499961; cv=none; b=PGp0h0wgA9DTyFcaYASL1tWnJEtHo5WlYYPwHc6kare5pPBcEAUifn00VmMQE7gzdqAQLbgsKiRRyBTjX2wW4t0xg8hmpu7X4E/WzcYF9x8S576QFigRsYoqzIvqWcqP8tq5vSFbULxnp8AFAsqRoRQgpSrVxkE48A+ikK4Y/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732499961; c=relaxed/simple;
	bh=jOimkNeJ8PSf4wp3zHaf1e+L9kTww0qBwpT05jAXmH8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BOOBXeAzQtNlRP+hwecZKsY6iJBNnEkkD6TzfVw4tXo0sYune2eJYvo90corhuMzXcZiBCB7cqMcIScyP6YlLi+cyzYvTp7SiJ6nv2jsa5zxGjIk8OVocnr5Oeaat2NoRLP1QH2Cn5eobNlf/A2rvYiZpDDAG7PgoilT/Dhxwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a75c23283cso33417655ab.0
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 17:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732499959; x=1733104759;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyP2WlpsFyMyoLJM50Bt2iubn7mJqAwE8aaWAzJfa+c=;
        b=oKmWVmikD/RaD4sL9slzObQFvC3NaUdeh574zL05FA/cUpgKPFAfhzEUm/6XJ8Af7B
         glBU9kiRCtlcdKIn0RICGZuaKKEZ03svzkDUfFGoglaWBGNeMMcMZCoZH4kLsTMTxeB8
         sQaNuky/n5Eq3qtdw7puHuwXB/EMzkFBozOtK2HTNUFZTaQ2OVJSGb3vhvyx9YsMs+4V
         t85tdJ7jFdMuGrHHaxr3RV8JDL8EGnqArK9Xx9ru0W4V0ShrHJtSF8jdJGiDSJlh+wwx
         SQESHOogq+WiSv+DoB08CHBzFmaM1/pCOfoe8D/6VX5g/HwvDuVztFTK3mZ0ibB1d2Di
         imkw==
X-Forwarded-Encrypted: i=1; AJvYcCWJDN5OcgJbUMMsrdzlXK8qrsIJrwwglbWJkZkBhXBUhGyd+Im+vG6l+E9H1RiqIDydw9BmsFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw84UpjWut59Koyt1njmaKvZbCZAEPrh6zbzJLeC6TTmvMbv+o1
	3GFdNhhSabDzfiDXj3bl7eTOLzTp8NJq0WMNt8UzsrVzP4tVmbtk0o5GARSK9AIWl98rq77PLVQ
	GEsAlM0+e837V9iReg/H5PNMzINDdyJIEwS8z0bVuwHZyPDcgYO5fr+c=
X-Google-Smtp-Source: AGHT+IHFRxvzXqxa5HEqVatsAuNcAjMnKDv88RtOzdFLbuSrRv5HTLcEaFatT/gCwmz8NTzXfOdhnMZFVUt0kZmo4lhOUJ5uxQyn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a7:9fff:1353 with SMTP id
 e9e14a558f8ab-3a79fff1550mr100803675ab.0.1732499958844; Sun, 24 Nov 2024
 17:59:18 -0800 (PST)
Date: Sun, 24 Nov 2024 17:59:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743d9f6.050a0220.1cc393.0054.GAE@google.com>
Subject: [syzbot] [hams?] KMSAN: uninit-value in sixpack_receive_buf
From: syzbot <syzbot+c08839217d2085e56bb8@syzkaller.appspotmail.com>
To: ajk@comnets.uni-bremen.de, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bf9aa14fc523 Merge tag 'timers-core-2024-11-18' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d7bae8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1eb27d66c540f6e6
dashboard link: https://syzkaller.appspot.com/bug?extid=c08839217d2085e56bb8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0c0e51a2a13/disk-bf9aa14f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/852f5ece75d3/vmlinux-bf9aa14f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fb1796345b4/bzImage-bf9aa14f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c08839217d2085e56bb8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sixpack_decode drivers/net/hamradio/6pack.c:938 [inline]
BUG: KMSAN: uninit-value in sixpack_receive_buf+0x773/0x2d70 drivers/net/hamradio/6pack.c:447
 sixpack_decode drivers/net/hamradio/6pack.c:938 [inline]
 sixpack_receive_buf+0x773/0x2d70 drivers/net/hamradio/6pack.c:447
 tty_ldisc_receive_buf+0x202/0x290 drivers/tty/tty_buffer.c:391
 tty_port_default_receive_buf+0xdf/0x190 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x473/0xdb0 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:883 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
 __tty_buffer_request_room+0x36e/0x6d0 drivers/tty/tty_buffer.c:273
 __tty_insert_flip_string_flags+0x140/0x570 drivers/tty/tty_buffer.c:309
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x39e/0xa10 drivers/tty/serial/serial_core.c:3550
 serial8250_read_char+0x1a7/0x5d0 drivers/tty/serial/8250/8250_port.c:1743
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1760 [inline]
 serial8250_handle_irq+0x970/0x1130 drivers/tty/serial/8250/8250_port.c:1924
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
 common_interrupt+0x92/0xb0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693

CPU: 1 UID: 0 PID: 7175 Comm: kworker/u8:31 Not tainted 6.12.0-syzkaller-01782-gbf9aa14fc523 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
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

