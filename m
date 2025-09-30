Return-Path: <netdev+bounces-227254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADABFBAAE39
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE9F7A2BF2
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995A1F37DA;
	Tue, 30 Sep 2025 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AYy+UTNu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC071E5B71
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195774; cv=none; b=CmOxzgwzTJSHUzaxImYpXjRoa5D0dyGiDonr5DtGQ3+QPSAj+UISIodf2ikWvnYDjYfinfkbH/MnBVsupZCjDF5i+qiH2OuyWydJb+Jggfm1nAmKnS2z8ZLt4jCecy/g7yPwOYcM+ukb83UNQyADT0xF9AtLny7pdsCxfzqSuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195774; c=relaxed/simple;
	bh=8Kpl6hx8Cv8z6i5PE12EBxs253An2iAGJOjhj3NcToA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW1u/i1kGsf2+FiQSLh2e8aPqcv+HOWnEPMeMAj7mpprL3ZOIKNKF2dGSFy0NigQoF6FMZQYj0ZstFIXKuNcZQ/ASKfGvzPDRPSE1KGNpNHXSh6b23q8hyJe8EMbKeNWu3HkfutHXn1AUwV2dkUWKQLjjYrJncuC66tA3TIeSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AYy+UTNu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLGEhu026037;
	Tue, 30 Sep 2025 01:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ICk9nDPphWyHhH5W+
	z+GLuWpol1yXkeeteqskEWs5TM=; b=AYy+UTNuZ6eFoEfstPJC7fwxCiio90fx+
	D6aMCPflySKZDBVm8jAOJfu4S79OUcjFPgRTLcJ8hQbOkwbjfAWECwWjzVH40QCk
	9kIEx99e1eVcNy/Y1WteIUVEm0+IZ6EzFBim+nelVBFjFg6/Mm7rwXHCi+XbAouj
	gMeV7cm1KLNpQ2VfgztALukxLBmtFwYpppVv7sA8Og1RB/9db57dE/aGUimWZCTN
	XXK9ffg3gdS4anBbdrmXoKofolZW/WFqWG1so8k/5yRhcxLvqam2g3KNtMmajsdP
	aTZT380VJ9OvarUX2KpfdjHc51MEH1oR59IsGfgPQjiUv63mCHlkA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e75shx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58U1T8rv032143;
	Tue, 30 Sep 2025 01:29:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e75shw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLQT1S024121;
	Tue, 30 Sep 2025 01:29:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy10par-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58U1T4cE19595852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 01:29:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE8B958060;
	Tue, 30 Sep 2025 01:29:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 628995806B;
	Tue, 30 Sep 2025 01:29:04 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 01:29:04 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
        edumazet@google.com
Subject: [PATCH net-next v11 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Mon, 29 Sep 2025 18:27:08 -0700
Message-ID: <20250930012857.2270721-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250930012857.2270721-1-wilder@us.ibm.com>
References: <20250930012857.2270721-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9YoHw9Lw0gz8bnZO8i-49Rkjz-SaFoaK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX3YbmfMiRHNGL
 p0XM4Ovu02BccrdKS083z6BiRCTwKqtpby7ED64g2PshOplXJPDMjivIj3fTyMGJZ6QL6V4Fncc
 xOQyOHQc7Cea986pBPxamHQt8JRA6Sj5Do9iGikZk+GlhOnZDakrKUPwwuY4VUhpzAdX3Lr9ZHi
 rPj0ezoHHBI1zvG+t0U0yKX8Xajeol7UNngVy+GhOvU/fXzkHGdOKKNyHDwStKFSvV33mER9jHT
 2eRWexSaGAdr9aDKo60gPUKFOV6WROVM2/z32XBrMRZUqEI5u84lTsxCZFNu3a5JOjfXVNxM8dx
 ucGy0gRS2hkq9JZwmxRx7R5c35GRrYvQ/d385f+0mXVuX3MpnCgdO4JAgchfme3KVu5CjrCptAn
 6tPXQZmzR98bzMRmqNJTKzpAkPvX6w==
X-Proofpoint-GUID: W7hEfMKax-pERHZcVPIUywmHN6TUzJjK
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68db3264 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

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
index dea58a07e4cc..e3eb5fe6d1e8 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -87,14 +87,15 @@ enum {
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
@@ -169,8 +170,10 @@ static inline void __bond_opt_init(struct bond_opt_value *optval,
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


