Return-Path: <netdev+bounces-219686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0654B42A5E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919B31C21975
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FD36809B;
	Wed,  3 Sep 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TCoyCcCM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC32E7BD5
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929452; cv=none; b=VV+Udp+YthCha4SKJapwQHqpYmR4C8JkZrPTPPf9oaooGmTa8dGxVVZIz8KFdWxmSMkt4u1PKeM0Pu5WLooBQJnvTtcS117vCZxPwLf3PRQ/lmiAsaB2kWa2Y2bRk8JKqZrLparhxaWkhnPPoEJaZ8SCO8k8YNt26OM7YyWBj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929452; c=relaxed/simple;
	bh=0ahPQGhQAf60bWli36foxHSvw7w2+VrbSMDPmDu/EDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePVl9zzGNxrFI82LXXrr8/u2g21S9NhnEigH5hi1MGSb0o8wILK1cV8WEuf3GlHJfrGyNgfZpss2ePNrnigmJx1wFiX7Az+IujaQlYiRpGZ3oOMjliW/gLQPa6krGLc5KIDcYtZ9i70QT3tUc5Y2PgAdxpqIxPT88aUNOO4msgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TCoyCcCM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583JtsKi007977;
	Wed, 3 Sep 2025 19:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=PW4pmp77Y4+qB7Y0dJ3aWMxa5+YBZ
	ylyIab5ytikYKk=; b=TCoyCcCMPicpgaQiFYKTjiFCwXYQOIIaDs9ls5GsJyxRj
	JVm1ifH60FJxiqeFXTryGARdNLxsCxFwRYCL+suKsgKv3z1D2GwUfSRMfQ1VqRMj
	tcR5BnQun548SHqBCJfB+1TBXlTWoPRsm9CG/1UzDtG1AwdIWSgoCyoZ4TlWxjge
	aNyhsG5iMUInGigjanNSz45e+9TKNLG3goxzDmUiElalVs6bgE9KW/DnG7HKAZRJ
	xUhzyMwpFe/Zdc5UvJVqI+C1qxJRLABKA7xPt+BmBL5AdEpGSaCFYPvs/TBADAJk
	UD7YMBRRmcJEYvtrA9BbOvk40+bvFHHxsicA4dA6A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xu5585ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 19:57:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583J1ss5032533;
	Wed, 3 Sep 2025 19:57:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrh2wtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 19:57:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 583JvKOI036811;
	Wed, 3 Sep 2025 19:57:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48uqrh2wsm-1;
	Wed, 03 Sep 2025 19:57:20 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] udp_tunnel: Fix typo using netdev_WARN instead of netdev_warn
Date: Wed,  3 Sep 2025 12:57:12 -0700
Message-ID: <20250903195717.2614214-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030200
X-Proofpoint-GUID: Dk62nRoGBVlEPdd8v75dmsEK1d_qVZJA
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=68b89da2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=3LOikb7nRXj5aQZQSjkA:9 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: Dk62nRoGBVlEPdd8v75dmsEK1d_qVZJA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE4OCBTYWx0ZWRfX3yUSHrji6sK5
 kszVwYanr2J5lGCmSiMS5oo7Rp//7YlrlmPOY/5DRZB7zptuzIyWUeTm71RQSW4woqgAUSdlg0H
 hhqfma4S3NORX7tVUhv8l46t//+aNZ7lToye+tJ6/vly5GyulPvx5kHUed+bOZO9w/yR1EQ1DXW
 d2Szq65idpwv1eMFLlwPFSl+aKHsgbrhzFu6YgTRprask5pou+FXSI28ryMTXkOmthRii+r9MPr
 7wZ4fHzxg0++ajhF5tWgew6c6pZqBQaFwyYdVriUUIKPrgS/Aai0eAbMbWukz4YghQVR97vcooB
 T+QXzh62W08IaO+Cd+Zhw46V2FdxSyG1HWtWetSyvbqY6cCiLALh5kprFDO6qiKGciFT8DNVEQO
 jF5gwYYS/x8BdaA4lUC3Pt9/yP8dgQ==

There is no condition being tested, so it should be netdev_warn,
not netdev_WARN. Using netdev_WARN here is a typo or misuse.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/ipv4/udp_tunnel_nic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index ff66db48453c..944b3cf25468 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -930,7 +930,7 @@ udp_tunnel_nic_netdevice_event(struct notifier_block *unused,
 
 		err = udp_tunnel_nic_register(dev);
 		if (err)
-			netdev_WARN(dev, "failed to register for UDP tunnel offloads: %d", err);
+			netdev_warn(dev, "failed to register for UDP tunnel offloads: %d", err);
 		return notifier_from_errno(err);
 	}
 	/* All other events will need the udp_tunnel_nic state */
-- 
2.50.1


