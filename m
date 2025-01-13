Return-Path: <netdev+bounces-157908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA27A0C478
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300B83A1A85
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1C1F8EF2;
	Mon, 13 Jan 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BdQ0piND"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192491D54EF;
	Mon, 13 Jan 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806653; cv=none; b=hRVi3FNziv3x8JmsS1Bm0zSQgcDij27c4VKVKkXYd1JGFShgaOom51n2a1bZel+2+YjUSLSvT7efoScUUzEMqHO7+p71dvVTLLZyszUPumCgsmOfRA3f0DkUxEi/8K99VRo+DAddw2tqTPhjHmyvV8+JhUeU7sdXZG/LURBX+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806653; c=relaxed/simple;
	bh=RQnhJRNgDLemGSI57q+8mmqZ5dCA8weUN4fT2xuvUC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmJVltnf3kpBaBkIXdcIc3CWiEsfCM35T4eMUlEEdNXNE0NEIh/19OmjNQadZEjqN3+t9YDhqo9MQMSHoIN79kn+k5i/pYHuYRhPyx5svFeohPHsCGiUG38SNFsEac0ssIxMAXMVd0AVzyqCQVe2uQ9Coqmv2V0wsjQe3/BSzSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BdQ0piND; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE6U2Y019902;
	Mon, 13 Jan 2025 22:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2wFLw8tFW9H7uxQCP
	yaGBT9D6W9KrM8Uc9NqUhP/j70=; b=BdQ0piNDbicMDQ5u6y3/KMV5y5IYroA/L
	y88AR7DSbzAeLDbRJfSPFD1rkRd/afI+qXwwz3NwMh4Th6NMQVmeE17T2MEC/69G
	tnq7Ztku2dysZZdaJmNZp0pDt8/8enI8m9K5EB48e8WPXOOCtStyz5TCuKXu6JdP
	Lvr7gwvplbfDMHbkKMVZz6VWVC++E6IyFEL/vjMxUDRDCdEhMPPnmiUtPQJWcNgD
	t6G8mHQoDfigUZNzBI0e3llAH1PNDEuwHAUhRrikj2S9RSiajDRWqkOgps86HtOm
	z9ENHe/wBGWe+Aw2Qs8Rn0bNmXCjatTZTqLLux164x+sFkW/2z6/g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a5a2fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 22:17:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DJOQr2002666;
	Mon, 13 Jan 2025 22:17:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by0f7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 22:17:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DMHRbT32572044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 22:17:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5942558066;
	Mon, 13 Jan 2025 22:17:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 092AB58055;
	Mon, 13 Jan 2025 22:17:27 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com.com (unknown [9.61.148.44])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 22:17:26 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: nick.child@ibm.com, netdev@vger.kernel.org,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH 1/3] hexdump: Implement macro for converting large buffers
Date: Mon, 13 Jan 2025 16:17:19 -0600
Message-ID: <20250113221721.362093-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113221721.362093-1-nnac123@linux.ibm.com>
References: <20250113221721.362093-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c4c-LSmt2tDpjExehFmYl8_-zT5dpUXR
X-Proofpoint-ORIG-GUID: c4c-LSmt2tDpjExehFmYl8_-zT5dpUXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=937 spamscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130173

Define for_each_line_in_hex_dump which loops over a buffer and calls
hex_dump_to_buffer for each segment in the buffer. This allows the
caller to decide what to do with the resulting string and is not
limited by a specific printing format like print_hex_dump.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 include/linux/printk.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..d55968f7ac10 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -755,6 +755,27 @@ enum {
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
 			      bool ascii);
+/**
+ * for_each_line_in_hex_dump - iterate over buffer, converting into hex ASCII
+ * @i - offset in @buff
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
2.47.1


