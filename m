Return-Path: <netdev+bounces-71497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3668539F5
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936561F2326B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360C310A16;
	Tue, 13 Feb 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RUDaiU0M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1275D277
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849191; cv=none; b=EGgE7kG8mLM5sXb3K1wo9ly1p6H9jCKLY71+/RSizya40ZDwje5Am2QBvcuSKdnn3ifG1SPjYRHqW5IduvsFReSNwFzELg9S1C/wV/g8PSvwSsl9RvR9B5fl0DUzperYxmJ76FAmtbjtwjU6c7//7TaeA8inG6Ttqv28cCjmjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849191; c=relaxed/simple;
	bh=D9Ua1XqMwPjRL91Y1pK+WEzkWtLsLUvaWMfmOYtLnPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hc8qWCMM18PeouwwcvPoswoNzdzvYIVXbUrmqn+EHg6Og+QzAVKyBfbqvogzuUJ0NmLx1n42vTIY6+A2c9B5jEn632ky2AUsOLcIzGJ2CbAW+8wdI98Pv12ObnTPQG2v/nEGRhTEIYaeI/uRRj5+d8XowlaQ3ID2u5D5YmRfjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RUDaiU0M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DHvmcn023800;
	Tue, 13 Feb 2024 18:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=UA904GNJyXN6vQVu5c46P3OVKYLY5S4PRrJAUDY8ZNg=;
 b=RUDaiU0MR3XtOyuHgocqKRVLQpqyLZ1utgjYvTYW+q90iKfiUQoulHooLUiPQLFwPrxg
 h0cjfJdI+k/N47NrteHpK6JLImolrlpxilQ0ZxGF+56CCIQ+Lo9zmKBXM4cA/vfvaydr
 P1JP5KOUQI5lRzmHp5i1sKk9YAngzCmJgIDxXfIBszYYNaVZ5w7UUOt0WuEdJC+Z9PPD
 KbWmavevMoSr65lr3FL1fFlPw7mZlrpkcRsyZdYLK3KZwXZCDxfestK5LMO/ohU0qADA
 D9fQi6F3+73JL3ndwqC6BHIyCo4hmYaCLmOzIytwn0K7rtbyRIdXdstE6OTawhC1S0aW fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8d9j10uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:33:01 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DHw6ec024299;
	Tue, 13 Feb 2024 18:33:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8d9j10uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:33:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DIWliX009896;
	Tue, 13 Feb 2024 18:33:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkrt69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:33:00 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DIWtQO20054666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 18:32:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB1A58060;
	Tue, 13 Feb 2024 18:32:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C4515803F;
	Tue, 13 Feb 2024 18:32:54 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 18:32:54 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, manishc@marvell.com,
        pabeni@redhat.com, skalluru@marvell.com, simon.horman@corigine.com,
        edumazet@google.com, VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com,
        abdhalee@in.ibm.com, thinhtr@linux.vnet.ibm.com
Subject: [PATCH v10 0/2] bnx2x: Fix error recovering in switch configuration
Date: Tue, 13 Feb 2024 12:32:44 -0600
Message-Id: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QnLqj2f0GueQn-j-JhrKvG0fgDMuc8Wf
X-Proofpoint-ORIG-GUID: d8-0IUbq72LHEdWZtCm4JBaFol68T68j
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
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=428 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130146

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


