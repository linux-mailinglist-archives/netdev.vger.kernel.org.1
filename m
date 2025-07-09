Return-Path: <netdev+bounces-205521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B54AFF0FB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE2C1C80142
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1414239082;
	Wed,  9 Jul 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y6i1Qn/R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB119E806
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086430; cv=none; b=UHiku1GrqWrVk3hVmA2GUHHKeLJLb9jmUkKomABdo5vT23pB3NRe3gedW59WLt1ljYLaDdqpCHFDaw2EZp0bw6B3TmYx+dT9UPHVjwNhUJ/Nsq/HreXNnQdJQv5tsiLJfcCo3W4S0F3D+VSvhdCu7hBvl5qbnyjqx0cxC+RSRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086430; c=relaxed/simple;
	bh=ZpgghFx+TG28gNIEAT1qp+31USPoS37hnolMfVH+TTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CIILPtObcYtXW7rhbThvpT8tF+zaSzM50LX2M2YHEzxJcJ2M+CsC6uYxv0IB1hArj+u96dUpGfhnmHMHVrFDq7kdPo9aoJtlSZYOyvYmbsLlS9mDRGnOXIvQq61litzhmkjEJnhdO4p/ejMgkWqkkggy4lKrUjI1K2HFYt6qjMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y6i1Qn/R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Gqv3a009243;
	Wed, 9 Jul 2025 18:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=0eNdPcSMZrjpPwFqffqZejmWJvhf
	bUeHOPbJacutdlY=; b=Y6i1Qn/R547gnFUFbwgOc6u4/vGKeN38S0PplMxxR62t
	1g6kRcQ3lSTpjuDost2z1oEVR0GceCK9LCRH9jIZ+rQ1QkNBIf1oMro+lez2Rk6L
	CT42wBQgNmL3JmEWLTxKYUnhuTNwkL7g8GbGnU3Gi3W3zhKP2qNBLS6bMh1YPfol
	WaUBNapwb+usLEsAEAY+xe7bprMT2lypN9jjjJ+P4hDbId6wXuGsysu4IdroK6B8
	4xadIa+csQOQxgkvp/dZtciM4TpJnZvwzLD1Le0GE10lvO6W4C+cNm279natfKYr
	2UjwPicOWqUfYR58qzefehtUeg1kW2k1yfDhp+fdoA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb20hps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:40:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569IPiFD025623;
	Wed, 9 Jul 2025 18:40:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcp9mck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:40:23 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569IeLrd5505542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 18:40:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C1E658055;
	Wed,  9 Jul 2025 18:40:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A05215804B;
	Wed,  9 Jul 2025 18:40:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.247.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 18:40:20 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH v3 net-next 0/2] ibmvnic: Fix/Improve queue stats
Date: Wed,  9 Jul 2025 11:40:06 -0700
Message-Id: <20250709184008.8473-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2NSBTYWx0ZWRfXxEBSdnDA/kuF FkyaCQ8NpnQ+HNbjjje5LVXjY0lmzR+UpFoazAcoEuybstePxVhcwq9VbyrLIEPktMr61oxEMIw mEoPdwWoEcLZqTf6DDzOkVIDB2d2NClICfBT9WUrQGixSsFHNsmrJyAQB2YxdaHNOrkjTdh6pUr
 5XiHbqonk6vgz0xnLEBKpAWAdsq/fPWkbdQcRfLauQv8v5FCM5trMznldusYf0eGvNb4rvp0p+X BoSPc4Tn9GiLhQklnt2m66a5hkERCT5GDtYkqSXKRvJkvWAF493QfisCxlYdJvVQezzfifQ+vr7 nV49YoTI6UGjgunUF84lVZVKE/GRadyCx5MwPKbu8eQ3zkAkjnPTHqx1hzQqU/zefs7q+GUUOCY
 ETzV0tKzuZh8Q9dh/e0n695YWXd+VzIMQHE+BEp1wcN+upeMy954kxFW7tLKM4VJKBe3vOOK
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686eb798 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=9GrW9DZCARAA:10 a=Wb1JkmetP80A:10 a=OLL_FvSJAAAA:8 a=moRpFM_92Wu3aGCG9KwA:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
 a=--L9bC3Vx1EA:10 a=is7418X0aMcA:10 a=nWRTeK5yBa4A:10 a=B8jS9hfQbaAA:10 a=R7sulA5OP14A:10 a=IufbB6nXXc8A:10 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-ORIG-GUID: qDGTCweOgkBH6FD01WcVRxCUJR7wRBT3
X-Proofpoint-GUID: qDGTCweOgkBH6FD01WcVRxCUJR7wRBT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=580 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090165

This patch series introduces two updates to the ibmvnic driver, 
focusing on improving the accuracy and safety of queue-level statistics.

Patch 1: Convert per-queue RX/TX stats to atomic64_t to ensure thread-safe 
updates in concurrent environments. This establishes a safe and consistent 
foundation for subsequent statistics-related fixes. 

Patch 2: Fix inaccurate sar statistics by implementing ndo_get_stats64() and 
removing the outdated manual updates to netdev->stats.

This series is intended for `net-next` and assumes the bug fix for hardcoded 
`NUM_RX_STATS` and `NUM_TX_STATS` has already been included in the `net` tree.

--------------------------------------

Changes since v2:
link to v2: https://www.spinics.net/lists/netdev/msg1104665.html

- Dropped Patch 2 from v2, which fixed the hardcoded `NUM_RX_STATS` and `NUM_TX_STATS`,
 as suggested by Simon. https://www.spinics.net/lists/netdev/msg1106669.html
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


