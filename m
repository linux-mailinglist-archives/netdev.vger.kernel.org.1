Return-Path: <netdev+bounces-187298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D05AA6448
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB59A8063
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0EF233153;
	Thu,  1 May 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pwCOh3bX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B782144C9
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129004; cv=none; b=JF3fKjIREkVsqf36w+3OzLlhqCkQRrMrT1s6hBqz+ny77Rh80ITwEKwFjiWsz1E5h7u9nlVMbDUR30/X4TWDr9Prn42fIG7Xo7de4trVrHzhE2wb0I6VfypgJ+Np+kcrKPsGigK01Z77KYK61yDclOYgjWGG/2bi7KNrHElo85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129004; c=relaxed/simple;
	bh=/+32GYy31f61bjddyY+3tp88uwLVGb0LhgRAo5MrOso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMKLkQkgZf33PqkbG+5IigxiJU0kClaxCyj9B0FxxlpRxX8jXoaV8y466IFvp3f382C4/2kh1AZYUPTk1qyOinQJeoi1bFGhxCm04tp0wB1znvQb1utTIQjU7+nubu2YV8YnPed7Fa4xN6a3fB0AXtj1JHi5T3+vTRaG9kGWY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pwCOh3bX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541BpNPs027699;
	Thu, 1 May 2025 19:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=caAEH/TApAN1wAmC7MoCNocKcJ8+CeKGQvII9Fl5q
	nQ=; b=pwCOh3bXV3o1uYDfCCLh0oWw5ayRFAHwAf3ek/s5n+kfDAq0KIyq7dCBp
	RrSC2fn716641Z8944BtgicdFaLcKvIoAy70sylcb2So+ujtXLgRNMOuF/QQNJzd
	ZfeL4Hx3t7JXfRCx1WOCQjaMenaiFF9QRnFSNUwHDvhQ1v17wXMZPUwWXe338P1n
	BoAB7OpEEohB94jURtNelW2L298xMC8VwWqiv5ibbKXLOSKSykC4ydxoC3FRDcp2
	aBwl1SeulwfWG/hWfW8Ol2cHYTQLBRlDId2yYSekPJgLVDDHzwvIe2pVZ6ZApoaq
	ITrK8/RygMIi0eDKvxq2/IKlgQUqQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buy950h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 19:49:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 541IIAeT024679;
	Thu, 1 May 2025 19:49:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1medtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 19:49:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 541JnpLW24904240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 19:49:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB1758043;
	Thu,  1 May 2025 19:49:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D86AA58053;
	Thu,  1 May 2025 19:49:50 +0000 (GMT)
Received: from d.austin.ibm.com (unknown [9.41.102.181])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 19:49:50 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, michal.swiatkowski@linux.intel.com,
        horms@kernel.org, kuba@kernel.org,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v4 0/3] net: ibmveth: Make ibmveth use new reset function and new KUnit testsg
Date: Thu,  1 May 2025 14:49:41 -0500
Message-ID: <20250501194944.283729-1-davemarq@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDE1MCBTYWx0ZWRfX+2nbv6hhe1zA aADjqyvmvAnO/zQhl4vWZl85rwixTmuYyRHoVOWKXoljYxn/Yt+mKfDwLYi0iBwCFLbrLflmJb0 P/dMLqOWPUgLKhbgAjPB94QQFb93T1EwlAZTF+Hin7NWfX19ca0c6gI82Q3EEWZAUwo/b2CRlZ+
 X2/ZIiwQbcIkhs5yJn82WJN3hrMYngRP1Eww3rihT9bC0KiO7Y2AdHeG3Rvcf9WIIE1wRLl7Rr7 kZZgJ35gTdbEjWUgu4uIG57robAnls1DMlzW1MZQUEC5bRjgBwKrYZ4+tFa9dBp6vFaaxGD4Tm/ cAjSo933Uno+FwYtiEDtvx+zfoJ+qD5jwifOJSwq2PIiy8HtseZwjrjact6YX6FArBn6g6kJ55k
 wIWLNaPQNKvWklJ9LN+XfwYgpp4DGWcdsqlkUZcuJPLZ6L4v8CYy45Ge88dUOY4zF9HmCXeD
X-Authority-Analysis: v=2.4 cv=FOYbx/os c=1 sm=1 tr=0 ts=6813d061 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=dt9VzEwgFbYA:10 a=AIdBDbJpuyt8KpZaaOoA:9
X-Proofpoint-ORIG-GUID: WQfDCzc2fTcks667WTA62ir9d1O1aYZm
X-Proofpoint-GUID: WQfDCzc2fTcks667WTA62ir9d1O1aYZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=705 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010150

- Fixed struct ibmveth_adapter indentation
- Made ibmveth driver use WARN_ON with recovery rather than BUG_ON. Some
  recovery code schedules a reset through new function ibmveth_reset. Also
  removed a conflicting and unneeded forward declaration.
- Added KUnit tests for some areas changed by the WARN_ON changes.

Changes:
v4: Addressed Jakub Kicinski's review comment: added missing work
queue cancel in ibmveth_remove
v3: Addressed Simon Horman's review comments
- Reworded commit message for ibmveth_reset and WARN_ON changes
- Fixed broken kernel-doc comments
- Fixed struct ibmveth_adapter as a separate patch before ibmveth_reset
  and WARN_ON changes
v2: Addressed Michal Swiatkowski's review comments
- Split into multiple patches
- Used a more descriptive label

Dave Marquardt (3):
  net: ibmveth: Indented struct ibmveth_adapter correctly
  net: ibmveth: Reset the adapter when unexpected states are detected
  net: ibmveth: added KUnit tests for some buffer pool functions

 drivers/net/ethernet/ibm/Kconfig   |  13 ++
 drivers/net/ethernet/ibm/ibmveth.c | 247 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmveth.h |  65 ++++----
 3 files changed, 274 insertions(+), 51 deletions(-)

-- 
2.49.0


