Return-Path: <netdev+bounces-35013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E061D7A6726
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA781C20A71
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AB3FB3F;
	Tue, 19 Sep 2023 14:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595938DD2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:42:55 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6256130;
	Tue, 19 Sep 2023 07:42:53 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRxW9Y_1695134569;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRxW9Y_1695134569)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:42:51 +0800
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
Subject: [PATCH net-next 08/18] net/smc: enable virtual ISM device feature bit
Date: Tue, 19 Sep 2023 22:41:52 +0800
Message-Id: <1695134522-126655-9-git-send-email-guwen@linux.alibaba.com>
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

This patch enables the first supplement feature of SMCv2.1, that
is the support for virtual ISM devices.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c | 2 ++
 net/smc/smc.h    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9e31033..7eab600 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1522,6 +1522,7 @@ static int __smc_connect(struct smc_sock *smc)
 	ini->smcr_version = SMC_V1 | SMC_V2;
 	ini->smc_type_v1 = SMC_TYPE_B;
 	ini->smc_type_v2 = SMC_TYPE_B;
+	ini->feature_mask = SMC_FEATURE_MASK;
 
 	/* get vlan id from IP device */
 	if (smc_vlan_by_tcpsk(smc->clcsock, ini)) {
@@ -1987,6 +1988,7 @@ static int smc_listen_v2_check(struct smc_sock *new_smc,
 	ini->smc_type_v2 = pclc->hdr.typev2;
 	ini->smcd_version = smcd_indicated(ini->smc_type_v1) ? SMC_V1 : 0;
 	ini->smcr_version = smcr_indicated(ini->smc_type_v1) ? SMC_V1 : 0;
+	ini->feature_mask = SMC_FEATURE_MASK;
 	if (pclc->hdr.version > SMC_V1) {
 		if (smcd_indicated(ini->smc_type_v2))
 			ini->smcd_version |= SMC_V2;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 24745fd..71b9640 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -58,6 +58,13 @@ enum smc_state {		/* possible states of an SMC socket */
 	SMC_PROCESSABORT	= 27,
 };
 
+enum smc_supp_feature {	/* supplemental features supported by current version */
+	SMC_SPF_VIRT_ISM_DEV	= 0,
+};
+
+#define SMC_FEATURE_MASK \
+	(BIT(SMC_SPF_VIRT_ISM_DEV))
+
 struct smc_link_group;
 
 struct smc_wr_rx_hdr {	/* common prefix part of LLC and CDC to demultiplex */
-- 
1.8.3.1


