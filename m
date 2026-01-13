Return-Path: <netdev+bounces-249564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB3D1AFC7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8EB73045DE9
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202F35EDA0;
	Tue, 13 Jan 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llCBCvSl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4F35E55E
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331525; cv=none; b=m0oWwKkXTfktzF5rVP5loSuUT5LUyuUMyyZopcvcNnjRxJKRbX4PKPUOx/QNMUMgeYtOW9arRWVtF8AH8DFIEL71Kh5lk95qIceth+CHyaJpAxr7Jnk3sm+Op5KiHY9KN5iQCHbtxYXPuoTVyg5jaeV/dSkzKfg+l4loK/KoS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331525; c=relaxed/simple;
	bh=2MKnYAo1aukRI50r4+V2l8FecngrbNwxlNLMKo1Vtms=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jaA5nH/k+SBgb7zDXLLnAbkLq2bViCDb8X5gCxEr01V9E9YuCRd4p2gR6ZFoFQr7IReqkMrdOSEUdm9yW6uDipPf6ONIr20IruEygY6J+uedhIbBOVUjLssFhEdzgo0eNgRfcjJZqleb6FDDhiPvsWJ75z/6TT0gmVNhB9jtCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llCBCvSl; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88a360b8096so210183706d6.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768331522; x=1768936322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4Hu1zUVnXzmu+Z4JAPQZZvrg3oPtQWEOyoJzS/8eLE=;
        b=llCBCvSlklyZrbeTiZhwqu1VMoqStrYZtlkuqQvR7Br+r8tBlbGosl8PlzAVs49Ndi
         gleewMdRRzUtEA+pTuFYT1/fvs33lhRnWCoNlCK9MKlaQFxjCAAq0xf866PcLSryFd6v
         9xUltnrLG0ZFnzut5E/UAkf0474uKF7tTzoUuHqZz5u36nc2oy5H9Etk2yDsMSxgER2j
         M/T1Onej16RVfRWkSfy4zAxjT5kzTW9T6uKy3BJAKfdJ3iHfuH91ft5qapLNDuOiKTDg
         Bb9Z+UENE0E+WDpBelX62HDtfj4Z3x4eXNSNLSNU5fMPfYt1347fJsu7DXZ2c7J/75fC
         p1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331522; x=1768936322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4Hu1zUVnXzmu+Z4JAPQZZvrg3oPtQWEOyoJzS/8eLE=;
        b=wgmGaz/IQ3D9infBfSAks6kDRSwPrAcDenERlBc+9W0t1gYsynuRYoov8foHVJdAjr
         1JackyFhJ2OBgda25CsEMXFerLO2UwWoyti62O4+SMwINTI8tmei/FBH1f4fnCjrwKQ1
         4xi0TlT+sn/HuUQsF4YbZEbo31VTuC9OTlVS4cACZu9GbuDfrFhN4rXIx7vZYz1WCjl+
         RdJ/jUF7mycUqZqvfk7G7Il6SOldEM/jrtmGngNuxkSOIwUbYShAA7WvGRCTIfgV08xF
         BKBTIu9alEnDz+olThvvLgDe5cSZSm+zVfQOYnLOV7saS+sLXa1oycXdWIuDgCZWvxNP
         JVyg==
X-Forwarded-Encrypted: i=1; AJvYcCVq3FDpnHXmpbmGVL4PPoXRJzpIsupbPPJIyEUlLyYdCK4TB+fdbXJY05af5gZnd3RG8sLTFQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFdP2wllMpENcBbuU0xmEm7gTibzetj38gEBDlIDxcFcbranf
	kVsdWNADSGwG6WQyDDmUCKF9594EemAkSocaOK4QBp7ROs3TO/frCs+yLUSQ2QhwlAaXcVrLYcb
	5VoQ28w4pzLrbNQ==
X-Google-Smtp-Source: AGHT+IGivelngq01nGWJfkI0CQoi9h3OFJnewHYMmHvT2I4KvXr1welPv0q+d1hqXUxgCms9OmpfM32hkp63gQ==
X-Received: from qvboj2.prod.google.com ([2002:a05:6214:4402:b0:88a:2e8e:af6e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2dc6:b0:884:6f86:e08c with SMTP id 6a1803df08f44-8908418883cmr317048786d6.21.1768331522673;
 Tue, 13 Jan 2026 11:12:02 -0800 (PST)
Date: Tue, 13 Jan 2026 19:12:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113191201.3970737-1-edumazet@google.com>
Subject: [PATCH net] bonding: limit BOND_MODE_8023AD to Ethernet devices
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+9c081b17773615f24672@syzkaller.appspotmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"

BOND_MODE_8023AD makes sense for ARPHRD_ETHER only.

syzbot reported:

 BUG: KASAN: global-out-of-bounds in __hw_addr_create net/core/dev_addr_lists.c:63 [inline]
 BUG: KASAN: global-out-of-bounds in __hw_addr_add_ex+0x25d/0x760 net/core/dev_addr_lists.c:118
Read of size 16 at addr ffffffff8bf94040 by task syz.1.3580/19497

CPU: 1 UID: 0 PID: 19497 Comm: syz.1.3580 Tainted: G             L      syzkaller #0 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:378 [inline]
  print_report+0xca/0x240 mm/kasan/report.c:482
  kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
  kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
  __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
  __hw_addr_create net/core/dev_addr_lists.c:63 [inline]
  __hw_addr_add_ex+0x25d/0x760 net/core/dev_addr_lists.c:118
  __dev_mc_add net/core/dev_addr_lists.c:868 [inline]
  dev_mc_add+0xa1/0x120 net/core/dev_addr_lists.c:886
  bond_enslave+0x2b8b/0x3ac0 drivers/net/bonding/bond_main.c:2180
  do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2963
  do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3165
  rtnl_changelink net/core/rtnetlink.c:3776 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
  rtnl_newlink+0x161c/0x1c90 net/core/rtnetlink.c:4072
  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
  netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
  sock_sendmsg_nosec net/socket.c:727 [inline]
  __sock_sendmsg+0x21c/0x270 net/socket.c:742
  ____sys_sendmsg+0x505/0x820 net/socket.c:2592
  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
  __sys_sendmsg+0x164/0x220 net/socket.c:2678
  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
  __do_fast_syscall_32+0x1dc/0x560 arch/x86/entry/syscall_32.c:307
  do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
 </TASK>

The buggy address belongs to the variable:
 lacpdu_mcast_addr+0x0/0x40

Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
Reported-by: syzbot+9c081b17773615f24672@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6966946b.a70a0220.245e30.0002.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/bonding/bond_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3d56339a8a10d97664e6d8cb8b41a681e6e9efc5..0aca6c937297def91d5740dfd456800432b5e343 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1862,6 +1862,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	 */
 	if (!bond_has_slaves(bond)) {
 		if (bond_dev->type != slave_dev->type) {
+			if (slave_dev->type != ARPHRD_ETHER &&
+			    BOND_MODE(bond) == BOND_MODE_8023AD) {
+				SLAVE_NL_ERR(bond_dev, slave_dev, extack,
+					     "8023AD mode requires Ethernet devices");
+				return -EINVAL;
+			}
 			slave_dbg(bond_dev, slave_dev, "change device type from %d to %d\n",
 				  bond_dev->type, slave_dev->type);
 
-- 
2.52.0.457.g6b5491de43-goog


