Return-Path: <netdev+bounces-208247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D21B0AB65
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE56AA39B1
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BFD2206AC;
	Fri, 18 Jul 2025 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RGZ3Ae/w"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B021FF4E
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873897; cv=none; b=EsNmO9Rnwx0kYUIBZZIoI71R+hPWKJBC5RE+1+gTpOZzJQTlaRF28v71AmJo5T+LW6tL8UO8t8Kw/vDiqMDiQLquY4w4ASbkGhFFsLyWDdsCelV0J3qassP0dTxLlzI5RF2ehzj+fzUKaTIH8ldyIOGmHYPb1c5V2oaqjNtFou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873897; c=relaxed/simple;
	bh=BQd3iAxZB+V3QPxtMC9mPxWN4Lpa/9A37bDSZs5fFwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1prZW5okMAa4vY3NvxpKEG+wUQ0nDTG+M4+hJZmgx9MY3HnQV6pyYhtORRwgFDvLFlPnlWq/8ER0dzPvFQGEST6u5oyF/jlm/MWPY3w2eBxEMyU9Dcu1GTg55rxNk0P6YTuhPs27v8llXSxYSWzLTMKbpYS9gWeP3f2bfR0jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RGZ3Ae/w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IL9ZaA030557;
	Fri, 18 Jul 2025 21:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vGlJIleTNPSAHPga3
	NGfld4EUzjqG3q209GrwuBhfB0=; b=RGZ3Ae/wRaoYAwKaGn0OJdy+gp6TNl6Ve
	34BIEXVydOOEwm51T+oZ2+vijjwbR3PMz3DajPHTQXfdhkLNCcFfx4Chwbb1cjJN
	Okm2XwMZkR/MtQWS/Cd3T7Y/8WTpY0WXNQY3KQT1TaYkhXushbZxrwfctE2tA3hd
	7DCAMZgtK9psuXuxun0ErFvikv/T8iVfgL4gaL9vMwc//KXPjF/7gzCsvojOe7Tz
	D1a3Kve4P/cMItd4DMI4I9uNP9RIRqi146pOhJ/Cy4ucZ+joSK1yMnweHHnLx4w5
	th2fwpwmZGBQRKCGzeisTX62Uu6Nu0G497dCK8tx4OYndE3LFpyMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7dkhu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHboPP025987;
	Fri, 18 Jul 2025 21:24:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31q3612-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ILOio234210158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:24:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2299958053;
	Fri, 18 Jul 2025 21:24:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6BE958059;
	Fri, 18 Jul 2025 21:24:43 +0000 (GMT)
Received: from localhost (unknown [9.61.165.151])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 21:24:43 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v6 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Fri, 18 Jul 2025 14:23:38 -0700
Message-ID: <20250718212430.1968853-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718212430.1968853-1-wilder@us.ibm.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UtHdTsw8b4QBtRuAAghLcxTBoXR0jy3N
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=687abb9e cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
X-Proofpoint-GUID: UtHdTsw8b4QBtRuAAghLcxTBoXR0jy3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE3MyBTYWx0ZWRfX6aOqVI5uug8m QhPDuz0RHpmAVsI7ZyfndZch1yX9NIrRqI3y78xUERS7VvdsSLdJHHVOWKQWbvofPRcEYMFlYY2 gM/ADXAJak8vn6mHo5sLcZplQ1tSITDwvfxMO1qWnXgLAHEOzAC3HQFBYj5hMyDvG5xt13GsupS
 uxEltVnv9otmzQneaQJv8tpG4GJbSmUcZFUQIMIuU0AZohALNk0FA/RNHEYKE+cmdmy6HLZ0MER oWxC1FbLtTrpBJw6rx8I5ptLcmdvbAfObhFcaEyPkmpXbKPoS6bS3h+bBHS/mfN2BLxauE63AxL +jRz91Jcp8ALvxFMyFaJ88gJfdvVb6IMEj5HOHXN2TiKjnLwDvTUV44W/enLpNetRuYtSSRb6Q0
 6IVZEHXHjrtoXivvaelB49PnF1NtqSWgBpMblAe4VVxN8vzYH5vg1VMUtAfoNvl+mO/iBqCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180173

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
index b7f275bc33a1..b95023bf40c3 100644
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
+	u16 extra_len;
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
2.43.5


