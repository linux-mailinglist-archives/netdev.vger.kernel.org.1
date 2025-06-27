Return-Path: <netdev+bounces-202033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A6AEC0C5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0523B23BA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660C21D3C6;
	Fri, 27 Jun 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oGK07EL9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFF212B28
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055587; cv=none; b=q4kwsWcFktXK5hC8jvgScbCdw1eAcD1rZkpS9jT6tqfKLuaqUl3cTrK2SyoPQwrSm+Ym1/12dqPzQYeNJfpz0FxjoY/ZUvBPwF/OtcEYWxmYJzpCzHDeDS+6/YAWbiPN85TOSF/ghA+y0N4EM2waRZtog/txt0aBdQLbW872lZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055587; c=relaxed/simple;
	bh=3sX+zqjgGfvnnd61YIaXZ+zaDhb0L0fhTerM2fcHxRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiJ+MO9qQ1oAl3efvsFKBZhOI4xwBBVxSFvtFPKM2uGAfOykUXqaVNz1DtjxW14etj0i5Q5N6tlblSvmHZDxDa8kFOtzbl48XwE65Ku0wyBFHvz1MVRpHBq/fXXWlBGATSHVZH4jnsilWwLNBi/iohAtfIr6B9GE1xijd5pGv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oGK07EL9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RHGgSs019612;
	Fri, 27 Jun 2025 20:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UEf+sZfgVB5UCHPB5
	BrVjsX+/LqDyH0wCwpDV88LMJA=; b=oGK07EL9NF6MdPKnDffoc/pih2lomI4YL
	ULqq/u+HTQpWuc7f1ECEImMqKhofQZfseK6xe7NRpVk7pVi4QwCch0xAY8EvAVyw
	gbEbcwqcdLRYhcikgU1Nm9q+YNuwCH2bcla8mpDdbtPJF4DP/c/AbnyrHYY9DwTR
	ymXvLSWUWt1vMxH4eevSpQrAP7jBrYy97XkMKfDIaSId5e6gQFVoV3fqDYU4TO5H
	6gTlaZQGAAPd2h46bZFT45vos2oXuJpx6+R7xmd0U+PeVKzKeG7JesvWxZQgwVSc
	yp59J+XKesJ16mq3V8f9yGHTwXmyfp+804zblaPkuiAsiT5zxWHow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3q877-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RHtSVx003989;
	Fri, 27 Jun 2025 20:19:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99m5q9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RKJbcj20251296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 20:19:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4199258045;
	Fri, 27 Jun 2025 20:19:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0593358050;
	Fri, 27 Jun 2025 20:19:37 +0000 (GMT)
Received: from localhost (unknown [9.61.49.21])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 20:19:36 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v4 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Fri, 27 Jun 2025 13:17:15 -0700
Message-ID: <20250627201914.1791186-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250627201914.1791186-1-wilder@us.ibm.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685efcdc cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE2NCBTYWx0ZWRfX3WOLLL8ChfEd kPZSbJS73/IiEFO9Ct1cmrHJ3TEV62YLbfJMd6klajnZNzMpGorq2bifzmXgoEVAIgCE3tNpTR2 PpB/0hDhnzpH3WmH88WEZ9EXHGVe2p6GMyJQpoz4Mzq/hRpGc+Lo27yUUVj+ABmQScCXcGlK1iX
 2lP74z/WGsTUAsJ/HxR1PpSTOo5aA1ZOkT22uMhMTl6AR8iY10k9LeOg9GoQWOXRPfE1x4VMdJF /ZeKjc1muAjTOSMaSmLHZYEdm9dZrfT8QYEhBnWJ/nqOIZ3UpGlNuItbK5r7xidJEelXJZkT9ng YHh0DNIehp0ix0UQMm5O+OT7qbMa/EzUTK59+IdB0QHQVAn5h5jd6K6YwqPWSAcwTazSMP4OJBO
 6fvuY80Kh/cRjACmqWkeES0nlXFA6gb4RnT43nhG4SUbsJqooBjYx9/+2DWfBk+GcCa8mv3D
X-Proofpoint-GUID: Qgd1BqVKhlno6wdd1L3dC6jpkhjJBQo4
X-Proofpoint-ORIG-GUID: Qgd1BqVKhlno6wdd1L3dC6jpkhjJBQo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270164

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
index 0a7d690cb005..d5d59081a9ce 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -85,14 +85,15 @@ enum {
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
@@ -167,8 +168,10 @@ static inline void __bond_opt_init(struct bond_opt_value *optval,
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


