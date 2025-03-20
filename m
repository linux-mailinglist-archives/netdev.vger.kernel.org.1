Return-Path: <netdev+bounces-176599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F135CA6AFD6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E09982A70
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60703227586;
	Thu, 20 Mar 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r/n1YA0+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B220C477
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506199; cv=none; b=KeQEHRL9kncMj5KVsQTDwC0U/ebaKKii9SxP61NS6Z7ACpwqlzpf0YIHxiqCvbrqzz/BEgLei0EE52/RLcrXPdZVTDLa4uriBl81RnIFaRf/N83s6kxLmIvNrIJ0uQhsVRi0SmgP42NShdrGQXPWkycVV3/ytjrF+GGTrp25emY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506199; c=relaxed/simple;
	bh=hc51Lkdct6uqqWV8pqMw9aQ62bLbeMIuUAQRVYD5USc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amr5SAXIEAKp7AI0BskvCFcK4JX+9eUUxUPObsDIklEjK4/bq9VhW9XocPTVKpohTP6jfsnbR1Rf7Ysg3bLcFrDSXxmgbUmvNsW3zgcLRujRy/i5UiDEnOg7fTdq5yjwRdsXgQYO4S0iSxgD7zJxBpNw6cXQiLP4q7pfe97AjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r/n1YA0+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KKa3US027541
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 21:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tju/xG/djID0g3mEBemfT6X1eXpwAaHq0v5fZEBnV
	C0=; b=r/n1YA0+A8PGCozTF5EdgpSd6GwC1dYCitDk8JjRw722fSzM4epr2ojmI
	W64lN2dbTCld67mCZLCkAbpDKyNre8CmDl9mjsjAo7wflVeMxGGMzY4RzbSlQ8l+
	GJ/Uu2nDP16oIfVvR019T/xn1LqBKLG7m8zFWpNBOpBL+2TCwhwAbbykkV2hpQ4h
	x3te536OS3+Hlg1iZg+3Y0/EWpn0sfTRZSqHACpQLXq+E/eNFTuAmsxjb2D0Ojch
	rpVDevkKxK9i2LD9CWA0j3iebZcLSETFogUZkHmG/Euzz793/e+0/LzzryCZS8w/
	hR+vzEoE7BV9Rj7jrtu5PIEtY7GEA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gt6q06rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 21:29:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KK5QeY023211
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 21:29:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3m210j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 21:29:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KLTrmj33686046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 21:29:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 268DB5805A;
	Thu, 20 Mar 2025 21:29:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 082155805C;
	Thu, 20 Mar 2025 21:29:53 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.lan (unknown [9.61.95.179])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 21:29:52 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net] ibmvnic: Use kernel helpers for hex dumps
Date: Thu, 20 Mar 2025 16:29:51 -0500
Message-ID: <20250320212951.11142-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5f4jf2IdoGs5vEMGO5hXHtjP0NPFBu4_
X-Proofpoint-ORIG-GUID: 5f4jf2IdoGs5vEMGO5hXHtjP0NPFBu4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=899 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200139

Previously, when the driver was printing hex dumps, the buffer was cast
to an 8 byte long and printed using string formatters. If the buffer
size was not a multiple of 8 then a read buffer overflow was possible.

Therefore, create a new ibmvnic function that loops over a buffer and
calls hex_dump_to_buffer instead.

This patch address KASAN reports like the one below:
  ibmvnic 30000003 env3: Login Buffer:
  ibmvnic 30000003 env3: 01000000af000000
  <...>
  ibmvnic 30000003 env3: 2e6d62692e736261
  ibmvnic 30000003 env3: 65050003006d6f63
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in ibmvnic_login+0xacc/0xffc [ibmvnic]
  Read of size 8 at addr c0000001331a9aa8 by task ip/17681
  <...>
  Allocated by task 17681:
  <...>
  ibmvnic_login+0x2f0/0xffc [ibmvnic]
  ibmvnic_open+0x148/0x308 [ibmvnic]
  __dev_open+0x1ac/0x304
  <...>
  The buggy address is located 168 bytes inside of
                allocated 175-byte region [c0000001331a9a00, c0000001331a9aaf)
  <...>
  =================================================================
  ibmvnic 30000003 env3: 000000000033766e

Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
This patch obsoletes my work to define a for_each macro in printk.h [1]. It was
determined the pitfalls outweighed the benefits of the code cleanup.

Side question, is net the correct mailing list even if the bug being addressed
was introduced long before the current release? Or is net-next more appropriate?
Does bug severity play any part in this or does anything with a Fixes tag go to
net? netdev-FAQ implies all fixes go into net but previous mailing list entries
seem to vary. Thanks

[1] https://lore.kernel.org/lkml/20250219211102.225324-1-nnac123@linux.ibm.com/

 drivers/net/ethernet/ibm/ibmvnic.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 0676fc547b6f..480606d1245e 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4829,6 +4829,18 @@ static void vnic_add_client_data(struct ibmvnic_adapter *adapter,
 	strscpy(vlcd->name, adapter->netdev->name, len);
 }
 
+static void ibmvnic_print_hex_dump(struct net_device *dev, void *buf,
+				   size_t len)
+{
+	unsigned char hex_str[16 * 3];
+
+	for (size_t i = 0; i < len; i += 16) {
+		hex_dump_to_buffer((unsigned char *)buf + i, len - i, 16, 8,
+				   hex_str, sizeof(hex_str), false);
+		netdev_dbg(dev, "%s\n", hex_str);
+	}
+}
+
 static int send_login(struct ibmvnic_adapter *adapter)
 {
 	struct ibmvnic_login_rsp_buffer *login_rsp_buffer;
@@ -4939,10 +4951,8 @@ static int send_login(struct ibmvnic_adapter *adapter)
 	vnic_add_client_data(adapter, vlcd);
 
 	netdev_dbg(adapter->netdev, "Login Buffer:\n");
-	for (i = 0; i < (adapter->login_buf_sz - 1) / 8 + 1; i++) {
-		netdev_dbg(adapter->netdev, "%016lx\n",
-			   ((unsigned long *)(adapter->login_buf))[i]);
-	}
+	ibmvnic_print_hex_dump(adapter->netdev, adapter->login_buf,
+			       adapter->login_buf_sz);
 
 	memset(&crq, 0, sizeof(crq));
 	crq.login.first = IBMVNIC_CRQ_CMD;
@@ -5319,15 +5329,13 @@ static void handle_query_ip_offload_rsp(struct ibmvnic_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
 	struct ibmvnic_query_ip_offload_buffer *buf = &adapter->ip_offload_buf;
-	int i;
 
 	dma_unmap_single(dev, adapter->ip_offload_tok,
 			 sizeof(adapter->ip_offload_buf), DMA_FROM_DEVICE);
 
 	netdev_dbg(adapter->netdev, "Query IP Offload Buffer:\n");
-	for (i = 0; i < (sizeof(adapter->ip_offload_buf) - 1) / 8 + 1; i++)
-		netdev_dbg(adapter->netdev, "%016lx\n",
-			   ((unsigned long *)(buf))[i]);
+	ibmvnic_print_hex_dump(adapter->netdev, buf,
+			       sizeof(adapter->ip_offload_buf));
 
 	netdev_dbg(adapter->netdev, "ipv4_chksum = %d\n", buf->ipv4_chksum);
 	netdev_dbg(adapter->netdev, "ipv6_chksum = %d\n", buf->ipv6_chksum);
@@ -5558,10 +5566,8 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	netdev->mtu = adapter->req_mtu - ETH_HLEN;
 
 	netdev_dbg(adapter->netdev, "Login Response Buffer:\n");
-	for (i = 0; i < (adapter->login_rsp_buf_sz - 1) / 8 + 1; i++) {
-		netdev_dbg(adapter->netdev, "%016lx\n",
-			   ((unsigned long *)(adapter->login_rsp_buf))[i]);
-	}
+	ibmvnic_print_hex_dump(netdev, adapter->login_rsp_buf,
+			       adapter->login_rsp_buf_sz);
 
 	/* Sanity checks */
 	if (login->num_txcomp_subcrqs != login_rsp->num_txsubm_subcrqs ||
-- 
2.48.1


