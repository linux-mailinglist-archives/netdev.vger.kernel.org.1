Return-Path: <netdev+bounces-202694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7FAEEB06
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3646176749
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26422DF99;
	Mon, 30 Jun 2025 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eUA8VDeC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730920F07C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751327296; cv=none; b=YsYnpc3G5FoPOKMczH+UbUogKanKAAm4iTGC1ue2GKKo0DSBskrwFoFqGCrUwWq9MXIxT3ZSCmMD1hVaxjflBfHAaZNJbFWz+HWHU/7gOFl7eXHKH2UDrFRQZ8rUB5drCpxIhLsl4QqCf66d6AIkX2yxUzCs452l2FcIO/xMirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751327296; c=relaxed/simple;
	bh=ZctxJgnXDzuX2ojeSYrsyF6SFChEZ09VYyORjPDb1eA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PAIuelvHKgfJYx012jhWoA+ZdY8dsMP0Yxu8uMu8M1BRup8l1Crxn/lonf5eW5wvH5GhOV6zr/fWzm66oZ6B2F9hc4X4ToJ6msvEMmIJOAYgDoFA6PSIWhGeSKKtMNkqMkg5YeayYf2QTU4te9Tpwk/8UZsfHKMJUiTUbl95wXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eUA8VDeC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEJKR5028490
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CYvOW6j4G0litxvmd30Cx6HBBKJ0i1RzdJLSO++dX
	/o=; b=eUA8VDeCojdfcdddSKqthYRIJxe1ybNKD6ZQF0yoB83F6V4JL+J46AOpD
	hmyu/bVPDhSP7PbIHbLUHwWAFj0A4/cm3HDSPlFBKMaIuyE4uvfYwYFVl5tNl4ww
	/fZ5TjzObOUcrcCE52Kor8kBlIbjnXDFtnnnbYIAqj5a4nCyvgbq46PS5dAf0cGC
	s6J8/py9OS7s/tnCG/kmFK0O4zArKKsNrCoOLCmTFdRILwiAv5J8vMIghk+FjLXO
	lh/+5bmDjjn3JfGe/6LGMbZmByEBZFCyykSAoHutF2MzeqjdAfHZzAQQz+iPyxAp
	9dtRiaHurYc2R6j1JWDsvT6y483Vw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830m7q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55ULfDSx032152
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47ju40g99w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UNmB7o31261378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 23:48:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D43B5805B;
	Mon, 30 Jun 2025 23:48:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B65D58059;
	Mon, 30 Jun 2025 23:48:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.36])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 23:48:10 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH net-next 0/4] ibmvnic: Improve queue stats and subcrq indirect handling
Date: Mon, 30 Jun 2025 16:48:02 -0700
Message-Id: <20250630234806.10885-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U2__FbN6l-bjNIpW45E9p7wV-9ctr_MF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE5NiBTYWx0ZWRfX83ZpHaPjj3Yz wqETXb0lK7nV8sCNmyHN/JRCGP9ezbKpVUCHOT8UwiirxCyvqnQKOWyvoRHG1RgIQ9iH5taFhJb e9DXztDUl960ANU8AMADQqnvrzJy9PWJ2EhZSwHfq/PPIiPUJjaI0HkkpRwXs2nr05Zh/YJypax
 iqAXJQC1CpTbJh/7KPkZjbjXg7GrSHruu9OVxMXJCwXmD9Z/Ja+8U7emUTVAmYmffBOw8aVXKM6 LX9MHlhKlP868AWl/Q874bOpAG/OZq07afCXVLLGBz/C7Ue/DMGVj7Qxm1v8ZIfDoJP9i4GJcgi O1Oa5JE9XSP5KW9SMv8Y6eraW1m0TpJ6T6gDCgokrYC0oTcr7yik4ewWut7bMtEYljul62rA9WE
 qK/UYoLOqJHjGYv2JxSuJHtAlWINoIIISYgoATAF55eatBYW3mU1zb6sv0uogjZvABd5GEYs
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=6863223d cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=sU9CkWjVgfER919gmKsA:9
X-Proofpoint-GUID: U2__FbN6l-bjNIpW45E9p7wV-9ctr_MF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxlogscore=507 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300196

This patch series introduces improvements and fixes for
the ibmvnic driver, focusing on statistics handling and CRQ scalability:

1. Dynamically derive NUM_R instead of relying on a static macro.
This allows more flexible configuration of receive queues at runtime.

2. Convert queue-level statistics to use atomic64_t to ensure correctness
under concurrent updates and avoid race conditions.

3. Fix inaccurate System Attention Resource (SAR) statistics reporting
by switching to ndo_get_stats64. This aligns the SAR path with the standard
kernel interface for retrieving network statistics, ensuring accuracy and consistency.

4. Increase the maximum number of indirect entries per sub-CRQ to
 better support high-throughput configurations and future scaling needs.


Mingming Cao (4):
  ibmvnic: Derive NUM_RX_STATS/NUM_TX_STATS dynamically
  ibmvnic: Use atomic64_t for queue stats
  ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting
  ibmvnic: Make max subcrq indirect entries tunable via module param

 drivers/net/ethernet/ibm/ibmvnic.c | 92 ++++++++++++++++++++----------
 drivers/net/ethernet/ibm/ibmvnic.h | 29 ++++++----
 2 files changed, 80 insertions(+), 41 deletions(-)

-- 
2.39.3 (Apple Git-146)


