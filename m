Return-Path: <netdev+bounces-206803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8DDB046FA
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1525189D109
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6423C269CE8;
	Mon, 14 Jul 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BCyaLfTw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE442269817
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515888; cv=none; b=NhE65nlWpGBVMRnv1m8c3aBBmexZVxkIFSJFUcivxcDhwRQlRy86mN8nAfIXzxVF5yJkXDPIe+gRKbHIneR+i6OClapfd5drGeQyfC1qa0zb06c4kjMZ2fyDCVPjG4FoOYMmhxVqMwVfqF2Qi0SRiz3jYjnrBsfG4Su59N3uWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515888; c=relaxed/simple;
	bh=TsJcLA3CgvD+tsH4Gf/Y8A3gW4iziLSEvUbDwiJDaGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwA/XejruuSAhyBdYAHQFsvFJ3M1AbXUa43JV02K/zfZUNd015HeiXcn/kM9A7QjFbZYMvHLtTC3VAJN/IDIiWgw7n8CcDSPkO7ZJwjOgbUx5VhILevj5ShutgdoJmHcXqvfqP0VaHsOykcvDNR6gyWX2F3ELTHWdngc1g/D3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BCyaLfTw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EH3npu001413;
	Mon, 14 Jul 2025 17:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=MWMv6kM7A1MYAZnhxf7ZrrnIb2bV5
	rf1xiaiPrp+xYY=; b=BCyaLfTwWSZp3UlBc0/sWPi6fnHSs9nkqOrBPIgRv4SLO
	eR8N5dlWtnQlz1qo0fDDBrIGRPJ+pQNkkUPL/4DbggdeCfFJazN2WNvMKv3DT8Ri
	R1ld+unVMumf4+UAfWAHE+vD4zR2ujkNa/Pwep1ACmmE33va0VmIDxrDSv/pLorP
	yaXYqRA/kmw0hGrNfc5J+l/jLpSzwp5ZPbcq8FaHvXXir9dlKVHIPk36ZSYfbf6i
	DlnO6MA7jSGj4YhqxIzDV73vfZnlVSYEpk78w/50BUYZzJcROr4ZWhP/VWhAeBhe
	pUMi+G31dv6D9MB1eCyzCMjbflJgAfZOEat1hiQcA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fvud3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 17:57:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGmSt3029618;
	Mon, 14 Jul 2025 17:57:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58mrg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 17:57:52 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EHvpU8039779;
	Mon, 14 Jul 2025 17:57:51 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ue58mrf7-1;
	Mon, 14 Jul 2025 17:57:51 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sayantan.nandy@airoha.com, lorenzo@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net] net: airoha: fix potential use-after-free in airoha_npu_get()
Date: Mon, 14 Jul 2025 10:57:17 -0700
Message-ID: <20250714175720.3394568-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140113
X-Proofpoint-ORIG-GUID: mJsAYs92N45bLN3Tue4NbRtjWgs5yxWZ
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68754520 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=hBxZxRE7htRTxmr4ZZIA:9
X-Proofpoint-GUID: mJsAYs92N45bLN3Tue4NbRtjWgs5yxWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExNCBTYWx0ZWRfX4ylNJgGXEYBo mZm71e6QNYNx+2qpdvPBdNCQLzOB1/PDLOpZ9Ms3rE8AnKsO+O1UjH4kgi8IrPZfz++ecExrdv5 RWBQF/z3Q/W98B6pZ/edzrQlh7+DnCl8h8zBL5RGpZXfDyzVYxrHtDNNIMcUr6f/zf351D0n7dZ
 O8vXVVv7j/1fB/jj8j5QX8o9YyGFrvMuB5Brr4XvCEmzDURIcffcM+IRwzhbTEKZMhV9xHqNqWY 2YNg4YSA10W1Lu5nqlf5WhfbkTC7Am8MstMvesTOUjNJdsXBpqMUA9pVs8G2Qp2b5XStEs8Oj8B Jfa/u9rNAcMc2BDLvRYqtJNwMemsshrbi5CfpGQmuPgHJ323QQf1LqGgxQ4vYV+FKPPgv2Dlki7
 fPW4xRIAvbuP0/48ZivC9phcgKFa9JuYDSeTcIHPtqsSWdtKZ4kRRZsuIlVeTkmhyf7FK06d

np->name was being used after calling of_node_put(np), which
releases the node and can lead to a use-after-free bug.
Store the name in a local variable before releasing the
node to avoid potential issues.

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 0e5b8c21b9aa8..30cd617232244 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -400,11 +400,12 @@ struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
 	if (!np)
 		return ERR_PTR(-ENODEV);
 
+	const char *np_name = np->name;
 	pdev = of_find_device_by_node(np);
 	of_node_put(np);
 
 	if (!pdev) {
-		dev_err(dev, "cannot find device node %s\n", np->name);
+		dev_err(dev, "cannot find device node %s\n", np_name);
 		return ERR_PTR(-ENODEV);
 	}
 
-- 
2.46.0


