Return-Path: <netdev+bounces-24816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67175771C67
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9872E1C209D5
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEFF3D60;
	Mon,  7 Aug 2023 08:38:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B81C14
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:38:15 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22FF10EF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:38:14 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3778UbpI025835;
	Mon, 7 Aug 2023 08:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=sPxaBK+v0LpwvzJGBGOCnrHSicGRsYiKE4dWGzfNw7M=;
 b=LZWt26PGazu1GnTErSHUrhuOQsqQ3dCDuJWtbZJsgukVlFMY85YAVDU9s3kJU83Gxtil
 zD/bgrVr1bQnyVqEKLs5cxO9z+4T1PsCTWLhKP3zdOWfSzdJPU7s46Qmv36cPvq7qYex
 RljcpOByw6AuaDUzUuUh/Al9Wf+qofJflJQLtetVOxi8JnT83tOcoqGjXOd5x9AXkjZ7
 MzegfInrECDJ0ckGQCukGlSfN28ZHdDEM/rfaU+NdAjuAP9BFkSBaZIKnDkNcdUvrqMD
 zf/nGncozukSMAAZ6evPA+fHFmJh1MKabqguoPTj5N2BCngWlpeiw8o5N04IMmUcvxMz CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3saw5j06j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 08:38:06 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3778UsCS026435;
	Mon, 7 Aug 2023 08:38:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3saw5j06hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 08:38:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3778M8rk030364;
	Mon, 7 Aug 2023 08:33:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rmug15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 08:33:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3778X1PM39649688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Aug 2023 08:33:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 665A820043;
	Mon,  7 Aug 2023 08:33:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C118120040;
	Mon,  7 Aug 2023 08:32:58 +0000 (GMT)
Received: from li-79f82dcc-27d1-11b2-a85c-9579c2333295.ibm.com.com (unknown [9.43.16.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Aug 2023 08:32:58 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, moshe@nvidia.com, leon@kernel.org,
        mahesh@linux.ibm.com, oohall@gmail.com,
        Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: [PATCH net] net/mlx5: Avoid MMIO when the error is detected
Date: Mon,  7 Aug 2023 14:02:05 +0530
Message-Id: <20230807083205.18557-1-ganeshgr@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q7vDcD5aZuLEThpzcoCTWL4FqZyYg9kn
X-Proofpoint-ORIG-GUID: yQ-bJDABI-xorHq79eNfH9xHZGZgncbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=704 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the drivers are notfied about the pci error, All
the IO to the card must be stopped, Else the recovery would
fail, Avoid memory-mapped IO until the device recovers
from pci error.

Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 932fbc843c69..010dee4eec14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -221,10 +221,13 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
 	clock = container_of(timer, struct mlx5_clock, timer);
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 
+	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		goto out;
 	write_seqlock_irqsave(&clock->lock, flags);
 	timecounter_read(&timer->tc);
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
+out:
 	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
 }
 
-- 
2.40.1


