Return-Path: <netdev+bounces-289402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IORvE6hBDGq4bwUAu9opvQ
	(envelope-from <netdev+bounces-289402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:55:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1010957CF52
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19CC630BEB75
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09300369D4C;
	Tue, 19 May 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYi6q0Ku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422D369D45
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187626; cv=none; b=qhvHifceeeGR6SKKppyGXMVvdU1oEeJTTiyvlIztmxxyksZSg0Hepr7CangAjfNBzVOyuRBZV/HUKBFoF1yyjAiaEl/9sW2HTad0+TM699qs+/urGZjd+Zy76+JrDfUHrBxflSKvrmGwS34NQy+F21jelm/Zs4iR1/rnTEjfnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187626; c=relaxed/simple;
	bh=mO0cTsfurZJRh70+4cjjSUsu5ZmYxVvvAclYwTEmi+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MzWs/t3CxT7EE8YQe6TwR07/KfrHuOd1pTmivpi+h7Vx9Y/AeJh2eJjh2ur9YocBb/3w71lnbh40El6xbsndR769aFGvROLum84FTMDTuB+gRePsQUQs0UooHXag+18jVqUO+3JVYrz7YronghVQ4SjpQVQVh6BIGFd/81HQXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYi6q0Ku; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-83ef8b48f94so2529384b3a.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779187625; x=1779792425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2h2PNmKKKAGDfcHH2hpILyf7BR19TWjTq3xq81PbRc=;
        b=cYi6q0Ku9L0WTgHZ4aQ8ErrZtncvpFHlKVRrKNAYMXYPWeeXYID5edaG2xe6OUcjpH
         T3qRAskFlABw0Ll8hXbTeneFLjGmxb1NHY6/pcoDW1kgUVS6YoF2GgzjCAiNKV+wHdo+
         QEaD0aRuLkAUjygenlkx2nn9V93CLe60c+gZLdqXrfAaTvQPF1ac1iZ5JlZ1kuPXoJwH
         Rtz+w9lpC6Y7X+JzNx8DsjkmSAQmzn1emBtCtBdAw9SZXmR+8DEF2zkUrtM2hCWFuWNZ
         eFYLOMQnYA2ZqId04wOK2Wqa7hNrSLDRgu5ryFvc1qYz5Jn0Szbr8aCXEjb9YE8Sp78v
         VhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187625; x=1779792425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2h2PNmKKKAGDfcHH2hpILyf7BR19TWjTq3xq81PbRc=;
        b=C71WHgZhnB1e2+hk6xrAbx04Y0wuddRF/xRShr0oMH6k2T9++iSOYS9SNEQi/I/Kmw
         53VNklZjXGqCTjMkxCr4IvWzhY/3VwTuKFfNxlNUuEMjdVvL2GewIqC8swlfOsM9ihpv
         bjS0HlDg4xlL4exMjtveV7ZlxZKXlmciTMp1TacSYNwb9BABXOLczARBHFUSmf/Tg9Td
         1TebUCz64zx1LfOJ7UpIxPeMAx6KcPMd0ZriLIGo/p4V08gIdgbmN7qGCnPNr0+FC513
         wCmgWJLh22odOrzXd46PTQ9ns/4ysogzGvI+2G8aRLhx6caoNlDK2+LeO0pB4kafrUIx
         6/HQ==
X-Gm-Message-State: AOJu0YwzD0G88Xj4wpSNlHqI2cDb1gHWvx9fog4LkuNR9d/pLtX+CcLa
	vOqHF00//shoQDePlQCYxyMOIdsfnza1dxOm4/JHUPR5/DpAsoq8gcN3
X-Gm-Gg: Acq92OGfvRCfH4PpjXckN16y4/Pz76Cb1jfNykahLf7cRCmAdbFnb/MVd2016LIs//H
	W4uZVc+4YaSlDEYuv1am6BzBAEh+xmFVObCjiPlAlGogU+n0VJnD0k+MxeROMK+aEw+6pRWWD2G
	2ztljJV99vHLRZDQ6XoIBK0trvSGrxrUWGZyvEQMDnlk1UXsq6IR2EaFWBLzTJRv0c0uzrhS4EP
	42P0NO0D7SuHahAA7TIaGGQ3VyJ2dO1HRYp61sKtjzn+mnPiuuptxfl4SChnMp7QpMOEdMD+fRo
	k7qTfTjVZ6+8m3yCa9UJdvq/Nk0NubMnNqNxWhoEwGFf5mlP1WoBhPZV7lkS+V7n5gY0gkkZK8r
	RBp0u7NRlfC31J4Ba+pcv2WAhQWyUOxLT6bP+CUEO42foLdw0NY4X9GTi1Ekiceba4UDtGbJU7/
	X/FcU498JQDAg/jIOp5GMMb5DgM6tduA4=
X-Received: by 2002:a05:6a00:2d8c:b0:83e:f75d:828d with SMTP id d2e1a72fcca58-83f33cb5e90mr19566890b3a.16.1779187624803;
        Tue, 19 May 2026 03:47:04 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19778c87sm16666168b3a.19.2026.05.19.03.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:47:04 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH v2] netpoll: normalize skb->dev to the netpoll device
Date: Tue, 19 May 2026 18:46:47 +0800
Message-Id: <20260519104647.3517990-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-289402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1010957CF52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__netpoll_send_skb() always transmits through np->dev and queues busy
packets on np->dev->npinfo->txq, but it leaves skb->dev unchanged.
Stacked callers such as DSA and macvlan can reach netpoll with skb->dev
still naming the upper device while np->dev is the lower device that
owns the netpoll state.

If the skb has to be deferred, queue_process() later dequeues it from
the lower device's txq but retries it through skb->dev. That can
re-enter the upper ndo_start_xmit path on an already transformed skb,
and if the upper device disappears before the lower txq drains the
workqueue can dereference a stale skb->dev pointer.

The buggy scenario involves two paths, with each column showing the
order within that path:

path A label: netpoll enqueue path   path B label: upper-device teardown
1. Stacked xmit calls netpoll        1. Teardown unregisters the upper
   with lower np->dev and upper         net_device while lower npinfo
   skb->dev.                            stays alive.
2. __netpoll_send_skb() uses         2. netdev_release() runs for the
   np->dev->npinfo as the txq           upper net_device.
   owner.
3. Busy transmit queues the skb      3. The lower txq still owns the
   on that lower txq with upper         deferred skb.
   skb->dev.
4. queue_process() drains the        4. queue_process() dereferences
   lower txq and reads skb->dev.        that stale upper skb->dev.

Normalize skb->dev to np->dev after loading np->dev from the netpoll
instance, before either the direct transmit path or the fallback enqueue.
This keeps the queued skb in the same device and txq domain as the
netpoll state that owns it.

KASAN report as below:

KASAN slab-use-after-free in queue_process+0x7c/0x480
Workqueue: events queue_process
The buggy address belongs to the object at ffff88810906c000 which belongs
to the cache kmalloc-4k of size 4096
The buggy address is located 168 bytes inside of freed 4096-byte region
[ffff88810906c000, ffff88810906d000)
Read of size 8
Call trace:
  dump_stack_lvl+0x73/0xb0 (?:?)
  print_report+0xd1/0x620 (?:?)
  srso_alias_return_thunk+0x5/0xfbef5 (?:?)
  __virt_addr_valid+0x215/0x420 (?:?)
  kasan_complete_mode_report_info+0x64/0x200 (?:?)
  kasan_report+0xf7/0x130 (?:?)
  queue_process+0x7c/0x480 (net/core/netpoll.c:88)
  kasan_check_range+0x10c/0x1c0 (?:?)
  __kasan_check_read+0x15/0x20 (?:?)
  process_one_work+0x8b7/0x1af0 (kernel/workqueue.c:3200)
  assign_work+0x170/0x3f0 (?:?)
  worker_thread+0x574/0xf10 (?:?)
  _raw_spin_unlock_irqrestore+0x4b/0x60 (?:?)
  trace_hardirqs_on+0x2a/0x180 (?:?)
  kthread+0x2fc/0x3f0 (?:?)
  ret_from_fork+0x58b/0x830 (?:?)
  __switch_to+0x58e/0xe90 (?:?)
  __switch_to_asm+0x39/0x70 (?:?)
  ret_from_fork_asm+0x1a/0x30 (?:?)
Freed by task stack:
  kasan_save_stack+0x3d/0x60 (?:?)
  kasan_save_track+0x18/0x40 (?:?)
  kasan_save_free_info+0x3f/0x60 (?:?)
  __kasan_slab_free+0x48/0x70 (?:?)
  kfree+0x20e/0x4e0 (?:?)
  kvfree+0x31/0x40 (?:?)
  netdev_release+0x71/0x90 (net/core/net-sysfs.c:2227)
  device_release+0xd2/0x250 (?:?)
  kobject_put+0x181/0x4c0 (lib/kobject.c:730)
  netdev_run_todo+0x700/0x1000 (net/core/dev.c:11666)
  rtnl_dellink+0x396/0xc00 (net/core/rtnetlink.c:3558)
  rtnetlink_rcv_msg+0x740/0xc20 (net/core/rtnetlink.c:6897)
  netlink_rcv_skb+0x147/0x3a0 (?:?)
  rtnetlink_rcv+0x19/0x20 (net/core/rtnetlink.c:7021)
  netlink_unicast+0x4d1/0x830 (net/netlink/af_netlink.c:1327)
  netlink_sendmsg+0x840/0xe10 (net/netlink/af_netlink.c:1812)
  ____sys_sendmsg+0x8a7/0xb50 (?:?)
  ___sys_sendmsg+0x104/0x190 (?:?)
  __sys_sendmsg+0x135/0x1d0 (?:?)
  __x64_sys_sendmsg+0x7b/0xc0 (?:?)
  x64_sys_call+0x205c/0x2130 (?:?)
  do_syscall_64+0x115/0x6a0 (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe+0x77/0x7f (?:?)

Fixes: 5de4a473bda4 ("netpoll queue cleanup")
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
v2:
Add the KASAN access, object, and free-side details requested during review.
Add Fixes: 5de4a473bda4 ("netpoll queue cleanup").

 net/core/netpoll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 84faace50ac28..3f4a17fa5713a 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -319,6 +319,8 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	lockdep_assert_irqs_disabled();
 
 	dev = np->dev;
+	/* npinfo->txq belongs to np->dev, so retries must stay bound to it. */
+	skb->dev = dev;
 	rcu_read_lock();
 	npinfo = rcu_dereference_bh(dev->npinfo);
 
-- 
2.43.0


