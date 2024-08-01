Return-Path: <netdev+bounces-115128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA292945416
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649E61F23B7E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6A14B954;
	Thu,  1 Aug 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E42LRrJr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8314A0AB
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547435; cv=none; b=K6XPvrEk4qnH21R1J1BZi++NTDqvaN0u1F9ZbxKN1HHdJKsq3ru9WOWz2GK/xyoqNT5u+dpd72u1kZBLAVkDjQt2Txm9TPtYhlok41Cit+Nkhfm7Y3bDPl1NAShOtpd2VNbAr9K6A0iOBAB9lOIt/wsRKq3b+KXe/fy44Kz1J1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547435; c=relaxed/simple;
	bh=pP+W3Kdnh7lAvF3LEkC/dwO1r1xc9tSYSzd51F8Dab8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4GOwPRMof3dShsSiYcslPcX0jTvNKqIqPPr/xdR3IAfN7tWZ3djfDi2aTgOAy//qRWI0KPC+2WB0FiEUn1IqvVO3lfKwJnoYgZcWntDq+Iq1Aqb1wG22yno2neZ0iUaadI3Kpm1lhbd0A5F7GsL6u4LNBBvcSvjmkQYEgJCsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E42LRrJr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471KScFH015800
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=aqaB87wIgeEj1GEiZDXwHvXvkV
	aSAyeJfvwuGnwTGks=; b=E42LRrJrvaZFqo9JhNRgLgKEjbuekoUbNakEOiBj86
	xGFa/XKpoDQFg3uScY7yXFASNtiuK3gw2Qd7lOo/nfbqQB5crd5+VY/V1Mq1COup
	31gX2ZqxjbuNkOUYXSa+tiAHBgPHDi2DHf4i8VEcM8SriQIY/Le9hKMY3tJpOwOG
	2YHfevOgw/Xy4TxVQAoA6jBW2M6IvU7vntm+FC3pgbkOquH942tdhRMrRmbOkxr/
	W9B6NSVgPvD8CvBwcRGw6jEeINCX1bk5NE3VMkKeala2t3LxsP3g34fwAjjsWZwZ
	v7q4748UyWH3lQ+y5lpz/ZlDyDhdrW+rHSE13oJWs8XA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rhe4g3ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471J5HtI011295
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn3vp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:52 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471LNiM066847068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 21:23:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FC9A58058;
	Thu,  1 Aug 2024 21:23:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D648C58059;
	Thu,  1 Aug 2024 21:23:43 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.139.48])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 21:23:43 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next 0/7] ibmvnic RR performance improvements
Date: Thu,  1 Aug 2024 16:23:33 -0500
Message-ID: <20240801212340.132607-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HjV9GvQekCMwBckxF14Tm89NcBdPzRU7
X-Proofpoint-GUID: HjV9GvQekCMwBckxF14Tm89NcBdPzRU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=45 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=9 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxscore=45 bulkscore=0 lowpriorityscore=0
 spamscore=45 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010142

Hello!

This patchset aims to increase the ibmvnic small packet request
response transaction rate.

When measuring transaction rate on several netperf tcp_rr connections,
a ~2x improvement can be observed! No regressions were seen when
performing other bw/latency tests.

The main points of improvement were from:
 - Patch 1 - request response tests will almost never fill a napi budget
             so wasting time replenishing every poll can be expensive
 - Patch 6 - Turns out that updating BQL completed bytes more than once per
             interrupt can be a really bad idea!

The final patch SHOULD be temporary, we are waiting for our FW teams to
clarify some documentation items. Within a few years that logic should
be replaced. In the meantime, it only effects non-GSO + CSO + !xmit_more
packets. There was no effect on performance from this patch.

Looking forward to any and all feedback!
Thanks,
  Nick Child

Nick Child (7):
  ibmvnic: Only replenish rx pool when resources are getting low
  ibmvnic: Use header len helper functions on tx
  ibmvnic: Reduce memcpys in tx descriptor generation
  ibmvnic: Remove duplicate memory barriers in tx
  ibmvnic: Introduce send sub-crq direct
  ibmvnic: Only record tx completed bytes once per handler
  ibmvnic: Perform tx CSO during send scrq direct

 drivers/net/ethernet/ibm/ibmvnic.c | 174 +++++++++++++++++------------
 1 file changed, 102 insertions(+), 72 deletions(-)

-- 
2.43.0


