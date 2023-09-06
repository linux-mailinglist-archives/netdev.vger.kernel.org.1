Return-Path: <netdev+bounces-32284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA65793E29
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 15:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E551D2815C6
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEDE107A9;
	Wed,  6 Sep 2023 13:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8C10790
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:55:48 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFBD7;
	Wed,  6 Sep 2023 06:55:43 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VrU7-yS_1694008540;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VrU7-yS_1694008540)
          by smtp.aliyun-inc.com;
          Wed, 06 Sep 2023 21:55:41 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	"D. Wythe" <alibuda@linux.alibaba.com>
Subject: [RFC net-next 2/2] net/smc: remove locks smc_client_lgr_pending and smc_server_lgr_pending
Date: Wed,  6 Sep 2023 21:55:30 +0800
Message-Id: <1694008530-85087-3-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694008530-85087-1-git-send-email-alibuda@linux.alibaba.com>
References: <1694008530-85087-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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

This patch attempts to remove locks named smc_client_lgr_pending and
smc_server_lgr_pending, which aim to serialize the creation of link
group. However, once link group existed already, those locks are
meaningless, worse still, they make incoming connections have to be
queued one after the other.

Before attempting to locking at xxx_lgr_pending, trying to invoke
smc_conn_create() firstly but does not allow it to create link group.
Once we found we MUST create link group, then we can make lock on it.
In that way, we can skip meaningless lock.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc_clc.h  |  1 +
 net/smc/smc_core.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index c5c8e7d..050484a 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -48,6 +48,7 @@
 #define SMC_CLC_DECL_RELEASEERR	0x03030009  /* release version negotiate failed */
 #define SMC_CLC_DECL_MAXCONNERR	0x0303000a  /* max connections negotiate failed */
 #define SMC_CLC_DECL_MAXLINKERR	0x0303000b  /* max links negotiate failed */
+#define SMC_CLC_DECL_REQLGR	0x0303000c  /* required create link grou */
 #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
 #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index bd01dd3..76c82ae 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1863,8 +1863,7 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 	return lgr->peer_gid == peer_gid && lgr->smcd == smcismdev;
 }
 
-/* create a new SMC connection (and a new link group if necessary) */
-int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
+static int __smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini, bool create_lgr)
 {
 	struct smc_connection *conn = &smc->conn;
 	struct net *net = sock_net(&smc->sk);
@@ -1927,6 +1926,8 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 
 create:
 	if (ini->first_contact_local) {
+		if (!create_lgr)
+			return SMC_CLC_DECL_REQLGR;
 		rc = smc_lgr_create(smc, ini);
 		if (rc)
 			goto out;
@@ -1962,6 +1963,29 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	return rc;
 }
 
+/* create a new SMC connection (and a new link group if necessary) */
+int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
+{
+	int rc;
+
+	/* make no impact on SMCD */
+	if (ini->is_smcd)
+		goto locked;
+
+	/* try create conn without create lgr first */
+	rc = __smc_conn_create(smc, ini, /* disallow create lgr */ false);
+	if (!rc) {
+		/* not rely on new lgr, unlock lgr pending lock in advance. */
+		smc_lgr_pending_unlock(ini, ini->mutex);
+		return 0;
+	} else if (rc != SMC_CLC_DECL_REQLGR) {
+		/* that's unexcepted error */
+		return rc;
+	}
+locked:
+	return __smc_conn_create(smc, ini, /* create lgr if needed */ true);
+}
+
 #define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
 #define SMCR_RMBE_SIZES		5 /* 0 -> 16KB, 1 -> 32KB, .. 5 -> 512KB */
 
-- 
1.8.3.1


