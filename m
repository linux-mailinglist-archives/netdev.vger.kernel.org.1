Return-Path: <netdev+bounces-239609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B0C6A255
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 129A8362D81
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667F361DCD;
	Tue, 18 Nov 2025 14:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8A35F8D5
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477849; cv=none; b=n0zld0hkKqzNCw2bPFuCEWXG1+SY/5PMdBn5kr5CypEYdVS3v87S5Oo4eb3ZS/MTuK2Yi/f2yy+EtMNhn3iltWaR+8wOnVZlPUbYwX3K5yzmzXu8rnOp7jLwYPbIvmyN4kJDgQUgjAyxLeK71GjG1hk/2XbVOD87BBp2mesfidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477849; c=relaxed/simple;
	bh=ruYCHusFkEH9KG2jSmGmY93iY/CEiGTZkjjn416cp2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Fafipu6HNGzNHczyCdjareBtFqzcdwDxC500Mmhp3t4UmkeIHZqOkzG/Wifxbh/1NXfxlCwXrY0NXqcOFe3KY+QdWEEj9TIYjev6AlV1BEuYPb6VwxXsb9a4AlK/5wtS6OHa4YdUDpetEYB3MZq0wek5t/JPhcR0JrIJGe2AmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9487df8723aso1131982639f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 06:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763477847; x=1764082647;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u763Shby4GQU/5OqcoMKzhO+KKK/dvga9Fa7xrTqfVg=;
        b=MSK9Es9yYedqzdOJvMNx5ZUuKtIWS+FK8NYlGWooIv8WxFED2MLG9Hjk5yazQ0sD5L
         O5pKvRTV2qT6t5Kjy8WcLOhE9eP0MBPLeW2s5d1u+uQxoPW5hU4eaOHs7Qq7JeZ6JymP
         VYnkp4y2TcKAqKcsPd4yRL70shliyIXfCDnuVZW+WOaqNv6H/1DJ3PRQqqCa4fF0UCUP
         05KpjVVdPOnxZ63m4Uq+fjB2oYFLTBOtpYEdDJxcE6Cd0cLC10KuLCPfV3l1EcZEpdoh
         tRT5c/WJl06bd/IEA2AUv/bz8sLZ7YhBXBDsgmH4dILcn+AfrBcyWwm/aqagKczxnpBl
         IwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX09rf9gYdv6e9TpTTrsncfKOswXz6R20sFiTpeAYeem8fkBS9ztnmYaKBjT0BogPNbbANGGNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zV+g056AIyrP9x+bLgy4nRokvIaRyV0y2eSzn/59a1c/KVl0
	9JWxvVYfv6H1H6xHnJOofc1SoD/IWOcvs17gUv65CRQmhpjCellHOiL0CmIeLHUOVMjHKK1+b8x
	U+8EnGeLUkBthPmVT6Bww3e0rqF++fKzXsRucDXDbEK2fv2/5f/OF7Wcm3rI=
X-Google-Smtp-Source: AGHT+IHa4N09KYI8/WNwIltWNhmJKlXVmJu3DeOqrGZ0vlm1Y96bjs9AjcmNtJPRcyC9kLIx3VFX6ZXPa2RYWqnjo0rNI9BKaFSd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:433:2240:a516 with SMTP id
 e9e14a558f8ab-4348c93d24amr231835385ab.30.1763477847195; Tue, 18 Nov 2025
 06:57:27 -0800 (PST)
Date: Tue, 18 Nov 2025 06:57:27 -0800
In-Reply-To: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691c8957.a70a0220.3124cb.00cd.GAE@google.com>
Subject: [syzbot ci] Re: ipvlan: support mac-nat mode
From: syzbot ci <syzbot+ci8641603e6d3479de@syzkaller.appspotmail.com>
To: andrew@lunn.ch, andrey.bokhanko@huawei.com, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, skorodumov.dmitry@huawei.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v4] ipvlan: support mac-nat mode
https://lore.kernel.org/all/20251118100046.2944392-1-skorodumov.dmitry@huawei.com
* [PATCH net-next 01/13] ipvlan: Support MACNAT mode
* [PATCH net-next 02/13] ipvlan: macnat: Handle rx mcast-ip and unicast eth
* [PATCH net-next 03/13] ipvlan: Forget all IP when device goes down
* [PATCH net-next 04/13] ipvlan: Support IPv6 in macnat mode.
* [PATCH net-next 05/13] ipvlan: Fix compilation warning about __be32 -> u32
* [PATCH net-next 06/13] ipvlan: Make the addrs_lock be per port
* [PATCH net-next 07/13] ipvlan: Take addr_lock in ipvlan_open()
* [PATCH net-next 08/13] ipvlan: Don't allow children to use IPs of main
* [PATCH net-next 09/13] ipvlan: const-specifier for functions that use iaddr
* [PATCH net-next 10/13] ipvlan: Common code from v6/v4 validator_event
* [PATCH net-next 11/13] ipvlan: common code to handle ipv6/ipv4 address events
* [PATCH net-next 12/13] ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
* [PATCH net-next 13/13] selftests: drv-net: selftest for ipvlan-macnat mode

and found the following issue:
WARNING: suspicious RCU usage in ipvlan_addr_event

Full report is available here:
https://ci.syzbot.org/series/e483b93a-1063-4c8a-b0e2-89530e79768b

***

WARNING: suspicious RCU usage in ipvlan_addr_event

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      c99ebb6132595b4b288a413981197eb076547c5a
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/ac5af6f3-6b14-4e35-9d81-ee1522de3952/config

8021q: adding VLAN 0 to HW filter on device batadv0
=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
drivers/net/ipvlan/ipvlan.h:128 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor/5984:
 #0: ffffffff8f2cc248 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/0x18b0
 #1: ffffffff8f39d9b0 ((inetaddr_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90

stack backtrace:
CPU: 1 UID: 0 PID: 5984 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250
 lockdep_rcu_suspicious+0x140/0x1d0
 ipvlan_addr_event+0x60b/0x950
 notifier_call_chain+0x1b6/0x3e0
 blocking_notifier_call_chain+0x6a/0x90
 __inet_insert_ifa+0xa13/0xbf0
 inet_rtm_newaddr+0xf3a/0x18b0
 rtnetlink_rcv_msg+0x7cf/0xb70
 netlink_rcv_skb+0x208/0x470
 netlink_unicast+0x82f/0x9e0
 netlink_sendmsg+0x805/0xb30
 __sock_sendmsg+0x21c/0x270
 __sys_sendto+0x3bd/0x520
 __x64_sys_sendto+0xde/0x100
 do_syscall_64+0xfa/0xfa0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f711f191503
Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 70 22 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
RSP: 002b:00007ffc44b05f28 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f711ff14620 RCX: 00007f711f191503
RDX: 0000000000000028 RSI: 00007f711ff14670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffc44b05f44 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f711ff14670 R15: 0000000000000000
 </TASK>
syz-executor (5984) used greatest stack depth: 19864 bytes left


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

