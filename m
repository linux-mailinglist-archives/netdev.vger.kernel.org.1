Return-Path: <netdev+bounces-68151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF691845EE2
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB081F2DE2B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD37C6DE;
	Thu,  1 Feb 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KiyoMXCU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C837C6CB
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809761; cv=none; b=CXPdFPJjGYCyFTt4n9ZZIoO93lTLNmw7Qc++QYYt+F4pkSUDpz7PhB8q2p9o4h+4nX0NHpLthwmYLnmU22Cz5m4/0c1jGSDgXI4YqK7yf60Z2ki2GkI3FHBaCkYHX6BdPUEYc9g2zaGeccVEB7Sr6I9YPOLJqaNSjyalQJamUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809761; c=relaxed/simple;
	bh=/Wrk96vZIerFbnVJIhO2E/dIoGaH6mMaFGWlbosa9aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8TGPABKai6QVVo/8EN+vsf7Xv7cVFrF8xYlyAA0tQjC1Nw3jGESE2Q5xX39LDaCAbEU4d4Ue2FiD/WTXoeBrSWBhIQ/ntnwkiAbEhIuUcjU/9ZmTEQ1+DxxJdv13FYzCto03zU8sp2oQ2MU6BIN4TqfG6Nruw5qy9Yz3eFKEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KiyoMXCU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411HavuX025768;
	Thu, 1 Feb 2024 17:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3FSFDlXPHrSxBSXeP/zpAamoXpEdxmlSh9RqO4bmNjw=;
 b=KiyoMXCUKQ2O9d+kmQMGbOUOlmNwMDtV/Uwf3Wmj3AJJ3bfT0FP9WSiUUkogKywtUdu9
 LdN9Z9kgoPKamns8Gr14vKQJ4L1qNzdU6rd6M0LgkQeA02alrPWNoMtHgYoNuD/RyhpC
 uaRpXaKhOIkatP9I7VHTtD4+Rtr+BBO90xSHg0ZbLqvNXeZD7mqSPObvOyYyKVtGa+aX
 BOMnmxcSM8Duaj/yaedSVY9U9wjr76fdF2WnUfvIRCGszOTb0D/GmfudzH5sH9SGjNCn
 EWcNV9h5PVQin4K+otyKBw+m6MoFsVvngFtfXr/m8XUlkP29mF5vRM1DL8pgCMa5M0fg Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0e093trg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:49:13 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411HbaBN029387;
	Thu, 1 Feb 2024 17:49:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0e093tqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:49:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411HFdPS002256;
	Thu, 1 Feb 2024 17:49:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5tp7a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:49:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411Hn73Q57999640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 17:49:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EADC58052;
	Thu,  1 Feb 2024 17:49:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4376F58062;
	Thu,  1 Feb 2024 17:49:07 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Feb 2024 17:49:07 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
        manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
        simon.horman@corigine.com, edumazet@google.com,
        VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
        thinhtr@linux.vnet.ibm.com
Subject: [PATCH v7 1/2] net/bnx2x: Prevent access to a freed page in page_pool
Date: Thu,  1 Feb 2024 11:48:21 -0600
Message-Id: <90238577e00a7a996767b84769b5e03ef840b13a.1706804455.git.thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1706804455.git.thinhtr@linux.vnet.ibm.com>
References: <cover.1706804455.git.thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R35_jKJpokj1aV0GjDWV5C7y2BH6W3fy
X-Proofpoint-ORIG-GUID: 8xMcrqU1e0EVlkRyWGlNA49l-u1pXpld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=732 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010138

Verify page pool allocations before freeing.

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index d8b1824c334d..0bc1367fd649 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1002,9 +1002,6 @@ static inline void bnx2x_set_fw_mac_addr(__le16 *fw_hi, __le16 *fw_mid,
 static inline void bnx2x_free_rx_mem_pool(struct bnx2x *bp,
 					  struct bnx2x_alloc_pool *pool)
 {
-	if (!pool->page)
-		return;
-
 	put_page(pool->page);
 
 	pool->page = NULL;
@@ -1015,6 +1012,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
 {
 	int i;
 
+	if (!fp->page_pool.page)
+		return;
+
 	if (fp->mode == TPA_MODE_DISABLED)
 		return;
 
-- 
2.25.1


