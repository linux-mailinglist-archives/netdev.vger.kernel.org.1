Return-Path: <netdev+bounces-129801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B075E986439
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 17:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0F028717F
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FB1A29A;
	Wed, 25 Sep 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RGBTGhkS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A71D5ADB;
	Wed, 25 Sep 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279757; cv=none; b=ajHEh2k35cVb4Sc5YFyp7x1hFJ0PN8i1vGVBJHGXt8Sqb5L+lD555GpW8WeRas45NWk31qsfGI8pbywcnbudWFdMKrCJJvLHZCLhl2f/qnwrYrh+KveSPGqoWsTmQ1EXCAiN4BKOwJUFtTi/b2O3VUVV2Vk0H+Yr28VdADcCESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279757; c=relaxed/simple;
	bh=6cl/j0h8/fQAecYQcMkV6Ik//UIK14kCIeO58lhlD0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YE0GT/inKcrY/wKjKkj12KJdFCAc4WAJI1sIyhpJkzFJHUW3JLlnXL7NyTknYyvSK0ef6G68E0TBTSHw7hOpxvjgCsvwT3y1MpYzE3UZ+Je8ebC7fypFDWvbM/SgTw3umiQrbqJHSlq3cFT4MamhBEbfYTGocHNtWM4QVT9MOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RGBTGhkS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PF8aGl012527;
	Wed, 25 Sep 2024 15:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=P8P2LInkPjfmmtxfJgORNu/tQb
	1/lCiXfKfhHbq/uwA=; b=RGBTGhkSeIKb57pHfMRqzNCTgKHQyqB6YZoeyoTG4U
	iZEu8rp+xZSeLRbWhbXUrgRLBXs3t4jdiGYkCwNouqHn7OIfJFK8y0GSb9+UqByC
	ZLfgMMvVqyZudVtcH/PjOu/aS42JIxan+8KUYSuZwNpgXEPkouNW1IjyoxAADxm1
	qVk2krT5dRp7K1qXFrNO5dDsIzwxG1ivmhag4VbVLBgrp3wV7vLedx0yQotlxb/q
	xD9YrqH8Gqpd9xpX811TMhcpJpGkB0BL46qMg1FgwLNlEcTMIGdNLPmgP7eYCQ1+
	H2tpPR0WSUO3xpw0PDxq7I+HG2dDdxsIuWiMuiuWi5Ng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk0y8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 15:55:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48PFtWwM026737;
	Wed, 25 Sep 2024 15:55:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk0y8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 15:55:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48PEpufn000636;
	Wed, 25 Sep 2024 15:55:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8futn58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 15:55:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48PFtUQb28049968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 15:55:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F8C958056;
	Wed, 25 Sep 2024 15:55:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E7895803F;
	Wed, 25 Sep 2024 15:55:30 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.18.127])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Sep 2024 15:55:30 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: sam@mendozajonas.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, gwshan@linux.vnet.ibm.com, joel@jms.id.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2] net/ncsi: Disable the ncsi work before freeing the associated structure
Date: Wed, 25 Sep 2024 10:55:23 -0500
Message-ID: <20240925155523.1017097-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: POry1i8rnsfMSXOG3dF5uswqgu50EnHn
X-Proofpoint-GUID: QzXtUoC9gSTn8yU4tyu1H-DzYHSrr1qA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_10,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=670 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250111

The work function can run after the ncsi device is freed, resulting
in use-after-free bugs or kernel panic.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Use disable_work_sync instead of cancel_work_sync

 net/ncsi/ncsi-manage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5ecf611c8820..5cf55bde366d 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1954,6 +1954,8 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
+	disable_work_sync(&ndp->work);
+
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.43.0


