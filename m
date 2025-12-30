Return-Path: <netdev+bounces-246292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F865CE8B5E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 06:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06332300AB09
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 05:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8522135B8;
	Tue, 30 Dec 2025 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A/7v5iqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D1946C
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072137; cv=none; b=ju49GfmOP4UUJH+em9rDEFbJSNXD+UoOpVx3nCHBjDYFV+VceuYU2TAD1kqVPD/XevakLM8Yz2O7Ys/doEa9ieu0zS+3+O5llVnA0fEvEWc40S+lKTJ4NQ33gDrE/dS+5Z5moyuTbwnH8axs6ojR/wNe9Mil57ReXXWhwwjhE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072137; c=relaxed/simple;
	bh=hPu57gdygFd0tvKstrt0sJ1H2b0cBnD8S+gD+2uYQpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjCZF62TVJ6lSQ9T615A7N8Q5RuOvywor+rB3E/zf3nQvvsLGCk0+fN2VelM6l3eGT1nOu1PY8flBOh8i8JW4NP5Lgbm9dGwvx8M6uXWhpEhr2D7bGlYaSHKRZ2oigodDfaN9UgvIN0G9Q7FUEVeHlJiDu5ZhjYIAVi0EkD5j14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A/7v5iqJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU4Nf4F3214023;
	Tue, 30 Dec 2025 05:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=RuAtZ7IYG5tpySzHe/HYeMEmSHt9R
	sFp4qguBBuHucc=; b=A/7v5iqJKT5Ds0zgFJvyfbLQwDKES8Dxr1Y3Fv0a/TY2j
	A+9YQJtNGX6qLrvjxwzAklD6d+0+ED05kvnzw4y8uv0DYs19tdU0eGjfUr+yWIjf
	MRfzgigGkr3cr8mStj2zeHSsigP9JvS3uiQa1h2KZY056raQZTrzk179n6YROeIi
	l2SSc7GarkMK/D1wrNvyL0wNb5cGaYEQEAUmBNNz9UOUV2ow50XI5W6SmBgtq29k
	sZr9YQxXxL6+j3hjEzbSMAOWKEHcXCzFhWAY9/NkMOIJkYF02hb41c4f8VdfVzR7
	QUsmfX89xZ8BvpoMRRlflneZsxyQgAVzQXivwDExw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba80pt5mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 05:21:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU3NEhS038909;
	Tue, 30 Dec 2025 05:21:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w7k4ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 05:21:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BU5Ls9m023710;
	Tue, 30 Dec 2025 05:21:54 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w7k4n7-1;
	Tue, 30 Dec 2025 05:21:54 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: vadym.kochan@plvision.eu, andrew+netdev@lunn.ch, taras.chornyi@plvision.eu,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net] net: marvell: prestera: fix NULL dereference on devlink_alloc() failure
Date: Mon, 29 Dec 2025 21:21:18 -0800
Message-ID: <20251230052124.897012-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512300046
X-Proofpoint-ORIG-GUID: dwkjSpHMMYediH3Qh1vUjlS8_F0SrFaM
X-Proofpoint-GUID: dwkjSpHMMYediH3Qh1vUjlS8_F0SrFaM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA0NyBTYWx0ZWRfX26MUhqsmS6Pz
 516kI0FxmidmxUV2+WhovkPbj7fHe9HUx3eQ7W7A3zDBd2vfWedemAtckrfmoBN42Mv6Gp1hcEf
 WSpwtoxMh3lMIEUlYKcOOjq6l1o0HOhPn4LLqM6q4xKfljeBcfYaQJRVnpIL6uHP23dCrWqnQ6i
 hHxctvFisxvRJSqp0VONF0yyA2OLZCWGQwWJE3eFqal9HHWrV46mkNNigKzyXzufUXLlsJMoAcc
 xJDgSYG9J9JScjMIHgM6XB6mxd4yVq6oT072DT++rTDP2wUm3RcHzCC9eiTu63kSjBt+fTUQRBi
 dvb+oVn9VxHY+dRV8t7cb5Kg7HnXNeG7YkcceWT2lzYgK00KFkCBap8SOG4qlPTRv/kbGJu2HMh
 gUarp+l8qb0BVnvW+fcYHlPtB5PUm/u8QaIVJS46FCHsj7feCfCvswopnPocn0nv1ADe23J3NsS
 c8o8ro8Vpk+i+tvQUJw==
X-Authority-Analysis: v=2.4 cv=RY2dyltv c=1 sm=1 tr=0 ts=69536174 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=13ARFvAsurhowUsGTS4A:9

devlink_alloc() may return NULL on allocation failure, but
prestera_devlink_alloc() unconditionally calls devlink_priv() on
the returned pointer.

This leads to a NULL pointer dereference if devlink allocation fails.
Add a check for a NULL devlink pointer and return NULL early to avoid
the crash.

Fixes: 34dd1710f5a3 ("net: marvell: prestera: Add basic devlink support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
index 2a4c9df4eb79..e63d95c1842f 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
@@ -387,6 +387,8 @@ struct prestera_switch *prestera_devlink_alloc(struct prestera_device *dev)
 
 	dl = devlink_alloc(&prestera_dl_ops, sizeof(struct prestera_switch),
 			   dev->dev);
+	if (!dl)
+		return NULL;
 
 	return devlink_priv(dl);
 }
-- 
2.50.1


