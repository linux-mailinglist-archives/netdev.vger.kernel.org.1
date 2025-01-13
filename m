Return-Path: <netdev+bounces-157910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500D0A0C47A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51609169D26
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C91F9433;
	Mon, 13 Jan 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QecwLVbg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE01E3DCB;
	Mon, 13 Jan 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806654; cv=none; b=jsJLiKqskoorvF7b5qu0efInntYD53gfcAAk31CiMGFlzNU+wiP5yN/yobQQaAwOLHGQNpb5oY50PH5k2HBfXdPJiEh3wXm4VtLE0Jt1RKtsLmhckUVI4nFl21cabD0KG/0pD/nAPXTM6JGvdiQ+6pBn/suOmRYWwSgungp3F74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806654; c=relaxed/simple;
	bh=otPaKT3oE6Oa2WvKYaED6FaoqDqhU95SE9AjCgwz+QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3n8r4NOSpo2QlgQAAJl5ck2Rf6ikeNo1z8LSUdf/8KIDyCeuG0tJRF0xsCNB65GREACeykww9nEkSvPptLq0ZfdoXKOnoQNMQBMMIyCcEEAqkA01q0BF4bxrMgR+PaLva+iwjKQ1wZOUA1lk3wV+J2WEPsk4+ZZwMgNyvE6oiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QecwLVbg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHWEkI000480;
	Mon, 13 Jan 2025 22:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=arRBEmzv5Tp7Ml5eh5fRemUqxR7Uoq/BO6iqYGOSj
	HQ=; b=QecwLVbgzVwNbr5blca7yM0A2iLv7EikHaeYSqWgrIm5M2S4gtvUgBENm
	Dax4DyHhu1uwMhW0YEjXuHchz6dO8yrpBnVyQw8Cml2BBYHLdf1SWituLJHuokoz
	EAti/suikxDc5DzacaUlrL4W2xjIUXjLH9EufBS5HIowBSK0GyCQLxjoUkpiR2Pd
	mF7R6u4Ey5z2lIcf+CgY3vMgqydn4Vh/DIMLaG2+rhE3dbRFiqKQ/PjIFCyB2jmG
	pnWyRTS/nzD3xLkQpY0TgHJvkL3HgcHM7HUEARZUn4TMNpEmzl/H7iZhg1aIAU2X
	8TiSh1Y42tWYHVRfahSis1vLDUNyA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444y12kj9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 22:17:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DLPrGc001108;
	Mon, 13 Jan 2025 22:17:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456jr3bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 22:17:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DMHQjo31457936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 22:17:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF28C5805B;
	Mon, 13 Jan 2025 22:17:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0285804B;
	Mon, 13 Jan 2025 22:17:26 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com.com (unknown [9.61.148.44])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 22:17:26 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: nick.child@ibm.com, netdev@vger.kernel.org,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH 0/3] Use new for_each macro to create hexdumps
Date: Mon, 13 Jan 2025 16:17:18 -0600
Message-ID: <20250113221721.362093-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CWkARnLXQcB5zODdw5SQSy0t2XrVAlvo
X-Proofpoint-GUID: CWkARnLXQcB5zODdw5SQSy0t2XrVAlvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=921 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130170

Apologies, not sure what mailing list/tree to target. First 2 patches look
like *-next and last patch should go to net-next.

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

Side question:
  hex_dump_to_buffer automatically sets groupsize to 1 if user given
  groupsize is not a multiple of len. When printing large buffers this
  makes non-uniform output. For example, this is a 31 byte 8 groupsize
  buffer:
   ibmvnic 30000003 env3: 6c6774732e737561 2e6d62692e736261
   ibmvnic 30000003 env3: 63 6f 6d 00 03 00 05 65 6e 76 33 00 00 00 00
  Since the second line is only 15 bytes, the group size is set to 1. I
  have written a patch which keeps groupsize so output would be:
   ibmvnic 30000003 env3: 6c6774732e737561 2e6d62692e736261
   ibmvnic 30000003 env3: 636f6d0003000565 6e763300000000
  But since I am not sure if this would break some dependency for someone,
  and my justification for change is purely pedantic, I chose to omit
  that patch in this patchset. Let me know if there is any interest and
  I will send a different patchset for that. 

Thanks for your consideration/review.

Nick Child (3):
  hexdump: Implement macro for converting large buffers
  hexdump: Use for_each macro in print_hex_dump
  ibmvnic: Print data buffers with kernel API's

 drivers/net/ethernet/ibm/ibmvnic.c | 23 ++++++++++++++---------
 include/linux/printk.h             | 21 +++++++++++++++++++++
 lib/hexdump.c                      | 11 +++--------
 3 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.47.1


