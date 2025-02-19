Return-Path: <netdev+bounces-167895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5600A3CB25
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C004E189F269
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B5254AFC;
	Wed, 19 Feb 2025 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dmNObzAk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60F253F16;
	Wed, 19 Feb 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999504; cv=none; b=KFj3oRNiff1b8Sp2x5w251CGj6hdTcXY49NAWd5B3ld6ybHxfQgTUAokgv+dm97lyRAeyrpVQRSzd5LXb1ixsrI4d9MZyBCK9IRfVNf+ou/EhhGMkxUeNCBs9FMLlqo1Pwa3r69lzmB7edLgtk7ofNOH8XXnrcRKvaZJm5cCHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999504; c=relaxed/simple;
	bh=eH7XlfXjhN7iCkf56Tia2Non753VvDY0UklqsLTQQNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRPTmRySqjo0YvJIgNicBPFq3NkG8QKYc65UYe3Q7UTeAEOohC0I7x2fjDx51tK021afo0fqLkn8jkLp8y2nCtpphhsbKGq3m9i3BjVCnEau+0R4EnG33C2iusMuBlR22TP/XIKh5ju0QL6Fz9wtsT4Jo2PZn4DKajACCbmTUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dmNObzAk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JG53vp022092;
	Wed, 19 Feb 2025 21:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NGKeY49n9lVKZOiCo
	gWK/F48ABB2IagRGicNLseklZE=; b=dmNObzAkMyNasq0sGJ/V+BHPP/MEhA2em
	vJ3/92d11zCo8OjUiR5qTdqVJd0VKBuDDhTtZ12zmaJar5T5jpTdHy6Iuu+O0JTI
	qJxZI4PH7/H0z1m8Mmdnom3Zo1fB1spTAmJ2wbCFNWL7i2CRHXpbXYCn5K1bRgHx
	E/2GUs7Wz2ZZxbC1BXTLvjLllKN7rd6aqxbkF/u+cYgQx4WUgtWlQZSrRYBTCEfq
	wwsRU+j0+4fL/LWyg8zKF7NjG209d91NzyiDSRx7ctFyW+Y6Cqh3gv9iUvT69KTE
	OxT4z3SILp9+EDh7YbDS8Xqol9CCA3UH6zVrHGLlW8b87Z787ijrg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjv6n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JL4YdS024369;
	Wed, 19 Feb 2025 21:11:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjv6n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKrDHU002336;
	Wed, 19 Feb 2025 21:11:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03x68bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:26 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JLBPBT19333798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:11:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A93458062;
	Wed, 19 Feb 2025 21:11:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93DA858054;
	Wed, 19 Feb 2025 21:11:24 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com.com (unknown [9.61.179.202])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 21:11:24 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
        david.laight.linux@gmail.com, nick.child@ibm.com, pmladek@suse.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 1/3] hexdump: Implement macro for converting large buffers
Date: Wed, 19 Feb 2025 15:11:00 -0600
Message-ID: <20250219211102.225324-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219211102.225324-1-nnac123@linux.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rj7X2i2tyjdhNe-0fZoN2EbVaAOM_7fM
X-Proofpoint-ORIG-GUID: Pr6Qi2sTC9RtTZy2o1UnubzTyVJJdWlI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=906
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190158

Define for_each_line_in_hex_dump which loops over a buffer and calls
hex_dump_to_buffer for each segment in the buffer. This allows the
caller to decide what to do with the resulting string and is not
limited by a specific printing format like print_hex_dump.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 include/linux/printk.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..12e51b1cdca5 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -755,6 +755,26 @@ enum {
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
+				(len) - (i), (rowsize), (groupsize),	\
+				(linebuf), (linebuflen), false);	\
+	     (i) += (rowsize) == 32 ? 32 : 16				\
+	    )
 #ifdef CONFIG_PRINTK
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
-- 
2.48.1


