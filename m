Return-Path: <netdev+bounces-167897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30522A3CB2B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682DF189F982
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC3C253F1A;
	Wed, 19 Feb 2025 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sqhcTh20"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE92253F27;
	Wed, 19 Feb 2025 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999509; cv=none; b=cpe2iKJLPy8rGAEPFcq9C5P/6PRNmvZdVFrT4N0nI8eiatLnVYNcjriNH9V37S25gCY2BHRs6Jx2livrr/zlAtDD0Z/CurBLud/ETQ2CciJPzjkYpDx6Zx6OGiD+8++5uH5AKQfc9ykbGt93BgODtLbFXpdiiqMS33Spj1At9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999509; c=relaxed/simple;
	bh=1cUkvGwy1P4Fi9ondrK7es7LSnt2Stb+1JzUmn9+JPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc3ahFSelg8/QABMS1EuUABb44GL3QDkj0AEr79G9jo+Rs9TWu44Lg056vE/JUXEqbmuQvXydFpBYzzTgDxLQuQ3FGcUgsyLSKTzzw7osWwXjL5a+qHVZCjmo794k+Z/mD8J+vSPgYyw4Me77aIRJcKwcQB9HoPnPygJAKRZ1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sqhcTh20; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEi2Zi005307;
	Wed, 19 Feb 2025 21:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7KOl+ey/mlID+rWU/
	C0xqE52W963Y8MbAqipqrN6X7A=; b=sqhcTh20mlN7YBZ0+gLxH4Bpu3sUEzeWD
	jmfO5SAdmVMN6jkjp8yVql5eld9ISX65/3xoIArRUcDdCSF1GbaX+9Z79TqZYTTR
	lkMJOj1NyoQQHwaUwyqogQpGrg0b+KIA1OpuLkiSgXjSPdpeIHorEdnXjo/A9Jb8
	8npzJDLdPIuTCBByj1kEQbSA9YUu94Irjon66qMe+8fewNk5PSZ4jFlHwhRW9PNX
	f9DjdSFoSG2p/lLadAYVd8FRGcplxTytwwie7XGBwlxganhVawqfZ1dhBRQDiYfb
	aK/33bk+ehUMLT63jL28OuxHec4rI2/52VaYVGwHBhepUV3d16Qjw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w650d30h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JL9hSU005773;
	Wed, 19 Feb 2025 21:11:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w650d30f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKo2sF027066;
	Wed, 19 Feb 2025 21:11:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w02569hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JLBQox32113222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:11:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 875B258054;
	Wed, 19 Feb 2025 21:11:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E686F5805A;
	Wed, 19 Feb 2025 21:11:25 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com.com (unknown [9.61.179.202])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 21:11:25 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
        david.laight.linux@gmail.com, nick.child@ibm.com, pmladek@suse.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, Nick Child <nnac123@linux.ibm.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v3 3/3] ibmvnic: Print data buffers with kernel API's
Date: Wed, 19 Feb 2025 15:11:02 -0600
Message-ID: <20250219211102.225324-4-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219211102.225324-1-nnac123@linux.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WSoFnmtVhtjla2_RVZCerOJQNb7IS5wJ
X-Proofpoint-GUID: 3nmtspfiKe2M0K31fLuKvpKhiXKqmWRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=743 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190158

Previously, data buffers that were to be printed were cast to 8 byte
integers and printed. This can lead to buffer overflow if the length
of the buffer is not a multiple of 8.

Simplify and safeguard printing by using kernel provided functions
to print these data blobs.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e95ae0d39948..a8f1feb9a2e7 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4834,6 +4834,7 @@ static int send_login(struct ibmvnic_adapter *adapter)
 	struct device *dev = &adapter->vdev->dev;
 	struct vnic_login_client_data *vlcd;
 	dma_addr_t rsp_buffer_token;
+	unsigned char hex_str[16 * 3];
 	dma_addr_t buffer_token;
 	size_t rsp_buffer_size;
 	union ibmvnic_crq crq;
@@ -4937,9 +4938,9 @@ static int send_login(struct ibmvnic_adapter *adapter)
 	vnic_add_client_data(adapter, vlcd);
 
 	netdev_dbg(adapter->netdev, "Login Buffer:\n");
-	for (i = 0; i < (adapter->login_buf_sz - 1) / 8 + 1; i++) {
-		netdev_dbg(adapter->netdev, "%016lx\n",
-			   ((unsigned long *)(adapter->login_buf))[i]);
+	for_each_line_in_hex_dump(i, 16, hex_str, sizeof(hex_str), 8,
+				  adapter->login_buf, adapter->login_buf_sz) {
+		netdev_dbg(adapter->netdev, "%s\n", hex_str);
 	}
 
 	memset(&crq, 0, sizeof(crq));
@@ -5317,15 +5318,17 @@ static void handle_query_ip_offload_rsp(struct ibmvnic_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
 	struct ibmvnic_query_ip_offload_buffer *buf = &adapter->ip_offload_buf;
+	unsigned char hex_str[16 * 3];
 	int i;
 
 	dma_unmap_single(dev, adapter->ip_offload_tok,
 			 sizeof(adapter->ip_offload_buf), DMA_FROM_DEVICE);
 
 	netdev_dbg(adapter->netdev, "Query IP Offload Buffer:\n");
-	for (i = 0; i < (sizeof(adapter->ip_offload_buf) - 1) / 8 + 1; i++)
-		netdev_dbg(adapter->netdev, "%016lx\n",
-			   ((unsigned long *)(buf))[i]);
+	for_each_line_in_hex_dump(i, 16, hex_str, sizeof(hex_str), 8, buf,
+				  sizeof(adapter->ip_offload_buf)) {
+		netdev_dbg(adapter->netdev, "%s\n", hex_str);
+	}
 
 	netdev_dbg(adapter->netdev, "ipv4_chksum = %d\n", buf->ipv4_chksum);
 	netdev_dbg(adapter->netdev, "ipv6_chksum = %d\n", buf->ipv6_chksum);
@@ -5518,6 +5521,7 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	struct net_device *netdev = adapter->netdev;
 	struct ibmvnic_login_rsp_buffer *login_rsp = adapter->login_rsp_buf;
 	struct ibmvnic_login_buffer *login = adapter->login_buf;
+	unsigned char hex_str[16 * 3];
 	u64 *tx_handle_array;
 	u64 *rx_handle_array;
 	int num_tx_pools;
@@ -5556,9 +5560,10 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	netdev->mtu = adapter->req_mtu - ETH_HLEN;
 
 	netdev_dbg(adapter->netdev, "Login Response Buffer:\n");
-	for (i = 0; i < (adapter->login_rsp_buf_sz - 1) / 8 + 1; i++) {
-		netdev_dbg(adapter->netdev, "%016lx\n",
-			   ((unsigned long *)(adapter->login_rsp_buf))[i]);
+	for_each_line_in_hex_dump(i, 16, hex_str, sizeof(hex_str), 8,
+				  adapter->login_rsp_buf,
+				  adapter->login_rsp_buf_sz) {
+		netdev_dbg(adapter->netdev, "%s\n", hex_str);
 	}
 
 	/* Sanity checks */
-- 
2.48.1


