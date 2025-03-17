Return-Path: <netdev+bounces-175183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54775A6410F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530F6189121F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B151DF24E;
	Mon, 17 Mar 2025 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtbOcPJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5F28E3F
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192245; cv=none; b=VQHeIEHbiyae9jTJps6btT8S3lahdj3LRqHbibsMpe90n219PjV2AXa8zqlQcwpZfE5adsqVuBAGP/rnxpJv1Q0Fa73r1Uq7nxqmFftLkLLGcrkNBfboEHeKMxXfFFtAkGX49AdV6mO8iB22X5MD5CytcMaVCgHWzC6q2dDgpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192245; c=relaxed/simple;
	bh=jJxCszxbJOiO/3VvhDNyqf9hQuzn+3D4SlBkuBddPUs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=vCTm+vdHZ5rikE5x4Rl1DPCMkXFxD7NJnSZUF7YzPVLQgMfVPrR4ka50L/AT8PW9C9uHvabBR1Y0Eq4ZOCcjTPe4ahnEqY+0OzWNWAkJmnJtmXCfLVTcNMQujY1esx84SJPD5bdIc7CFqbmzyMZzUdItquX+ygq4JsIlqwnbH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtbOcPJo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso7119844a12.2
        for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 23:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742192241; x=1742797041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXi8STk1nKKZsJst7Aq2xD99ogtnMVrEfct9SThPE0k=;
        b=FtbOcPJoOEsH3KWGXM29ZB77DkfvH/trV4mAIjaqONfWDRTowt8LMOCBcOrVy4uk31
         dloCXhzE0FOk7jGAHxf8CYRB4vBP4LRJSl+w1b5+xDNE30Kcym7iLqa+N5YNQAEA/9Jh
         wo9kpxgQrp2fg79cnsDUNurXyaV1N8RqD0sPVc4FalBa1imEduZPf33ObUIVTHqBa7PJ
         zoeHGtRHLyPkBly3HThacbY4epMQ83jyGEVgrCjI4a0bwzwnFGqrMcoW2m2jnBcvhuHt
         1yA4xp2Aoz9MEzj+/VehpmZJrBQMa7vdXmiBFThOLegMJQrPsK6HbuLCavX9Rv+1awS6
         PDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742192241; x=1742797041;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXi8STk1nKKZsJst7Aq2xD99ogtnMVrEfct9SThPE0k=;
        b=pUrhIJ58CoH197rFoqICKL5/Ak/bFD7WOWgNaD5EZ5uOVsSVtbCxlyHxp16UdjTgxw
         5Ry6d0SsXgal/Oe2iLJBm7ydNxIGv3QeY/S/1bPcfK3p7BQY4oCLpkc2neW9FH8sgcM7
         A8VwnvRo6o5agsrTLE5TK9TiIH8djrYQy0P7LjQdSfwPz/A1znneQPQ56mBjCLHhdLsF
         keD6YtGKBP2AnfQE2zf1WIfhqnOYeBaDJm0kFql0EylHnRKmUeCYkAgoTW4c2m0a+gkm
         ttSs5qEB+1Ozj8i3FPHE7vKKY57wRm36BbHsmLvST3hNqsz4jUy6PWJ+iWLV55jh8vR2
         wJug==
X-Gm-Message-State: AOJu0Ywew5kHWh6jAmdnpqp+/f26qxCLTvH5gz0EzA1ogmjguVgHK3C1
	81bLifKJG1JhrccRtVVPVwYbdTDtFa36cIvmwaR3hBfRuueos8XoVkg9LKAJamzjL727Y7ZVjnZ
	KMKaeK+sTxgIM5LHqlS8LYUGqONe0WSZqF10=
X-Gm-Gg: ASbGncvXRd6iBrzkI9gWln8m36sjHi0hSlCyUI6szieMYmnraiG/C2na+TyF4OxRWQ8
	nFTzYu26M2dsbi7UxA9M9hHxPHRGAhqHqRiL7OKIfeFVFAg6JsKzYjeegm01L0grNxtSO0QNKnN
	gwuSVxproxIfRx4YoaZCJBwvCXrCuj
X-Google-Smtp-Source: AGHT+IGcgaBjIvGM5ZZKlH4qKrHDn66vTkNDLVRECnySc7Po++cNJ/492vz0OK7WTBf9E/XjoVDCt3vF8GT6Z8YCBEo=
X-Received: by 2002:a05:6402:50d0:b0:5e4:b66f:880e with SMTP id
 4fb4d7f45d1cf-5e89f24f5e8mr8013703a12.7.1742192241244; Sun, 16 Mar 2025
 23:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 17 Mar 2025 15:17:09 +0900
X-Gm-Features: AQ5f1Jp9HoLJpzFPba545PtTITeyn4eHZz6qIjQTCDdacpYZYJxugM68jHi9DlE
Message-ID: <CAMArcTX2dEs=H586fumSEv_V8_p-pcAjyyPXkcLG9WkQM+c0cA@mail.gmail.com>
Subject: Report deadlock in the latest net-next
To: Netdev <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Stanislav,
I found a deadlock in the latest net-next kernel.
The calltrace indicates your current
commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations").
The dev->lock was acquired in do_setlink.constprop.0+0x12a/0x3440,
which is net/core/rtnetlink.c:3025
And then dev->lock is acquired in dev_disable_lro+0x81/0x1f0,
which is /net/core/dev_api.c:255
dev_disable_lro() is called by netdev notification, but notification
seems to be called both outside and inside dev->lock context.
This case is that netdev notification is called inside dev->lock context.
So deadlock occurs.
Could you please look into this?

Reproducer:
modprobe netdevsim
ip netns add ns_test
echo 1 > /sys/bus/netdevsim/new_device
ip link set $interface netns ns_test

============================================
WARNING: possible recursive locking detected
6.14.0-rc6+ #56 Not tainted
--------------------------------------------
ip/1672 is trying to acquire lock:
ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at: dev_disable_lro+0x81/0x1f0

but task is already holding lock:
ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at:
do_setlink.constprop.0+0x12a/0x3440

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock);
  lock(&dev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by ip/1672:
 #0: ffffffff943ba050 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x6b4/0x1c60
 #1: ffff88813abc6170 (&net->rtnl_mutex){+.+.}-{4:4}, at:
rtnl_newlink+0x6f6/0x1c60
 #2: ffff888231fbad90 (&dev->lock){+.+.}-{4:4}, at:
do_setlink.constprop.0+0x12a/0x3440

stack backtrace:
CPU: 2 UID: 0 PID: 1672 Comm: ip Not tainted 6.14.0-rc6+ #56
66129e0c5b1b922fef38623168aea99c0593a519
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
Call Trace:
 <TASK>
 dump_stack_lvl+0x7e/0xc0
 print_deadlock_bug+0x4fd/0x8e0
 __lock_acquire+0x3082/0x4fd0
 ? __pfx___lock_acquire+0x10/0x10
 ? mark_lock.part.0+0xfa/0x2f60
 ? __pfx___lock_acquire+0x10/0x10
 ? check_chain_key+0x1c1/0x520
 lock_acquire+0x1b0/0x570
 ? dev_disable_lro+0x81/0x1f0
 ? __pfx_lock_acquire+0x10/0x10
 __mutex_lock+0x17c/0x17c0
 ? dev_disable_lro+0x81/0x1f0
 ? dev_disable_lro+0x81/0x1f0
 ? __pfx___mutex_lock+0x10/0x10
 ? mark_held_locks+0xa5/0xf0
 ? neigh_parms_alloc+0x36b/0x4f0
 ? __local_bh_enable_ip+0xa5/0x120
 ? lockdep_hardirqs_on+0xbe/0x140
 ? dev_disable_lro+0x81/0x1f0
 dev_disable_lro+0x81/0x1f0
 inetdev_init+0x2d1/0x4a0
 inetdev_event+0x9b3/0x1590
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_inetdev_event+0x10/0x10
 ? notifier_call_chain+0x9b/0x300
 notifier_call_chain+0x9b/0x300
 netif_change_net_namespace+0xdfe/0x1390
 ? __pfx_netif_change_net_namespace+0x10/0x10
 ? __pfx_validate_linkmsg+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 do_setlink.constprop.0+0x241/0x3440
 ? lock_acquire+0x1b0/0x570
 ? __pfx_do_setlink.constprop.0+0x10/0x10
 ? rtnl_newlink+0x6f6/0x1c60
 ? __pfx_lock_acquired+0x10/0x10
 ? netlink_sendmsg+0x712/0xbc0
 ? rcu_is_watching+0x11/0xb0
 ? trace_contention_end+0xef/0x140
 ? __mutex_lock+0x935/0x17c0
 ? __create_object+0x36/0x90
 ? __pfx_lock_release+0x10/0x10
 ? rtnl_newlink+0x6f6/0x1c60
 ? __nla_validate_parse+0xb9/0x2830
 ? __pfx___mutex_lock+0x10/0x10
 ? lockdep_hardirqs_on+0xbe/0x140
 ? __pfx___nla_validate_parse+0x10/0x10
 ? rcu_is_watching+0x11/0xb0
 ? cap_capable+0x17d/0x360
 ? fdget+0x4e/0x1d0
 rtnl_newlink+0x108d/0x1c60
 ? __pfx_rtnl_newlink+0x10/0x10
 ? mark_lock.part.0+0xfa/0x2f60
 ? __pfx___lock_acquire+0x10/0x10
 ? __pfx_mark_lock.part.0+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_rtnl_newlink+0x10/0x10
 rtnetlink_rcv_msg+0x71c/0xc10
 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 ? check_chain_key+0x1c1/0x520
 ? __pfx___lock_acquire+0x10/0x10
 netlink_rcv_skb+0x12c/0x360
 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 ? __pfx_netlink_rcv_skb+0x10/0x10
 ? netlink_deliver_tap+0xcb/0x9e0
 ? netlink_deliver_tap+0x14b/0x9e0
 netlink_unicast+0x447/0x710
 ? __pfx_netlink_unicast+0x10/0x10
 netlink_sendmsg+0x712/0xbc0
 ? __pfx_netlink_sendmsg+0x10/0x10
 ? _copy_from_user+0x3e/0xa0
 ____sys_sendmsg+0x7ab/0xa10
 ? __pfx_____sys_sendmsg+0x10/0x10
 ? __pfx_copy_msghdr_from_user+0x10/0x10
 ___sys_sendmsg+0xee/0x170
 ? __pfx___lock_acquire+0x10/0x10
 ? kasan_save_stack+0x20/0x40
 ? __pfx____sys_sendmsg+0x10/0x10
 ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ? kasan_save_stack+0x30/0x40
 ? __pfx_lock_release+0x10/0x10
 ? __might_fault+0xbf/0x170
 __sys_sendmsg+0x105/0x190
 ? __pfx___sys_sendmsg+0x10/0x10
 ? rseq_syscall+0xc3/0x130
 do_syscall_64+0x64/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fd20f92c004
Code: 15 19 6e 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00
00 f3 0f 1e fa 80 3d 45 f0 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d
005
RSP: 002b:00007fff40636e68 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd20f92c004
RDX: 0000000000000000 RSI: 00007fff40636ee0 RDI: 0000000000000003
RBP: 00007fff40636f50 R08: 0000000067d7b7e9 R09: 0000000000000050
R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000067d7b7ea R14: 000055d14b9e4040 R15: 0000000000000000

Thanks a lot!
Taehee Yoo

