Return-Path: <netdev+bounces-116240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38494987F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615F31C21608
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE771494A3;
	Tue,  6 Aug 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XANY0o48"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB586146D49
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973045; cv=none; b=X9MUISbRaoOJl7xr671F6dhw6B7T5paxsoVlXxdZr0NAaidQzOKZOAtcxwEPSBa0b+d4bT+C0C7VjZvto+eQeIHofFaeNyxTk/P5wfJIlwey9DhEGpDmHpGSV5QKooUd/MTkSqt0jIQLEzOdYVI0wgyhYLH8YiY4/+CDRdM/GeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973045; c=relaxed/simple;
	bh=pVKxyDBiYQWiB3fop6BaMSwRMEPdMtgFAubT+d6fKbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8Lk1VxKUn5IbkjtiisjhTMp45ymY3kPO7wyHm6zSJReeKIgWTmVCkMI9u3dKXz1a5Y4ENYFuAJsCFIWwQ8Y81ThOGR22YnYUcTy37QDJ7gt1uTlNimfJiJ3OXoZRE7Cb+L17R/8iYpcDk8MOOT7zuGYMRtpVCT+Wn1K8J9Ipt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XANY0o48; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DLZ33031339
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=9F02EwPXI4aT5
	CnW58/zkcJ83XZYJYBHGVtcYK8uSYw=; b=XANY0o48PJf5cpV2U1n6uWRXuQ3xM
	+lC735GG/ud0Zt4NOwKvilV3z9/j2tJtDOCYasHkczWqdPdjN3NNFcy+PN6uUIJx
	vdArjkscEq8CskSE/rLgm71b232+evV+rvXwgjO7F2H8ZoxaWSoebFc9n0HKqjR5
	jEbop+kIn1niKs9Nb1DGQpPP+oHOFlql3bPBmIIjG1nX5LQ2GBM5GI8NblLkG1zj
	v4sABh/uvHC0uKaj6ZXEJZ0YHqpzrBK2rZyjT3/U8vYBsjyZ5rjtReoe5v+U0IJl
	hfdOLa49JmLVpoKUZv4XODhJs+vwm+ugeRIYref603b6EH+puOv+ZkkGA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uf1hsky3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476J2kaK017993
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40t0cmn7gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476JbDAq60686846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 19:37:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74E2858077;
	Tue,  6 Aug 2024 19:37:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A1E658062;
	Tue,  6 Aug 2024 19:37:13 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.153.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 19:37:13 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2 7/7] ibmvnic: Perform tx CSO during send scrq direct
Date: Tue,  6 Aug 2024 14:37:06 -0500
Message-ID: <20240806193706.998148-8-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806193706.998148-1-nnac123@linux.ibm.com>
References: <20240806193706.998148-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mo7L-SvRD1_8fBlVJAPVrRTeO-lZD9Z5
X-Proofpoint-ORIG-GUID: Mo7L-SvRD1_8fBlVJAPVrRTeO-lZD9Z5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_16,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 mlxlogscore=986 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408060137

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
Observing trace data and packet rate with this workload shows minimal
performance degradation:

1. NIC does checksum w headers, safely use send_subcrq_indirect:
  - Packet rate: 631k txs
  - Trace data:
    ibmvnic_xmit = 44344685.87 us / 6234576 hits = AVG 7.11 us
    ibmvnic_tx_scrq_flush = 33040649.69 us / 5638441 hits = AVG 5.86 us
    send_subcrq_indirect = 37438922.24 us / 6030859 hits = AVG 6.21 us
    skb_checksum_help = 4.07 us / 2 hits = AVG 2.04 us
     ^ Notice hits, tracing this just for reassurance

2. NIC does checksum w/o headers, dangerously use send_subcrq_direct:
  - Packet rate: 831k txs
  - Trace data:
    ibmvnic_xmit = 48940092.29 us / 8187630 hits = AVG 5.98 us
    ibmvnic_tx_scrq_flush = 31141879.57 us / 7948960 hits = AVG 3.92 us
    send_subcrq_indirect = 8412506.03 us / 728781 hits = AVG 11.54
     ^ notice hits is much lower
    skb_checksum_help = 2.03 us / 1 hits = AVG 2.03

3. driver does checksum, safely use send_subcrq_direct (THIS PATCH):
  - Packet rate: 829k txs
  - Trace data:
    ibmvnic_xmit = 56696077.63 us / 8066168 hits = AVG 7.03 us
    ibmvnic_tx_scrq_flush = 30219545.55 us / 7782409 hits = AVG 3.88 us
    send_subcrq_indirect = 8638326.44 us / 763693 hits = AVG 11.31 us
    skb_checksum_help = 8587456.16 us / 7526072 hits = AVG 1.14 us

When the bitstring ever specifies that CSO does not require headers
(dependent on VIOS vnic server changes), then this patch should be
removed and replaced with one that investigates the bitstring before
using send_subcrq_direct.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 05c0d68c3efa..1990d518f247 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2406,6 +2406,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	unsigned long lpar_rc;
 	union sub_crq tx_crq;
 	unsigned int offset;
+	bool use_scrq_send_direct = false;
 	int num_entries = 1;
 	unsigned char *dst;
 	int bufidx = 0;
@@ -2465,6 +2466,18 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
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
 
@@ -2546,11 +2559,13 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
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


