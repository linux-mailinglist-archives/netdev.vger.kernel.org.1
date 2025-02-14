Return-Path: <netdev+bounces-166501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DD1A36300
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F16216B50E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2BE2676FD;
	Fri, 14 Feb 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E0q3Q8fe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF292676CE;
	Fri, 14 Feb 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550300; cv=none; b=mXGGbBPsee1DqUmlCpsepLvT1YWj8+Q6aU5OEY4kDUC4EI14RSVoBFAV92GfvvN6oJ8qpvs0QrmquZQQ+jBBp4mCMw4/zSYFLGu5xMxfuP73SC43goKHUiep/G3yKgGDldJ5K+UfHdT+5JGtvQoZluoyHKd0lnKI8skRqcCoR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550300; c=relaxed/simple;
	bh=LsWihSEDqmW2ynjjlF9YkNchxOjrOyCby77qfHSZnAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcXYlBe3TIep3SEwB0bHY+yiXz6KvbVDBMWEvx9kMlSLa6aQE4gnLVEBAu1wwafv/CLtuDwJB8VSOwFncdAa3obXiuVh2SlqAuDIdhHf6NEkVVNGHtGIiFyHPAUeFcQ6ieammrDEY/I5gmGn5WL7ec+dXi7/zr8Vkc5utiT8HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E0q3Q8fe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EBAgNh000518;
	Fri, 14 Feb 2025 16:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pjx1l8vRjPsMgVy1+/X/PVrWefQm6fL9MGARtv2sl
	sE=; b=E0q3Q8feKaa3pljJhfPXsUbOo13cXTtao9KoK0GTGC8j2igNhANF1ZzWY
	fIvhpV3kFCMzoby9A7MS/wzPUQItHsikqq+QdyLq0+1txJfivg8NFP/b5OuEyCpb
	rJWfjIuxf5++BrTVNDLsQ8MLrKIzi7j8MxSjOkpuwv208yhf3f+pVxRYhIU9nrR5
	TGrk0NQ4ytqH0UziW1Ul3iBTjZIGbG55gBkpao0gVeppYt8NnuDbFoTK7DHZbQJG
	L/z9bR3DY2boab7c8Egg5zhBjXWtQxSDASd3kg8TwWROJFJs9AyQDKcETZ9okuWt
	vIxtcovDmXMadYjKFCOLCsd8sptnA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvacbbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:24:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFWsLH016752;
	Fri, 14 Feb 2025 16:24:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pk3kmd4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:24:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EGOpZY27329042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 16:24:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6485F58056;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 352C05803F;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.lan (unknown [9.61.91.157])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, nick.child@ibm.com,
        jacob.e.keller@intel.com, horms@kernel.org,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH v2 0/3] Use new for_each macro to create hexdumps
Date: Fri, 14 Feb 2025 10:24:33 -0600
Message-ID: <20250214162436.241359-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mIdPVQ06Q4rkXpArDOB5AZYYNaCAvUFl
X-Proofpoint-ORIG-GUID: mIdPVQ06Q4rkXpArDOB5AZYYNaCAvUFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140114

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

Thanks for your consideration/review. And thanks to Simon and Jacob for v1
review!

Changes since v1:
 - add Jacob's Reviewed-by
 - fix kernel doc typo in patch 1 noted by Simon

v1: https://lore.kernel.org/lkml/20250113221721.362093-1-nnac123@linux.ibm.com/

Nick Child (3):
  hexdump: Implement macro for converting large buffers
  hexdump: Use for_each macro in print_hex_dump
  ibmvnic: Print data buffers with kernel API's

 drivers/net/ethernet/ibm/ibmvnic.c | 23 ++++++++++++++---------
 include/linux/printk.h             | 21 +++++++++++++++++++++
 lib/hexdump.c                      | 11 +++--------
 3 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.48.0


