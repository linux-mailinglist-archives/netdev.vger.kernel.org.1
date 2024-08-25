Return-Path: <netdev+bounces-121709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38B95E283
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 09:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410D61F21B02
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F461FC4;
	Sun, 25 Aug 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Q4DPPDR+";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="UbVmgG1v"
X-Original-To: netdev@vger.kernel.org
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA82AEFD
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571947; cv=none; b=hKDvfsuuvfI6/sjkpEmepq8VZ+uWusSEoVwAbS0Jxg06DpQEuX529u1nB+ak11SCzoxwbjBtL2OVRYJ7QGm76Ii+OEo63LUc1WjRZcdTp6heFVGQXq6yNBg6RUFtzDvpEQR7MXDohSI69napBuD6CEW5jk+8tcJl8d5aGGZAKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571947; c=relaxed/simple;
	bh=Wc1ReSSoRHrxczllmAyrC82DrWl15s7C5Gl7hBzXjR0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XX2erJjgC+UKzp8gordni7ROfFae+38RalRg6u9kJHZu1Up9gPluXTaYjTETiUFb6S3nTnvlzZilslhkrfdX1APUhRdvkA1Qec8LPXI3Clpa3e96n365dN+Zwzy1Ftb/zsMy7izTjyRcSgqLWCdOOBJ4x2oQxYWLjAJbR2N1/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Q4DPPDR+; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=UbVmgG1v; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724571945; x=1756107945;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=Wc1ReSSoRHrxczllmAyrC82DrWl15s7C5Gl7hBzXjR0=;
  b=Q4DPPDR+CzF/9AwVx/RxcceWfXg8FyWZONf+bDcp/huJ7aZiw3UqB63U
   SA9UKtv2hy5rORB0pEvo1TsDmytTCiX7BopU1V0sc5qe/eI/PncD7KKpO
   TBh49YutWSi8J1mEPSjFKaEWbbs9yZCTE6Od8ndEZEiQ1p4ms6a6pxeEa
   25hr/bM8kd1u6ahm4duHhw02MRcG5Wz4y7JiNJwJEgbNKktszbsIH5otF
   DaDOA6ajIDdaP7tirsQNqGSrf5RQHd1CE8Zaxxr/B8qZkuQMPgaPcQpfK
   QPJGse5dm9EJDRdezZbVVek4wwrfwD4/zYyOCoRmbIlnlMZ035rpyoWs/
   A==;
X-CSE-ConnectionGUID: nc3BqjXdQvyi3Z6YsqCWkQ==
X-CSE-MsgGUID: iTaio583QAmT25NyP7sL3A==
Received: from mail-io1-f71.google.com ([209.85.166.71])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 25 Aug 2024 00:45:45 -0700
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f93601444so372394939f.2
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724571944; x=1725176744; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nd8St0Q3+Z5rQPfjGMrPNgX+gBQoI0R6Kq0GksepDsQ=;
        b=UbVmgG1v2Hb9d+OeR8yeG5mVzt+PcyJwcPOhWRE4jTQDuVLNetKFmRkPMEeLgcDvgB
         RECHiiekg4kNPD9bsxKjSlCFTvhCxIq7OU1ytv8daSNO57UpaM8mSqR2agycaWrjI2VU
         xberCY3K2iUfCPp8Jw/gm9BLX1uXpxwjUYtyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724571944; x=1725176744;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nd8St0Q3+Z5rQPfjGMrPNgX+gBQoI0R6Kq0GksepDsQ=;
        b=orr/GuA4BbbjtBCATfnlXVFec5xgsyFJoJOZTJ0ZS2NcwfEhLcvhU7RLfEKGzf+a//
         R9dcI0QkRLTtXuVP3Hyw4IZ8V8od0NKGw+r6mha18NKqeUf9V5Nu0vAFuPeCMCThkBL7
         iwCoPBnHvZ0ZKOKdOHRUwXflfcpd7v/qd+fD0HlBxAuRPnsKfT+PtW++z5HSvGVzsrKN
         GiPqsGMCB6B9j3PNcvdVgmLyiJ5CFxH9lNv04oqj5Oh9yb49rKX1rLOoOdj/oUhlDde2
         gDxXWznqPHCp/KkV8qu6v1PzY2cAm8PuZMV4S+WQariQ69CtWR2wt9zTSjRnVOdrRBhW
         AqNg==
X-Forwarded-Encrypted: i=1; AJvYcCUWNQL/Gdnyz0vBVXluEAI7lzJDRehGZMeIxZZuXRWg2Uwl1ai9WQz0qv0SJFHi7l+VIWLxQBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBi0xPcARSSJk0O0RFFHdNaVsrpTXX2gxITh8kx9MGgdIKf00l
	Z5nhpTM+TnUDZiwUYOan6zFVE1MDWTm4kchlJA+b5l4HLyLafM5C7utI+kEjOPLxJ6qstRY0dSA
	g/p0W8saylZ9uLECLuPqm68VgjG+hM5T0HRKYfTOY2xWnSCYcsQ7qhMBO1VgDJKWqswaeRjXyNs
	nQ0wDS9g5sBzhTjiaYyTAec/q3BVbrIg==
X-Received: by 2002:a05:6602:2c08:b0:804:f2be:ee33 with SMTP id ca18e2360f4ac-82787323b5bmr1085271339f.2.1724571943623;
        Sun, 25 Aug 2024 00:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHLdzYf+KApPZ3mER63Tiqo6L2o5S4C2XhxzItF+QR6Mv/oPhPCKwSu0JNzBqAWSVNlul45WSG5uwliJtUEao=
X-Received: by 2002:a05:6602:2c08:b0:804:f2be:ee33 with SMTP id
 ca18e2360f4ac-82787323b5bmr1085270339f.2.1724571943267; Sun, 25 Aug 2024
 00:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sun, 25 Aug 2024 00:45:30 -0700
Message-ID: <CANikGpd2u3=GH8TLL40UuOJroe0-WdYCjj1vZJyCBgmSRvtNWQ@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in __netif_receive_skb_core
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In function `__netif_receive_skb_core`, an error of "unable to handle
kernel paging request" happend when executing `if (ptype->type !=
type)`. It happened because the register $r12 became an unexpected
value 0xffffffffffffffc0, because it was propagated from $r15 whose
value was null. So it's likely that this is an null-pointer
dereference issue.

The full report including the Syzkaller reproducer:
https://gist.github.com/TomAPU/38bb00292b33d52a6dd2d1b629247146/revisions

The brief report is below:

Syzkaller hit 'BUG: unable to handle kernel paging request in
__netif_receive_skb_core' bug.

BUG: unable to handle page fault for address: ffffffffffffffc0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD d936067 P4D d936067 PUD d938067 PMD 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 8484 Comm: kworker/0:5 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
RIP: 0010:deliver_ptype_list_skb net/core/dev.c:2247 [inline]
RIP: 0010:__netif_receive_skb_core+0x3163/0x3ef0 net/core/dev.c:5581
Code: 48 8d 41 10 48 89 44 24 48 4d 8d 67 c0 4c 89 e0 48 c1 e8 03 48
b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 0f 85 61 02 00 00 <41> 0f
b7 1c 24 89 df 44 89 f6 e8 ee f5 b8 f8 66 44 39 f3 0f 85 a0
RSP: 0018:ffffc90000007880 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000080000101 RSI: 000000000000dd86 RDI: 0000000000000000
RBP: ffffc90000007a50 R08: ffffffff88d85c72 R09: ffffffff88d82f9b
R10: 0000000000000002 R11: ffff8880244b5a00 R12: ffffffffffffffc0
R13: ffffffff8f260cb0 R14: 000000000000dd86 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc0 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __netif_receive_skb_one_core net/core/dev.c:5623 [inline]
 __netif_receive_skb+0x11e/0x640 net/core/dev.c:5739
 process_backlog+0x37d/0x7a0 net/core/dev.c:6068
 __napi_poll+0xcc/0x480 net/core/dev.c:6722
 napi_poll net/core/dev.c:6791 [inline]
 net_rx_action+0x7ed/0x1040 net/core/dev.c:6907
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 do_softirq+0x117/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1b0/0x1f0 kernel/softirq.c:382
 wg_socket_send_skb_to_peer+0x172/0x1d0 drivers/net/wireguard/socket.c:184
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1ba/0x960 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: ffffffffffffffc0
---[ end trace 0000000000000000 ]---
RIP: 0010:deliver_ptype_list_skb net/core/dev.c:2247 [inline]
RIP: 0010:__netif_receive_skb_core+0x3163/0x3ef0 net/core/dev.c:5581
Code: 48 8d 41 10 48 89 44 24 48 4d 8d 67 c0 4c 89 e0 48 c1 e8 03 48
b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 0f 85 61 02 00 00 <41> 0f
b7 1c 24 89 df 44 89 f6 e8 ee f5 b8 f8 66 44 39 f3 0f 85 a0
RSP: 0018:ffffc90000007880 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000080000101 RSI: 000000000000dd86 RDI: 0000000000000000
RBP: ffffc90000007a50 R08: ffffffff88d85c72 R09: ffffffff88d82f9b
R10: 0000000000000002 R11: ffff8880244b5a00 R12: ffffffffffffffc0
R13: ffffffff8f260cb0 R14: 000000000000dd86 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc0 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 48 8d 41 10           lea    0x10(%rcx),%rax
   4: 48 89 44 24 48       mov    %rax,0x48(%rsp)
   9: 4d 8d 67 c0           lea    -0x40(%r15),%r12
   d: 4c 89 e0             mov    %r12,%rax
  10: 48 c1 e8 03           shr    $0x3,%rax
  14: 48 b9 00 00 00 00 00 movabs $0xdffffc0000000000,%rcx
  1b: fc ff df
  1e: 0f b6 04 08           movzbl (%rax,%rcx,1),%eax
  22: 84 c0                 test   %al,%al
  24: 0f 85 61 02 00 00     jne    0x28b
* 2a: 41 0f b7 1c 24       movzwl (%r12),%ebx <-- trapping instruction
  2f: 89 df                 mov    %ebx,%edi
  31: 44 89 f6             mov    %r14d,%esi
  34: e8 ee f5 b8 f8       call   0xf8b8f627
  39: 66 44 39 f3           cmp    %r14w,%bx
  3d: 0f                   .byte 0xf
  3e: 85                   .byte 0x85
  3f: a0                   .byte 0xa0

