Return-Path: <netdev+bounces-232656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E6C07BC9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A41C208CA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8011F0E56;
	Fri, 24 Oct 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nOTn9/FB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10528311956
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330351; cv=none; b=RRN+IfDHuwGIksSHRTDjWUI9ASoJjIY2T3Ym8YNF0XmYphLML3+LihT5qdxHYDLikxunRNgHFCK2s+BUVGBvGDyhYJBzhnMlO0IgvQylHDWJy0VwVwHUrSaV/Ibh+/znrdp0Ak0VTHaY8VPINB3zYl00PBm7gWkSatTbeKgbNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330351; c=relaxed/simple;
	bh=oF0xQKta9woMkjRloLNata7GnWCJUU9eN4GD1R9mQyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6DNf7co3pXH+QsRE8Y2otTCRt4Nl4A9q7kdODhS+AxUKDUSc3rNoJWU39X4Scb/TKuMSQI70oPYJOThbfKACUzEiRVD9ff+KcrmnJUieUb5SrWz7jXkb3TvRsoDy5VnrK221I1cMZdIvmh5v/w6PStq1rUZz1MbYoqkP2APv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nOTn9/FB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OINUkr012082;
	Fri, 24 Oct 2025 18:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=XkKqZOV8sSSGZVqzvceBZEcc7n8sQ
	98xxcCJSbJ8wEM=; b=nOTn9/FBkuwRXVtkFCXiwQn/jDWJIeX0/mNvmmvc2cdl2
	P3X7B2ySGo2+mSKReiKqMbLlK38dW4o9vHHd+81xZTXl91whjIBdkp29ozT3UcWx
	KRIx2eKTFMn4Qge/8rv56I8cXKSsuuZauMvEXjgPKFCnVmuHQN08d0vRVvpYq0Mu
	IjjDAQwc5Ngwo5dY99QsTskzsA2hC7tiYVwcWGq+n45rCW9CBL5FgPE//qH7SMvk
	C1Ae7gbVXwv345b9a9wZRcyB8qk7YfLyrlc5CSVQzv/V+avLZgWcXFixvlhsCuB+
	9F/tGhVE6YssTO/fdmrBzel+Zdlu3a99ElpFnWEAQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0wcm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 18:25:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OHwduC006350;
	Fri, 24 Oct 2025 18:25:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwkarut9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 18:25:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59OIPWHP016656;
	Fri, 24 Oct 2025 18:25:32 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49xwkarus9-1;
	Fri, 24 Oct 2025 18:25:32 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next v3] idpf: correct queue index in Rx allocation error messages
Date: Fri, 24 Oct 2025 11:25:23 -0700
Message-ID: <20251024182528.1480729-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510240166
X-Proofpoint-ORIG-GUID: fySugU6l_WVzUeeAOGR9ZKiKGisc8VqX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX5tyTx+m0H0HS
 1i8wctG7IJzypw0CPh1NotZFkS/8/Bi9f9dXH/Jr0LFYcx1wOD9vziSysqk/jF7dhf8j0c6DdPk
 vvyt3TmIzNyDvXG5RQwz4aZcQP9+C+4x6m1WtluPQrRghFNFX9vaSajErVUBEh+G7ZO4k5BbSn9
 4y0fN152LzJNNKpWac96uQEn/guPOHSfl+uVR94n9VuYLAgs75XfGFTH1yka9Q5QR7BAw72XPco
 A67AK3KsNdK6jgataMkxrPfCzA1qUH7MiaRU00sj9PR3nbgth5sA/r7DJhV3s0CAlYMq0unYI9H
 4pxLUJiAvoagabKgGgKp+6HtMmQp9BRGBqak/OsHciAnsfMbv9MbZSoJU8bzkojUllSi0M0tJEk
 NBQx+9XqoplxjUz7e2BEvWHcPAqAClsWU8efCcjm/o4S366dRcY=
X-Proofpoint-GUID: fySugU6l_WVzUeeAOGR9ZKiKGisc8VqX
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fbc49e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=bN0ZCpVs3yKAuBo6K4UA:9 cc=ntf awl=host:12092

The error messages in idpf_rx_desc_alloc_all() used the group index i
when reporting memory allocation failures for individual Rx and Rx buffer
queues. This is incorrect.

Update the messages to use the correct queue index j and include the
queue group index i for clearer identification of the affected Rx and Rx
buffer queues.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2  
no change added Reviewed-by: Simon
v2 -> v3
added queue group index i as suggested by Alexander.
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 828f7c444d30..ed0383ab5979 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -922,8 +922,8 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 			err = idpf_rx_desc_alloc(vport, q);
 			if (err) {
 				pci_err(vport->adapter->pdev,
-					"Memory allocation for Rx Queue %u failed\n",
-					i);
+					"Memory allocation for Rx queue %u from queue group %u failed\n",
+					j, i);
 				goto err_out;
 			}
 		}
@@ -939,8 +939,8 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 			err = idpf_bufq_desc_alloc(vport, q);
 			if (err) {
 				pci_err(vport->adapter->pdev,
-					"Memory allocation for Rx Buffer Queue %u failed\n",
-					i);
+					"Memory allocation for Rx Buffer Queue %u from queue group %u failed\n",
+					j, i);
 				goto err_out;
 			}
 		}
-- 
2.50.1


