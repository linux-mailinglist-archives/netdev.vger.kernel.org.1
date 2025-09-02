Return-Path: <netdev+bounces-219091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9FCB3FC1C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C447AC7EF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E027FD6E;
	Tue,  2 Sep 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rfFirnyd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E727F18B
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808478; cv=none; b=NVnmcYMzbG8XiUxrwwl8AAbAz46lYR/tvl1ZAn+HZdAWkycsystzI3jIt3D5uoAqiGNKiD7D6Epy4pzSJRWYN3E8pscajEQnNXYc/17e4gYcGNs3j2lpsyWIp5ACZPYc/coO98k2iINjAShpH73Yx3HLKDI2cONE2ZKDWcWXPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808478; c=relaxed/simple;
	bh=mRBCaz6yQQ8y5HPzbOu+OApwDAC9z0YF7SCpqL8K2Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEcSy/JKfG3O5xnr8G5+xBrAQvYBem50wdX+V52hcYNzO5k18HAmsa9qaECV7YjCv+WXvRNKJhfK6njVmFOWMQQSFlCifybqlfrublpC4BDkoXsXADHz8XQZlrTeNcbVHOaUDu6x83hiZMU8itU6/8YvJLdSBp9KRARrK963qCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rfFirnyd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826gR9L019772;
	Tue, 2 Sep 2025 10:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=vO5sdeAA4eJb+SGG4GQFEgYWnn9b+
	By/pq5SaaA6s68=; b=rfFirnyd+AbDENKTc0m/YZ3xzrhzglqMe3c//ICIhoVXg
	lGFMlqgtdGBxWUv5GU0xtbDkCDMMWJe/HBHgcX3Y8cBGLjMy0ou+u7AsflWqx1YS
	AXfvlJpbbfq5quB6z7MQz9V3zhflsHS7oJn+VX6vvjZj3cZAMkKPNdpXHyRRCe7F
	1MBfiXjrAbtEhDM3+mWuKgTLVPzHNbbEaB51ep5r9t830hySuUNpyyPxjcNwCOqe
	MNOvzU4cVmzefWCFxdwLDN/8IDQKPKTnR4GJL0Zzus0JhxDGOcgsqQkO6xRb79l4
	DwTeV0GjigMZTmiDYnAnrNuXhPPzE5cSXYOgu4reg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4k63j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 10:21:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5829f82w036265;
	Tue, 2 Sep 2025 10:21:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8wsnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 10:21:02 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 582AL1sK040494;
	Tue, 2 Sep 2025 10:21:01 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqr8wsn6-1;
	Tue, 02 Sep 2025 10:21:01 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] mctp: return -ENOPROTOOPT for unknown getsockopt options
Date: Tue,  2 Sep 2025 03:20:55 -0700
Message-ID: <20250902102059.1370008-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020101
X-Proofpoint-ORIG-GUID: 4ezUKfYn7__DuqY4A6tqoJiHXr6fIQF8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX4ShUvrU3Qu0r
 oMmrUQBEARER/9UbLVlu6gj7b4xOUj6fAakgiV14QGWCLjuykmtyR4tnJObz+vHPi0n+SCy5DGH
 LzmMQdx3GpDL/DkrFvTO6HASMxlAlSMzRXkyj/XD4xyxPlPi4KMeXJJw0ArY0206/UIgFmgiTjj
 brV3jnpy443dQ0I0xcpI+2IsFxh9cRe5w+53dHnC49u3JI0TI3XWpU+9glBn897ufkbFm+d+TkL
 nKJnrtdpZb+0tw8aa5oncBbLZ0zJwqz57E8a2FGoSgpVvAgJstb4vHA+63ZzZnDsOJzoY1NjOvy
 eGJXjVVX+YLtaxIY7hUc93ibSPYlYJWUKsWWaRY8TOrP4UR3S4Q/RWeVytWY2LvPwRon9/KR3km
 XU/GMl1f
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b6c50e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=b78P2r09iYH4FrHxmTIA:9
X-Proofpoint-GUID: 4ezUKfYn7__DuqY4A6tqoJiHXr6fIQF8

In mctp_getsockopt(), unrecognized options currently return -EINVAL.
In contrast, mctp_setsockopt() returns -ENOPROTOOPT for unknown
options.

Update mctp_getsockopt() to also return -ENOPROTOOPT for unknown
options. This aligns the behavior of getsockopt() and setsockopt(),
and matches the standard kernel socket API convention for handling
unsupported options.

Fixes: 99ce45d5e7db ("mctp: Implement extended addressing")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/mctp/af_mctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index df4e8cf33899..685524800d70 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -425,7 +425,7 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 		return 0;
 	}
 
-	return -EINVAL;
+	return -ENOPROTOOPT;
 }
 
 /* helpers for reading/writing the tag ioc, handling compatibility across the
-- 
2.50.1


