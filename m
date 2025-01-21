Return-Path: <netdev+bounces-159893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1CEA1754E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D823A43D9
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2878BA3F;
	Tue, 21 Jan 2025 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jVWPxbYa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D579CF;
	Tue, 21 Jan 2025 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737420626; cv=none; b=ODvXjiUSiiIyq09jgHu3+aKsn8zY0woU9O96sT6iGW2cLWhBG5Rzi9y/oloV5jsI9hO4Pb8M22Qh5JNeiIab7NOniEcDjWzzZ6+ta3+EDGSWN1G9nPc/4I+crbwiMqPU05ae0rY83Z1wh/ZuSxwmrzsgG6p3NhLQLjzP7dno6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737420626; c=relaxed/simple;
	bh=PN328jyx3pg410v491/brYCarztqpDWvP+P0edW2ACQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnV4ugDwoMQBg59zGxyyFmNwTiCnX+pCTj5ZZGZDcMUGeLKj27XbQgWohkfC7eUP4jNz4CQaceTjARyS8bracgk1Bun5uSNPsy4wN5hHBNWEMFzy8qlEn0tP8pLZ3wglzOD3RdVMl65rQ7v2qHxr/a5xLL6F/jqORas6LRH50b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jVWPxbYa; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KGMvar011787;
	Tue, 21 Jan 2025 00:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=Y0i0NIXmUMRfHjAb805Wm0NeB/eJd
	7gYXF48XL/H0kg=; b=jVWPxbYaEmlPSOMV1w70d34Whctt/DmMCzbQsD6ZsqQm6
	wOfz+V1Av3bUmXczNiexbwS2Y7U3xMAVQCIYkNgAAj/57zO8cagM5thFFukDhA0Q
	EM+HH9sirKQT3fE6zRxJlF7cCmhnziCm+wRaEKvjqiMGEBIRFssF5D73gYkcyfP6
	x39biaLaELiEeQ6TvPJz5UuZoK31Hc49tO3zibmGT6WQA1XiZPNA4Sz32Evbb1s2
	g1arX4p/Qt3XkT5u33X648/rGmL+RbQDhc9ukjD9ceaaMfo5sf8OkfWcV/hQpuLR
	jnZkzWTS4LHEMnyG3eoQPNzl/+wqtZMKgg7+JkGug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qkvddu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 00:50:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50KMB9A1030296;
	Tue, 21 Jan 2025 00:50:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fh5aun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 00:50:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50L0o6c7000969;
	Tue, 21 Jan 2025 00:50:06 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4491fh5asy-1;
	Tue, 21 Jan 2025 00:50:06 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Francois Romieu <romieu@fr.zoreil.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] net: mvneta: fix locking in mvneta_cpu_online()
Date: Mon, 20 Jan 2025 16:50:02 -0800
Message-ID: <20250121005002.3938236-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_07,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210004
X-Proofpoint-GUID: hr6sjcEIIfoZzqxUL2j_9AjwRLusbvZV
X-Proofpoint-ORIG-GUID: hr6sjcEIIfoZzqxUL2j_9AjwRLusbvZV

When port is stopped, unlock before returning

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis, only compile tested
---
 drivers/net/ethernet/marvell/mvneta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 82f4333fb426..4fe121b9f94b 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4432,6 +4432,7 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
 	 */
 	if (pp->is_stopped) {
 		spin_unlock(&pp->lock);
+		netdev_unlock(port->napi.dev);
 		return 0;
 	}
 	netif_tx_stop_all_queues(pp->dev);
-- 
2.39.3


