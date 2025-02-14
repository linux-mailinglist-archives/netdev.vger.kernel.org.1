Return-Path: <netdev+bounces-166500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A821A362FE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81703A7AA7
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1232676F5;
	Fri, 14 Feb 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X6fS5qwO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5B267393;
	Fri, 14 Feb 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550299; cv=none; b=d6FxkI6aFVLJAHY/5+k3zv+jmazcFwRdHPsOfmc3TLpNe5M11edVM76i/FFmemwDVLGLfJqFUduBlwKowBzCdRE3a/k0nf2jXYFUvMGdqD0+jhk0TNuU08hJmnpBmC5EoqufBJjgQUYI8qVxC2+PzC3P2Bac0sgEuLwYiMq8tQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550299; c=relaxed/simple;
	bh=0mTy7aT2DO+MQw1h7heKPjMWt+yyZdSNOVwiqs1Gz2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHO4KTkpYXgCVEHM+/4sg6EWv/BTa7ruOUnNRZiwYu/sh/ugwwCE1tNm1cH6q+PKWqV4/B3ref9S4JO5k9G+8C40EC2pR/XMVe+4X0vyqIywUVcGMUbjoQqitVe23xfkvVa8n+7J/k92A4UCWyvWAn6h2JNiGzONooYIPr+d+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X6fS5qwO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAo29a032741;
	Fri, 14 Feb 2025 16:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yFfZClgTIGahWWAji
	gU50EkYWifUgFkD4IIJI/BSD+c=; b=X6fS5qwO9I/mubzqM6sdbFIPwsB1Y+mQE
	mcUGeBIqMKM5Hp4HsPSorcXSgFMKT6wJdNpD0cVrluqYbrQr4IaJKCrQk8VnSlOj
	oaV4IWx3LJZPLbEiwfNyVrAB3sFJ9kDT+IpKdMcLil5+bMaPphw3JSx4xslVMjtl
	sZqet8LAUpKE254hYzPsMy+F5lpt7SPTU+F/+EmLhd1DbAuhAQAf0R/7SzPr1Pvb
	i2Wiq2taCP8AE8DPrItwNFd+qKJ7pIp+DB/NXR/28pID/rgi/0iCvfBY4uvqjUb1
	VK7Fo3tAlgzdUpcbyOqcvRvZsS//ff2xmB1KiuAgRwr82bHr+Sp5g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvacbb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:24:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EEXLrf028236;
	Fri, 14 Feb 2025 16:24:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyvkea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:24:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EGOp5w27329044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 16:24:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A71858056;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BDA15805A;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.lan (unknown [9.61.91.157])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, nick.child@ibm.com,
        jacob.e.keller@intel.com, horms@kernel.org,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH 1/3] hexdump: Implement macro for converting large buffers
Date: Fri, 14 Feb 2025 10:24:34 -0600
Message-ID: <20250214162436.241359-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214162436.241359-1-nnac123@linux.ibm.com>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NgG4kIDWrONo9mMbLfKZvrBJbv4GqcbG
X-Proofpoint-ORIG-GUID: NgG4kIDWrONo9mMbLfKZvrBJbv4GqcbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140114

Define for_each_line_in_hex_dump which loops over a buffer and calls
hex_dump_to_buffer for each segment in the buffer. This allows the
caller to decide what to do with the resulting string and is not
limited by a specific printing format like print_hex_dump.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 include/linux/printk.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..559d4bfe0645 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -755,6 +755,27 @@ enum {
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
 			      bool ascii);
+/**
+ * for_each_line_in_hex_dump - iterate over buffer, converting into hex ASCII
+ * @i: offset in @buff
+ * @rowsize: number of bytes to print per line; must be 16 or 32
+ * @linebuf: where to put the converted data
+ * @linebuflen: total size of @linebuf, including space for terminating NUL
+ *		IOW >= (@rowsize * 2) + ((@rowsize - 1 / @groupsize)) + 1
+ * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ */
+ #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, groupsize, \
+				   buf, len) \
+	for ((i) = 0;							\
+	     (i) < (len) &&						\
+	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
+				min((len) - (i), rowsize),		\
+				(rowsize), (groupsize), (linebuf),	\
+				(linebuflen), false);			\
+	     (i) += (rowsize) == 16 || (rowsize) == 32 ? (rowsize) : 16	\
+	    )
 #ifdef CONFIG_PRINTK
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
-- 
2.48.0


