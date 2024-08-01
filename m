Return-Path: <netdev+bounces-115133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3C94541B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485511F248EE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417814D2A8;
	Thu,  1 Aug 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nlNl+VW5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185C14BF8B
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547437; cv=none; b=WNCLbIrK4UsRttqlAsp0XEG0KlB/673Pohrte2oXZu9Y7Z/JtL/jtmPAr9ZNpYx6RHS6C6S9cpBTnBpdIEY5hr/BmXkyzHEmk59FrJLteprmNtLWqY1MCYjg2xznfl0xSxH5jKhmG3qA+cbmIiSs5rbB+Qj+MHMDK0eD8Un4WTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547437; c=relaxed/simple;
	bh=s8ZYP69m2oV6AxGKuTielUPsKCvuBr3Xzck9IUlU5fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyiElTHy8osV2C1AOMUQraACEIQAEgCJTwyWKKXzuwivLuuFUwMbytt5OhAFWpwgrlWZfJQucVOs+rbGf5zFk9yW1w4nGLVFDYqEScLTvke8rRrlPKIfmLjpqFKilDOu1y+/xZ2BtOI5DY8UV1ZcnFLrLtQkC85kQFape4yM3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nlNl+VW5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471Kv08E002945
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=boxQSGhWvCVEF
	Yk6Vvo3QUjcEEgcgGgzVr9fjfbYHQ8=; b=nlNl+VW5Qri84W8Tzav/VXnL6EbsF
	voFYimyfIZvx+0+R7A14i/W/pwRlEuABsXRKlfw47HYpxMXQ/+cVbWjC9khjwjK3
	GsPS9n6/Xk9XBpkSQyNLiZvzvLYeE2XsutEggGgfVWmvSVK8bpCvqdV3Ev6urzbN
	Gl8HXTWavjGzf5t09AmLwgMWd/W0RMk6N+xMOIiOu0Ys+MUfxGI7WuH2qzEiILiP
	BH3LAIwmCMTtokNNxZwCvQPe2GkG95LZLSmh/RiB85AdkoCYg+J+gBXp6nkZ6pKm
	mCPJyLLd7j5KoaMLrDxMRAUiMpjac7Qpr+chX8bz0k4jXkvo+PEWy5FLw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rh02r55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471HuxWk029094
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm1449v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471LNlir32440884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 21:23:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34BD958059;
	Thu,  1 Aug 2024 21:23:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B853258058;
	Thu,  1 Aug 2024 21:23:46 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.139.48])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 21:23:46 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next 7/7] ibmvnic: Perform tx CSO during send scrq direct
Date: Thu,  1 Aug 2024 16:23:40 -0500
Message-ID: <20240801212340.132607-8-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801212340.132607-1-nnac123@linux.ibm.com>
References: <20240801212340.132607-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GeCsqzgyQihPJn4LEOyL9qelASDPBG-4
X-Proofpoint-GUID: GeCsqzgyQihPJn4LEOyL9qelASDPBG-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_19,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=764 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010142

During initialization with the vnic server, a bitstring is communicated
to the client regarding header info needed during CSO (See "VNIC
Capabilities" in PAPR). Most of the time, to be safe, vnic server
requests header info for CSO. When header info is needed, multiple TX
descriptors are required per skb; This limits the driver to use
send_subcrq_indirect instead of send_subcrq_direct.

Previously, the vnic server request for header info was ignored. This
allowed the use of send_sub_crq_direct. Transmitions were successful
because the bitstring returned by vnic server is very broad and over
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


