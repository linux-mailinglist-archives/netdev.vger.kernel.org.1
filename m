Return-Path: <netdev+bounces-303265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L87NDUraQ2r5kAoAu9opvQ
	(envelope-from <netdev+bounces-303265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:01:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EA6E5AD5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:01:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=GFXfOUZu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303265-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303265-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 155593126253
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20144B681;
	Tue, 30 Jun 2026 14:54:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791743DA25
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831271; cv=none; b=B3+TfTfiPpsYJgEMHMBHF4gChtcewSNhH8XmPcAKfh0/NyAviugrfvs5+D3cVCuj7d87JTnDIMk5q1qTImvlaqpYl+8xPyoR2iPNDgJyQTiJUueymR7RxROiWiXdY1dzqtj25Y+WqfDjvcD9s0Vvrhz5GrFqx2WDJlv0HwwZ1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831271; c=relaxed/simple;
	bh=+0qL4Nq5XDgLiyYoRDkp7UFQ3SNvan6mgj0/ffp++aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9pSSxFiZch6/F7B9IKxWPvnQXW+4HIZmf7FdhFvWSvCfqrd1XvzxfDYTXXKt2oQovPqrS58wW97zEYLAXjkmAPEAmXSmnK6lR9rFXs2ZQQ3Oe6OSd8sS6HIDpb7oziAMPuQt4154MFdzO9HbLHT7tmN0eZrlG+5FAeMAtMzNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GFXfOUZu; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIRb52171487;
	Tue, 30 Jun 2026 14:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eth5XrNWWBh4tENkm
	fKvSNGeeLnYMF2x3/+7Xl0TsYk=; b=GFXfOUZu/Hoy19eUmg1wq/TLe5igcwiJR
	wp0rlXVCxso7GcPFG+1mtdb4NvBu0u4dfEvl5YqutJuBXqM9zmymVhQMBBnH3oRu
	tkWICx3M2MqvO/JkkT089bHJoAs4Nl+rKIpsdUdTivAKrXB1EyApL/73Hz8Dmhzx
	ftc4V0hhCmnIT3j580Bf6mlNb6LwWz0EPdMZHf9zEpznHZbwikdz2MfM4taK7JEA
	MNBWECnr8hqqt1qYMHNZE6EoAnhpq0Fk7z8cqqENv6Lc05C85B7jmRWcoJi9vOS0
	HCOzLh6GJNokMBP9TBX82jwDIYml/t9yalOxOi/dWML89QUXHHkuQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9y5bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnqTG025898;
	Tue, 30 Jun 2026 14:54:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gaku5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UEsDw534079362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:54:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9D155805A;
	Tue, 30 Jun 2026 14:54:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E11E5805D;
	Tue, 30 Jun 2026 14:54:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:54:12 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 16/18] ibmveth: Implement incremental MQ RX queue resize
Date: Tue, 30 Jun 2026 07:53:23 -0700
Message-Id: <f2aa676604b63b7e2c4797da911e9bc8dc2e83ab.1782758799.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1782758799.git.mmc@linux.ibm.com>
References: <cover.1782758799.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX/5mv07b53fb1
 lKtfoxOWdI6s8iI3otUtjFpMUVgy/Xo121SAmmzj8nBjFBQndqP+fAhpS/MqwfD/yNpfJRrSUU5
 QizwR7T2kGBJ9kQuzb2GZKwO860SYfgN0fDHkgj15f/qjyL+NdAE5muRZtUVIC0dE0p7ekF+9vW
 Z3+4XnnLpBcMs7tbr9ltUqea4LhjZ/ujLEOhj2n42oboN91xlYxRiyg6DI8sokuey3fiNw3yIpI
 QPCQXXl9O5+3E5ZTCaA5S6IDFz7Kwk9NvjjIZ/dSd2IO+I5w0sahftYMVEucfdhewQUubSjmGJa
 eb+XzAO4ByZ3zgfVK8xCS61DefARCT2bYUQ+hxqelYCnGmhD1PeqlDBy5yEa91H7wxdgsvXE8XW
 nvzSmrUe2aHSwRgt1mJ10UXPF4g3/DS99JHjQVr07RprxuXbTkVzjumA5fev+XZk0acErl30BHR
 th2oqHmk389r+iPHtlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX5SkQuhCfGZC1
 Aj9sDy638oXZrgIZfnwjgDwTk5/J+ciHdaZlph+Y+eDj5n34vfWK/jboYli2eZz+xCY6zJyvJ/c
 IrcXj5IJwvbXSixvZWM5GnIJRZAo+rg=
X-Proofpoint-GUID: QvBD2HiIMFNXtVuMOQPXz5jBBI5CrObc
X-Proofpoint-ORIG-GUID: ih4IrxeHx9hx8a3AWX_mRaavV7LeOBSg
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a43d898 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=l_etWYYMc1M-NAxKRdsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[mmc@linux.ibm.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E86EA6E5AD5

Add ibmveth_resize_rx_queues_incremental() to grow or shrink
adapter->num_rx_queues while the netdev stays up.

Scale-up, per new queue index:
  alloc RX resources and per-queue pools
  register subordinate queue with PHYP
  request_irq(), then ibmveth_enable_irq(), then napi_enable
  update num_rx_queues, replenish new queues
  netif_set_real_num_rx_queues()

Scale-down disables NAPI on excess queues, drains pending buffers,
disables PHYP IRQ delivery and waits for in-flight handlers with
synchronize_irq() before lowering num_rx_queues, then tears down
IRQ/PHYP/memory.

Reject out-of-range new_count. On scale-down netif failure, re-enable
NAPI on queues not yet torn down. Refresh VIO CMO entitlement after a
successful resize when FW_FEATURE_CMO is enabled.

Scale-up rollback mirrors scale-down: drain posted buffers and wait for
in-flight handlers before deregistering with PHYP.

In replenish_task(), skip queues with queue_index >= num_rx_queues and
require pool->free_map before replenishing so in-flight handlers avoid
queues being torn down without clearing probe-time pool->active on free.

Queue 0 is never removed here. Scale-up failure unwinds only queues
added in this call. ethtool -L wiring is next.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 183 ++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cd0acd1715da..ac4d89a66a8d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -945,18 +945,22 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 	unsigned long flags;
 	int i;
 
-	if (queue_index >= adapter->num_rx_queues)
-		return;
-
 	adapter->replenish_task_cycles++;
 
+	if (queue_index >= adapter->num_rx_queues) {
+		netdev_dbg(adapter->netdev,
+			   "Skipping replenish for freed queue %d (num_queues=%d)\n",
+			   queue_index, adapter->num_rx_queues);
+		return;
+	}
+
 	spin_lock_irqsave(&rxq->replenish_lock, flags);
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
 		struct ibmveth_buff_pool *pool =
 			&adapter->rx_buff_pool[queue_index][i];
 
-		if (pool->active &&
+		if (pool->active && pool->free_map &&
 		    (atomic_read(&pool->available) < pool->threshold))
 			ibmveth_replenish_buffer_pool(adapter, pool,
 						      queue_index);
@@ -1682,7 +1686,7 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
  * the IRQ mapping for subordinate queues. Queue 0 is freed only through
  * ibmveth_free_all_queues() (H_FREE_LOGICAL_LAN).
  */
-static void __maybe_unused
+static void
 ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
 				   int queue_idx)
 {
@@ -1714,6 +1718,175 @@ ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
 	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
 }
 
+/**
+ * ibmveth_resize_rx_queues_incremental - Resize RX queue count incrementally
+ * @adapter: ibmveth adapter structure
+ * @new_count: Target number of RX queues
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Adds or removes RX queues without tearing down the entire adapter.
+ * Active queues continue receiving during scale-up; scale-down drains
+ * excess queues before deregistering them with the hypervisor.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
+				     int new_count, int rxq_entries)
+{
+	struct net_device *netdev = adapter->netdev;
+	u64 mac_address = ether_addr_to_u64(netdev->dev_addr);
+	int old_count = adapter->num_rx_queues;
+	int failed_queue;
+	int rc, i;
+
+	if (old_count == new_count) {
+		netdev_dbg(netdev, "RX queue count unchanged (%d), nothing to do\n",
+			   old_count);
+		return 0;
+	}
+
+	if (new_count < 1 || new_count > IBMVETH_MAX_RX_QUEUES) {
+		netdev_err(netdev, "Invalid RX queue count %d (must be 1-%d)\n",
+			   new_count, IBMVETH_MAX_RX_QUEUES);
+		return -EINVAL;
+	}
+
+	netdev_info(netdev, "Incrementally resizing RX queues: %d to %d\n",
+		    old_count, new_count);
+
+	if (new_count > old_count) {
+		netdev_dbg(netdev, "Scale-up: adding queues %d-%d\n",
+			   old_count, new_count - 1);
+
+		for (i = old_count; i < new_count; i++) {
+			rc = ibmveth_alloc_single_rx_queue(adapter, i, rxq_entries);
+			if (rc) {
+				netdev_err(netdev, "Failed to allocate queue %d: %d\n",
+					   i, rc);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_register_single_rx_queue(adapter, i,
+							      mac_address);
+			if (rc) {
+				netdev_err(netdev, "Failed to register queue %d: %d\n",
+					   i, rc);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_setup_single_rx_interrupt(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to setup IRQ for queue %d: %d\n",
+					   i, rc);
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to enable IRQ for queue %d: %d\n",
+					   i, rc);
+				ibmveth_cleanup_single_rx_interrupt(adapter, i);
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			napi_enable(&adapter->napi[i]);
+		}
+
+		adapter->num_rx_queues = new_count;
+
+		for (i = old_count; i < new_count; i++)
+			ibmveth_replenish_task(adapter, i);
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			goto cleanup_new_queues;
+		}
+	} else {
+		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
+			   new_count, old_count - 1);
+
+		for (i = new_count; i < old_count; i++)
+			napi_disable(&adapter->napi[i]);
+
+		for (i = new_count; i < old_count; i++)
+			ibmveth_drain_rx_queue(adapter, i);
+
+		synchronize_net();
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			for (i = new_count; i < old_count; i++)
+				napi_enable(&adapter->napi[i]);
+			return rc;
+		}
+
+		/* Disable hypervisor interrupts and wait for handlers to complete
+		 * before updating num_rx_queues.
+		 */
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
+
+		adapter->num_rx_queues = new_count;
+
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_cleanup_single_rx_interrupt(adapter, i);
+			ibmveth_deregister_single_rx_queue(adapter, i);
+			ibmveth_free_single_rx_queue(adapter, i);
+		}
+	}
+
+	netdev_info(netdev, "Successfully resized to %d RX queues (incremental)\n",
+		    adapter->num_rx_queues);
+
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dev_desired(adapter->vdev,
+					ibmveth_get_desired_dma(adapter->vdev));
+
+	return 0;
+
+cleanup_new_queues:
+	failed_queue = i;
+	netdev_err(netdev,
+		   "Scale-up failed at queue %d, cleaning up queues %d-%d\n",
+		   failed_queue, old_count, failed_queue - 1);
+	for (i = old_count; i < failed_queue; i++)
+		napi_disable(&adapter->napi[i]);
+
+	for (i = old_count; i < failed_queue; i++)
+		ibmveth_drain_rx_queue(adapter, i);
+
+	synchronize_net();
+
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_cleanup_single_rx_interrupt(adapter, i);
+		ibmveth_deregister_single_rx_queue(adapter, i);
+		ibmveth_free_single_rx_queue(adapter, i);
+	}
+	adapter->num_rx_queues = old_count;
+	netdev_warn(netdev, "Keeping %d queues after scale-up failure\n",
+		    old_count);
+	return rc;
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
-- 
2.39.3 (Apple Git-146)


