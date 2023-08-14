Return-Path: <netdev+bounces-27212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CEB77AF85
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 04:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221D41C2088E
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D6F7E2;
	Mon, 14 Aug 2023 02:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264649469
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 02:30:22 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A81DE6D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 19:30:21 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPJF10S0FztRtX;
	Mon, 14 Aug 2023 10:26:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 10:30:18 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] ethernet: rocker: Use is_broadcast_ether_addr() and is_multicast_ether_addr() instead of ether_addr_equal()
Date: Mon, 14 Aug 2023 10:29:48 +0800
Message-ID: <20230814022948.2019698-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use is_broadcast_ether_addr() and is_multicast_ether_addr() instead of
ether_addr_equal() to check if the ethernet address is broadcast
and multicast address separately.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 826990459fa4..7f389f3adbf4 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -208,7 +208,6 @@ static const u8 zero_mac[ETH_ALEN]   = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 static const u8 ff_mac[ETH_ALEN]     = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 static const u8 ll_mac[ETH_ALEN]     = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
 static const u8 ll_mask[ETH_ALEN]    = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xf0 };
-static const u8 mcast_mac[ETH_ALEN]  = { 0x01, 0x00, 0x00, 0x00, 0x00, 0x00 };
 static const u8 ipv4_mcast[ETH_ALEN] = { 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
 static const u8 ipv4_mask[ETH_ALEN]  = { 0xff, 0xff, 0xff, 0x80, 0x00, 0x00 };
 static const u8 ipv6_mcast[ETH_ALEN] = { 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
@@ -939,7 +938,7 @@ static int ofdpa_flow_tbl_bridge(struct ofdpa_port *ofdpa_port,
 	if (eth_dst_mask) {
 		entry->key.bridge.has_eth_dst_mask = 1;
 		ether_addr_copy(entry->key.bridge.eth_dst_mask, eth_dst_mask);
-		if (!ether_addr_equal(eth_dst_mask, ff_mac))
+		if (!is_broadcast_ether_addr(eth_dst_mask))
 			wild = true;
 	}
 
@@ -1012,7 +1011,7 @@ static int ofdpa_flow_tbl_acl(struct ofdpa_port *ofdpa_port, int flags,
 
 	priority = OFDPA_PRIORITY_ACL_NORMAL;
 	if (eth_dst && eth_dst_mask) {
-		if (ether_addr_equal(eth_dst_mask, mcast_mac))
+		if (is_multicast_ether_addr(eth_dst_mask))
 			priority = OFDPA_PRIORITY_ACL_DFLT;
 		else if (is_link_local_ether_addr(eth_dst))
 			priority = OFDPA_PRIORITY_ACL_CTRL;
-- 
2.34.1


