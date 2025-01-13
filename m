Return-Path: <netdev+bounces-157909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23463A0C479
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51113A324D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26EC1F8EF9;
	Mon, 13 Jan 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ePkIRnvy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2E1EBFE8;
	Mon, 13 Jan 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806653; cv=none; b=Mf+VhIMvRi34SsFXjfQHo0AXEPWf0IBQ9ZVWiKEX4XvJ1JaLd0hUfSKf6dus4hSgi1VIHHlQaBFumKtMbf6OafXLwigF7SL8knXkCKIs6w3OCzwWSbGSA3zLhBk+B7fpQXndwoKgT2QWDTOPY60Nzxt7JUWWykdBbIKtsQyFXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806653; c=relaxed/simple;
	bh=U/1rVWcsrXbc1r4VEwXO/XZRy38DCLOMvGKhemqBFww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnXH3S0Rj9lkheYi3gNs7r8SRhn3n3rPLBLtLOklB/cBb8SDRL44yLOci73L6jE9foj2LoFbtT9CZ1jfA9rH9ZLYYErUmDrEFi/srRMP7fqSrIlM91gfSO2SN9S7qhx8ys8yXRksioZgNSGM1C1b5aquMQu9iUpfyBjVauKX/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ePkIRnvy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGJkor002370;
	Mon, 13 Jan 2025 22:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=peq0z7fMiaJEdZUrk
	Z7UXf2AGzRX/IAZoNjAPeh6Zc8=; b=ePkIRnvyAqliqqupW6gYaSQJoc3N9DmBx
	JLT8Fu0D5dRi+70OPctuQogiAfPGpcR/LWr5oymwbnrU5MxmY5AT1L3UwlMsy/L4
	bphPob2E8Na4JRzRn7NA7Mg9sAN0IAJObPM4prAWjoXVz0KnCFltfsBOT6iDF1yV
	kweS6bsuj8i4VbyFQW2EVEgbErw0gntFFh2439mqQ5pwi8iEHeBSxV0d9OucZQtR
	/fH/BtPhZeFc6oXN/MclHuIBmXTe2++KeT+ts+VKLhys3T8+D9m4iznLFSJyjk8A
	Bvw79ehxdE4Wkwhx3JBxZaY4FpR51FN/Ab4++yW4osGYhzzEG8PIw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uagvdgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 22:17:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DL5YWP000827;
	Mon, 13 Jan 2025 22:17:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456jr3by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 22:17:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DMHR6P32572046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 22:17:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C185804B;
	Mon, 13 Jan 2025 22:17:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F51158055;
	Mon, 13 Jan 2025 22:17:27 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com.com (unknown [9.61.148.44])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 22:17:27 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: nick.child@ibm.com, netdev@vger.kernel.org,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH 2/3] hexdump: Use for_each macro in print_hex_dump
Date: Mon, 13 Jan 2025 16:17:20 -0600
Message-ID: <20250113221721.362093-3-nnac123@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nn5yBUDGchBH99OhndwOV3rscTWIsNcI
X-Proofpoint-GUID: nn5yBUDGchBH99OhndwOV3rscTWIsNcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=804
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130173

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
2.47.1


