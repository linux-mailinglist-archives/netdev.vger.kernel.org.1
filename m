Return-Path: <netdev+bounces-243011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F89C9840F
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 17:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A043A1C0A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42873331211;
	Mon,  1 Dec 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WfYY0af6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222913959D
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606758; cv=none; b=t3zg1B2u8FfDbv7ydPSQatIGLeeOncwT+gHKvlaNrmIjZqBPA2OXBJFNcB+36LgBEiSprSvgL4Nx4rI8zNQWEpQa8HsNku0ToGaxz4k/I0RhOUB/8MQSxPeTht28SY2lNRY5X6M7Bnf8epBjQYsh5g5gRXwRH8GuCRHu1AJVLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606758; c=relaxed/simple;
	bh=a9mFx9bciWWt4mGYo4A/uV3VTz1rKfm4a0G/86d4dfk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ReOnXudOyj0ZgVpvO47/QKQj/0h8nyKkWc4H9+Yp+IJf5O6DIis9QkomDo55ML/X91vIZlxcaDpMoSyg17D5MruQIjuha+0OKsP7ur6Kkbbs7z7Y8d0EjIj1i62wqg+H35OJ1x88ZOsJc/ZSHb/snWxOlZlcimhYQG5BE5O9EJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WfYY0af6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso49374055e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764606754; x=1765211554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=np9sPAP1vbi6M9Sj8Z4L220V4fGnXykh9GTyl5g58Eo=;
        b=WfYY0af6bpi5EydAISTzNwZa9s6H9s3SQ6iiuDSDeO8TN5Jgfd0NBitSNMfInlhISw
         AJHQCpzH2dLd1sjI9z8Co5SYC6I87kMYHb7+KsWQELKZz8gIMo4MtIQXK6oX2SHp1EcP
         /Wt6jk4GVV5pzCt+VG/x00S1CGY3YSa6v+9qzUtU/3hA9n/sCrAPD01J76+JXsXLFXZB
         7VtI4hCjV01b2flliiAoFG1zotpYZZlX+vmO9Bdr1fKgUoLvUZqSTWV+W+HF3cRiNWFz
         ZxWZZC8QAWp9oedf+qTMSVeTvJxlfU+XNBB6R7DjjlDPiKagK4gy+SH0jIV0o3BZ8nnu
         DPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764606754; x=1765211554;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=np9sPAP1vbi6M9Sj8Z4L220V4fGnXykh9GTyl5g58Eo=;
        b=iWDOS2KBT29Nn/3Qs27jWzFknvTYvG17+F4UTPXqeVP/iCPIrKUkquB+Gpu9cK7Yvj
         HiiAETNkqc/TfpubRV+dzGnjaWX7cVvNvZeKfol/sqNLintoI4lYAYDhsiut2BjZsYmx
         88OXEWg/O6VFWDHrWQnw02O5w4CawFNak2/nMShtCx1L7TZI2+GquXQfof+GHAZ4N1+k
         EDsYNTlJguEPtDMWkwSiyCY6+vLjHuGjXKKRcIaveMx81UQkAgjgzkxOC/FtR1Oa7E/u
         a+fwi/oMthp88bCWQYkuNxdC/r/+PVYVN8p1uI9jCgiHDXg4HPrcnsJMvBmysBY9ORTw
         OAVg==
X-Gm-Message-State: AOJu0YyI9CuuhFChULp53sctCADVUdUWmFB7oAtc9x377FyPn7Wqdn2w
	31Ow4QTiX4rOSfmE/cAiuyZTdGapR9vgmuAugI2KhDhx+CvlUJnHO1bweb6Xmm6M7YMfRmZcXFX
	NQ7lR
X-Gm-Gg: ASbGncsPf68q8ReH3Fk+SNGve2DQBDDHmENpB+1vzhWZgbGo0YyI8dxP2WjBVqnJg37
	XG4HdxrVGu9rZAbHrr4hlngGVGnyt1wECfYwk8Wm89jato8I4ZpeoAjxq50ZOd8q3WtGucmijH+
	hJ3Cu+DAU0SwytoD6zR88z6GZoDQ7UruPtbxjdjlbnOKgpbBEG0muoy7JXsDdIlYPuLEVqqSf82
	49KQn9jKDbMFeriYp1cNnGLNrwEDLh/DE6PrI1eN6jgIAL2beJJsbZfOKmLq8tcQtcmFsc8bcAL
	Kinu2dnYC7hsWdxzePAHm9f4iU2r+aWHYaHg/DTmcj38N3tpsgoLmAlS6UEN0C0RWNzb2LEs5tR
	4tE06r8RGqBX+WGDzzl6cM0wHfTpw4ZFldpU6hAoh9yZK5RT5Zsiz2/0vhff1Be/h2YxPMMSUIB
	sxecuzuDPoZol0kdvj4DtdmZHunnskUqLl8YZmlDzNiOMWP761yBOE
X-Google-Smtp-Source: AGHT+IFCKFo8S/ilqlPMQtExLAOh92SlFULuQ/k2FwkuIQTV2pRuH8SbaT+DbssrOYzQhGXbq4bgZQ==
X-Received: by 2002:a05:600c:a01:b0:477:7b72:bf9a with SMTP id 5b1f17b1804b1-477c112f5c2mr375494925e9.28.1764606753542;
        Mon, 01 Dec 2025 08:32:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c3a28sm325717315e9.9.2025.12.01.08.32.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:32:33 -0800 (PST)
Date: Mon, 1 Dec 2025 08:32:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 220820] New: net: tcp: avoid division by zero in
 __tcp_select_window
Message-ID: <20251201083228.70b70181@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Mon, 01 Dec 2025 10:26:14 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220820] New: net: tcp: avoid division by zero in __tcp_select_window


https://bugzilla.kernel.org/show_bug.cgi?id=220820

            Bug ID: 220820
           Summary: net: tcp: avoid division by zero in
                    __tcp_select_window
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: kitta@linux.alibaba.com
        Regression: No

In the following kernel version:

name:linux
url:http://github.com/gregkh/linux.git
branch: master
commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d

bug report:
------------[ cut here ]------------
UBSAN: division-overflow in net/ipv4/tcp_output.c:3333:13
division by zero
CPU: 0 UID: 0 PID: 4151 Comm: syz.0.268 Not tainted 6.18.0-rc7 #1 PREEMPT(none) 
Hardware name: Red Hat KVM, BIOS 1.16.0-4.al8 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x168/0x1f0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:233 [inline]
 __ubsan_handle_divrem_overflow lib/ubsan.c:351 [inline]
 __ubsan_handle_divrem_overflow+0x1ae/0x2a0 lib/ubsan.c:333
 __tcp_select_window.cold+0x16/0x35 net/ipv4/tcp_output.c:3333
 tcp_select_window net/ipv4/tcp_output.c:280 [inline]
 __tcp_transmit_skb+0xca3/0x38b0 net/ipv4/tcp_output.c:1565
 tcp_transmit_skb net/ipv4/tcp_output.c:1646 [inline]
 tcp_send_active_reset+0x422/0x7e0 net/ipv4/tcp_output.c:3828
 mptcp_do_fastclose.part.0+0x158/0x1e0 net/mptcp/protocol.c:2792
 mptcp_do_fastclose net/mptcp/protocol.c:2779 [inline]
 mptcp_disconnect+0x2c6/0x9b0 net/mptcp/protocol.c:3252
 inet_shutdown+0x270/0x440 net/ipv4/af_inet.c:937
 __sys_shutdown_sock net/socket.c:2470 [inline]
 __sys_shutdown_sock net/socket.c:2464 [inline]
 __sys_shutdown+0x117/0x1b0 net/socket.c:2486
 __do_sys_shutdown net/socket.c:2491 [inline]
 __se_sys_shutdown net/socket.c:2489 [inline]
 __x64_sys_shutdown+0x54/0x80 net/socket.c:2489
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x6e/0x940 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7ff5e46fb4dd
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48
89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01
c3 48 8b 0d 6b 89 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ff5e31f0cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 00000000005c5fa0 RCX: 00007ff5e46fb4dd
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000005c5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000005c6038 R14: 0000000000000000 R15: 00007ff5e31f1640
 </TASK>
---[ end trace ]---
Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 4151 Comm: syz.0.268 Not tainted 6.18.0-rc7 #1 PREEMPT(none) 
Hardware name: Red Hat KVM, BIOS 1.16.0-4.al8 04/01/2014
RIP: 0010:__tcp_select_window+0x58a/0x1240 net/ipv4/tcp_output.c:3333
Code: e3 0f 8c 8a 02 00 00 e8 34 dc a3 fd 8b 5c 24 0c 31 ff 89 de e8 c7 d5 a3
fd 85 db 0f 84 6c 9d 36 fd e8 1a dc a3 fd 44 89 f0 99 <f7> 7c 24 0c 41 29 d6 45
89 f4 e9 2a ff ff ff e8 02 dc a3 fd 48 89
RSP: 0018:ffff88800b5f7ae0 EFLAGS: 00010283
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90000d11000
RDX: 0000000000000000 RSI: ffffffff83f30a16 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888028a9f400 R14: 0000000000000000 R15: 0000000000000000
FS:  00007ff5e31f1640(0000) GS:ffff8880e70ab000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f711faa0 CR3: 000000001de2e003 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 80000000
Call Trace:
 <TASK>
 tcp_select_window net/ipv4/tcp_output.c:280 [inline]
 __tcp_transmit_skb+0xca3/0x38b0 net/ipv4/tcp_output.c:1565
 tcp_transmit_skb net/ipv4/tcp_output.c:1646 [inline]
 tcp_send_active_reset+0x422/0x7e0 net/ipv4/tcp_output.c:3828
 mptcp_do_fastclose.part.0+0x158/0x1e0 net/mptcp/protocol.c:2792
 mptcp_do_fastclose net/mptcp/protocol.c:2779 [inline]
 mptcp_disconnect+0x2c6/0x9b0 net/mptcp/protocol.c:3252
 inet_shutdown+0x270/0x440 net/ipv4/af_inet.c:937
 __sys_shutdown_sock net/socket.c:2470 [inline]
 __sys_shutdown_sock net/socket.c:2464 [inline]
 __sys_shutdown+0x117/0x1b0 net/socket.c:2486
 __do_sys_shutdown net/socket.c:2491 [inline]
 __se_sys_shutdown net/socket.c:2489 [inline]
 __x64_sys_shutdown+0x54/0x80 net/socket.c:2489
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x6e/0x940 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7ff5e46fb4dd
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48
89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01
c3 48 8b 0d 6b 89 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ff5e31f0cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 00000000005c5fa0 RCX: 00007ff5e46fb4dd
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000005c5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000005c6038 R14: 0000000000000000 R15: 00007ff5e31f1640
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tcp_select_window+0x58a/0x1240 net/ipv4/tcp_output.c:3333
Code: e3 0f 8c 8a 02 00 00 e8 34 dc a3 fd 8b 5c 24 0c 31 ff 89 de e8 c7 d5 a3
fd 85 db 0f 84 6c 9d 36 fd e8 1a dc a3 fd 44 89 f0 99 <f7> 7c 24 0c 41 29 d6 45
89 f4 e9 2a ff ff ff e8 02 dc a3 fd 48 89
RSP: 0018:ffff88800b5f7ae0 EFLAGS: 00010283
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90000d11000
RDX: 0000000000000000 RSI: ffffffff83f30a16 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888028a9f400 R14: 0000000000000000 R15: 0000000000000000
FS:  00007ff5e31f1640(0000) GS:ffff8880e70ab000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f711faa0 CR3: 000000001de2e003 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 80000000
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:   0f 8c 8a 02 00 00       jl     0x290
   6:   e8 34 dc a3 fd          callq  0xfda3dc3f
   b:   8b 5c 24 0c             mov    0xc(%rsp),%ebx
   f:   31 ff                   xor    %edi,%edi
  11:   89 de                   mov    %ebx,%esi
  13:   e8 c7 d5 a3 fd          callq  0xfda3d5df
  18:   85 db                   test   %ebx,%ebx
  1a:   0f 84 6c 9d 36 fd       je     0xfd369d8c
  20:   e8 1a dc a3 fd          callq  0xfda3dc3f
  25:   44 89 f0                mov    %r14d,%eax
  28:   99                      cltd
* 29:   f7 7c 24 0c             idivl  0xc(%rsp) <-- trapping instruction
  2d:   41 29 d6                sub    %edx,%r14d
  30:   45 89 f4                mov    %r14d,%r12d
  33:   e9 2a ff ff ff          jmpq   0xffffff62
  38:   e8 02 dc a3 fd          callq  0xfda3dc3f
  3d:   48                      rex.W
  3e:   89                      .byte 0x89

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

division by zero
CPU: 0 UID: 0 PID: 4151 Comm: syz.0.268 Not tainted 6.18.0-rc7 #1 PREEMPT(none) 
Hardware name: Red Hat KVM, BIOS 1.16.0-4.al8 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x168/0x1f0
 __ubsan_handle_divrem_overflow+0x1ae/0x2a0
 __tcp_select_window.cold+0x16/0x35
 __tcp_transmit_skb+0xca3/0x38b0
 tcp_send_active_reset+0x422/0x7e0
 mptcp_do_fastclose.part.0+0x158/0x1e0
 mptcp_disconnect+0x2c6/0x9b0
 inet_shutdown+0x270/0x440
 __sys_shutdown+0x117/0x1b0
 __x64_sys_shutdown+0x54/0x80
 do_syscall_64+0x6e/0x940
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7ff5e46fb4dd
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48
89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01
c3 48 8b 0d 6b 89 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ff5e31f0cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 00000000005c5fa0 RCX: 00007ff5e46fb4dd
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000005c5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000005c6038 R14: 0000000000000000 R15: 00007ff5e31f1640
 </TASK>
---[ end trace ]---
Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 4151 Comm: syz.0.268 Not tainted 6.18.0-rc7 #1 PREEMPT(none) 
Hardware name: Red Hat KVM, BIOS 1.16.0-4.al8 04/01/2014
RIP: 0010:__tcp_select_window+0x58a/0x1240
Code: e3 0f 8c 8a 02 00 00 e8 34 dc a3 fd 8b 5c 24 0c 31 ff 89 de e8 c7 d5 a3
fd 85 db 0f 84 6c 9d 36 fd e8 1a dc a3 fd 44 89 f0 99 <f7> 7c 24 0c 41 29 d6 45
89 f4 e9 2a ff ff ff e8 02 dc a3 fd 48 89
RSP: 0018:ffff88800b5f7ae0 EFLAGS: 00010283
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90000d11000
RDX: 0000000000000000 RSI: ffffffff83f30a16 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888028a9f400 R14: 0000000000000000 R15: 0000000000000000
FS:  00007ff5e31f1640(0000) GS:ffff8880e70ab000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f711faa0 CR3: 000000001de2e003 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 80000000
Call Trace:
 <TASK>
 __tcp_transmit_skb+0xca3/0x38b0
 tcp_send_active_reset+0x422/0x7e0
 mptcp_do_fastclose.part.0+0x158/0x1e0
 mptcp_disconnect+0x2c6/0x9b0
 inet_shutdown+0x270/0x440
 __sys_shutdown+0x117/0x1b0
 __x64_sys_shutdown+0x54/0x80
 do_syscall_64+0x6e/0x940
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7ff5e46fb4dd
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48
89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01
c3 48 8b 0d 6b 89 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ff5e31f0cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 00000000005c5fa0 RCX: 00007ff5e46fb4dd
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000005c5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000005c6038 R14: 0000000000000000 R15: 00007ff5e31f1640
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tcp_select_window+0x58a/0x1240
Code: e3 0f 8c 8a 02 00 00 e8 34 dc a3 fd 8b 5c 24 0c 31 ff 89 de e8 c7 d5 a3
fd 85 db 0f 84 6c 9d 36 fd e8 1a dc a3 fd 44 89 f0 99 <f7> 7c 24 0c 41 29 d6 45
89 f4 e9 2a ff ff ff e8 02 dc a3 fd 48 89
RSP: 0018:ffff88800b5f7ae0 EFLAGS: 00010283
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90000d11000
RDX: 0000000000000000 RSI: ffffffff83f30a16 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888028a9f400 R14: 0000000000000000 R15: 0000000000000000
FS:  00007ff5e31f1640(0000) GS:ffff8880e70ab000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f711faa0 CR3: 000000001de2e003 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 80000000

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

