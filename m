Return-Path: <netdev+bounces-197555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A2AD925E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA161888ED3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE2B1FC0FE;
	Fri, 13 Jun 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XyInHlu3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A561ACED7;
	Fri, 13 Jun 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830568; cv=none; b=pvxXLrQinWhQKR7U513DnpC3Yi3LXirDCrgN/zcpoQXDExfczM6HuHKs8VPlZXJSYOWswBy8wrYRJs5weFkbTnyVFbm1wQPrcpfzEfSC7JIUVV8uWupyvu5ANFziQxZa3XUEzZ/SZI+ZiKC5xTTPjPjbfcKVHjPu3shSoDKUaho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830568; c=relaxed/simple;
	bh=aDVEjclZHq3dM+hdgbvjUwy0ua5O04khGzKkRZzx15A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ikvtrc+jykGnM188iGp8lO9HJOCMB9U4F7gNzwWo+VQCuI+psiiByJA4FNcq2K/bz7aaeqUrxYsB99v7Qf7m1bGKyWdznT/2UGg1KwkFeD9Q0j9167WAwB3SnoZ9VW5tyu0q/Jteov1GFh2XydgF8zD0wx567yhMx2u2gr9PrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XyInHlu3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DDVaUs015720;
	Fri, 13 Jun 2025 16:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=/0DCRS7jNv98LWVt8rDe+WfVDZJk
	1RBINBRtUHWV9ZI=; b=XyInHlu3ttSD6jbBlwY3UkaxuYfBX3zUw8dfuU+NHLo6
	lPkrAPt10A08m93eB1L6kQSbt1Ck0xkHSM9jTsxLJQgPIlctHPM8+YpfCk4YphlG
	OkgJaBbGfLx4TNeTfImXZ6zqZF53c7FANWHY0E4rn0MtSUQP3eQkZrwEngCAtmJi
	pRz58njk6nFzBnKexvS/TkjD0ztVcel64A7x+3pA8oX3fGx+1tyklY+U6FD8urKA
	L25wW15Ik/kzmjzGlCjZiDk+JAByHIuu/BNpdplzCsE9ywffdVR++grkqMViVXLA
	Ms8oTvnsrb5m6SiqtPd1Rr0S7VwDkGpUncYDCRzZWg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mq41j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 16:02:39 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55DG2cfB004609;
	Fri, 13 Jun 2025 16:02:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mq41e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 16:02:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55DF0Txr027957;
	Fri, 13 Jun 2025 16:02:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mtpjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 16:02:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55DG2bI533686194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 16:02:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0801658043;
	Fri, 13 Jun 2025 16:02:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 658B758053;
	Fri, 13 Jun 2025 16:02:36 +0000 (GMT)
Received: from d.ibm.com (unknown [9.61.41.78])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Jun 2025 16:02:36 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
Date: Fri, 13 Jun 2025 11:02:23 -0500
Subject: [PATCH net v2] Fixed typo in netdevsim documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-netdevsim-typo-fix-v2-1-d4e90aff3f2f@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAI5LTGgC/1WMQQ6CMBBFr0Jm7RCmFYmuvIdx0dJBJrEttkgwh
 LvbuHP5Xv77G2ROwhku1QaJF8kSQwF1qKAfTXgwiisMqlFtcyKFgWfHSxaP82eKOMiK1mrSTp8
 7ZR2UcEpc9O/0BmUP9yKHFEsyJjZ/f9Tq7qhqIk0NEjqzsDfpdX1KeK+1WF/30cO+fwGD0Y4nq
 QAAAA==
X-Change-ID: 20250612-netdevsim-typo-fix-bb313d3972bd
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=684c4b9f cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=CYWh4jdgKPvq9Fx5Vf4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2XLPBnR0vTB3q8tv2mnj9EI3h-zE20TE
X-Proofpoint-ORIG-GUID: 1AaA2ISEQQJ8NUth1v7qlmgTKT_UGeMf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDExNSBTYWx0ZWRfXy+u9k8mfdz2g 12mnEKj3oGRVHvNFRxfJZo1tOHtsHzfv5pIet1UYlUgJpLidJS+okPhCh8d8tAgaURGE21Jz159 28LKIRNei/qIpejgodUR46XXS+mthpArCR6Kjlz17dCHB7tHLcrXi6uKqvkjLa8zvSEgihI0T4H
 qBsDyJ7ELcJVMtoxIZdT+A262z2027WMBoStQ25EVe59b4Fc8ReQxQBtdsQqk8Mn/Ki8TrEFpsB PBSkvCVwyyTqPDxtG8BWKrn0YhjJl+acHRdEEb6A84tv50Am5p5fkUtCw6LQLP0Y9ys1iBoGg6b EEV8cLvlGgEG+gtQhGoXXX8GOHZo4sKpjrxTrmpjgesy7Y2yyhSBq58UPMbgXZZhtI2oERCQDNn
 m2CcI1Gt/5mlXMnTMnx/JcYIJweRNNEnvpAzyhnqxNomm4YSTpJ36AtwFbUlrsv4lSOOG+Hy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=976 spamscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130115

Fixed a typographical error in "Rate objects" section

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
- Fixed typographical error in "Rate objects" section
- Spell checked netdevsim.rst and found no additional errors
-
---
 Documentation/networking/devlink/netdevsim.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/netdevsim.rst b/Documentation/networking/devlink/netdevsim.rst
index 88482725422c2345adccc0f04d2566fb5ba5ef6f..3932004eae82ce125be7f8380975c43b7175422d 100644
--- a/Documentation/networking/devlink/netdevsim.rst
+++ b/Documentation/networking/devlink/netdevsim.rst
@@ -62,7 +62,7 @@ Rate objects
 
 The ``netdevsim`` driver supports rate objects management, which includes:
 
-- registerging/unregistering leaf rate objects per VF devlink port;
+- registering/unregistering leaf rate objects per VF devlink port;
 - creation/deletion node rate objects;
 - setting tx_share and tx_max rate values for any rate object type;
 - setting parent node for any rate object type.

---
base-commit: 27cea0e419d2f9dc6f51bbce5a44c70bc3774b9a
change-id: 20250612-netdevsim-typo-fix-bb313d3972bd

Best regards,
-- 
Dave Marquardt <davemarq@linux.ibm.com>


