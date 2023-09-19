Return-Path: <netdev+bounces-35016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA467A672D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AB21C20A29
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE903AC1A;
	Tue, 19 Sep 2023 14:43:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252A3AC0E
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:43:09 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96CCEA;
	Tue, 19 Sep 2023 07:43:03 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRx7eE_1695134578;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRx7eE_1695134578)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:43:00 +0800
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
Subject: [PATCH net-next 12/18] net/smc: implement DMB-related operations of loopback
Date: Tue, 19 Sep 2023 22:41:56 +0800
Message-Id: <1695134522-126655-13-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
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

This patch implements DMB registration, unregistration and data move
operations of SMC-D loopback.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_cdc.c      |   6 +++
 net/smc/smc_cdc.h      |   1 +
 net/smc/smc_loopback.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++--
 net/smc/smc_loopback.h |  13 +++++
 4 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 89105e9..2641800 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -411,6 +411,12 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
 {
 	struct smc_connection *conn = from_tasklet(conn, t, rx_tsklet);
+
+	smcd_cdc_rx_handler(conn);
+}
+
+void smcd_cdc_rx_handler(struct smc_connection *conn)
+{
 	struct smcd_cdc_msg *data_cdc;
 	struct smcd_cdc_msg cdc;
 	struct smc_sock *smc;
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 696cc11..11559d4 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -301,5 +301,6 @@ int smcr_cdc_msg_send_validation(struct smc_connection *conn,
 				 struct smc_wr_buf *wr_buf);
 int smc_cdc_init(void) __init;
 void smcd_cdc_rx_init(struct smc_connection *conn);
+void smcd_cdc_rx_handler(struct smc_connection *conn);
 
 #endif /* SMC_CDC_H */
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index fe61260..7807b38 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <net/smc.h>
 
+#include "smc_cdc.h"
 #include "smc_ism.h"
 #include "smc_loopback.h"
 
@@ -73,6 +74,93 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 	return 0;
 }
 
+static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
+			       void *client_priv)
+{
+	struct smc_lo_dmb_node *dmb_node, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+	int sba_idx, rc;
+
+	/* check space for new dmb */
+	for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LODEV_MAX_DMBS) {
+		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
+			break;
+	}
+	if (sba_idx == SMC_LODEV_MAX_DMBS)
+		return -ENOSPC;
+
+	dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
+	if (!dmb_node) {
+		rc = -ENOMEM;
+		goto err_bit;
+	}
+
+	dmb_node->sba_idx = sba_idx;
+	dmb_node->cpu_addr = kzalloc(dmb->dmb_len, GFP_KERNEL |
+				     __GFP_NOWARN | __GFP_NORETRY |
+				     __GFP_NOMEMALLOC);
+	if (!dmb_node->cpu_addr) {
+		rc = -ENOMEM;
+		goto err_node;
+	}
+	dmb_node->len = dmb->dmb_len;
+	dmb_node->dma_addr = (dma_addr_t)dmb_node->cpu_addr;
+
+again:
+	/* add new dmb into hash table */
+	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
+	write_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
+		if (tmp_node->token == dmb_node->token) {
+			write_unlock(&ldev->dmb_ht_lock);
+			goto again;
+		}
+	}
+	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
+	write_unlock(&ldev->dmb_ht_lock);
+
+	dmb->sba_idx = dmb_node->sba_idx;
+	dmb->dmb_tok = dmb_node->token;
+	dmb->cpu_addr = dmb_node->cpu_addr;
+	dmb->dma_addr = dmb_node->dma_addr;
+	dmb->dmb_len = dmb_node->len;
+
+	return 0;
+
+err_node:
+	kfree(dmb_node);
+err_bit:
+	clear_bit(sba_idx, ldev->sba_idx_mask);
+	return rc;
+}
+
+static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
+{
+	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* remove dmb from hash table */
+	write_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
+		if (tmp_node->token == dmb->dmb_tok) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		write_unlock(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	hash_del(&dmb_node->list);
+	write_unlock(&ldev->dmb_ht_lock);
+
+	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
+	kfree(dmb_node->cpu_addr);
+	kfree(dmb_node);
+
+	return 0;
+}
+
 static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
 {
 	return -EOPNOTSUPP;
@@ -99,6 +187,38 @@ static int smc_lo_signal_event(struct smcd_dev *dev, u64 rgid, u32 trigger_irq,
 	return 0;
 }
 
+static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
+			    bool sf, unsigned int offset, void *data,
+			    unsigned int size)
+{
+	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	read_lock(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
+		if (tmp_node->token == dmb_tok) {
+			rmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!rmb_node) {
+		read_unlock(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock(&ldev->dmb_ht_lock);
+
+	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
+
+	if (sf) {
+		struct smc_connection *conn =
+			smcd->conn[rmb_node->sba_idx];
+
+		if (conn && !conn->killed)
+			smcd_cdc_rx_handler(conn);
+	}
+	return 0;
+}
+
 static int smc_lo_supports_v2(void)
 {
 	return SMC_LO_SUPPORTS_V2;
@@ -130,14 +250,14 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 
 static const struct smcd_ops lo_ops = {
 	.query_remote_gid = smc_lo_query_rgid,
-	.register_dmb		= NULL,
-	.unregister_dmb		= NULL,
+	.register_dmb = smc_lo_register_dmb,
+	.unregister_dmb = smc_lo_unregister_dmb,
 	.add_vlan_id = smc_lo_add_vlan_id,
 	.del_vlan_id = smc_lo_del_vlan_id,
 	.set_vlan_required = smc_lo_set_vlan_required,
 	.reset_vlan_required = smc_lo_reset_vlan_required,
 	.signal_event = smc_lo_signal_event,
-	.move_data		= NULL,
+	.move_data = smc_lo_move_data,
 	.supports_v2 = smc_lo_supports_v2,
 	.get_system_eid = smc_lo_get_system_eid,
 	.get_local_gid = smc_lo_get_local_gid,
@@ -211,6 +331,8 @@ static void smc_lo_dev_release(struct device *dev)
 static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 {
 	smc_lo_generate_id(ldev);
+	rwlock_init(&ldev->dmb_ht_lock);
+	hash_init(ldev->dmb_ht);
 
 	return smcd_lo_register_dev(ldev);
 }
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 2156f22..943424f 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -20,12 +20,25 @@
 
 #define SMC_LO_CHID 0xFFFF
 #define SMC_LODEV_MAX_DMBS 5000
+#define SMC_LODEV_DMBS_HASH_BITS 12
+
+struct smc_lo_dmb_node {
+	struct hlist_node list;
+	u64 token;
+	u32 len;
+	u32 sba_idx;
+	void *cpu_addr;
+	dma_addr_t dma_addr;
+};
 
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
 	u16 chid;
 	struct smcd_gid local_gid;
+	DECLARE_BITMAP(sba_idx_mask, SMC_LODEV_MAX_DMBS);
+	rwlock_t dmb_ht_lock;
+	DECLARE_HASHTABLE(dmb_ht, SMC_LODEV_DMBS_HASH_BITS);
 };
 
 int smc_loopback_init(void);
-- 
1.8.3.1


