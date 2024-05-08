Return-Path: <netdev+bounces-94584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D38BFEE8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1568E1C236AF
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D832686243;
	Wed,  8 May 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZSqZywKA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC63779945;
	Wed,  8 May 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175420; cv=none; b=Fu9rEt64AmqGvFGON4SU9Wm5ldMlIjMvQM8iGDIL7/vuvaL0m566RKY19VgLfQeyX56hDKyNQMWiIUUOI90c+B4Jo06UouAR5v9ltJZfjI49P1agq1T44CO59zrFZqQVTHW1p/KkixD8yax1RGPm39zBQakS5JoGb70Xlkbtj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175420; c=relaxed/simple;
	bh=JkTg06/aHpbfRaS0lnRY52yM18vskA2DYA+nr/8Qpq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bRiS/QwU5cAZ8AG3/pSmSiYdNii32b8AwApA/5ZflnYDYsX52Vx2PqluR/D3Q90NsPayuwyAUfMx+fW60PRBJyvchOVgWfhjAQe6pULBhVe3mYd24k5uaZwUJvd+tjFmWqJwhQTgllFcGQF85ydN3jAOvLhsfFkuviM3jzsKoq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZSqZywKA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CO6mO024548;
	Wed, 8 May 2024 13:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=yxMZYDUUD3Dft0P5djSV6E4v28ayn+snF83s6212Ovg=;
 b=ZSqZywKAKz+cOfYKG4OsIU86ieCWLJwGs/k3mefaR+ezm26DiJf6SlDfgqqwi6sMRuk3
 b7yeP5knFSdhNkkPJKsiCUFHS2OSSOT6H2A5+48FXe8ZEPMOgVbw/wdIFDdDbIeW60bH
 9MD/lKoYitGrXtGRZvEgpV1DECbGrieNzSfP3j0Zj5++7GNIHnVVvYtYeU0woYve/Bjm
 CGwrt7gBX/pOHGNkHzUGvxMHdxZMmc9IW9lOlV/5+9zwsD3wdjfVFRVJ/n/t46FWzlma
 jO7LPN8vdI5SZUj6NpueogfNAEBekEdTHBfVX39R3B6ikFhRxISGr+ZctDTyNTho4P9Q 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfu9t0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 13:36:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448CqdCF020102;
	Wed, 8 May 2024 13:36:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfm2jvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 13:36:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 448DaSoq030474;
	Wed, 8 May 2024 13:36:28 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-191-233-230.vpn.oracle.com [10.191.233.230])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xysfm2jun-1;
	Wed, 08 May 2024 13:36:28 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH v3] net/sched: adjust device watchdog timer to detect stopped queue at right time
Date: Wed,  8 May 2024 19:06:17 +0530
Message-Id: <20240508133617.4424-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080096
X-Proofpoint-ORIG-GUID: 8pM6oRgjrPqmzGYpDrbzh9e2I0iqMs52
X-Proofpoint-GUID: 8pM6oRgjrPqmzGYpDrbzh9e2I0iqMs52

Applications are sensitive to long network latency, particularly
heartbeat monitoring ones. Longer the tx timeout recovery higher the
risk with such applications on a production machines. This patch
remedies, yet honoring device set tx timeout.

Modify watchdog next timeout to be shorter than the device specified.
Compute the next timeout be equal to device watchdog timeout less the
how long ago queue stop had been done. At next watchdog timeout tx
timeout handler is called into if still in stopped state. Either called
or not called, restore the watchdog timeout back to device specified.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
v3:
  - Address redundant braces.
v2: https://lore.kernel.org/linux-kernel/20240506135944.7753-1-praveen.kannoju@oracle.com/
  - Identify the oldest trans_start from all the queues and use it.
v1: https://lore.kernel.org/netdev/20240430140010.5005-1-praveen.kannoju@oracle.com/
---
 net/sched/sch_generic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 4a2c763e2d11..c671b261252a 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -506,19 +506,22 @@ static void dev_watchdog(struct timer_list *t)
 			unsigned int timedout_ms = 0;
 			unsigned int i;
 			unsigned long trans_start;
+			unsigned long oldest_start = jiffies;
 
 			for (i = 0; i < dev->num_tx_queues; i++) {
 				struct netdev_queue *txq;
 
 				txq = netdev_get_tx_queue(dev, i);
 				trans_start = READ_ONCE(txq->trans_start);
-				if (netif_xmit_stopped(txq) &&
-				    time_after(jiffies, (trans_start +
-							 dev->watchdog_timeo))) {
+				if (!netif_xmit_stopped(txq))
+					continue;
+				if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
 					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
 					atomic_long_inc(&txq->trans_timeout);
 					break;
 				}
+				if (time_after(oldest_start, trans_start))
+					oldest_start = trans_start;
 			}
 
 			if (unlikely(timedout_ms)) {
@@ -531,7 +534,7 @@ static void dev_watchdog(struct timer_list *t)
 				netif_unfreeze_queues(dev);
 			}
 			if (!mod_timer(&dev->watchdog_timer,
-				       round_jiffies(jiffies +
+				       round_jiffies(oldest_start +
 						     dev->watchdog_timeo)))
 				release = false;
 		}
-- 
2.31.1


