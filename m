Return-Path: <netdev+bounces-166502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7626A36306
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEA6189026A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D02676FB;
	Fri, 14 Feb 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKCvgizw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C217E0ED;
	Fri, 14 Feb 2025 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550306; cv=none; b=JBCvKhoXno+6j3vxtvfRi2BbQlxeJeJWhpqk8ekK1nYAazIPZbtNgAIbkuQJO1d+pmfdhF98T/LQnADP1oSlDH7hJkuoWpHyYYmPHRYnRYdsmmz7hLTEaTzDIr5H0WROkr5G1Y3rd2F02S4GesGGh+4iW50pxN1kh7KoItHISsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550306; c=relaxed/simple;
	bh=XGCrjKYWR6g/Oc7ffC1TNGQJ7GNX5TqlzKoNYIeqInk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA6RYps2XyKRtV3tgWVFPHYRGeH6JYxlf6EeQAZzXMJ1muFZ4Dlf6MhVhwlurDFfoYyhoX6OKWeP6EaXLRkgXf+7J8z74Q/qqygi4qx7BuMBPgIEEGXYtxnx3uskbp4mQ/D6UxLf0NzsZHmqQD1bD52uQoXnvHY4FsMBlo1PAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKCvgizw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E7X0G3026210;
	Fri, 14 Feb 2025 16:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HVK5Ba/d9bGUUzXzE
	oQTVrIVyX5umy5tq9OStFoQzHg=; b=rKCvgizwkuI/UlC27TdtP4Cbv5lvZBXxl
	F7kS1sc2mcfRCUPa5mE9jPM/cI4mpfhP/5OweCS078+5i7rcadlELWEntSjeTWDb
	QRowi/aAwXyibqBvxmgR16FjFVPmI3Q4kPAAHT/GA6tBh74PtHt4AMcLIN7VCeQM
	6/FU5SVYZMyio6o3OIVTTUAxKq5TNtdwPTTdsYCK6BOeyXn8Oc8GsA3Nma7VepJF
	JEK3Lx7md3n24tkLSIjp+mC4+W9jtxDCMMJiMt5qhMbSNRaEv3mb7s7y7Sbhcfk/
	324Rdw9pBGcxaLSYJGPuRxm0fJW4lU4lFjo6I1pX0BpLw0GPVGJSQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hpte9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:24:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFHjEP016679;
	Fri, 14 Feb 2025 16:24:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pk3kmd4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:24:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EGOqm418154226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 16:24:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BF135803F;
	Fri, 14 Feb 2025 16:24:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF62258056;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.lan (unknown [9.61.91.157])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, nick.child@ibm.com,
        jacob.e.keller@intel.com, horms@kernel.org,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH v2 3/3] ibmvnic: Print data buffers with kernel API's
Date: Fri, 14 Feb 2025 10:24:36 -0600
Message-ID: <20250214162436.241359-4-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214162436.241359-1-nnac123@linux.ibm.com>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M1vwKHZdR9uqW1AiZCVjq7v90PIzsE4x
X-Proofpoint-GUID: M1vwKHZdR9uqW1AiZCVjq7v90PIzsE4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=767 mlxscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140114

Previously, data buffers that were to be printed were cast to 8 byte
integers and printed. This can lead to buffer overflow if the length
of the buffer is not a multiple of 8.

Simplify and safeguard printing by using kernel provided functions
to print these data blobs.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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
2.48.0


