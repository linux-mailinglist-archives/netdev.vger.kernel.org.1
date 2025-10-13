Return-Path: <netdev+bounces-228983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C6DBD6C95
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0E1F4EB4A7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BD2E5430;
	Mon, 13 Oct 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NyKSR69i"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D96271459
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399646; cv=none; b=Mx/N/A1CScae1RS1WPE1t+jY5hopnUoShvUOlmui1CScEclzFiXQ4kfdwGu+7GJrUfBb+0YRVkj7CglJJjGmSSpe/8Cty+jyE2Sm7gRXBK9PAGEtK4De0M1IYKFTVXzSJQ1m2cZnidvRYGywgsJtH/TD2++zGUeibWK8K+ZjlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399646; c=relaxed/simple;
	bh=8Kpl6hx8Cv8z6i5PE12EBxs253An2iAGJOjhj3NcToA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roF3szjSP6wPUfKyxKedFUUo9BhEp4058vjXUddAbW2ed2wM+DMLKCW0the4CLYLG9k0tRwFEWmQRPhS4kJitxtqLJ53ozwLXvImdc2ZGjJJ+0IDFuYunpWY4pATfS4LIbSWJX0S0vGFM0/I8no20isJ7iwt/SAMSscnHJEaoSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NyKSR69i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DI8ksr016580;
	Mon, 13 Oct 2025 23:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ICk9nDPphWyHhH5W+
	z+GLuWpol1yXkeeteqskEWs5TM=; b=NyKSR69i9vpy9A4ENRMiOiK0GqBORiVjJ
	3eqYn8lQDAuB3vTnJTD4/bqqg8+HFQFHFPy9lRYz+Sf4/GU36Y0xP3tT9S1X+0My
	5PgepyNa8r9C2vbJAHJpTbJDToMTTKueo4oK0TfW/6IKuPGGR+mgrlMBqpbj0WJC
	hAKKIjb7TOk3vmApwP9FYYUQieG7brCtTBT+JT0lAmLIkaWFenStIvkXJ3pSUkXg
	asTy6RtlqoJucWoJzGDfsLl3UPYdtaFO+eatfATwEMDE1l/9Cs3qoV0ummJYgvY6
	CRZa5GrQLnzgdI0OT0GsAbBSjj6uVvjVk2seelJ7cxGSuXdII8CFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr3kd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DNnEBM016870;
	Mon, 13 Oct 2025 23:53:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr3kd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DN3785018362;
	Mon, 13 Oct 2025 23:53:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf1x1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DNrnqM26215096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 23:53:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D705A58055;
	Mon, 13 Oct 2025 23:53:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9616058043;
	Mon, 13 Oct 2025 23:53:49 +0000 (GMT)
Received: from localhost (unknown [9.61.176.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 23:53:49 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com
Subject: [PATCH net-next v13 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Mon, 13 Oct 2025 16:52:47 -0700
Message-ID: <20251013235328.1289410-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013235328.1289410-1-wilder@us.ibm.com>
References: <20251013235328.1289410-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ed9110 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=zofNYPC-ylGwukCjRwUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6hCzNPU0Ig4TST9la4wQHRdCXtgSQwmi
X-Proofpoint-ORIG-GUID: 5hZUyRINQLZxNcY_2J8_LG3gGNOO8zVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX/5VNNzw/A1HL
 GYb4SA1C2JGrXHJNZsLNtgm8/UtNbLfaBXNrG2vf9VQtskSldstYjSwXximm6Gins8qnOu30h8r
 gDTBs+j4c8m6qp2J2ne83xs08HTM0NkwitSFufkJsC1s8MrCKE1uYFD9srCxzetWgSuW8OGkmHs
 O72+cAiBlsE7m25Apaf0fTeNobcVkgWHt1oa6I8DpS+GWK5oBSCmNc+zpp31o/qLl6FbScMmold
 2u2D64agwz9SINGZ6Oqg+9vJGawTH8nH6vUZ4sny9+sV6MuCc+t5Ky7FLWMSGjI6vKkSUkG4283
 UuByuUWaaRVdx1BJT/pppkblj56ufYRCKJkRw+D99JCn8gVwf/LbJO+adQCiyhz0RjccDy71Egh
 5NYPEJmW4f0Y+FefgJ26RcXwMtVGGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140

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


