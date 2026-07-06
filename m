Return-Path: <netdev+bounces-305213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mItbBvUETGqLewEAu9opvQ
	(envelope-from <netdev+bounces-305213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0744F715198
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:41:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=SrzPztWZ;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305213-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305213-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 528123029FEC
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B01133A9DA;
	Mon,  6 Jul 2026 19:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A4316190
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:37:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366626; cv=none; b=UtVfVxx9TTEShab5C4238A1FMGQegBwwCsIjciM0l1HfjLvPIsVrOyfh2v8QCJYnHtwkag92MKTCygM7VVd4LtNl/dPR2CCQ6+BGF7pDO3K7P+PdTOV/wAjPreeZ3LBQbiQJ9saC25yggHKZAQBIoqlou5mv37fE44QnTD17a30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366626; c=relaxed/simple;
	bh=e4cnca4uK7sGnu2TTNYjN+1pAZTrczRsma8sw+08KeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5I/YCRFmp5HjK9f5y8aNzsywGoLAxEhwvEqnChQKU6RZG+qC/pHOJKWoAqkLHQa+/p/L1mlHnyCpqqoML4JLt6fe79EOpRQb/BCjLvHZZt9HUX5ESkEcxvHExKebL0b1VVpU/aqTiBOHg07Iw/wjv/N/tizHiB4oPl4kWc2JGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SrzPztWZ; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIPHF4050075;
	Mon, 6 Jul 2026 19:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RZjo9KniSD0qcbgoF
	1ISjVcr/SurARDGU5dqH0fFeio=; b=SrzPztWZDB1oo3Wp8GWV4zPB+fWtZ49BN
	kFPMuGiGYVAjt3mgeFd+lQHgxeHTFiumkZat2Uhoai0ZiefStMbnhM9fxrW4m58y
	CtRmpvZAwLLfsY34nXfK/H44O9ZUfTjEaZk8kD73MAmHD5O79Ky9QvudrSnHmgP9
	UkC6AwpQ9L1AUyzHgqnldM5OCrGodAGpMA8+BWAgKmtW1CGmg0f99YKj/McjHNWZ
	bw4nwd3IAZpHt8jMpKWjAbxzR00Gd5DBY/ZdFPiEA2HT0FzdUdDOeYHnUk5VDAOZ
	S9BTQuHG0B7IaPd3BTMge7I5x/NyAH7PLXAQlW2YDBu7dVvYJgfKQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stskjyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYkGQ013179;
	Mon, 6 Jul 2026 19:36:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xxmww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Jao5232375358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:50 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D1255805C;
	Mon,  6 Jul 2026 19:36:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 552F758051;
	Mon,  6 Jul 2026 19:36:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:49 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 09/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Mon,  6 Jul 2026 12:35:57 -0700
Message-Id: <20260706193603.8039-10-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: GpnCdwnLNJ1eLhP2SEpZ8Y3LRis3Ku9f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX67kDlAVLJjtW
 LHTnsW0MNDugH5PHZszOMky4mApZqQO5EUIiBrmBdvvrMEu38RvSpgWJcv3VJbUoL3DTYa42zzj
 DxKaoOVTgt3qNkpJuRNtw9qwZTHtO7M=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4c03d4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DGqNc8_RdM7thkqK1-0A:9
X-Proofpoint-GUID: UfPxPljR_t10C32lCHdiXyi0Vji0WUww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX4p+wMQXFCBpH
 isZzXdEeIjrsYLEmIBJWkLvbbpZrwURpt7kuzGMwdhf4sla+ZREFbMRyhKaE5uqnruEPMiTnD9R
 fQlQ53CnGXu2LWSm6DZ8odW5nwsX6G6vSvDz1KaE9inaXZVXMiqsTm7nlI2uC90myG2/TdZgF6k
 YoEcljQ133rFW2isRjoDacg1VsvPK1131OHo3tONtShAeXDWYvU2sN4ss/Y1VJ00jbunMICxapA
 9AJhaJ31bdoWuJq0xNl9EJ8IGp17hILvqdIorLj7ocI3wJ16oSCqrIq9ICBQNed3ddOdBZNEkkx
 /nScdn0nz5qTaoJERJBsaTjZnjd5ADxYYvMzsZXLxgt5vaAYSm0hH1jZU7HXOd8/x+5Nb+os/Ud
 56uvMSmMD1w8K+m/dypMOvlKGqTeWtxKhH+oYm5IZ3ctM3KVWSsYaWgfw2wqA43Jk/Y0ty+Rcd2
 yVdrLcxxqN1zIJefudA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060195
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0744F715198

Replenish is the last open-path hypervisor call that still needs
per-queue awareness before MQ receive is enabled. Today
ibmveth_replenish_buffer_pool() calls h_add_logical_lan_buffer() or
h_add_logical_lan_buffers() directly; MQ posts via
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against adapter->queue_handle[].

Add ibmveth_add_logical_lan_buffers() to pick the hcall:
multi_queue uses h_add_logical_lan_buffers_queue() (up to 12 buffers,
IOBAs packed with odd counts in the upper 32 bits); legacy uses the
existing single- and multi-buffer hcalls. Count add_buf/add_bufs/
add_bufs_queue in hcall_stats.

Thread queue_index through replenish_task() and replenish_buffer_pool()
so they index rx_buff_pool[queue_index][pool]. All callers still pass
queue 0; legacy hcalls remain the live path until MQ probe enables
multi_queue.

Also split H_FUNCTION handling: legacy batch falls back to single-buffer
mode; multi_queue logs an error on unsupported firmware.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 134 ++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index fa2d4777ffc7..b3b3886c3eed 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -597,11 +597,73 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
 		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
+/**
+ * ibmveth_add_logical_lan_buffers - Add receive buffers to hypervisor
+ * @adapter: ibmveth adapter structure
+ * @descs: array of buffer descriptors to add
+ * @filled: number of valid descriptors in the array
+ * @buff_size: size of each buffer (multi-queue mode only)
+ * @queue_index: RX queue index
+ *
+ * Return: hypervisor return code
+ */
+static long ibmveth_add_logical_lan_buffers(struct ibmveth_adapter *adapter,
+					    union ibmveth_buf_desc *descs,
+					    int filled,
+					    unsigned long buff_size,
+					    int queue_index)
+{
+	struct vio_dev *vdev = adapter->vdev;
+	unsigned long rc;
+
+	if (adapter->multi_queue) {
+		unsigned long buffersznum = (buff_size << 32) | filled;
+		unsigned long ioba[IBMVETH_MAX_RX_PER_HCALL / 2] = {0};
+		int i;
+
+		/* Pack descriptor addresses into ioba pairs.
+		 * Each ioba holds two 32-bit addresses packed into 64 bits:
+		 * - Even descriptors (0,2,4...) go in high 32 bits
+		 * - Odd descriptors (1,3,5...) go in low 32 bits
+		 */
+		for (i = 0; i < filled && i < IBMVETH_MAX_RX_PER_HCALL; i++) {
+			int pair_idx = i / 2;           /* Which pair: 0-5 */
+			int is_high = (i % 2 == 0);     /* High or low 32 bits */
+
+			if (is_high)
+				ioba[pair_idx] = (unsigned long)descs[i].fields.address << 32;
+			else
+				ioba[pair_idx] |= descs[i].fields.address;
+		}
+
+		rc = h_add_logical_lan_buffers_queue(vdev->unit_address,
+						     adapter->queue_handle[queue_index],
+						     buffersznum,
+						     ioba[0], ioba[1], ioba[2],
+						     ioba[3], ioba[4], ioba[5]);
+		adapter->hcall_stats.add_bufs_queue++;
+	} else if (filled == 1) {
+		rc = h_add_logical_lan_buffer(vdev->unit_address,
+					      descs[0].desc);
+		adapter->hcall_stats.add_buf++;
+	} else {
+		rc = h_add_logical_lan_buffers(vdev->unit_address,
+					       descs[0].desc, descs[1].desc,
+					       descs[2].desc, descs[3].desc,
+					       descs[4].desc, descs[5].desc,
+					       descs[6].desc, descs[7].desc);
+		adapter->hcall_stats.add_bufs++;
+	}
+
+	return rc;
+}
+
 /* replenish the buffers for a pool.  note that we don't need to
  * skb_reserve these since they are used for incoming...
  */
 static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
-					  struct ibmveth_buff_pool *pool)
+					  struct ibmveth_buff_pool *pool,
+					  int queue_index)
 {
 	union ibmveth_buf_desc descs[IBMVETH_MAX_RX_PER_HCALL] = {0};
 	u32 remaining = pool->size - atomic_read(&pool->available);
@@ -687,24 +749,15 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		if (!filled)
 			break;
 
-		/* single buffer case*/
-		if (filled == 1)
-			lpar_rc = h_add_logical_lan_buffer(vdev->unit_address,
-							   descs[0].desc);
-		else
-			/* Multi-buffer hcall */
-			lpar_rc = h_add_logical_lan_buffers(vdev->unit_address,
-							    descs[0].desc,
-							    descs[1].desc,
-							    descs[2].desc,
-							    descs[3].desc,
-							    descs[4].desc,
-							    descs[5].desc,
-							    descs[6].desc,
-							    descs[7].desc);
+		lpar_rc = ibmveth_add_logical_lan_buffers(adapter, descs,
+							  filled,
+							  pool->buff_size,
+							  queue_index);
+
 		if (lpar_rc != H_SUCCESS) {
 			dev_warn_ratelimited(dev,
-					     "RX h_add_logical_lan failed: filled=%u, rc=%lu, batch=%u\n",
+					     "RX h_add_logical_lan %s failed: filled=%u, rc=%lu, batch=%u\n",
+					     adapter->multi_queue ? "_queue" : "",
 					     filled, lpar_rc, batch);
 			goto hcall_failure;
 		}
@@ -745,24 +798,19 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		}
 		adapter->replenish_add_buff_failure += filled;
 
-		/*
-		 * If multi rx buffers hcall is no longer supported by FW
-		 * e.g. in the case of Live Partition Migration
-		 */
-		if (batch > 1 && lpar_rc == H_FUNCTION) {
-			/*
-			 * Instead of retry submit single buffer individually
-			 * here just set the max rx buffer per hcall to 1
-			 * buffers will be respleshed next time
-			 * when ibmveth_replenish_buffer_pool() is called again
-			 * with single-buffer case
-			 */
-			netdev_info(adapter->netdev,
-				    "RX Multi buffers not supported by FW, rc=%lu\n",
-				    lpar_rc);
-			adapter->rx_buffers_per_hcall = 1;
-			netdev_info(adapter->netdev,
-				    "Next rx replesh will fall back to single-buffer hcall\n");
+		if (lpar_rc == H_FUNCTION) {
+			if (adapter->multi_queue) {
+				netdev_err(adapter->netdev,
+					   "Unexpected H_FUNCTION from multi-queue buffer add (queue=%d, batch=%d)\n",
+					   queue_index, batch);
+				break;
+			} else if (batch > 1) {
+				netdev_warn(adapter->netdev,
+					    "H_FUNCTION from legacy batch buffer add (batch=%d), falling back to single buffer mode\n",
+					    batch);
+				adapter->rx_buffers_per_hcall = 1;
+				continue;
+			}
 		}
 		break;
 	}
@@ -784,18 +832,24 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 }
 
 /* replenish routine */
-static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
+static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
+				   int queue_index)
 {
 	int i;
 
+	if (queue_index >= adapter->num_rx_queues)
+		return;
+
 	adapter->replenish_task_cycles++;
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
+		struct ibmveth_buff_pool *pool =
+			&adapter->rx_buff_pool[queue_index][i];
 
 		if (pool->active &&
 		    (atomic_read(&pool->available) < pool->threshold))
-			ibmveth_replenish_buffer_pool(adapter, pool);
+			ibmveth_replenish_buffer_pool(adapter, pool,
+						      queue_index);
 	}
 
 	ibmveth_update_rx_no_buffer(adapter);
@@ -2307,7 +2361,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, 0);
 
 	if (frames_processed == budget)
 		goto out;
@@ -2458,7 +2512,7 @@ static void ibmveth_poll_controller(struct net_device *dev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, 0);
 	ibmveth_interrupt(dev->irq, &adapter->napi[0]);
 }
 #endif
-- 
2.39.3 (Apple Git-146)


