Return-Path: <netdev+bounces-197044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA66AD76B2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728FD3A2751
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19AC29ACED;
	Thu, 12 Jun 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qc31L+oq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F929B227
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742688; cv=none; b=nOjwB0iNQgTdxlN/SQtmjvHA/Kup7L5PrIRRueVb/RjVR9i8L1da6xGGIqdqe9Wx+pMzuXK+xVw+zONEwYwVHpoe/q4ilVc0TeTPr7HHaorYx5obKSMV111TdqBWwbD9wW3bINrDC7fR/n8gnPAa8co8EwYoHSHCECUKqRLFehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742688; c=relaxed/simple;
	bh=ExOvME78VX0Mh0l0CrpxpRCxPJxxASddmtz+acIUKbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3Yavfm/gMaZ2srDqaoErfOhfNFQsF7XNvai3PBf08KQTgQnNT6S38SufAwbuhrxUuFtm+bMyGPb9UBlaUtIiKII+ZObh0ZzayFW/Mv6TBxxxos2CMHuQ518jglKA5O8SiudXvPfWL+tv3ZadOi1cPrtvufd+UlpxXgoCumTkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qc31L+oq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C9HPnk031658;
	Thu, 12 Jun 2025 15:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zb1Dc/+Jo0W8ONc2e6br6Wu5v3H+qenmh2LgyxwMN
	bU=; b=qc31L+oqaoGxcPRQ0kG1b0D7bWq5pyvD28mM04ujW1CXInNykdm/IZTHV
	hYeEdL+Hwm3GThYwFPxj1E0UzMPwI9aWDF6nZd+YQD9UmmPSUM1MviD4UULA9Ooc
	6X9B/a2Dy7i0lAbaUT4H4smP3/LIimBMYoDPXoporFCheetopHpL3H4Rf/bbWPL6
	FKhLeV/7JaFoWgCJazsEarWlKkI0RgTrqkEz7KkRpJBihF+9jQ9nRlce3UXvouEP
	6ypU+ZiCmbikwDIG1tjCcGc34pFMeK1bHVIs/Bju1pRe+EWBvplB1/IvvExqN9ya
	Q5HaNBaCXH7TwJgxziURfZWvBZysg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mgsuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 15:37:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CCJ03J019623;
	Thu, 12 Jun 2025 15:37:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4752f2n4u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 15:37:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CFbrdW28377770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 15:37:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E04F358055;
	Thu, 12 Jun 2025 15:37:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A786A58043;
	Thu, 12 Jun 2025 15:37:53 +0000 (GMT)
Received: from d.austin.ibm.com (unknown [9.41.102.181])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Jun 2025 15:37:53 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: netdev@vger.kernel.org, leitao@debian.org
Cc: kuba@kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH] Fixed typo in netdevsim documentation
Date: Thu, 12 Jun 2025 10:37:42 -0500
Message-ID: <20250612153742.11310-1-davemarq@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=684af453 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=djFlhJzBvflCo5wEEMgA:9
X-Proofpoint-GUID: VHVpWqQnMv4w9pDJ2ORRTCJJHbEuxdb1
X-Proofpoint-ORIG-GUID: VHVpWqQnMv4w9pDJ2ORRTCJJHbEuxdb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDExNyBTYWx0ZWRfXy/0cMjzI4EpX m11xpyD8WkKvID8zqQf+4rQaql7EVIvljt7JBcFXg9hSEHK76v49spesy9pWmerjnWdnT9goVXS w8z8knDhPeDs8P18Sp70UQYGJCwjt9P2PWT0ZJoqGSxMHRpfkVyH0CAAkQOGQX7LV1sp2VL8jf6
 qH7Q1za2WxG8BvyIltZ/o/aC4J9zb8b/kBihG5rBMIeDNxVFDqiyWwJIxG6E1juhAJg3Xd54PNS DrprgOcR7SwXrXx9GWbrs3S/RK/Ot7ttOErmckqb30AkpltMZZ0owEQoZF4mu5D54hZyu/N1ZfN j7KM5U+y0xmR79i9Itt+eXvcJ8F7e+2zISvH6Z/P0+wD6YDrC+w6tFyc3buG/AM+SjEqQTzlK9u
 MaTm5fG8P81XPCKX6mvcWcG8yF3N1+CXakpm+7Gs4cZOrOgNKCPA61FXmfzhSYQlve2cCtH/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=832 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120117

Fixed a typographical error in "Rate objects" section

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 Documentation/networking/devlink/netdevsim.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/netdevsim.rst b/Documentation/networking/devlink/netdevsim.rst
index 88482725422c..3932004eae82 100644
--- a/Documentation/networking/devlink/netdevsim.rst
+++ b/Documentation/networking/devlink/netdevsim.rst
@@ -62,7 +62,7 @@ Rate objects
 
 The ``netdevsim`` driver supports rate objects management, which includes:
 
-- registerging/unregistering leaf rate objects per VF devlink port;
+- registering/unregistering leaf rate objects per VF devlink port;
 - creation/deletion node rate objects;
 - setting tx_share and tx_max rate values for any rate object type;
 - setting parent node for any rate object type.
-- 
2.49.0


