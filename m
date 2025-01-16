Return-Path: <netdev+bounces-158820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E545FA1367B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099DF1631BD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671C5197A7F;
	Thu, 16 Jan 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4DJGlls"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424174A05
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019323; cv=none; b=SeowG4q8thPw+ezBj7TjfkoVgvfi7gJNKUSx2/O6SvPKnrabFzgb9AsqGzgVVRbCPi/bs9zEFdMdmmqjq1hIhX1+sjQxTEmQvR5SFmqQoiG/RED+MV6rT8UhpvhAicQZlmFF4YyOQOon52tIluhWo9rpR7uv6aOtKxTjKUC00+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019323; c=relaxed/simple;
	bh=uAoR75IBxXh6YxXbMUBnbBW+8+cEJgdCOO8ezgpAFwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFklOSjiuXKDjGfd1x3AZ8cSEB3HCyr955iEbtf3I9TYZEFAAVl1dV9EVe18fMGQGc6EBVtwrpxHGrzAkzSdqjfyOzsoN8n0q5DlgWJnSYHpAki8tpIurKD0WL9XFL1z3hB92J65NPJcz7OC+GA86JJcjFimcEv3rnQ5kUtcKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4DJGlls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE2BC4CED6;
	Thu, 16 Jan 2025 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737019322;
	bh=uAoR75IBxXh6YxXbMUBnbBW+8+cEJgdCOO8ezgpAFwI=;
	h=From:To:Cc:Subject:Date:From;
	b=k4DJGlls8L0Vm6b+nZOtJaLJHB98vJGv4Ol4ePaiLUAfranhH7m9aYlAefGa516Fm
	 CoM8zH+Z8VEq0VJHuyMy54RpH9OOTJrmDkKq87f4MSEMNOuzpdBzsrEYNaCEaBio0p
	 KGvlTVYQHH4YIpbyQ1c1e36Ha6rgURqBiHeqN8q2Irw1pKM8AhiWCg8Ic89EuQ21Ed
	 h9rxwQJAzf2GYCbuyrkFwaKfV/CH2SAqjmbqm9dXjIjcinzbGFUSfEEx8kqrvRttiT
	 UcEL0lM3mcrVEExQCD3qVscV9USZx0OkdlKqdQEzHxpv/E88Y0WAodn7QZhYoESj+3
	 Txdn1pWbwrjqg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	ecree.xilinx@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v2] net: avoid race between device unregistration and ethnl ops
Date: Thu, 16 Jan 2025 10:21:57 +0100
Message-ID: <20250116092159.50890-1-atenart@kernel.org>
X-Mailer: git-send-email 2.48.0
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

This is because unregister_netdevice_many_notify might run before the
rtnl lock section of ethnl operations, eg. set_channels in the above
example. In this example the rss lock would be destroyed by the device
unregistration path before being used again, but in general running
ethnl operations while dismantle has started is not a good idea.

Fix this by denying any operation on devices being unregistered. A check
was already there in ethnl_ops_begin, but not wide enough.

Note that the same issue cannot be seen on the ioctl version
(__dev_ethtool) because the device reference is retrieved from within
the rtnl lock section there. Once dismantle started, the net device is
unlisted and no reference will be found.

Fixes: dde91ccfa25f ("ethtool: do not perform operations on net devices being unregistered")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ethtool/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e3f0ef6b851b..4d18dc29b304 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
 		pm_runtime_get_sync(dev->dev.parent);
 
 	if (!netif_device_present(dev) ||
-	    dev->reg_state == NETREG_UNREGISTERING) {
+	    dev->reg_state >= NETREG_UNREGISTERING) {
 		ret = -ENODEV;
 		goto err;
 	}
-- 
2.48.0


