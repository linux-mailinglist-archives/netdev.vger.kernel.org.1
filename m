Return-Path: <netdev+bounces-93723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793978BCF8E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5ECB214AB
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DDF81205;
	Mon,  6 May 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fChRnzLO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808015A5;
	Mon,  6 May 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004002; cv=none; b=huMIUbBXuK/27VDlVLatXQyv97mI2Y61ilB+9H5Z4RlH1SEIr49QMfZnBWhRouEi5FSatdLbs4121RfIxdgvV0q3TfEwyt85/PGtT1ZXg56zwGAHIQjzUw8CICXMgJ9KuK5SXagEezFFcabt7BCZa4Xd8AAR6Jd6rW2f1J/R2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004002; c=relaxed/simple;
	bh=P7hzobG48OrQRhVmRGZvAghTx4JfPFToBDmjqFqNKpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FjngjOzOW/UegdXZxQvS9bIY6Mrq+kWlnyeAIilH++tXiK5MGLSt9yFQEg6CG/R6csedYUt1yz19woRn72Wis7vYQ1qA5a0NEFULS05Y/EKO2kBhqyQuPcCgXVPmP9ENCc8vGmWoqLeqDuc9N09owkhhVwRiHCprouk4cmOPxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fChRnzLO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446An4gF027863;
	Mon, 6 May 2024 13:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=l8vsB0YxVyOhCoOR1rq+CzGzcpNzExSdLNP82ssVmCM=;
 b=fChRnzLOkEjRTcdNnI/XUZmQK/PfdYREMS5/ArjpCknWpCIJeTmNpY+G6XfeITRj1g4h
 YwinRki+3j8GY0gsdLC7YMKpTuYzFSD8AqMmxPFSRTZH578/pgs/zyKRXGGpWZQUlrZH
 NXTH4pexaNtzdTVl0Lpy7+vCTlIwYlvICQoiUbke23WKM4IwH6ABEc3uFfSfZ4tW9PZ5
 hDD0mC86ajeTDc6e0Ger4Ha9So3FcHBTf4/IO93W6nfOrHgGp34iadfNm48/A0M8A92X
 Lj761TyNkRDbTAg6F0F2iOzy5Nn60XpAw9UJPSTBo/esAoEtN3xB5WhYJQwkAQ8Nq/Oz lA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwd2dtnaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 13:59:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446ChRM6014136;
	Mon, 6 May 2024 13:59:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf61983-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 13:59:54 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446Dv4n5027456;
	Mon, 6 May 2024 13:59:53 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-191-206-220.vpn.oracle.com [10.191.206.220])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xwbf6195f-1;
	Mon, 06 May 2024 13:59:53 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH v2] net/sched: adjust device watchdog timer to detect stopped queue at right time
Date: Mon,  6 May 2024 19:29:44 +0530
Message-Id: <20240506135944.7753-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060096
X-Proofpoint-GUID: TJufH9kkmrhGtnz6M3se9SSQm5zh2ZI8
X-Proofpoint-ORIG-GUID: TJufH9kkmrhGtnz6M3se9SSQm5zh2ZI8

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
v2:
  - Identify the oldest trans_start from all the queues and use it.
v1: https://lore.kernel.org/netdev/20240430140010.5005-1-praveen.kannoju@oracle.com/
---
 net/sched/sch_generic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 4a2c763e2d11..840b995c7233 100644
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
+				if (time_after(jiffies, (trans_start + dev->watchdog_timeo))) {
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


