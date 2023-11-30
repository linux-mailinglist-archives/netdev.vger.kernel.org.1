Return-Path: <netdev+bounces-52340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBFC7FE769
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 03:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA51E2817BE
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798DBF50C;
	Thu, 30 Nov 2023 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0DCA
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 18:50:24 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sggdn0wJ7zvR99;
	Thu, 30 Nov 2023 10:49:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 10:50:21 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <fw@strlen.de>, <luwei32@huawei.com>, <shaozhengchao@huawei.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] ipvlan: implemente .parse_protocol hook function in ipvlan_header_ops
Date: Thu, 30 Nov 2023 11:02:25 +0800
Message-ID: <20231130030225.3571231-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected

The .parse_protocol hook function in the ipvlan_header_ops structure is
not implemented. As a result, when the AF_PACKET family is used to send
packets, skb->protocol will be set to 0.
The IPVLAN device must be of the Ethernet type. Therefore, use
eth_header_parse_protocol function to obtain the protocol.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
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


