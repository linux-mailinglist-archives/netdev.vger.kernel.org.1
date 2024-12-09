Return-Path: <netdev+bounces-150125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8053D9E901F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5BB1884FFF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0D2165F5;
	Mon,  9 Dec 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RSvnD6ig"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAF216380;
	Mon,  9 Dec 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740117; cv=none; b=sctZ/QijBIeNztFTSz7euodqQxgmxBZLXteCzTlflwpdC8vHyS2Sf7wGaDt5wSRjSUaj3aJYeQonkZ1AdqGyZvfYp3SA/gU67r7s9+Zm4BxTzYZh/A4zBe+uxJT3V0TYLF6fOJ3XlBLWSU7uCsLWyVAlFsdNYMax7KNOjxJuNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740117; c=relaxed/simple;
	bh=2rwkr8VeDzByDBZGpYZoDTrR1oxX145BEsFkGtK1PH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LlUu4WME6wePOyz1574sBp8aLtDwOOFCIHPkKkV5alYNcL11J3sTtvOpTgKV0OuhapMlQNLCC27oNtyhHa1riCltKHl9kArwAUxgI2+b1WVizYyWT1Csv0X7Q+zn+XoEk9xIv0vvWDyxVzz59Ud+NLzNHBo8NnKwSjsaWF0SEpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RSvnD6ig; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AHY1i002320;
	Mon, 9 Dec 2024 10:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=vhuftYfkSdQcWlAg8B4/iwLLXDaM
	P6B4MuhilJfNZgE=; b=RSvnD6iggUfdQS/1yQ/AIrU+/VlDK2IGD8s0JzukDiTj
	/QVAWnzrnbSW9BLKqPm2sU8UbUaY0+Q8aYOiHiwrRi864jAFbZpIJpWta9G4cew0
	gZJGVlZJyphVqAy8f2q+yK8Yfxk/4M9Ng2/70XYACXrvDvNu7M3NYXJA336PSCxz
	zpQxUHO2sT8yzzrD+hU4GH5JM2pTmsGhvxqwVKvP28U9vFWSNOOiTD5jgValM6eY
	dbJZwSLBkkxhKZIG9tCLhWwPWucwfx1rogf7RYvo1e/HPYPmZrJ6AG8LWEeBrg4p
	qXyQ4sN96b9HFEUTm9rjCZWnm8oV8FYR7HBVV3ewjg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vgpxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:28:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9ACS3R029316;
	Mon, 9 Dec 2024 10:28:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vgpxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:28:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B97mZCr017364;
	Mon, 9 Dec 2024 10:28:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1dsey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:28:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9ASJpe29688438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 10:28:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7EF758053;
	Mon,  9 Dec 2024 10:28:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AA8458043;
	Mon,  9 Dec 2024 10:28:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 10:28:17 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 09 Dec 2024 11:28:03 +0100
Subject: [PATCH] net: ethernet: 8390: Add HAS_IOPORT dependency for mcf8390
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-mcf8390_has_ioport-v1-1-f263d573e243@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIADLGVmcC/x3MQQqAIBBA0avErBPUCq2rRIjZmLMoQyOC6O5Jy
 7f4/4GMiTDDUD2Q8KJMcS8QdQUu2H1FRksxSC5bIXnPNud103MTbDYUj5hOphY36852QnEHJTw
 Serr/6Ti97wf4qtOTZAAAAA==
X-Change-ID: 20241209-mcf8390_has_ioport-7dcb85a5170c
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=2rwkr8VeDzByDBZGpYZoDTrR1oxX145BEsFkGtK1PH8=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNLDjpk/fVr1tsKSNSVdzmnn/2V33B7M5lH9H+Gh5X5r/
 c3OQs1THaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzEdCnD/5DHoRVrWnZ5dcV4
 3tfbJsctvCFKyv5QSO7bl+oTGr08Shn+l2RO2uefZXF/Yp+F7NdFiwS77Oa1lgpvmXZlt7sEl9U
 EHgA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _fSFbHkQVgRDwUpOIitBanAy28Vw7hbx
X-Proofpoint-ORIG-GUID: -yl5drc7EgQmgyyfmqNxE78OqFiyS1dL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 mlxlogscore=574
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090078

Since commit 6f043e757445 ("asm-generic/io.h: Remove I/O port accessors
for HAS_IOPORT=n") the I/O port accessors are compile-time optional. As
m68k may or may not select HAS_IOPORT the COLDFIRE dependency is not
enough to guarantee I/O port access. Add an explicit HAS_IOPORT
dependency for mcf8390 to prevent a build failure as seen by the kernel
test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412080511.ORVinTDs-lkp@intel.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/net/ethernet/8390/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/8390/Kconfig b/drivers/net/ethernet/8390/Kconfig
index 345f250781c6d9c3c6cbe5445250dc5987803b1a..f2ee99532187d133fdb02bc4b82c7fc4861f90af 100644
--- a/drivers/net/ethernet/8390/Kconfig
+++ b/drivers/net/ethernet/8390/Kconfig
@@ -87,7 +87,7 @@ config MAC8390
 
 config MCF8390
 	tristate "ColdFire NS8390 based Ethernet support"
-	depends on COLDFIRE
+	depends on COLDFIRE && HAS_IOPORT
 	select CRC32
 	help
 	  This driver is for Ethernet devices using an NS8390-compatible

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241209-mcf8390_has_ioport-7dcb85a5170c

Best regards,
-- 
Niklas Schnelle


