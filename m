Return-Path: <netdev+bounces-222625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FEFB550AF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A074B1BC0C2E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E088E31283F;
	Fri, 12 Sep 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GgwV/5mi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B76311C19
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686485; cv=none; b=PyS3+hiYkXwZtVbVXx7giHPORHTUsrN5xLTC3QbNRNVV2b12TJWc4KM/jvqC5O4yIpetGg5o/JlHmh343I/t2U86/x8SW74i4keNvCKlqln/F87d+OjjNwPs4/EHy00BhXKx0ZRgEl5p+AO9lGzRm4c7dWu4eomRevSxm6Gs2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686485; c=relaxed/simple;
	bh=H9AMgHFQC2fW3r+zhFEgx7FSAMz2d7NWu816Capi9dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvBrKuVKAbWg/oSOGjrsj9v0qMDa7VQyYnwVBS9sWxf9LI+hz/z13igM+FJlhVKGtjdyvJw0Qtubq37PTb310Wv4791KsOwaZnydqrkLnvA+h1AFBxVKULQcKNqasAYwJICSQ9+jsA4xjBnHSeUvBp1sgww7+/VbKuvag+IEl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GgwV/5mi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tnTl021080;
	Fri, 12 Sep 2025 14:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=pT4fulXW4l/3njJxuzuoP0s5vq45i
	gkE0nQF9Xob15k=; b=GgwV/5mibNeurSCEDMK/CZkzYIYJKQINbNxMcL4LQNtSw
	BjT/X3Ks2kA08fooeuChcQwRQuCI+5pgaFmGLOp1BTINNtQpg7xUsWnpzY81B5Pt
	kh8b9P+oPhuVu2qXck1BvxsSvAOra3WV9LwYc+AttYvn32AEXPXVapOq6086tSol
	3hfYiHIMNFGW8QvSbzz4VCWk/aDqFsyTRxjszNNZ/uECX4t/oNCbQcyRrK+E1MrV
	GAO281kRy5WQei/6FD3fiaUNqNSxCCSK8ER0o6/iXMM8Wy9cRBeuHEbWBCpn1S7d
	ibjC7qcHGiPLa2nUygtJ0vQpYZIjDndOqks8RFuEw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jh0brx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 14:14:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCdFjK013730;
	Fri, 12 Sep 2025 14:14:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bde400c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 14:14:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CEESmp031238;
	Fri, 12 Sep 2025 14:14:28 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bde3yyn-1;
	Fri, 12 Sep 2025 14:14:28 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sln@onemain.com, brett.creeley@amd.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net] ionic: use int type for err in ionic_get_module_eeprom_by_page
Date: Fri, 12 Sep 2025 07:14:24 -0700
Message-ID: <20250912141426.3922545-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120132
X-Proofpoint-ORIG-GUID: XNV6rNmPcHocIYfFN-bbKBRisO07XCMx
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c42ac6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=9UgsCzVKAAAA:8 a=aYG9vCOGyGdZPDYcLycA:9
 a=rjeGxHOXENzEDeilVzgO:22
X-Proofpoint-GUID: XNV6rNmPcHocIYfFN-bbKBRisO07XCMx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfXy0lGsGc0dH2z
 wdSt6LGJ3ixP7TOQTrGKyeQYTW2j7uSh7T6ZBk+to99ezYLTbxFlTE8lvRzWlYFfhifzQOvW8Cd
 LDAlsogkWmq3B3PUvlQK+Km+JUj4HIqhw4xqZZZv9JeCDy5f3iUb86HsT7FdkCUCE36pYvAUIWo
 4MqHGyWF8kAZWb3QDZJZLjMF9Umn1mWht2J5IU5pVwuthFhQGpuRK3QPShjETUuNoslL9/tqz5P
 dmOL3Y966lRGVhwEvfPPBoYb5iWCB2ax8rVld/qUGH0E/NAgDFVQbx8CRFwAtOO5Zf4x2ygM2uO
 B3DFqgNVNXzTGY5GKkEBUl1m5siDFzFlQ2hDE9hgQxRGK+8oQzMCb6UtAIzUy8UMCFLorA658mf
 EJOBtJ13

The variable 'err' is declared as u32, but it is used to store
negative error codes such as -EINVAL.

Changing the type of 'err' to int ensures proper representation of
negative error codes and aligns with standard kernel error handling
conventions.

Also, there is no need to initialize 'err' since it is always set
before being used.

Fixes: c51ab838f532 ("ionic: extend the QSFP module sprom for more pages")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Shannon Nelson <sln@onemain.com>
---
v1 -> v2
Made 'err' uninitialized as suggested by Brett
added Reviewed-by: Shannon
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 92f30ff2d631..2d9efadb5d2a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -978,7 +978,7 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 	struct ionic_dev *idev = &lif->ionic->idev;
-	u32 err = -EINVAL;
+	int err;
 	u8 *src;
 
 	if (!page_data->length)
-- 
2.50.1


