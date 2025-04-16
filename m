Return-Path: <netdev+bounces-183494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBDCA90D76
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8696144055D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAC22E414;
	Wed, 16 Apr 2025 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U/gv/Vzs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538C1F585A
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744837086; cv=none; b=Ke5TJON1D1zn2Cw8JXrsEBC5U6LrpyTKDgFQClRfiUJ6uW2OrbrW91OtfpM8sarxVtddgq+1MnVjbRVrGiO82RA3X5J+9RYxYRE83fDjh8Athq/yut/SB+cSotJZSliEz5Id3gBGmV5LJ4ICdC5yY2tE87HQiLwnvhyG7aVwX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744837086; c=relaxed/simple;
	bh=KcwjwOdXOFZ2uC8d2B+n9ZQi0QQyX8P8TaMAGk5KMTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPZ8tVghiDHXRBdIN9Q1tpKxqcG0iIlseevTbzyovtjm5wysRgH49dAN9IhQjcWrzlK1XoYDZraKRLSiwFwiwtDDbygAXst9ag3g8cDQu3XrZ2IPjjlO7UzOVy1cGkVouj3jUFW8QMQpmRk+Thb0/VVYvLaNxHfjFhIvbh609Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U/gv/Vzs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GGOO7w028954;
	Wed, 16 Apr 2025 20:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z3OVOLyfKCMLVdglfMW9yUPuUvtMIDsNWh42JPY9z
	ig=; b=U/gv/VzsPW3GWoZZiLHyTUL9rRdX6CX14d7eHaZoJkrVGTaAnmOr4SPzE
	QfIAoXouxADe349dU+QDubXY38njCqgGVn25a7Cs2jrus6DuAZlLE1Zily2GkV/L
	IDlGLDLgHZ+JuzF5NyEnUiwjTwz9yoNYB1T5KrwJMOdi9edl1KDJNAaa+giyJKeD
	FciS7tgKdwi/bE8UbTn7WCI3p9JV623FPyiIV8Kvpa+YGLNRhEMCTORgVl6j8j/y
	3XfSVyXf170BUjfKaGXZSlMWFeBFX16znp+6moV4e49ALKOMg467jlAVh1J1UZF7
	VR9b5Ei0ZCgonp4OsF+jBbWjvSTHQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462affbc9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 20:57:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GKCWNL024882;
	Wed, 16 Apr 2025 20:57:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtjmyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 20:57:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GKvtPL27132168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 20:57:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9714E58058;
	Wed, 16 Apr 2025 20:57:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E00858057;
	Wed, 16 Apr 2025 20:57:55 +0000 (GMT)
Received: from d.attlocal.net (unknown [9.61.183.42])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 20:57:55 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com, horms@kernel.org,
        Dave Marquardt <davemarq@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 0/3] net: ibmveth: Make ibmveth use new reset function and new KUnit tests
Date: Wed, 16 Apr 2025 15:57:48 -0500
Message-ID: <20250416205751.66365-1-davemarq@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: En7UeUUHKYq9QAiPzlK9gR7zYXjJB3Zq
X-Proofpoint-GUID: En7UeUUHKYq9QAiPzlK9gR7zYXjJB3Zq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 mlxlogscore=800 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160164

- Fixed struct ibmveth_adapter indentation
- Made ibmveth driver use WARN_ON with recovery rather than BUG_ON. Some
  recovery code schedules a reset through new function ibmveth_reset. Also
  removed a conflicting and unneeded forward declaration.
- Added KUnit tests for some areas changed by the WARN_ON changes.

Changes:
v3: Addressed Simon Horman's review comments
- Reworded commit message for ibmveth_reset and WARN_ON changes
- Fixed broken kernel-doc comments
- Fixed struct ibmveth_adapter as a separate patch before ibmveth_reset
  and WARN_ON changes
v2: Addressed Michal Swiatkowski's review comments
- Split into multiple patches
- Used a more descriptive label

Dave Marquardt (3):
  net: ibmveth: Indented struct ibmveth_adapter correctly
  net: ibmveth: Reset the adapter when unexpected states are detected
  net: ibmveth: added KUnit tests for some buffer pool functions

 drivers/net/ethernet/ibm/Kconfig   |  13 ++
 drivers/net/ethernet/ibm/ibmveth.c | 241 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmveth.h |  65 ++++----
 3 files changed, 268 insertions(+), 51 deletions(-)

-- 
2.49.0


