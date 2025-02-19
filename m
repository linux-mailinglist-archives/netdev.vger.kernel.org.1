Return-Path: <netdev+bounces-167894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B2AA3CB26
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F7B3B35A6
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA2254AED;
	Wed, 19 Feb 2025 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S7GPdm1o"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAF25334E;
	Wed, 19 Feb 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999504; cv=none; b=j6xSE7znIQBZNeKLJUvFbpmgKtFmG/qCAN+htxW9dbAOP7mK3Txpw/OkSihGCS7KAmWh1jqWm0Dq7p3tAewylD4ZC20we8tP2c7FIU1HBc1iFJp9HcTKVJ0cVfxdJeAYglFdJKLNC6liocnZwfikNrrebo+nDHIFL68zkVL7gSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999504; c=relaxed/simple;
	bh=PmoC+i0YxAQIPqJ9b7EIKVRSdP0/qmTSG3ODXrcWuAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ft/Zs8E1ZlD9Laz6ggnhbQVG20Qn6kqrE5blO7ypsCY6J/bHFRkB78ynPcWrWdd+hmVFCeY8v6nRGOsAWSyPJqiqJ5xhSiRH8j6A/fVd3a1m0rVVDjZPjlBkD4vc6/MbPC/PnDYrAkVMrASwi0YC5JEDr1sVmlwpH9PLbysr2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S7GPdm1o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFdPtN001659;
	Wed, 19 Feb 2025 21:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/5pFPpwlGeDZA7LwOsaraBsXb5yQCmY13xNzaSTKa
	y4=; b=S7GPdm1ovc53b8XeHN76G58d9fds+GbNq0Z03RGXf55OYxk0EsAC/ubrb
	awg7fs+hmC3RyNc5UyzlAx/kbDRYLFdxEUrX76Klok1ViHp5/O0+PwGz1JpkkicX
	UK2IUII//dTcTr5LXIcak/o/dquAlN89jnEApZJXyEEfkCG98aOtNLNTTik8uP6O
	dZGxdiwVh+7kQ/3kM/P2ugDDfAXlnN1JdGr+w2GjJE+Scogqzpu9hOTnAYf2NvF0
	q/qb+ynZhzaUmhxBFOC/EWw7vHSVw18jNH/QD/Gsf190acnKGsb3/fVO4TrP0HT7
	CVMhwjBSUPOmaiqFP5qkTNs+7Obew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wj4thn2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JL6iIi032018;
	Wed, 19 Feb 2025 21:11:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wj4thn2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKtuhD005817;
	Wed, 19 Feb 2025 21:11:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xe9cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:25 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JLBOTr16384724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:11:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D24A5805F;
	Wed, 19 Feb 2025 21:11:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3AA958054;
	Wed, 19 Feb 2025 21:11:23 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com.com (unknown [9.61.179.202])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 21:11:23 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
        david.laight.linux@gmail.com, nick.child@ibm.com, pmladek@suse.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 0/3] Use new for_each macro to create hexdumps
Date: Wed, 19 Feb 2025 15:10:59 -0600
Message-ID: <20250219211102.225324-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P1LJ6NX2O1acrhWxbM7Jesjq_0kdOnow
X-Proofpoint-ORIG-GUID: MclHQAyOKws6i7Z7NSyKlZ7NHcXAPjbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=839 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502190158

Currently, obtaining a hexdump can be done through one of the following:
 1. hex_dump_to_buffer - takes at most 32 bytes of a buffer and returns a 
     hexdump string representation
 2. print_hex_dump - prints output of hex_dump_to_buffer iteratively over
    a large buffer

There is no functionality for iterating over a large buffer and receiving
the string representation. It seems most users of hex_dump_to_buffer are
calling hex_dump_to_buffer within the body of a loop which iterates
through a buffer.

This patchset creates a for_each macro that accepts a buffer and fills
out an output string with the converted hexdump. This loops over the
buffer and takes care of incrementing pointers. Hopefully this makes
writing sequential calls to hex_dump_to_buffer more straightforward.

From a users perspective there should be no difference in output.

The inspiration here was I wanted to use print_hex_dump in ibmvnic code
but I wanted to print through netdevice printing functions to maintain
formatting. Looking at other users of hex_dump_to_buffer it seems they had
similar intentions.

Thanks to Dave, Simon, David, and Paolo for v2 review.

Changes since v2:
 - patch1: remove unnecssary call to min, this addresses Simon's observation of
 gcc-7.5.0 warning. Other possible solutions were to change typing but it turns
 out the call to min is unnecessary since hex_dump_to_buffer has logic for
 handling len > rowlen and vice versa. So we can be honest about the len.
 - patch1: cleanup for loop i increment in response to Dave's review
 - patch3: fix ordering of [Signed-off,Reviewed]-by tags in the commit message
 - target net-next thanks to Paolo's recommendation

v2: https://lore.kernel.org/lkml/20250214162436.241359-1-nnac123@linux.ibm.com/

Changes since v1:
 - add Jacob's Reviewed-by
 - fix kernel doc typo in patch 1 noted by Simon

v1: https://lore.kernel.org/lkml/20250113221721.362093-1-nnac123@linux.ibm.com/

similar intentions.
Nick Child (3):
  hexdump: Implement macro for converting large buffers
  hexdump: Use for_each macro in print_hex_dump
  ibmvnic: Print data buffers with kernel API's

 drivers/net/ethernet/ibm/ibmvnic.c | 23 ++++++++++++++---------
 include/linux/printk.h             | 20 ++++++++++++++++++++
 lib/hexdump.c                      | 11 +++--------
 3 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.48.1


