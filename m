Return-Path: <netdev+bounces-167896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B878A3CB27
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E45189F434
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB96255E26;
	Wed, 19 Feb 2025 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ikH06Jlp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAA253F31;
	Wed, 19 Feb 2025 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999505; cv=none; b=FGUdoaEYvV5HyD00Ka0cRXoVW29BgHgf/i8Gye27tk5Zq/8neFNAsIbDNfDw2KA0YBQiQTLjCW/uiR+dQMamYcYKUlpl0AURCABr8NqD9mOoOoZKH203VhddCGvOC9qqOzfk3JSeS0QhpQNepoErgNq/idBjHQjOIJZYCOWhGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999505; c=relaxed/simple;
	bh=h7KODB3l27HDY/3S18EGMuiv704ZGfQfohzkQV5gUTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OY7QC2Js34qvEiOZ5U7DEI35us7oxelmV6NHGeThcibLhvAIkzKETaDg9q6NFyrG4A+kJXFdiI+St60DIVOe2ZREMnd4iYCsPOatzZdZH2L8riBbDw6h93j1klSvusZzYs3ehXLUrPXom4sDORsCIT9A4tdg5MwEIdiY6f7yos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ikH06Jlp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGefVT022079;
	Wed, 19 Feb 2025 21:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PP1/KcoaCOjPIC91f
	iWzNtyg0TUbZIsC2JBkNngDsc4=; b=ikH06Jlp0VC9FVHXqpADgUmXjUXXOXCPU
	FSTKwG7fAD0VsJfqo4MvqiB+VNtqJcQpXMWx6iGR4a9k6crGt5Tqz18iQ7JG5A4U
	Fi0q6V3s+jyqUk1fA+kT36mOVvIIBCpyt/GrdIAWckLRqcjeoCqG8roMK5KlVt+l
	IVYj3XmLqe9gmLXmHeSwzo/iRiXvei/h5EHhhWzytR6reIZYMpUfZh6L2hM3cZXx
	+Gl12cQFv0RzmwOSExznCQl73Qr0InNpKraj10cUX9kxX4Tw51ytoN+f8gaQS7XT
	qXmAUDDU5gUfbfoafc/4zx6ou/TyBC4FZx9QIVJP6oXZthr4A+0ow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjv6n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JLBSFu003828;
	Wed, 19 Feb 2025 21:11:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjv6n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKeVqE005844;
	Wed, 19 Feb 2025 21:11:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xe9ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:11:26 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JLBPUY10945114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:11:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B4F58054;
	Wed, 19 Feb 2025 21:11:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4061058064;
	Wed, 19 Feb 2025 21:11:25 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com.com (unknown [9.61.179.202])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 21:11:25 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
        david.laight.linux@gmail.com, nick.child@ibm.com, pmladek@suse.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 2/3] hexdump: Use for_each macro in print_hex_dump
Date: Wed, 19 Feb 2025 15:11:01 -0600
Message-ID: <20250219211102.225324-3-nnac123@linux.ibm.com>
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
X-Proofpoint-GUID: 6r2v9npDOuuIzVXGFSadxw-Yo1EyWczE
X-Proofpoint-ORIG-GUID: DQR9fdP4YIhwTotXKsThlkj06IuapsJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=782
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190158

The looping logic in print_hex_dump can be handled by the macro
for_each_line_in_hex_dump.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 lib/hexdump.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/lib/hexdump.c b/lib/hexdump.c
index c3db7c3a7643..181b82dfe40d 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -263,19 +263,14 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		    const void *buf, size_t len, bool ascii)
 {
 	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
+	int i;
 	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
 
 	if (rowsize != 16 && rowsize != 32)
 		rowsize = 16;
 
-	for (i = 0; i < len; i += rowsize) {
-		linelen = min(remaining, rowsize);
-		remaining -= rowsize;
-
-		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
-				   linebuf, sizeof(linebuf), ascii);
-
+	for_each_line_in_hex_dump(i, rowsize, linebuf, sizeof(linebuf),
+				  groupsize, buf, len) {
 		switch (prefix_type) {
 		case DUMP_PREFIX_ADDRESS:
 			printk("%s%s%p: %s\n",
-- 
2.48.1


