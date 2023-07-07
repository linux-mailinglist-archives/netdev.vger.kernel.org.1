Return-Path: <netdev+bounces-16010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B75174AEE6
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 12:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6831C20FBC
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EAFBE75;
	Fri,  7 Jul 2023 10:44:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A9BA47
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 10:44:13 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84831737;
	Fri,  7 Jul 2023 03:44:11 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367AJ2Eq022909;
	Fri, 7 Jul 2023 10:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jXhueTSPOHMzlueqvymp8seQ1H++N+GTe725CM9biwY=;
 b=MX+D2ct1BfD0A5mbo6FU8r5n70vr6NWZqiPWu/qWK6PvN7N8UNx22jlyTGQFW+EgWDO6
 Ua6oTAs8FF1qIzFvffBegHqr9RvftKUXXTryJ+rZSI/ErQElzbyFO5/65XqRejx6gVhX
 GeXweDSgkp+NQSl2W5u/ieXme4ZGSGa48gi1jx81XU0ZMw/pNuvXKPA86rCufSCI7AMS
 WJSkV+glBA2D3uVgD6zZ50PfBeDL9PS98y3AopZv5TQkOflfF5FDfECFjUed89ASonG+
 ONQX5GispEPKFGF18cDlkyLGaoR8OzEx3loC8rd+BrzoeV6QMbieNfpSB5pAGNYsCQ5P BA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpgun8m4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 10:44:09 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367AN2NV003223;
	Fri, 7 Jul 2023 10:44:09 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpgun8m3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 10:44:09 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3673dexW014309;
	Fri, 7 Jul 2023 10:44:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rjbddtw1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 10:44:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367Ai2HS19726956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jul 2023 10:44:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCEDE2006C;
	Fri,  7 Jul 2023 10:44:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616AE20067;
	Fri,  7 Jul 2023 10:44:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jul 2023 10:44:02 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>, Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Karcher <jaka@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] s390/ism: Do not unregister clients with registered DMBs
Date: Fri,  7 Jul 2023 12:43:59 +0200
Message-Id: <20230707104359.3324039-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707104359.3324039-1-schnelle@linux.ibm.com>
References: <20230707104359.3324039-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MzfvT2oZq5ivVFuzWudenQfOz_mazAC-
X-Proofpoint-GUID: OqOJMU7ONgozHh55kkrFxnHTPIudG_Ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When ism_unregister_client() is called but the client still has DMBs
registered it returns -EBUSY and prints an error. This only happens
after the client has already been unregistered however. This is
unexpected as the unregister claims to have failed. Furthermore as this
implies a client bug a WARN() is more appropriate. Thus move the
deregistration after the check and use WARN().

Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 54091b7aea16..6df7f377d2f9 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -96,29 +96,32 @@ int ism_unregister_client(struct ism_client *client)
 	int rc = 0;
 
 	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	clients[client->id] = NULL;
-	if (client->id + 1 == max_client)
-		max_client--;
-	mutex_unlock(&clients_lock);
 	list_for_each_entry(ism, &ism_dev_list.list, list) {
 		spin_lock_irqsave(&ism->lock, flags);
 		/* Stop forwarding IRQs and events */
 		ism->subs[client->id] = NULL;
 		for (int i = 0; i < ISM_NR_DMBS; ++i) {
 			if (ism->sba_client_arr[i] == client->id) {
-				pr_err("%s: attempt to unregister client '%s'"
-				       "with registered dmb(s)\n", __func__,
-				       client->name);
+				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
+				     __func__, client->name);
 				rc = -EBUSY;
-				goto out;
+				goto err_reg_dmb;
 			}
 		}
 		spin_unlock_irqrestore(&ism->lock, flags);
 	}
-out:
 	mutex_unlock(&ism_dev_list.mutex);
 
+	mutex_lock(&clients_lock);
+	clients[client->id] = NULL;
+	if (client->id + 1 == max_client)
+		max_client--;
+	mutex_unlock(&clients_lock);
+	return rc;
+
+err_reg_dmb:
+	spin_unlock_irqrestore(&ism->lock, flags);
+	mutex_unlock(&ism_dev_list.mutex);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ism_unregister_client);
-- 
2.39.2


