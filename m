Return-Path: <netdev+bounces-35017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E1C7A6732
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5811B1C2029D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F623AC27;
	Tue, 19 Sep 2023 14:43:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565B63AC0E
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:43:17 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7AC18F;
	Tue, 19 Sep 2023 07:43:06 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRxWDi_1695134580;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRxWDi_1695134580)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:43:02 +0800
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
Subject: [PATCH net-next 13/18] net/smc: register loopback device as SMC-Dv2 device
Date: Tue, 19 Sep 2023 22:41:57 +0800
Message-Id: <1695134522-126655-14-git-send-email-guwen@linux.alibaba.com>
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

After loopback device gets ready, add it to the smcd_dev list as an
SMC-Dv2 device for use by SMC-D protocol.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 7807b38..650561b 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -303,18 +303,27 @@ static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
 
 	ldev->smcd = smcd;
 	smcd->priv = ldev;
-
-	/* TODO:
-	 * register smc_lo to smcd_dev list.
-	 */
+	mutex_lock(&smcd_dev_list.mutex);
+	smc_ism_check_v2_capable(smcd);
+	list_add(&smcd->list, &smcd_dev_list.list);
+	mutex_unlock(&smcd_dev_list.mutex);
+	pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
+			    smc_lo_dev_name, smcd->pnetid,
+			    smcd->pnetid_by_user ? " (user defined)" : "");
 	return 0;
 }
 
 static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 {
-	/* TODO:
-	 * unregister smc_lo from smcd_dev list.
-	 */
+	struct smcd_dev *smcd = ldev->smcd;
+
+	pr_warn_ratelimited("smc: removing smcd device %s\n",
+			    smc_lo_dev_name);
+	smcd->going_away = 1;
+	smc_smcd_terminate_all(smcd);
+	mutex_lock(&smcd_dev_list.mutex);
+	list_del_init(&smcd->list);
+	mutex_unlock(&smcd_dev_list.mutex);
 }
 
 static void smc_lo_dev_release(struct device *dev)
-- 
1.8.3.1


