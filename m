Return-Path: <netdev+bounces-178838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A352A7925D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB87C1882130
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A839FD9;
	Wed,  2 Apr 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X59TmNwC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229478C91
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608661; cv=none; b=DtJ8DFcUOCGz5CBA2KqhuEzKB0uPjHuXMnqs/j70ox08QpuYV6XhcKbk/mHr9i+D+G3ZFACua3kVUoGteaIo9i4u3GwsDuSfSxhulB4EE5kHPfqaB50EhF84MI6HsE75BCdNPRmfecgzDny6KUmsPJ38htFLyjzTY6Im1G/7q4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608661; c=relaxed/simple;
	bh=viiUJMSwE46Da8L6ffvyFkMI/S4LosbmTw3asAKUiGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=id1KcdYOXkJXRnoAqQ/O0SIgwGqZZSGtyQdtB/kILr+QEChG/F7zzyItmg7gTlq3BRiDyH2NldkpKAu8tPimhkHIVw0EmMvYn0vIusqdYgMV8Eex3CHSVczRyDNYMBgQYTYYUxpDGwW4IkcRqnT3taChL3hid4nMKKxB1r/KA3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X59TmNwC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532CTRFS023225;
	Wed, 2 Apr 2025 15:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DejapdO+txJM4i2wzrKNYHRTJMOJImjIV70hVROlM
	Js=; b=X59TmNwC2Yy5GDDalXhQmVlamnUTQBNvaxq5+kp9yyX/GdKzfH7P/oXeq
	eEJFdBhJNRrNtjYKjCLGVHCnI8Ty3iONd9s0ZEN9zEsv3VvFVydB1f8fLjhO0oWH
	Vd/fObBPFjsPBK9l2NVBmBVhTBfkIGbOPk/tc9AVO8HqP7+BMWa+hrkTVWni3RNI
	tnxwgivqeQ6U8i0JLAJT50liiPcvosI71TwCI/6PBl8Z6J/O0kwVeZdI+gKj1NS/
	bsbMWGmMV7iVtqJAA+sILx5sTiXoxR4/q8qPPm2u+Qv8gQzPOPFgKDCvKY/4f6uT
	eiTjMiXz+6gUSlEknu6jlF9KtjyjA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s59fs0sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 15:44:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 532CUdwW009923;
	Wed, 2 Apr 2025 15:44:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6p0j0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 15:44:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 532Fi7np14615112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 15:44:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C92405805F;
	Wed,  2 Apr 2025 15:44:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1944F5805E;
	Wed,  2 Apr 2025 15:44:07 +0000 (GMT)
Received: from d.ibm.com (unknown [9.61.146.121])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 15:44:06 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Dave Marquardt <davemarq@linux.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: ibmveth: make veth_pool_store stop hanging
Date: Wed,  2 Apr 2025 10:44:03 -0500
Message-ID: <20250402154403.386744-1-davemarq@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: spqrmp_pLLQr5bMI8SpZpJhKJ9vN_W6R
X-Proofpoint-GUID: spqrmp_pLLQr5bMI8SpZpJhKJ9vN_W6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=992
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020098

v2:
- Created a single error handling unlock and exit in veth_pool_store
- Greatly expanded commit message with previous explanatory-only text

Summary: Use rtnl_mutex to synchronize veth_pool_store with itself,
ibmveth_close and ibmveth_open, preventing multiple calls in a row to
napi_disable.

Background: Two (or more) threads could call veth_pool_store through
writing to /sys/devices/vio/30000002/pool*/*. You can do this easily
with a little shell script. This causes a hang.

I configured LOCKDEP, compiled ibmveth.c with DEBUG, and built a new
kernel. I ran this test again and saw:

    Setting pool0/active to 0
    Setting pool1/active to 1
    [   73.911067][ T4365] ibmveth 30000002 eth0: close starting
    Setting pool1/active to 1
    Setting pool1/active to 0
    [   73.911367][ T4366] ibmveth 30000002 eth0: close starting
    [   73.916056][ T4365] ibmveth 30000002 eth0: close complete
    [   73.916064][ T4365] ibmveth 30000002 eth0: open starting
    [  110.808564][  T712] systemd-journald[712]: Sent WATCHDOG=1 notification.
    [  230.808495][  T712] systemd-journald[712]: Sent WATCHDOG=1 notification.
    [  243.683786][  T123] INFO: task stress.sh:4365 blocked for more than 122 seconds.
    [  243.683827][  T123]       Not tainted 6.14.0-01103-g2df0c02dab82-dirty #8
    [  243.683833][  T123] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  243.683838][  T123] task:stress.sh       state:D stack:28096 pid:4365  tgid:4365  ppid:4364   task_flags:0x400040 flags:0x00042000
    [  243.683852][  T123] Call Trace:
    [  243.683857][  T123] [c00000000c38f690] [0000000000000001] 0x1 (unreliable)
    [  243.683868][  T123] [c00000000c38f840] [c00000000001f908] __switch_to+0x318/0x4e0
    [  243.683878][  T123] [c00000000c38f8a0] [c000000001549a70] __schedule+0x500/0x12a0
    [  243.683888][  T123] [c00000000c38f9a0] [c00000000154a878] schedule+0x68/0x210
    [  243.683896][  T123] [c00000000c38f9d0] [c00000000154ac80] schedule_preempt_disabled+0x30/0x50
    [  243.683904][  T123] [c00000000c38fa00] [c00000000154dbb0] __mutex_lock+0x730/0x10f0
    [  243.683913][  T123] [c00000000c38fb10] [c000000001154d40] napi_enable+0x30/0x60
    [  243.683921][  T123] [c00000000c38fb40] [c000000000f4ae94] ibmveth_open+0x68/0x5dc
    [  243.683928][  T123] [c00000000c38fbe0] [c000000000f4aa20] veth_pool_store+0x220/0x270
    [  243.683936][  T123] [c00000000c38fc70] [c000000000826278] sysfs_kf_write+0x68/0xb0
    [  243.683944][  T123] [c00000000c38fcb0] [c0000000008240b8] kernfs_fop_write_iter+0x198/0x2d0
    [  243.683951][  T123] [c00000000c38fd00] [c00000000071b9ac] vfs_write+0x34c/0x650
    [  243.683958][  T123] [c00000000c38fdc0] [c00000000071bea8] ksys_write+0x88/0x150
    [  243.683966][  T123] [c00000000c38fe10] [c0000000000317f4] system_call_exception+0x124/0x340
    [  243.683973][  T123] [c00000000c38fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
    ...
    [  243.684087][  T123] Showing all locks held in the system:
    [  243.684095][  T123] 1 lock held by khungtaskd/123:
    [  243.684099][  T123]  #0: c00000000278e370 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x50/0x248
    [  243.684114][  T123] 4 locks held by stress.sh/4365:
    [  243.684119][  T123]  #0: c00000003a4cd3f8 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x88/0x150
    [  243.684132][  T123]  #1: c000000041aea888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x154/0x2d0
    [  243.684143][  T123]  #2: c0000000366fb9a8 (kn->active#64){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x160/0x2d0
    [  243.684155][  T123]  #3: c000000035ff4cb8 (&dev->lock){+.+.}-{3:3}, at: napi_enable+0x30/0x60
    [  243.684166][  T123] 5 locks held by stress.sh/4366:
    [  243.684170][  T123]  #0: c00000003a4cd3f8 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x88/0x150
    [  243.684183][  T123]  #1: c00000000aee2288 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x154/0x2d0
    [  243.684194][  T123]  #2: c0000000366f4ba8 (kn->active#64){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x160/0x2d0
    [  243.684205][  T123]  #3: c000000035ff4cb8 (&dev->lock){+.+.}-{3:3}, at: napi_disable+0x30/0x60
    [  243.684216][  T123]  #4: c0000003ff9bbf18 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x138/0x12a0

From the ibmveth debug, two threads are calling veth_pool_store, which
calls ibmveth_close and ibmveth_open. Here's the sequence:

  T4365             T4366
  ----------------- ----------------- ---------
  veth_pool_store   veth_pool_store
                    ibmveth_close
  ibmveth_close
  napi_disable
                    napi_disable
  ibmveth_open
  napi_enable                         <- HANG

ibmveth_close calls napi_disable at the top and ibmveth_open calls
napi_enable at the top.

https://docs.kernel.org/networking/napi.html]] says

  The control APIs are not idempotent. Control API calls are safe
  against concurrent use of datapath APIs but an incorrect sequence of
  control API calls may result in crashes, deadlocks, or race
  conditions. For example, calling napi_disable() multiple times in a
  row will deadlock.

In the normal open and close paths, rtnl_mutex is acquired to prevent
other callers. This is missing from veth_pool_store. Use rtnl_mutex in
veth_pool_store fixes these hangs.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Reviewed-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/ibm/ibmveth.c | 39 +++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b619a3ec245b..04192190beba 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1802,18 +1802,22 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	long value = simple_strtol(buf, NULL, 10);
 	long rc;
 
+	rtnl_lock();
+
 	if (attr == &veth_active_attr) {
 		if (value && !pool->active) {
 			if (netif_running(netdev)) {
 				if (ibmveth_alloc_buffer_pool(pool)) {
 					netdev_err(netdev,
 						   "unable to alloc pool\n");
-					return -ENOMEM;
+					rc = -ENOMEM;
+					goto unlock_err;
 				}
 				pool->active = 1;
 				ibmveth_close(netdev);
-				if ((rc = ibmveth_open(netdev)))
-					return rc;
+				rc = ibmveth_open(netdev);
+				if (rc)
+					goto unlock_err;
 			} else {
 				pool->active = 1;
 			}
@@ -1833,48 +1837,59 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 
 			if (i == IBMVETH_NUM_BUFF_POOLS) {
 				netdev_err(netdev, "no active pool >= MTU\n");
-				return -EPERM;
+				rc = -EPERM;
+				goto unlock_err;
 			}
 
 			if (netif_running(netdev)) {
 				ibmveth_close(netdev);
 				pool->active = 0;
-				if ((rc = ibmveth_open(netdev)))
-					return rc;
+				rc = ibmveth_open(netdev);
+				if (rc)
+					goto unlock_err;
 			}
 			pool->active = 0;
 		}
 	} else if (attr == &veth_num_attr) {
 		if (value <= 0 || value > IBMVETH_MAX_POOL_COUNT) {
-			return -EINVAL;
+			rc = -EINVAL;
+			goto unlock_err;
 		} else {
 			if (netif_running(netdev)) {
 				ibmveth_close(netdev);
 				pool->size = value;
-				if ((rc = ibmveth_open(netdev)))
-					return rc;
+				rc = ibmveth_open(netdev);
+				if (rc)
+					goto unlock_err;
 			} else {
 				pool->size = value;
 			}
 		}
 	} else if (attr == &veth_size_attr) {
 		if (value <= IBMVETH_BUFF_OH || value > IBMVETH_MAX_BUF_SIZE) {
-			return -EINVAL;
+			rc = -EINVAL;
+			goto unlock_err;
 		} else {
 			if (netif_running(netdev)) {
 				ibmveth_close(netdev);
 				pool->buff_size = value;
-				if ((rc = ibmveth_open(netdev)))
-					return rc;
+				rc = ibmveth_open(netdev);
+				if (rc)
+					goto unlock_err;
 			} else {
 				pool->buff_size = value;
 			}
 		}
 	}
+	rtnl_unlock();
 
 	/* kick the interrupt handler to allocate/deallocate pools */
 	ibmveth_interrupt(netdev->irq, netdev);
 	return count;
+
+unlock_err:
+	rtnl_unlock();
+	return rc;
 }
 
 
-- 
2.49.0


