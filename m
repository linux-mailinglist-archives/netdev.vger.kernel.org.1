Return-Path: <netdev+bounces-48411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8357EE409
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0FEB20A13
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399531A7E;
	Thu, 16 Nov 2023 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tj85W4tW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1AE195
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:19:39 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGFFHr2005453;
	Thu, 16 Nov 2023 15:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zzZ32tTgRNSb2ua0SnhVIVGZH87LnQAqUHUs0Im3qh0=;
 b=tj85W4tWSVG2WUE4cdX8XNBmDTD56oaT/vFXTldb5I9CKWEMbD37rjLM39Ayjswii/FC
 lIf3bb74DXsXqninXQX9saqTDZm9ggbair52dZX8BAtZUNCAmCQT/G/OFiLnFRP4Gqcd
 +aGyrumnFhbi1/cTGy7cYhLHnwCpfohdzqrA6NDOXZPRBf9qkCK7Ox/OHwvYlM1GZ6ty
 tJEnp3+fHUdcvjgrARcvB7jT76V3Ra3BjijWi5jQCw4nVGxDOOrNKVeuOtJvxJiPEqyN
 mXPrQBJ7+0sqCIvwqBDj2F95m1FNlXy6C8iuXK8diCer0nyWv/GscM4nC8tyPMnBToRI OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udnjd84r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 15:19:32 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGFHAUd014166;
	Thu, 16 Nov 2023 15:19:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udnjd84px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 15:19:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGFJ1RC012139;
	Thu, 16 Nov 2023 15:19:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnqe2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 15:19:30 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGFJUSU11338392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 15:19:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBE8858059;
	Thu, 16 Nov 2023 15:19:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAEFF58058;
	Thu, 16 Nov 2023 15:19:29 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Nov 2023 15:19:29 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: mchan@broadcom.com
Cc: pavan.chebbi@broadcom.com, netdev@vger.kernel.org, prashant@broadcom.com,
        siva.kallam@broadcom.com, drc@linux.vnet.ibm.com,
        venkata.sai.duggi@ibm.com, thinhtr@linux.vnet.ibm.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
Subject: [PATCH v3] net/tg3: fix race condition in tg3_reset_task()
Date: Thu, 16 Nov 2023 09:18:22 -0600
Message-Id: <20231116151822.281-1-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
References: <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1udnFHlFgsNrt66vBHY4kjT-v9jiVM8I
X-Proofpoint-GUID: bzeaEeSqGctd7lk-SGOzF7yofCU8Dy4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_15,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=975 bulkscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160119

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

  v3: re-post the patch.
  v2: checking PCI errors in tg3_tx_timeout()

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


