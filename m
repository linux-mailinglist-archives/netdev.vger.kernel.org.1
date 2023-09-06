Return-Path: <netdev+bounces-32283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081CA793E28
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CA928150C
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32731079D;
	Wed,  6 Sep 2023 13:55:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851C1079C
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:55:44 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AA61B6;
	Wed,  6 Sep 2023 06:55:42 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VrU7-xt_1694008537;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VrU7-xt_1694008537)
          by smtp.aliyun-inc.com;
          Wed, 06 Sep 2023 21:55:39 +0800
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
Subject: [RFC net-next 1/2] net/smc: refactoring lgr pending lock
Date: Wed,  6 Sep 2023 21:55:29 +0800
Message-Id: <1694008530-85087-2-git-send-email-alibuda@linux.alibaba.com>
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

This patch replaces the locking and unlocking of lgr pending with
a unified inline function, and since the granularity of lgr pending
lock is within the lifecycle of init_info, which make it possible
to record the lock state on init_info. So that other routines can
unlock lgr pending lock safely.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c   | 24 ++++++++++++------------
 net/smc/smc_core.h | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd97..52a987b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1251,10 +1251,10 @@ static int smc_connect_rdma(struct smc_sock *smc,
 	if (reason_code)
 		return reason_code;
 
-	mutex_lock(&smc_client_lgr_pending);
+	smc_lgr_pending_lock(ini, &smc_client_lgr_pending);
 	reason_code = smc_conn_create(smc, ini);
 	if (reason_code) {
-		mutex_unlock(&smc_client_lgr_pending);
+		smc_lgr_pending_unlock(ini, &smc_client_lgr_pending);
 		return reason_code;
 	}
 
@@ -1346,7 +1346,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 		if (reason_code)
 			goto connect_abort;
 	}
-	mutex_unlock(&smc_client_lgr_pending);
+	smc_lgr_pending_unlock(ini, &smc_client_lgr_pending);
 
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
@@ -1356,7 +1356,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 	return 0;
 connect_abort:
 	smc_conn_abort(smc, ini->first_contact_local);
-	mutex_unlock(&smc_client_lgr_pending);
+	smc_lgr_pending_unlock(ini, &smc_client_lgr_pending);
 	smc->connect_nonblock = 0;
 
 	return reason_code;
@@ -1413,10 +1413,10 @@ static int smc_connect_ism(struct smc_sock *smc,
 	ini->ism_peer_gid[ini->ism_selected] = aclc->d0.gid;
 
 	/* there is only one lgr role for SMC-D; use server lock */
-	mutex_lock(&smc_server_lgr_pending);
+	smc_lgr_pending_lock(ini, &smc_server_lgr_pending);
 	rc = smc_conn_create(smc, ini);
 	if (rc) {
-		mutex_unlock(&smc_server_lgr_pending);
+		smc_lgr_pending_unlock(ini, &smc_server_lgr_pending);
 		return rc;
 	}
 
@@ -1443,7 +1443,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 				  aclc->hdr.version, eid, ini);
 	if (rc)
 		goto connect_abort;
-	mutex_unlock(&smc_server_lgr_pending);
+	smc_lgr_pending_unlock(ini, &smc_server_lgr_pending);
 
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
@@ -1453,7 +1453,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 	return 0;
 connect_abort:
 	smc_conn_abort(smc, ini->first_contact_local);
-	mutex_unlock(&smc_server_lgr_pending);
+	smc_lgr_pending_unlock(ini, &smc_server_lgr_pending);
 	smc->connect_nonblock = 0;
 
 	return rc;
@@ -2460,7 +2460,7 @@ static void smc_listen_work(struct work_struct *work)
 	if (rc)
 		goto out_decl;
 
-	mutex_lock(&smc_server_lgr_pending);
+	smc_lgr_pending_lock(ini, &smc_server_lgr_pending);
 	smc_close_init(new_smc);
 	smc_rx_init(new_smc);
 	smc_tx_init(new_smc);
@@ -2479,7 +2479,7 @@ static void smc_listen_work(struct work_struct *work)
 
 	/* SMC-D does not need this lock any more */
 	if (ini->is_smcd)
-		mutex_unlock(&smc_server_lgr_pending);
+		smc_lgr_pending_unlock(ini, &smc_server_lgr_pending);
 
 	/* receive SMC Confirm CLC message */
 	memset(buf, 0, sizeof(*buf));
@@ -2510,7 +2510,7 @@ static void smc_listen_work(struct work_struct *work)
 					    ini->first_contact_local, ini);
 		if (rc)
 			goto out_unlock;
-		mutex_unlock(&smc_server_lgr_pending);
+		smc_lgr_pending_unlock(ini, &smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, cclc);
 	smc_listen_out_connected(new_smc);
@@ -2518,7 +2518,7 @@ static void smc_listen_work(struct work_struct *work)
 	goto out_free;
 
 out_unlock:
-	mutex_unlock(&smc_server_lgr_pending);
+	smc_lgr_pending_unlock(ini, &smc_server_lgr_pending);
 out_decl:
 	smc_listen_decline(new_smc, rc, ini ? ini->first_contact_local : 0,
 			   proposal_version);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 120027d..6f309a3 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -422,6 +422,8 @@ struct smc_init_info {
 	u8			ism_offered_cnt; /* # of ISM devices offered */
 	u8			ism_selected;    /* index of selected ISM dev*/
 	u8			smcd_version;
+	/* mutex holding for conn create */
+	struct mutex *mutex;
 };
 
 /* Find the connection associated with the given alert token in the link group.
@@ -589,6 +591,25 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 int smcr_nl_get_link(struct sk_buff *skb, struct netlink_callback *cb);
 int smcd_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb);
 
+static inline void smc_lgr_pending_lock(struct smc_init_info *ini, struct mutex *lock)
+{
+	if (unlikely(ini->mutex))
+		pr_warn_once("smc: lgr pending deadlock dected.");
+
+	mutex_lock(lock);
+	ini->mutex = lock;
+}
+
+static inline void smc_lgr_pending_unlock(struct smc_init_info *ini, struct mutex *lock)
+{
+	/* already unlock it */
+	if (!ini->mutex)
+		return;
+
+	ini->mutex = NULL;
+	mutex_unlock(lock);
+}
+
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
 	return link->lgr;
-- 
1.8.3.1


