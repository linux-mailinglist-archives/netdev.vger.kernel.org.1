Return-Path: <netdev+bounces-101208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2F8FDBFB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124D21F24779
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837D817BD8;
	Thu,  6 Jun 2024 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="OI71k+WW"
X-Original-To: netdev@vger.kernel.org
Received: from rn-mailsvcp-mx-lapp03.apple.com (rn-mailsvcp-mx-lapp03.apple.com [17.179.253.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0C79F6
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.179.253.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635611; cv=none; b=NcYAhkgzv83up4Kg+SSTETh7rJBpuhNMJD5/rQxoyfGMI4C5rJJECAmVmBg/cOcmlFbgQHk6uusiFVMg/7T4+SbH1/L4q5VHyUkGz+lK8fbjzJMqbDH/P2QGdWcGs6QhnWP09vtkPG29N9Lzw67IQHvb56HyETUrLeJ1GGktOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635611; c=relaxed/simple;
	bh=IRJLqhyh1gDa3XgA+IfxCDwGdC6wCcDK1HyhBWWA/1k=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=t0sje3BJdVJjrT5nYoxP8Rqzxd1xPbe5F2Bd/IXzvwwEy0Z/3ldft49JHEdq3MWMPXe01udcWOZxSfODpZtPH67O0aOq1IcZlVavJgV57S8jzAlxyaTpipaZ3dpBBOzJGt1gibp9nBJr43GzrHWhf5vsjtVphix21lWNmmCXsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=OI71k+WW; arc=none smtp.client-ip=17.179.253.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by rn-mailsvcp-mx-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SEM000GITBTTQ10@rn-mailsvcp-mx-lapp03.rno.apple.com>
 for netdev@vger.kernel.org; Wed, 05 Jun 2024 17:00:03 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version : subject
 : to; s=20180706; bh=DZnhjeHDfehigRTdDOx2Dic+f6jXdmx+9z316MgOiOU=;
 b=OI71k+WWcEp7ddN1rQjWGyYMM42mWjB+6faMU99x/d4P0LJ28plaw5EV1zTc+cZ8MPQ9
 yVtRsw4PIupTq1q80DfDtdRpvBuoHfzNJx258glzRHGtt+x14ZASxoImIdDgCeC8847u
 vUN73DRaaWhXnrXnMxtxI+TmRqPVtQJiOsFrsPdVmJI7VrVd6C7kYS/Lr7Z1XXsLkxER
 3QYW+uox4BoZ9VUOQGMCx8kzXsgrHmDzgTHaX2V8fLwMjBcEqTmrzPN3UwlsCOdriRWv
 ItPgwCnv+I/GXkPXD0TjErQ6fAn3bF6jZjKnXTVFbLso20BIQ0uByfXi3nCqTQrSdFuB mQ==
Received: from mr55p01nt-mmpp04.apple.com
 (mr55p01nt-mmpp04.apple.com [10.170.185.204])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SEM002A2TBZ9VU0@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Wed, 05 Jun 2024 16:59:59 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp04.apple.com by
 mr55p01nt-mmpp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SEM0AC00SYTJS00@mr55p01nt-mmpp04.apple.com>; Wed,
 05 Jun 2024 23:59:59 +0000 (GMT)
X-Va-A:
X-Va-T-CD: 5c1d590bbb3e9640019563b4ec412a7e
X-Va-E-CD: c925dc3801666250965ce69d6e85441c
X-Va-R-CD: e5c7bea4c2914ad505fe915864724212
X-Va-ID: 351fd445-1e1b-4b2b-b451-607833f739f7
X-Va-CD: 0
X-V-A:
X-V-T-CD: 5c1d590bbb3e9640019563b4ec412a7e
X-V-E-CD: c925dc3801666250965ce69d6e85441c
X-V-R-CD: e5c7bea4c2914ad505fe915864724212
X-V-ID: 750d89c4-e558-4ccc-93b5-0c9e2abdb6ae
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
Received: from mr41p01nt-relayp04.apple.com ([17.233.30.20])
 by mr55p01nt-mmpp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SEM0AL28TBY8Z00@mr55p01nt-mmpp04.apple.com>; Wed,
 05 Jun 2024 23:59:59 +0000 (GMT)
From: Christoph Paasch <cpaasch@apple.com>
To: netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH net] net: Don't warn on ENOMEM in __dev_change_net_namespace
Date: Wed, 05 Jun 2024 16:59:52 -0700
Message-id: <20240605235952.21320-1-cpaasch@apple.com>
X-Mailer: git-send-email 2.39.4 (Apple Git-150.1)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit

syzkaller found a WARN in __dev_change_net_namespace when
device_rename() returns ENOMEM:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6395 at net/core/dev.c:11430 __dev_change_net_namespace+0xba7/0xbf0
Modules linked in:
CPU: 1 PID: 6395 Comm: syz-executor.1 Not tainted 6.9.0-g4eea1d874bbf #66
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:__dev_change_net_namespace+0xba7/0xbf0 net/core/dev.c:11430
Code: 05 d6 72 34 01 01 48 c7 c7 ea e8 c4 82 48 c7 c6 21 d2 cb 82 ba bf 07 00 00 e8 25 cc 39 ff 0f 0b e9 5b f8 ff ff e8 c9 b3 4f ff <0f> 0b e9 ca fc ff ff e8 bd b3 4f ff 0f 0b e9 5f fe ff ff e8 b1 b3
RSP: 0018:ffffc90000d1f410 EFLAGS: 00010293
RAX: ffffffff81d1d487 RBX: ffff8881213b5000 RCX: ffff888115f9adc0
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc90000d1f4e0 R08: ffffffff81d1d14a R09: 205d393032343136
R10: 3e4b5341542f3c20 R11: ffffffff81a40d20 R12: ffff88811f57af40
R13: 0000000000000000 R14: 00000000fffffff4 R15: ffff8881213b5000
FS:  00007fc93618e640(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000468d90 CR3: 0000000126252003 CR4: 0000000000170ef0
Call Trace:
 <TASK>
 do_setlink+0x154/0x1c70 net/core/rtnetlink.c:2805
 __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
 rtnl_newlink+0xe60/0x1210 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x689/0x720 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0xea/0x1c0 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x430/0x500 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x43d/0x540 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xa4/0xd0 net/socket.c:745
 ____sys_sendmsg+0x22a/0x320 net/socket.c:2585
 ___sys_sendmsg+0x143/0x190 net/socket.c:2639
 __sys_sendmsg net/socket.c:2668 [inline]
 __do_sys_sendmsg net/socket.c:2677 [inline]
 __se_sys_sendmsg net/socket.c:2675 [inline]
 __x64_sys_sendmsg+0xd8/0x150 net/socket.c:2675
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0xf0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fc936e686a9

The WARN is there because device_rename() is indeed not meant to
fail in __dev_change_net_namespace(), except for the case where
it can't allocated memory.

So, let's special-case the scenario where err == ENOMEM to silence the
warning.

AFAICS, this has been there since the initial implementation.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Fixes: ce286d327341 ("[NET]: Implement network device movement between namespaces")
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4d4de9008f6f..ba0c9f705ddb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11428,7 +11428,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_set_uevent_suppress(&dev->dev, 1);
 	err = device_rename(&dev->dev, dev->name);
 	dev_set_uevent_suppress(&dev->dev, 0);
-	WARN_ON(err);
+	WARN_ON(err && err != -ENOMEM);
 
 	/* Send a netdev-add uevent to the new namespace */
 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
-- 
2.39.4 (Apple Git-150.1)


