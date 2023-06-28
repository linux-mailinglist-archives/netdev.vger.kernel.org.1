Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47A27417F1
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjF1SWv (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 14:22:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231388AbjF1SWu (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 14:22:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SIIllA004930
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 18:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=VoNlCvqm1Oa3F/NJYdHzYGSoMvakI4Kaz35WWNZEr4I=;
 b=Euw84znQyJf8VjCXSnzocpL7I7y7GbSJ6itUhSIhJ82JtNSblTt+Orp8DIxXOPut46B+
 +A1JjzpSxkcQTNVz6PsUpX/Zxuw9GJef8pQ00Pn+GrJ6Q+aV+nWZeqrukVqABj9w1Qqh
 bObysfuyFLFXCYZQNfdaMJMF6nPvqb8S6+gjSBbk6olIQOfPuLdIK3iWlkvd+83OAIQx
 erVGieIWUMvtJZ5o3ecTJKjrhgwBIvLaSGi1mRinOVCTw47+3HMRY4hE0VcWa49AKoBC
 eYHbLpQh0q01pa5Oy1qQd268pxqzQeZBWjtwEPN8WHIuF7GqLl2xi6y8P3n1/JwSeltS cw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgt1h03nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 18:22:49 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHVbJ3023990
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 18:22:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3rdr467a8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 18:22:48 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SIMknk63963534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:22:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4BBC5805E;
        Wed, 28 Jun 2023 18:22:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A821F5805A;
        Wed, 28 Jun 2023 18:22:46 +0000 (GMT)
Received: from li-8d37cfcc-31b9-11b2-a85c-83226d7135c9.austin.ibm.com (unknown [9.24.4.46])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 18:22:46 +0000 (GMT)
From:   Nick Child <nnac123@linux.ibm.com>
To:     netdev@vger.kernel.org
Cc:     haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH v2 net] ibmvnic: Do not reset dql stats on NON_FATAL err
Date:   Wed, 28 Jun 2023 13:22:44 -0500
Message-Id: <20230628182244.23878-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3W7jZeHs8jeohKYEjSogHbD-8GxOM4jF
X-Proofpoint-GUID: 3W7jZeHs8jeohKYEjSogHbD-8GxOM4jF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_12,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=825
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306280162
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

All ibmvnic resets, make a call to netdev_tx_reset_queue() when
re-opening the device. netdev_tx_reset_queue() resets the num_queued
and num_completed byte counters. These stats are used in Byte Queue
Limit (BQL) algorithms. The difference between these two stats tracks
the number of bytes currently sitting on the physical NIC. ibmvnic
increases the number of queued bytes though calls to
netdev_tx_sent_queue() in the drivers xmit function. When, VIOS reports
that it is done transmitting bytes, the ibmvnic device increases the
number of completed bytes through calls to netdev_tx_completed_queue().
It is important to note that the driver batches its transmit calls and
num_queued is increased every time that an skb is added to the next
batch, not necessarily when the batch is sent to VIOS for transmission.

Unlike other reset types, a NON FATAL reset will not flush the sub crq
tx buffers. Therefore, it is possible for the batched skb array to be
partially full. So if there is call to netdev_tx_reset_queue() when
re-opening the device, the value of num_queued (0) would not account
for the skb's that are currently batched. Eventually, when the batch
is sent to VIOS, the call to netdev_tx_completed_queue() would increase
num_completed to a value greater than the num_queued. This causes a
BUG_ON crash:

ibmvnic 30000002: Firmware reports error, cause: adapter problem.
Starting recovery...
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:27!
Oops: Exception in kernel mode, sig: 5
[....]
NIP dql_completed+0x28/0x1c0
LR ibmvnic_complete_tx.isra.0+0x23c/0x420 [ibmvnic]
Call Trace:
ibmvnic_complete_tx.isra.0+0x3f8/0x420 [ibmvnic] (unreliable)
ibmvnic_interrupt_tx+0x40/0x70 [ibmvnic]
__handle_irq_event_percpu+0x98/0x270
---[ end trace ]---

Therefore, do not reset the dql stats when performing a NON_FATAL reset.

Fixes: 0d973388185d ("ibmvnic: Introduce xmit_more support using batched subCRQ hcalls")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
v1 - https://lore.kernel.org/netdev/20230622190332.29223-1-nnac123@linux.ibm.com/
Changes since v1:
 - Do not clear the STACK_XOFF bit because we are garaunteed it is already cleared
 drivers/net/ethernet/ibm/ibmvnic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index c63d3ec9d328..763d613adbcc 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1816,7 +1816,14 @@ static int __ibmvnic_open(struct net_device *netdev)
 		if (prev_state == VNIC_CLOSED)
 			enable_irq(adapter->tx_scrq[i]->irq);
 		enable_scrq_irq(adapter, adapter->tx_scrq[i]);
-		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
+		/* netdev_tx_reset_queue will reset dql stats. During NON_FATAL
+		 * resets, don't reset the stats because there could be batched
+		 * skb's waiting to be sent. If we reset dql stats, we risk
+		 * num_completed being greater than num_queued. This will cause
+		 * a BUG_ON in dql_completed().
+		 */
+		if (adapter->reset_reason != VNIC_RESET_NON_FATAL)
+			netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
 	}
 
 	rc = set_link_state(adapter, IBMVNIC_LOGICAL_LNK_UP);
-- 
2.31.1

