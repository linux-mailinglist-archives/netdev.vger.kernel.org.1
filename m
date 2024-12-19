Return-Path: <netdev+bounces-153242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E409A9F7533
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8A818860D1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133312163BB;
	Thu, 19 Dec 2024 07:14:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7E148FE8;
	Thu, 19 Dec 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592466; cv=none; b=Uf/hnK2ZZZbknxldoBaLaflxp6IcElooZpdzDAAzIOUKvzWdcopWFrx+x4smC7UGD9lcdk47bImyg6igM4FjpWKH0ciquAouHCYwVyd7E0OfUCmUH2jdSfv5Y4ze8br2BnF7Q/DbBkNP70MkLX8gvfv6Yjwdwx5mh/l2wNkuiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592466; c=relaxed/simple;
	bh=1T+vkj8b5eLtRDN7GMdnAokrDhFqEsi0RdzR3tL8mB4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7K+raV5PjJFdRqYM8HheFZiyayRnmDL7UJOPVXdZZ54eJ1+VBi0XStL14NsW1ASF+01EdkTAFBm4r0BsdjMLjciT/WoFWACm2FlphE1UEj+8H9gLarqjM6Oqs3fWp331vVPnhmZrgywZ+N2Qf70XRMvj1iHBHze2H+cR6lqwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YDMGk6gtlz1JFnJ;
	Thu, 19 Dec 2024 15:13:50 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 849B218001B;
	Thu, 19 Dec 2024 15:14:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Dec
 2024 15:14:00 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<luoxuanqiang@kylinos.cn>, <kuniyu@amazon.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: fix memory leak in tcp_conn_request()
Date: Thu, 19 Dec 2024 15:28:59 +0800
Message-ID: <20241219072859.3783576-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200005.china.huawei.com (7.202.181.32)

If inet_csk_reqsk_queue_hash_add() return false, tcp_conn_request() will
return without free the dst memory, which allocated in af_ops->route_req.

Here is the kmemleak stack:

unreferenced object 0xffff8881198631c0 (size 240):
  comm "softirq", pid 0, jiffies 4299266571 (age 1802.392s)
  hex dump (first 32 bytes):
    00 10 9b 03 81 88 ff ff 80 98 da bc ff ff ff ff  ................
    81 55 18 bb ff ff ff ff 00 00 00 00 00 00 00 00  .U..............
  backtrace:
    [<ffffffffb93e8d4c>] kmem_cache_alloc+0x60c/0xa80
    [<ffffffffba11b4c5>] dst_alloc+0x55/0x250
    [<ffffffffba227bf6>] rt_dst_alloc+0x46/0x1d0
    [<ffffffffba23050a>] __mkroute_output+0x29a/0xa50
    [<ffffffffba23456b>] ip_route_output_key_hash+0x10b/0x240
    [<ffffffffba2346bd>] ip_route_output_flow+0x1d/0x90
    [<ffffffffba254855>] inet_csk_route_req+0x2c5/0x500
    [<ffffffffba26b331>] tcp_conn_request+0x691/0x12c0
    [<ffffffffba27bd08>] tcp_rcv_state_process+0x3c8/0x11b0
    [<ffffffffba2965c6>] tcp_v4_do_rcv+0x156/0x3b0
    [<ffffffffba299c98>] tcp_v4_rcv+0x1cf8/0x1d80
    [<ffffffffba239656>] ip_protocol_deliver_rcu+0xf6/0x360
    [<ffffffffba2399a6>] ip_local_deliver_finish+0xe6/0x1e0
    [<ffffffffba239b8e>] ip_local_deliver+0xee/0x360
    [<ffffffffba239ead>] ip_rcv+0xad/0x2f0
    [<ffffffffba110943>] __netif_receive_skb_one_core+0x123/0x140

Call dst_release() to free the dst memory when
inet_csk_reqsk_queue_hash_add() return false in tcp_conn_request().

Fixes: ff46e3b44219 ("Fix race for duplicate reqsk on identical SYN")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/ipv4/tcp_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5bdf13ac26ef..4811727b8a02 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7328,6 +7328,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 			if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req,
 								    req->timeout))) {
 				reqsk_free(req);
+				dst_release(dst);
 				return 0;
 			}
 
-- 
2.34.1


