Return-Path: <netdev+bounces-181391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06F3A84C36
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C740F4C2476
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41FD28D82F;
	Thu, 10 Apr 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="We6NjXbi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89981FBE8B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310376; cv=none; b=JYW5XI7hLuStLZJ7ZoonCdGv7ZPDxSP0d7PAvH1U1jSEsVez+abSypskH0JPBYZoc1mRgVQd+TQhlSV2u9LUtBY+EHj8ouUwqMVNrvvOHc6rGZV9Gyqk3OY3tc5B1RRfJWVfMqTFAblK9xXSYe7ypJLNhs4B3OyFNzElK0OQOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310376; c=relaxed/simple;
	bh=L2f1ODIUzYl2QbwBU2nOiGMoQn5Im63CRHBLEtU7uGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kF1XTvgodDrtmsNfSGHtnUUGqcLlk7M/dQvw0QADWakpJGlVEybOcufTz32z5udjflZ1AB0qbLeWz4bsAg078IblYWGgrBY74UyYWV+kiCo1kyjOrxcZne4jSytySMQxi585YRFXeatyvaPnbug0j02lLTl8KQ0Ajcw3gomrU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=We6NjXbi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ACS4nU003715;
	Thu, 10 Apr 2025 18:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=18/9cGoDQlqTsXsRMO3AJA7exMHlf8vV8hvWnTgnZ
	p0=; b=We6NjXbica9ymBHrn5soaVf3eOZSE1PyjahbkkU+f2SFLr3ULsauQVFSg
	0cOdM8QN3LuO5E1KcyjmIX9/8sE/N3JDiR6DEnhzN7gEQIYkGLzfItuFWx8MjHwA
	XciN34vZdnsCj72msooNFLFFb6A+ez6lsOeccNlxipfLCU20GZY2pSawSuE6kL1e
	tp1VAwPGx2aWoWUvZ7RzzOr8hYgY6iNUmJ3jFhtsIoi7aVydEJ0fBsTDy1OYdcud
	UtnlFpOqavtRPKjwlAkKO5a7V2Zv8L+d42u516RbzMpOelwut2q/jLMNikZC3uUP
	NKQO5U8FGmSLtale8ekQb4UYD22bw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xe13t455-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:39:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AHn2oC018451;
	Thu, 10 Apr 2025 18:39:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2ky9f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:39:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AIdRor28377602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:39:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF4B458055;
	Thu, 10 Apr 2025 18:39:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E8C85804B;
	Thu, 10 Apr 2025 18:39:27 +0000 (GMT)
Received: from d.austin.ibm.com (unknown [9.41.102.181])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 18:39:27 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Dave Marquardt <davemarq@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next] ibmveth: Use WARN_ON with error handling rather than BUG_ON
Date: Thu, 10 Apr 2025 13:39:18 -0500
Message-ID: <20250410183918.422936-1-davemarq@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4hsIQiWIZPtpk8f8aa38QNCYw-U05ouk
X-Proofpoint-GUID: 4hsIQiWIZPtpk8f8aa38QNCYw-U05ouk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100133

- Replaced BUG_ON calls with WARN_ON calls with error handling,
  with calls to a new ibmveth_reset routine, which resets the device.
- Added KUnit tests for ibmveth_remove_buffer_from_pool and
  ibmveth_rxq_get_buffer under new IBMVETH_KUNIT_TEST config option.
- Removed unneeded forward declaration of ibmveth_rxq_harvest_buffer.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/Kconfig   |  13 ++
 drivers/net/ethernet/ibm/ibmveth.c | 242 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmveth.h |  65 ++++----
 3 files changed, 269 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/ibm/Kconfig b/drivers/net/ethernet/ibm/Kconfig
index c0c112d95b89..4f4b23465c47 100644
--- a/drivers/net/ethernet/ibm/Kconfig
+++ b/drivers/net/ethernet/ibm/Kconfig
@@ -27,6 +27,19 @@ config IBMVETH
 	  To compile this driver as a module, choose M here. The module will
 	  be called ibmveth.
 
+config IBMVETH_KUNIT_TEST
+	bool "KUnit test for IBM LAN Virtual Ethernet support" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on KUNIT=y && IBMVETH=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for the IBM LAN Virtual Ethernet driver.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 source "drivers/net/ethernet/ibm/emac/Kconfig"
 
 config EHEA
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 04192190beba..ea201e5cc8bc 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -28,6 +28,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <asm/hvcall.h>
 #include <linux/atomic.h>
 #include <asm/vio.h>
@@ -39,8 +40,6 @@
 #include "ibmveth.h"
 
 static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance);
-static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
-				       bool reuse);
 static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev);
 
 static struct kobj_type ktype_veth_pool;
@@ -231,7 +230,10 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		index = pool->free_map[free_index];
 		skb = NULL;
 
-		BUG_ON(index == IBM_VETH_INVALID_MAP);
+		if (WARN_ON(index == IBM_VETH_INVALID_MAP)) {
+			(void)schedule_work(&adapter->work);
+			goto failure2;
+		}
 
 		/* are we allocating a new buffer or recycling an old one */
 		if (pool->skbuff[index])
@@ -300,6 +302,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		                 DMA_FROM_DEVICE);
 	dev_kfree_skb_any(pool->skbuff[index]);
 	pool->skbuff[index] = NULL;
+failure2:
 	adapter->replenish_add_buff_failure++;
 
 	mb();
@@ -370,20 +373,36 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 	}
 }
 
-/* remove a buffer from a pool */
-static void ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
-					    u64 correlator, bool reuse)
+/**
+ * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
+ * @adapter: adapter instance
+ * @correlator: identifies pool and index
+ * @reuse: whether to reuse buffer
+ *
+ * Return:
+ * * %0       - success
+ * * %-EINVAL - correlator maps to pool or index out of range
+ * * %-EFAULT - pool and index map to null skb
+ */
+static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
+					   u64 correlator, bool reuse)
 {
 	unsigned int pool  = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 	unsigned int free_index;
 	struct sk_buff *skb;
 
-	BUG_ON(pool >= IBMVETH_NUM_BUFF_POOLS);
-	BUG_ON(index >= adapter->rx_buff_pool[pool].size);
+	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
+	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
+		(void)schedule_work(&adapter->work);
+		return -EINVAL;
+	}
 
 	skb = adapter->rx_buff_pool[pool].skbuff[index];
-	BUG_ON(skb == NULL);
+	if (WARN_ON(!skb)) {
+		(void)schedule_work(&adapter->work);
+		return -EFAULT;
+	}
 
 	/* if we are going to reuse the buffer then keep the pointers around
 	 * but mark index as available. replenish will see the skb pointer and
@@ -411,6 +430,8 @@ static void ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	mb();
 
 	atomic_dec(&(adapter->rx_buff_pool[pool].available));
+
+	return 0;
 }
 
 /* get the current buffer on the rx queue */
@@ -420,24 +441,44 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
-	BUG_ON(pool >= IBMVETH_NUM_BUFF_POOLS);
-	BUG_ON(index >= adapter->rx_buff_pool[pool].size);
+	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
+	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
+		(void)schedule_work(&adapter->work);
+		return NULL;
+	}
 
 	return adapter->rx_buff_pool[pool].skbuff[index];
 }
 
-static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
-				       bool reuse)
+/**
+ * ibmveth_rxq_harvest_buffer - Harvest buffer from pool
+ *
+ * @adapter - pointer to adapter
+ * @reuse   - whether to reuse buffer
+ *
+ * Context: called from ibmveth_poll
+ *
+ * Return:
+ * * %0    - success
+ * * other - non-zero return from ibmveth_remove_buffer_from_pool
+ */
+static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
+				      bool reuse)
 {
 	u64 cor;
+	int rc;
 
 	cor = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
-	ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
+	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
+	if (unlikely(rc))
+		return rc;
 
 	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
 		adapter->rx_queue.index = 0;
 		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
 	}
+
+	return 0;
 }
 
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
@@ -709,6 +750,35 @@ static int ibmveth_close(struct net_device *netdev)
 	return 0;
 }
 
+/**
+ * ibmveth_reset - Handle scheduled reset work
+ *
+ * @w - pointer to work_struct embedded in adapter structure
+ *
+ * Context: This routine acquires rtnl_mutex and disables its NAPI through
+ *          ibmveth_close. It can't be called directly in a context that has
+ *          already acquired rtnl_mutex or disabled its NAPI, or directly from
+ *          a poll routine.
+ *
+ * Return: void
+ */
+static void ibmveth_reset(struct work_struct *w)
+{
+	struct ibmveth_adapter *adapter = container_of(w, struct ibmveth_adapter, work);
+	struct net_device *netdev = adapter->netdev;
+
+	netdev_dbg(netdev, "reset starting\n");
+
+	rtnl_lock();
+
+	dev_close(adapter->netdev);
+	(void)dev_open(adapter->netdev, NULL);
+
+	rtnl_unlock();
+
+	netdev_dbg(netdev, "reset complete\n");
+}
+
 static int ibmveth_set_link_ksettings(struct net_device *dev,
 				      const struct ethtool_link_ksettings *cmd)
 {
@@ -1324,7 +1394,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			wmb(); /* suggested by larson1 */
 			adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
-			ibmveth_rxq_harvest_buffer(adapter, true);
+			if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+				break;
 		} else {
 			struct sk_buff *skb, *new_skb;
 			int length = ibmveth_rxq_frame_length(adapter);
@@ -1334,6 +1405,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			__sum16 iph_check = 0;
 
 			skb = ibmveth_rxq_get_buffer(adapter);
+			if (unlikely(!skb))
+				break;
 
 			/* if the large packet bit is set in the rx queue
 			 * descriptor, the mss will be written by PHYP eight
@@ -1357,10 +1430,12 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 				if (rx_flush)
 					ibmveth_flush_buffer(skb->data,
 						length + offset);
-				ibmveth_rxq_harvest_buffer(adapter, true);
+				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+					break;
 				skb = new_skb;
 			} else {
-				ibmveth_rxq_harvest_buffer(adapter, false);
+				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, false)))
+					break;
 				skb_reserve(skb, offset);
 			}
 
@@ -1407,7 +1482,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	 * then check once more to make sure we are done.
 	 */
 	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
-	BUG_ON(lpar_rc != H_SUCCESS);
+	if (WARN_ON(lpar_rc != H_SUCCESS)) {
+		(void)schedule_work(&adapter->work);
+		goto out;
+	}
 
 	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
 		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
@@ -1428,7 +1506,7 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	if (napi_schedule_prep(&adapter->napi)) {
 		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 				       VIO_IRQ_DISABLE);
-		BUG_ON(lpar_rc != H_SUCCESS);
+		WARN_ON(lpar_rc != H_SUCCESS);
 		__napi_schedule(&adapter->napi);
 	}
 	return IRQ_HANDLED;
@@ -1670,6 +1748,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	adapter->vdev = dev;
 	adapter->netdev = netdev;
+	INIT_WORK(&adapter->work, ibmveth_reset);
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
@@ -1962,3 +2041,128 @@ static void __exit ibmveth_module_exit(void)
 
 module_init(ibmveth_module_init);
 module_exit(ibmveth_module_exit);
+
+#ifdef CONFIG_IBMVETH_KUNIT_TEST
+#include <kunit/test.h>
+
+/**
+ * ibmveth_reset_kunit - reset routine for running in KUnit environment
+ *
+ * @w - pointer to work_struct embedded in adapter structure
+ *
+ * Context: Called in the KUnit environment. Does nothing.
+ *
+ * Return: void
+ */
+static void ibmveth_reset_kunit(struct work_struct *w)
+{
+	netdev_dbg(NULL, "reset_kunit starting\n");
+	netdev_dbg(NULL, "reset_kunit complete\n");
+}
+
+/**
+ * ibmveth_remove_buffer_from_pool_test - unit test for some of
+ *                                        ibmveth_remove_buffer_from_pool
+ * @test - pointer to kunit structure
+ *
+ * Tests the error returns from ibmveth_remove_buffer_from_pool.
+ * ibmveth_remove_buffer_from_pool also calls WARN_ON, so dmesg should be
+ * checked to see that these warnings happened.
+ *
+ * Return: void
+ */
+static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
+{
+	struct ibmveth_adapter *adapter = kunit_kzalloc(test, sizeof(*adapter), GFP_KERNEL);
+	struct ibmveth_buff_pool *pool;
+	u64 correlator;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter);
+
+	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
+
+	/* Set sane values for buffer pools */
+	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+					 pool_count[i], pool_size[i],
+					 pool_active[i]);
+
+	pool = &adapter->rx_buff_pool[0];
+	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
+
+	correlator = ((u64)IBMVETH_NUM_BUFF_POOLS << 32) | 0;
+	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
+	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+
+	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0].size;
+	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
+	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+
+	correlator = (u64)0 | 0;
+	pool->skbuff[0] = NULL;
+	KUNIT_EXPECT_EQ(test, -EFAULT, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
+	KUNIT_EXPECT_EQ(test, -EFAULT, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+}
+
+/**
+ * ibmveth_rxq_get_buffer_test - unit test for ibmveth_rxq_get_buffer
+ * @test - pointer to kunit structure
+ *
+ * Tests ibmveth_rxq_get_buffer. ibmveth_rxq_get_buffer also calls WARN_ON for
+ * the NULL returns, so dmesg should be checked to see that these warnings
+ * happened.
+ *
+ * Return: void
+ */
+static void ibmveth_rxq_get_buffer_test(struct kunit *test)
+{
+	struct ibmveth_adapter *adapter = kunit_kzalloc(test, sizeof(*adapter), GFP_KERNEL);
+	struct sk_buff *skb = kunit_kzalloc(test, sizeof(*skb), GFP_KERNEL);
+	struct ibmveth_buff_pool *pool;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+
+	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
+
+	adapter->rx_queue.queue_len = 1;
+	adapter->rx_queue.index = 0;
+	adapter->rx_queue.queue_addr = kunit_kzalloc(test, sizeof(struct ibmveth_rx_q_entry),
+						     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue.queue_addr);
+
+	/* Set sane values for buffer pools */
+	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+					 pool_count[i], pool_size[i],
+					 pool_active[i]);
+
+	pool = &adapter->rx_buff_pool[0];
+	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
+
+	adapter->rx_queue.queue_addr[0].correlator = (u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+
+	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | adapter->rx_buff_pool[0].size;
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+
+	pool->skbuff[0] = skb;
+	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | 0;
+	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter));
+}
+
+static struct kunit_case ibmveth_test_cases[] = {
+	KUNIT_CASE(ibmveth_remove_buffer_from_pool_test),
+	KUNIT_CASE(ibmveth_rxq_get_buffer_test),
+	{}
+};
+
+static struct kunit_suite ibmveth_test_suite = {
+	.name = "ibmveth-kunit-test",
+	.test_cases = ibmveth_test_cases,
+};
+
+kunit_test_suite(ibmveth_test_suite);
+#endif
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 8468e2c59d7a..b0a2460ec9f9 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -134,38 +134,39 @@ struct ibmveth_rx_q {
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
+	struct work_struct work;
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


