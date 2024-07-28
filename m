Return-Path: <netdev+bounces-113436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A993E4A7
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 12:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122F21C20B98
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DB23399B;
	Sun, 28 Jul 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPe2UObM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F08BE7;
	Sun, 28 Jul 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722164144; cv=none; b=APYj5DW0SjbJxUCpt7kBrsGlcK1hI6bVLuDpp6jorASnIkr+EM+bQNYNkdhW4PZ/+WkGFEmWN02udngRakNTSHueCn/mD19pzgXTXaYG1cvQW0DdfCjPZIt3l43pntVtVfzDBDler9o/S3cFu71fKnzwzNTbPWhJGGj4YTGeHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722164144; c=relaxed/simple;
	bh=AO3ANZGwYlvPW60ri3QboTRjAJTqnJc/8tMPlmXUxz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8KtKAZ2F7M8uqtGo9zoRqWB+xAIhEq2RvjV4rjvAY8YYzvrI2iDTUirVWFN4ZNPCTRUj3TIQSwfPfCOPejv01+AkjX/MvevUcSlxiCdBS9fbMRw5HYbzNOucKbuGMQvMgRy504CbngaOk36k2Os1ZclHJsRl0WnxCcjrZay+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPe2UObM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc5549788eso16544575ad.1;
        Sun, 28 Jul 2024 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722164142; x=1722768942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqWBgWElavqY7wtWZRfzFWrTNHwzIbu4PnT54eW9R3E=;
        b=aPe2UObMmvWB8IK5SFcf3WxE2VZs7JtUUvP6lFMvKSTa5FMDN6t1DWyfVbitCQwdzW
         LkjMEDzpi+PcOcGRPTQgp4PPkwlxKU85t6p/dbdNCt0QzO7y6I4voZ9DZA2UfK9SNuu5
         tIV6DVupxEzzpin0JkTg0sq5+6zzCfbJQXugFs5N6/EOjLRAGyy6lyXRHtZTOtJEjPNr
         OwcC20cR0R5y+lo6Q5iZChsF/VBtxl3Gncyw6EoY+PjogrxvuBkbjwNLtF6PIf0ckV4j
         bCnsvxdhpHgfEp3hwzmx+GWKdHnGRX0+wgR5KkNpLfOAbuYh9R2NTxOT/s74Uo57aWlG
         l1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722164142; x=1722768942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqWBgWElavqY7wtWZRfzFWrTNHwzIbu4PnT54eW9R3E=;
        b=xBQrKO8/NbybFwi4Rprpgrxs1GttwmFjWtHvuuCmPCSuphHSM6R+l36LtG1qsoGqeW
         t78dngMJc6tOEPckEwZs1cFdxi6yzdt8q9ax0ozwQRLLGbaHpAUohGv3R7N78SFUS/0n
         AGJ/bwVPNdg6d/xpB5GGC3Cya0GX/um3wLBF+ZZu7wxzTGKiPEsalkHihUAXCV4uqv7O
         0XzJvTrBSVhk8Z9up9x3yDAsV5GTd0WC8gq0wPazT8t0dAdd4wa9JAUKeMSgUEo5nPsA
         +9s+ZPJXv3G4g9+nJWHmGlBnOfss8/GKQwcMRzfwOmllaSPSgDqP3DIGnxQd2j74Tel5
         69Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUF8rGnB87/6A5S6osmShGCQQ/m8gWs+kLWbyEJ6Osuo4bEby2rexKIr9HeKJfAyFTILo6/p0KUUD/WL74AXAMhoscTTX+p/EEk7Z1G4kiQFNPT8e3YHxVf3lVtQya/wc/lfu0F
X-Gm-Message-State: AOJu0YwVoPcSjKxao/iknze+mXbabQPT7KoIYyMsnqKQNIXl7KMy20AS
	gTVoupltavAo960QFcHqYvcYn0cDCvusegj4YVFJTp3SlITWzxXh
X-Google-Smtp-Source: AGHT+IGzXuZ1BhxG7GGEAUuxZTP2VXBnxlPfrBkK95JR+XYXeZjfoWa8Spn8JHu0gzaNoQrbpl1b7g==
X-Received: by 2002:a17:903:32d1:b0:1f8:5a64:b468 with SMTP id d9443c01a7336-1ff048a0510mr69511105ad.47.1722164141677;
        Sun, 28 Jul 2024 03:55:41 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm62775345ad.205.2024.07.28.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 03:55:41 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: razor@blackwall.org,
	agospoda@redhat.com,
	syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] net: Fix data race around dev->flags in netif_is_bond_master
Date: Sun, 28 Jul 2024 19:54:29 +0900
Message-Id: <20240728105429.2223-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000e9f499061c6d4d7a@google.com>
References: <000000000000e9f499061c6d4d7a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BUG: KCSAN: data-race in __dev_change_flags / is_upper_ndev_bond_master_filter

read-write to 0xffff888112d970b0 of 4 bytes by task 4888 on cpu 0:
 __dev_change_flags+0x9a/0x410 net/core/dev.c:8755
 rtnl_configure_link net/core/rtnetlink.c:3321 [inline]
 rtnl_newlink_create net/core/rtnetlink.c:3518 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x121e/0x1690 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x85e/0x910 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x12c/0x230 net/netlink/af_netlink.c:2564
 rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:6653
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x58d/0x660 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x5ca/0x6e0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x140/0x180 net/socket.c:745
 ____sys_sendmsg+0x312/0x410 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x1e9/0x280 net/socket.c:2668
 __do_sys_sendmsg net/socket.c:2677 [inline]
 __se_sys_sendmsg net/socket.c:2675 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2675
 x64_sys_call+0xb25/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888112d970b0 of 4 bytes by task 11 on cpu 1:
 netif_is_bond_master include/linux/netdevice.h:5020 [inline]
 is_upper_ndev_bond_master_filter+0x2b/0xb0 drivers/infiniband/core/roce_gid_mgmt.c:275
 ib_enum_roce_netdev+0x124/0x1d0 drivers/infiniband/core/device.c:2310
 ib_enum_all_roce_netdevs+0x8a/0x100 drivers/infiniband/core/device.c:2337
 netdevice_event_work_handler+0x15b/0x3c0 drivers/infiniband/core/roce_gid_mgmt.c:626
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3329
 worker_thread+0x526/0x720 kernel/workqueue.c:3409
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x00001002 -> 0x00000202

According to KCSAN report, there is a read/write race between 
__dev_change_flags and netif_is_bond_master for dev->flags. Therefore, 
should change to use READ_ONCE() when reading dev->flags.

Reported-by: syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com
Fixes: 8a7fbfab4be3 ("netxen: write IP address to firmware when using bonding")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 607009150b5f..5c95d7925b3f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5043,7 +5043,7 @@ static inline bool netif_is_macvlan_port(const struct net_device *dev)
 
 static inline bool netif_is_bond_master(const struct net_device *dev)
 {
-	return dev->flags & IFF_MASTER && dev->priv_flags & IFF_BONDING;
+	return READ_ONCE(dev->flags) & IFF_MASTER && dev->priv_flags & IFF_BONDING;
 }
 
 static inline bool netif_is_bond_slave(const struct net_device *dev)
--

