Return-Path: <netdev+bounces-157911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DDA0C47E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4975E3A16F0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611C81F9F56;
	Mon, 13 Jan 2025 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JG9Wb8Kw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB11EE7B0;
	Mon, 13 Jan 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806655; cv=none; b=HQ0m7Axsc3/DW4IwKUjaCVmKfQfjrb8iOnq797yxAudIU/s9rSVJHXc4Qe4n8ItWZ93MUoNmm1nIXfyMj7cZnJ88PrNIe7I+PMBkdgrYkP+0aP4/1kfpEgs4ezk2DrxnBGCrMp8DJqXgZzT/ax/GXf4Qgd2C2CN+L0K0/iuIqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806655; c=relaxed/simple;
	bh=IW2V5eMxUjMuGbD59gBqxYAMjzcD5HGkFFt13PdLcGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPaBTzKhBz7uSW+JkrjvkLkSyHg79wlSZNF/KHnffdicHqxu5dKEJZ1/W2a90fGA4V1WFXeG0eT0YmDkOQ5GTUCLyD7qfefMTof+M1rvGyhVnCE3ZasJMD44r7rOUwrF8chzRY35cWUZUtdg4YwG1pQxeQ2v7CVl8KupaKOqCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JG9Wb8Kw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DFfelR002372;
	Mon, 13 Jan 2025 22:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ucRLBcOE+YQ9Qwwpt
	C6XtxG02p46d6+s0y1G8OqLQB8=; b=JG9Wb8KwqbagCW4f9IMnfzmxFnWsuI4Xz
	HTQN+psMe22Dhk/4dDGel4gVVnuDE/k6PG50I7ND3bbQPN3EgVihMoLMN1rmK14w
	5wD3fp7Lf5qMwk6PHB8FhM9XvPLKAtlyv9cpGNPbwnbnykgEvpfidu27EPE2S6O9
	voHQYvvK/vjPvvNYH8VTYh93CgnMwiF8iWd7F+EdteJDdc+HKijTvuJNvA7N1xjO
	a11S9jy3rNBV8SGu5IoDsCpxOLrWz3M8OWDgElfDc+VW5GRrYXtCNArtqLwlI7v1
	5+TGTdEaaMdXz8l3m4dCbRdx0r4g9a17tyvFqnvlJr9ND3M5RGuyg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uagvdgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 22:17:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DK07t0002663;
	Mon, 13 Jan 2025 22:17:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by0f7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 22:17:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DMHSaK6357630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 22:17:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C11EE58059;
	Mon, 13 Jan 2025 22:17:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C2E25804B;
	Mon, 13 Jan 2025 22:17:28 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com.com (unknown [9.61.148.44])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 22:17:28 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: nick.child@ibm.com, netdev@vger.kernel.org,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH 3/3] ibmvnic: Print data buffers with kernel API's
Date: Mon, 13 Jan 2025 16:17:21 -0600
Message-ID: <20250113221721.362093-4-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113221721.362093-1-nnac123@linux.ibm.com>
References: <20250113221721.362093-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BsLVXfW1L6gUnsUfERQBcs_A1BVRAj0j
X-Proofpoint-GUID: BsLVXfW1L6gUnsUfERQBcs_A1BVRAj0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=830
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130173

Previously, data buffers that were to be printed were cast to 8 byte
integers and printed. This can lead to buffer overflow if the length
of the buffer is not a multiple of 8.

Simplify and safeguard printing by using kernel provided functions
to print these data blobs.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
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
2.47.1


