Return-Path: <netdev+bounces-39893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961677C4BEF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68F41C20C72
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 07:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002E19471;
	Wed, 11 Oct 2023 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4D199C5
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:33:37 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8CD91;
	Wed, 11 Oct 2023 00:33:33 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VtvoMDz_1697009610;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VtvoMDz_1697009610)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 15:33:30 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH net 2/5] net/smc: fix incorrect barrier usage
Date: Wed, 11 Oct 2023 15:33:17 +0800
Message-Id: <1697009600-22367-3-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch add explicit CPU barrier to ensure memory
consistency rather than compiler barrier.

Besides, the atomicity between READ_ONCE and cmpxhcg cannot
be guaranteed, so we need to use atomic ops. The simple way
is to replace READ_ONCE with xchg.

Fixes: 475f9ff63ee8 ("net/smc: fix application data exception")
Co-developed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Links: https://lore.kernel.org/netdev/1b7c95be-d3d9-53c3-3152-cd835314d37c@linux.ibm.com/T/
---
 net/smc/smc_core.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d520ee6..cc7d72e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1133,9 +1133,10 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 
 		smc_buf_free(lgr, is_rmb, buf_desc);
 	} else {
-		/* memzero_explicit provides potential memory barrier semantics */
-		memzero_explicit(buf_desc->cpu_addr, buf_desc->len);
-		WRITE_ONCE(buf_desc->used, 0);
+		memset(buf_desc->cpu_addr, 0, buf_desc->len);
+		/* make sure buf_desc->used not be reordered ahead */
+		smp_mb__before_atomic();
+		xchg(&buf_desc->used, 0);
 	}
 }
 
@@ -1146,17 +1147,21 @@ static void smc_buf_unuse(struct smc_connection *conn,
 		if (!lgr->is_smcd && conn->sndbuf_desc->is_vm) {
 			smcr_buf_unuse(conn->sndbuf_desc, false, lgr);
 		} else {
-			memzero_explicit(conn->sndbuf_desc->cpu_addr, conn->sndbuf_desc->len);
-			WRITE_ONCE(conn->sndbuf_desc->used, 0);
+			memset(conn->sndbuf_desc->cpu_addr, 0, conn->sndbuf_desc->len);
+			/* make sure buf_desc->used not be reordered ahead */
+			smp_mb__before_atomic();
+			xchg(&conn->sndbuf_desc->used, 0);
 		}
 	}
 	if (conn->rmb_desc) {
 		if (!lgr->is_smcd) {
 			smcr_buf_unuse(conn->rmb_desc, true, lgr);
 		} else {
-			memzero_explicit(conn->rmb_desc->cpu_addr,
-					 conn->rmb_desc->len + sizeof(struct smcd_cdc_msg));
-			WRITE_ONCE(conn->rmb_desc->used, 0);
+			memset(conn->rmb_desc->cpu_addr, 0,
+			       conn->rmb_desc->len + sizeof(struct smcd_cdc_msg));
+			/* make sure buf_desc->used not be reordered ahead */
+			smp_mb__before_atomic();
+			xchg(&conn->rmb_desc->used, 0);
 		}
 	}
 }
-- 
1.8.3.1


