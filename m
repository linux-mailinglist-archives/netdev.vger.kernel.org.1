Return-Path: <netdev+bounces-116235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EA7949879
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA732835D1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC415444E;
	Tue,  6 Aug 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jOf889PW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166B146A65
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973041; cv=none; b=LMvreLKsu47E1TylpO4YujcbM1ToiAL2eCbtQxreAlzta/WkqHviC8aGncXhZZELoqTTTJwgWpPrJGCbouryB7y53Y1CFNxAwSRdKSN+RKD6CschfOSyvyuZTLt9qou18Un5yE2xnUhsik8190eFED3Pa75cOYeIFFWv0nnWAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973041; c=relaxed/simple;
	bh=i4ibiUv6HtLXlU/QoxnCG8lydhqOVzUKSbvDnVkJ1hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjiLnTVpc5r1Y4KDH/mR17DhA3NoECqeaPMUp65nse4w1gSFDwYSHR008Hm3Cz0o8dmCnnHXjObUi1opZOfVFr5DHTi8p2Egq7tj86HBYYDWCBky06qS+tTsw2PZnyNm9U23Ree9flrgWwrhsVOmMJlathTkrQJzmjwflvUm/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jOf889PW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DLSmc002711
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=CvzTyrWdP2etOmNAUPDb/aa19/HmUHgVRJ3JEoL
	vaPI=; b=jOf889PWOukMU0eOZsAxNgGo81rKzQbMaJFTboQ5YDbH8R2tk273k2n
	+jyhq6zwptM8C69t07EzWcUZjwjrQBgI8BRCT0Z5JYRwxqmcvY3Pt236uZBR6g+A
	c5UzrTpEWepe0zZbnDVPg/Y20Dv7SUZ0css3jNWJ5VS1r0NoS1vdLx3f5bv8I5Q7
	X3FHq8702z3I9S9BBN10P4PaZy9IkCsYDqOFq83CxmeFWClcWTwLLihj2MDGxIZ9
	KQxDvnECrbpjyerHujYh7us6+rc2Yd33w/yXwnNHh00sxqxZ6E7iAJEI1PCnsNzD
	VBwVCaEWyyU1wW+WPEycBbr99k7SJKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ucd21yq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476J7uOe024155
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvpdc1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:17 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476JbAFG12321398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 19:37:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1BE25805A;
	Tue,  6 Aug 2024 19:37:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D4E85805D;
	Tue,  6 Aug 2024 19:37:10 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.153.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 19:37:10 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2 0/7] ibmvnic rr patchset
Date: Tue,  6 Aug 2024 14:36:59 -0500
Message-ID: <20240806193706.998148-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zOnbyvO-IgNjDUlR4FVhzOrvGwuYu58X
X-Proofpoint-ORIG-GUID: zOnbyvO-IgNjDUlR4FVhzOrvGwuYu58X
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
 definitions=2024-08-06_16,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=440
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060137

Only change from v1 is a commit message change in the last patch.
In response to Jakubs comment, I added a blurb about non-GSO large
packet performance. Thanks Jakub for requesting this, I hadn't thought
to test that prior. Luckily, I think we are safe since xmit_more
is usually true (even in RR tests) due to the segmented packets. My best
case (and feedback is still welcome) to see if we hit any issues with
expensive checksumming was an 8900 byte RR workload with MTU 9000. Noted
those results in the commit message.

Thanks again,
Nick

v1 - https://lore.kernel.org/netdev/20240801212340.132607-1-nnac123@linux.ibm.com/

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


