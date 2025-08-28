Return-Path: <netdev+bounces-218019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA3B3AD67
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B5F1883B15
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EB26B951;
	Thu, 28 Aug 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aKHULvXv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B712609D6
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419574; cv=none; b=NlXci3uZoOFCPKQMOkyE8SYlIKTHPiZewFb9ev3QYY/E4NcBD9MhmwVHR2oDq4b7BkgvOBaKhUujubvm+CAQ3NKK70n7njRVg/zTOdaC5sieOHZJHLbukyhCD8iVF2u23+wt/vJsBGz7atf8sBc21MZi+S+3sqozvo6aQ1PRywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419574; c=relaxed/simple;
	bh=MQKjuBZ9jF0mckpOwYWgkpLyoNZW3UsQBW37YZIQ/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EImifLnHXivm2wj/2sihT9sVXRBZaS5zYzWr1IMIyRMw5uUbHbkaqylA2Pr5QBlbU4IG7FH6u7f/OXUFQgW1cgUjOVvED4SoJjDxbW3L+3pW0C4xPKsVV6LO+fRj8laimpyFghA9GMwOosI/F4Kx0uDTql5rWmOGRRuQaM7zuCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aKHULvXv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SGmeXR030477;
	Thu, 28 Aug 2025 22:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=krOeWezkgS9V/GW/N
	Rvt9U0ACSBl0zTg6ypjslaJSJA=; b=aKHULvXvKs2ns1du20bK5Sc4xzmlvk2LO
	dalgFoJEPolAcdgQfj5p7NPyxrkj0iyrokk4u/WHhyNSsKSlNpRnlVNtTvuaKMRD
	UggmrsIx2BJ1RS7X0DWM1EwgydqHLG7ql8O82AGz/3e4nnupFHzC/qToa5+qQBTZ
	7eVNNe32rZ5hbP2v2/+YkZHkDnUvVK2v/yV0PJDc2eFsckXN3+MQUp5302kf93XZ
	4xIJbrY63dHU7wdaY3uh3ZeKUgQxUnEHaGwhC0y/7UIl1/aq3P0dsDCATonKsa6Y
	a+QUtBQuyDSpI+VKTZtqVGjCnLgACkYGFtCTmwoBN3DcK+LwsWzOA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rw7gqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLUXm2002473;
	Thu, 28 Aug 2025 22:19:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mpx0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:24 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57SMJKv832113184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 22:19:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB3495805A;
	Thu, 28 Aug 2025 22:19:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E49D58052;
	Thu, 28 Aug 2025 22:19:20 +0000 (GMT)
Received: from localhost (unknown [9.61.155.164])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 22:19:20 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v8 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Thu, 28 Aug 2025 15:18:04 -0700
Message-ID: <20250828221859.2712197-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250828221859.2712197-1-wilder@us.ibm.com>
References: <20250828221859.2712197-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2EB62PvbQygvyMhdvi6hCuS29gk5Y1Sz
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68b0d5ec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
X-Proofpoint-GUID: 2EB62PvbQygvyMhdvi6hCuS29gk5Y1Sz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfX67YlU8gu93N1
 SeZ2ubeVkyodFCBDiVM6d+oDht1WDqaZ3VsJDkJIfhFXSeWUicYtf/isxydaWQHRT1x51ztIUqF
 tbEBQ7a2eNtmam0FwbRTpgLOyp5pnr+pdTqzJKXJ9X7AkTbps+YZOM1ZtFxU5RjyAN75gbf+idl
 X4x92xCOjB7kOjSBYuZOywLpx4eblnjCMgT2t51+zr9v5/ZA6aj2Rj/UiFym8aEb5oyIybh2DYN
 CmyKU7T66469uxtgLhBJtam2W9CpZIL/1bQ93LEtXz7eiq447cjj8+WLGTfBzIwIIGqF4wCuSNj
 yfH0/AvM+zAIM6fjmSHnxJ6syzM/vA4EKsStgjfRwYOf/7S52Cy1XXCjfOv7xb2rDKJoIJVMR18
 k+r1EfAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055

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
index b7f275bc33a1..7d22bbe67121 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -86,14 +86,15 @@ enum {
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
@@ -168,8 +169,10 @@ static inline void __bond_opt_init(struct bond_opt_value *optval,
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


