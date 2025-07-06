Return-Path: <netdev+bounces-204443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A9AFA786
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 21:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44C91896FBE
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC02264A8;
	Sun,  6 Jul 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S2ycRp0z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCB155757;
	Sun,  6 Jul 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751831561; cv=none; b=pXzqwXUo7MfsV6CD4bQdMsUWnWrqb9DaCyOrTyRITROm6SHaBkxQ3SWf0L3iB4Ev11nvD2dG/SiumCN89rIP21HZQP4ULJLb0SXRfSNshjEHae4TZsPl3JQUzr98uwiLkzHzNVZPmu+QOBOsnZbukqkzEyrJC6wZ3kPfAXH6+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751831561; c=relaxed/simple;
	bh=s0h+a9qLrIZEARpjhdCOYc+6tgoyC8w3Ppn8ZtC0zyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BAQwxdQnP6AsLlSe3UL4sAQ9EruFF1zqOJUMR0biouUweRh6FFDxj40jyZXJTIx1lXMI3dzcAP/flx3g2e2yzktdKbOIDHHE+iA+yiHpctxUH333XxdOiVC1jHwvCxCLrjxnPlVabl/3FK8BEFkk8KXF8PyOBYUyJ5q8Een3sRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S2ycRp0z; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566GUf7l002277;
	Sun, 6 Jul 2025 19:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=amTDFcbj9f1xnTT+
	UZkRmI0REECJuhlFHPddZ2sUimI=; b=S2ycRp0zW2cu1HEjtxIysddKylcXxg5+
	LVal1g4RKqQ7ykuTGXXXzhaHDgDwrRSNfD+4vFw0vB/lWRaJotgb/R9LagGqgMpG
	GKU4s3TUata5fTs66o6ud3/ClZzlxYQBqOPDoGNY475B3gYVOwmlDcCmjcjPGBxD
	2tq63J1e2LLWq7MZZHP+/KQfH9vYlqUgWBgcXdrVVXOmej6lyZN3Y2ZW+tI4n96A
	n0kJgJLikpleLt03omaS/AApnbXn5UAwwzGucyN69F8N0WSnjny/nvopXz+odspG
	77jQkEfz3RhtMzRnwlejF1tjUcgfDGMbI8jbPtc5+3e7lyFTgAvDKA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptu7hg45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Jul 2025 19:52:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 566H0Spl040487;
	Sun, 6 Jul 2025 19:52:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg7rq2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Jul 2025 19:52:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 566JqEfg028809;
	Sun, 6 Jul 2025 19:52:14 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ptg7rq2m-1;
	Sun, 06 Jul 2025 19:52:14 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org,
        darren.kenny@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: thunderx: Fix format-truncation warning in bgx_acpi_match_id()
Date: Sun,  6 Jul 2025 12:51:42 -0700
Message-ID: <20250706195145.1369958-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507060127
X-Proofpoint-ORIG-GUID: TA32LHohU68ojy7Z6Bs4ZPiLwS7zjNyc
X-Proofpoint-GUID: TA32LHohU68ojy7Z6Bs4ZPiLwS7zjNyc
X-Authority-Analysis: v=2.4 cv=IMQCChvG c=1 sm=1 tr=0 ts=686ad3f0 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=xO2tqtdlJwZuTTCz-PAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDEyNyBTYWx0ZWRfX290a2KG5Uw11 NJH7ouZRRuuXsyoy1I4TPFcf2PfG3h7fmI3f6dYRG6PX4IUvIBiaF/jMs4IkkiQWt2Wcuy5ZuZB JsBFB+ZkaXMRfN/4o+REHcvAZEcSPg9KWdEPRnHGInzTlSOooxAeHUVRlg7qRaooyFAPe6WLuEG
 Mh5zdJyG4IojyASk9WtvpWKu7SYARl3xlzqTJ+xPSxciCK0/2aJxwj2e6aUQyfJlimpXBjE2CeE Uu5cZol1ZV6iz5ghsXRlmM77UAfTdUoUYZMjbGFPUhSisQELfcJIm8WgjxB8Lmt8mZ/PkOL1Nm0 2QEDxpg3UoCGkNlx53IafoRjg6hP2ROiZBq+bl4iwQSMEN+pch2yXGSj14a/bR2Rb6ySn0R7uJ/
 ToKMDxLMLOnVnZe6QKJxy+UsLdY1C66Sluz2RIYYErL7Myj+W4wp0OU6D0nqq5GEQ+deJB5p

The buffer bgx_sel used in snprintf() was too small to safely hold
the formatted string "BGX%d" for all valid bgx_id values. This caused
a -Wformat-truncation warning with Werror enabled during build.

Increase the buffer size from 5 to 8 and use sizeof(bgx_sel) in
snprintf() to ensure safety and suppress the warning.

Build warning:
  CC      drivers/net/ethernet/cavium/thunder/thunder_bgx.o
  drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function
‘bgx_acpi_match_id’:
  drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:27: error: ‘%d’
directive output may be truncated writing between 1 and 3 bytes into a
region of size 2 [-Werror=format-truncation=]
    snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
                             ^~
  drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:23: note:
directive argument in the range [0, 255]
    snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
                         ^~~~~~~
  drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:2: note:
‘snprintf’ output between 5 and 7 bytes into a destination of size 5
    snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);

compiler warning due to insufficient snprintf buffer size.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 3b7ad744b2dd6..2eea3142eebea 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1429,9 +1429,9 @@ static acpi_status bgx_acpi_match_id(acpi_handle handle, u32 lvl,
 {
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct bgx *bgx = context;
-	char bgx_sel[5];
+	char bgx_sel[8];
 
-	snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
+	snprintf(bgx_sel, sizeof(bgx_sel), "BGX%d", bgx->bgx_id);
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_SINGLE_NAME, &string))) {
 		pr_warn("Invalid link device\n");
 		return AE_OK;
-- 
2.46.0


