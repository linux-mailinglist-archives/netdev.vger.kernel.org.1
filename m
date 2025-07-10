Return-Path: <netdev+bounces-205874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CFB009C8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFCE7B7856
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA12F0E34;
	Thu, 10 Jul 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/yrkClr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJfOV0JV"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F162741D3;
	Thu, 10 Jul 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167922; cv=none; b=EcoDR8JsMXMB5FL15A01YVxL8QcW4nILQlrbLLpc2cTBTXD9VKjuitt8WWB1MZMhsscRvdUW2GQjH9aAmbE5BXv0IXbDHFfS+h2VpfCfrxoo12Ap7D2paPU35wEkyaMYFXj3sgwebGQWd26I9CRw89lULpU/JJw2kZ+EO7FiuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167922; c=relaxed/simple;
	bh=8JGLHd9KwI1hsUfxZDLOIAbieicXy+t4MTagilWWq3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bDpVoY/2B3WHeWHDrwHs5gcuRr+4sX/mrerlHP1PMGalg9lkVVvKLVFk9fsEQXxiLQKa/ipv6XVyLmUMffJ4pJo/IcgYjpGC6wCidjWoQgqW/LGDBsp+CujXPCMHbCGVS5EVmg796kR8MffrnN/5Ta0YhhXjfXf733MbGIpCQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/yrkClr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJfOV0JV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752167914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXIFfi2Bipnzyr4cjiV9P8D8ad88wZzhPdgeCcQPA40=;
	b=V/yrkClrWbDoU5GT3S/aHTVVfVnm0xfRfcTU4NkJbnY4/ENXLO+u5lOOFpCXqnOwQzWVKg
	3Hnq5kOAlsME2A8/CQjj+ua+YjFxD+GUeNX0sCr8sBNCr3AvfBAG6LLrOLSdd4mU6zpr8U
	mxCFapWlx+/7W38Gg5kqATQVzetzORHvp6sk1Iue+hdFyWbZjoqlSbag9xztimZ4iYiuWG
	CCIGCT3II4N7zhcKckDpZYyxllCRdo4dzzXyd+bVoselNx8AiE3kmjauURkvqZNWGHxb0M
	t9z5O/g/lLDMfZaQ7jeYq6hmRCAH8bZrRDe7ouBScov7HdF2YdhoQM8oSxztQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752167914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXIFfi2Bipnzyr4cjiV9P8D8ad88wZzhPdgeCcQPA40=;
	b=MJfOV0JVhhTINYB10G0EdFEjvp5BFaGEyCfbCQAmXCdzoptCRhUAnVE4ELFe8wViM+ASjD
	leMwdIiiMl+eolBw==
To: syzbot <syzbot+613717becd328141aea6@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
 senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Cc: "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    netdev@vger.kernel.org
Subject: Re: [syzbot] [kernel?] Internal error in update_curr_se
In-Reply-To: <686feae2.a00a0220.26a83e.0017.GAE@google.com>
References: <686feae2.a00a0220.26a83e.0017.GAE@google.com>
Date: Thu, 10 Jul 2025 19:24:33 +0206
Message-ID: <84ple8hsly.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

CC netdev-folks since network is probably the real error here. I
included the related printk message below.

John Ogness

On 2025-07-10, syzbot <syzbot+613717becd328141aea6@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8c2e52ebbe88 eventpoll: don't decrement ep refcount while ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1344c0f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d7414ddc603207aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=613717becd328141aea6
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-8c2e52eb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7aa6956f1641/vmlinux-8c2e52eb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6dbbe09dcb32/zImage-8c2e52eb.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+613717becd328141aea6@syzkaller.appspotmail.com
>
> Insufficient stack space to handle exception!
> Task stack:     [0xec5d8000..0xec5da000]
> IRQ stack:      [0xdf800000..0xdf802000]
> Overflow stack: [0x830b9000..0x830ba000]
> Internal error: kernel stack overflow: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 0 UID: 0 PID: 9458 Comm: syz-executor Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT 
> Hardware name: ARM-Versatile Express
> PC is at update_curr_se+0x4/0xcc kernel/sched/fair.c:1147
> LR is at update_curr+0x30/0x318 kernel/sched/fair.c:1236
> pc : [<802a3d44>]    lr : [<802a3e3c>]    psr: a0000193
> sp : df7ffff8  ip : df7ffff8  fp : df80002c
> r10: 00000001  r9 : 00000000  r8 : dddcf080
> r7 : 84e23a00  r6 : 00000409  r5 : dddcf0c0  r4 : 84e23a00
> r3 : 00000000  r2 : 00000409  r1 : 84e23a00  r0 : dddcf080
> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 8688b5c0  DAC: fffffffd
> Register r0 information: non-slab/vmalloc memory
> Register r1 information: slab kmalloc-512 start 84e23a00 pointer offset 0 size 512
> Register r2 information: non-paged memory
> Register r3 information: NULL pointer
> Register r4 information: slab kmalloc-512 start 84e23a00 pointer offset 0 size 512
> Register r5 information: non-slab/vmalloc memory
> Register r6 information: non-paged memory
> Register r7 information: slab kmalloc-512 start 84e23a00 pointer offset 0 size 512
> Register r8 information: non-slab/vmalloc memory
> Register r9 information: NULL pointer
> Register r10 information: non-paged memory
> Register r11 information: 2-page vmalloc region starting at 0xdf800000 allocated at start_kernel+0x5a4/0x750 init/main.c:1004
> Register r12 information: 2-page vmalloc region starting at 0xdf800000 allocated at start_kernel+0x5a4/0x750 init/main.c:1004
> Process syz-executor (pid: 9458, stack limit = 0xec5d8000)
> Stack: (0xdf7ffff8 to 0xdf802000)
> ffe0:                                                       ???????? ????????
> 0000: 00000000 dddcf0c0 83f8be80 00000409 84e23a00 00000000 00000000 00000001
> 0020: df800064 df800030 802a9430 802a3e18 00000000 00000000 00000000 00000409
> 0040: 83f8be80 00000000 dddcf0c0 00000000 00000000 00000001 df8000bc df800068
> 0060: 802a9964 802a9410 df8000dc df800078 802bc254 802b0a48 df8000cc 00000003
> 0080: 00000001 dddcf080 81a2cd48 81a2cc18 df800104 83f8bc00 00000409 dddcf080
> 00a0: 00000409 df80011c dddcf080 00000000 df8000dc df8000c0 80298df4 802a98bc
> 00c0: dddcf080 83f8bc00 00000088 00000409 df800104 df8000e0 8029e680 80298dc8
> 00e0: 83f8bc00 84280000 83f8c494 80000193 00000088 dddcf080 df800154 df800108
> 0100: 8029edb0 8029e624 00000000 00000000 5b70d000 df80011c 00000000 00000000
> 0120: 00000000 cfc088bb 00000000 8295a38c 00000022 8295a390 00000015 82246070
> 0140: 84280000 00000001 df800164 df800158 8029f4e0 8029eb04 df80017c df800168
> 0160: 8025da6c 8029f4d4 00000023 00000022 df80018c df800180 802e6f38 8025da4c
> 0180: df8001ac df800190 803c20b0 802e6f30 00000000 826bdedc 8280c960 00000015
> 01a0: df8001c4 df8001b0 803c2154 803c2094 826bded8 826bdedc df8001e4 df8001c8
> 01c0: 803c2194 803c2108 00000005 00000000 81d100dc 00000015 df80020c df8001e8
> 01e0: 8022f9d0 803c2170 83097d00 8309a080 81d100dc 00000015 df800220 84280000
> 0200: df80021c df800210 8022fb38 8022f84c df80024c df800220 802f1848 8022fb24
> 0220: 802f17ac 8280ccdc df80a000 826c0348 df80a00c 00000000 84280000 00000001
> 0240: df80025c df800250 802eaf8c 802f17b8 df80026c df800260 802eb008 802eaf24
> 0260: df80028c df800270 802012a8 802eaffc 826c195c 824471a0 82409ea4 df8002b8
> 0280: df8002b4 df800290 81a2c0f4 8020124c 81a38d94 20000113 ffffffff df8002ec
> 02a0: 20000113 84280000 df800314 df8002b8 80200bbc 81a2c0a0 82b02980 20000113
> 02c0: df807000 0000654a 00000001 8280ccdc 81c01ab4 83097d18 20000113 84280000
> 02e0: 00000001 df800314 df800318 df800308 80976bb8 81a38d94 20000113 ffffffff
> 0300: 00000000 b5403587 df80033c df800318 80976bb8 81a38d78 80976b2c 83097d18
> 0320: 81c01ab4 81d100dc 82246070 84280000 df800364 df800340 802f9b28 80976b38
> 0340: 00000005 81c01ab4 803c1dd4 00000000 82246070 84280000 df80038c df800368
> 0360: 8022f794 802f9b08 826bdedc 8295a390 803c1dd4 00000000 00000000 84280000
> 0380: df80039c df800390 80230284 8022f768 df8003c4 df8003a0 803c1c6c 8023024c
> 03a0: 8295a390 00000000 82820850 00000000 00000000 84280000 df8003dc df8003c8
> 03c0: 803c1dd4 803c1be8 8295a2f0 00000000 df8003f4 df8003e0 802e873c 803c1d94
> 03e0: 00000035 ffffffff df800444 df8003f8 802e5f80 802e86e0 df80048c 82804d40
> 0400: 00000002 854e0000 8280c6f4 824240ec 00010100 cfc088bb 00000000 83c4a300
> 0420: 8570fa00 826c2ecc 84b67000 00000000 8588d000 00000113 df80045c df800448
> 0440: 802e605c 802e5d8c df80048c df800458 df80046c df800460 802e6d54 802e6040
> 0460: df800484 df800470 80204a24 802e6d50 df80048c cfc088bb df800554 df800498
> 0480: 81566984 80204a00 824240ec 84b670d8 00001500 84280000 818830d0 80261fb8
> 04a0: 818830d0 80261fb8 80261ffc 80293598 df8004e8 004e0000 fffffff4 df8004c8
> 04c0: 818313d0 80304fc0 00000000 00000000 84bb45e0 00000001 df8004fc df8004e8
> 04e0: 80261ffc 80293598 85904010 00000001 00000000 df800500 00000001 826c1650
> 0500: 86680e80 826c1650 85904040 85904000 df8005fc 85827680 00000004 8280c7fc
> 0520: 8243c60c cfc088bb df8005cc 0000000e 83c4a300 8581a800 00000010 00000000
> 0540: ff7e1ea0 00000113 df8005b4 df800558 81811c28 81565c10 83c4a300 00000000
> 0560: 854e0000 856dc400 00000000 00000000 00000000 00000000 00000000 00000000
> 0580: 00000000 cfc088bb 00000000 83c4a300 00000000 854e0000 00000000 000005dc
> 05a0: 84dff000 81d75a90 df8005f4 df8005b8 818168e4 818118bc 85828310 81d75a90
> 05c0: df8005f4 df8005d0 81684870 83c4a300 854e0000 00000000 00000001 84b67000
> 05e0: 84dff000 81d75a90 df80063c df8005f8 81816ad4 818166b8 8189cff4 00000a04
> 0600: 84dff000 84b67000 00000000 854e0000 818166ac cfc088bb 83c4a300 854e0000
> 0620: 00000000 00000000 84280000 826c2ece df80065c df800640 8189d09c 81816a60
> 0640: 83c4a300 00000000 84dff000 00000000 df800694 df800660 80ceebc8 8189d068
> 0660: 00000000 00000008 df8006fb 83c4a300 00000000 cfc088bb 84b67000 0000008c
> 0680: 00000000 00000000 df8006b4 df800698 80cef51c 80cee7f8 83c4a300 84b67000
> 06a0: 00000000 00000000 df800704 df8006b8 815658f4 80cef510 00000052 00000036
> 06c0: df800704 df800728 82804d40 0000008c 824471a0 8570fa00 83c4a300 83c4a300
> 06e0: 8570fa00 826c2ecc 84b67000 df800708 8588d000 00000113 df8007c4 df800708
> 0700: 81565f54 8156581c 818830d0 80261fb8 818830d0 80261fb8 80261ffc 80293598
> 0720: df800758 004e0000 fffffff4 df800738 818313d0 80304fc0 00000000 00000000
> 0740: 84bb45e0 00000001 df80076c df800758 80261ffc 80293598 85904010 00000001
> 0760: 00000000 df800770 00000001 826c1650 86680e80 826c1650 85904040 85904000
> 0780: df80086c 85827680 00000004 8280c7fc 8243c60c cfc088bb df80083c 0000000e
> 07a0: 83c4a300 8581a800 00000010 00000000 ff7e1ea0 00000113 df800824 df8007c8
> 07c0: 81811c28 81565c10 83c4a300 00000000 854e0000 856dc400 00000000 00000000
> 07e0: 00000000 00000000 00000000 00000000 00000000 cfc088bb 00000000 83c4a300
> 0800: 00000000 854e0000 00000000 000005dc 84dff000 81d75a90 df800864 df800828
> 0820: 818168e4 818118bc 85828310 81d75a90 df800864 df800840 81684870 83c4a300
> 0840: 854e0000 00000000 00000001 84b67000 84dff000 81d75a90 df8008ac df800868
> 0860: 81816ad4 818166b8 8189cff4 00000a04 84dff000 84b67000 00000000 854e0000
> 0880: 818166ac cfc088bb 83c4a300 854e0000 00000000 00000000 84280000 826c2ece
> 08a0: df8008cc df8008b0 8189d09c 81816a60 83c4a300 00000000 84dff000 00000000
> 08c0: df800904 df8008d0 80ceebc8 8189d068 00000000 00000008 df80096b 83c4a300
> 08e0: 00000000 cfc088bb 84b67000 0000008c 00000000 00000000 df800924 df800908
> 0900: 80cef51c 80cee7f8 83c4a300 84b67000 00000000 00000000 df800974 df800928
> 0920: 815658f4 80cef510 00000052 00000036 df800974 df800998 82804d40 0000008c
> 0940: 824471a0 8570fa00 83c4a300 83c4a300 8570fa00 826c2ecc 84b67000 df800978
> 0960: 8588d000 00000113 df800a34 df800978 81565f54 8156581c 818830d0 80261fb8
> 0980: 818830d0 80261fb8 80261ffc 80293598 df8009c8 004e0000 fffffff4 df8009a8
> 09a0: 818313d0 80304fc0 00000000 00000000 84bb45e0 00000001 df8009dc df8009c8
> 09c0: 80261ffc 80293598 85904010 00000001 00000000 df8009e0 00000001 826c1650
> 09e0: 86680e80 826c1650 85904040 85904000 df800adc 85827680 00000004 8280c7fc
> 0a00: 8243c60c cfc088bb df800aac 0000000e 83c4a300 8581a800 00000010 00000000
> 0a20: ff7e1ea0 00000113 df800a94 df800a38 81811c28 81565c10 83c4a300 00000000
> 0a40: 854e0000 856dc400 00000000 00000000 00000000 00000000 00000000 00000000
> 0a60: 00000000 cfc088bb 00000000 83c4a300 00000000 854e0000 00000000 000005dc
> 0a80: 84dff000 81d75a90 df800ad4 df800a98 818168e4 818118bc 85828310 81d75a90
> 0aa0: df800ad4 df800ab0 81684870 83c4a300 854e0000 00000000 00000001 84b67000
> 0ac0: 84dff000 81d75a90 df800b1c df800ad8 81816ad4 818166b8 8189cff4 00000a04
> 0ae0: 84dff000 84b67000 00000000 854e0000 818166ac cfc088bb 83c4a300 854e0000
> 0b00: 00000000 00000000 84280000 826c2ece df800b3c df800b20 8189d09c 81816a60
> 0b20: 83c4a300 00000000 84dff000 00000000 df800b74 df800b40 80ceebc8 8189d068
> 0b40: 00000000 00000008 df800bdb 83c4a300 00000000 cfc088bb 84b67000 0000008c
> 0b60: 00000000 00000000 df800b94 df800b78 80cef51c 80cee7f8 83c4a300 84b67000
> 0b80: 00000000 00000000 df800be4 df800b98 815658f4 80cef510 00000052 00000036
> 0ba0: df800be4 df800c08 82804d40 0000008c 824471a0 8570fa00 83c4a300 83c4a300
> 0bc0: 8570fa00 826c2ecc 84b67000 df800be8 8588d000 00000113 df800ca4 df800be8
> 0be0: 81565f54 8156581c 818830d0 80261fb8 818830d0 80261fb8 80261ffc 80293598
> 0c00: df800c38 004e0000 fffffff4 df800c18 818313d0 80304fc0 00000000 00000000
> 0c20: 84bb45e0 00000001 df800c4c df800c38 80261ffc 80293598 85904010 00000001
> 0c40: 00000000 df800c50 00000001 826c1650 86680e80 826c1650 85904040 85904000
> 0c60: df800d4c 85827680 00000004 8280c7fc 8243c60c cfc088bb df800d1c 0000000e
> 0c80: 83c4a300 8581a800 00000010 00000000 ff7e1ea0 00000113 df800d04 df800ca8
> 0ca0: 81811c28 81565c10 83c4a300 00000000 854e0000 856dc400 00000000 00000000
> 0cc0: 00000000 00000000 00000000 00000000 00000000 cfc088bb 00000000 83c4a300
> 0ce0: 00000000 854e0000 00000000 000005dc 84dff000 81d75a90 df800d44 df800d08
> 0d00: 818168e4 818118bc 85828310 81d75a90 df800d44 df800d20 81684870 83c4a300
> 0d20: 854e0000 00000000 00000001 84b67000 84dff000 81d75a90 df800d8c df800d48
> 0d40: 81816ad4 818166b8 8189cff4 00000a04 84dff000 84b67000 00000000 854e0000
> 0d60: 818166ac cfc088bb 83c4a300 854e0000 00000000 00000000 84280000 826c2ece
> 0d80: df800dac df800d90 8189d09c 81816a60 83c4a300 00000000 84dff000 00000000
> 0da0: df800de4 df800db0 80ceebc8 8189d068 00000000 00000008 df800e4b 83c4a300
> 0dc0: 00000000 cfc088bb 84b67000 0000008c 00000000 00000000 df800e04 df800de8
> 0de0: 80cef51c 80cee7f8 83c4a300 84b67000 00000000 00000000 df800e54 df800e08
> 0e00: 815658f4 80cef510 00000052 00000036 df800e54 df800e78 82804d40 0000008c
> 0e20: 824471a0 8570fa00 83c4a300 83c4a300 8570fa00 826c2ecc 84b67000 df800e58
> 0e40: 8588d000 00000113 df800f14 df800e58 81565f54 8156581c 818830d0 80261fb8
> 0e60: 818830d0 80261fb8 80261ffc 80293598 df800ea8 004e0000 fffffff4 df800e88
> 0e80: 818313d0 80304fc0 00000000 00000000 84bb45e0 00000001 df800ebc df800ea8
> 0ea0: 80261ffc 80293598 85904010 00000001 00000000 df800ec0 00000001 826c1650
> 0ec0: 86680e80 826c1650 85904040 85904000 df800fbc 85827680 00000004 8280c7fc
> 0ee0: 8243c60c cfc088bb df800f8c 0000000e 83c4a300 8581a800 00000010 00000000
> 0f00: ff7e1ea0 00000113 df800f74 df800f18 81811c28 81565c10 83c4a300 00000000
> 0f20: 854e0000 856dc400 00000000 00000000 00000000 00000000 00000000 00000000
> 0f40: 00000000 cfc088bb 00000000 83c4a300 00000000 854e0000 00000000 000005dc
> 0f60: 84dff000 81d75a90 df800fb4 df800f78 818168e4 818118bc 85828310 81d75a90
> 0f80: df800fb4 df800f90 81684870 83c4a300 854e0000 00000000 00000001 84b67000
> 0fa0: 84dff000 81d75a90 df800ffc df800fb8 81816ad4 818166b8 8189cff4 00000a04
> 0fc0: 84dff000 84b67000 00000000 854e0000 818166ac cfc088bb 83c4a300 854e0000
> 0fe0: 00000000 00000000 84280000 826c2ece df80101c df801000 8189d09c 81816a60
> 1000: 83c4a300 00000000 84dff000 00000000 df801054 df801020 80ceebc8 8189d068
> 1020: 00000000 00000008 df8010bb 83c4a300 00000000 cfc088bb 84b67000 0000008c
> 1040: 00000000 00000000 df801074 df801058 80cef51c 80cee7f8 83c4a300 84b67000
> 1060: 00000000 00000000 df8010c4 df801078 815658f4 80cef510 00000052 00000036
> 1080: df8010c4 df8010e8 82804d40 0000008c 824471a0 8570fa00 83c4a300 83c4a300
> 10a0: 8570fa00 826c2ecc 84b67000 df8010c8 8588d000 00000113 df801184 df8010c8
> 10c0: 81565f54 8156581c 818830d0 80261fb8 818830d0 80261fb8 80261ffc 80293598
> 10e0: df801118 004e0000 fffffff4 df8010f8 818313d0 80304fc0 00000000 00000000
> 1100: 84bb45e0 00000001 df80112c df801118 80261ffc 80293598 85904010 00000001
> 1120: 00000000 df801130 00000001 826c1650 86680e80 826c1650 85904040 85904000
> 1140: df80122c 85827680 00000004 8280c7fc 8243c60c cfc088bb df8011fc 0000000e
> 1160: 83c4a300 8581a800 00000010 00000000 ff7e1ea0 00000113 df8011e4 df801188
> 1180: 81811c28 81565c10 83c4a300 00000000 854e0000 856dc400 00000000 00000000
> 11a0: 00000000 00000000 00000000 00000000 00000000 cfc088bb 00000000 83c4a300
> 11c0: 00000000 854e0000 00000000 000005dc 84dff000 81d75a90 df801224 df8011e8
> 11e0: 818168e4 818118bc 85828310 81d75a90 df801224 df801200 81684870 83c4a300
> 1200: 854e0000 00000000 00000001 84b67000 84dff000 81d75a90 df80126c df801228
> 1220: 81816ad4 818166b8 8189cff4 00000a04 84dff000 84b67000 00000000 854e0000
> 1240: 818166ac cfc088bb 83c4a300 854e0000 00000000 00000000 84280000 826c2ece
> 1260: df80128c df801270 8189d09c 81816a60 83c4a300 00000000 84dff000 00000000
> 1280: df8012c4 df801290 80ceebc8 8189d068 00000000 00000008 df80132b 83c4a300
> 12a0: 00000000 cfc088bb 84b67000 0000008c 00000000 00000000 df8012e4 df8012c8
> 12c0: 80cef51c 80cee7f8 83c4a300 84b67000 00000000 00000000 df801334 df8012e8
> 12e0: 815658f4 80cef510 00000052 00000036 df801334 df801358 82804d40 0000008c
> 1300: 824471a0 8570fa00 83c4a300 83c4a300 8570fa00 826c2ecc 84b67000 df801338
> 1320: 8588d000 00000113 df8013f4 df801338 81565f54 8156581c 818830d0 80261fb8
> 1340: 818830d0 80261fb8 80261ffc 80293598 df801388 004e0000 fffffff4 df801368
> 1360: 818313d0 80304fc0 00000000 00000000 84bb45e0 00000001 df80139c df801388
> 1380: 80261ffc 80293598 85904010 00000001 00000000 df8013a0 00000001 826c1650
> 13a0: 86680e80 826c1650 85904040 85904000 df80149c 85827680 00000004 8280c7fc
> 13c0: 8243c60c cfc088bb df80146c 0000000e 83c4a300 8581a800 00000010 00000000
> 13e0: ff7e1ea0 00000113 df801454 df8013f8 81811c28 81565c10 83c4a300 00000000
> 1400: 854e0000 856dc400 00000000 00000000 00000000 00000000 00000000 00000000
> 1420: 00000000 cfc088bb 00000000 83c4a300 00000000 854e0000 00000000 000005dc
> 1440: 84dff000 81d75a90 df801494 df801458 818168e4 818118bc 85828310 81d75a90
> 1460: df801494 df801470 81684870 83c4a300 854e0000 00000000 00000001 84b67000
> 1480: 84dff000 81d75a90 df8014dc df801498 81816ad4 818166b8 8189cff4 00000a04
> 14a0: 84dff000 84b67000 00000000 854e0000 818166ac cfc088bb 83c4a300 854e0000
> 14c0: 00000000 00000000 84280000 826c2ece df8014fc df8014e0 8189d09c 81816a60
> 14e0: 83c4a300 00000000 84dff000 00000000 df801534 df801500 80ceebc8 8189d068
> 1500: 00000000 00000008 df80159b 83c4a300 00000000 cfc088bb 84b67000 0000008c
> 1520: 00000000 00000000 df801554 df801538 80cef51c 80cee7f8 83c4a300 84b67000
> 1540: 00000000 00000000 df8015a4 df801558 815658f4 80cef510 00000052 00000036
> 1560: df8015a4 df8015c8 82804d40 0000008c 824471a0 8570fa00 83c4a300 83c4a300
> 1580: 8570fa00 826c2ecc 84b67000 df8015a8 8588d000 00000113 df801664 df8015a8
> 15a0: 81565f54 8156581c 818830d0 80261fb8 818830d0 80261fb8 80261ffc 80293598
> 15c0: df8015f8 004e0000 fffffff4 df8015d8 818313d0 80304fc0 00000000 00000000
> 15e0: 84bb45e0 00000001 df80160c df8015f8 80261ffc 80293598 85904010 00000001
> 1600: 00000000 df801610 00000001 826c1650 86680e80 826c1650 85904040 85904000
> 1620: df80170c 85827680 00000004 8280c7fc 8243c60c cfc088bb df8016dc 0000000e
> 1640: 83c4a300 8581a800 00000010 00000000 ff7e1ea0 00000113 df8016c4 df801668
> 1660: 81811c28 81565c10 83c4a300 00000000 854e0000 856dc400 00000000 00000000
> 1680: 00000000 00000000 00000000 00000000 00000000 cfc088bb 00000000 83c4a300
> 16a0: 00000000 854e0000 00000000 000005dc 84dff000 81d75a90 df801704 df8016c8
> 16c0: 818168e4 818118bc 85828310 81d75a90 df801704 df8016e0 81684870 83c4a300
> 16e0: 854e0000 00000000 00000001 84b67000 84dff000 81d75a90 df80174c df801708
> 1700: 81816ad4 818166b8 8189cff4 00000a04 84dff000 84b67000 00000000 854e0000
> 1720: 818166ac cfc088bb 83c4a300 854e0000 00000000 00000000 84280000 826c2ece
> 1740: df80176c df801750 8189d09c 81816a60 83c4a300 00000000 84dff000 00000000
> 1760: df8017a4 df801770 80ceebc8 8189d068 26ffa6a3 00000010 00000001 83c4a300
> 1780: 00000000 cfc088bb 84b67000 0000008c 00000000 00000000 df8017c4 df8017a8
> 17a0: 80cef51c 80cee7f8 83c4a300 84b67000 00000000 00000000 df801814 df8017c8
> 17c0: 815658f4 80cef510 00000052 00000036 df801814 df801838 82804d40 0000008c
> 17e0: 824471a0 8570fa00 83c4a300 83c4a300 8570fa00 826c2ecc 84b67000 df801818
> 1800: 8588d000 00000113 df8018d4 df801818 81565f54 8156581c 84b67000 00000006
> 1820: 8581a868 8581a868 856dc54c 8183d788 81811b50 008168e4 fffffff4 df801848
> 1840: 80261ffc 80293598 8581a800 84b67000 df80186c df801860 81a38c78 80261fb8
> 1860: df8018ec df801870 8157a71c 81a38c58 00000000 00000036 0000000e 00000005
> 1880: 000086dd 8581a868 df8018b4 df801898 815e2e4c 8153d0f0 815e2e28 8581a800
> 18a0: 80cef010 cfc088bb df8018d4 83c4a300 8581a800 80cef010 84b67000 00000000
> 18c0: ff7e1ea0 00000113 df801904 df8018d8 81579278 81565c10 00000000 0000007e
> 18e0: df801904 84b67000 83c4a300 8581a800 855136c2 00000009 df801964 df801908
> 1900: 81811b50 81579170 83c4a300 00000000 854e0000 856dc400 00000000 00000000
> 1920: 00000000 00000000 00000000 00000000 00000000 cfc088bb 00000000 83c4a300
> 1940: 842cd400 854e0000 00000000 000005dc 84e7d000 00000040 df8019a4 df801968
> 1960: 818168e4 818118bc 85828310 00000040 df8019a4 df801980 81684870 83c4a300
> 1980: 854e0000 842cd400 00000001 84b67000 84e7d000 00000040 df8019ec df8019a8
> 19a0: 81816ad4 818166b8 8189cff4 00000a04 84e7d000 84b67000 842cd400 854e0000
> 19c0: 818166ac cfc088bb 83c4a300 854e0000 842cd400 0000007e 855136aa 00000070
> 19e0: df801a0c df8019f0 8189d09c 81816a60 83c4a300 85513680 84e7d000 0000007e
> 1a00: df801a54 df801a10 818a0960 8189d068 00000056 84e7d6f8 df801a54 00000000
> 1a20: 00000000 842cd400 00000000 83c4a300 84e7d000 84e7d6f8 8588d000 00000040
> 1a40: 0000f9ae 84e7d6c0 df801aec df801a58 80d56ac0 818a07cc df801aac 84e7d710
> 1a60: 00000000 00000040 00000000 0000f9ae 0000c117 00000000 826c2e40 82ad9ee4
> 1a80: 00000070 85513680 0000ffff 854e0000 854e0000 00000000 00000000 85d9c000
> 1aa0: 00000001 cfc088bb df801b2c 00000000 00000000 00000000 0b1414ac cfc088bb
> 1ac0: 83c4a300 83c4a300 84e7d000 00000000 00000000 84280000 826c2ece 81d7bdd4
> 1ae0: df801b3c df801af0 815658f4 80d56258 8588d9c0 00000113 df801b3c df801b60
> 1b00: 82804d40 00000046 824471a0 85715000 83c4a300 83c4a300 85715000 826c2ecc
> 1b20: 84e7d000 df801b40 8588d9c0 00000113 df801bfc df801b40 81565f54 8156581c
> 1b40: 8183df74 8183f608 df801b94 df801b58 8183d840 8183ce88 80328e2c 0026199c
> 1b60: fffffff4 df801b70 80261ffc 80293598 8581a400 84e7d000 df801b94 df801b88
> 1b80: 81a38c78 80261fb8 df801c14 df801b98 8157a71c 81a38c58 00000000 df801ba8
> 1ba0: 80261ffc 80293598 859042b0 00000001 df801c94 df801bc0 818830d0 80261fb8
> 1bc0: 00000400 829e567c 000086dd cfc088bb df801bfc 83c4a300 8581a400 815e2e28
> 1be0: 84e7d000 00000000 ff7e1ea0 00000113 df801c2c df801c00 81579278 81565c10
> 1c00: 00000000 00000038 df801c2c 84e7d000 83c4a300 8581a400 85513708 00000009
> 1c20: df801c8c df801c30 81811b50 81579170 83c4a300 00000038 854e0000 856e5c00
> 1c40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 cfc088bb
> 1c60: 00000000 83c4a300 842c8b40 854e0000 00000000 000005dc 84e7d000 842c8b40
> 1c80: df801ccc df801c90 818168e4 818118bc 85828310 842c8b40 df801ccc df801ca8
> 1ca0: 81684870 83c4a300 854e0000 842c8b40 00000001 84e7d000 84e7d000 842c8b40
> 1cc0: df801d14 df801cd0 81816ad4 818166b8 83c4a300 00000a04 84e7d000 84e7d000
> 1ce0: 842c8b40 854e0000 818166ac cfc088bb 83c4a300 856e5c00 00000001 df801e14
> 1d00: 8588d9c0 854e0000 df801ddc df801d18 8183df74 81816a60 ec54ac30 0000003d
> 1d20: 85513680 00000070 00000085 60000000 000000ff 00000010 00000a03 00000000
> 1d40: 84e7d000 842c8b40 854e0000 8183cd3c 0000003d 00000000 00000000 00000000
> 1d60: 003a0000 00000001 00000000 00000000 00000000 00000000 000002ff 00000000
> 1d80: 00000000 02000000 000080fe 00000000 ffaaaaa8 41aaaafe 00000000 00000085
> 1da0: 00000000 00000000 df801ddc cfc088bb 00000008 84e7d000 83c4a300 df801e14
> 1dc0: 81e7d724 00000000 df801ec8 81c05258 df801e0c df801de0 8183f608 8183dd20
> 1de0: 00000000 df801df0 818223c4 856e5d4c 856e5e88 856e5d48 84e7d000 00000100
> 1e00: df801e54 df801e10 818224a0 8183f5ac 8029f97c 000080fe 00000000 ffaaaaa8
> 1e20: 41aaaafe cfc088bb df801e44 84280000 856e5e88 818223d4 000c1000 00000100
> 1e40: df801ec8 81c05258 df801e8c df801e58 803287b0 818223e0 00000000 856e5e88
> 1e60: 81c05258 cfc088bb 856e5e88 dddc4f00 818223d4 00000000 000c1000 df801ec8
> 1e80: df801f0c df801e90 80328c64 8032878c 82804d40 00000000 829fc90c 82258cbc
> 1ea0: 8280c690 00000004 829fa5ee 84280000 803408f4 00000000 00000000 85c23788
> 1ec0: 876d3f9c 8295a670 00000000 00000000 00000000 00000000 00000000 cfc088bb
> 1ee0: 00000002 dddc4f00 00000002 00000002 00000001 00000100 82804d40 84280000
> 1f00: df801f2c df801f10 80328e00 803289ac 82804084 00000000 00000002 82804084
> 1f20: df801f3c df801f30 80328e2c 80328da4 df801fac df801f40 8026199c 80328e1c
> 1f40: 81a2cd28 81a2cc18 00400140 82804d40 000c1001 826c1980 826c1980 824471a0
> 1f60: 00000000 0000000a 826b7210 82438988 df801f40 82804080 802bcae8 802b014c
> 1f80: 84280000 84280000 824471a0 82409ea4 ec5d9fb0 00000000 0000003e 00000008
> 1fa0: df801fc4 df801fb0 80261e10 80261868 826c195c 824471a0 df801fd4 df801fc8
> 1fc0: 80262188 80261d0c df801ffc df801fd8 81a2c110 80262184 00027e50 60000010
> 1fe0: ffffffff 84280000 826b7044 0000003e ec5d9fac df802000 819fb9f4 81a2c0a0
> Call trace: frame pointer underflow
> [<802a3e0c>] (update_curr) from [<802a9430>] (enqueue_entity+0x2c/0x4ac kernel/sched/fair.c:5331)
>  r10:00000001 r9:00000000 r8:00000000 r7:84e23a00 r6:00000409 r5:83f8be80
>  r4:dddcf0c0
> [<802a9404>] (enqueue_entity) from [<802a9964>] (enqueue_task_fair+0xb4/0x774 kernel/sched/fair.c:6985)
>  r10:00000001 r9:00000000 r8:00000000 r7:dddcf0c0 r6:00000000 r5:83f8be80
>  r4:00000409
> [<802a98b0>] (enqueue_task_fair) from [<80298df4>] (enqueue_task+0x38/0x174 kernel/sched/core.c:2084)
>  r10:00000000 r9:dddcf080 r8:df80011c r7:00000409 r6:dddcf080 r5:00000409
>  r4:83f8bc00
> [<80298dbc>] (enqueue_task) from [<8029e680>] (activate_task kernel/sched/core.c:2126 [inline])
> [<80298dbc>] (enqueue_task) from [<8029e680>] (ttwu_do_activate+0x68/0x2d8 kernel/sched/core.c:3746)
>  r7:00000409 r6:00000088 r5:83f8bc00 r4:dddcf080
> [<8029e618>] (ttwu_do_activate) from [<8029edb0>] (ttwu_queue kernel/sched/core.c:4019 [inline])
> [<8029e618>] (ttwu_do_activate) from [<8029edb0>] (try_to_wake_up+0x2b8/0x9d0 kernel/sched/core.c:4347)
>  r9:dddcf080 r8:00000088 r7:80000193 r6:83f8c494 r5:84280000 r4:83f8bc00
> [<8029eaf8>] (try_to_wake_up) from [<8029f4e0>] (wake_up_process+0x18/0x1c kernel/sched/core.c:4480)
>  r10:00000001 r9:84280000 r8:82246070 r7:00000015 r6:8295a390 r5:00000022
>  r4:8295a38c
> [<8029f4c8>] (wake_up_process) from [<8025da6c>] (rcuwait_wake_up+0x2c/0x3c kernel/exit.c:336)
> [<8025da40>] (rcuwait_wake_up) from [<802e6f38>] (nbcon_kthread_wake kernel/printk/internal.h:173 [inline])
> [<8025da40>] (rcuwait_wake_up) from [<802e6f38>] (nbcon_irq_work+0x14/0x18 kernel/printk/nbcon.c:1229)
>  r5:00000022 r4:00000023
> [<802e6f24>] (nbcon_irq_work) from [<803c20b0>] (irq_work_single+0x28/0x74 kernel/irq_work.c:221)
> [<803c2088>] (irq_work_single) from [<803c2154>] (irq_work_run_list+0x58/0x68 kernel/irq_work.c:252)
>  r7:00000015 r6:8280c960 r5:826bdedc r4:00000000
> [<803c20fc>] (irq_work_run_list) from [<803c2194>] (irq_work_run+0x30/0x44 kernel/irq_work.c:261)
>  r5:826bdedc r4:826bded8
> [<803c2164>] (irq_work_run) from [<8022f9d0>] (do_handle_IPI+0x190/0x2d8 arch/arm/kernel/smp.c:665)
>  r7:00000015 r6:81d100dc r5:00000000 r4:00000005
> [<8022f840>] (do_handle_IPI) from [<8022fb38>] (ipi_handler+0x20/0x28 arch/arm/kernel/smp.c:703)
>  r9:84280000 r8:df800220 r7:00000015 r6:81d100dc r5:8309a080 r4:83097d00
> [<8022fb18>] (ipi_handler) from [<802f1848>] (handle_percpu_devid_irq+0x9c/0x2cc kernel/irq/chip.c:857)
> [<802f17ac>] (handle_percpu_devid_irq) from [<802eaf8c>] (generic_handle_irq_desc include/linux/irqdesc.h:173 [inline])
> [<802f17ac>] (handle_percpu_devid_irq) from [<802eaf8c>] (handle_irq_desc+0x74/0x84 kernel/irq/irqdesc.c:676)
>  r10:00000001 r9:84280000 r8:00000000 r7:df80a00c r6:826c0348 r5:df80a000
>  r4:8280ccdc r3:802f17ac
> [<802eaf18>] (handle_irq_desc) from [<802eb008>] (generic_handle_domain_irq+0x18/0x1c kernel/irq/irqdesc.c:732)
> [<802eaff0>] (generic_handle_domain_irq) from [<802012a8>] (gic_handle_irq+0x68/0x7c drivers/irqchip/irq-gic.c:370)
> [<80201240>] (gic_handle_irq) from [<81a2c0f4>] (generic_handle_arch_irq+0x60/0x80 kernel/irq/handle.c:238)
>  r7:df8002b8 r6:82409ea4 r5:824471a0 r4:826c195c
> [<81a2c094>] (generic_handle_arch_irq) from [<80200bbc>] (__irq_svc+0x7c/0xbc arch/arm/kernel/entry-armv.S:228)
> Exception stack(0xdf8002b8 to 0xdf800300)
> 02a0:                                                       82b02980 20000113
> 02c0: df807000 0000654a 00000001 8280ccdc 81c01ab4 83097d18 20000113 84280000
> 02e0: 00000001 df800314 df800318 df800308 80976bb8 81a38d94 20000113 ffffffff
>  r9:84280000 r8:20000113 r7:df8002ec r6:ffffffff r5:20000113 r4:81a38d94
> [<81a38d6c>] (_raw_spin_unlock_irqrestore) from [<80976bb8>] (gic_ipi_send_mask+0x8c/0xb0 drivers/irqchip/irq-gic.c:847)
> [<80976b2c>] (gic_ipi_send_mask) from [<802f9b28>] (__ipi_send_mask+0x2c/0xcc kernel/irq/ipi.c:285)
>  r9:84280000 r8:82246070 r7:81d100dc r6:81c01ab4 r5:83097d18 r4:80976b2c
> [<802f9afc>] (__ipi_send_mask) from [<8022f794>] (smp_cross_call+0x38/0xe4 arch/arm/kernel/smp.c:710)
>  r9:84280000 r8:82246070 r7:00000000 r6:803c1dd4 r5:81c01ab4 r4:00000005
> [<8022f75c>] (smp_cross_call) from [<80230284>] (arch_irq_work_raise+0x44/0x48 arch/arm/kernel/smp.c:583)
>  r9:84280000 r8:00000000 r7:00000000 r6:803c1dd4 r5:8295a390 r4:826bdedc
> [<80230240>] (arch_irq_work_raise) from [<803c1c6c>] (irq_work_raise kernel/irq_work.c:84 [inline])
> [<80230240>] (arch_irq_work_raise) from [<803c1c6c>] (__irq_work_queue_local+0x90/0x1ac kernel/irq_work.c:112)
> [<803c1bdc>] (__irq_work_queue_local) from [<803c1dd4>] (irq_work_queue kernel/irq_work.c:124 [inline])
> [<803c1bdc>] (__irq_work_queue_local) from [<803c1dd4>] (irq_work_queue+0x4c/0x88 kernel/irq_work.c:116)
>  r9:84280000 r8:00000000 r7:00000000 r6:82820850 r5:00000000 r4:8295a390
> [<803c1d88>] (irq_work_queue) from [<802e873c>] (nbcon_kthreads_wake+0x68/0x80 kernel/printk/nbcon.c:1271)
>  r5:00000000 r4:8295a2f0
> [<802e86d4>] (nbcon_kthreads_wake) from [<802e5f80>] (vprintk_emit+0x200/0x2b4 kernel/printk/printk.c:2432)
>  r5:ffffffff r4:00000035
> [<802e5d80>] (vprintk_emit) from [<802e605c>] (vprintk_default+0x28/0x30 kernel/printk/printk.c:2465)
>  r10:00000113 r9:8588d000 r8:00000000 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<802e6034>] (vprintk_default) from [<802e6d54>] (vprintk+0x10/0x14 kernel/printk/printk_safe.c:82)
> [<802e6d44>] (vprintk) from [<80204a24>] (_printk+0x34/0x58 kernel/printk/printk.c:2475)
> [<802049f0>] (_printk) from [<81566984>] (__dev_queue_xmit+0xd80/0xfa4 net/core/dev.c:4728)

This is the message that is trying to be printed. Maybe this is useful?

int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
{
	...

		/* Other cpus might concurrently change txq->xmit_lock_owner
		 * to -1 or to their cpu id, but not to our id.
		 */
		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {

			...

		} else {
			/* Recursion is detected! It is possible,
			 * unfortunately
			 */
recursion_alert:
			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
					     dev->name);
		}

>  r3:84280000 r2:00001500 r1:84b670d8 r0:824240ec
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_hh_output include/net/neighbour.h:523 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_output include/net/neighbour.h:537 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (ip6_finish_output2+0x378/0x990 net/ipv6/ip6_output.c:141)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:00000010 r6:8581a800 r5:83c4a300
>  r4:0000000e
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:81d75a90 r9:84dff000 r8:000005dc r7:00000000 r6:854e0000 r5:00000000
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:81d75a90 r9:84dff000 r8:84b67000 r7:00000001 r6:00000000 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:511 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:552 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:616 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_queue_xmit+0x3dc/0x5a4 drivers/net/ipvlan/ipvlan_core.c:682)
>  r7:00000000 r6:84dff000 r5:00000000 r4:83c4a300
> [<80cee7ec>] (ipvlan_queue_xmit) from [<80cef51c>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:224)
>  r7:00000000 r6:00000000 r5:0000008c r4:84b67000
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r7:00000000 r6:00000000 r5:84b67000 r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d000 r8:df800708 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_hh_output include/net/neighbour.h:523 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_output include/net/neighbour.h:537 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (ip6_finish_output2+0x378/0x990 net/ipv6/ip6_output.c:141)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:00000010 r6:8581a800 r5:83c4a300
>  r4:0000000e
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:81d75a90 r9:84dff000 r8:000005dc r7:00000000 r6:854e0000 r5:00000000
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:81d75a90 r9:84dff000 r8:84b67000 r7:00000001 r6:00000000 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:511 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:552 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:616 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_queue_xmit+0x3dc/0x5a4 drivers/net/ipvlan/ipvlan_core.c:682)
>  r7:00000000 r6:84dff000 r5:00000000 r4:83c4a300
> [<80cee7ec>] (ipvlan_queue_xmit) from [<80cef51c>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:224)
>  r7:00000000 r6:00000000 r5:0000008c r4:84b67000
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r7:00000000 r6:00000000 r5:84b67000 r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d000 r8:df800978 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_hh_output include/net/neighbour.h:523 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_output include/net/neighbour.h:537 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (ip6_finish_output2+0x378/0x990 net/ipv6/ip6_output.c:141)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:00000010 r6:8581a800 r5:83c4a300
>  r4:0000000e
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:81d75a90 r9:84dff000 r8:000005dc r7:00000000 r6:854e0000 r5:00000000
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:81d75a90 r9:84dff000 r8:84b67000 r7:00000001 r6:00000000 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:511 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:552 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:616 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_queue_xmit+0x3dc/0x5a4 drivers/net/ipvlan/ipvlan_core.c:682)
>  r7:00000000 r6:84dff000 r5:00000000 r4:83c4a300
> [<80cee7ec>] (ipvlan_queue_xmit) from [<80cef51c>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:224)
>  r7:00000000 r6:00000000 r5:0000008c r4:84b67000
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r7:00000000 r6:00000000 r5:84b67000 r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d000 r8:df800be8 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_hh_output include/net/neighbour.h:523 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_output include/net/neighbour.h:537 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (ip6_finish_output2+0x378/0x990 net/ipv6/ip6_output.c:141)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:00000010 r6:8581a800 r5:83c4a300
>  r4:0000000e
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:81d75a90 r9:84dff000 r8:000005dc r7:00000000 r6:854e0000 r5:00000000
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:81d75a90 r9:84dff000 r8:84b67000 r7:00000001 r6:00000000 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:511 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:552 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:616 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_queue_xmit+0x3dc/0x5a4 drivers/net/ipvlan/ipvlan_core.c:682)
>  r7:00000000 r6:84dff000 r5:00000000 r4:83c4a300
> [<80cee7ec>] (ipvlan_queue_xmit) from [<80cef51c>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:224)
>  r7:00000000 r6:00000000 r5:0000008c r4:84b67000
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r7:00000000 r6:00000000 r5:84b67000 r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d000 r8:df800e58 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_hh_output include/net/neighbour.h:523 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_output include/net/neighbour.h:537 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (ip6_finish_output2+0x378/0x990 net/ipv6/ip6_output.c:141)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:00000010 r6:8581a800 r5:83c4a300
>  r4:0000000e
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:81d75a90 r9:84dff000 r8:000005dc r7:00000000 r6:854e0000 r5:00000000
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:81d75a90 r9:84dff000 r8:84b67000 r7:00000001 r6:00000000 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:511 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:552 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:616 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_queue_xmit+0x3dc/0x5a4 drivers/net/ipvlan/ipvlan_core.c:682)
>  r7:00000000 r6:84dff000 r5:00000000 r4:83c4a300
> [<80cee7ec>] (ipvlan_queue_xmit) from [<80cef51c>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:224)
>  r7:00000000 r6:00000000 r5:0000008c r4:84b67000
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r7:00000000 r6:00000000 r5:84b67000 r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d000 r8:df8010c8 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_hh_output include/net/neighbour.h:523 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_output include/net/neighbour.h:537 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (ip6_finish_output2+0x378/0x990 net/ipv6/ip6_output.c:141)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:00000010 r6:8581a800 r5:83c4a300
>  r4:0000000e
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:81d75a90 r9:84dff000 r8:000005dc r7:00000000 r6:854e0000 r5:00000000
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:81d75a90 r9:84dff000 r8:84b67000 r7:00000001 r6:00000000 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:511 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:552 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:616 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_queue_xmit+0x3dc/0x5a4 drivers/net/ipvlan/ipvlan_core.c:682)
>  r7:00000000 r6:84dff000 r5:00000000 r4:83c4a300
> [<80cee7ec>] (ipvlan_queue_xmit) from [<80cef51c>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:224)
>  r7:00000000 r6:00000000 r5:0000008c r4:84b67000
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r7:00000000 r6:00000000 r5:84b67000 r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d000 r8:df801338 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_hh_output include/net/neighbour.h:523 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_output include/net/neighbour.h:537 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (ip6_finish_output2+0x378/0x990 net/ipv6/ip6_output.c:141)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:00000010 r6:8581a800 r5:83c4a300
>  r4:0000000e
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:81d75a90 r9:84dff000 r8:000005dc r7:00000000 r6:854e0000 r5:00000000
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:81d75a90 r9:84dff000 r8:84b67000 r7:00000001 r6:00000000 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:511 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:552 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:616 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_queue_xmit+0x3dc/0x5a4 drivers/net/ipvlan/ipvlan_core.c:682)
>  r7:00000000 r6:84dff000 r5:00000000 r4:83c4a300
> [<80cee7ec>] (ipvlan_queue_xmit) from [<80cef51c>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:224)
>  r7:00000000 r6:00000000 r5:0000008c r4:84b67000
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r7:00000000 r6:00000000 r5:84b67000 r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d000 r8:df8015a8 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_hh_output include/net/neighbour.h:523 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (neigh_output include/net/neighbour.h:537 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81811c28>] (ip6_finish_output2+0x378/0x990 net/ipv6/ip6_output.c:141)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:00000010 r6:8581a800 r5:83c4a300
>  r4:0000000e
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:81d75a90 r9:84dff000 r8:000005dc r7:00000000 r6:854e0000 r5:00000000
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:81d75a90 r9:84dff000 r8:84b67000 r7:00000001 r6:00000000 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:511 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:552 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:616 [inline])
> [<8189d05c>] (ip6_local_out) from [<80ceebc8>] (ipvlan_queue_xmit+0x3dc/0x5a4 drivers/net/ipvlan/ipvlan_core.c:682)
>  r7:00000000 r6:84dff000 r5:00000000 r4:83c4a300
> [<80cee7ec>] (ipvlan_queue_xmit) from [<80cef51c>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:224)
>  r7:00000000 r6:00000000 r5:0000008c r4:84b67000
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80cef504>] (ipvlan_start_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r7:00000000 r6:00000000 r5:84b67000 r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d000 r8:df801818 r7:84b67000 r6:826c2ecc r5:8570fa00
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81579278>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81579278>] (neigh_resolve_output net/core/neighbour.c:1512 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81579278>] (neigh_resolve_output+0x114/0x20c net/core/neighbour.c:1492)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:84b67000 r6:80cef010 r5:8581a800
>  r4:83c4a300
> [<81579164>] (neigh_resolve_output) from [<81811b50>] (neigh_output include/net/neighbour.h:539 [inline])
> [<81579164>] (neigh_resolve_output) from [<81811b50>] (ip6_finish_output2+0x2a0/0x990 net/ipv6/ip6_output.c:141)
>  r8:00000009 r7:855136c2 r6:8581a800 r5:83c4a300 r4:84b67000
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:00000040 r9:84e7d000 r8:000005dc r7:00000000 r6:854e0000 r5:842cd400
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:00000040 r9:84e7d000 r8:84b67000 r7:00000001 r6:842cd400 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8189d09c>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8189d09c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
>  r9:00000070 r8:855136aa r7:0000007e r6:842cd400 r5:854e0000 r4:83c4a300
> [<8189d05c>] (ip6_local_out) from [<818a0960>] (ip6tunnel_xmit include/net/ip6_tunnel.h:161 [inline])
> [<8189d05c>] (ip6_local_out) from [<818a0960>] (udp_tunnel6_xmit_skb+0x1a0/0x384 net/ipv6/ip6_udp_tunnel.c:111)
>  r7:0000007e r6:84e7d000 r5:85513680 r4:83c4a300
> [<818a07c0>] (udp_tunnel6_xmit_skb) from [<80d56ac0>] (geneve6_xmit_skb drivers/net/geneve.c:1013 [inline])
> [<818a07c0>] (udp_tunnel6_xmit_skb) from [<80d56ac0>] (geneve_xmit+0x874/0x10a0 drivers/net/geneve.c:1043)
>  r10:84e7d6c0 r9:0000f9ae r8:00000040 r7:8588d000 r6:84e7d6f8 r5:84e7d000
>  r4:83c4a300
> [<80d5624c>] (geneve_xmit) from [<815658f4>] (__netdev_start_xmit include/linux/netdevice.h:5215 [inline])
> [<80d5624c>] (geneve_xmit) from [<815658f4>] (netdev_start_xmit include/linux/netdevice.h:5224 [inline])
> [<80d5624c>] (geneve_xmit) from [<815658f4>] (xmit_one net/core/dev.c:3830 [inline])
> [<80d5624c>] (geneve_xmit) from [<815658f4>] (dev_hard_start_xmit+0xe4/0x2b0 net/core/dev.c:3846)
>  r10:81d7bdd4 r9:826c2ece r8:84280000 r7:00000000 r6:00000000 r5:84e7d000
>  r4:83c4a300
> [<81565810>] (dev_hard_start_xmit) from [<81565f54>] (__dev_queue_xmit+0x350/0xfa4 net/core/dev.c:4713)
>  r10:00000113 r9:8588d9c0 r8:df801b40 r7:84e7d000 r6:826c2ecc r5:85715000
>  r4:83c4a300
> [<81565c04>] (__dev_queue_xmit) from [<81579278>] (dev_queue_xmit include/linux/netdevice.h:3355 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81579278>] (neigh_resolve_output net/core/neighbour.c:1512 [inline])
> [<81565c04>] (__dev_queue_xmit) from [<81579278>] (neigh_resolve_output+0x114/0x20c net/core/neighbour.c:1492)
>  r10:00000113 r9:ff7e1ea0 r8:00000000 r7:84e7d000 r6:815e2e28 r5:8581a400
>  r4:83c4a300
> [<81579164>] (neigh_resolve_output) from [<81811b50>] (neigh_output include/net/neighbour.h:539 [inline])
> [<81579164>] (neigh_resolve_output) from [<81811b50>] (ip6_finish_output2+0x2a0/0x990 net/ipv6/ip6_output.c:141)
>  r8:00000009 r7:85513708 r6:8581a400 r5:83c4a300 r4:84e7d000
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (__ip6_finish_output net/ipv6/ip6_output.c:215 [inline])
> [<818118b0>] (ip6_finish_output2) from [<818168e4>] (ip6_finish_output+0x238/0x3a8 net/ipv6/ip6_output.c:226)
>  r10:842c8b40 r9:84e7d000 r8:000005dc r7:00000000 r6:854e0000 r5:842c8b40
>  r4:83c4a300
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (NF_HOOK_COND include/linux/netfilter.h:306 [inline])
> [<818166ac>] (ip6_finish_output) from [<81816ad4>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:247)
>  r10:842c8b40 r9:84e7d000 r8:84e7d000 r7:00000001 r6:842c8b40 r5:854e0000
>  r4:83c4a300
> [<81816a54>] (ip6_output) from [<8183df74>] (dst_output include/net/dst.h:459 [inline])
> [<81816a54>] (ip6_output) from [<8183df74>] (NF_HOOK include/linux/netfilter.h:317 [inline])
> [<81816a54>] (ip6_output) from [<8183df74>] (ndisc_send_skb+0x260/0x494 net/ipv6/ndisc.c:513)
>  r9:854e0000 r8:8588d9c0 r7:df801e14 r6:00000001 r5:856e5c00 r4:83c4a300
> [<8183dd14>] (ndisc_send_skb) from [<8183f608>] (ndisc_send_rs+0x68/0x1d4 net/ipv6/ndisc.c:723)
>  r10:81c05258 r9:df801ec8 r8:00000000 r7:81e7d724 r6:df801e14 r5:83c4a300
>  r4:84e7d000
> [<8183f5a0>] (ndisc_send_rs) from [<818224a0>] (addrconf_rs_timer+0xcc/0x2f0 net/ipv6/addrconf.c:4041)
>  r8:00000100 r7:84e7d000 r6:856e5d48 r5:856e5e88 r4:856e5d4c
> [<818223d4>] (addrconf_rs_timer) from [<803287b0>] (call_timer_fn+0x30/0x220 kernel/time/timer.c:1747)
>  r10:81c05258 r9:df801ec8 r8:00000100 r7:000c1000 r6:818223d4 r5:856e5e88
>  r4:84280000
> [<80328780>] (call_timer_fn) from [<80328c64>] (expire_timers kernel/time/timer.c:1798 [inline])
> [<80328780>] (call_timer_fn) from [<80328c64>] (__run_timers+0x2c4/0x3f8 kernel/time/timer.c:2372)
>  r9:df801ec8 r8:000c1000 r7:00000000 r6:818223d4 r5:dddc4f00 r4:856e5e88
> [<803289a0>] (__run_timers) from [<80328e00>] (__run_timer_base kernel/time/timer.c:2384 [inline])
> [<803289a0>] (__run_timers) from [<80328e00>] (__run_timer_base kernel/time/timer.c:2376 [inline])
> [<803289a0>] (__run_timers) from [<80328e00>] (run_timer_base+0x68/0x78 kernel/time/timer.c:2393)
>  r10:84280000 r9:82804d40 r8:00000100 r7:00000001 r6:00000002 r5:00000002
>  r4:dddc4f00
> [<80328d98>] (run_timer_base) from [<80328e2c>] (run_timer_softirq+0x1c/0x34 kernel/time/timer.c:2403)
>  r4:82804084
> [<80328e10>] (run_timer_softirq) from [<8026199c>] (handle_softirqs+0x140/0x458 kernel/softirq.c:579)
> [<8026185c>] (handle_softirqs) from [<80261e10>] (__do_softirq kernel/softirq.c:613 [inline])
> [<8026185c>] (handle_softirqs) from [<80261e10>] (invoke_softirq kernel/softirq.c:453 [inline])
> [<8026185c>] (handle_softirqs) from [<80261e10>] (__irq_exit_rcu+0x110/0x1d0 kernel/softirq.c:680)
>  r10:00000008 r9:0000003e r8:00000000 r7:ec5d9fb0 r6:82409ea4 r5:824471a0
>  r4:84280000
> [<80261d00>] (__irq_exit_rcu) from [<80262188>] (irq_exit+0x10/0x18 kernel/softirq.c:708)
>  r5:824471a0 r4:826c195c
> [<80262178>] (irq_exit) from [<81a2c110>] (generic_handle_arch_irq+0x7c/0x80 kernel/irq/handle.c:240)
> [<81a2c094>] (generic_handle_arch_irq) from [<819fb9f4>] (call_with_stack+0x1c/0x20 arch/arm/lib/call_with_stack.S:40)
>  r9:0000003e r8:826b7044 r7:84280000 r6:ffffffff r5:60000010 r4:00027e50
> [<819fb9d8>] (call_with_stack) from [<80200f48>] (__irq_usr+0x88/0xa0 arch/arm/kernel/entry-armv.S:443)
> Exception stack(0xec5d9fb0 to 0xec5d9ff8)
> 9fa0:                                     00000000 7eb7ba7c 00000000 00000000
> 9fc0: ffffffff 00000000 00008ca0 00002328 cccccccd 0000003e 00000008 00000843
> 9fe0: 00000158 7eb7ba40 00000000 00027e50 60000010 ffffffff
> Code: ebfed2aa eaffffdf eb5e20cd e1a0c00d (e92dd830) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	ebfed2aa 	bl	0xfffb4ab0
>    4:	eaffffdf 	b	0xffffff88
>    8:	eb5e20cd 	bl	0x1788344
>    c:	e1a0c00d 	mov	ip, sp
> * 10:	e92dd830 	push	{r4, r5, fp, ip, lr, pc} <-- trapping instruction
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

