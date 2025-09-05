Return-Path: <netdev+bounces-220413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A7B45F4C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931F217C98E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4AB30215C;
	Fri,  5 Sep 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V4DPpxg/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03013D521
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091025; cv=none; b=W7wGmoTjsNyEn+vjPsiqztXogT+v0sjkrXor4+IqHCtgteC6eFTRfNgdcDdzS3Kk25l3yKy/pnicSKCw5m8FhAgFBI7rpM0mtovJJrBGnsLqy23ItCc14U0fHePpSvJbdqM0L6AMRAAckXq7LucUfjIfGQZDE5mGTi7/wdCkyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091025; c=relaxed/simple;
	bh=N/XLEdd/36E3VKQJRAy10+TqEjA2D9OndM8M1TSa0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XRESoN17fqEs+rZUGHmUbTE9dMNq5GveNdJ6tEA+qXB6gAuFYtRDWc4SXR/ua55QumbAAX1Ot13a7Lzy8yDA/Wp5wQmJZgOcJveSOJ2O2eVmxQr6XBK1Ox6e9OKqa5W5L4NfGMxMMOmw6dVlr5yELvb18K/g2DSrhbBC/eL6X7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V4DPpxg/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585Ge1ZH029531;
	Fri, 5 Sep 2025 16:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=4IrDvN+ljaS/y0Gt
	YP7KIqU40F2jJ0z+JgehSEHudXM=; b=V4DPpxg/umw+KGfaIUVvh4SVKi/7dpxB
	I+GsRE5CjZdD7+3WQzfXHyrcrLVkryvFQrTf9WnAiCEf3cfj5vZa5LcUHjh4SaLS
	8+yP9iVI8e4BstPjR+Q65TrDGXvV1qJuQYnVyJ3TLFY0vA+bQl2PY7B9UzvAX+sk
	Z3jqTKj+sfR/8+0NsNwDtJi8uKGyp75FCjsB5JTrIegU+7UcD/mPIwsfiSIODrvw
	uakvEznJrGhd3/tCTx+bt3rrfXw9HYXefvTgQiXaE7zVsAPH41wB+UNjM72uXAv4
	Bv2LkdWOA++E/fDdgWXoNt345aB+KT3FRk02iQkHbbxrBqjJRWNiHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4903jv80r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 16:50:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585FNdKX031701;
	Fri, 5 Sep 2025 16:50:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrkffbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 16:50:11 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585GoAZY037082;
	Fri, 5 Sep 2025 16:50:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48uqrkff8s-1;
	Fri, 05 Sep 2025 16:50:10 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: mctp: fix typo in comment
Date: Fri,  5 Sep 2025 09:50:03 -0700
Message-ID: <20250905165006.3032472-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050165
X-Proofpoint-ORIG-GUID: UsT-iRN2mqTk0VDigQg0yGr2nUSnpI32
X-Authority-Analysis: v=2.4 cv=b8Ky4sGx c=1 sm=1 tr=0 ts=68bb14c3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=PjRIAmLr7RPfk1QMv50A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: UsT-iRN2mqTk0VDigQg0yGr2nUSnpI32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE2NCBTYWx0ZWRfX60sxtem0RrRm
 Rflh6s9AgfW7ds+mTpCwCTZTiTYmvZ6hDCNw8fXzE2yv7T63jiT880PBniDjQWTqAA7SJkaU/78
 GyIsn+KH+aMRVFZKebZriLEYKYSfXAzoruJczj5V5xlLqg/ceB4IOmeaUTNZMwc5vmjFd9XPyJy
 2DpnNjq56DX9nmLhpX+WN2pfFDWWoLz6FdovbpFcYYqo16BDb6BjpUUL6xVfqnqMeN7NgZvZwgA
 EDeaDQasWPRNCJiJ50QCDngvRbLcxO25FzYdtz5yZ39FgCLfzl06VLXzugSF7xwyNjtULDhob/x
 FGyrwj3DOkxLZ7CjQiEcqakwmW9Z4oL0otNt85eix24R/N7u7ODqelkw8NU6Tl4b2qjZjlqAW0g
 X+YfJYZw7m5MRMME+lZn4AH2EbS3dg==

Correct a typo in af_mctp.c: "fist" -> "first".

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/mctp/af_mctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 685524800d70..b99ba14f39d2 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -256,7 +256,7 @@ static int mctp_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 	skb_reserve(skb, hlen);
 
-	/* set type as fist byte in payload */
+	/* set type as first byte in payload */
 	*(u8 *)skb_put(skb, 1) = addr->smctp_type;
 
 	rc = memcpy_from_msg((void *)skb_put(skb, len), msg, len);
-- 
2.50.1


