Return-Path: <netdev+bounces-26079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A86776BF9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D6A281DE6
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2421C1DDE2;
	Wed,  9 Aug 2023 22:10:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1362224535
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:10:51 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F635FE
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:10:50 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Lw0cD018766;
	Wed, 9 Aug 2023 22:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bFpKX8RrkXwdOkBViyX8RsTJAPLr6mKyFGKzcEqvI4Y=;
 b=eDJVL71t9ZGDentYZNatYw2iJvHKOh4ykjMg2qa+I5Gm9jQVQzyJMs0NlABlUJnx7ag8
 Zf0Yaq5f+H75yU1I52Mhcwtd9nk0fnR3Q5VlA2obMlXo0aebP8T7cJzhSU9iK5XiuPFj
 kBV1iqUrrmuaHwqCxjMnAc0Z1iLgvOlQPn8EW5PkFthQG2xo3gXQbaH9f2c2aDG7MtfR
 bu+sjNxxjkKGxR3aa6yZID5xJmqNyCT2fC8gVQa+zj6kcp67ZKVUYiK76YvYehR+GtUL
 JS62yVNnmI7g4U0lBLEjDloYAQ1l8FEpX9gLCVzthn8ZmzjfMtLAdPbpXI3S8LKQsoGL Sg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sck6907rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Aug 2023 22:10:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379KmhF7006666;
	Wed, 9 Aug 2023 22:10:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rtch0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Aug 2023 22:10:46 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379MAjbw22872644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Aug 2023 22:10:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30BE05803F;
	Wed,  9 Aug 2023 22:10:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06F695806A;
	Wed,  9 Aug 2023 22:10:45 +0000 (GMT)
Received: from li-8d37cfcc-31b9-11b2-a85c-83226d7135c9.austin.ibm.com (unknown [9.24.4.46])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Aug 2023 22:10:44 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, danymadden@us.ibm.com,
        tlfalcon@linux.ibm.com, bjking1@linux.ibm.com,
        Nick Child <nnac123@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 4/5] ibmvnic: Do partial reset on login failure
Date: Wed,  9 Aug 2023 17:10:37 -0500
Message-Id: <20230809221038.51296-4-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230809221038.51296-1-nnac123@linux.ibm.com>
References: <20230809221038.51296-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u-v5DgtK9fgQ4Nbm164T9OnZeXkK_w4h
X-Proofpoint-ORIG-GUID: u-v5DgtK9fgQ4Nbm164T9OnZeXkK_w4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_19,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090190
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Perform a partial reset before sending a login request if any of the
following are true:
 1. If a previous request times out. This can be dangerous because the
 	VIOS could still receive the old login request at any point after
 	the timeout. Therefore, it is best to re-register the CRQ's  and
 	sub-CRQ's before retrying.
 2. If the previous request returns an error that is not described in
 	PAPR. PAPR provides procedures if the login returns with partial
 	success or aborted return codes (section L.5.1) but other values
	do not have a defined procedure. Previously, these conditions
	just returned error from the login function rather than trying
	to resolve the issue.
 	This can cause further issues since most callers of the login
 	function are not prepared to handle an error when logging in. This
 	improper cleanup can lead to the device being permanently DOWN'd.
 	For example, if the VIOS believes that the device is already logged
 	in then it will return INVALID_STATE (-7). If we never re-register
 	CRQ's then it will always think that the device is already logged
 	in. This leaves the device inoperable.

The partial reset involves freeing the sub-CRQs, freeing the CRQ then
registering and initializing a new CRQ and sub-CRQs. This essentially
restarts all communication with VIOS to allow for a fresh login attempt
that will be unhindered by any previous failed attempts.

Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 46 ++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 77b0a744fa88..e9619957d58a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -97,6 +97,8 @@ static int pending_scrq(struct ibmvnic_adapter *,
 static union sub_crq *ibmvnic_next_scrq(struct ibmvnic_adapter *,
 					struct ibmvnic_sub_crq_queue *);
 static int ibmvnic_poll(struct napi_struct *napi, int data);
+static int reset_sub_crq_queues(struct ibmvnic_adapter *adapter);
+static inline void reinit_init_done(struct ibmvnic_adapter *adapter);
 static void send_query_map(struct ibmvnic_adapter *adapter);
 static int send_request_map(struct ibmvnic_adapter *, dma_addr_t, u32, u8);
 static int send_request_unmap(struct ibmvnic_adapter *, u8);
@@ -1527,11 +1529,9 @@ static int ibmvnic_login(struct net_device *netdev)
 
 		if (!wait_for_completion_timeout(&adapter->init_done,
 						 timeout)) {
-			netdev_warn(netdev, "Login timed out, retrying...\n");
-			retry = true;
-			adapter->init_done_rc = 0;
-			retry_count++;
-			continue;
+			netdev_warn(netdev, "Login timed out\n");
+			adapter->login_pending = false;
+			goto partial_reset;
 		}
 
 		if (adapter->init_done_rc == ABORTED) {
@@ -1576,7 +1576,41 @@ static int ibmvnic_login(struct net_device *netdev)
 		} else if (adapter->init_done_rc) {
 			netdev_warn(netdev, "Adapter login failed, init_done_rc = %d\n",
 				    adapter->init_done_rc);
-			return -EIO;
+
+partial_reset:
+			/* adapter login failed, so free any CRQs or sub-CRQs
+			 * and register again before attempting to login again.
+			 * If we don't do this then the VIOS may think that
+			 * we are already logged in and reject any subsequent
+			 * attempts
+			 */
+			netdev_warn(netdev,
+				    "Freeing and re-registering CRQs before attempting to login again\n");
+			retry = true;
+			adapter->init_done_rc = 0;
+			retry_count++;
+			release_sub_crqs(adapter, true);
+			reinit_init_done(adapter);
+			release_crq_queue(adapter);
+			/* If we don't sleep here then we risk an unnecessary
+			 * failover event from the VIOS. This is a known VIOS
+			 * issue caused by a vnic device freeing and registering
+			 * a CRQ too quickly.
+			 */
+			msleep(1500);
+			rc = init_crq_queue(adapter);
+			if (rc) {
+				netdev_err(netdev, "login recovery: init CRQ failed %d\n",
+					   rc);
+				return -EIO;
+			}
+
+			rc = ibmvnic_reset_init(adapter, false);
+			if (rc) {
+				netdev_err(netdev, "login recovery: Reset init failed %d\n",
+					   rc);
+				return -EIO;
+			}
 		}
 	} while (retry);
 
-- 
2.39.3


