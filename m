Return-Path: <netdev+bounces-232557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FEDC06905
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC71B4F28B7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446342DC77B;
	Fri, 24 Oct 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MK24m6GL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517B2566DF
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313625; cv=none; b=YurrhnDlCpIYFJcfX3lUrKL8WXDk1wWAg8JVy7itYr/VNB5aSYz36/D/mrxvF4ADSvITS0IuzbuIaQoSSHdWVuetr2MREFmfovo2BghytiQ7Fv4lk+FFFAO3X1fIH6rsdyFiCK8FQe9YSMmOJxVCuJiDpypKe+nwT2ZACu5bdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313625; c=relaxed/simple;
	bh=wGuksP5GFdLEQKYlv5zuBqT09EyUrzTjd8olXremcuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qq332WRp3pBVB7KYyoTitO+PHPA8Fy3uY7yWA7NgCCrXCigzqiyz16hciIt676pKPXLV4JVaQTNLo3ZlksJlOcINMDCNOk3t98mcZ4fNdweD9Q3MTXgJuCzb2gbP2tsB2YSLXkZdiVOzy0fVdwLUoui4Ym63VudX6LHr8oSTJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MK24m6GL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NaST013827;
	Fri, 24 Oct 2025 13:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mf4Pgy6pFL7S0hO85hk88NuMCd3f+
	Bxj+YF0GpXw1q4=; b=MK24m6GLpOc9KrFqEEmf1dz1u5wZGgbKBMdfT8IRfpqIe
	7qiJ2WSTmpG902G8hURsWDaaUSmO+7SbtR7x8+jRqMOxuslu7g5Nw+eFTlMvyqTA
	u98QFS+HJmdfBI8Q9MBNzoh18Fg7LWGqQMm2zQRzEjXbQRHJqPswPOPy+90arDXH
	Hp+puibhV/DRdmaK5ScXsT5T4iQBUq/WfcCBFR6wPQ5mfO68zyuhkxy3MnWsAIyh
	tXlUBR6k6HvW8yOdsfWhqfOEy7PBhk5EE66xs6y6+OvZGjHiwjqUjkxaTg9y2VF9
	QIOKR2+2mT1Ars/cMTR39HFt0IRXfZT0GhPfHL8iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah2g70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 13:46:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OCBlvM007741;
	Fri, 24 Oct 2025 13:46:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bg5k68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 13:46:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59ODki5m027958;
	Fri, 24 Oct 2025 13:46:44 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bg5k2w-1;
	Fri, 24 Oct 2025 13:46:44 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] iavf: fix incorrect warning message in iavf_del_vlans()
Date: Fri, 24 Oct 2025 06:46:26 -0700
Message-ID: <20251024134636.1464666-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510240123
X-Proofpoint-ORIG-GUID: JOij40voZ86C1wTNPgj0xgeVnL63-AOM
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fb8345 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UV6hcFBDGNwxlG23zUoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfXyfG+r9NVtUS1
 tLUVknovR891bMe1BOHliwHLElt5noL0uKT+JQVM9OkozqHfY0zyvjNlmOdqGwJ1RLzsZo1mt/c
 u4WLJCNQC2SmemfFd4fdpgXFEG7pb81j66Dbg0/R7eEmA0AxTgVo1dXzWHtzA+UksITp48dBFS9
 wt0AW7PV1FMV24dGbrDQn7TydlIQF8hMnTvb9CHSgXmU5V6uE/RCkG/by0tB7NqIVpPldsezanU
 Xz38vXQmCSl884sNhsFID9H4BJNNYyiQxMSACXtiBQb716n0mYZxtawt5cJ2+YjVyt2rkTro3d+
 Kc6Id7gScrRwRjcZrZgIwGZwfriMploaLfzlUbPErXN4XF3duXFD/akWBVmIyywvSMI9wmGUjz7
 R2qdFiLKW0KumaHdXKbXjXV2+SVWXQ==
X-Proofpoint-GUID: JOij40voZ86C1wTNPgj0xgeVnL63-AOM

The warning message refers to "add VLAN changes" instead of
"delete VLAN changes". Update the log string to use the correct text.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 34a422a4a29c..6ad91db027d3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -987,7 +987,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
-- 
2.50.1


