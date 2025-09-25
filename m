Return-Path: <netdev+bounces-226486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC18BA0F84
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39598188F2D2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B43128BA;
	Thu, 25 Sep 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1MKHSP2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81021279351
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823354; cv=none; b=HdNSTbsfEmsK05+1XlKoBmhE+Joz4DonsIRlRJTdrD/w7uNapoDIdZhdgIi34myxE9V4y0dz2qqa8/Yiq30vP6JWk/TGHvoduwLST0TufMyvnJci5dDnF8/1Bqk7cymQXKzeFQ0aVmCudmD74VX1d8YdjnHGa9BITzutgCYNAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823354; c=relaxed/simple;
	bh=B73gyIOK1gT+mP7CJIUTbIlqjfSS2xShEqiW1uzYaXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSR1cxfl8SempMkVhX9237cceEpTibGSIPB7oe9+ON1r6PDJdZBVOd+QiiWqzIxwlTg+EfwZs74gAg5a09h58mzoIT76zrbneYxm/EIopaR3Xufm3aFYc559j4wJOyXlUq/u5sInv0wffXwsF3qRqtDv7zK1HaSRDqzuaKUld2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b1MKHSP2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PFuKoV010461;
	Thu, 25 Sep 2025 18:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2YkWXtt+/iNmBo0YKAv/upVPd12D2
	aqpm9C0JlblUaY=; b=b1MKHSP2MjFgriKm1ajWP2S/3X3vb3qR9/rTubjTTJ6EL
	A9ABLJEVF5LyWIBOTuCuDul3JJDuaNuBABxTos6UUyqeH7rEwGTOyHoorszUZh26
	0qiz2Qrwm2VzXJraDOdrctxF/MdiiRl6+P0Mu/lkcHsHHmntxbttZGn/z9e9bmkQ
	n0MpgxSI8zCxbcQ30a6sLhV36reR9RVm1jnoYNwp6ufqII3s85Gwv9AA7GfG09tF
	jFLnlELilPwFgzMKgVPzkVsYH2PrY+unDBowcXzLPmAUk1D0ciKeRIw3VGk6EemT
	Typx/34WmC4yILgtkhxS7g+MoA40KiuoAW4hBDBgw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdtfey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 18:02:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHjCxK014657;
	Thu, 25 Sep 2025 18:02:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a952fggy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 18:02:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58PI2GJs002050;
	Thu, 25 Sep 2025 18:02:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49a952fgfr-1;
	Thu, 25 Sep 2025 18:02:16 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: krishneil.k.singh@intel.com, alan.brady@intel.com,
        aleksander.lobakin@intel.com, andrew+netdev@lunn.ch,
        anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] idpf: fix mismatched free function for dma_alloc_coherent
Date: Thu, 25 Sep 2025 11:02:10 -0700
Message-ID: <20250925180212.415093-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509250167
X-Proofpoint-GUID: k1rCsmWWRNMsQDPyhidLnwUPFUX7zwcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfXyy/ei0Ix7dju
 ukfYwNrULI0LUnSXF1rIibOq6oD6zQ9bx0FKI9AdB8DMd6d2LXfwd2gMm8aIotPWlo+IgOVrY4S
 AOgcUmYy9Wsyxf4hwffcfIlQgRVwjYQkA1awD8dI0fZuzTSG7UsUt3XLVt7nTcQEX4zzlBECH2v
 owFBY/3Ge56cMVJ70nlGLpQFnyQbknmYX1pC0aKsWLCZvwrKHmccPsG5ZH3m5T594Zco7PcbQ+Q
 KZyEsAuCTlPghprsvlx+PigpP3QQY/3GxOcv1oEw6217S87+HZTSX9W8kcxEPe1u9nmeV4HWAgi
 +FhM9uyQpt8ROaj0j6pesE7i75pSS74HH68ppOVHJLu7irIcNY+thn7n8f0x7HlDpzPzRr47yzd
 xv6UwRnZQDEx2N+U7PR9Z77n0YVTZg==
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d583a9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=OrEgqHaMTj2tCEy2Q7sA:9 cc=ntf
 awl=host:12090
X-Proofpoint-ORIG-GUID: k1rCsmWWRNMsQDPyhidLnwUPFUX7zwcL

The mailbox receive path allocates coherent DMA memory with
dma_alloc_coherent(), but frees it with dmam_free_coherent().
This is incorrect since dmam_free_coherent() is only valid for
buffers allocated with dmam_alloc_coherent().

Fix the mismatch by using dma_free_coherent() instead of
dmam_free_coherent

Fixes: e54232da1238 ("idpf: refactor idpf_recv_mb_msg")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 6330d4a0ae07..c1f34381333d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -702,9 +702,9 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
 		/* If post failed clear the only buffer we supplied */
 		if (post_err) {
 			if (dma_mem)
-				dmam_free_coherent(&adapter->pdev->dev,
-						   dma_mem->size, dma_mem->va,
-						   dma_mem->pa);
+				dma_free_coherent(&adapter->pdev->dev,
+						  dma_mem->size, dma_mem->va,
+						  dma_mem->pa);
 			break;
 		}
 
-- 
2.50.1


