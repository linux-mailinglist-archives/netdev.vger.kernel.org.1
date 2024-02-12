Return-Path: <netdev+bounces-71074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31510851EDD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AD81F22F4E
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 20:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEA04C61B;
	Mon, 12 Feb 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kBuVqGAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115774A9BF
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770886; cv=none; b=AbBAxXXTEJy2uCy5n89Z4jw1mSPOayZGPbbmw+OKYX2x9AIf63VoiAUMOjaWty7DYqnHVqobGvb+bhmeXysiZINXOS0OXq2EaT2AV9q3zVFheU0Bp3mL1PBC/kJ0X3sF6BVn7EKITCDlRKrrmF41D9mMYNr4i8s8l6RuSUY+Wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770886; c=relaxed/simple;
	bh=POfCkg9REXkzOZuwhgPNyTAD699zK9CtSORUJEsyMaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYn8ZEd8pMbdB8ql9zu9pN6mz5lXB1wy6bne2kFNktwFb/oHo7C3gNKgtkIDBd1D3spg4V77bDnc2w4glPRR9rsFlzSU8TtqRddQ3rbG2Wm1zQAjXxMJsKzLRmpSLZO9R2qt+fXJBXG0xkahxF/xtEVk6NydVkyIWWJjVz7l8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kBuVqGAQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CKbWtX019513;
	Mon, 12 Feb 2024 20:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=UA904GNJyXN6vQVu5c46P3OVKYLY5S4PRrJAUDY8ZNg=;
 b=kBuVqGAQyj9gdFAotx3TXX92zS6lIoDs/cqmg1iKnfq1Rhy4EbLF4HsCZPSaL6YFTE9d
 qE8e2znlitoXXIeTQJo54K3cgC92jPhMV/6yPdfqjABIKVjxYK8pUuM+tVlk/c0I77mi
 4t/7rKkIfSazWgXdOYFvFZ3U5A7aZXnbLA9ZkQigOBxMTTKhckV8KuK/sAUAmFYUhFar
 e92zzlVwofOhN4VPI3XW+1IDzv2XOhWy9b34/O8PrGc3j9oSVXKqpuUKvP9APZ1rP5Mt
 +8RW0llskcx16XFZHb8zW4Iip2gdLzKdOdRKupU2vPmzXyIHg6BRnkYnQ5WC+hKslRfB kw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7the87q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:47:57 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CKcddh021025;
	Mon, 12 Feb 2024 20:47:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7the87pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:47:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CKjEfr009914;
	Mon, 12 Feb 2024 20:47:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62jkb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:47:56 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CKlpMH31195622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 20:47:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60AC058056;
	Mon, 12 Feb 2024 20:47:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2E7158061;
	Mon, 12 Feb 2024 20:47:49 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.67.31.65])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 20:47:49 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, manishc@marvell.com,
        pabeni@redhat.com, skalluru@marvell.com, simon.horman@corigine.com,
        edumazet@google.com, VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com,
        abdhalee@in.ibm.com, thinhtr@linux.vnet.ibm.com
Subject: [PATCH v9 0/2] bnx2x: Fix error recovering in switch configuration
Date: Mon, 12 Feb 2024 14:47:43 -0600
Message-Id: <cover.1707414045.git.thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hKD3G4jC5-XYciFAVlRTx1DFI0qMRns5
X-Proofpoint-GUID: yCcbzjG3TD41_I8xFITREl-FkrzxPEyg
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
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=430 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120161

Please refer to the initial cover letter
https://lore.kernel.org/all/20230818161443.708785-1-thinhtr@linux.vnet.ibm.com

In series Version 6, the patch 
   [v6,1/4] bnx2x: new flag for tracking HW resource
was successfully made it to the mainline kernel
https://github.com/torvalds/linux/commit/bf23ffc8a9a777dfdeb04232e0946b803adbb6a9
but the rest of the patches did not.

The following patch has been excluded from this series: 
    net/bnx2x: prevent excessive debug information during a TX timeout
based on concerns raised by some developers that it might omit valuable 
debugging details as in some other scenarios may cause the TX timeout.


v9: adding "Fixes:" tag to commit messages for patch
    net/bnx2x: Prevent access to a freed page in page_pool

v8: adding stack trace to commit messages for patch
    net/bnx2x: Prevent access to a freed page in page_pool

v7: resubmitting patches. 

Hereby resubmitting the two patches below:

Thinh Tran (2):
  net/bnx2x: Prevent access to a freed page in page_pool
  net/bnx2x: refactor common code to bnx2x_stop_nic()

 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 28 +++++++++++--------
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  7 +++--
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 25 +++--------------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 12 ++------
 4 files changed, 27 insertions(+), 45 deletions(-)

-- 
2.25.1


