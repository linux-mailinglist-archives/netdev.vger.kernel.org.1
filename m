Return-Path: <netdev+bounces-197946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BDAADA7C7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 07:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5BA16BFDF
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F21B040D;
	Mon, 16 Jun 2025 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S64gmAVD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582A189B8C;
	Mon, 16 Jun 2025 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052722; cv=none; b=TcrDTNjynbjv8rT9hC61x/T6Ebc9fe6D0Lx+G5R8rkD9cxcTcKzX57fJfssJdnRNcCjS3+lDRsul/YBPgbC0Csafeh5X2965GPOC/A8glyKOei+X9nXmrS0GeMT1vc3f8QguD07ZKHTroCyUcrAmrQIvaR91ETobzJ2dsnxEgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052722; c=relaxed/simple;
	bh=fpnkkOftvr32u+qLJ/VQLPl9wzt0dntur1yD8wmaBr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBbtZUnayJUVQbUvhos+S/x4LClIovmgBBqaNyIYOCE5xDC1KrZLH3JVi8NnQsfXn8aXh9DjsThHxVg6+fVOhj5jvhIIG72a8UoSz0sPgMORCtsd6vkKRSu3994CWaFAqSoRP57Zm6zkMclYOhKu2Th0pw+DHov4QrdZgOXcI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S64gmAVD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G0WYLe014065;
	Mon, 16 Jun 2025 05:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=zWCCR
	oNpZVN4KFAYLFC9HnHKzqleSTDoIKfkY6cqO10=; b=S64gmAVDWXzB91rIWdgob
	LWvGNatIchgh0K729kY1iZNOT/wGxCT7l8soMzg0L/4M7QE1VhITPRNEzSZGfL93
	as2usjIZ9fL5go7vD4Mtq5H1BdoN+8STEeSv65lLLgGLIJ0S36QcxSwHHlwv9S3t
	IsVvo39Sf6O3bx3iUZPGldzDrqcfvDoK4TB4u5B3okv0hYTjsqGcKdyUSeYR1GYi
	J6sMHVE03w/vGlWQNH9JcbOds3X9j+bbzn+J4zh6SClOe5YeYWqeFKYpkLUHnREZ
	I3xLjP4Lt0r3njjW3pHDLXL6AIQVNvWPjWk/uPY3uYOZ4BHnYJ29hIGnVto4YXEH
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4791mxhpxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 05:45:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55G4Mq7F032103;
	Mon, 16 Jun 2025 05:45:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh7fhg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 05:45:09 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55G5j7FU015580;
	Mon, 16 Jun 2025 05:45:09 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh7fhda-2;
	Mon, 16 Jun 2025 05:45:09 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: pabeni@redhat.com, kuba@kernel.org, jeroendb@google.com,
        hramamurthy@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, netdev@vger.kernel.org, almasrymina@google.com,
        bcf@google.com
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        ziweixiao@google.com, joshwash@google.com, willemb@google.com,
        pkaligineedi@google.com
Subject: [PATCH 2/2] gve: Return error for unknown admin queue command
Date: Sun, 15 Jun 2025 22:45:01 -0700
Message-ID: <20250616054504.1644770-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>
References: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160036
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAzNiBTYWx0ZWRfX09dleojPizNU +Isuc89mK7W5eExXrnPLW8soG+8zzJKaMIQruSrXZe/P4vP9XLkJfYxkrVt9u2Z2P1HT97e4YOK Yk5Pl6nQNlwxIA8gNBxSZCwNI06srOu8C14mn7pr6jukNO9rsIynviwdYqNLEbgfhijNp+oSZFz
 GjdWDGYrPZxcRkk1p2/6XIMgZICmSPdDJsLzqrvl/khRKHyOldJQk/NHtEGyz2uEohqXUiFy/8M aQYNBpFOHtLCEYc9O8so3+kawSuICd4Wadxg1DTfgZw7buzETf0xX2iGM9NK9qcaEAXSyE8X9EA ZNJ3uDMFDiGReHbaMDa8QWfpz0KGbcIXyyQ3ynL48TgyY7nG46whpQFvONDRLcDTLb8IoGH5E48
 NGAQxX35x4S2tpuj4pct8yrhLWyP2mId1KHZQY0gx18JJP1CTx7h18Nqqf5C2k4ZOnIuCe21
X-Authority-Analysis: v=2.4 cv=HvR2G1TS c=1 sm=1 tr=0 ts=684faf66 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=dq2otab6FrwKeooAi1oA:9
X-Proofpoint-GUID: KBjjd7qMdtXynZq612vREd8ihT1EkRrq
X-Proofpoint-ORIG-GUID: KBjjd7qMdtXynZq612vREd8ihT1EkRrq

In gve_adminq_issue_cmd(), return -EINVAL instead of 0 when an unknown
admin queue command opcode is encountered.

This prevents the function from silently succeeding on invalid input
and prevents undefined behavior by ensuring the function fails gracefully
when an unrecognized opcode is provided.

These changes improve error handling.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index e93e564f3e65..a7b21cea27da 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -564,6 +564,7 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 		break;
 	default:
 		dev_err(&priv->pdev->dev, "unknown AQ command opcode %d\n", opcode);
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.47.1


