Return-Path: <netdev+bounces-191548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D9ABC062
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043013ABB4C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496FB281351;
	Mon, 19 May 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JsOL34wN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3FD26AA88;
	Mon, 19 May 2025 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664272; cv=none; b=IpL/PJJsrhOWQ0f2FWOtEg3fts7jejjiwfLhZPH/7qVedRLthnhK1gMOcQ1HdTmGWNwitwvMay4dknrROdustO8sakqQ8kCHM69C7XzQYxsKi2mWomzKhV44AEmdFYcQBTwFec2UCbdL1e8ZVkbsMzwXDH2GesGYOrGFgXrWf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664272; c=relaxed/simple;
	bh=F9YUAtGxzRKzqxiaEcNL9j1uUwgXa9TGLGYUo1DfYzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvnWSWZVjUVM7tar8K5c/EydUfM+zbZKcFMs1iOQDAgkikPu3km+OxFAsFH3ooSgV6JAoDgFShyVgcdIXzIgK8K66pDH3vw45A89OizAgtrUk44kvwDTYKA6Hb1zsiZAlzJ6r6bBPBjTszBWM/PxUyYtahcfNHdRmK/4388oe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JsOL34wN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ikge019882;
	Mon, 19 May 2025 14:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=jfAvfmaP4Vog/zDqvYg6fB4Jhk0Eh
	rxYNvfTR89+Dec=; b=JsOL34wNPM9qjS2RAT3p9bjofTFk3/rMBw7Md+QhgP+Yh
	PuIK66fviQuGMUSZ/eTd42L62Dz7fqtpaPs2ud0iebd0b7j07Pmba/i3hm/3N4dN
	kljAmoLKnlCgddXfLgpi3h9cLedd5opa/0lu4va8eqYv8OQUWHXV0pbk+DU/3HrZ
	/xS1sEbZsSN45aOaw0tT01sENqDWVc9Kj1tKpNXR2+dpfuMWVIL2qwBn8B31SigH
	92IEksgGG2GOyW5X/tPEtAxV5M1lCRMKrOTH65vkb8JPmETa+2Y6fNbF9WBsLbpr
	/Y1qVohKD0evPFYkkh5aQA8NCyQiJ6pIfW+zu5qvQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46phcdu5jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 14:17:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDjmJx037137;
	Mon, 19 May 2025 14:17:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7ggwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 14:17:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54JEHZuM017600;
	Mon, 19 May 2025 14:17:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46pgw7ggv1-1;
	Mon, 19 May 2025 14:17:34 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] emulex/benet: correct command version selection in be_cmd_get_stats()
Date: Mon, 19 May 2025 07:17:19 -0700
Message-ID: <20250519141731.691136-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190132
X-Authority-Analysis: v=2.4 cv=a6gw9VSF c=1 sm=1 tr=0 ts=682b3d81 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=5cChKmV2vpbr6EMTWcEA:9 cc=ntf awl=host:13186
X-Proofpoint-GUID: QcRoVyzC2eeXFONFrJN4_1mMTrC8SgHw
X-Proofpoint-ORIG-GUID: QcRoVyzC2eeXFONFrJN4_1mMTrC8SgHw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMiBTYWx0ZWRfX49YumU+mtCMS j2KxLvBJtRU4z09XDGX7/c6lo9qEgA6EeZa+CVjeiHhthg2WkPZBQ7fOXdJlQ3/SDseBQjxcsBK uTrAxAdNpDDmilsdRdDHxtxfcIz1GULC5jB0kpnFhAP8NAOkTvL94MpygruA0/TjUd40318FtnQ
 PR6oCUdzATm/sA7NpslHASeWS0awBkQlNNXN3Flg0AJOjUrbPfEIojzzGu4KAnDkAbsSiGYBiZV BnNLaMIVZovT17qkik1EEgfxjbl/it0z1qXXFkK7TGSoyIbOt6sxdi9V4yxlJf5UdUYNYQqEZNC YT7BZno6VrW7WTGCyk92/9uaRGck51Z8d7VKmvVRhl6IzXjLMH5fPFXQ1GF1njp9IPp/K7YEGwm
 QRUSVIE/+bDLm4ZmBBggJ8wHmz8EnR+PpvuVM/sHFOECaBqkhH/o84/sVkKvL5NAQWDxuQoQ

Logic here always sets hdr->version to 2 if it is not a BE3 or Lancer chip,
even if it is BE2. Use 'else if' to prevent multiple assignments, setting
version 0 for BE2, version 1 for BE3 and Lancer, and version 2 for others.
Fixes potential incorrect version setting when BE2_chip and
BE3_chip/lancer_chip checks could both be true.

Fixes: 61000861e860 ("be2net: Call version 2 of GET_STATS ioctl for Skyhawk-R")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 51b8377edd1d..a89aa4ac0a06 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -1609,7 +1609,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	/* version 1 of the cmd is not supported only by BE2 */
 	if (BE2_chip(adapter))
 		hdr->version = 0;
-	if (BE3_chip(adapter) || lancer_chip(adapter))
+	else if (BE3_chip(adapter) || lancer_chip(adapter))
 		hdr->version = 1;
 	else
 		hdr->version = 2;
-- 
2.47.1


