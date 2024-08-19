Return-Path: <netdev+bounces-119566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07AC956422
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971912813BA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4476156230;
	Mon, 19 Aug 2024 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ+U4lro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591538DD2;
	Mon, 19 Aug 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051464; cv=none; b=TT94BuBC69QJd8rEZASpTj80LSg9128p3B5KntOWcFcOtKm+Bt8CXpkFfa8fX5z3lrygEQ0O//YslIJU9ApMJPquBAntIW1sBKQ3Nakxv+XbIYHjZ7ahB59nHLmXT8TENZgHbDXhv2qcXvkzUy0V7sdV/SF1STXECsyJumHGDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051464; c=relaxed/simple;
	bh=f3GLkV0VDHW5sRCTOGkvjvBlzCcp8One8L7kzSEWBmQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sdYZIKML3UsqRuBxenXx8zwXGMEEtMsfed71PRMCHGub2ie1zBCtPOe7hvyNegVNtmasar7EDCFzvbtur+27F5DtGMny8Dkwo5FtoPuU+9uImKqQZJcEDV3Wmv1HOx01UYwNa0sRhayI9Mau/D7nMGLAg2OIgVHYQe7FRD2wdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ+U4lro; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-842f04589f3so1034416241.2;
        Mon, 19 Aug 2024 00:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724051462; x=1724656262; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PT2iDuWldiFob1UDCRdi17Dp+7KUjW3NHqSPmCv2URk=;
        b=mQ+U4lrouZY/+QYxmhAqw6jNaiMZv6NI9g/1ot21r+tpeii/0PBfRXEukTCafgyEhS
         +NVvAUF9UjuGBh3S7/VOKvBy+P+GRqe0ee9WPJZ4WnD9pPOuL+024oFAztOr4hDPrAkR
         kWt+NC8UuirEkKvXGShhVMGLc6HuQzrnX+SzXq2y1GY1cqpNFBuhYx/J5OuekZNApPnL
         I6PIhT9GCw21yWNaNel7MWCEI2KELXX0VJNLfSpcAh+riCcQGaaLFWHf8YBjKtnhuQjI
         IBPD7RvGilScu17ySEkd3ML2rA9yQW6CoFgiyDLblfhDFKCrzAwXs4kihImNAq9p+A2H
         GdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724051462; x=1724656262;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT2iDuWldiFob1UDCRdi17Dp+7KUjW3NHqSPmCv2URk=;
        b=cpzRMkWjAiLqV5l+WOzXdSLs0JqnVU1cPmJiQfN7MVCb+1JM6P1HQqfhLeEbjbWM30
         6RR+JfFyTZYhb8ScdlaDqJ+j3j0skYvrCtoYbhUfcswu/qEZmIhu/JgdQKpt5e88Ql3x
         /YvA42aKzqfx4pXAp3COFxg8LY4VLIiMs3/IITmHv67o/8IRbesFc3SO4pFVZzz9cR7A
         CdX+DfRuKW9tAYfd+e7yy8N7+YzrgkcKmJmaibGCVYRUT5qndlmIIcPsM1PTfTHKk7Et
         LGzVjeLwwzfXRE4TXhlB26IHwuSfSD8uMlTJSZdEC6QRhhPRL4Twzx/D14r8XuZNUuS/
         R1Og==
X-Forwarded-Encrypted: i=1; AJvYcCVfbBpQl/k4kb0C/jD7oqPS6mEwZWOzLJ/Qm3u+iItBMOtMA1XZMPCTHmiHJj+RL6PyEjS8YVhaoNFyIyFvnhSaHaHoRQTtTwPSNQ3oDQGxvwBgg2Ioe+XZRQpDKsSNYU/doIwF
X-Gm-Message-State: AOJu0YyVNhokGOLVE9s4edrbugo9QBCRiAovcH0saTyOqKDtiU2RvVgk
	Zehdb9k44LeJ2MegIIjGFWwI6hbPqRWG+DkKr0ZAgwh/ByGfLJZElukWiJ7bW1RHgEbWqMUQeDb
	Bg12DeFeOmeuHlFrllYioplMrEa4=
X-Google-Smtp-Source: AGHT+IGV+TUsAL8Mt5tVz39mJVGivprdA/vpM5wpr4+qqCGj5ZSync5ELFtB0+HuR7/L6LaMTR8lLQCYqro5bQqSlq4=
X-Received: by 2002:a05:6102:32d2:b0:48f:e954:2426 with SMTP id
 ada2fe7eead31-49779904db7mr7637579137.2.1724051461724; Mon, 19 Aug 2024
 00:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6rmA66+87ISx?= <ii4gsp@gmail.com>
Date: Mon, 19 Aug 2024 16:10:50 +0900
Message-ID: <CAKrymDQ48QK5Wu5n1NJK8TouqA0cmg1ZkiALCM+W8KHFxraWgg@mail.gmail.com>
Subject: general protection fault in qdisc_reset
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, kuba@kernel.org, 
	jiri@resnulli.us, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I have been fuzzing Linux 6.10.0-rc3 with Syzkaller and found.

kernel config: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf284390e34fa9b17542c9/config_v6.10.0_rc3
C repro: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf284390e34fa9b17542c9/repro.cprog
repro syscall steps:
https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf284390e34fa9b17542c9/repro.prog

==========================================
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000026: 0000 [#1] PREEMPT SMP KASAN NOPTI
audit: type=1400 audit(1723346247.508:9): avc:  denied  { kernel } for
 pid=227 comm="syz-executor166" scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:system_r:kernel_t:s0 tclass=perf_event permissive=1
KASAN: null-ptr-deref in range [0x0000000000000130-0x0000000000000137]
CPU: 0 PID: 227 Comm: syz-executor166 Not tainted
6.10.0-rc3-00021-g2ef5971ff345 #1
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:strlen+0x1e/0xa0 lib/string.c:402
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00
00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 <0f> b6
04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 80 7d 00 00
RSP: 0018:ffff888008b5f708 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: ffffffffabcde7c0 RCX: ffffffffa9d3584d
RDX: 0000000000000026 RSI: ffffffffabcde7c0 RDI: 0000000000000130
RBP: 0000000000000130 R08: 0000000000000000 R09: fffffbfff57c50aa
R10: ffffffffabe28557 R11: 0000000000000000 R12: ffffffffabcde980
R13: dffffc0000000000 R14: ffff888001e32428 R15: 0000000000000130
FS:  00005555772cf380(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555772cfca8 CR3: 000000000da8e006 CR4: 0000000000370ef0
Call Trace:
 <TASK>
 trace_event_get_offsets_qdisc_reset include/trace/events/qdisc.h:77 [inline]
 perf_trace_qdisc_reset+0xf5/0x6a0 include/trace/events/qdisc.h:77
 trace_qdisc_reset include/trace/events/qdisc.h:77 [inline]
 qdisc_reset+0x3e1/0x550 net/sched/sch_generic.c:1029
 dev_reset_queue+0x80/0x120 net/sched/sch_generic.c:1306
 dev_deactivate_many+0x41f/0x830 net/sched/sch_generic.c:1375
 __dev_close_many+0x129/0x2e0 net/core/dev.c:1543
 __dev_close net/core/dev.c:1568 [inline]
 __dev_change_flags+0x3dc/0x5a0 net/core/dev.c:8779
 dev_change_flags+0x8e/0x160 net/core/dev.c:8853
 devinet_ioctl+0xcbf/0x1a30 net/ipv4/devinet.c:1177
 inet_ioctl+0x350/0x3b0 net/ipv4/af_inet.c:1003
 packet_ioctl+0xa8/0x230 net/packet/af_packet.c:4256
 sock_do_ioctl+0x119/0x2a0 net/socket.c:1222
 sock_ioctl+0x3eb/0x630 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x162/0x1e0 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b72ae3c0d
Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6b571178 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b72ae3c0d
RDX: 0000000020000200 RSI: 0000000000008914 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8b72b7bcc8 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x1e/0xa0 lib/string.c:402
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00
00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 <0f> b6
04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 80 7d 00 00
RSP: 0018:ffff888008b5f708 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: ffffffffabcde7c0 RCX: ffffffffa9d3584d
RDX: 0000000000000026 RSI: ffffffffabcde7c0 RDI: 0000000000000130
RBP: 0000000000000130 R08: 0000000000000000 R09: fffffbfff57c50aa
R10: ffffffffabe28557 R11: 0000000000000000 R12: ffffffffabcde980
R13: dffffc0000000000 R14: ffff888001e32428 R15: 0000000000000130
FS:  00005555772cf380(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555772cfca8 CR3: 000000000da8e006 CR4: 0000000000370ef0
----------------
Code disassembly (best guess):
   0: 90                   nop
   1: 90                   nop
   2: 90                   nop
   3: 90                   nop
   4: 90                   nop
   5: 90                   nop
   6: 90                   nop
   7: 90                   nop
   8: 90                   nop
   9: 90                   nop
   a: 90                   nop
   b: 90                   nop
   c: f3 0f 1e fa           endbr64
  10: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  17: fc ff df
  1a: 55                   push   %rbp
  1b: 48 89 fa             mov    %rdi,%rdx
  1e: 48 89 fd             mov    %rdi,%rbp
  21: 53                   push   %rbx
  22: 48 c1 ea 03           shr    $0x3,%rdx
  26: 48 83 ec 08           sub    $0x8,%rsp
* 2a: 0f b6 04 02           movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e: 48 89 fa             mov    %rdi,%rdx
  31: 83 e2 07             and    $0x7,%edx
  34: 38 d0                 cmp    %dl,%al
  36: 7f 04                 jg     0x3c
  38: 84 c0                 test   %al,%al
  3a: 75 50                 jne    0x8c
  3c: 80 7d 00 00           cmpb   $0x0,0x0(%rbp)
==========================================

Thanks,

ii4gsp

