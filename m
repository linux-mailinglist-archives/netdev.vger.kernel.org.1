Return-Path: <netdev+bounces-150140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37409E9223
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F431885B8D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BA21A951;
	Mon,  9 Dec 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZJNyK8U5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57E21A93E;
	Mon,  9 Dec 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743633; cv=none; b=W1gqGNx/Z00NrP0nYGZIGgovJ9BsKjtBSa9eMZm3TEd1hvQUU+NxzwxzGPiDHcGPGG8mCDD4sD2NJNOaWAM4f0vnykyG4VOB+fu2LMo5cYEl9giFQ+ph5iW8lC0P2voxW0DERW2aJpwuVZXGCc4dOz51zX4vv3ziZuiZ34yITV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743633; c=relaxed/simple;
	bh=5kAsIsrtlfuGTm/bEhkcn9of1LNX7krnEZlj5KO/lfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=obhqahu2eFgPsvSH8qQTt/en9b6DKuX9pOsKAoDEfa8XOdBD/TUDXMoebK+fUsTrZXfM8ceUqj7jRA6iGyoV1S2Uz0wKCfDUnbADqfUeKVjwf91n2aLympt1kLcrKewS24YDJnMu13al0tn9iFh6MREA7R16X3g2ZySByU0+iag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZJNyK8U5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8LtOeR028746;
	Mon, 9 Dec 2024 11:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6XsX4n18k66gRAYyHoQrPh/Nuqak
	/pwxNZaaUKLnsZI=; b=ZJNyK8U5WuNT++uqrYsh5IB1w6DRvKIKsM5WksffDDU1
	KrkaHZ6UOl5SnWz6b1dcWvPwFsvtzBnD4IdrAfgkRLQjnaEWXN8VldUJDP9UuhfC
	mJ2treqaEgQQyxm5bp/rimBBYishjiRHOuc/LNOpxFe4hGSXHl4pSMHORmTNYCtM
	i1NWjRlEL/a4n+XHni3a5ES00BU0n3w8JDch6tIDVYUzBEuq5iQ2HWIXYi7LcyB7
	BEt2XR3sKimZBzBh3kqIu+ARKsyHyben8CI8uPccXw+qplaGawl1rSwUrE04c4nM
	hWKbYb9RikBS+VQ264w9Pt465F7i2FjYaeZ9wODe4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsj86m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:27:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9BMPlO011368;
	Mon, 9 Dec 2024 11:27:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsj86m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:27:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AChfE032575;
	Mon, 9 Dec 2024 11:27:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pmxb9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:27:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9BR18j32309912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:27:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF42258055;
	Mon,  9 Dec 2024 11:27:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E07325804E;
	Mon,  9 Dec 2024 11:26:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:26:59 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 09 Dec 2024 12:26:50 +0100
Subject: [PATCH net v2] net: ethernet: 8390: Add HAS_IOPORT dependency for
 mcf8390
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-mcf8390_has_ioport-v2-1-3254267dc35e@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAPnTVmcC/32NWwqDMBREtyL3u5E8TH18dR9FROO1XqiJJDZYx
 L03uIB+nhnmzAEBPWGAJjvAY6RAziaQtwzM3NsXMhoTg+SyEJLXbDFTpWrezX3oyK3Ob6wczVD
 pXouSG0jD1eNE+yV9gsUN2hTOFDbnv9dRFFf1zxkFE2ySdzXqUqEs1ONN9rPnNCy5cQu053n+A
 CfRRli9AAAA
X-Change-ID: 20241209-mcf8390_has_ioport-7dcb85a5170c
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=5kAsIsrtlfuGTm/bEhkcn9of1LNX7krnEZlj5KO/lfA=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNLDLv++opB7f+IMB/NYoawu50NbymNlRAS2ptfm5mkdv
 t1/pFOyo5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgImI32D4X/DEI/Nbv+OCvfvC
 unYHnZ++M71cUG6/nfYc+ZktHrl/7zIyHAmcXGi12emWQ0pLMWfkT+fX3H4JX37z7DGa/1/9/MY
 MDgA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aMlxx1DiQJnoOfKBf4D1Y4oMDeGrnLti
X-Proofpoint-ORIG-GUID: eqK2dz6w1ZX8wWAq40W120ARCdbo-xkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=720
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090086

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
Changes in v2:
- Add missing "net" prefix. Sorry about the noise
- Link to v1: https://lore.kernel.org/r/20241209-mcf8390_has_ioport-v1-1-f263d573e243@linux.ibm.com
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


