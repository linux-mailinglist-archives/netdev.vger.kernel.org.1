Return-Path: <netdev+bounces-97486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7288CB9A5
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 05:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB8D1C2146F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46B39AEC;
	Wed, 22 May 2024 03:18:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA896282E5;
	Wed, 22 May 2024 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716347905; cv=none; b=W/xLJ8Bot5kbD4qBeiUO0CX4tAy3ARNBoyFQboESsZ/V880C9a7EbL95cJEHp9hYTWUV3N8lZwtlCI94CbakD5WOA5BwoSP1MK4YUSeGcewUcR/jmj1AD9y8NMHQHQV96XABnkuCg/9yuoOvnqYPi5QAKb4YvKoSQtmqLfybx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716347905; c=relaxed/simple;
	bh=0P6QvCqv65afoN5ksAiwVQghCbYdGDTybP9H+2zq/vk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DvSP1R8sahvQezFW4F0cqH2/IzQ0xzuIV+C8fiHKTJRQdXqIDUwYkrLCfk9g5/UZXoMd8RXdL7n1qVSZkMqD6rcR5psRIws4V/6H+szt8ql0XRr5pxXLgppfAbiUMziqo2rr5lQv2uWCcbhVb9HmPobDuHwhVhZbjclPNi8q0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from gui.. (unknown [115.206.161.197])
	by mail-app4 (Coremail) with SMTP id cS_KCgDHVbNcY01mSWLVAA--.228S4;
	Wed, 22 May 2024 11:15:42 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yuehaibing@huawei.com,
	linma@zju.edu.cn,
	larysa.zaremba@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 net-next] ila: avoid genlmsg_reply when not ila_map found
Date: Wed, 22 May 2024 11:15:37 +0800
Message-Id: <20240522031537.51741-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgDHVbNcY01mSWLVAA--.228S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWxuF15Gw43trW7Zry3CFg_yoWrAr18pa
	45Gr1DGr40qry8XF4xAr1rJryaqFn8AF1UWw4I9r4kAF4UKa4UJr1Utrs8ArnxZFs0vr13
	XasrGF4Fyr15taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/

The current ila_xlat_nl_cmd_get_mapping will call genlmsg_reply even if
not ila_map found with user provided parameters. Then an empty netlink
message will be sent and cause a WARNING like below.

WARNING: CPU: 1 PID: 7709 at include/linux/skbuff.h:2524 __dev_queue_xmit+0x241b/0x3b60 net/core/dev.c:4171
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:skb_assert_len include/linux/skbuff.h:2524 [inline]
RIP: 0010:__dev_queue_xmit+0x241b/0x3b60 net/core/dev.c:4171
RSP: 0018:ffffc9000f90f228 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff816968a8 RDI: fffff52001f21e37
RBP: ffff8881077f2d3a R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff8881077f2c90 R15: ffff8881077f2c80
FS:  00007fb8be338700(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00ca8a000 CR3: 0000000105e17000 CR4: 0000000000150ee0
Call Trace:
 <TASK>
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:307 [inline]
 __netlink_deliver_tap net/netlink/af_netlink.c:325 [inline]
 netlink_deliver_tap+0x9e4/0xc40 net/netlink/af_netlink.c:338
 __netlink_sendskb net/netlink/af_netlink.c:1263 [inline]
 netlink_sendskb net/netlink/af_netlink.c:1272 [inline]
 netlink_unicast+0x6ac/0x7f0 net/netlink/af_netlink.c:1360
 nlmsg_unicast include/net/netlink.h:1067 [inline]
 genlmsg_unicast include/net/genetlink.h:372 [inline]
 genlmsg_reply include/net/genetlink.h:382 [inline]
 ila_xlat_nl_cmd_get_mapping+0x589/0x950 net/ipv6/ila/ila_xlat.c:493
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:756
 genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
 genl_rcv_msg+0x441/0x780 net/netlink/genetlink.c:850
 netlink_rcv_skb+0x153/0x400 net/netlink/af_netlink.c:2540
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:861
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb8bd68f359
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb8be338168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb8bd7bbf80 RCX: 00007fb8bd68f359
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007fb8bd6da498 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc22fb52af R14: 00007fb8be338300 R15: 0000000000022000

Do nullptr check and assign -EINVAL ret if no ila_map found.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/ipv6/ila/ila_xlat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 67e8c9440977..63b8fe1b8255 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -483,6 +483,8 @@ int ila_xlat_nl_cmd_get_mapping(struct sk_buff *skb, struct genl_info *info)
 				    info->snd_portid,
 				    info->snd_seq, 0, msg,
 				    info->genlhdr->cmd);
+	} else {
+		ret = -EINVAL;
 	}
 
 	rcu_read_unlock();
-- 
2.34.1


