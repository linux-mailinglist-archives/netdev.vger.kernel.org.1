Return-Path: <netdev+bounces-206893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEEDB04B13
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F5A4A5311
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B2278753;
	Mon, 14 Jul 2025 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lnnsz4Mr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2340233712
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533757; cv=none; b=MhCi9WKUWSsv75FPAY2Z2w2Efbz6yNS4C6PeOdCyLCMeVFfCRAFeDGkxdGnck6rVWQczXvNioSG1SalfVvjQFNtdNAHtrXnKTA5U10FpRpiHeWyrLULKCVRcR4nQurjg0fONb5nWZBt0NAzw0v1dpp63ZzNfgGH3owePL0KFLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533757; c=relaxed/simple;
	bh=BQd3iAxZB+V3QPxtMC9mPxWN4Lpa/9A37bDSZs5fFwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCU2yBi3namEbWHrlHnEaQtNKXSDocFaNWRGt7huren+WWZuXNKi3cVbn7rYJCQBgBKJo76qTlP7d11W1w0KzBJi7m+mh8dT4SY9cckLVEk/2dls5YfUb00DHK4X0Z/zCREL/3KIPAQlDdka2JM0CkPrtMFzPDtjyIfGS/sqVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lnnsz4Mr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGSBNU008825;
	Mon, 14 Jul 2025 22:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vGlJIleTNPSAHPga3
	NGfld4EUzjqG3q209GrwuBhfB0=; b=lnnsz4Mrm9qYfPqtl/EicepF2cvToS8rK
	WG66Pa4i5nbIE8lQypcPwmnZIeCkirtCINkzBsgdIolExjYtO/0ofnhriA+91KvU
	pDjfbCpz3eT8iQAHHAuhPIzbONNadb4AypY/i+QjMwcUqcsQ23neDelwTDlGmXRy
	349PX+CbZno5YyhJzIL1tZzp31i1LSorVgqbyajdG9a5CweEfpBn2AGuA1FqfFeH
	0Bh4G5Q93+nFbQUaIWZ7QuWBD9YUC65QhiDwHwZXsNDEA9VsggOkBpudTNcNTXKD
	Ab/ZOtD1S9BrX+3ntI6/pToel4cro7LaedBU5haQ4/IdZV2RnFP4w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cv6h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EJlI9X021906;
	Mon, 14 Jul 2025 22:55:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r2yhqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EMtjws56754606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 22:55:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0029958056;
	Mon, 14 Jul 2025 22:55:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF24958052;
	Mon, 14 Jul 2025 22:55:44 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 22:55:44 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v5 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Mon, 14 Jul 2025 15:54:47 -0700
Message-ID: <20250714225533.1490032-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250714225533.1490032-1-wilder@us.ibm.com>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SYMe05-dRYv0y_uckJyLonCgvHu0SAwQ
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68758af4 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
X-Proofpoint-GUID: SYMe05-dRYv0y_uckJyLonCgvHu0SAwQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfX+Ou0ghhVRv2z azYGz1xSTxXkTvHoqR7xY2ON7/VOqbpdLswCyST6G+s6EGqfa7B8LL+7GZJZ95uFughSnZQUx7t T3fjQbA4z21bDLuTlTIAQhnCtOge8cKbU9ginEc/Yf8ujU67G/WD+hi8RTdCXqGzsz8lA72Vys3
 g6o/N8lVLuFxxkW94U0KMffMsjU3LQzKurldvg7Gm3gJ36xrHheBMvsj7+qb1ailOECTxAlVd2l 1NMM/RhqQvtlF7oUqboAQap8/Uspe2P6FKC5nuOfhvISeLixlbK1SYkqsr0BCKWA/LnnF4iFb6X n5kFL/IIHnsMZI6YUKaIvtt5k1N1/jQEQbqxMGU+C2WcJk2kRbsDBDUPePtr7foDMugOu7XZd52
 mOd5foPkNzb/xdedEPBfsMp5ZuLWC7kgSEBdRtxFPrjrfi9DwkxjtfJBu/gqns+XVKxuk/N6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140159

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


