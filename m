Return-Path: <netdev+bounces-45773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B897DF77B
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B861C20EA9
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72C1DA21;
	Thu,  2 Nov 2023 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jXifKv0W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D71CF86
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 16:16:36 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964CE3
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:16:35 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2FoRnh023809;
	Thu, 2 Nov 2023 16:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TIVce9mbYtaD3CAal2n1sZC4w7tuC8q8EcVtDoD9xnM=;
 b=jXifKv0WVg0Em/+PDr/VOIhIvkxSkHMS8TM3qXK4B7ZzgdNAzKewJ1B68i2tu1Ic5LL2
 MlWC5VWNEC+fzQnl7vJMJKUe3FlQDSNHeNyldtvSqYpzRLDAM0TBQU8zDByRarOd0Fet
 lCbT/07Ojx6MNQjG3WEj04iybw2gKl+ma2iampaeD9nF4f6yxOFDO+v6BTtFL+BFX1kL
 G8JZtcvbduSrz05uYlRNAYov6E0Nj9XIHBqD//dS2E+9HwIr6O+frkJVyRj9c6cpTnra
 5VEctXXn78+aqWw5YeDZpHnLOl+tR312hpAn6y0dzR5DuwOQ/dcfmX2Cs+5n+XWsKfYY Tw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4e60j4qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Nov 2023 16:16:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2EoSub020285;
	Thu, 2 Nov 2023 16:12:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1d0yyy02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Nov 2023 16:12:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A2GCM5v57409894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Nov 2023 16:12:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D17B5805A;
	Thu,  2 Nov 2023 16:12:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC97258054;
	Thu,  2 Nov 2023 16:12:21 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Nov 2023 16:12:21 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, pavan.chebbi@broadcom.com, drc@linux.vnet.ibm.com
Cc: venkata.sai.duggi@ibm.com, Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [PATCH v2] net/tg3: fix race condition in tg3_reset_task()
Date: Thu,  2 Nov 2023 11:12:19 -0500
Message-Id: <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VxFN2bcif8r9rBvBXfaiQImdMbc7RWCj
X-Proofpoint-ORIG-GUID: VxFN2bcif8r9rBvBXfaiQImdMbc7RWCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_05,2023-11-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020130

When an EEH error is encountered by a PCI adapter, the EEH driver
modifies the PCI channel's state as shown below:

   enum {
      /* I/O channel is in normal state */
      pci_channel_io_normal = (__force pci_channel_state_t) 1,

      /* I/O to channel is blocked */
      pci_channel_io_frozen = (__force pci_channel_state_t) 2,

      /* PCI card is dead */
      pci_channel_io_perm_failure = (__force pci_channel_state_t) 3,
   };

If the same EEH error then causes the tg3 driver's transmit timeout
logic to execute, the tg3_tx_timeout() function schedules a reset
task via tg3_reset_task_schedule(), which may cause a race condition
between the tg3 and EEH driver as both attempt to recover the HW via
a reset action.

EEH driver gets error event
--> eeh_set_channel_state()
    and set device to one of
    error state above		scheduler: tg3_reset_task() get 
   				returned error from tg3_init_hw()
			     --> dev_close() shuts down the interface

tg3_io_slot_reset() and 
tg3_io_resume() fail to
reset/resume the device


To resolve this issue, we avoid the race condition by checking the PCI
channel state in the tg3_tx_timeout() function and skip the tg3 driver
initiated reset when the PCI channel is not in the normal state.  (The
driver has no access to tg3 device registers at this point and cannot
even complete the reset task successfully without external assistance.)
We'll leave the reset procedure to be managed by the EEH driver which
calls the tg3_io_error_detected(), tg3_io_slot_reset() and 
tg3_io_resume() functions as appropriate. 



Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Tested-by: Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
Reviewed-by: David Christensen <drc@linux.vnet.ibm.com>

---
 drivers/net/ethernet/broadcom/tg3.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 14b311196b8f..1c72ef05ab1b 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7630,6 +7630,26 @@ static void tg3_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct tg3 *tp = netdev_priv(dev);
 
+	/* checking the PCI channel state for hard errors
+	 * for pci_channel_io_frozen case
+	 *   - I/O to channel is blocked.
+	 *     The EEH layer and I/O error detections will
+	 *     handle the reset procedure
+	 * for pci_channel_io_perm_failure  case
+	 *   - the PCI card is dead.
+	 *     The reset will not help
+	 * report the error for both cases and return.
+	 */
+	if (tp->pdev->error_state == pci_channel_io_frozen) {
+		netdev_err(dev, " %s, I/O to channel is blocked\n", __func__);
+		return;
+	}
+
+	if (tp->pdev->error_state == pci_channel_io_perm_failure) {
+		netdev_err(dev, " %s, adapter has failed permanently!\n", __func__);
+		return;
+	}
+
 	if (netif_msg_tx_err(tp)) {
 		netdev_err(dev, "transmit timed out, resetting\n");
 		tg3_dump_state(tp);
-- 
2.25.1


