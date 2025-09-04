Return-Path: <netdev+bounces-220172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C34AB44969
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0C3176CBF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533442E88B0;
	Thu,  4 Sep 2025 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FLwwBMAi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC72E8B73
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024415; cv=none; b=AyYa62UpgNLhN2gYMkR1jEutpna9W2aMtJJ5/I7W4Q+tPtXKiNASzMdP6/OHUbQ3a7Y0EIUbLZen/rgGJ32YHsfavcSQV05peHqpqlKhHgAerczSNw1re7pLtlxleSpHQCC+YdMlRCh7CZTFDysx4GSrMrbWu3aoYvlYj2LFebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024415; c=relaxed/simple;
	bh=MQKjuBZ9jF0mckpOwYWgkpLyoNZW3UsQBW37YZIQ/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bd+qQa8ghHOnyl9r2K4YJT8n2gDKZis02Eg4TitCUmGJwkcokI+KbFDeLXTZWT/ETjRqkhZ7n+X+4XH/JXRFyACO+XAvJ2i5mN6mLom6tikhiltqLePKvfGtk843iewuVRs5PVLmI3KGC/AmmG8XBbV+6ya+p733SLf5MuB1D+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FLwwBMAi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Cut4s004664;
	Thu, 4 Sep 2025 22:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=krOeWezkgS9V/GW/N
	Rvt9U0ACSBl0zTg6ypjslaJSJA=; b=FLwwBMAieZtu1Y7PAtb+H8P+tTZM7PyHD
	iTm/BSRVJ/pLW7K6MDWt9hwocCsixbcM2nGRY1Q1OgCVRz2JaJ1B9FCEFCarDC78
	mLJf2M3KZZOV6Vo4dj9XpOL/waUg6YyqoqNIq6uXz8cDoKmvIdVXo+I7zUs/Ipoi
	its575FznKTSgPbifEJN/T8GEBxlhMMb5Iz9R7yAy6NRVdfYaCyOKCZlE1F8O0nI
	SaYYa0cpZKJXBeuWS8bHYSgN685VNxXodkpybHmw8AwdPTt7EFAYXDqeAtF/AF1P
	icKMLswgNJihv6zlGy4CtyhyduLTb9j7iS7FwlMIs32H2Xy7KU4mw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuacbx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584J1bju019412;
	Thu, 4 Sep 2025 22:20:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n6jmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:04 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584MK0sr31720182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 22:20:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C306D58050;
	Thu,  4 Sep 2025 22:20:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7665258045;
	Thu,  4 Sep 2025 22:20:00 +0000 (GMT)
Received: from localhost (unknown [9.61.141.209])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 22:20:00 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v10 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Thu,  4 Sep 2025 15:18:20 -0700
Message-ID: <20250904221956.779098-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904221956.779098-1-wilder@us.ibm.com>
References: <20250904221956.779098-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q-6V25wu5bvbx0E1aP4ElAIiUWe_qaT3
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68ba1095 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX0aPLcFmx/Cr3
 in/jA9Z4IPyDgNO7ftFr6dEDFSGCivpHOTq9ootu0zgr7WFSTj3Z455eujTdOjbjJ2rJwCQPN4C
 ycINT3s6DRgEGJuoHJZzghdIW741dFGIVknlt8MGjK/txVvdMeI2yXnI86zT9WB9eXK2T0gYXVS
 C+N6RpkMxL4Y51gtSjDMofyAxW62UH+l3u4cxnsMWwNwt/PysWwZO4AMU0Gpbde2lhApm+kPVwB
 quGRzSi7lWFeTojF1jPVTZJ6Q+kxWkE6zqNNBJnazFTMVbLm6OVaynTElQE02ev1WLX9mqdDdYI
 87sGvK4HRq+kepYz3igRPfLX2KXoj92kjjbVjVuvRCU5189XREk9gA8rbEHxCu9Tj86lQmXIpY+
 rxXtFzNM
X-Proofpoint-ORIG-GUID: q-6V25wu5bvbx0E1aP4ElAIiUWe_qaT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

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


