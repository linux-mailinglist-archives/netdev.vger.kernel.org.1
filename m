Return-Path: <netdev+bounces-212650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46819B2191A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B43D7ACF33
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D5422DA02;
	Mon, 11 Aug 2025 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FdYDt6d2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A94223DE7
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954376; cv=none; b=soxNwypmgP/pK8UHBPD56+x5nJ4zuVqLWNDcGeNal7ntx9p8VEgNnbb5F+cl8RElZmhPIAIgYuRZdXZ5Goysb0Jw4fskZkAySlsAk5oS+4iDPiPU9dKrUhyf+tOmROsCaFtwmY7tQ2ZJXXD28EfNdEfmMmIB34W5M+BInSvlNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954376; c=relaxed/simple;
	bh=zeEymaK2mtHEmKnt13uxjMcd7LKa5+pXEDrvLDXOUco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brUzGI/+WWXuC13OqrExfyewTPCj/Bkn3y8YFCzf0vqA3oRYOcGChvFKGiLjQ9vj7HgWVb6kQyLZvpPlrLh93dVlZSSbcZTT4Jtm/OMJ2KMzkSBWHvX5YOTu2CBCvn4eE+AYMKEvgnNMdzBoZqo3Av0rXB6Xa9Mvk3/vIBFFUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FdYDt6d2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDrhPb009288;
	Mon, 11 Aug 2025 23:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BTXNRBd9EzEt0BRGA
	m2kf9iKioVscjee7CMNWxDlNSs=; b=FdYDt6d2jK7sRJrLaCd0Gt4tnKT/kxgRY
	6uGw7IuK7fFbxUzXhTPOAvTGOstjneiCRBj0lbWc24+JNV3PmsBYRmJ4oIFS8zTi
	nOtFuwBh0Xu2vFbnGjZSdUzXXvmMeJ/WN4ez66gp9rTiFpt+btpC+1cR+X2eXPls
	IwU39N7dm8M2LgofbV6e9wvfbprjpe7HWUB8kzQuHD6PvDa4VOpuOlCveZhnchp7
	5a/ASeobMldECopRz1GOgVy+GDO7yZ1jc72Y4SlxA7PyRGB7uFuKK5YzFCT8wGPC
	ICfBDLPhDNuydXN9karXCnXpCXpP1cBSPPt2tpcbtOIe0uLpmcytw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14bn2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BJMvGZ028582;
	Mon, 11 Aug 2025 23:19:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5mytyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BNJHKW9700048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 23:19:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0E3E58053;
	Mon, 11 Aug 2025 23:19:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CDD458043;
	Mon, 11 Aug 2025 23:19:16 +0000 (GMT)
Received: from localhost (unknown [9.61.174.150])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 23:19:16 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v7 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Mon, 11 Aug 2025 16:18:01 -0700
Message-ID: <20250811231909.1827080-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811231909.1827080-1-wilder@us.ibm.com>
References: <20250811231909.1827080-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ywVa5DtelbRh9lgwo04GMTYN25_bw771
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE2NSBTYWx0ZWRfXxzHpMU8qCn21
 rnyUWC5JebRb3wX7cFYikh4tsFKwguOUneJAbp4pZ4E1gKaOZVvvnM+5N8Irq1cT9S0SVxFKS7s
 RMGhG67ZZd/OFc7YNsqDas+TOGPQjiifEJb1tEjNSs1N2yniANn6JfdzeZHU1ym9Z2otueIeMZL
 hUa5kdc1WA6rt/XEeiHnPKXIbT45D+f6Rz0XDLjF0lQDq3qgzVqIMhEEWCxWExjfU2hgi1KY/Tv
 mq8898dBfTG7DjlO5azlQqwoRfPdFDc8AaaUBzXYbLWZhLHrmJSZ3J1B/uDzcTPAcsomyoC2WIa
 w7LBWu/uF8Ub9qDfZ2cgVHLhV4aMvbrFHP4W5+oHrecyzOaOyILdmAuerS3MBa75ekFraynvaGM
 X8Z0S8NWvBem6tUqfsxCisrVKRg7noVEUPuWXQCP+pRzkHQzi1J/RayF08czfXLEJvXswPx0
X-Proofpoint-GUID: ywVa5DtelbRh9lgwo04GMTYN25_bw771
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689a7a78 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110165

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
2.50.1


