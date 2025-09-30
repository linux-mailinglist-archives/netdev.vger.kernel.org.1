Return-Path: <netdev+bounces-227404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8EBAEC9A
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1300E4A3D92
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF52D3217;
	Tue, 30 Sep 2025 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pG6ZjZnk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B92C11EA
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275546; cv=none; b=RmRwMuYuYST7DUn0lemf4QelgxXVvK0idB9vrA6Yph3JEyjW5BEaHHYANapjuXvERFpv8G5kRlX6SzYEel/HdZDFrmt0Hdma2N5Qi+iNga/lq6d18Bz7fiVS8aP/RMaNf0DSDy+qP3cFfbNOjrxEa6inhRUiiIpqDIg4tHi9Ues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275546; c=relaxed/simple;
	bh=8Kpl6hx8Cv8z6i5PE12EBxs253An2iAGJOjhj3NcToA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9tLZ4HdmfDM9gZFg+hHK83TsHD2vZIwJCoe/oszialkOw8yfduylsXr1NyIStunAaQyaZe6JzV01kpStAUQH3x6pmA1uS9ZrmpZLi4+iBbooOicajikQTOXAG4laA47Z28heXJEWorDz24gLFj//Cg0yx1W0S6ZX3lJlDspYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pG6ZjZnk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UH8Xw9031961
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ICk9nDPphWyHhH5W+
	z+GLuWpol1yXkeeteqskEWs5TM=; b=pG6ZjZnkq7sNlvjYiu9F2TN+/7ZiL4GwP
	fbVGJvOTTf0/8SwmlmVXAhReXr/LSs69pJOlK6RUATyZBKfEr4Btmh8uDUQl1+0I
	fzufGY73nPGfAsE3BAjiLs67SZNt5ibGIbI2pSNj97lkENDruxFzJ3H0OeGmEdEh
	i5wCb+OMcmjWrn06DyX5Mawp46+06BPV8P94w3sUEOgkthZiQEdIIUPXzPfdYnlI
	XrQlYlq9Zq0EnzQ0ef5IKBNuOzwwkwJuKpxl3bZiSIVnDw7thVeJTwulPehR33GS
	7oiszI7aFCMw/rsWtkVrt+URVv0Qb2SvjHtohzvTa2EDy3c+hznMw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwkehx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UN4me7026756
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8mx3e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UNd0At59900222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 23:39:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7249A58055;
	Tue, 30 Sep 2025 23:39:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 348B55804E;
	Tue, 30 Sep 2025 23:39:00 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 23:39:00 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: wilder@us.ibm.com
Subject: [PATCH net-next v12 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Tue, 30 Sep 2025 16:38:02 -0700
Message-ID: <20250930233849.2871027-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250930233849.2871027-1-wilder@us.ibm.com>
References: <20250930233849.2871027-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX7X8eJPGgVZlV
 LKdXhRpFwMYfJXtIYtcxW0BeCaKJ+fQtvazGRenPZYR/H9vs/ivG3e3YES9ua8Cf/yLhP6XZFKt
 aanFrSgkayygsV5Tl7HZiznYdjYDKfrlU2Z5nIrKmegtrRmFGQcn/BdPlhI4XdFPc5mI4skCl//
 BTxo3c8H0sElIgII1ct363arwh9q0eayOCiYhl4g+T5smAwzAPzeNdCtFjl2cWV+MQ2zXvGn6ep
 53lfWJVzZbWU/mjIPNa9W5hsmhHDtq4lHBoVcQ0TeaL83Sz6xOH6IJaoljR7exM8EGWUCfRjH4q
 Pz+HqpmYcgE9CwnC+FgFX0pL4wcvWm0joviqV4O7LtSQiiMX0DWh+eVmI+ntXzKRrgVGQa41Uxu
 abK37Pb3piu14woTtdYEnDxr4ParWQ==
X-Proofpoint-ORIG-GUID: 5E_v9tNLWS0AdYyaGkE6_un3fzi_O50t
X-Proofpoint-GUID: 5E_v9tNLWS0AdYyaGkE6_un3fzi_O50t
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dc6a16 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Used to record the size of the extra array.

__bond_opt_init() is updated to set extra_len.
BOND_OPT_EXTRA_MAXLEN is increased from 16 to 64.

This is needed for the extended  arp_ip_target option.
The ip command will now pass a variable length value when
setting arp_ip_target.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bond_options.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index dea58a07e4cc..e3eb5fe6d1e8 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -87,14 +87,15 @@ enum {
  * - if value != ULLONG_MAX -> parse value
  * - if string != NULL -> parse string
  * - if the opt is RAW data and length less than maxlen,
- *   copy the data to extra storage
+ *   copy the data to extra storage, extra_len is set to the size of data copied.
  */
 
-#define BOND_OPT_EXTRA_MAXLEN 16
+#define BOND_OPT_EXTRA_MAXLEN 64
 struct bond_opt_value {
 	char *string;
 	u64 value;
 	u32 flags;
+	size_t extra_len;
 	union {
 		char extra[BOND_OPT_EXTRA_MAXLEN];
 		struct net_device *slave_dev;
@@ -169,8 +170,10 @@ static inline void __bond_opt_init(struct bond_opt_value *optval,
 	else if (string)
 		optval->string = string;
 
-	if (extra && extra_len <= BOND_OPT_EXTRA_MAXLEN)
+	if (extra && extra_len <= BOND_OPT_EXTRA_MAXLEN) {
 		memcpy(optval->extra, extra, extra_len);
+		optval->extra_len = extra_len;
+	}
 }
 #define bond_opt_initval(optval, value) __bond_opt_init(optval, NULL, value, NULL, 0)
 #define bond_opt_initstr(optval, str) __bond_opt_init(optval, str, ULLONG_MAX, NULL, 0)
-- 
2.50.1


