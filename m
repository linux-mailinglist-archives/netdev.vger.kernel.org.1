Return-Path: <netdev+bounces-203466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C120AF5FC3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229CB174F32
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB252D0C91;
	Wed,  2 Jul 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X/osXlhD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD81254B1B
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476693; cv=none; b=r1jCkjAxrJA2oFVNTnUz/dzHFUDDONlqWf/tCvPmrndYkQxxsWwePNLV8qnWS1k29Lupscmqiuhf9wNGlAW7wboeFCpRRL98jdlssSpGF2LMD2GfQRhrAI9mB8YDyywRw4mKP1/7o47buhvuoO1HdNWuAujjNrwge2NzGbXLnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476693; c=relaxed/simple;
	bh=PbNAuwln59r/FsE0Zyr1wHRQpQ3TGEZH9qEFsY5JVMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C967BLW+ezyveLmbPbL8QPkme+j8rCZZGXZeEZLi4vs0BWIjsgY0uIWsYNlc6moH4HxFf9Mfr4C0+Lp3y+yr0xXe/GzjmAErlkBGJo5WwXDAe0NJW68IffhU/jaUB7dehv3nQgzCZjddD+UhJ5FLiA2llMBobte8osR6kbm5+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X/osXlhD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Beq0x010048
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=GoXzxUDaE3Zt+49X6qVQX5ckfdKU
	leP6H2k/d4Xz5BY=; b=X/osXlhDF5TcZXThaTczN5zGousLSlXHci7kJhEhcq8C
	e29wPkAFs5wDs1tOz1ULUrhnaSgqqT1sHM3y5JUb52rYn3HbI+kwXynF21vqqnMq
	6UfH398jJV7fYKPtzYTcBJkB2fd6UP+F38fMU0RYYSVIqIjTVbMcEIVVcZY8PuOu
	iTq7nR2fyfPyNsQcPCtSVYRefiI6WTJe3LK9aUte7BqrzUxTOZMaX4qp4RAenI+C
	qhxE0NZJIjFaAhXjdmmFPU8s6e8L9oTQLAtMTVQx4oNb5LRFGqxG3AH7TomwTuOv
	tjvuYNYXbaotjSay5jX+dcxTZo3m8bZk+AZpk6ncoQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830xywe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562GmIlR021117
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtquguje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562HI3I310027668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 17:18:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA20458054;
	Wed,  2 Jul 2025 17:18:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0610A5805C;
	Wed,  2 Jul 2025 17:18:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.2])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 17:18:07 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        davemarq@linux.ibm.com, mmc@linux.ibm.com
Subject: [PATCH v2 net-next 0/4] Fix/Improve queue stats and subcrq indirect handling 
Date: Wed,  2 Jul 2025 10:18:00 -0700
Message-Id: <20250702171804.86422-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ga7Ajv_6uSY7YU0e-gOEEdo30yOjotM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MiBTYWx0ZWRfX2dy1PULv1pyJ OASuHhQBRjTSG5E80u9/sTHFD2i7pkQDuKBdnNE9sp45cLTQCqUC5qVhqRDLcQEKZPDyv9sYVsc YI2Y9qy9kOBbJ8scTU7uN4YTbkVpLj3Tqqheilc9N0w/FYFSn2lYukynqBvn6aE8fanUy9Kb88K
 Vb7Guy7oHyK7LB14ZC8JsfIZjHUT2SEz2Nx4jKFwqziVanMHdfg8m3EvR9y2aIR41RlwtgfebU3 a+sWLUgouJOdyEM0PPgq3gVl0LRHpUGOcm/ER5Fscp3dhLct5NTHbnfX+g7cWUSQn5clHHukUTJ NNKN66iViGzxRBYPoHN4D8hJX9By0Ry6rtm15rD5FRiLwWlabEdunVB/cBjHwPxZZ9uRCvxi/pN
 sSR31ZvVk8lR6j6kDZ9KwbSycRdIvJ0v6gmwS6M2KzbCEWo1vedhW33WqR4KkkOM1tlDn8EU
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=686569d3 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=9GrW9DZCARAA:10 a=Wb1JkmetP80A:10 a=OLL_FvSJAAAA:8 a=moRpFM_92Wu3aGCG9KwA:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
 a=nWRTeK5yBa4A:10 a=IufbB6nXXc8A:10 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: 9ga7Ajv_6uSY7YU0e-gOEEdo30yOjotM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=484 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020142

This patch series introduces fixes and improvements to the ibmvnic driver, 
focusing on accurate statistics reporting, CRQ scalability.

Patch 1: Convert per-queue RX/TX stats to atomic64_t to ensure thread-safe 
updates in concurrent environments. This establishes a safe and consistent 
foundation for subsequent statistics-related fixes.

Patch 2: Replace hardcoded NUM_RX_STATS and NUM_TX_STATS macros by dynamically
 deriving the counts using sizeof. This fixes a mismatch introduced in commit 
2ee73c54a615 (“ibmvnic: Add stat for tx direct vs tx batched”) and ensures 
that all stat fields are correctly reported via ethtool -S.

Patch 3: Fix inaccurate sar statistics by implementing ndo_get_stats64() and 
removing the outdated manual updates to netdev->stats.

Patch 4: Raise the default number of indirect sub-CRQ entries to 128 on POWER9 
and later systems, improving performance under high-throughput workloads. A 
module parameter is included as a fallback for compatibility on older systems; 
this is documented as a transitional mechanism, not intended for dynamic tuning.


--------------------------------------

Changes since v1:
 Link to v1: https://www.spinics.net/lists/netdev/msg1103893.html

Patch 1 (was Patch 2 in v1): Introduces atomic64_t stats early to establish 
a consistent foundation. Replaces atomic64_sub() with atomic64_sub_return() 
and adds a warning for underflow. This change now comes first to ensure correct
 ordering of dependency with stat size derivation.

Patch 2 (was Patch 1 in v1): Commit message rewritten to clearly highlight the 
mismatch bug caused by static stat counts and rebased on top of the atomic64 
conversion to avoid broken logic during intermediate states.

Patch 3: No functional changes

Patch 4: Commit message clarified to explain the use of 128 indirect entries 
on POWER9+ systems and the intent of the module parameter as a transitional 
fallback for legacy or constrained systems.

Mingming Cao (4):
  ibmvnic: Use atomic64_t for queue stats
  ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof
  ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting
  ibmvnic: Make max subcrq indirect entries tunable via module param

 drivers/net/ethernet/ibm/ibmvnic.c | 101 ++++++++++++++++++++---------
 drivers/net/ethernet/ibm/ibmvnic.h |  29 +++++----
 2 files changed, 89 insertions(+), 41 deletions(-)

-- 
2.39.3 (Apple Git-146)


