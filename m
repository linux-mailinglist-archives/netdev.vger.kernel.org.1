Return-Path: <netdev+bounces-53250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC6D801CCC
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 13:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B981C20952
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF00168C6;
	Sat,  2 Dec 2023 12:52:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403F18C
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:52:43 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sj8rB1mdrzsR4C;
	Sat,  2 Dec 2023 20:48:58 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 2 Dec
 2023 20:52:40 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <willemb@google.com>, <luwei32@huawei.com>, <shaozhengchao@huawei.com>,
	<willemdebruijn.kernel@gmail.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next,v3] ipvlan: implement .parse_protocol hook function in ipvlan_header_ops
Date: Sat, 2 Dec 2023 21:04:38 +0800
Message-ID: <20231202130438.2266343-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected

The .parse_protocol hook function in the ipvlan_header_ops structure is
not implemented. As a result, when the AF_PACKET family is used to send
packets, skb->protocol will be set to 0.
Ipvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
eth_header_parse_protocol function to obtain the protocol.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v3: remove Fixes tag, it fixes nothing
v2: modify commit info and add Fixes tag
---
 drivers/net/ipvlan/ipvlan_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 57c79f5f2991..f28fd7b6b708 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -387,6 +387,7 @@ static const struct header_ops ipvlan_header_ops = {
 	.parse		= eth_header_parse,
 	.cache		= eth_header_cache,
 	.cache_update	= eth_header_cache_update,
+	.parse_protocol	= eth_header_parse_protocol,
 };
 
 static void ipvlan_adjust_mtu(struct ipvl_dev *ipvlan, struct net_device *dev)
-- 
2.34.1


