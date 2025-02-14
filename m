Return-Path: <netdev+bounces-166503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD36A36304
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100153AE8B6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB71267B8B;
	Fri, 14 Feb 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R59gBZ+4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DA14D28C;
	Fri, 14 Feb 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550308; cv=none; b=TIKCnD/aEX7E7622/ERh3YMahNLmuREpROk2oQSfZdvDDH2pTU531vnxQhLeivm1mngmXqv8bxNZDPTJzf3Li1ArNu3k6gOn1/6r0y113YtXEYGEctXkO+bASJhUonny8+E6QltWtHRuHlxleZg+HcISueoGF6uPzupw1edfO/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550308; c=relaxed/simple;
	bh=MvxERc194WQJx36vLWPBEF+DLPnFAKH0/YV6FuaNUNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWntc0rYq0HW6tx77mV+/JNenGyush0Gc81wkjklsWfTEKxzSyhKvzTktx5/sqa9IRS+emahu56Wit0OKopBH/KnOsyvA3/qANuxlRfy7UNuD6BeHsQeCqbh9uN81NfcYZY447o100+jUfa357qb9jTAObNlXo4As59VtWOL57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R59gBZ+4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFdcek032481;
	Fri, 14 Feb 2025 16:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yG70bgF4eF0LbCZrC
	bJjOyXn2pmOX1dHX5jvropnH6A=; b=R59gBZ+4392p79qX19Ph8tJ7FR3iI2W7o
	J/Ninepujgqw6UHYoorf3Bj6yTIEdBUgdPRhsF2ZJOxlgCnMLsNw+4P2gyUYhJoD
	O05v4xyRqKB1LYRJdssgwocmKwCOwgQOhqluGowhZxAhp7k0iNurR7WPOFR3TsEg
	qoWnQ56aUqVGv2Ido9dDCj55/oGz9kgmjgSPtBv/tWiAa9xZt8g8fakzAtpEoqdi
	kwsN7y2rDuuZFyvpM0ltcvKN9CP7tWb+bzq0EuH/l8KECbVjLWWHN3ZM+n3ciJaF
	PGvw9jVDrAeXS7PEzIIPCsPjnbrCBSV7lrPFjiYRQ8qq7xNnkpBoQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t8nug6qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:24:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EEbawB028197;
	Fri, 14 Feb 2025 16:24:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyvked-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:24:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EGOpoa27329046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 16:24:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D83E55803F;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1AA658061;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.lan (unknown [9.61.91.157])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 16:24:51 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, nick.child@ibm.com,
        jacob.e.keller@intel.com, horms@kernel.org,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH v2 2/3] hexdump: Use for_each macro in print_hex_dump
Date: Fri, 14 Feb 2025 10:24:35 -0600
Message-ID: <20250214162436.241359-3-nnac123@linux.ibm.com>
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
X-Proofpoint-GUID: 9LXfp6siklWuK3QkpAUTEsSjRVu61PQb
X-Proofpoint-ORIG-GUID: 9LXfp6siklWuK3QkpAUTEsSjRVu61PQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=885
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140114

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
2.48.0


