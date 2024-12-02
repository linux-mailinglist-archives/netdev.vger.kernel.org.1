Return-Path: <netdev+bounces-147982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A429DF9ED
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 05:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A46161B50
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF761F8AFA;
	Mon,  2 Dec 2024 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXfVa5F8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B61F8F19;
	Mon,  2 Dec 2024 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113895; cv=none; b=EVkQZyZDD5CrciNFPbtDusyMHs6oqNcdpm49J2bOwYHPopWnTPopp3yRWRk1PPbvS0YAxYUx84fPTUN9eK4J76eXLAiWO5iyezxGhujXSd1ojIuSYLgcP09dPwdVIosK1mV59fO9UKwlSex+wlI1A4loJ7kwMueeyEDLIs21nhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113895; c=relaxed/simple;
	bh=oY9lbTYj5kesSZ5kBO+VHe4hOcD3qbTqWUzofJFt5K0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l6120EjqdKtRsJkeemlRBwrgkky7Q5FsMvFo1JxHxlM69o4eKqCUwE7cCkphw98qQtPkAleKxYFH5vfwOhWx/zCRMYYrVqhFQz6lViqU1SrTgYCHG+6y8Rm5ZHXdq4OEdiUpiQ7wRPY4p4qEX46KYQtTeKHGxF2jngYOlGad6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXfVa5F8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa5366d3b47so623273866b.0;
        Sun, 01 Dec 2024 20:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733113890; x=1733718690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oY9lbTYj5kesSZ5kBO+VHe4hOcD3qbTqWUzofJFt5K0=;
        b=CXfVa5F8f2cWxQ3M6sB+WBx7k3JGSkDxElBG2UXeyKrtYMw7S4sfe1TVf4dfeQEV5D
         Uj11WuN4/bhLhV9QE7HJsUznfAANyOQLLye8VhCIFdx2Du2TpDxYVpOlS7vVXsH+PCXq
         m7hKLIOZj+rxNSB1InJClQ/Z4AIkYoBSuIDDkJtSO6xHjzx755asMmAbRlO1XJGQuawq
         ZGaCEKz2vNEcq8nrB++5xSYV+qUyQwgw3r4d8VAsubtMAWKrlWq/13BXJ0vzuTmgvrrD
         GfLofA2fjoQ7c1TcwzTq/ElX3Z6DnBYrEiSXksCedTZbsGpeiXJ129qfwjLOovBDuSlU
         nLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113890; x=1733718690;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oY9lbTYj5kesSZ5kBO+VHe4hOcD3qbTqWUzofJFt5K0=;
        b=qaoqUocYpQqpVYNKCOMSGa2J3CgMnjWjTjcdb3aG6Jd0IcUl9gIpXI0a8N6+r0cwBQ
         BD12D+uKOnM2zfA52u9tK909XFWBKZ9sGjg5ATk4LtfGhilBj4ST43s74wHAPe+G4s1v
         V8NIi5ldRE5XZiGqB3IGfQARpLqK/iQKerTU0MM2HnBULR+wACNdvxxBxarRh0J4KJb5
         QTDjmEQY2N5gc+lc9zUbBDz7YEzuuITOqCvG4M18n7JDwoulQKfI8i6mTdnyZwloFJLa
         /PXGR2Mzk4RS38uOl7N9s+fGcxrEAI2xSUgzN9TrBNibviSxXnFcblG2fHuZefAMJJ7/
         sH1w==
X-Forwarded-Encrypted: i=1; AJvYcCXL0m9OkMsZBVCU6ET0NU6/jKvGisVm5L4BU8tTTgJ+MKuv7yoc1xM1OyvKp0R5SrPtUMWvQEf654RclGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5SoJdu0djEqn1aE4i5D0Ii5qUVH42Pv89nDLmPqqE3yzhuhdf
	1nwaIORTj+R2z4w5TSbdTFxcxbeQLhpzwSu35+sQSmeH2xkF7ndoGuitAW5/CHn1HhB0mJ4J6Pd
	D0jCQa2/ALF9hv8SbkVyAUluZ1zw=
X-Gm-Gg: ASbGncvUbs+OgYoOQHGTbdgE1UBXVSrZxV59wDPjzj1nLPUsE1QdNEgSQCStI61l2Vw
	5nHaKLi7mac1HoEo8s0fSmZczD5rXtODe
X-Google-Smtp-Source: AGHT+IGLHgN2lSBuI8Vi73vkLuueEXO3I5ntd4QiZ9GlpDHGh0Mqp1BSoKpleMQ3LoRsw0Wpz72s8HhSs1bQ5VVsMC4=
X-Received: by 2002:a17:907:778f:b0:aa5:1019:7ade with SMTP id
 a640c23a62f3a-aa580f1d550mr1609342466b.13.1733113889869; Sun, 01 Dec 2024
 20:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 12:31:18 +0800
Message-ID: <CAKHoSAtO1vE+_-Fo9Gc9Tv2bgtubkBYk6uEOddJr79DNQvmSQQ@mail.gmail.com>
Subject: "general protection fault in netlbl_unlhsh_add" in Linux Kernel
 Version 4.9
To: paul@paul-moore.com, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 4.9
This issue was discovered using our custom vulnerability discovery
tool.

Affected File: netlabel_unlabeled.c

File: netlabel_unlabeled.c
Function: netlbl_unlhsh_add_addr4

Detailed call trace:

sr 1:0:0:0: [sr0] unaligned transfer
tmpfs: Bad mount option nr_)nodes
9pnet: Insufficient options for proto=fd
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Modules linked in:
CPU: 1 PID: 6915 Comm: syz.2.719 Not tainted 4.9.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
task: ffff88006b952940 task.stack: ffff88005d920000
RIP: 0010:[<ffffffff82f4e3e6>] [<ffffffff82f4e3e6>]
netlbl_unlhsh_add_addr4 net/netlabel/netlabel_unlabeled.c:262 [inline]
RIP: 0010:[<ffffffff82f4e3e6>] [<ffffffff82f4e3e6>]
netlbl_unlhsh_add+0x8e6/0xf00 net/netlabel/netlabel_unlabeled.c:430
RSP: 0018:ffff88005d9274c8 EFLAGS: 00010257
RAX: 000000000100007f RBX: 0000000000000004 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000202 RDI: 0000000000000000
RBP: ffff88005d9275b8 R08: 00000000000000a0 R09: ffff88005d80c000
R10: 00000000e8d5b47c R11: 0000000097bb816a R12: ffff88006abcd680
R13: 0000000000000000 R14: ffff88005d9bcae0 R15: ffff88006879542c
FS: 00007f7c96bb1640(0000) GS:ffff88006d100000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7c96baff88 CR3: 0000000069138000 CR4: 00000000003406e0
Stack:
ffffffff81946e40 ffff88006abcd680 1ffff1000bb24e9e 0000012b83476cad
0000000000000000 0000000041b58ab3 ffffffff834b7a00 ffffffff82f4db00
ffff88005d927638 00000000024000c0 0000000000000022 ffff88005d927550
Call Trace:
[<ffffffff82f4ed95>] netlbl_unlabel_staticadddef+0x395/0x460
net/netlabel/netlabel_unlabeled.c:980
[<ffffffff82915b6c>] genl_family_rcv_msg+0x69c/0xc30 net/netlink/genetlink.c:636
[<ffffffff829162ab>] genl_rcv_msg+0x1ab/0x260 net/netlink/genetlink.c:660
[<ffffffff82914477>] netlink_rcv_skb+0x297/0x390 net/netlink/af_netlink.c:2298
[<ffffffff829154b8>] genl_rcv+0x28/0x40 net/netlink/genetlink.c:671
[<ffffffff82912e84>] netlink_unicast_kernel
net/netlink/af_netlink.c:1231 [inline]
[<ffffffff82912e84>] netlink_unicast+0x4c4/0x6e0 net/netlink/af_netlink.c:1257
[<ffffffff82913a17>] netlink_sendmsg+0x977/0xca0 net/netlink/af_netlink.c:1803
[<ffffffff8280164a>] sock_sendmsg_nosec net/socket.c:621 [inline]
[<ffffffff8280164a>] sock_sendmsg+0xca/0x110 net/socket.c:631
[<ffffffff82803480>] ___sys_sendmsg+0x730/0x870 net/socket.c:1954
[<ffffffff82804cf1>] __sys_sendmsg+0xd1/0x170 net/socket.c:1988
[<ffffffff82804dbd>] SYSC_sendmsg net/socket.c:1999 [inline]
[<ffffffff82804dbd>] SyS_sendmsg+0x2d/0x50 net/socket.c:1995
[<ffffffff82f8f937>] entry_SYSCALL_64_fastpath+0x1a/0xa9
Code: 14 02 4c 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 f4 02
00 00 48 89 d9 48 ba 00 00 00 00 00 fc ff df 41 8b 07 48 c1 e9 03 <0f>
b6 0c 11 48 89 da 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RIP [<ffffffff82f4e3e6>] netlbl_unlhsh_add_addr4
net/netlabel/netlabel_unlabeled.c:262 [inline]
RIP [<ffffffff82f4e3e6>] netlbl_unlhsh_add+0x8e6/0xf00
net/netlabel/netlabel_unlabeled.c:430
RSP <ffff88005d9274c8>
---[ end trace ec99797c85dd42d0 ]---

Repro C Source Code: https://pastebin.com/aHhVhbJ4

Root Cause:

The root cause appears to be a NULL pointer dereference or improper
memory handling within the netlbl_unlhsh_add function, likely due to
misconfigurations or faulty memory accesses. This could be exacerbated
by incorrect kernel options or mounting configurations, such as
unaligned transfers or missing options for 9pnet.

Thank you for your time and attention.

Best regards

Wall

