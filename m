Return-Path: <netdev+bounces-157809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74CA0BD19
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603313A849D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118B326AC3;
	Mon, 13 Jan 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9tqDRXF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1569240221
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785126; cv=none; b=oXMkeVkd/hcTFFMcNemi7rI57VU+sNwx23twlYIksz2hT1c3myp4vSt3qbFNFkuWcUlEit6faZCN6M5Ctke9k7/k8LyeFVHCSr0we1kzIgsaiv4pbb8c4MjudV1IGOyJH0OdSh73Mv6xZb7knxNpb3/NAxHbk7HJ3NnaLDDt/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785126; c=relaxed/simple;
	bh=HWibHrrl+vafat5BIhWC2GQ7mv9vy4H4FYEH1IlROCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jzs4sUOoURgEYgc+oZzZans7SoAXhRuSvmB4taxUMpphnhfSr/JKKtGyOXe+xCPsRpXgKTS6Gntb+aOXXbWZG2Y7okbMJKM1rFNKwn38CanS0/LRPAObBjJoi4Q5EkJMDt0b7kuR/qtg3VowYDXFVQY+nnlCMFp/HC6SuRudmuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9tqDRXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D61C4CED6;
	Mon, 13 Jan 2025 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736785125;
	bh=HWibHrrl+vafat5BIhWC2GQ7mv9vy4H4FYEH1IlROCo=;
	h=From:To:Cc:Subject:Date:From;
	b=D9tqDRXFcU2WIJ1mYHWAm7Q3uMtGDJYNoYypfJ3bzFrMK/Aq0JUfp4JQ/LrCznTdT
	 t5FTr3NLGR8CSjmZYPBxuAU1ulsbc3mMo7Vc/AEJUgqz+epYm4w3zDEAU3lMn0ihLK
	 ELdKvvPzcl0gSBju/b48sjHEUFstEI7BKfygpdRZ1RiT8pLxWnvm0wnO6l00vVUAfJ
	 6G0IXuD+UqNVs5spXfQJCgkkRx6AAJjWQgZllyO2HTnNm20dSALW9RNvaBXIaDMrBt
	 9ibjaGY1fqHexipnXQrszkzqGut1ST8RnC6pSm/lzlv2UyWydgCz6dFb7r9JT7F9E0
	 OIw5tQyrajoEg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH net] net: avoid race between device unregistration and set_channels
Date: Mon, 13 Jan 2025 17:18:40 +0100
Message-ID: <20250113161842.134350-1-atenart@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following trace can be seen if a device is being unregistered while
its number of channels are being modified.

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  WARNING: CPU: 3 PID: 3754 at kernel/locking/mutex.c:564 __mutex_lock+0xc8a/0x1120
  CPU: 3 UID: 0 PID: 3754 Comm: ethtool Not tainted 6.13.0-rc6+ #771
  RIP: 0010:__mutex_lock+0xc8a/0x1120
  Call Trace:
   <TASK>
   ethtool_check_max_channel+0x1ea/0x880
   ethnl_set_channels+0x3c3/0xb10
   ethnl_default_set_doit+0x306/0x650
   genl_family_rcv_msg_doit+0x1e3/0x2c0
   genl_rcv_msg+0x432/0x6f0
   netlink_rcv_skb+0x13d/0x3b0
   genl_rcv+0x28/0x40
   netlink_unicast+0x42e/0x720
   netlink_sendmsg+0x765/0xc20
   __sys_sendto+0x3ac/0x420
   __x64_sys_sendto+0xe0/0x1c0
   do_syscall_64+0x95/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

This is because unregister_netdevice_many_notify might run before
set_channels (both are under rtnl). When that happens, the rss lock is
being destroyed before being used again. Fix this by destroying the rss
lock in run_todo, outside an rtnl lock section and after all references
to net devices are gone.

Note that allowing to run set_channels after the rtnl section of the
unregistration path should be fine as it still runs before the
destructors (thanks to refcount). This patch does not change that.

Fixes: 87925151191b ("net: ethtool: add a mutex protecting RSS contexts")
Cc: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a9f62f5aeb84..d8491a275e2e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10931,6 +10931,8 @@ void netdev_run_todo(void)
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 
+		mutex_destroy(&dev->ethtool->rss_lock);
+
 		netdev_do_free_pcpu_stats(dev);
 		if (dev->priv_destructor)
 			dev->priv_destructor(dev);
@@ -11566,8 +11568,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		if (dev->netdev_ops->ndo_uninit)
 			dev->netdev_ops->ndo_uninit(dev);
 
-		mutex_destroy(&dev->ethtool->rss_lock);
-
 		net_shaper_flush_netdev(dev);
 
 		if (skb)
-- 
2.47.1


