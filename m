Return-Path: <netdev+bounces-218572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FDBB3D4CD
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 21:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE2E3BC6FA
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22286223707;
	Sun, 31 Aug 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W6I5EgF6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47C21CC51
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667025; cv=none; b=sw8YIEhjI4VT/YOW9wMKScWecKFpwjbdxgKJHBjFgUZ9EHPEFuZbQlBQxEEc8t70qO5rIoiwnqpUxJXXFnuLc+nicMf7ll4BwvjDOWpChtfXTKznNgtnc2cWPKOQFrdP7DGMB5PCtZT6bgjgqOMnNwqZ7f7OuPZvJWKzq/Nc6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667025; c=relaxed/simple;
	bh=/bprT3ZJPfqFkvJLb5ZCTjFC0zQk1dxq+a8rqM+yspc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gu8lhQEMAg60fTXsuE32v9PvChIWlHs285voTC4O6erVv0zg8QvjFjedpQy9Nb+uT9usgZGDtXU/7WmcpOiUjEE0hir5j+GAMP3eTiHAnEk2pjw8s0wdUrcRHUVvQRgUTBwZz/UfRqeRmqm7iig9PSp5j0+K6Dxao5exRwLgqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W6I5EgF6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VIMHwZ000877;
	Sun, 31 Aug 2025 19:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=cvh5ye7IwuufqJITe0zGF6/f7Yraj
	2GtQXSPMK2RV0w=; b=W6I5EgF6m5r8WR9SRhdL6Ioy9MRU2iAcJb03k1HF1+b7j
	ME7VaW0MsY64KYqYmB239lcwYLKr2AB9ZI/j1KwmVttqLPWFfn6NMOuBXW24SSRC
	bc/imYEYXP5M3lqWrUzMNnGd5dalemQZYfydKEIkHbH8fn50Y9qjguBbk+765SOC
	kBq/N+etkkP2ggRsp7TpwEVNTZNvxLnqYwUe8Pl5y3eI1hSo0s/fJYK/LESgcUPd
	C+/FLoT7cDlyox4zsH0Nzz6BnZzHaVHE3PlQJ4Dy6C6bTQLg+Q08joKL8E0tFyKv
	yYN0ewUI/LCihUk+cBMD7bsb8qTTK0UbEjymnNV2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvs8gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 19:03:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57VHN5v7004189;
	Sun, 31 Aug 2025 19:03:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr7eqy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 19:03:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57VJ0TTk037252;
	Sun, 31 Aug 2025 19:03:21 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqr7eqxu-1;
	Sun, 31 Aug 2025 19:03:21 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jiri@nvidia.com, stanislaw.gruszka@linux.intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] genetlink: fix genl_bind() invoking bind() after -EPERM
Date: Sun, 31 Aug 2025 12:03:13 -0700
Message-ID: <20250831190315.1280502-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-08-31_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508310200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX3MgPJItI1TTJ
 6Q5HohfMFyLSxnE2BLMeFfD8q4I9LZBVbNcTmUvFFSvKQloBJHNwnizMzqnaya6tAMVxng2zHG8
 6I8dIlpiYHRoLQEWbkZ2ZjSg4bTm3xsJGGM3muWhhJDrdI2zQFBBv3wLg8WExuH0tWJ8r5KQViA
 vD1i7aIFo9X0Pbt3iZcEOJeNfvrefrVFwwqQworD9ZN8LC6NqXw7r45MwL9ZPdIdS+qpC+ids82
 jom055HhEfuIYdo9jQSvkOodWoBAKP1PBXLiTklRJIcummZwTr4idJl24XAvZYZpcbUBI2cyLYx
 rMeIA9gDoXrXBTIjnrb7/X+Q2M9kEMK/CfrFDKQxLjOaokiYaKZcG+HOYGSIi32YFAchD39i68R
 IJeCjeoh
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b49c7b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=IQN_B5fLJMZ4uxNOhSQA:9
X-Proofpoint-ORIG-GUID: HXjN6zLJaJo-4Mo6Gf_CNJUPmFynhkLJ
X-Proofpoint-GUID: HXjN6zLJaJo-4Mo6Gf_CNJUPmFynhkLJ

Per family bind/unbind callbacks were introduced to allow families
to track multicast group consumer presence, e.g. to start or stop
producing events depending on listeners.

However, in genl_bind() the bind() callback was invoked even if
capability checks failed and ret was set to -EPERM. This means that
callbacks could run on behalf of unauthorized callers while the
syscall still returned failure to user space.

Fix this by only invoking bind() if (!ret && family->bind)
i.e. after permission checks have succeeded.

Fixes: 3de21a8990d3 ("genetlink: Add per family bind/unbind callbacks")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/netlink/genetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 104732d34543..3b51fbd068ac 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1836,7 +1836,7 @@ static int genl_bind(struct net *net, int group)
 		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
 			ret = -EPERM;
 
-		if (family->bind)
+		if (!ret && family->bind)
 			family->bind(i);
 
 		break;
-- 
2.50.1


