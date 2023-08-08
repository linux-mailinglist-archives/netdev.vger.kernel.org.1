Return-Path: <netdev+bounces-25487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE27743C1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F98B2817A2
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDC91CA0C;
	Tue,  8 Aug 2023 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBE1BB45
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E89268ED
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:49:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKrrT4mQ7ztRwj;
	Tue,  8 Aug 2023 19:42:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 19:45:29 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
	<jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 2/3] octeontx2-af: Use u64_to_ether_addr() to convert ethernet address
Date: Tue, 8 Aug 2023 19:45:03 +0800
Message-ID: <20230808114504.4036008-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808114504.4036008-1-lizetao1@huawei.com>
References: <20230808114504.4036008-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use u64_to_ether_addr() to convert a u64 value to an Ethernet MAC address,
instead of directly calculating, as this is exactly what this
function does.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 095b2cc4a699..b3f766b970ca 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -686,7 +686,7 @@ int rvu_mbox_handler_cgx_mac_addr_get(struct rvu *rvu,
 {
 	int pf = rvu_get_pf(req->hdr.pcifunc);
 	u8 cgx_id, lmac_id;
-	int rc = 0, i;
+	int rc = 0;
 	u64 cfg;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
@@ -697,8 +697,7 @@ int rvu_mbox_handler_cgx_mac_addr_get(struct rvu *rvu,
 	rsp->hdr.rc = rc;
 	cfg = cgx_lmac_addr_get(cgx_id, lmac_id);
 	/* copy 48 bit mac address to req->mac_addr */
-	for (i = 0; i < ETH_ALEN; i++)
-		rsp->mac_addr[i] = cfg >> (ETH_ALEN - 1 - i) * 8;
+	u64_to_ether_addr(cfg, rsp->mac_addr);
 	return 0;
 }
 
-- 
2.34.1


