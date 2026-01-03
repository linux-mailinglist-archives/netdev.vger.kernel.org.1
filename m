Return-Path: <netdev+bounces-246676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3626CF0397
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99E8E3009F65
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11BB30C348;
	Sat,  3 Jan 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pIb2pUyv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D030C61B
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767462250; cv=none; b=T7KPhow540h+cxBdOJzvy2uu1kMvLCg0ZRLygJ4JM3yTL/8nuVAmEOqhdrgJ2g5gIru7C0EZhiY7nVLKCy9B1SSSrHe2I3cclpZqhJ3kEi3Nu1XzCe/cITa3mC0JFOopT9mSuXeDC948L90Gasbdbv9t/Z4E0uZuc9nnQnxM0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767462250; c=relaxed/simple;
	bh=be35GgswJwV8SOw4Y2fD49I2EG/TfB+Zp/Jt3RV0Vi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipEKN508NoCLWGy5MQ7WljWxHsdFX/RoQQyIs8gqppaUnBLQMlH0TsEXPxVRp0GjcJQqbEBllzNT4oueVQf9mfqoV8fAeVym+vRVPpuY0zxh9vK3/H3H2MiIIs5E//LKAbUTuTNR7zFdHE0+Aka/GKvwY3F4KnMjdQe2DuUsnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pIb2pUyv; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 603HcXpR1335620;
	Sat, 3 Jan 2026 17:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=wQcqmZxBj2+k1yqOZF/ojDjDGTvxE
	0qqbdHJWL98JlI=; b=pIb2pUyvBcMt7E9tRSTCkZZuqAYxWfE/Dz4+ETw6F9L21
	wd5c60d6HaSJhQxZaD3SlW8Ggo1RoBnFPQFN/MrGyM809+tG4avcrYcjVsovG+Qc
	3wPP4AfR5Z2MQznQdFIs2K3fluRTLwgERRyoJNC/e+TQpFm56q4RTLFNLELLCLMA
	vMtiUBmerwyCOUZnj1pApUGrfz+iCtryy+6L1HGUp8+i289JfRi6L2UHCUDYox3u
	oT1ti3F5jGgq0jN87uxeJiuZWokj9ZswtyAuiwetKM2Qn6yRo5DCoxNoHBG77Jqr
	yy7rneTPStjk7enHUf+c+MBcn+HWaU5mVu3MWEXaw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev1t88h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 17:43:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 603D0POc030681;
	Sat, 3 Jan 2026 17:43:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besja4j34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 17:43:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 603HhiLv006488;
	Sat, 3 Jan 2026 17:43:44 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4besja4j2s-1;
	Sat, 03 Jan 2026 17:43:44 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: vadym.kochan@plvision.eu, oleksandr.mazur@plvision.eu,
        andrew+netdev@lunn.ch, taras.chornyi@plvision.eu, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: marvell: prestera: correct return type of prestera_ldr_wait_buf()
Date: Sat,  3 Jan 2026 09:43:10 -0800
Message-ID: <20260103174313.1172197-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-01-03_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601030161
X-Proofpoint-ORIG-GUID: sOObde_9f8vLWNCRcjx4QUDAGYzhcK2y
X-Authority-Analysis: v=2.4 cv=CKknnBrD c=1 sm=1 tr=0 ts=69595552 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=fkL2CWc80PhRqSun8S4A:9 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDE2MSBTYWx0ZWRfX3kuFVLANWXJn
 xfNwGahM9ptVGSmT991jWTJXimaKv6+RIyRN2L5+uwU0pvOAavBaN1jwIIgbSQ2IG+Pkmx36zY8
 eRwvTjj4MMI3LaTB1uDT1aKnoGzuI+3vOojt+ZCbAlrUhsmoKh1Q5x0TItC5ItAk6qU5sgivUSU
 kutrFUse+CtzRZVZ6jETKml1GW+4aiJBpwFHQo6ymubUfpt9yn2ocnImEsObVCrooDO8vAH8KnA
 GkTz5oYd9IMVOd74+XNaFka/pe7UosaFJ9Gcvxu0aVoDB+e1qE0SUPybAheUDEWQ05Kf+ZSks3r
 N1wx/kCVhI4c/MARZvkhFbAs/t8pXSKSthzpWrdYUhUqgxt9/W8uQFzjEtoJCBeJIVXbjkP9Fcv
 NPHpmqdmvLwQik2U80JPoViMex/wioUM1CWQkgpSymSPp3TSzfMTAjYGYSlwQNN2a4nuJLlcqIk
 hjCA8mguD6w5u94VC/GdbpLdIRA2cKYHRfyWyqSs=
X-Proofpoint-GUID: sOObde_9f8vLWNCRcjx4QUDAGYzhcK2y

prestera_ldr_wait_buf() returns the result of readl_poll_timeout(),
which is 0 on success or -ETIMEDOUT on failure. Its current return
type is u32.

Assigning this u32 value to an int variable works today because the
bit pattern of (u32)-ETIMEDOUT (0xffffff92) is correctly interpreted
as -ETIMEDOUT when stored in an int. However, keeping the function
return type as u32 is misleading and fragile.

Change the return type to int to reflect the actual semantic of
returning negative error codes and to avoid potential issues with
unsigned casts. There is no functional change.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index 3e13322470da..2989a77e3b42 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -542,7 +542,7 @@ static int prestera_ldr_wait_reg32(struct prestera_fw *fw,
 				  10 * USEC_PER_MSEC, waitms * USEC_PER_MSEC);
 }
 
-static u32 prestera_ldr_wait_buf(struct prestera_fw *fw, size_t len)
+static int prestera_ldr_wait_buf(struct prestera_fw *fw, size_t len)
 {
 	u8 __iomem *addr = PRESTERA_LDR_REG_ADDR(fw, PRESTERA_LDR_BUF_RD_REG);
 	u32 buf_len = fw->ldr_buf_len;
-- 
2.50.1


