Return-Path: <netdev+bounces-244447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F092CB7821
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 02:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8DAA301619C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 01:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457226F478;
	Fri, 12 Dec 2025 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MciBeZo6"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B845B26FDB3;
	Fri, 12 Dec 2025 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501620; cv=none; b=u9VXuFfA8FKJYtT47uUM/RaaKZpM4crHYG40iL2ENbUntSY4VeNdc355K00MATQhfejDYhuF0ERBrtHF7/YNcza2qIt0JtJLqXyEDK+rtsXK+gwEIL7gXsZmSPWPgJcWhuMsvXhk0jxQ3vO+sReMtpe4gA359TrjxUJT5/kX9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501620; c=relaxed/simple;
	bh=aczU1JfBLxP2khwCirtNjzBSNECnoRTmttzNtlwxNUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOzyIhLC6AZDy6pHE92WB3fGlz/0SqVbhGKOEtfRATC11+NGympM/7tGwHly04FRydTnxXBrTfvvcIjRS835IFUfesGs65HxpZ/cObrmUtUWV6K7wzFC1YRL9S8TDpvbneB1l8VAgTXj1yZA7JyTN12HCiPpno9XDcZQYIysbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MciBeZo6; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hw8tuactDGjDGNOJ5xlRE25GO/eWacUHzTR/n+O1OCg=;
	b=MciBeZo6do0ynq3ObqEemd+esv2NFLzcEF+2LZu/dqVOW7AWokW4DM+7yLVFQ18+I0H6dFzPz
	c+lPmIfh/2Wy3G7uDbhX8phXNvmJjDrpEheuoM0WAU2CB14rglgWE2MHTGgj0x5n6CGRw86uMBp
	4Hu+WDtQclL+yrKAYNwgjlE=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dSB7M2GxtznTV6;
	Fri, 12 Dec 2025 09:04:31 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id D3A071401F1;
	Fri, 12 Dec 2025 09:06:47 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 12 Dec
 2025 09:06:47 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <chuck.lever@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<brauner@kernel.org>
CC: <kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net v2] net/handshake: Fix null-ptr-deref in handshake_complete()
Date: Fri, 12 Dec 2025 09:27:23 +0800
Message-ID: <20251212012723.4111831-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)

A null pointer dereference in handshake_complete() was observed [1].

When handshake_req_next() return NULL in handshake_nl_accept_doit(),
function handshake_complete() will be called unexpectedly which triggers
this crash. Fix it by goto out_status when req is NULL.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
RIP: 0010:handshake_complete+0x36/0x2b0 net/handshake/request.c:288
Call Trace:
 <TASK>
 handshake_nl_accept_doit+0x32d/0x7e0 net/handshake/netlink.c:129
 genl_family_rcv_msg_doit+0x204/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg+0x436/0x670 net/netlink/genetlink.c:1195
 genl_rcv_msg+0xcc/0x170 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x14c/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x2d/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x878/0xb20 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x897/0xd70 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa39/0xbf0 net/socket.c:2592
 ___sys_sendmsg+0x121/0x1c0 net/socket.c:2646
 __sys_sendmsg+0x155/0x200 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x5f/0x350 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

Fixes: fe67b063f687 ("net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()")
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-tls-handshake/aScekpuOYHRM9uOd@morisot.1015granger.net/T/#m7cfa5c11efc626d77622b2981591197a2acdd65e
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/handshake/netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 1d33a4675a48..b989456fc4c5 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -126,7 +126,8 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 out_complete:
-	handshake_complete(req, -EIO, NULL);
+	if (req)
+		handshake_complete(req, -EIO, NULL);
 out_status:
 	trace_handshake_cmd_accept_err(net, req, NULL, err);
 	return err;
-- 
2.34.1


