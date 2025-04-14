Return-Path: <netdev+bounces-182443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9BA88C5A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0223B2672
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241C1AF0AE;
	Mon, 14 Apr 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F1x4kVNe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE8381BA
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744659634; cv=none; b=qcpXE6scqg01woGNeWByM2DNzgsKTRoHYXoks1lWcPMTrsTsy2est5RCfTCxb6ycQ2mkqEqHC2PaZG4Zu+/eSWPIxEZaut/m3sc7k13XubdcZ2Rsq28KERIiVbyaWxiHhggBGnBWUwgDf7PNaiqnpaNVbPwMPXMpmwj9peMr5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744659634; c=relaxed/simple;
	bh=K/9rMxGNq5o700JrBtEvc8thEgKLxjrV8PsG1PDppfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tovSrNNBxAR+UpJRvEbLDenV9oeDTAWXPIuQX5Vp4Yy1GpYFWy6hEUvWd3jQNZbqgsbzfIgbuQQGo4/yJukNhT6Y6BULT6UFQqJJwDbQk2/rFBelQbViqhFexTfzMVZBTY5Fw8PCcQO2o5dEYoKXGuzRS2LwkaHO0YQL7PwLguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F1x4kVNe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EA43He026680;
	Mon, 14 Apr 2025 19:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Eo/7lmDns5bA04x+0vlwGMMIGQBGv0AeM71HeXdVR
	+k=; b=F1x4kVNepHNiTlXSoTwRhM2FSSAOe+0zEnF1V1AaULo1ZavoZWc7QzbBR
	nD2HaFePqzKRJl6Muq6pXSTszO2Mx7lfzgLbh925aAecss5z2OTFFAVvgkBiysNC
	tzG05bEmjVxfVsGyvsyvWHATe6CgKsYomNZz5TI5Fs+RKj/6DCgKsoxD8OznpuE6
	uRO/Nrkz6niTCVCBEkbVbSyn6khzIU9H1Y/qGJg3R1Mxs9gB2QyjDUI3hQp5JaL2
	7FuwHFRhOU9fdkhD3AlW2u57EO2C55CiMY/AF/JsgHBY1MX9q91eszvo8mzqiR7A
	KldFCf/n07VkWdihLpT99VTTWvx1g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46109f2raq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 19:40:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EI25tQ016689;
	Mon, 14 Apr 2025 19:40:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460571ydj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 19:40:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EJeOHI28902100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 19:40:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D8AC5805D;
	Mon, 14 Apr 2025 19:40:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32CDA58058;
	Mon, 14 Apr 2025 19:40:24 +0000 (GMT)
Received: from d.attlocal.net (unknown [9.61.98.8])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 19:40:24 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
        Dave Marquardt <davemarq@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 0/2] net: ibmveth: Make ibmveth use WARN_ON instead of BUG_ON and added KUnit tests
Date: Mon, 14 Apr 2025 14:40:14 -0500
Message-ID: <20250414194016.437838-1-davemarq@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -yDISVVWdXosvG8rLzfqzz5BPPUGHLXq
X-Proofpoint-ORIG-GUID: -yDISVVWdXosvG8rLzfqzz5BPPUGHLXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=740 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140142

- Made ibmveth driver use WARN_ON with recovery rather than BUG_ON. Some
  recovery code schedules a reset through new function ibmveth_reset. Also
  removed a conflicting and unneeded forward declaration.
- Added KUnit tests for some areas changed by the WARN_ON changes.

Changes:
v2: Addressed Michal Swiatkowski's comments
- Split into multiple patches
- Used a more descriptive label
*** BLURB HERE ***

Dave Marquardt (2):
  net: ibmveth: make ibmveth use WARN_ON instead of BUG_ON
  net: ibmveth: added KUnit tests for some buffer pool functions

 drivers/net/ethernet/ibm/Kconfig   |  13 ++
 drivers/net/ethernet/ibm/ibmveth.c | 241 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmveth.h |  65 ++++----
 3 files changed, 268 insertions(+), 51 deletions(-)

-- 
2.49.0


