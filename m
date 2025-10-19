Return-Path: <netdev+bounces-230748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F555BEE9B6
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E877189B552
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B635726B761;
	Sun, 19 Oct 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DlL3/XRt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22C4964F
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760890667; cv=none; b=OOgWuJUdKdh0FWB6ClT33/R7lTgEXeSSp9tTPU1qukANgHiF0ieOybjwOa+JposaDSB7fIgRwdGEyShplRGqJUR7BxHvOvUfvzvyejMw0kUN6XR9uZ7NYBl4aPFnBtU2Rwz++LZfm9mjqhxaiptEid3sKfAkEFo60uD8DEtzejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760890667; c=relaxed/simple;
	bh=vqXb80mOFAjPoe3h2l/igwhqT43nocCzsWtKUywquJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTgo4Ijag66HHJ2W/ZCT4RT+PM8UTYTyhSW1p4jmkIl1hrX/wSufCX2S0k4AnivFKBU7b7g747PyZ2TgPfvFpoz392KAlaeBHUiVcDOtg0tzXUREFpHYDECt/J0ClUHxV/UhIGoDJGprRTJMSkxvZ+XS/PmUGosoCURMKmzKsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DlL3/XRt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JBH6AL020815;
	Sun, 19 Oct 2025 16:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/Yy3hMpT5NgnQi27t/+XNoOdUuFEN
	JEKglgNvRF+wdQ=; b=DlL3/XRtxvo0xW1A23ci1Qhg4ARibRhJq42A6qYg9z2M6
	kosFXwrX2khKiRmPUKrMhNswhZZfkUPlSBd4gFUNiaWA4ZH+EgrQ1LHYuAdXlEr2
	jky0bWfNNnaVxX4vEtV18yXLjYvREr4HCbeA8wDu6fYf61xqhf4rDKtZGM1pARQq
	0/E6OPVzbfrsGS0RkU2hscv8D7kYWmViFaIQ1SIuRAf8VMVhIw8GV+oRhVS/zsLO
	Z82rUT68O55H48MawhmxQ1lgGiPKqK/8VLGqUYZikUn+ytJgMA8Tm9Kx35opM9yE
	i4fIKmRw24glS+pf/uh8/UpbLJjHGabhC77xcbeXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v30713me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Oct 2025 16:17:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59JF0BN0013649;
	Sun, 19 Oct 2025 16:17:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1b9ye5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Oct 2025 16:17:37 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59JGHaeT005168;
	Sun, 19 Oct 2025 16:17:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1b9ye56-1;
	Sun, 19 Oct 2025 16:17:36 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jiri@resnulli.us, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com
Subject: [PATCH net-next] devlink: region: correct port region lookup to use port_ops
Date: Sun, 19 Oct 2025 09:17:27 -0700
Message-ID: <20251019161731.1553423-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=871 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510190117
X-Proofpoint-ORIG-GUID: aqHc3ywiqsIyzhwT2jPu0rHKD_YSmaqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXzWsdHM0svVCf
 6b2+mbLqqR//FXWPQ/t0S+URvsDaraL6xOcQBPrLCs7UeNGD+BIVCincbtc6Z35YSZV+eoi/Ty0
 OMoFaRbjD0xwr//9iwlNBais8hCJjndLaeaEZMDhsr+yAMouSpVu/WmADwOVSyrhnfJUM8Dnr5t
 RnW56JGLrfOswc8PnbNGgJGiedUReoakTZxeQJlCVzIbRDbGsyyHXXi0N6+VuEypLJHkQo3WFk6
 J6kxu+pcib25anJX+6ACdwHLwYGkKS+ERxN1CBJWpUsy/W64GnLEG5Q27VNJHs5Sgn09JzoQvnd
 rU7XXJCR8CMvpD2XeWUHKpRjOLsWv7+3JbF2JsRYOlBN5zeyslg5rChTNEMI3ZG6PHSFCYX9ETH
 O2FLzqEJ8M1An4zWHwEdvkoY82ADTA==
X-Proofpoint-GUID: aqHc3ywiqsIyzhwT2jPu0rHKD_YSmaqe
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f50f21 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UfRTzp-lEnWZV1Yto5EA:9

The function devlink_port_region_get_by_name() incorrectly uses
region->ops->name to compare the region name. as it is not any critical
imapce as ops and port_pos define as union for devlink_region but as per
code logica it should refer port_ops here.

no functional impact as ops and port_ops are part of same union.

Update it to use region->port_ops->name to properly reference
the name of the devlink port region.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/devlink/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/region.c b/net/devlink/region.c
index 63fb297f6d67..d6e5805cf3a0 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -50,7 +50,7 @@ devlink_port_region_get_by_name(struct devlink_port *port,
 	struct devlink_region *region;
 
 	list_for_each_entry(region, &port->region_list, list)
-		if (!strcmp(region->ops->name, region_name))
+		if (!strcmp(region->port_ops->name, region_name))
 			return region;
 
 	return NULL;
-- 
2.50.1


