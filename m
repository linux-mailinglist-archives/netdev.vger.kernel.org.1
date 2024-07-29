Return-Path: <netdev+bounces-113748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C693FB58
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9183D1F2266B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF115EFCD;
	Mon, 29 Jul 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6WDZqiz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AD147C79;
	Mon, 29 Jul 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270881; cv=none; b=ZaHFhN7orpt/nQS210sdemQwimrC4RC8ILokLkw1pzdT0VN2w7BLhrN8S8jHyyW3RLOCDbmpiLiJ5MLduqQlUrzMuo+K23YRSo3LtMPUDvm/VfQA4TkH12GVYVls1ouJ6g/O/SC4eY+sHtRH7Eqb29H9zOhE6gFG3E0DeibG/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270881; c=relaxed/simple;
	bh=SPs/h4eDA0EqXISGqYB8Y4wvV05LZy9STRUwWyLtH4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QyFDJHI/rpGkeSexWqY8UApJkpI7a0c7ullg5QChlw3NuRii1jGIwQ29fX6p/oPMGeWxGHvh73f9G1vLkol6qbrvxiJmDcRhIu3qZbTElfQI4z2Ch57LQVRLFYUMOpgRtJNH5u5UciSOju5jnKMV8BuD8tRMinuqHH9nFMDwftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6WDZqiz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d19c525b5so2162748b3a.2;
        Mon, 29 Jul 2024 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722270879; x=1722875679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S07/vuCHhHfjsPowJ43obkMU9EzXlqdaIB8+Pgcbn/I=;
        b=W6WDZqizg8pNRdUDwz33/72hMYyxePhOV8Z96vDBtSMI5id+5Mv+1ekh6VOmifRf5Y
         SM9QpYr4+hVw5cAh2KQDpm+54MPwayXzD4cUgfIZ4ogpj3JLi9LgZeoUeyL/3CP8pwft
         qY+2hF5ZbiExyIgJpSyZ+FRWsSlIvjDwc6kSmnp3QCKSrjlY2vSYJmuf3j6FcCjJZU+n
         3qhBidOCG0BxcnOS3G04KC6ZvUG4GkzxmS5XQmUh37Da+R6oqG1gMyicKGOjMxt4Lesg
         NlySAF0di3FXPRfkbXre1UNXL+bd5f/Sa7DxX5OnwKaKkGpaglWMYwen83kuZRzQCq5R
         vYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722270879; x=1722875679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S07/vuCHhHfjsPowJ43obkMU9EzXlqdaIB8+Pgcbn/I=;
        b=XXBW2zIM2rNMgxVfQdfIbRjuOxFgCkklHy/IaE6NJt+clrKeWggJmOj4T22W5d8Kat
         yiRx9wTC55BuSqr1t/6/Qy+61+z4lv/HoqnmoV0U7HZ7jATUfONE9ecY2SsWDqZ88Vtl
         O43f0W7vyu6pnFJmfUkqDWyhvW8FgDgo8fM2JO7jiYE08tmboEXhFawOIaGh1lfQKYIs
         S4Ypn8LB/BZrM30kXX4QpCfI8PDueZ9RXUMnDV4o6dRatcDp95eEZaH/GE+bXtqQAwvD
         k/o5L1QdQLtvBgXZLtmDdBj/yasdOYo2gUhNWWAKqkf8gbTVJ0RO81V6ywRnhXAzrpVo
         RsEA==
X-Forwarded-Encrypted: i=1; AJvYcCV7R7LJaRUGQ2zNk/jUJ8qMZsi4ntHd63zO0maXTBNLlpTumpLMKgx5XujIzK2+jfzn+4VK25K6xo7U9FKA4VrCv008obMtN0DwfP8ea9eHD77QkeGBD1+BvaImg8DDm/Cm34x3
X-Gm-Message-State: AOJu0Yy9rKw0aEcqd1vgjeMbFxs+ZPv1i0J7H3Fx0aLjoECZG4ZpmEfd
	2PxUG/5Oeti3dfbmjQo79tkoLbRTnJwzjGPkQabIEdiKRj3E1xip
X-Google-Smtp-Source: AGHT+IE5T5nz1QWQcuPThyUGTKSVkvdf/XAPrJNR6sUEIiHMKVbJBo3TT0s+7/45q5vio83o+BKZ7A==
X-Received: by 2002:a05:6a00:9141:b0:70d:2583:7227 with SMTP id d2e1a72fcca58-70ece9eba1emr6185215b3a.6.1722270879131;
        Mon, 29 Jul 2024 09:34:39 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874bf5sm6978055b3a.162.2024.07.29.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:34:38 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] net: annotate data race around dev->flags in __dev_change_flags
Date: Tue, 30 Jul 2024 01:33:26 +0900
Message-Id: <20240729163326.16386-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to KCSAN report, there is a read/write race between 
__dev_change_flags and netif_is_bond_master for dev->flags.

Thereforce, __dev_change_flags() needs protection.

<syzbot>
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

Reported-by: syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/core/dev.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..3b9626cdfd9a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8799,7 +8799,7 @@ EXPORT_SYMBOL(dev_get_flags);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
 		       struct netlink_ext_ack *extack)
 {
-	unsigned int old_flags = dev->flags;
+	unsigned int old_flags = READ_ONCE(dev->flags);
 	int ret;
 
 	ASSERT_RTNL();
@@ -8808,12 +8808,13 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 	 *	Set the flags on our device.
 	 */
 
-	dev->flags = (flags & (IFF_DEBUG | IFF_NOTRAILERS | IFF_NOARP |
-			       IFF_DYNAMIC | IFF_MULTICAST | IFF_PORTSEL |
-			       IFF_AUTOMEDIA)) |
-		     (dev->flags & (IFF_UP | IFF_VOLATILE | IFF_PROMISC |
-				    IFF_ALLMULTI));
+	unsigned int new_flags = (flags & (IFF_DEBUG | IFF_NOTRAILERS | IFF_NOARP |
+			                   IFF_DYNAMIC | IFF_MULTICAST | IFF_PORTSEL |
+			                   IFF_AUTOMEDIA)) |
+		                 (READ_ONCE(dev->flags) & (IFF_UP | IFF_VOLATILE | IFF_PROMISC |
+				                IFF_ALLMULTI));
 
+	WRITE_ONCE(dev->flags, new_flags);
 	/*
 	 *	Load in the correct multicast list now the flags have changed.
 	 */
@@ -8839,12 +8840,12 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 
 	if ((flags ^ dev->gflags) & IFF_PROMISC) {
 		int inc = (flags & IFF_PROMISC) ? 1 : -1;
-		unsigned int old_flags = dev->flags;
+		unsigned int old_flags = READ_ONCE(dev->flags);
 
 		dev->gflags ^= IFF_PROMISC;
 
 		if (__dev_set_promiscuity(dev, inc, false) >= 0)
-			if (dev->flags != old_flags)
+			if (READ_ONCE(dev->flags) != old_flags)
 				dev_set_rx_mode(dev);
 	}
 
--

