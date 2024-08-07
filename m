Return-Path: <netdev+bounces-116616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1012094B1FB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47E2281F2F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07514EC47;
	Wed,  7 Aug 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l+ESdIj8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBBF149DE4
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065506; cv=none; b=Q9/033lPGpXlnNAh+SMFb3RMydju3pkAXTvaGdv5oQ/q3o5M7xmWQYbsnLRapbe2wQTycngBPFfRV2anjp2xchH7bElhQZlaizLrd6ccyanQ/D2ESeQ0gwMFD02KWQRAswWXvuVgvEDLFFfo4m1ylw1MLphz4MqiAgjt0ye5oag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065506; c=relaxed/simple;
	bh=rgO8nEzc5kUApEAn+fC7H7NqXoLNWhU+gdMci1N+jmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZLTdr7fZsjYzI9dC5kIP08Y6DbQAj9XmL+dh+LXfAuI6kyqVRgJib+89O0DqiYas9RucPWiqDiJFejeY1ohcjRiaCOeQJLhEEwhjpV5CIq4laTlj76EK2BECAUDCvOAnoEB8tsnbtHJRxLnWlLEeIRB6W+W+HXwjHD67FwRU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l+ESdIj8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772PFSA023303
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=jHBbKAO/15U34
	gDmTdZiVZXosuKj03Ja/qoyOek5iPo=; b=l+ESdIj8YhtWLLiLxYzG7cdm7D33/
	+Yr3qUcrgfF83tCYWY14tphtQrWdpaiELVE756FpqOAPFpUs9Mt37JTUUWkDzibU
	Rx0bHxPTyPU19eVWw1+p14VAjkTwFqS8nO1hb/rIrJYWjn7vjT/oVxP/tVpNhGDw
	lOmDXcrEGo5mu63BXVSVOeTwo8Zk8FhYlm1hGH60rciCjDgnd16MAHBg9p+Tf0eC
	zP/1FxHzeHk9y/MPxs2iSFa257l0Asa3FuQ2CHzGlr0gN4Ka9aSOSwKwwnAqRFG5
	tXXMqf/hYJUcnktJEJEfSIc+QiRnXa7dar+/QSZt07/BExdOG2+gC6wgw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40umqvuur7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477IqNDS024101
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvpk3pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477LIFl436700868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 21:18:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE1C55806C;
	Wed,  7 Aug 2024 21:18:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80D415807B;
	Wed,  7 Aug 2024 21:18:13 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.4.192])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 21:18:13 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 7/7] ibmvnic: Perform tx CSO during send scrq direct
Date: Wed,  7 Aug 2024 16:18:09 -0500
Message-ID: <20240807211809.1259563-8-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807211809.1259563-1-nnac123@linux.ibm.com>
References: <20240807211809.1259563-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tBLMX9TXjZa_J86DQ5l4qwN5R-pp4WNf
X-Proofpoint-GUID: tBLMX9TXjZa_J86DQ5l4qwN5R-pp4WNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070146

During initialization with the vnic server, a bitstring is communicated
to the client regarding header info needed during CSO (See "VNIC
Capabilities" in PAPR). Most of the time, to be safe, vnic server
requests header info for CSO. When header info is needed, multiple TX
descriptors are required per skb; This limits the driver to use
send_subcrq_indirect instead of send_subcrq_direct.

Previously, the vnic server request for header info was ignored. This
allowed the use of send_sub_crq_direct. Transmissions were successful
because the bitstring returned by vnic server is broad and over
cautionary. It was observed that mlx backing devices could actually
transmit and handle CSO packets without the vnic server receiving
header info (despite the fact that the bitstring requested it).

There was a trust issue: The bitstring was overcautionary. This extra
precaution (requesting header info when the backing device may not use
it) comes at the cost of performance (using direct vs indirect hcalls
has a 30% delta in small packet RR transaction rate). So it has been
requested that the vnic server team tries to ensure that the bitstring
is more exact. In the meantime, disable CSO when it is possible to use
the skb in the send_subcrq_direct path. In other words, calculate the
checksum before handing the packet to FW when the packet is not
segmented and xmit_more is false.

Since the code path is only possible if the skb is non GSO and xmit_more
is false, the cost of doing checksum in the send_subcrq_direct path is
minimal. Any large segmented skb will have xmit_more set to true more
frequently and it is inexpensive to do checksumming on a small skb.
The worst-case workload would be a 9000 MTU TCP_RR test with close
to MTU sized packets (and TSO off). This allows xmit_more to be false
more frequently and open the code path up to use send_subcrq_direct.
Observing trace data (graph-time = 1) and packet rate with this workload
shows minimal performance degradation:

1. NIC does checksum w headers, safely use send_subcrq_indirect:
  - Packet rate: 631k txs
  - Trace data:
    ibmvnic_xmit = 44344685.87 us / 6234576 hits = AVG 7.11 us
      skb_checksum_help = 4.07 us / 2 hits = AVG 2.04 us
       ^ Notice hits, tracing this just for reassurance
      ibmvnic_tx_scrq_flush = 33040649.69 us / 5638441 hits = AVG 5.86 us
        send_subcrq_indirect = 37438922.24 us / 6030859 hits = AVG 6.21 us

2. NIC does checksum w/o headers, dangerously use send_subcrq_direct:
  - Packet rate: 831k txs
  - Trace data:
    ibmvnic_xmit = 48940092.29 us / 8187630 hits = AVG 5.98 us
      skb_checksum_help = 2.03 us / 1 hits = AVG 2.03
      ibmvnic_tx_scrq_flush = 31141879.57 us / 7948960 hits = AVG 3.92 us
        send_subcrq_indirect = 8412506.03 us / 728781 hits = AVG 11.54
         ^ notice hits is much lower b/c send_subcrq_direct was called
                                            ^ wasn't traceable

3. driver does checksum, safely use send_subcrq_direct (THIS PATCH):
  - Packet rate: 829k txs
  - Trace data:
    ibmvnic_xmit = 56696077.63 us / 8066168 hits = AVG 7.03 us
      skb_checksum_help = 8587456.16 us / 7526072 hits = AVG 1.14 us
      ibmvnic_tx_scrq_flush = 30219545.55 us / 7782409 hits = AVG 3.88 us
        send_subcrq_indirect = 8638326.44 us / 763693 hits = AVG 11.31 us

When the bitstring ever specifies that CSO does not require headers
(dependent on VIOS vnic server changes), then this patch should be
removed and replaced with one that investigates the bitstring before
using send_subcrq_direct.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index b687e5396e11..87e693a81433 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2409,6 +2409,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	unsigned long lpar_rc;
 	union sub_crq tx_crq;
 	unsigned int offset;
+	bool use_scrq_send_direct = false;
 	int num_entries = 1;
 	unsigned char *dst;
 	int bufidx = 0;
@@ -2468,6 +2469,18 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	memset(dst, 0, tx_pool->buf_size);
 	data_dma_addr = ltb->addr + offset;
 
+	/* if we are going to send_subcrq_direct this then we need to
+	 * update the checksum before copying the data into ltb. Essentially
+	 * these packets force disable CSO so that we can guarantee that
+	 * FW does not need header info and we can send direct.
+	 */
+	if (!skb_is_gso(skb) && !ind_bufp->index && !netdev_xmit_more()) {
+		use_scrq_send_direct = true;
+		if (skb->ip_summed == CHECKSUM_PARTIAL &&
+		    skb_checksum_help(skb))
+			use_scrq_send_direct = false;
+	}
+
 	if (skb_shinfo(skb)->nr_frags) {
 		int cur, i;
 
@@ -2549,11 +2562,13 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_crq.v1.flags1 |= IBMVNIC_TX_LSO;
 		tx_crq.v1.mss = cpu_to_be16(skb_shinfo(skb)->gso_size);
 		hdrs += 2;
-	} else if (!ind_bufp->index && !netdev_xmit_more()) {
-		ind_bufp->indir_arr[0] = tx_crq;
+	} else if (use_scrq_send_direct) {
+		/* See above comment, CSO disabled with direct xmit */
+		tx_crq.v1.flags1 &= ~(IBMVNIC_TX_CHKSUM_OFFLOAD);
 		ind_bufp->index = 1;
 		tx_buff->num_entries = 1;
 		netdev_tx_sent_queue(txq, skb->len);
+		ind_bufp->indir_arr[0] = tx_crq;
 		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, false);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
-- 
2.43.0


