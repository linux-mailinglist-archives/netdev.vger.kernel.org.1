Return-Path: <netdev+bounces-53251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA424801CCD
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529302814FF
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646EE168C8;
	Sat,  2 Dec 2023 12:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67420F0
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:55:03 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sj8yV0FBCzvR9X;
	Sat,  2 Dec 2023 20:54:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 2 Dec
 2023 20:55:00 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next,v2] macvlan: implement .parse_protocol hook function in macvlan_hard_header_ops
Date: Sat, 2 Dec 2023 21:06:58 +0800
Message-ID: <20231202130658.2266526-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected

The .parse_protocol hook function in the macvlan_header_ops structure is
not implemented. As a result, when the AF_PACKET family is used to send
packets, skb->protocol will be set to 0.
Macvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
eth_header_parse_protocol function to obtain the protocol.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v2: remove Fixes tag
---
 drivers/net/macvlan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 88dd8a2245b0..a3cc665757e8 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -609,6 +609,7 @@ static const struct header_ops macvlan_hard_header_ops = {
 	.parse		= eth_header_parse,
 	.cache		= eth_header_cache,
 	.cache_update	= eth_header_cache_update,
+	.parse_protocol	= eth_header_parse_protocol,
 };
 
 static int macvlan_open(struct net_device *dev)
-- 
2.34.1


