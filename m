Return-Path: <netdev+bounces-162153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0199BA25E68
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A7F16BA4B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033E20B200;
	Mon,  3 Feb 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q/zdFTDm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68C20AF95;
	Mon,  3 Feb 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595604; cv=none; b=bzvpO74JPKU+04xlVeYno3IiUU7k1RctnNg3kqw1k5n/DJZHLUh4XkNBOiqmMgAQpekb9RJ15I6rmzftfFUV7juyIDisUYtkNJtEMcvaGIPk35NGpHB3fzqT4Wx1BXAOuNKeYHQXsVUSgfSwACDpihAY8nvxA2QzW86cA82K1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595604; c=relaxed/simple;
	bh=4HCs6OFZWMXIhTxw4czDcvPojN7671mjOsnj6eA6SlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UIsqodLQRWma1LQf8h3b3qDMHpuZsabmgi7drw3K62up4/fEPB8f6H43bAJPjhCyJLsRanOq3PhGHodgU0JRdCIrgIQuMjMvFAJAIsA0j3rGf3vvZsgmWwd4or+WGisgpuaJVw4K8ot1tubsV/IbPdz9HBphAJXD5rXHUgGj0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q/zdFTDm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137Wpdf014517;
	Mon, 3 Feb 2025 15:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GnZSA81vFyz6mQj6HOVF+YCcu2rgvLk4RSORNs/b8
	mc=; b=q/zdFTDmPMhFTcf1eTQHK4tOKTaP0hMAYit3z/UBzgTZlLMprlVcWv/cZ
	M2s2u9/u5Q33CvBUgXK3JAGr+iqIEf6O+OehYje74hgejuXVO3qbhw4VM2vjKASz
	Qg5DscfIjXbaTP51D/fg/uQcdRq6KL9AeyVa6NVfjV1Td2fnEao3HVoRDYyr4is1
	hm5iGBqNu+KpxOpkmx0RF1HHhDO+jAzlOt9piKrXv2AEZiV8m5HppzlWcc9iEv4C
	8AItQO81v9es9+AOTdsWHHFaapJpm3FiCHso5Y1ruuM0uN7akUQ7tGcnAUuxcU1e
	Q9GoijWYlfzOdMMy36woC0xP71Z1g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgnj38n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:13:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 513F8mLw002595;
	Mon, 3 Feb 2025 15:13:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgnj38h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:13:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513D3VMK021486;
	Mon, 3 Feb 2025 15:13:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n16kh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:13:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513FD8fW21627588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 15:13:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABFDE58065;
	Mon,  3 Feb 2025 15:13:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC5B58056;
	Mon,  3 Feb 2025 15:13:08 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 15:13:08 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, ratbert@faraday-tech.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1 0/1] Document phys modes for ftgmac100
Date: Mon,  3 Feb 2025 09:12:54 -0600
Message-ID: <20250203151306.276358-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WTOSwCyHZ-zAh-AxMtKnOMoOODplOrzq
X-Proofpoint-ORIG-GUID: SjiK9Pdka_G6DROcrAzgWnkDALd1CxLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=943 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030110

Hello,
Please review the documentation changes of phys modes for ftgmac100 driver.
Initially I sent it with follwoing patchset:
20250116203527.2102742-2-ninad@linux.ibm.com

Rob Herring ACKed it. Andrew Lunn asked me to send this patch separately
to netdev.

Ninad Palsule (1):
  dt-bindings: net: faraday,ftgmac100: Add phys mode

 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.0


