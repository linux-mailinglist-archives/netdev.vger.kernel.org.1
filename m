Return-Path: <netdev+bounces-89409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D258AA3B5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48580B29D56
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90776190663;
	Thu, 18 Apr 2024 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rxid7FNi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D8190666
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713470129; cv=none; b=OyZstC28FZtJOXhNPz0A1Vl/2TGt2n1R8w3bXIpIef+qJQ5bmBKrqSZ/+mJXrrMNdrqCU5ZCw/fHDEA/7Q7gdCJFah1DbC3UZwTB1HuilwwIvun/nMRUsXshzZUH/61Set0PhGdJN4Wi3SAq0rAHiK2Hu3dLa+1p+eSXuCdyiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713470129; c=relaxed/simple;
	bh=6Jed1iakAXXsth42lGvwAx9ls2euaKF3OHYjTnog2gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pG7VgEoqtjJWDiyWw7yq2Jpx1f7IzeQ2LrF6VgxT6iFcrZCNDypkan/sqiaz89c6ro2CG6sNCNMAtBb23rCa57y1Jovw0WTefcbSxoetcQljJdvn4ulc0GwYWKhKmXjmOGGVDPD2BmNvbcpQ+Tgcaj/NtVITdBJpa3oOwe30pLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rxid7FNi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43IJRUa2027582;
	Thu, 18 Apr 2024 19:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=evWdKgom3m5/+HH7e1Y7V3TBRpLbj0pZXApxX7foLvg=;
 b=Rxid7FNisdDtysuwa3B12BmNL2sXt1O0WCucD785nXMB0ruUChHpro9YP1Pu3A9a6atR
 FdetlRnWIbZkyGk3Tud5Q4L7TXCGBeyT6oblo31qNqYUM9M3jdwy+vIRHk5QHGiXNUYh
 zNU+voCHEevqnr4/yRhg6aQW7tWhiDc4oMLbWD0t3ocKrei36U1asFKPc7aXRXg+ncuR
 0dd+obBiVmc3njaLplBNL6cWzhCpzvryQfl0sGNOVq24dU3KzPVCS9G8e96j9adntnQ7
 Uw9ZylqjLczRVU4GklpxE3eqaL+HeWAiqEyb+/e0D92vxaMagi9tHPI/KxrQT8bADebD Yw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xk9phg2gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 19:55:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43IHkIV1027281;
	Thu, 18 Apr 2024 19:55:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4s0cvyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 19:55:23 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43IJtKnS18088694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 19:55:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71B6D58060;
	Thu, 18 Apr 2024 19:55:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D796F5805D;
	Thu, 18 Apr 2024 19:55:19 +0000 (GMT)
Received: from ltc19u30.ibm.com (unknown [9.114.224.51])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Apr 2024 19:55:19 +0000 (GMT)
From: David Christensen <drc@linux.ibm.com>
To: dougmill@linux.ibm.com, davem@davemloft.net
Cc: pradeeps@linux.ibm.com, netdev@vger.kernel.org,
        David Christensen <drc@linux.ibm.com>
Subject: [PATCH net] MAINTAINERS: eth: mark IBM eHEA as an Orphan
Date: Thu, 18 Apr 2024 15:55:17 -0400
Message-Id: <20240418195517.528577-1-drc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GP7UwXjpA049sD-GLgOj8M445uDCzOpl
X-Proofpoint-ORIG-GUID: GP7UwXjpA049sD-GLgOj8M445uDCzOpl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 mlxlogscore=706 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180144

Current maintainer Douglas Miller has left IBM and no replacement has
been assigned for the driver. The eHEA hardware was last used on
IBM POWER7 systems, the last of which reached end-of-support at the
end of 2020.

Signed-off-by: David Christensen <drc@linux.ibm.com>
Reviewed-by: Pradeep Satyanarayana <pradeeps@linux.ibm.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5b89687680b..bcbbc240e51d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7831,9 +7831,8 @@ W:	http://aeschi.ch.eu.org/efs/
 F:	fs/efs/
 
 EHEA (IBM pSeries eHEA 10Gb ethernet adapter) DRIVER
-M:	Douglas Miller <dougmill@linux.ibm.com>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ethernet/ibm/ehea/
 
 ELM327 CAN NETWORK DRIVER
-- 
2.39.3


