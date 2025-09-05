Return-Path: <netdev+bounces-220411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748CB45E3D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4084D16536D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6821E04AD;
	Fri,  5 Sep 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C2sK3xal"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53B20330
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090056; cv=none; b=gd+0N+wQFTdRESD0yU0INpdL/hxR7L89kxqQ9sfGDjin6DmGOmRPRAZAFxOTdYLYQJFpK7AvSDLGX3WV5h9MFhFluAjV2qqXedzcXA4TvW+5PY1e3XWV+aP87FRFreSUe0MZFnpJFASuTdxnB7aNkDyobrspWksEdyObD5XKQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090056; c=relaxed/simple;
	bh=Iv6aI5AzC31p+XrPz0ld1Occ0bFRpR3eJKdtMzf1WQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUCw0dZWm76HxehtgMZOlDoOC6urG35MgMBa14Zmo/CPLaz6wUHB/fII/V8PoHy0glJWKOQOlhzhXj1MTUKpgo96ux7TxOwiAgiNZzw8/JxxbQ//BTjYzs50id0kUyd3AorE6jOEtmJUW2D6sW7u0vR90oLxQaEpqkgW3zyZrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C2sK3xal; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585FEjjX032086;
	Fri, 5 Sep 2025 16:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=EjnP/wLtNKnoRkE2dW6KYbn19Aftv
	XuU6y9eFs6HBsw=; b=C2sK3xalTcU8RNI1t6fwMjeUk/FQ/P1cmPRY5hMzOwsl1
	TYBLNEGlW7rCvTDIZF9KAI70n8r50q0CW2Isv860xEXfSVWVppgQtzdHPuIUeOHe
	/a/hN0nwCYbkAzPKO9elc4WWN4+rAQs069fUulLTkxCQB/g+orn08Iu7wkHBfMM2
	T3Sxgz5LpEx1qhy9ITzDeykFStLJ06QftyXYKBKGYdPNRuFPW01WGT6rAGWOzOx3
	aNTu5g3D9F5pEOcfB4hm4fAMEeDTbQbc5xqOQeBrlYwEgEkAPsaEPpndzXqwc2WZ
	oVmxNbaDFHHXY4KP9Qkiq+olxf8VB+imWKcaWonWQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4902b2g58c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 16:34:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585FT74P031776;
	Fri, 5 Sep 2025 16:34:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrkewnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 16:34:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585GXxcf026328;
	Fri, 5 Sep 2025 16:33:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48uqrkewm0-1;
	Fri, 05 Sep 2025 16:33:59 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] ixgbe: fix typo in function comment for ixgbe_get_num_per_func()
Date: Fri,  5 Sep 2025 09:33:49 -0700
Message-ID: <20250905163353.3031910-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050163
X-Proofpoint-GUID: HXDJ9ygbnRIbqfJjUMWx-91wpIC5VhA_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE1MCBTYWx0ZWRfX4PgtjIxiocoI
 sA7+wNutzvl/2wYa4dLohoL3ngev2iVPy2EAlssPhaR4CO3gW9Dl35HCEV7yeKLXidriA86K0mk
 7vlf7mVWPcxZ2GDHpvFt9v9P3z7GVP89VWgrv5onWdRiyrrxDuW9fEofRxcyzx4CDSpR/Mcwk4I
 I9Svia0ZMG1P6sZZH6Dd8v0i3m/P4wTUDIJeB80r4SIIQN2+DxDXBvbEl11sMLTQByiC7FV11w0
 Hm4pubFBstLMtZK3IwYPEE2YCc1XcN+jtMB1Fs9sNpos255wik2vH01X455tM8jyJOktVfIPGS2
 vnyJ+R8LAx60/FD+rRtticbkLdJBG7q55VYqO7UqatXcHE6E/20GpDSl0wJNEZd59bLMvSHZBTI
 Ts38PAW0PEMV2MQk79ZsOUlDAWHWrA==
X-Authority-Analysis: v=2.4 cv=X8lSKHTe c=1 sm=1 tr=0 ts=68bb10f9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=BqwlVtyWRyGNvs_enycA:9 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: HXDJ9ygbnRIbqfJjUMWx-91wpIC5VhA_

Correct a typo in the comment where "PH" was used instead of "PF".
The function returns the number of resources per PF or 0 if no PFs
are available.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index bfeef5b0b99d..aed8b30db2d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -774,7 +774,7 @@ static void ixgbe_parse_vf_func_caps(struct ixgbe_hw *hw,
  * from parsing capabilities and use this to calculate the number of resources
  * per PF based on the max value passed in.
  *
- * Return: the number of resources per PF or 0, if no PH are available.
+ * Return: the number of resources per PF or 0, if no PFs are available.
  */
 static u32 ixgbe_get_num_per_func(struct ixgbe_hw *hw, u32 max)
 {
-- 
2.50.1


