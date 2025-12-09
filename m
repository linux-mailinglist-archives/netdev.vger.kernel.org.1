Return-Path: <netdev+bounces-244106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A9CAFCAE
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453A13030DB0
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0812D3EDF;
	Tue,  9 Dec 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JiPcUjo4"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006602D738B;
	Tue,  9 Dec 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765280300; cv=none; b=OKZ+ZuWwEWuCFtKfM1DgM9l8yhgglWj4/pBlcohlny955oumFv0U+VtWL703zoBIbTA2/Tcxe5Ay/9Jc9XHqpgvkBrQF7Xdfi8PpBJIkqPTEeh+YSKTVa/lCBlPEAS5PLfuAf2+mrK2qBrorxXknpYFJzgsmoXUpPwVAvCqMNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765280300; c=relaxed/simple;
	bh=tWrBG8HAv0xv5TTDtzEEhPMb5d2qvR5a95M0Ni6dfvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vDP6vm8d5MR/tOJvOhPfqO6Ipmoc1v7U3xhDsqZ/oKrGWWiBSQtZ3UhKTf13KrPqs2auTL3bi2HWtPxtse0Xqif2rAjwRfTkXT3KTZ9WDrEXubQAs7ZaJn/tG06umzWNjue6lkDF1tJLvrJIe+Nyxbs/ERG1YxVhDqk35+f3564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JiPcUjo4; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XSAMW90pfyJ5RaZXgdjgyCtrW3u7NkuwZweC/h83jIk=;
	b=JiPcUjo4XSCIlajYQL9o0wr7Ve3qQNxypagTYPO4cAjdTvk/yeaFZEVUaBFLL9FctNDAccxOj
	+L4kcJYPHGmubSYSJjsUisB8Dtv6K9yjDBsJCmDopNLBYoy/nhf/ZyFFVw3qZwsKOb3zYMLVy+A
	nw6LLnRvGNMRBHNN3u3Tpo4=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dQcHd61rhzRhRm;
	Tue,  9 Dec 2025 19:36:13 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id EA8E514034D;
	Tue,  9 Dec 2025 19:38:09 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Dec
 2025 19:38:09 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <chuck.lever@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<brauner@kernel.org>
CC: <kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net] net/handshake: Fix null-ptr-deref in handshake_complete()
Date: Tue, 9 Dec 2025 19:58:52 +0800
Message-ID: <20251209115852.3827876-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/handshake/netlink.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 1d33a4675a48..cdaea8b8d004 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -106,25 +106,26 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = -EAGAIN;
 	req = handshake_req_next(hn, class);
-	if (req) {
-		sock = req->hr_sk->sk_socket;
-
-		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
-		if (fdf.err) {
-			err = fdf.err;
-			goto out_complete;
-		}
-
-		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
-		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
-		if (err)
-			goto out_complete; /* Automatic cleanup handles fput */
-
-		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
-		fd_publish(fdf);
-		return 0;
+	if (!req)
+		goto out_status;
+
+	sock = req->hr_sk->sk_socket;
+
+	FD_PREPARE(fdf, O_CLOEXEC, sock->file);
+	if (fdf.err) {
+		err = fdf.err;
+		goto out_complete;
 	}
 
+	get_file(sock->file); /* FD_PREPARE() consumes a reference. */
+	err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
+	if (err)
+		goto out_complete; /* Automatic cleanup handles fput */
+
+	trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
+	fd_publish(fdf);
+	return 0;
+
 out_complete:
 	handshake_complete(req, -EIO, NULL);
 out_status:
-- 
2.34.1


