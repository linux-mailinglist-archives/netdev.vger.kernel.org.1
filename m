Return-Path: <netdev+bounces-12655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF537385B5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F232815DB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB0418AF5;
	Wed, 21 Jun 2023 13:49:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58E18C0A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:49:40 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15E1BCA;
	Wed, 21 Jun 2023 06:49:37 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDkl4N021565;
	Wed, 21 Jun 2023 13:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=kH7D5GG6XvXWuo2k9pXAPdNcycrfpNYlhPm8LAAQcmc=;
 b=ohDC16mt2IDeYArdx2qr2GBqFRRyYWiiDtgfD1eeF3OC5BWk9X/EVm195KAz7iFmnOcT
 8+SkEpbVvIEJBdWBTbM9TEKF5ZMUG4mDMC8i8jd6nLsmqJnVWDhsBjc8Z7ioM9uK09+9
 z5gH58ZZ3i7oxEIPxXS1mjjezKiYdi9rCb+6RzXd3wcXhmRyEiV1VLmGPIWoyXgryo6Q
 l/L2nO9dwcFqSeU0bjD2SWs/iCO6CKVMThwdvcIbSQKtWK9MIlKXd8py7g6YMdIEz8JM
 R/UF/+LvHcSk4GakTmGjqoX0xk+hk3D7l12neiSQ1ZVsBTMmvBzLe2vaWQnUFD7SXlNd 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2ctr25j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 13:49:34 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LDlTjq024307;
	Wed, 21 Jun 2023 13:49:33 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2ctr24c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 13:49:32 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L2SdPC012944;
	Wed, 21 Jun 2023 13:49:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3r94f5a45w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 13:49:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LDnRYJ20710054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jun 2023 13:49:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B66B2004B;
	Wed, 21 Jun 2023 13:49:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA04220043;
	Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 86E41E13EF; Wed, 21 Jun 2023 15:49:26 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH net-next v2 4/4] s390/ctcm: Convert sprintf/snprintf to scnprintf
Date: Wed, 21 Jun 2023 15:49:21 +0200
Message-Id: <20230621134921.904217-5-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621134921.904217-1-wintera@linux.ibm.com>
References: <20230621134921.904217-1-wintera@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aX95AOeXMz4NuzuR9odfHRE7QXzcGY-J
X-Proofpoint-ORIG-GUID: A_TPtshQUDGSLsXr1RFtMQ9jwUU1ZP7R
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Thorsten Winkler <twinkler@linux.ibm.com>

This LWN article explains the why scnprintf is preferred over snprintf
in general
https://lwn.net/Articles/69419/
Ie. snprintf() returns what *would* be the resulting length, while
scnprintf() returns the actual length.

Note that ctcm_print_statistics() writes the data into the kernel log
and is therefore not suitable for sysfs_emit(). Observable behavior is
not changed, as there may be dependencies.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ctcm_dbug.c  |  2 +-
 drivers/s390/net/ctcm_main.c  |  6 +++---
 drivers/s390/net/ctcm_main.h  |  1 +
 drivers/s390/net/ctcm_mpc.c   | 18 ++++++++++--------
 drivers/s390/net/ctcm_sysfs.c | 36 +++++++++++++++++------------------
 5 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/net/ctcm_dbug.c b/drivers/s390/net/ctcm_dbug.c
index f7ec51db3cd6..b6f0e2f114b4 100644
--- a/drivers/s390/net/ctcm_dbug.c
+++ b/drivers/s390/net/ctcm_dbug.c
@@ -70,7 +70,7 @@ void ctcm_dbf_longtext(enum ctcm_dbf_names dbf_nix, int level, char *fmt, ...)
 	if (!debug_level_enabled(ctcm_dbf[dbf_nix].id, level))
 		return;
 	va_start(args, fmt);
-	vsnprintf(dbf_txt_buf, sizeof(dbf_txt_buf), fmt, args);
+	vscnprintf(dbf_txt_buf, sizeof(dbf_txt_buf), fmt, args);
 	va_end(args);
 
 	debug_text_event(ctcm_dbf[dbf_nix].id, level, dbf_txt_buf);
diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index e0fdd54bfeb7..79fac5314e67 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1340,7 +1340,7 @@ static int add_channel(struct ccw_device *cdev, enum ctcm_channel_types type,
 					goto nomem_return;
 
 	ch->cdev = cdev;
-	snprintf(ch->id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev->dev));
+	scnprintf(ch->id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev->dev));
 	ch->type = type;
 
 	/*
@@ -1505,8 +1505,8 @@ static int ctcm_new_device(struct ccwgroup_device *cgdev)
 
 	type = get_channel_type(&cdev0->id);
 
-	snprintf(read_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev0->dev));
-	snprintf(write_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev1->dev));
+	scnprintf(read_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev0->dev));
+	scnprintf(write_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev1->dev));
 
 	ret = add_channel(cdev0, type, priv);
 	if (ret) {
diff --git a/drivers/s390/net/ctcm_main.h b/drivers/s390/net/ctcm_main.h
index 90bd7b3f80c3..25164e8bf13d 100644
--- a/drivers/s390/net/ctcm_main.h
+++ b/drivers/s390/net/ctcm_main.h
@@ -100,6 +100,7 @@ enum ctcm_channel_types {
 #define CTCM_PROTO_MPC		4
 #define CTCM_PROTO_MAX		4
 
+#define CTCM_STATSIZE_LIMIT	64
 #define CTCM_BUFSIZE_LIMIT	65535
 #define CTCM_BUFSIZE_DEFAULT	32768
 #define MPC_BUFSIZE_DEFAULT	CTCM_BUFSIZE_LIMIT
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 8ac213a55141..64996c86defc 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -144,9 +144,9 @@ void ctcmpc_dumpit(char *buf, int len)
 
 	for (ct = 0; ct < len; ct++, ptr++, rptr++) {
 		if (sw == 0) {
-			sprintf(addr, "%16.16llx", (__u64)rptr);
+			scnprintf(addr, sizeof(addr), "%16.16llx", (__u64)rptr);
 
-			sprintf(boff, "%4.4X", (__u32)ct);
+			scnprintf(boff, sizeof(boff), "%4.4X", (__u32)ct);
 			bhex[0] = '\0';
 			basc[0] = '\0';
 		}
@@ -155,7 +155,7 @@ void ctcmpc_dumpit(char *buf, int len)
 		if (sw == 8)
 			strcat(bhex, "	");
 
-		sprintf(tbuf, "%2.2llX", (__u64)*ptr);
+		scnprintf(tbuf, sizeof(tbuf), "%2.2llX", (__u64)*ptr);
 
 		tbuf[2] = '\0';
 		strcat(bhex, tbuf);
@@ -171,8 +171,8 @@ void ctcmpc_dumpit(char *buf, int len)
 			continue;
 		if ((strcmp(duphex, bhex)) != 0) {
 			if (dup != 0) {
-				sprintf(tdup,
-					"Duplicate as above to %s", addr);
+				scnprintf(tdup, sizeof(tdup),
+					  "Duplicate as above to %s", addr);
 				ctcm_pr_debug("		       --- %s ---\n",
 						tdup);
 			}
@@ -197,14 +197,16 @@ void ctcmpc_dumpit(char *buf, int len)
 			strcat(basc, " ");
 		}
 		if (dup != 0) {
-			sprintf(tdup, "Duplicate as above to %s", addr);
+			scnprintf(tdup, sizeof(tdup),
+				  "Duplicate as above to %s", addr);
 			ctcm_pr_debug("		       --- %s ---\n", tdup);
 		}
 		ctcm_pr_debug("   %s (+%s) : %s  [%s]\n",
 					addr, boff, bhex, basc);
 	} else {
 		if (dup >= 1) {
-			sprintf(tdup, "Duplicate as above to %s", addr);
+			scnprintf(tdup, sizeof(tdup),
+				  "Duplicate as above to %s", addr);
 			ctcm_pr_debug("		       --- %s ---\n", tdup);
 		}
 		if (dup != 0) {
@@ -291,7 +293,7 @@ static struct net_device *ctcmpc_get_dev(int port_num)
 	struct net_device *dev;
 	struct ctcm_priv *priv;
 
-	sprintf(device, "%s%i", MPC_DEVICE_NAME, port_num);
+	scnprintf(device, sizeof(device), "%s%i", MPC_DEVICE_NAME, port_num);
 
 	dev = __dev_get_by_name(&init_net, device);
 
diff --git a/drivers/s390/net/ctcm_sysfs.c b/drivers/s390/net/ctcm_sysfs.c
index 98680c2cc4e4..0c5d8a3eaa2e 100644
--- a/drivers/s390/net/ctcm_sysfs.c
+++ b/drivers/s390/net/ctcm_sysfs.c
@@ -86,24 +86,24 @@ static void ctcm_print_statistics(struct ctcm_priv *priv)
 		return;
 	p = sbuf;
 
-	p += sprintf(p, "  Device FSM state: %s\n",
-		     fsm_getstate_str(priv->fsm));
-	p += sprintf(p, "  RX channel FSM state: %s\n",
-		     fsm_getstate_str(priv->channel[CTCM_READ]->fsm));
-	p += sprintf(p, "  TX channel FSM state: %s\n",
-		     fsm_getstate_str(priv->channel[CTCM_WRITE]->fsm));
-	p += sprintf(p, "  Max. TX buffer used: %ld\n",
-		     priv->channel[WRITE]->prof.maxmulti);
-	p += sprintf(p, "  Max. chained SKBs: %ld\n",
-		     priv->channel[WRITE]->prof.maxcqueue);
-	p += sprintf(p, "  TX single write ops: %ld\n",
-		     priv->channel[WRITE]->prof.doios_single);
-	p += sprintf(p, "  TX multi write ops: %ld\n",
-		     priv->channel[WRITE]->prof.doios_multi);
-	p += sprintf(p, "  Netto bytes written: %ld\n",
-		     priv->channel[WRITE]->prof.txlen);
-	p += sprintf(p, "  Max. TX IO-time: %u\n",
-		     jiffies_to_usecs(priv->channel[WRITE]->prof.tx_time));
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  Device FSM state: %s\n",
+		       fsm_getstate_str(priv->fsm));
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  RX channel FSM state: %s\n",
+		       fsm_getstate_str(priv->channel[CTCM_READ]->fsm));
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  TX channel FSM state: %s\n",
+		       fsm_getstate_str(priv->channel[CTCM_WRITE]->fsm));
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  Max. TX buffer used: %ld\n",
+		       priv->channel[WRITE]->prof.maxmulti);
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  Max. chained SKBs: %ld\n",
+		       priv->channel[WRITE]->prof.maxcqueue);
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  TX single write ops: %ld\n",
+		       priv->channel[WRITE]->prof.doios_single);
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  TX multi write ops: %ld\n",
+		       priv->channel[WRITE]->prof.doios_multi);
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  Netto bytes written: %ld\n",
+		       priv->channel[WRITE]->prof.txlen);
+	p += scnprintf(p, CTCM_STATSIZE_LIMIT, "  Max. TX IO-time: %u\n",
+		       jiffies_to_usecs(priv->channel[WRITE]->prof.tx_time));
 
 	printk(KERN_INFO "Statistics for %s:\n%s",
 				priv->channel[CTCM_WRITE]->netdev->name, sbuf);
-- 
2.39.2


