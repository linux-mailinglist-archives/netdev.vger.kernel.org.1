Return-Path: <netdev+bounces-36031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BB7ACA48
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 44DE11C20AC8
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D4D285;
	Sun, 24 Sep 2023 15:17:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057DD300
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 15:17:16 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC60EFD;
	Sun, 24 Sep 2023 08:17:13 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vsio7sa_1695568628;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vsio7sa_1695568628)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:10 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: wintera@linux.ibm.com,
	schnelle@linux.ibm.com,
	gbayer@linux.ibm.com,
	pasic@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 05/18] net/smc: reserve CHID range for SMC-D virtual device
Date: Sun, 24 Sep 2023 23:16:40 +0800
Message-Id: <1695568613-125057-6-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
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

This patch reserve CHID range from 0xFF00 to 0xFFFF for SMC-D virtual
device and introduces helpers to identify them.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 14d2e77..2ecc8de 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -15,6 +15,9 @@
 
 #include "smc.h"
 
+#define SMC_VIRT_ISM_CHID_MAX		0xFFFF
+#define SMC_VIRT_ISM_CHID_MIN		0xFF00
+
 struct smcd_dev_list {	/* List of SMCD devices */
 	struct list_head list;
 	struct mutex mutex;	/* Protects list of devices */
@@ -57,4 +60,16 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
 	return rc < 0 ? rc : 0;
 }
 
+static inline bool __smc_ism_is_virtdev(u16 chid)
+{
+	return (chid >= SMC_VIRT_ISM_CHID_MIN && chid <= SMC_VIRT_ISM_CHID_MAX);
+}
+
+static inline bool smc_ism_is_virtdev(struct smcd_dev *smcd)
+{
+	u16 chid = smcd->ops->get_chid(smcd);
+
+	return __smc_ism_is_virtdev(chid);
+}
+
 #endif
-- 
1.8.3.1


