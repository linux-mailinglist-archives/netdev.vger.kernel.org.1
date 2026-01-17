Return-Path: <netdev+bounces-250699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5406D38E5F
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 13:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48C46300F73B
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9621019E;
	Sat, 17 Jan 2026 12:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A82C08CB
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768651278; cv=none; b=Zpxj+aMAjtjPwOEIkyUXaCkBNGWdgkXArURlutf45RzHKQI6QvvqSMRuw7vAZxpDS0IFYfiZT2T4O3Lb2GZwf+S5PwKXSNtIOh2YXRZHAccqQuTYvrJwLSo7iUxN6flRUyav6xIEz7uk6wow/y1lc5jlcpYMCnHIJhBRSQ71Mec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768651278; c=relaxed/simple;
	bh=tk9wgp7hkpc/ZUC423QYLJU3G1kUcWR3jB7osyx1O9g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jF/Qv8rr1sMwjJm9k+FvmHL3cUrMx4Kij/ESzS0Qz+YDuRDTFTLbrQVIvvsy7sGSOAU4j6XelBAjNt/b0KuLZbcKjBkS0kiWQNQ20QbzVUBj0yYaQkD/EGVZqSnKWtKf7X/MtK96rGE00dM6IBj1SfJmEHK9HxGErzFcOgj5M9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60HB0Nkj032364;
	Sat, 17 Jan 2026 20:00:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60HB0FJl032297
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 17 Jan 2026 20:00:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c232db28-622d-4dd9-a61f-f12cd0ff39bb@I-love.SAKURA.ne.jp>
Date: Sat, 17 Jan 2026 20:00:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Leon Romanovsky "<leon@kernel.org>" Leon Romanovsky "<leonro@nvidia.com>"
 Shannon Nelson "<shannon.nelson@oracle.com>" Steffen Klassert
 "<steffen.klassert@secunet.com>" Yossef Efraim <yossefe@mellanox.com>
Cc: Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: xfrm: Possible refcount bug in xfrm_dev_state_add() ?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

Just browsing call trace for

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
  ref_tracker: netdev@ffff888052f24618 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
       xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
       xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
       xfrm_add_sa+0x34ff/0x5fa0 net/xfrm/xfrm_user.c:1022
       xfrm_user_rcv_msg+0x58e/0xc00 net/xfrm/xfrm_user.c:3507
       netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
       xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3529
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
       __sys_sendmsg+0x16d/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

problem, I noticed a different-but-possible refcount bug.

Commit 67a63387b141 ("xfrm: Fix negative device refcount on offload failure.")
resets xso->dev to NULL. Commit 50bd870a9e5c ("xfrm: Add ESN support for IPSec
HW offload") also resets xso->dev to NULL. Then, why not commit 585b64f5a620
("xfrm: delay initialization of offload path till its actually requested") also
resets xso->dev to NULL (like shown below) ? (Note that I don't know the
background of these commits...)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29..daa640f1ff9c 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -308,6 +308,7 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	if (!x->type_offload) {
 		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
+		xso->dev = NULL;
 		dev_put(dev);
 		return -EINVAL;
 	}

