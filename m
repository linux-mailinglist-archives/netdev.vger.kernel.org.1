Return-Path: <netdev+bounces-243971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A531CABCE4
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 03:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC1BA3006988
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 02:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86236271450;
	Mon,  8 Dec 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V/JgLOom";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PpZIEf45"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E826ED40
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159708; cv=none; b=prXXiFCqb4RuQM7n/2OXbmkYCQNQMTfZy4zob5gOSms5cJo+aJvIFVLjaiTWdBxkeac8vCDnCWUWdkyAT+H/LADcwOrtOOytzjWhZLGZilU8Cm9s2/70S4d0OJYzT6d2UUhb6d4ZUGIpuy9Xi28IoUxi33vrmqjyLAgDk/xLrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159708; c=relaxed/simple;
	bh=VccLCferOc+mdB16nfI0HlBzXI9Os/PGGnbeSXCmwo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPkIG0C4HnLF8pvIweY8X2iC1cSNR1bYJ8Lb7WX0iRGk8rYpxbk37RmT/zJ42g2as55zxxgUCZiq0DKo9EUseRcpYhb9/x6B+vvqy7Lw8VVsAazzudWQj04VYRITwSP82DwctP6IY4eKhzDWvDipWrXxB1fx3KF1kCXM56CDiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V/JgLOom; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PpZIEf45; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7MLi0b3702865
	for <netdev@vger.kernel.org>; Mon, 8 Dec 2025 02:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kzMAceVgYEV3LRopVsx6XpOY2J2YDxUetSp
	uW12UF28=; b=V/JgLOomjrBFM5RJfUjcf5cMMe5RowQIY0WKHAio4r5kLG1T+7A
	sQwDCcB5CnOwHmFT6YtOqYgZajooCXuZQq7uwsHzuN3Br5EQpxXMrAZ9Mv89GUrE
	pqF6mCQcO3p9dChXUKdGEEqjSCJk9rdr9jUqDrbj1UB40N0qf9V1Y5Vy1XwHsuk8
	VE0B9A9Pm+SD6F/Wt32yCkLzr5DiIz4TF67RwmB9gXo5w21zldIbVj21jnM/FD0r
	cKIeO+4FyQEN01FgOA/IPdgKsz55i9tq+ZKFU8wCOQk3WepjAkKavbtzCNri5HfO
	JwFr1/RobATCbNSYBe8iFEeiJM22uQnAG1Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avbga3cd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 02:08:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so4046508a12.3
        for <netdev@vger.kernel.org>; Sun, 07 Dec 2025 18:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765159705; x=1765764505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzMAceVgYEV3LRopVsx6XpOY2J2YDxUetSpuW12UF28=;
        b=PpZIEf45GCw6uYJ6vvh+Yziyw9pWluN+72yLEoH6josJP9l5n3hWFfkHxMpeEe2DJm
         S13EpyTyBsvmQEYl92RETyQVJ/1fQ9oJeRahzXoVdgGaIUufiU6+2fLaObVz2E1EIxiK
         Wcyhnu8z9YROgKO6wRaeHWYVPvGUwLS75ous5Z4Z3KiA/WvwQsyDvsf8Z7ckoAK2N9Zi
         KRn05jXCamBIIAzFzISiU+CLRau4WfFKmh9Wypgb2o9q4YDOTBbFikBaehljVt/ObO3b
         pYHUpMQvcje/uhfI5N1f5QS5ePRNLHk9jH3n0+iAzUWR/q2muL/8QhGNR3+gX9ALyHAb
         Jg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159705; x=1765764505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzMAceVgYEV3LRopVsx6XpOY2J2YDxUetSpuW12UF28=;
        b=qxKcpWqRZF69X12qGvZG12RrVavJ6OJozvrGhXmOZR3GHIjaPkRKG/a33KS7EnWI2i
         3EHJzl847rHpqNsrd1+x4L230B5wHA7SLkfrWhZsHZX+i/KjvBYICTil4fwvvm0eTjwK
         MznApwbZ7THsJuLfOXkcPTp0oSoY/USX4KOoYY0OSnRa8UGOQMQTehw6Flu9nSyzgT82
         C53ETNg5Glc6D43+DOLNIPZIMPRMs3BgKfW+9Qim/tPdEu5FQWVmR7uHfloOzJriHE6q
         gsfkzz/u76pbEGV5OovMT/fD2ghDf6MFJBhlctLTRKKQp4KOsTuvWnKUGEfbIXtpEIBm
         2K9A==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZMv03INzEvQ4ZpUqyMloIIGkS2B2lVzezobmh4MCxuYwxmJ64zUVl1KZeznE1sTPFjLnXHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsuQmXYfFPrSdp6kiMi2Awe31q4BcRGWDb9MIrKClnGr/NlZk
	iQQp5ozMhnDzw9cu0aX9P6+pSQCXlyl39SI5tSHd8xwK3iZ0Wj2bTxClFKZt0jE4dR4sBLzKdYE
	VSFq0RgL4T/18ItiuNZkZpDQQBZfTZFoUWSmP5BfWWF1kjN9RCcxD4M8QgrM=
X-Gm-Gg: ASbGncu7IhYoNVmTIWmWPR2ByTLl+5FTc2NYdDMVJRv9ZLpX7T7bFErIikHIOfTOM5P
	sIGqlMRG6GeEZKydfpPLABbJM7XBdAD1DMTSOrE5KksMyVOGp8Fc6NlU8YW6f3G1S+axE8IBlfr
	jS6GTWixIIyyMJHkGRBXiTuIWp+AeP5pYWJVs/ndKE5QVvc5wjx6KTnY6uIKNK5lO5KrALeikVw
	oL+H/oRUPybe4BmSUtK34r/E2gR4jyr9P9QuXFfMXH78flA6DIVCv5mxY2bZUM9rsa+qXX3WWfJ
	Tj/75Eh0dCQPwCgNo9F8ChvuBQwVaOt0wSCqKx1xpIueuIKTeyXpKL1UfrTkjWyjLzjDBvK/mLs
	nzq1h1Avz+rBkPA7re7O1EM183BaSPmTntgG5VLELPzzHhdS8PaygRKY1
X-Received: by 2002:a05:6a20:258a:b0:34f:68e9:da94 with SMTP id adf61e73a8af0-36617e8aa09mr5482226637.30.1765159704824;
        Sun, 07 Dec 2025 18:08:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWVe6gIB8P74v7a1QrkyOpnJq/8Z8WDZ38f3W2f7R80V4KSedeD0N4al3nh7zsNxc12nJyw==
X-Received: by 2002:a05:6a20:258a:b0:34f:68e9:da94 with SMTP id adf61e73a8af0-36617e8aa09mr5482205637.30.1765159704343;
        Sun, 07 Dec 2025 18:08:24 -0800 (PST)
Received: from quoll (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f1cfsm108001255ad.55.2025.12.07.18.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] ptp: chardev: Fix confusing cleanup.h syntax
Date: Mon,  8 Dec 2025 03:08:20 +0100
Message-ID: <20251208020819.5168-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=VccLCferOc+mdB16nfI0HlBzXI9Os/PGGnbeSXCmwo4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpNjMTnjIROfzmbzCUSuzKP7esUV6Bxhoh0qf1g
 kqSSn9XVzOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaTYzEwAKCRDBN2bmhouD
 1wO4D/4lAMnD+vm96R+r1TzQ8gkd/6eI46/tnhRAkdL4PKEPAOY/y6C497KZ/HtznagZ74EZ0Mb
 97pDynBThHAN3LiQXx83kC8n3+ev71L8dkaxRhDIYrgatb3a2LTk1PaDw7ZPtyrg78lyl6FAs2n
 Vy7dDaI4bX1ngu4mr4bWeFLTRPsKUFX0DV7c95PbX4sPED3CML80v2sM6znNjK/B1PWLe7X36+y
 Idwn4/89aigqByvlTmRlxm/NjrKYzOUFaH3L22FXXYU/kz8g81vYZD8e0Zv2oISzkIrBbne7lOC
 NYJM/8L9WFyccdZ1uBY1Lx/FdN42PJZQ98SNyFeDUVhA5wMA0sno1U6qxntqWKZWY1I/LoG83X6
 DsrkQMw/QQcR5opzUs0pXml0rUUI1NlTzll1mTgKk3BY5thd5eru/5I7lJuiYVe9o7pfgHsFivP
 ORHXGh4FBO2qEtwqFjMysiOMTrdbrgmRWV9P0qzD0EFFK/bpnIrVMtJ8Zo+bFP5M1KKsznsz0hD
 ZKYVknoSLnc/rpZi4bbFqDWvVh37OFGl/PLeH18e3avvZADjOQvfFehrQSGCW1tqnrMXJcFXG9a
 Gd2zu5pBbdOwt6xsVQKdU7mxan/ExJ7StvfxE3Ro/aYWRVL5pT0tLgoHoS5ujpuxtmP66k7JMJB YSIMpB9cesniFrA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d4z4CBjE c=1 sm=1 tr=0 ts=69363319 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=vTE1kzb4AqIx7XBf0Bkr0A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4ikAd483rJ0gCz60bdsA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Neyy_vlF4B1hZ48bf3jhlGx03qK_LwUe
X-Proofpoint-ORIG-GUID: Neyy_vlF4B1hZ48bf3jhlGx03qK_LwUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDAxNiBTYWx0ZWRfX7jYaFgKqCaGt
 osliImOt7k1W3n9i9PcEE7nzNqaJlRfOcmvLhWXmMI0yrDT3iUW62qX0rfEU2H3AUKM0ka7ITj4
 5BF9wUNjqmO6tfBr65rjiYgLlAhNihqiMH4WhlvkqFZBQ4YSePXI7yr92pOlq3rY3OGwIvesgXp
 2TXUsvZSZymxaAJDcj5eqcknFF6e8+3IR5tQViRSruyQC6ihta0FlcfljofLQt9lOj4v5dWfLr6
 HwLb/FoE7kk8VbYI0YKWD8ZKqdIB0FaA4NVKjVSGwi5lHm2EP5/R74JMHy0NwEpF/NQyi1dOUAu
 gzwdgTrlRKD13E+PthJ7m+hAGzMiMkU2CBCRstz4X0G7ZR6Idq+g1s8dwSmpIu+DHPxo+T2ye3o
 aFpPfwzvYpZRc67469yvf+WFX/TCxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080016

Initializing automatic __free variables to NULL without need (e.g.
branches with different allocations), followed by actual allocation is
in contrary to explicit coding rules guiding cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem the
recommendation is to always define and assign variables in one statement
and not group variable definitions at the top of the function when
__free() is used."

Code does not have a bug, but is less readable and uses discouraged
coding practice, so fix that by moving declaration to the place of
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/ptp/ptp_chardev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index c61cf9edac48..2a52cc7bccd1 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -350,13 +350,13 @@ typedef int (*ptp_gettimex_fn)(struct ptp_clock_info *,
 static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 				    ptp_gettimex_fn gettimex_fn)
 {
-	struct ptp_sys_offset_extended *extoff __free(kfree) = NULL;
 	struct ptp_system_timestamp sts;
 
 	if (!gettimex_fn)
 		return -EOPNOTSUPP;
 
-	extoff = memdup_user(arg, sizeof(*extoff));
+	struct ptp_sys_offset_extended *extoff __free(kfree) =
+		memdup_user(arg, sizeof(*extoff));
 	if (IS_ERR(extoff))
 		return PTR_ERR(extoff);
 
@@ -402,11 +402,11 @@ static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 
 static long ptp_sys_offset(struct ptp_clock *ptp, void __user *arg)
 {
-	struct ptp_sys_offset *sysoff __free(kfree) = NULL;
 	struct ptp_clock_time *pct;
 	struct timespec64 ts;
 
-	sysoff = memdup_user(arg, sizeof(*sysoff));
+	struct ptp_sys_offset *sysoff __free(kfree) =
+		memdup_user(arg, sizeof(*sysoff));
 	if (IS_ERR(sysoff))
 		return PTR_ERR(sysoff);
 
-- 
2.51.0


