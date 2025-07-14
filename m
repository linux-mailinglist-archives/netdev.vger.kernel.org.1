Return-Path: <netdev+bounces-206800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A9B04694
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA5F7B0A2A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6F0266576;
	Mon, 14 Jul 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NchOZO9P"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16859258CEC
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514524; cv=none; b=t4EZ6Mcwa/TgMIaud8x+hA9rVNie5xfFM1suepR8jNuAUgxQ6++ok0KTn3/opaIcTmIxZsK8/S29fXlrg0ZFRb5rD4Wev9/U6BOnbbjhL4AEvv7h7pCndDzg2sURGOq4ZCs3aoj8zT4Fe8d1nUeKet5UXoUyEnnCXmhN9uY+k0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514524; c=relaxed/simple;
	bh=tbUBJXixzpGPwapmbx88CasQU46Rf0MS4UQdCr6NyVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QYoCCzlKf3jZ2XJ8ZGQ1lkWDXFjU4RKlgLqqioNKJ6OSgaEWUEc5x2nx2p/6fvdyOs9zRqTtCNpZxRzt9lYzrreUT8vPy/r0ACOubVM0a2cOk+C2x+MHOlTMrCgkDWjeDaSlnDSV8dQzBV6XUbl9EraMjKgmRlxqQcy6Sj5xzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NchOZO9P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EC0Wmr002849;
	Mon, 14 Jul 2025 17:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ckpqZP/HdTmP+zx/+/3KL8VAv5rb
	bv80J7b27jpm5Cg=; b=NchOZO9P3OtXW4dpWMR9djXWTtYpr4PI8TpeZkO7Jd+h
	kUO/+A2CObC/cbwhooHIA8Wgc3gVGmhD3DsvNrwnHoFsicqxwX8ZaX9Fm0eRtDwK
	FEKhE49lI/ulAhhMnmBjB3p5f464SE6/eSJ+MXv7hTg7ag+eFTd4LRtbquRxIBoR
	U5oBALMFjdx36FvQsAIHCCbNx3Urt8E9KlqpUA73NKUxeicD54N36c+FvU11zz4X
	wzN42k1S3SrnMih36xOHIRYvMhjuMk3FQ2PimKV9+eIpzQxNEitOcsnLqJ2W979/
	S+uJjcDAM2Rjo6GJhNyPBKjKoxmvIKY8HvtlX10N/A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cu271-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 17:35:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EFDMTf000722;
	Mon, 14 Jul 2025 17:35:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48kxmvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 17:35:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EHZBJk60293454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 17:35:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD03C58065;
	Mon, 14 Jul 2025 17:35:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C0B58059;
	Mon, 14 Jul 2025 17:35:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.148])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 17:35:10 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH v3 net-next resubmit 0/2] ibmvnic: Fix/Improve queue stats
Date: Mon, 14 Jul 2025 13:35:05 -0400
Message-Id: <20250714173507.73096-1-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tCq7HKAOfjoDhAtfrduBxLgiUzDroLCt
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68753fd1 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=9GrW9DZCARAA:10 a=Wb1JkmetP80A:10 a=OLL_FvSJAAAA:8 a=moRpFM_92Wu3aGCG9KwA:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
 a=--L9bC3Vx1EA:10 a=is7418X0aMcA:10 a=nWRTeK5yBa4A:10 a=B8jS9hfQbaAA:10 a=R7sulA5OP14A:10 a=IufbB6nXXc8A:10 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: tCq7HKAOfjoDhAtfrduBxLgiUzDroLCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwOCBTYWx0ZWRfX/mxZ/kSGn5/Y rRXfDbw/AW6Yxay5sidcvQ3FP58eyammLw58hm1MvCD4jIYUB+QYrUtmrN8Sm2xQOlw9TC2PVst rST//Jy0prA7asSzZLcY9XQckIjFneAbF52IuAFkCF7ItOpi0PXZ0eQY5RMkyviiuIFBfSISEho
 av3UGEIwuwkRGlf9UeiW9qrhcY9xZxllRr+db9wo9zJVooE5YSjocwbwsIYZRwalxWN5qtD+R9z fOMfn5Ink3CEBH354B7UskpEIMeyMIw/aiHk3hWwSxArbJ5MnU5iH0Qh45mRnmI3DCOOcQsRrv6 ebliV1uscMS4xjd+FMh3fhFQ9fCB24xV7W49413icfWuY7b2tzYK+XwTxbt99uJzSdGfqZ4Uv65
 q3nM5I5JsQsaavAM8ITsIOzhOB8OqZeWunnNPqO3Efy0jFCvfS6NuGEHNr8ru5aDY59uWQnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=567 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140108

This series is resubmitted after the bug fix for hardcoded 
`NUM_RX_STATS` and `NUM_TX_STATS` has already been included in the `net-next` tree.

This patch series introduces two updates to the ibmvnic driver, 
focusing on improving the accuracy and safety of queue-level statistics.

Patch 1: Convert per-queue RX/TX stats to atomic64_t to ensure thread-safe 
updates in concurrent environments. This establishes a safe and consistent 
foundation for subsequent statistics-related fixes. 

Patch 2: Fix inaccurate sar statistics by implementing ndo_get_stats64() and 
removing the outdated manual updates to netdev->stats. This patch also improves
packets rates and bandwith with large workload.


--------------------------------------

Changes since v2:
link to v2: https://www.spinics.net/lists/netdev/msg1104665.html

- Dropped Patch 2 from v2, which fixed the hardcoded `NUM_RX_STATS` and `NUM_TX_STATS`,
 as suggested by Simon. https://www.spinics.net/lists/netdev/msg1106669.html included
 in net-next
- Updated Patch 1 in v2 to rebase on top of the above fix in `net`.
– Patch 3 in v2 (now patch 2) unchanged.
- Dropped Patch 4 from v2, which raised the default number of indirect sub-CRQ entries 
and introduced a module parameter for backward compatibility. Based on review feedback, 
plan to explore alternative ways to handle older systems without adding a module parameter.

---

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

Mingming Cao (2):
  ibmvnic: Use atomic64_t for queue stats
  ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting

 drivers/net/ethernet/ibm/ibmvnic.c | 71 +++++++++++++++++++-----------
 drivers/net/ethernet/ibm/ibmvnic.h | 18 ++++----
 2 files changed, 55 insertions(+), 34 deletions(-)

-- 
2.39.3 (Apple Git-146)


