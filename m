Return-Path: <netdev+bounces-224982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E0B8C7B8
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1823B7C80AC
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39F62D6E78;
	Sat, 20 Sep 2025 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KUdG9z8D"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6E1FC104
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370331; cv=none; b=h9YuoJwxpaowM9otrkIvWfVyPG3iDcedYBcTl4BUIgfQPZ8IqtaI+ClNoBrtYgljfslWLDxK5LuE7AdRwsr508dEBozORwu/h9v9pk7usrKSiUzc9a63qYIgY+nRuqzIe3hnWjJmLM2SAmcXoaEgz59kS2uBIjAx17nMEOvPmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370331; c=relaxed/simple;
	bh=9CWj0NL37rcS3J4GxeEKF45AY8LhEp6gl7JMEkEGM3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZxLwbP2Tcf8lh/yD+T2rjoP/KFMkJb1PpRDzCO9Qfbbyc6mUY21DvQjrHVHQV8XfEHuK0igZifluciWy+0iZsZpgxHEASIFJ9Zq0gjoGS5tMVVLzgI4k6F3eo5wBVgt2JxmCXMwSpX7g1JQ63YMk/l8P5Zl1WTMshRx2p2eo78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KUdG9z8D; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K7cPLe015910;
	Sat, 20 Sep 2025 12:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=YU+Cuo49Kj2z7eF1uxRR59Lo4rF81
	C0DnNKyffBtliM=; b=KUdG9z8DXR7+HXFq/6r68aQ3EL3OfW0tn0rGTvbgwDk3n
	JlAXOuUXa9Pr/GnZOLFgpHvsjNvesMi0wq8Ov+b4TQ4fKbOwqcmwYOcA1de40f4G
	W17YOmchkQemUYXdXpKkRzc+ANgSbfP7wyzBzcqZhCEKcuN2L6aoFNdJx7rk3aWw
	UXdO5XVVn0kY60OFKRlf/S/Z/NCKSBBC1gf6nobvSZrPeXageJ+ENWzG72vVDtgO
	MzIWOvVqsnXn5G9DGtIvsVmrfhMtfQjei6Blje85dVpkLxoTo2hjTkVFxfwsKaPM
	pY1mIqgO/IaYJftUUOATfufGRIPM4nVEnclLzqGng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad09ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Sep 2025 12:12:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58K70PkZ019773;
	Sat, 20 Sep 2025 12:12:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jq59ecw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Sep 2025 12:12:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58KCC0Z4029301;
	Sat, 20 Sep 2025 12:12:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 499jq59ece-1;
	Sat, 20 Sep 2025 12:12:00 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: netdev@vger.kernel.org, somnath.kotur@broadcom.com,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] bnxt_en: correct offset handling for IPv6 destination address
Date: Sat, 20 Sep 2025 05:11:17 -0700
Message-ID: <20250920121157.351921-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-20_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509200117
X-Proofpoint-ORIG-GUID: WVrKJcqwdDKwp1qrGhGaU-Yc8EGlMqOI
X-Proofpoint-GUID: WVrKJcqwdDKwp1qrGhGaU-Yc8EGlMqOI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX8qF/K+KaBp0n
 PHQ+G9U96iHvvaVS3Ss6ewx4s/h03Xz49TbUYqBB8ScjJFvbAcP3wAMEF/Gf3To5lkNkewxMIi3
 gRH5C/61gvlYGPO3fnwZyG919MirTCAtm2ub9XVsBsKvPPQKfn1w6N/zf+OfaGMjzFG3xS+666x
 zAFZvpEprro2wb0qU9BdGJ7ANj0mUVTKYEbWYVAVfFRyCSjx6ya4JrIiuIe7Evk3iMt+jusaSpN
 wQQXT/NJXsQkbtxiKLz1L1Whm/thxIYa4htg8glAYJdSlRa1qvbW+YbMLa1yWMuWzHuXyO/jsLS
 qmqwRXRwFImXVvNiDt0hSqP6qlRUiW5zuCNFWwFH1wqq7UFgKchszEypZTJydWRq2VTQ2xYmSnF
 y4xzWdgph8HVR4Zflx24ORimYMI1Tw==
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68ce9a11 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=IWR3VieDtcVXowqGW5gA:9 cc=ntf
 awl=host:13614

In bnxt_tc_parse_pedit(), the code incorrectly writes IPv6
destination values to the source address field (saddr) when
processing pedit offsets within the destination address range.

This patch corrects the assignment to use daddr instead of saddr,
ensuring that pedit operations on IPv6 destination addresses are
applied correctly.

Fixes: 9b9eb518e338 ("bnxt_en: Add support for NAT(L3/L4 rewrite)")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index d72fd248f3aa..2d66bf59cd64 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -244,7 +244,7 @@ bnxt_tc_parse_pedit(struct bnxt *bp, struct bnxt_tc_actions *actions,
 			   offset < offset_of_ip6_daddr + 16) {
 			actions->nat.src_xlate = false;
 			idx = (offset - offset_of_ip6_daddr) / 4;
-			actions->nat.l3.ipv6.saddr.s6_addr32[idx] = htonl(val);
+			actions->nat.l3.ipv6.daddr.s6_addr32[idx] = htonl(val);
 		} else {
 			netdev_err(bp->dev,
 				   "%s: IPv6_hdr: Invalid pedit field\n",
-- 
2.50.1


