Return-Path: <netdev+bounces-49012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91F7F06A8
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 14:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0837B2047D
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33488125B4;
	Sun, 19 Nov 2023 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7F8E6;
	Sun, 19 Nov 2023 05:58:05 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VwebcEG_1700402280;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VwebcEG_1700402280)
          by smtp.aliyun-inc.com;
          Sun, 19 Nov 2023 21:58:02 +0800
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
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] net/smc: Rename some variable 'fce' to 'fce_v2x' for clarity
Date: Sun, 19 Nov 2023 21:57:51 +0800
Message-Id: <1700402277-93750-2-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Rename some smc_clc_first_contact_ext_v2x type variables to 'fce_v2x'
to distinguish them from smc_clc_first_contact_ext type variables.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_clc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 8deb46c..f2f86c2 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -418,15 +418,15 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 	return true;
 }
 
-static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
+static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce_v2x,
 			    struct smc_init_info *ini)
 {
-	int ret = sizeof(*fce);
+	int ret = sizeof(*fce_v2x);
 
-	memset(fce, 0, sizeof(*fce));
-	fce->fce_v2_base.os_type = SMC_CLC_OS_LINUX;
-	fce->fce_v2_base.release = ini->release_nr;
-	memcpy(fce->fce_v2_base.hostname, smc_hostname, sizeof(smc_hostname));
+	memset(fce_v2x, 0, sizeof(*fce_v2x));
+	fce_v2x->fce_v2_base.os_type = SMC_CLC_OS_LINUX;
+	fce_v2x->fce_v2_base.release = ini->release_nr;
+	memcpy(fce_v2x->fce_v2_base.hostname, smc_hostname, sizeof(smc_hostname));
 	if (ini->is_smcd && ini->release_nr < SMC_RELEASE_1) {
 		ret = sizeof(struct smc_clc_first_contact_ext);
 		goto out;
@@ -434,8 +434,8 @@ static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
 
 	if (ini->release_nr >= SMC_RELEASE_1) {
 		if (!ini->is_smcd) {
-			fce->max_conns = ini->max_conns;
-			fce->max_links = ini->max_links;
+			fce_v2x->max_conns = ini->max_conns;
+			fce_v2x->max_links = ini->max_links;
 		}
 	}
 
@@ -1002,8 +1002,8 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				       int first_contact, u8 version,
 				       u8 *eid, struct smc_init_info *ini)
 {
+	struct smc_clc_first_contact_ext_v2x fce_v2x;
 	struct smc_connection *conn = &smc->conn;
-	struct smc_clc_first_contact_ext_v2x fce;
 	struct smc_clc_msg_accept_confirm *clc;
 	struct smc_clc_fce_gid_ext gle;
 	struct smc_clc_msg_trail trl;
@@ -1036,7 +1036,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
 			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
 			if (first_contact) {
-				fce_len = smc_clc_fill_fce(&fce, ini);
+				fce_len = smc_clc_fill_fce(&fce_v2x, ini);
 				len += fce_len;
 			}
 			clc_v2->hdr.length = htons(len);
@@ -1082,9 +1082,9 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
 			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
 			if (first_contact) {
-				fce_len = smc_clc_fill_fce(&fce, ini);
+				fce_len = smc_clc_fill_fce(&fce_v2x, ini);
 				len += fce_len;
-				fce.fce_v2_base.v2_direct = !link->lgr->uses_gateway;
+				fce_v2x.fce_v2_base.v2_direct = !link->lgr->uses_gateway;
 				if (clc->hdr.type == SMC_CLC_CONFIRM) {
 					memset(&gle, 0, sizeof(gle));
 					gle.gid_cnt = ini->smcrv2.gidlist.len;
@@ -1111,7 +1111,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 						SMCR_CLC_ACCEPT_CONFIRM_LEN) -
 				   sizeof(trl);
 	if (version > SMC_V1 && first_contact) {
-		vec[i].iov_base = &fce;
+		vec[i].iov_base = &fce_v2x;
 		vec[i++].iov_len = fce_len;
 		if (!conn->lgr->is_smcd) {
 			if (clc->hdr.type == SMC_CLC_CONFIRM) {
-- 
1.8.3.1


