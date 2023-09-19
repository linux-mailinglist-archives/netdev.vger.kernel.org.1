Return-Path: <netdev+bounces-35021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429AD7A673B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061AC2821E5
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6143B782;
	Tue, 19 Sep 2023 14:43:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DC3AC3B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:43:25 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4596E49;
	Tue, 19 Sep 2023 07:43:12 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRxWFd_1695134587;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRxWFd_1695134587)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:43:08 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 16/18] net/smc: avoid data copy from sndbuf to peer RMB in SMC-D
Date: Tue, 19 Sep 2023 22:42:00 +0800
Message-Id: <1695134522-126655-17-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This patch aims to avoid data copy from local sndbuf to peer RMB by mapping
local sndbuf to peer RMB when DMBs have ISM_ATTR_DMB_MAP attribute.

After this, local sndbuf and peer RMB share the same physical memory.

 +----------+                     +----------+
 | socket A |                     | socket B |
 +----------+                     +----------+
       |                               ^
       |         +---------+           |
  regard as      |         |     regard as
  local sndbuf   |  B's    |     local RMB
       |         |  RMB    |           |
       |-------> |         |-----------|
                 +---------+

1. From the perspective of RMB:

     a. Created or reused when connection is created.
     b. Unused and recycled to lgr buffer pool when connection is freed.
     c. Freed when link group is freed.

2. From the perspective of sndbuf:

     a. Mapped to peer RMB by the rtoken exchanged through CLC message.
        Then accessing local sndbuf is equivalent to accessing peer RMB.
     c. Unmapped from peer RMB and freed when connection is freed. Won't be
        recycled to lgr buffer pool.

Therefore, the data written to local sndbuf will directly reach peer RMB.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c   | 14 +++++++++++
 net/smc/smc_core.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_core.h |  1 +
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bc4300e..fd0b91f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1436,6 +1436,12 @@ static int smc_connect_ism(struct smc_sock *smc,
 	}
 
 	smc_conn_save_peer_info(smc, aclc);
+
+	if (smc_ism_dmb_mappable(smc->conn.lgr->smcd)) {
+		rc = smcd_buf_attach(smc);
+		if (rc)
+			goto connect_abort;
+	}
 	smc_close_init(smc);
 	smc_rx_init(smc);
 	smc_tx_init(smc);
@@ -2537,6 +2543,14 @@ static void smc_listen_work(struct work_struct *work)
 		mutex_unlock(&smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, cclc);
+
+	if (ini->is_smcd &&
+	    smc_ism_dmb_mappable(new_smc->conn.lgr->smcd)) {
+		rc = smcd_buf_attach(new_smc);
+		if (rc)
+			goto out_decl;
+	}
+
 	smc_listen_out_connected(new_smc);
 	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
 	goto out_free;
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index c36500a..bae2116 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1153,6 +1153,20 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 	}
 }
 
+static void smcd_buf_detach(struct smc_connection *conn)
+{
+	struct smcd_dev *smcd = conn->lgr->smcd;
+	u64 peer_token = conn->peer_token;
+
+	if (!conn->sndbuf_desc)
+		return;
+
+	smc_ism_detach_dmb(smcd, peer_token);
+
+	kfree(conn->sndbuf_desc);
+	conn->sndbuf_desc = NULL;
+}
+
 static void smc_buf_unuse(struct smc_connection *conn,
 			  struct smc_link_group *lgr)
 {
@@ -1197,6 +1211,10 @@ void smc_conn_free(struct smc_connection *conn)
 		if (!list_empty(&lgr->list))
 			smc_ism_unset_conn(conn);
 		tasklet_kill(&conn->rx_tsklet);
+
+		/* detach sndbuf from peer RMB */
+		if (smc_ism_dmb_mappable(lgr->smcd))
+			smcd_buf_detach(conn);
 	} else {
 		smc_cdc_wait_pend_tx_wr(conn);
 		if (current_work() != &conn->abort_work)
@@ -2458,15 +2476,23 @@ void smc_rmb_sync_sg_for_cpu(struct smc_connection *conn)
  */
 int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 {
+	bool sndbuf_created = false;
 	int rc;
 
+	if (is_smcd &&
+	    smc_ism_dmb_mappable(smc->conn.lgr->smcd))
+		goto create_rmb;
+
 	/* create send buffer */
 	rc = __smc_buf_create(smc, is_smcd, false);
 	if (rc)
 		return rc;
+	sndbuf_created = true;
+
+create_rmb:
 	/* create rmb */
 	rc = __smc_buf_create(smc, is_smcd, true);
-	if (rc) {
+	if (rc && sndbuf_created) {
 		down_write(&smc->conn.lgr->sndbufs_lock);
 		list_del(&smc->conn.sndbuf_desc->list);
 		up_write(&smc->conn.lgr->sndbufs_lock);
@@ -2476,6 +2502,48 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 	return rc;
 }
 
+int smcd_buf_attach(struct smc_sock *smc)
+{
+	struct smc_connection *conn = &smc->conn;
+	struct smcd_dev *smcd = conn->lgr->smcd;
+	u64 peer_token = conn->peer_token;
+	struct smc_buf_desc *buf_desc;
+	int rc;
+
+	buf_desc = kzalloc(sizeof(*buf_desc), GFP_KERNEL);
+	if (!buf_desc)
+		return -ENOMEM;
+
+	/* map local sndbuf desc to peer RMB, so operations on local
+	 * sndbuf are equivalent to operations on peer RMB.
+	 */
+	rc = smc_ism_attach_dmb(smcd, peer_token, buf_desc);
+	if (rc) {
+		rc = SMC_CLC_DECL_MEM;
+		goto free;
+	}
+
+	smc->sk.sk_sndbuf = buf_desc->len;
+	buf_desc->cpu_addr = (u8 *)buf_desc->cpu_addr + sizeof(struct smcd_cdc_msg);
+	buf_desc->len -= sizeof(struct smcd_cdc_msg);
+	conn->sndbuf_desc = buf_desc;
+	conn->sndbuf_desc->used = 1;
+	atomic_set(&conn->sndbuf_space, conn->sndbuf_desc->len);
+	return 0;
+
+free:
+	if (conn->rmb_desc) {
+		/* free local RMB as well */
+		down_write(&conn->lgr->rmbs_lock);
+		list_del(&conn->rmb_desc->list);
+		up_write(&conn->lgr->rmbs_lock);
+		smc_buf_free(conn->lgr, true, conn->rmb_desc);
+		conn->rmb_desc = NULL;
+	}
+	kfree(buf_desc);
+	return rc;
+}
+
 static inline int smc_rmb_reserve_rtoken_idx(struct smc_link_group *lgr)
 {
 	int i;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index d57eb9b..2cba119 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -551,6 +551,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
 void smc_smcd_terminate_all(struct smcd_dev *dev);
 void smc_smcr_terminate_all(struct smc_ib_device *smcibdev);
 int smc_buf_create(struct smc_sock *smc, bool is_smcd);
+int smcd_buf_attach(struct smc_sock *smc);
 int smc_uncompress_bufsize(u8 compressed);
 int smc_rmb_rtoken_handling(struct smc_connection *conn, struct smc_link *link,
 			    struct smc_clc_msg_accept_confirm *clc);
-- 
1.8.3.1


