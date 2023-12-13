Return-Path: <netdev+bounces-55626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FB680BB01
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 14:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68197B20A71
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E8CC8E1;
	Sun, 10 Dec 2023 13:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493EE1A1;
	Sun, 10 Dec 2023 05:24:35 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8DoYz_1702214671;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8DoYz_1702214671)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:33 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 07/13] net/smc: register loopback-ism into SMC-D device list
Date: Sun, 10 Dec 2023 21:24:08 +0800
Message-Id: <1702214654-32069-8-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
References: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

After loopback-ism device gets ready, add it to the SMC-D device list as
an ISMv2 device.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c      | 11 +++++++----
 net/smc/smc_ism.h      |  1 +
 net/smc/smc_loopback.c | 20 +++++++++++++-------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index fb1837d..4065ebd 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -91,6 +91,11 @@ bool smc_ism_is_v2_capable(void)
 	return smc_ism_v2_capable;
 }
 
+void smc_ism_set_v2_capable(void)
+{
+	smc_ism_v2_capable = true;
+}
+
 /* Set a connection using this DMBE. */
 void smc_ism_set_conn(struct smc_connection *conn)
 {
@@ -454,11 +459,9 @@ static void smcd_register_dev(struct ism_dev *ism)
 	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
 
+	if (smcd->ops->supports_v2())
+		smc_ism_set_v2_capable();
 	mutex_lock(&smcd_dev_list.mutex);
-	if (list_empty(&smcd_dev_list.list)) {
-		if (smcd->ops->supports_v2())
-			smc_ism_v2_capable = true;
-	}
 	/* sort list: devices without pnetid before devices with pnetid */
 	if (smcd->pnetid[0])
 		list_add_tail(&smcd->list, &smcd_dev_list.list);
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index ffff40c..6903cd5 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -52,6 +52,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
 bool smc_ism_is_v2_capable(void);
+void smc_ism_set_v2_capable(void);
 int smc_ism_init(void);
 void smc_ism_exit(void);
 int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index ee4f112..83bc9a7 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -273,10 +273,12 @@ static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
 		return -ENOMEM;
 	ldev->smcd = smcd;
 	smcd->priv = ldev;
-
-	/* TODO:
-	 * register loopback-ism to smcd_dev list.
-	 */
+	smc_ism_set_v2_capable();
+	mutex_lock(&smcd_dev_list.mutex);
+	list_add(&smcd->list, &smcd_dev_list.list);
+	mutex_unlock(&smcd_dev_list.mutex);
+	pr_warn_ratelimited("smc: adding smcd device %s\n",
+			    smc_lo_dev_name);
 	return 0;
 }
 
@@ -284,9 +286,13 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 {
 	struct smcd_dev *smcd = ldev->smcd;
 
-	/* TODO:
-	 * unregister loopback-ism from smcd_dev list.
-	 */
+	pr_warn_ratelimited("smc: removing smcd device %s\n",
+			    smc_lo_dev_name);
+	smcd->going_away = 1;
+	smc_smcd_terminate_all(smcd);
+	mutex_lock(&smcd_dev_list.mutex);
+	list_del_init(&smcd->list);
+	mutex_unlock(&smcd_dev_list.mutex);
 	kfree(smcd->conn);
 	kfree(smcd);
 }
-- 
1.8.3.1


