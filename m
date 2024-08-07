Return-Path: <netdev+bounces-116615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3541694B1FA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0299282195
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2314F118;
	Wed,  7 Aug 2024 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mn8j2Wvh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A11487EB
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065505; cv=none; b=JI1navbhLoyeHif3LZtHs+fTfw9jxpZPOWH+0bGwR8brEzxJ4mWckjrkqyGoSoCfX5Gq2ognW0kCwtRIjeP/gGRFAZoVb1W7Xd6SjHfiWJoKYcLvfJf/QluwZUQOJvX5QeL3SKTj4srtpt15yA3oazm4gFxc9ExNsnGXgFgxA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065505; c=relaxed/simple;
	bh=073tjT8mixTcQ1Ra7iABBOUa0RROKCOZIdMHmioRxF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezFPjr//wtQgiESW+O6LWdELzSJsu8/hPqCaLxQCKAWm4tFtQQhfwPnwjmrd2cYoVTxulT7hS571BLER+IMxZ5/pkro4RknW7jURfrl+Re7+VWFdX1E3/n7aSnzbKJ5iWiRYdtZfASgvGaILjEJaf1vKJwLtfxeQMWO0NoUlq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mn8j2Wvh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772MgPW021027
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=30XjeBj37N0ySf7ghSlCflK/nyEi7l0J5i+33g4
	970I=; b=Mn8j2Wvhofh0gNiF3okJJex9q845qcYrCr1G+M0OJ8QhVC68MIj2/Zy
	tL1/Pk1P8u3YyBH7IfdomTb0UUdL3LyIkXFJEfUDO9CwTAItG1ov2vfPoKzGv5jL
	YUMi9NWouf0gAaJBgctQ/z2NT17xanTjYehLpAr6V+ezzwixPreoxxsXr5dULsXA
	jCCSN6IoOqnZdtoY+/llthD6EC/Cdk70crrC6MWDCCQYUkC2j3y8h/qWvacXkBA1
	opnW1J6Bb02Qf5P6F7D2unX/tPvRoWzru9EuYLuAs4qZUVfPucGsm1JPl3IkBFKu
	e3whynAOHpv6rN4nFnj3bmfOO17XhXg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02kxx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477KbTGO030246
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k3aqax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477LICDt23593650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 21:18:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1D1058060;
	Wed,  7 Aug 2024 21:18:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAB1758068;
	Wed,  7 Aug 2024 21:18:11 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.4.192])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 21:18:11 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 0/7] ibmvnic: ibmvnic rr patchset
Date: Wed,  7 Aug 2024 16:18:02 -0500
Message-ID: <20240807211809.1259563-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z_eovrjDyMvgy6WJkj0LyADFX2VzryCS
X-Proofpoint-ORIG-GUID: z_eovrjDyMvgy6WJkj0LyADFX2VzryCS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=364 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070146

Hello again!
Thanks Simon and Jakub for the feedback, much appreciated.
I just learned about NIPA so hopefully I will get a local
instance up and won't have to clog the mailing list as much.

Changes since v2:
  - edit kdoc's in patch 3
  - fixup commit message formating in patch 7
Changes since V1:
  - add performance data in patch 7 commit message

v1 - https://lore.kernel.org/netdev/20240801212340.132607-1-nnac123@linux.ibm.com/
v2 - https://lore.kernel.org/netdev/20240806193706.998148-1-nnac123@linux.ibm.com/

Nick Child (7):
  ibmvnic: Only replenish rx pool when resources are getting low
  ibmvnic: Use header len helper functions on tx
  ibmvnic: Reduce memcpys in tx descriptor generation
  ibmvnic: Remove duplicate memory barriers in tx
  ibmvnic: Introduce send sub-crq direct
  ibmvnic: Only record tx completed bytes once per handler
  ibmvnic: Perform tx CSO during send scrq direct

 drivers/net/ethernet/ibm/ibmvnic.c | 183 +++++++++++++++++------------
 1 file changed, 108 insertions(+), 75 deletions(-)

-- 
2.43.0


