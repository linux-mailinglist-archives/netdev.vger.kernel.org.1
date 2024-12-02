Return-Path: <netdev+bounces-147981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D69DF9E8
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 05:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619BC162A6C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CA91D4326;
	Mon,  2 Dec 2024 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3J/xRL7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB628399;
	Mon,  2 Dec 2024 04:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113875; cv=none; b=FAaByeo0IOAYiF4Sw2Wp8Hy/r/PLcbi6Td8diaxpasJKJW2nkqrYU4TRty2RtGNXwFDhzc5AYjcPGDu4v1O0Ls32CYwG7P5im2rRake/LYVX+TkGBFpW/NxTTRmrmz3qbgMoDluT9+H7Ai/TCvWfESB8+jNyO/Xkm7Dc0xTf67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113875; c=relaxed/simple;
	bh=bIPhbO1/ynSDYWsNMsx3iDkg2fRe4cZ4TgHzFUgTKBQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZENnK0iNjVAsUTdMPyGAEjFHiosytrHWXQkQsd2MEnLui6V1N7COpQIC3NjPUmXCLhsknUsdDQZOyPkePw5MH3hXRVjdrbUop5OHlwBKUixua+Xkoyn06Ax6nQNeVx1jgwE/P3NLEU7KtIPvfo0WjEYAPIufwSB5u9677xwKBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3J/xRL7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5325af6a0so536578266b.2;
        Sun, 01 Dec 2024 20:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733113872; x=1733718672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIPhbO1/ynSDYWsNMsx3iDkg2fRe4cZ4TgHzFUgTKBQ=;
        b=B3J/xRL78cejbX1w6GQnGeGTIbrBKEBsPXcYGqLZw/6dC/L5Yvn4XwTxw2nPwoewoZ
         U8YFMs53kzlG+nXibLgN8VlGm5JKsTdk2ljOEgQxQmy0cgqvJHNa3Nl3CEjUbvRgG0xd
         rXosQLGswJewXyuP8YwjpdrkxGUUtAX6wEauvx2T7LaG6e3tKnAiClVFI1v4qjZaPTbb
         +o0RxfHoEeeZSRDSnNThILU6irO2e/jox9ffAMfVyj0YnqwwSi/HVmLaZ3+AfuifRuYJ
         IpURZdwWVDyQl40pNczffDsTJoAZcVD/XvgWfJL38DLo8xV31A/SFC3+khHMZVfho9po
         SNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113872; x=1733718672;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIPhbO1/ynSDYWsNMsx3iDkg2fRe4cZ4TgHzFUgTKBQ=;
        b=XmiFl6EA0JQfMiNnbpxkKU4YJXO87VvWorxE5XKERuYX/oYXVN5FTRtpS6pYiI+XSC
         +aKZ/tj87OlzYt9IWdnDWKfrmMcq6xKYTzKfOGK1Rm8iwMpNh3fTiftK4EmryGGqxj8G
         3V12dC4jdBKEwA86cJAzxw4ceCndRWGBwAuJJ1jYV0puFRD9YebH3vCtt+naQBJ7ZErY
         FLE+LURaiG+aBbJ9A+MWdsVvnGMI3wx/Mdp6w+6PnaeroWzYJ1slXJ9czRK/MF35nAC1
         2HpvKn3MIctMAsC45hjGMrGuNXbdEr/LLBT9ntsVXlgljpa+WBeoj0/6TeRh1VuNYyIn
         hPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/w4zilBWLZKaRhI0COxne7CWRpelR814y/mJaasGvfKMQCU//ItHzjJeXKmNAL53t+PZFOSgTA7YXx+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlEgr7thVDaPu4P0VTSZz6vhtrmFxtDBjv5fK2Czqp8gDxqooo
	N4DEfXtV74f/fiL7LPToS/CMdBQfMVZO0sm95QHSnMkV9fzp9xAmLJT/qf0fmc9JT0b7TTcL5GT
	mh0FbCTWsi61jeIuvAJkS1bPthasSP9EN
X-Gm-Gg: ASbGncsUJfri7GMrKB5l1s+/pDcNIheZ6CGnZDaA9+0bGOv/vuA5rRkOXSYkHFtzP1L
	h1Xae3nV2d62bk1uv8SO/B3rbQY/de4eH
X-Google-Smtp-Source: AGHT+IFmm8WyTfCyaLHVAoBscQqV6UIlCV3PK6u6u+GbZQROQ0E+zkqh6Uii+esD2CasIfgCHvLbBgDnaX+bjB8PYtg=
X-Received: by 2002:a17:907:784d:b0:a9a:dc3:c86e with SMTP id
 a640c23a62f3a-aa580edf9femr1691690766b.11.1733113871839; Sun, 01 Dec 2024
 20:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 12:31:00 +0800
Message-ID: <CAKHoSAtJSK6tYjZ8djK27LVuPvAVC=r+Hziv2oxA7vAYZw+30w@mail.gmail.com>
Subject: "Bug in qdisc_create" in Linux kernel version 2.6.26
To: hadi@cyberus.ca, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 2.6.26.
This issue was discovered using our custom vulnerability discovery
tool.

Affected File:

File: net/sched/sch_dsmark.c
Function: qdisc_create

Detailed call trace:

[ 2020.553610] Pid: 23156, comm: a.out Tainted: G D 2.6.26-1-amd64 #1
[ 2020.553610] RIP: 0010:[<ffffffffa030b3a0>] [<ffffffffa030b3a0>]
:sch_dsmark:dsmark_init+0x45/0x123
[ 2020.553610] RSP: 0018:ffff8101711a39a8 EFLAGS: 00000246
[ 2020.553610] RAX: 0000000000000000 RBX: ffff810238109a00 RCX: 0000000000000008
[ 2020.553610] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff810238109634
[ 2020.553610] RBP: 0000000000010000 R08: ffffffffa030b8c0 R09: ffff810238109624
[ 2020.553610] R10: ffff81000109f8f0 R11: 0000000000200200 R12: 0000000080020000
[ 2020.553610] R13: ffff810238109a00 R14: ffff810238109600 R15: ffffffffa030c300
[ 2020.553610] FS: 00007f375936f6e0(0000) GS:ffff81023beefc40(0000)
knlGS:0000000000000000
[ 2020.553610] CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 2020.553610] CR2: 0000000000000004 CR3: 0000000156c8f000 CR4: 00000000000006e0
[ 2020.553610] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2020.553610] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 2020.553610] Process a.out (pid: 23156, threadinfo ffff8101711a2000,
task ffff81022d116fa0)
[ 2020.553610] Stack: 0000000000000000 0000000000000000
ffff810238109634 0000000000000000
[ 2020.553610] 0000000000000000 0000000000000000 ffff810238109a00
0000000000010000
[ 2020.553610] 0000000080020000 ffff81023b1db000 ffff810238109600
ffffffff803ccf98
[ 2020.553610] Call Trace:
[ 2020.553610] [<ffffffff803ccf98>] ? qdisc_create+0x166/0x21e
[ 2020.553610] [<ffffffff803cdb33>] ? tc_modify_qdisc+0x286/0x393
[ 2020.553690] [<ffffffff803c3bf3>] ? rtnetlink_rcv_msg+0x0/0x1dd
[ 2020.553690] [<ffffffff803d1cc8>] ? netlink_rcv_skb+0x34/0x7c
[ 2020.553690] [<ffffffff803c3bed>] ? rtnetlink_rcv+0x18/0x1e
[ 2020.553690] [<ffffffff803d1ab3>] ? netlink_unicast+0x1e9/0x261
[ 2020.553690] [<ffffffff803b5f34>] ? __alloc_skb+0x7f/0x12d
[ 2020.553690] [<ffffffff803d2280>] ? netlink_sendmsg+0x274/0x287
[ 2020.553690] [<ffffffffa0113e46>] ?
:ext3:__ext3_journal_dirty_metadata+0x1e/0x46
[ 2020.553690] [<ffffffff803afea1>] ? sock_sendmsg+0xe2/0xff
[ 2020.553690] [<ffffffff802461a9>] ? autoremove_wake_function+0x0/0x2e
[ 2020.553690] [<ffffffff8027ca79>] ? zone_statistics+0x3a/0x8e
[ 2020.553690] [<ffffffff80276423>] ? get_page_from_freelist+0x45a/0x603
[ 2020.553690] [<ffffffff8027117a>] ? find_lock_page+0x1f/0x8a
[ 2020.553690] [<ffffffff8027e7c7>] ? __do_fault+0x39b/0x3e6
[ 2020.553690] [<ffffffff803b00d5>] ? sys_sendmsg+0x217/0x28a
[ 2020.553690] [<ffffffff803b1f69>] ? lock_sock_nested+0x9b/0xa6
[ 2020.553690] [<ffffffff802817df>] ? handle_mm_fault+0x3f4/0x867
[ 2020.553690] [<ffffffff80429e2d>] ? _spin_lock_bh+0x9/0x1f
[ 2020.553690] [<ffffffff803b1e4b>] ? release_sock+0x13/0x96
[ 2020.553690] [<ffffffff803b0aea>] ? move_addr_to_user+0x5d/0x78
[ 2020.553690] [<ffffffff803b0f9c>] ? sys_getsockname+0x7a/0xaa
[ 2020.553690] [<ffffffff8020beca>] ? system_call_after_swapgs+0x8a/0x8f
[ 2020.553690]
[ 2020.553690]
[ 2020.553690] Code: 0e 48 8d 56 04 48 89 e7 49 c7 c0 c0 b8 30 a0 be
05 00 00 00 83 e9 04 e8 dc 7f 0c e0 85 c0 89 c2 0f 88 d4 00 00 00 48
8b 44 24 08 <66> 8b 68 04 0f b7 fd e8 f8 7b 01 e0 ff c8 0f 85 b6 00 00
00 48
[ 2020.553690] RIP [<ffffffffa030b3a0>] :sch_dsmark:dsmark_init+0x45/0x123
[ 2020.553691] RSP <ffff8101711a39a8>
[ 2020.553691] CR2: 0000000000000004
[ 2020.558108] ---[ end trace 9deab910d1f789fc ]---

Repro C Source Code: https://pastebin.com/Gmj8kvJB

Root Cause:

The root cause of this bug lies in the dsmark_init function within the
sch_dsmark module, where an invalid memory access occurs due to a null
pointer dereference (CR2: 0000000000000004). The PoC triggers this
issue by invoking a series of socket-related system calls, including
socket, bind, getsockname, and sendmsg, with crafted parameters and
malformed data. This results in the improper initialization or
handling of the dsmark traffic control queueing discipline, leading to
an assertion failure and kernel crash. The issue arises from
insufficient input validation and error handling during the
initialization of the sch_dsmark structure, where certain fields are
not properly set up before being accessed, violating kernel invariants
and causing the crash.

Thank you for your time and attention.

Best regards

Wall

