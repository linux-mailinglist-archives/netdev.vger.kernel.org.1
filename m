Return-Path: <netdev+bounces-26226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B8777383
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C9E1C210CF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0843B1DDFF;
	Thu, 10 Aug 2023 08:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B1186C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:57:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7289211E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:57:07 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM13070VyzTmMF;
	Thu, 10 Aug 2023 16:55:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:57:04 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <razor@blackwall.org>,
	<jbenc@redhat.com>, <gavinl@nvidia.com>, <wsa+renesas@sang-engineering.com>,
	<vladimir@nikishkin.pw>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/2] net: macsec: Use helper functions to update stats
Date: Thu, 10 Aug 2023 16:56:41 +0800
Message-ID: <20230810085642.3781460-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810085642.3781460-1-lizetao1@huawei.com>
References: <20230810085642.3781460-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the helper functions dev_sw_netstats_rx_add() and
dev_sw_netstats_tx_add() to update stats, which helps to
provide code readability.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/macsec.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 144ec756c796..ae60817ec5c2 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -518,14 +518,8 @@ static void macsec_count_tx(struct sk_buff *skb, struct macsec_tx_sc *tx_sc,
 
 static void count_tx(struct net_device *dev, int ret, int len)
 {
-	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
-		struct pcpu_sw_netstats *stats = this_cpu_ptr(dev->tstats);
-
-		u64_stats_update_begin(&stats->syncp);
-		u64_stats_inc(&stats->tx_packets);
-		u64_stats_add(&stats->tx_bytes, len);
-		u64_stats_update_end(&stats->syncp);
-	}
+	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN))
+		dev_sw_netstats_tx_add(dev, 1, len);
 }
 
 static void macsec_encrypt_done(void *data, int err)
@@ -827,12 +821,7 @@ static void macsec_finalize_skb(struct sk_buff *skb, u8 icv_len, u8 hdr_len)
 
 static void count_rx(struct net_device *dev, int len)
 {
-	struct pcpu_sw_netstats *stats = this_cpu_ptr(dev->tstats);
-
-	u64_stats_update_begin(&stats->syncp);
-	u64_stats_inc(&stats->rx_packets);
-	u64_stats_add(&stats->rx_bytes, len);
-	u64_stats_update_end(&stats->syncp);
+	dev_sw_netstats_rx_add(dev, len);
 }
 
 static void macsec_decrypt_done(void *data, int err)
-- 
2.34.1


