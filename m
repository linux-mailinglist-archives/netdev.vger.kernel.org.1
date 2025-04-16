Return-Path: <netdev+bounces-183496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81DA90D79
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8AB1907ADC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C206923D299;
	Wed, 16 Apr 2025 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aihkn3Vn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3101F585A
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744837089; cv=none; b=XunP4wnZW3zem429l3puhoc0YMtec2FvOPFUlD4G0TzDt33pa6RaUi2JfszmypjkKil1U1vFRNuckvCKfONKxQsy6xXCfgE85bjYVA3G1hJs4fxRI37TMUI81As79r3JP+j1P2wdfM3V03MGMidBEs3liRSYyW7m/16N3MOEkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744837089; c=relaxed/simple;
	bh=1TYgkI0jpqiZmeaJzRMIGCnud3GPWM21iPh8+2KpQrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQePN/x7BfvmYzK/d6DjbTlELCqqtj0qN36oGlGMzQWWvvNVYUQwN/n+I+mWC7TnRvaQlFKs0Mp7Dsf5vn1pj/PdvtH54dAF+OshUWOLgEbMJJnhnWxeFP6LCyJoT7fWld+enB1Jv/ToklkeioOZ/d57oPL2u8QFAmZGPvK3Mgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aihkn3Vn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GKSc8M028110;
	Wed, 16 Apr 2025 20:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LQXARRB7fBWoUfcnM
	LzG+H6f0Bs1fqiGC2EPrK5jo4s=; b=aihkn3VnenHTtVbZaHovvPi9bXgbY5OnF
	fvB1gf2InsOZhQRoHrTX4c+X6Xrmt5Na//aDo3qxfqohbFKoJF+xtdYjdG120X1g
	j9LisHiyUeHPANrfiUtNqxxQ296m30xL9HLvqn0LrvbHsvoNUYP/yKVHT9BQxCEa
	RVFwQieQ/D8q/DgMBDD+5JmZGziW/xM7DIx0RBfahD0Nc7aSpgkqXLbEdzFnjdqS
	SU+XlhwyJc1L/B21/qhx96NQRdsQfpo9ouT52pWAXt5WgIIQfypx5R4f4zqnmx/8
	hhm2213LpF44tL1sl4rENnT4FYG+cpAbc+8HE22pMD+0+1r8j7cYA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ykt5wr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 20:57:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GJrcDC016431;
	Wed, 16 Apr 2025 20:57:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4605729ygs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 20:57:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GKvuvZ24773372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 20:57:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBDBB58058;
	Wed, 16 Apr 2025 20:57:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC2E658057;
	Wed, 16 Apr 2025 20:57:56 +0000 (GMT)
Received: from d.attlocal.net (unknown [9.61.183.42])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 20:57:56 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com, horms@kernel.org,
        Dave Marquardt <davemarq@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 1/3] net: ibmveth: Indented struct ibmveth_adapter correctly
Date: Wed, 16 Apr 2025 15:57:49 -0500
Message-ID: <20250416205751.66365-2-davemarq@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416205751.66365-1-davemarq@linux.ibm.com>
References: <20250416205751.66365-1-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RJlqlGRKiWAlNMagL7_Gu6WHIQiFccC3
X-Proofpoint-ORIG-GUID: RJlqlGRKiWAlNMagL7_Gu6WHIQiFccC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160168

Made struct ibmveth_adapter follow indentation rules

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.h | 64 +++++++++++++++---------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 8468e2c59d7a..0f72ce54e7cf 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -134,38 +134,38 @@ struct ibmveth_rx_q {
 };
 
 struct ibmveth_adapter {
-    struct vio_dev *vdev;
-    struct net_device *netdev;
-    struct napi_struct napi;
-    unsigned int mcastFilterSize;
-    void * buffer_list_addr;
-    void * filter_list_addr;
-    void *tx_ltb_ptr[IBMVETH_MAX_QUEUES];
-    unsigned int tx_ltb_size;
-    dma_addr_t tx_ltb_dma[IBMVETH_MAX_QUEUES];
-    dma_addr_t buffer_list_dma;
-    dma_addr_t filter_list_dma;
-    struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
-    struct ibmveth_rx_q rx_queue;
-    int rx_csum;
-    int large_send;
-    bool is_active_trunk;
-
-    u64 fw_ipv6_csum_support;
-    u64 fw_ipv4_csum_support;
-    u64 fw_large_send_support;
-    /* adapter specific stats */
-    u64 replenish_task_cycles;
-    u64 replenish_no_mem;
-    u64 replenish_add_buff_failure;
-    u64 replenish_add_buff_success;
-    u64 rx_invalid_buffer;
-    u64 rx_no_buffer;
-    u64 tx_map_failed;
-    u64 tx_send_failed;
-    u64 tx_large_packets;
-    u64 rx_large_packets;
-    /* Ethtool settings */
+	struct vio_dev *vdev;
+	struct net_device *netdev;
+	struct napi_struct napi;
+	unsigned int mcastFilterSize;
+	void *buffer_list_addr;
+	void *filter_list_addr;
+	void *tx_ltb_ptr[IBMVETH_MAX_QUEUES];
+	unsigned int tx_ltb_size;
+	dma_addr_t tx_ltb_dma[IBMVETH_MAX_QUEUES];
+	dma_addr_t buffer_list_dma;
+	dma_addr_t filter_list_dma;
+	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
+	struct ibmveth_rx_q rx_queue;
+	int rx_csum;
+	int large_send;
+	bool is_active_trunk;
+
+	u64 fw_ipv6_csum_support;
+	u64 fw_ipv4_csum_support;
+	u64 fw_large_send_support;
+	/* adapter specific stats */
+	u64 replenish_task_cycles;
+	u64 replenish_no_mem;
+	u64 replenish_add_buff_failure;
+	u64 replenish_add_buff_success;
+	u64 rx_invalid_buffer;
+	u64 rx_no_buffer;
+	u64 tx_map_failed;
+	u64 tx_send_failed;
+	u64 tx_large_packets;
+	u64 rx_large_packets;
+	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
 };
-- 
2.49.0


