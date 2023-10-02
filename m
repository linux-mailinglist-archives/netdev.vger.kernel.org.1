Return-Path: <netdev+bounces-37494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F27B5A9A
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7A0A8281E80
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48C1F175;
	Mon,  2 Oct 2023 18:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE71E517
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 18:55:33 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D533CE
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:55:31 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392ICIgS023156;
	Mon, 2 Oct 2023 18:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=baQvOB9foh+svMTd+4dkDTzq8oWLjRmgXYBzVdD4eqM=;
 b=XhlOdomf3mX1EOsPR5PQMGEKB1guF7Wn9yu/vRjy/AZGRVbF62y4vmYU6EBwI9Vwv9Ix
 /XpHRuuaG/IIBEUi9BJdJ6y6ciGdVPJYWqT7GT2OIODXVQcH/ulQDsivbU3QJgDsStYC
 AL+0rhahMV+nGPIhTZVGuYX1s/8bUhyNevttHIWtUMTI6U66cur0RCYuP8mSh5SdhhGc
 6chgZ/OxqCijLYISXrIp14axlQD35Jk+ReOL/eCElFzX5NUUcBLa4C2rFiTtLeSjX4Rz
 oyK1JSnjRb0rDuJ0XUcUACIXiYr5AOwO1l3nLJ7TQevljcPndt6uqttRcyKQp24OoVqa uA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tg2xb13hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Oct 2023 18:55:28 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 392IHt7Y017637;
	Mon, 2 Oct 2023 18:55:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0muntp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Oct 2023 18:55:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 392ItREM34800250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Oct 2023 18:55:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE6F758058;
	Mon,  2 Oct 2023 18:55:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B91F58057;
	Mon,  2 Oct 2023 18:55:25 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Oct 2023 18:55:25 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
        drc@linux.vnet.ibm.com, pavan.chebbi@broadcom.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>,
        Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
Subject: [PATCH] net/tg3: fix race condition in tg3_reset_task_cancel()
Date: Mon,  2 Oct 2023 13:55:10 -0500
Message-Id: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cHpS0ZEGWYLSvtrRPktxXuC0dYYZnb2k
X-Proofpoint-GUID: cHpS0ZEGWYLSvtrRPktxXuC0dYYZnb2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

during the EEH error injection tests on the 4-port 1 GbE NetXtreme
BCM5719 Gigabit Ethernet PCIe adapter, a race condition was observed in
the process of resetting and setting the driver flag to
TX_RECOVERY_PENDING between tg3_reset_task_cancel() and tg3_tx_recover().
As a result, it occasionally leads to transmit timeouts and the
subsequent disabling of all the driver's interfaces.

[12046.886221] NETDEV WATCHDOG: eth16 (tg3): transmit queue 0 timed out
[12046.886238] WARNING: CPU: 7 PID: 0 at ../net/sched/sch_generic.c:478
   dev_watchdog+0x42c/0x440
[12046.886247] Modules linked in: tg3 libphy nfsv3 nfs_acl .......
 ..........
[12046.886571] tg3 0021:01:00.0 eth16: transmit timed out, resetting
...........
[12046.966175] tg3 0021:01:00.1 eth15: transmit timed out, resetting
...........
[12046.981584] tg3 0021:01:00.2 eth14: transmit timed out, resetting
...........
[12047.056165] tg3 0021:01:00.3 eth13: transmit timed out, resetting


Fixing this issue by taking the spinlock when modifying the driver flag


Fixes: 6c4ca03bd890 ("net/tg3: resolve deadlock in tg3_reset_task() during EEH")


Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Tested-by: Venkata Sai Duggi <venkata.sai.duggi@ibm.com>

---
 drivers/net/ethernet/broadcom/tg3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 14b311196b8f..f4558762f9de 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6507,7 +6507,9 @@ static void tg3_tx_recover(struct tg3 *tp)
 		    "Please report the problem to the driver maintainer "
 		    "and include system chipset information.\n");
 
+	tg3_full_lock(tp, 0);
 	tg3_flag_set(tp, TX_RECOVERY_PENDING);
+	tg3_full_unlock(tp);
 }
 
 static inline u32 tg3_tx_avail(struct tg3_napi *tnapi)
@@ -7210,7 +7212,10 @@ static inline void tg3_reset_task_cancel(struct tg3 *tp)
 {
 	if (test_and_clear_bit(TG3_FLAG_RESET_TASK_PENDING, tp->tg3_flags))
 		cancel_work_sync(&tp->reset_task);
+
+	tg3_full_lock(tp, 0);
 	tg3_flag_clear(tp, TX_RECOVERY_PENDING);
+	tg3_full_unlock(tp);
 }
 
 static int tg3_poll_msix(struct napi_struct *napi, int budget)
-- 
2.25.1


