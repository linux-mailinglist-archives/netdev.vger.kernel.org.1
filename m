Return-Path: <netdev+bounces-169530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF06A44656
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DFE19C26DB
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63511195980;
	Tue, 25 Feb 2025 16:37:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E21946DF
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501442; cv=none; b=aRklietJzm7qiDp7u5XN6U9PeTtsXWrueHBMWYBQxJXzdvM+iR+pVBfk1YEUGjJY3Ip4g30EptmqQyDOIroUbTtAYIOH1s/pn8Qy5Pc4d9e4GoNcHjLseilXvbRNuOZtycnuAwrxGn+zK+Drxq7QCon24p26TSvGXKhzF7hHRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501442; c=relaxed/simple;
	bh=JXGNsMAKA/cIr0fw23heKnD8Fpk+70VhQUoueMIU+dA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WR2faLop9jECzipDSSiZq0IvkdWBdaxzZ/4+bbIwTN/OYkkNTpt9jHyjmHSuZGQ3rhbCj2QHpbUc2DEKrYTYdlOMelgbVwK7CQq1HclAsrZ65CMvd9mgo+Fc66KTGiqKHbUQEiYuw/y6z8WzkH3s3YfVoqeEQo/OrSWQ11/RMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=devklog.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=devklog.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-867129fdb0aso3565849241.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501439; x=1741106239;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bE1Bm++4+aG0JvqzXHtfxZSxbwfywYe7NdW94QidQIg=;
        b=ce7PZlxV/g021h+uweascBG+TmYtkg3JDP8Z3qteQdQ6RAyQzOJkUpRkhd/AqSE9xm
         5Ig5YkiAV70YJ6lAjww4LUPwW+uPjkN3m3jWZjkPexegiEIFwX4jrgOsxLHWGd8FRqJR
         UTNXOx5CMCapGT1cdiWsWWDyzO2FclUCvn1RuRHVEwLOZp//VNu6jVxjxhsMkIp8mspy
         DUgqhRmuO6Vgef5/ah3puhdMDXlOoTV0gptQQeQ9X13iRycAPxctrUcPX/4k76Xwg0Fn
         hhI1pXGHoxcYk9DJk7B9Rv9LDywLekojb8nyFAU6FsdIyc0JBIPk1cAQjLwh1X0R3Zw9
         VY4A==
X-Gm-Message-State: AOJu0YwO6ruXAfxmpWBx7w48VnC8KUdxBxuc0tDX09ZKlgmnc8WUkj0O
	HF6PWH/BtvpcQz6PMqnRxYCWN/1C1TE1R5L/L0wp59kifI/ie6LdP/wzvQ==
X-Gm-Gg: ASbGncst8hYgHr+B0hc+VmXUPhu5wLBb+k6dVmpkKofrru/zBolSp6WRagcVkHp0Oh0
	Ni6ajwS0L8Q7aCazorEa7LVJ4wAutVmVar3ZhY7Cwp9zeIF0wd3BCp/Zu/mNG7d7Tm+oJnY4CLG
	2s8Ca5ZDh3SxXehZal/hU4xSyN2HztVyUtSFYHKTzg68Mqv1oXjEeO7XkI/jMLGd4svNgawV2Kv
	AgbiYQMF/br1adppgkoTCnDPlta7MTt0aDlI4Vo6/JqSltZhnTMZeux96uyKGx25ALXyUjciUX2
	o/lLQGNkuHVrVNhxTV8fyI34aoTq6VmnY5HO87hygNE9b+e5rKuvsOnv
X-Google-Smtp-Source: AGHT+IGtphQAYN6SnLqeaj5u52N4Txa3SVmxouAupr2eOfFq6jmRr6ZOtpRRvyUVwLWR4d77hzbivQ==
X-Received: by 2002:a05:6102:2928:b0:4bb:e36f:6a35 with SMTP id ada2fe7eead31-4bfc280482fmr9208524137.14.1740501438955;
        Tue, 25 Feb 2025 08:37:18 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ed6eb5esm404222241.16.2025.02.25.08.37.18
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:37:18 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-868f19a9421so3642165241.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:37:18 -0800 (PST)
X-Received: by 2002:a05:6102:cd4:b0:4bb:e8c5:b157 with SMTP id
 ada2fe7eead31-4bfc29465dcmr9309040137.25.1740501438406; Tue, 25 Feb 2025
 08:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SmVhbi1GcmFuw6dvaXMgUm95?= <jf@devklog.net>
Date: Tue, 25 Feb 2025 08:37:07 -0800
X-Gmail-Original-Message-ID: <CAE8T=_Go-A_W9j18oO+5S52pXKwgFDcR8XgHiywwSRSZmO2LEw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo3XzyJQ3CwFhNx5fD629OTGZIyNneongY_0kMjUOJ_-HTtCNaCYjZWHvM
Message-ID: <CAE8T=_Go-A_W9j18oO+5S52pXKwgFDcR8XgHiywwSRSZmO2LEw@mail.gmail.com>
Subject: mlx5e_xmit: detected field-spanning write (6.12.16)
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm regularly seeing field-spanning write dumps from the mlx5 driver
on one of my Talos Linux + Cilium nodes running Linux 6.12.16. I don't
know if this is caused by a bug in one of Cilum's bpf programs or if
it's a legitimate issue with the driver.

kantai1: kern: warning: [2025-02-25T16:19:43.741311529Z]:
------------[ cut here ]------------
kantai1: kern: warning: [2025-02-25T16:19:43.741322529Z]: memcpy:
detected field-spanning write (size 32) of single field "h6 + 1" at
drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:469 (size 0)
kantai1: kern: warning: [2025-02-25T16:19:43.741350529Z]: WARNING:
CPU: 2 PID: 5273 at
drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:469
mlx5e_xmit+0x99b/0xe00 [mlx5_core]
kantai1: kern: warning: [2025-02-25T16:19:43.741401529Z]: Modules
linked in: nbd nvme_tcp nvme_fabrics nvme_keyring nvidia_uvm(O)
nvidia_modeset(O) nvidia(O) zfs(PO) spl(O) mlx5_ib nvme mlx5_core ahci
ixgbe sp5100_tco nvme_core mpt3sas ccp mlxfw libahci mdio watchdog
k10temp
kantai1: kern: warning: [2025-02-25T16:19:43.741426529Z]: CPU: 2 UID:
50 PID: 5273 Comm: apid Tainted: P           O       6.12.16-talos #1
kantai1: kern: warning: [2025-02-25T16:19:43.741433529Z]: Tainted:
[P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
kantai1: kern: warning: [2025-02-25T16:19:43.741435529Z]: Hardware
name: To Be Filled By O.E.M. ROMED8-2T/ROMED8-2T, BIOS P3.80
08/01/2023
kantai1: kern: warning: [2025-02-25T16:19:43.741439529Z]: RIP:
0010:mlx5e_xmit+0x99b/0xe00 [mlx5_core]
kantai1: kern: warning: [2025-02-25T16:19:43.741470529Z]: Code: 48 c7
c2 30 98 52 c0 4c 89 ce 89 04 24 48 c7 c7 78 98 52 c0 44 89 44 24 18
4c 89 5c 24 10 c6 05 08 1d 0c 00 01 e8 25 63 72 f2 <0f> 0b 44 8b 44 24
18 4c 8b 5c 24 10 8b 04 24 e9 9a fe ff ff 48 8b
kantai1: kern: warning: [2025-02-25T16:19:43.741474529Z]: RSP:
0018:ffffb42af65274f0 EFLAGS: 00010282
kantai1: kern: warning: [2025-02-25T16:19:43.741478529Z]: RAX:
0000000000000000 RBX: ffff8ebf75968840 RCX: 0000000000000027
kantai1: kern: warning: [2025-02-25T16:19:43.741482529Z]: RDX:
ffff8efd8d91bbc8 RSI: 0000000000000001 RDI: ffff8efd8d91bbc0
kantai1: kern: warning: [2025-02-25T16:19:43.741484529Z]: RBP:
ffff8ec29b976ee8 R08: 0000000000000000 R09: 732d646c65696620
kantai1: kern: warning: [2025-02-25T16:19:43.741487529Z]: R10:
ffffb42af6527290 R11: 203a7970636d656d R12: ffff8ebf7596f930
kantai1: kern: warning: [2025-02-25T16:19:43.741489529Z]: R13:
ffffb42ac29a34c0 R14: ffffb42ac29a34e0 R15: ffff8ebfc8411040
kantai1: kern: warning: [2025-02-25T16:19:43.741492529Z]: FS:
000000c000102e98(0000) GS:ffff8efd8d900000(0000)
knlGS:0000000000000000
kantai1: kern: warning: [2025-02-25T16:19:43.741495529Z]: CS:  0010
DS: 0000 ES: 0000 CR0: 0000000080050033
kantai1: kern: warning: [2025-02-25T16:19:43.741498529Z]: CR2:
000000c0116fd000 CR3: 0000000174728002 CR4: 0000000000f70ef0
kantai1: kern: warning: [2025-02-25T16:19:43.741501529Z]: PKRU: 55555554
kantai1: kern: warning: [2025-02-25T16:19:43.741503529Z]: Call Trace:
kantai1: kern: warning: [2025-02-25T16:19:43.741507529Z]:  <TASK>
kantai1: kern: warning: [2025-02-25T16:19:43.741509529Z]:  ?
mlx5e_xmit+0x99b/0xe00 [mlx5_core]
kantai1: kern: warning: [2025-02-25T16:19:43.741533529Z]:  ?
__warn.cold+0x93/0xe0
kantai1: kern: warning: [2025-02-25T16:19:43.741539529Z]:  ?
mlx5e_xmit+0x99b/0xe00 [mlx5_core]
kantai1: kern: warning: [2025-02-25T16:19:43.741568529Z]:  ?
report_bug+0xeb/0x130
kantai1: kern: warning: [2025-02-25T16:19:43.741573529Z]:  ?
handle_bug+0x53/0x90
kantai1: kern: warning: [2025-02-25T16:19:43.741578529Z]:  ?
exc_invalid_op+0x17/0x70
kantai1: kern: warning: [2025-02-25T16:19:43.741581529Z]:  ?
asm_exc_invalid_op+0x1a/0x20
kantai1: kern: warning: [2025-02-25T16:19:43.741588529Z]:  ?
mlx5e_xmit+0x99b/0xe00 [mlx5_core]
kantai1: kern: warning: [2025-02-25T16:19:43.741611529Z]:  ?
netif_skb_features+0xc1/0x2e0
kantai1: kern: warning: [2025-02-25T16:19:43.741616529Z]:
dev_hard_start_xmit+0x64/0x1a0
kantai1: kern: warning: [2025-02-25T16:19:43.741622529Z]:
sch_direct_xmit+0xb0/0x360
kantai1: kern: warning: [2025-02-25T16:19:43.741627529Z]:
__qdisc_run+0x143/0x590
kantai1: kern: warning: [2025-02-25T16:19:43.741630529Z]:
__dev_queue_xmit+0x578/0xe00
kantai1: kern: warning: [2025-02-25T16:19:43.741636529Z]:
ip6_finish_output2+0x2b7/0x600
kantai1: kern: warning: [2025-02-25T16:19:43.741641529Z]:  ?
nf_nat_ipv6_out+0x18/0x100
kantai1: kern: warning: [2025-02-25T16:19:43.741644529Z]:  ?
nf_hook_slow+0x41/0xe0
kantai1: kern: warning: [2025-02-25T16:19:43.741650529Z]:
ip6_finish_output+0x186/0x340
kantai1: kern: warning: [2025-02-25T16:19:43.741654529Z]:  ip6_xmit+0x2cd/0x630
kantai1: kern: warning: [2025-02-25T16:19:43.741657529Z]:  ?
ip6_output+0x150/0x150
kantai1: kern: warning: [2025-02-25T16:19:43.741661529Z]:  ?
__sk_dst_check+0x39/0xa0
kantai1: kern: warning: [2025-02-25T16:19:43.741665529Z]:  ?
inet6_csk_route_socket+0x138/0x200
kantai1: kern: warning: [2025-02-25T16:19:43.741671529Z]:
inet6_csk_xmit+0xce/0x130
kantai1: kern: warning: [2025-02-25T16:19:43.741676529Z]:
__tcp_transmit_skb+0x583/0xca0
kantai1: kern: warning: [2025-02-25T16:19:43.741682529Z]:
tcp_write_xmit+0x495/0x1580
kantai1: kern: warning: [2025-02-25T16:19:43.741688529Z]:
__tcp_push_pending_frames+0x32/0xc0
kantai1: kern: warning: [2025-02-25T16:19:43.741693529Z]:
tcp_sendmsg_locked+0xb0b/0xf50
kantai1: kern: warning: [2025-02-25T16:19:43.741699529Z]:  tcp_sendmsg+0x2b/0x40
kantai1: kern: warning: [2025-02-25T16:19:43.741703529Z]:
sock_write_iter+0x12d/0x1a0
kantai1: kern: warning: [2025-02-25T16:19:43.741709529Z]:  vfs_write+0x37e/0x430
kantai1: kern: warning: [2025-02-25T16:19:43.741716529Z]:  ksys_write+0xb9/0xf0
kantai1: kern: warning: [2025-02-25T16:19:43.741721529Z]:
do_syscall_64+0x6b/0xa60
kantai1: kern: warning: [2025-02-25T16:19:43.741729529Z]:
entry_SYSCALL_64_after_hwframe+0x55/0x5d
kantai1: kern: warning: [2025-02-25T16:19:43.741736529Z]: RIP: 0033:0x480c0e
kantai1: kern: warning: [2025-02-25T16:19:43.741741529Z]: Code: 24 28
44 8b 44 24 2c e9 70 ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff
76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
kantai1: kern: warning: [2025-02-25T16:19:43.741747529Z]: RSP:
002b:000000c00087d730 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
kantai1: kern: warning: [2025-02-25T16:19:43.741753529Z]: RAX:
ffffffffffffffda RBX: 000000000000000d RCX: 0000000000480c0e
kantai1: kern: warning: [2025-02-25T16:19:43.741756529Z]: RDX:
0000000000004016 RSI: 000000c000b4a000 RDI: 000000000000000d
kantai1: kern: warning: [2025-02-25T16:19:43.741760529Z]: RBP:
000000c00087d770 R08: 0000000000000000 R09: 0000000000000000
kantai1: kern: warning: [2025-02-25T16:19:43.741764529Z]: R10:
0000000000000000 R11: 0000000000000212 R12: 000000c00087d8a0
kantai1: kern: warning: [2025-02-25T16:19:43.741768529Z]: R13:
000000000000000a R14: 000000c000685a40 R15: 000000c00067c640
kantai1: kern: warning: [2025-02-25T16:19:43.741773529Z]:  </TASK>
kantai1: kern: warning: [2025-02-25T16:19:43.741777529Z]: ---[ end
trace 0000000000000000 ]---

