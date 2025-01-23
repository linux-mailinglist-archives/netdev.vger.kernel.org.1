Return-Path: <netdev+bounces-160579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F9A1A660
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C778E18898B6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2896211A1F;
	Thu, 23 Jan 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxcFvC4R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4238B
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644278; cv=none; b=hfnbYIuRsHVDYL9MHHOlQBqtstuTujDkUleQN7TDGd8egMwfRNOuoZCLcRzh92fU+GWCYiLR+19D3klQl9+kzNa+5EoQaSQKHA3sU4iIHXO2/TnkfV0tegI7YVqtuUMuGi9CrJE5/E6RUQnVk3qW7HLjiJdfFOY+Wf7poWnUqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644278; c=relaxed/simple;
	bh=ATAXJRBrIEgcIJPPDaa+u7aIkDEjRWjPNdOY+Qm0vXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HegXBbibFm0xMXR1Wi5X38vfwfaVVP7eUwIc5qCWkrNkOIny+oYFmK1g9bFipYluH3h9tPTjSnbIVO71AA25bz2/oBkn4brsqWu2GsGQbvoUyGhMCjUgmZ5hBIjSv5cIqRUbMqEg/BdVWND8lph7ZzKE/EzLQN44XKHvO4TLePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxcFvC4R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737644276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qfns0t1Hb450+zCIUE7wTfbHxCS8JJRbNSUDVykbp2o=;
	b=WxcFvC4RglKWvI8qb6Bfx/UHKmiAtr5jgveGvv/YujCIN0pq+XMgJY5opq/Z6co23WoOa0
	O3qTts3DWL8VkYeLKO/zsvBtL4kKY9eM4KFT1ZaorZ+1K+TJbongaV8JzTopOxgvMDw+DV
	5wa/+Zg6HropJa/Xf3mPrIKk6a33Bpo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-1P0ocR_gOy-5LWuJ7yCdnA-1; Thu, 23 Jan 2025 09:57:54 -0500
X-MC-Unique: 1P0ocR_gOy-5LWuJ7yCdnA-1
X-Mimecast-MFC-AGG-ID: 1P0ocR_gOy-5LWuJ7yCdnA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21632eacb31so13608275ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 06:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644273; x=1738249073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qfns0t1Hb450+zCIUE7wTfbHxCS8JJRbNSUDVykbp2o=;
        b=TlEt6Uc7jIE/KFOPgY0B7T9VcTzEyc8LclisF4jXA7lmUviQzW0Jy4PXWh5uSTxIxg
         q6WdxeRwr2ZRWquD5FvdzH3cV1PGhTg8AKciefzqa+6EuON1BSEaRW/vPswm7U9aoX0a
         Gb5DTB0pSceXbuWHZ53SPXnB7mGm88q8r1lbLAWirpgLDLRUGyNfaj3fKLNVo3N93hL0
         bgdsDNjyR92m6/g/L0bWDLjvFWO6h+3dcK2KPZEBUlyWzbs/+K9f8CE1pHq/jIN4JpaL
         GOAlXk8gVpjbCUuXI1G5L3eooxvV9XWUoNf941svIrI4E22cEnD6SLEOwM1LRiOdLqtt
         wrNw==
X-Gm-Message-State: AOJu0Yzp59Xg39AIatVF/AIGcYa3K6mrSVrUzWFPIRFj2RvfCiZbJvn3
	1PC4BTpMVwX1OEN9ioBbLfjYqt16KJyMokFF/I6NasfKIEZPKNJX3d9M5wkqWlE5+vA5afePq90
	B9KcH0BJKZBAQIrjXbwiaQHN/YfE/eADVFsTtxmyoG2DqE5GDC5laVA==
X-Gm-Gg: ASbGncuQcJUmAfgIkJVFoJ3AHc7pukcShW1yFEuUFwMO1Ef1KTJr/wXTeDOj4OThlv4
	zqSDsr9RYoDBW+JsSEKlgNxLjZQm0vVGHINmLMX+GYO4qwmW3gDeJtdbLUq3RZkVG/OqG4+yUdB
	VBgxJ1iXzUivK2g0J+vWsO2jHu6H7YTPfb5+nULK4mXOVe9bxzaGyl+79JkRPQAbXKYoay/Kpc6
	ApMbnpL21RP960CZrKyC/VyTajHAoRiDGP24mDq5aa0uZjxkDbMyCpILEjiNTDGHefN3q2bnzas
	xkhmEBbOBQChsZYYn/rn0tL/xmd8US6tq8k=
X-Received: by 2002:a17:902:d50c:b0:21a:8dec:e59f with SMTP id d9443c01a7336-21c355c28f0mr330637155ad.39.1737644273657;
        Thu, 23 Jan 2025 06:57:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8QRYP0+ZwUNMJ4N+zzGW8hTmYKyNYS11lIQwX0I5vKDOSiN6na4d2mcrPgaxg4cO2hR8H5Q==
X-Received: by 2002:a17:902:d50c:b0:21a:8dec:e59f with SMTP id d9443c01a7336-21c355c28f0mr330636855ad.39.1737644273320;
        Thu, 23 Jan 2025 06:57:53 -0800 (PST)
Received: from kernel-devel.local (fp6fd8f7a1.knge301.ap.nuro.jp. [111.216.247.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e083csm114811575ad.163.2025.01.23.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 06:57:52 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH net] vxlan: Fix uninit-value in vxlan_vnifilter_dump()
Date: Thu, 23 Jan 2025 23:57:46 +0900
Message-ID: <20250123145746.785768-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an uninit-value access in vxlan_vnifilter_dump() [1].

If the length of the netlink message payload is less than
sizeof(struct tunnel_msg), vxlan_vnifilter_dump() accesses bytes
beyond the message. This can lead to uninit-value access. Fix this by
returning an error in such situations.

[1]
BUG: KMSAN: uninit-value in vxlan_vnifilter_dump+0x328/0x920 drivers/net/vxlan/vxlan_vnifilter.c:422
 vxlan_vnifilter_dump+0x328/0x920 drivers/net/vxlan/vxlan_vnifilter.c:422
 rtnl_dumpit+0xd5/0x2f0 net/core/rtnetlink.c:6786
 netlink_dump+0x93e/0x15f0 net/netlink/af_netlink.c:2317
 __netlink_dump_start+0x716/0xd60 net/netlink/af_netlink.c:2432
 netlink_dump_start include/linux/netlink.h:340 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6815 [inline]
 rtnetlink_rcv_msg+0x1256/0x14a0 net/core/rtnetlink.c:6882
 netlink_rcv_skb+0x467/0x660 net/netlink/af_netlink.c:2542
 rtnetlink_rcv+0x35/0x40 net/core/rtnetlink.c:6944
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xed6/0x1290 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x1092/0x1230 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:726
 ____sys_sendmsg+0x7f4/0xb50 net/socket.c:2583
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2672
 x64_sys_call+0x3878/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4110 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_node_noprof+0x800/0xe80 mm/slub.c:4205
 kmalloc_reserve+0x13b/0x4b0 net/core/skbuff.c:587
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1323 [inline]
 netlink_alloc_large_skb+0xa5/0x280 net/netlink/af_netlink.c:1196
 netlink_sendmsg+0xac9/0x1230 net/netlink/af_netlink.c:1866
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:726
 ____sys_sendmsg+0x7f4/0xb50 net/socket.c:2583
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2672
 x64_sys_call+0x3878/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 30991 Comm: syz.4.10630 Not tainted 6.12.0-10694-gc44daa7e3c73 #29
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index d2023e7131bd..6e6e9f05509a 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -411,6 +411,11 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
 	struct tunnel_msg *tmsg;
 	struct net_device *dev;
 
+	if (cb->nlh->nlmsg_len < nlmsg_msg_size(sizeof(struct tunnel_msg))) {
+		NL_SET_ERR_MSG(cb->extack, "Invalid msg length");
+		return -EINVAL;
+	}
+
 	tmsg = nlmsg_data(cb->nlh);
 
 	if (tmsg->flags & ~TUNNEL_MSG_VALID_USER_FLAGS) {
-- 
2.48.1


