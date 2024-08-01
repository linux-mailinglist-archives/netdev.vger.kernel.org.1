Return-Path: <netdev+bounces-115123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB88945406
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F41C23297
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6514A62E;
	Thu,  1 Aug 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Io8m8Ghq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED413DDDC
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546757; cv=none; b=QbJ1HiHdnrByMnct78xxwzxGA9csAnDb8cguofbic7oSDVxQIle7N23rejcMsQX4fcgaP1eZxUevux3nvo57t0FVCqYTntmHqmekUR0zJtTyv+/G+uLfcFFRs7NRE2ouzDWp1wg3V49OX0wrq3n6j73Kekoy9m2d8E8mbitYStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546757; c=relaxed/simple;
	bh=Tr5K0+ObvLmCD70hraMktx2iTgOJF/iJDyq00efKNZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWFwOsQlxvzdCx29rV1dCn7lTF5pagl0Em0eEgGegVnDBmqvBlCeaN93uejc52ApGyH6IhFW6fh4ehRAXCTUQTHyqanARoZEyKH1XmAkX5cXQagg6dzM5LkipqAuEzi3kdGitGt9MRvmX3mjdlgzs2OzgX262CUW679wxn0nvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Io8m8Ghq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471Kw7RM012850
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=Z1YjOyzHoMbwg3f8k3tFP+P6cS
	NDxswrU8b6CwmKv/A=; b=Io8m8GhqJEPOYYs9DTnQu5E7bOrj7vc26OTMXUelQE
	xZDqwpOztfBh4yt8yq7il6JxwpjQWRbJ0AF0u4OV7NwVhSVCN6+bk4YwmNnFufbH
	27MyLCLg/Ac5JnILjwR2kx4Il6gEISVAUVLClObrNS9ADJMcJFp+6ebV8poKpMn9
	Vkihmf6xGGqFRmO0ewFjw7zhNbvIArK7+2W7wvKOhqvteZ9EU9QWdGmxjV9wFawE
	71XtHIEPCY05xZZBqBdM3V/PKhee1ltDsqMd9zBg79XdNRkVlNRmG7S0TOXFZrW6
	nbuUQ6cvcj2zEbUg1NEQeJl3aQV13rCNYk+2Brpsaxtw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rhe602n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:12:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471IVEr7011143
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:12:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn3upc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:12:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471LCPCg7537302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 21:12:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF29B58063;
	Thu,  1 Aug 2024 21:12:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86BAF5804B;
	Thu,  1 Aug 2024 21:12:25 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.139.48])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 21:12:25 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next 0/2] ibmveth RR performance
Date: Thu,  1 Aug 2024 16:12:13 -0500
Message-ID: <20240801211215.128101-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6LRVcQphM3zj58WRmi9wM9GE1MeUtOs1
X-Proofpoint-GUID: 6LRVcQphM3zj58WRmi9wM9GE1MeUtOs1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_19,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=357
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010139

Hello!

This patchset aims to increase the ibmveth drivers small packet
request response rate.

These 2 patches address:
1. NAPI rescheduling technique
2. Driver-side processing of small packets

Testing over several netperf tcp_rr connections, we saw a
30% increase in transactions per second. No regressions
were observed in other workloads.

Please let me know if there are any questions/concerns.

Thanks,
  Nick Child

Nick Child (2):
  ibmveth: Optimize poll rescheduling process
  ibmveth: Recycle buffers during replenish phase

 drivers/net/ethernet/ibm/ibmveth.c | 172 +++++++++++++----------------
 1 file changed, 75 insertions(+), 97 deletions(-)

-- 
2.43.0


