Return-Path: <netdev+bounces-143324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8A9C2032
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896771C24326
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDA1F4FC4;
	Fri,  8 Nov 2024 15:16:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEE3BBF2;
	Fri,  8 Nov 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078960; cv=none; b=NqxQCWDwsX0tmciSPlDCnjUtsINkTDsLFT75nKni5XTyEq4+x/nQUAi3C/mtA89jYqfqh9no1XtT2V2jssu9D8reKJtYwB9JEMzgI/q6fkn3mWma39FsbOdn2C5H4oiRaiSd+NbRnJf8yHZfDOnsiQiQbM3BveeEK/j1hz4Rlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078960; c=relaxed/simple;
	bh=QGfQlgMdHx/sKHVCjVmoWUa2gOQ4QNTeJSs7AzC1b/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNaDPKgFPYS5lotKMbe7xlly082vZpYLLM9aCwq48EdvUTTrUn9a4xJh7U7/NcURhkCdnAv1I2vc5fqPIKX/GssGEwZoUteyXQnsGIKuuOyW62QhTaG/BTXye3gXF13zjMajqoS4Vbc7aguSQe2mePeR8K3wiL1DQyWppmwG7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8Bo1Us004301;
	Fri, 8 Nov 2024 14:54:26 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42s6g5gq9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 08 Nov 2024 14:54:25 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Nov 2024 06:54:24 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 8 Nov 2024 06:54:21 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <stefan@datenfreihafen.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] mac802154: add a check for slave data list before delete
Date: Fri, 8 Nov 2024 22:54:20 +0800
Message-ID: <20241108145420.2445641-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
References: <672b9f03.050a0220.350062.0276.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 91hp4j1d9HElIMzUHIlD19Q1Jegf0Vlw
X-Authority-Analysis: v=2.4 cv=JoCjr94C c=1 sm=1 tr=0 ts=672e2622 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=2YZDpE0dDemZ_0IDS0YA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 91hp4j1d9HElIMzUHIlD19Q1Jegf0Vlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_12,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=576 spamscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411080124

syzkaller reported a corrupted list in ieee802154_if_remove. [1]

Remove an IEEE 802.15.4 network interface after unregister an IEEE 802.15.4
hardware device from the system.

CPU0					CPU1
====					====
genl_family_rcv_msg_doit		ieee802154_unregister_hw
ieee802154_del_iface			ieee802154_remove_interfaces
rdev_del_virtual_intf_deprecated	list_del(&sdata->list)
ieee802154_if_remove
list_del_rcu

Avoid this issue, by adding slave data state bit SDATA_STATE_LISTDONE, set
SDATA_STATE_LISTDONE when unregistering the hardware from the system, and
add state bit SDATA_STATE_LISTDONE judgment before removing the interface
to delete the list. 

[1]
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6277 Comm: syz-executor157 Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 a1 7e 00 07 90 0f 0b 48 c7 c7 e0 37 60 8c 4c 89 fe e8 8f 7e 00 07 90 0f 0b 48 c7 c7 40 38 60 8c 4c 89 fe e8 7d 7e 00 07 90 <0f> 0b 48 c7 c7 a0 38 60 8c 4c 89 fe e8 6b 7e 00 07 90 0f 0b 48 c7
RSP: 0018:ffffc9000490f3d0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: d211eee56bb28d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88805b278dd8 R08: ffffffff8174a12c R09: 1ffffffff2852f0d
R10: dffffc0000000000 R11: fffffbfff2852f0e R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88805b278cc0
FS:  0000555572f94380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056262e4a3000 CR3: 0000000078496000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 ieee802154_if_remove+0x86/0x1e0 net/mac802154/iface.c:687
 rdev_del_virtual_intf_deprecated net/ieee802154/rdev-ops.h:24 [inline]
 ieee802154_del_iface+0x2c0/0x5c0 net/ieee802154/nl-phy.c:323
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-and-tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 net/mac802154/ieee802154_i.h | 1 +
 net/mac802154/iface.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 08dd521a51a5..6771c0569516 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -101,6 +101,7 @@ enum {
 
 enum ieee802154_sdata_state_bits {
 	SDATA_STATE_RUNNING,
+	SDATA_STATE_LISTDONE,
 };
 
 /* Slave interface definition.
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..aed2fc63395d 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -683,6 +683,9 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
 
+	if (test_bit(SDATA_STATE_LISTDONE, &sdata->state))
+		return;
+
 	mutex_lock(&sdata->local->iflist_mtx);
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
@@ -698,6 +701,7 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
 		list_del(&sdata->list);
+		set_bit(SDATA_STATE_LISTDONE, &sdata->state);
 
 		unregister_netdevice(sdata->dev);
 	}
-- 
2.43.0


