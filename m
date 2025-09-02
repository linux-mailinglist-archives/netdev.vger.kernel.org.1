Return-Path: <netdev+bounces-219293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13423B40EAB
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A778F1B27E12
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34221341662;
	Tue,  2 Sep 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m5bsDFPd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6742E8892
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845849; cv=none; b=i70DiFz2BVsM12I3TvTOlbl8nwWxveU4mRMvnpaNGJRh2w46LGgcywkTxhmvfJRg+YEd9upRK4JFSg0OvUMhpwwL57NvkfPcY4DExrDPaTUZQd64QzedJgLmZ64qhF3XBCNdYXQSvGEnLYOQ8ApNJuC8kUecnr/8IanGWyxQiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845849; c=relaxed/simple;
	bh=MQKjuBZ9jF0mckpOwYWgkpLyoNZW3UsQBW37YZIQ/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyClePn45X1lgB7POoy1BRlyi9gawvNpcKxzOHrP68n9tBS9jDnW1pTDTNMZMAjScCwIIWdtNaze3DTlSpoIukZysVM8oXxR4D704u297Ywtdnyjgfv7M+prAySs/B8UfEZOf8eJLgEuoWeQF5UljSwZ3aC+zLsfMOCHQqNtUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m5bsDFPd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582D1lBl032366;
	Tue, 2 Sep 2025 20:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=krOeWezkgS9V/GW/N
	Rvt9U0ACSBl0zTg6ypjslaJSJA=; b=m5bsDFPdo1wjBbCwv+Dqhkyex02ZWpdS1
	kyzQZkYGT2y+784w9ipsmr6RX7nisAmEFaOpgr8FsDyXDc+3Z/8pn2cKmTOihMuw
	/m/J7tbqNLfY04w0oFxxrPMH+VCBH9AVjRtAKoh3TFlOg29/9HgO8jkFpqxYyNrJ
	SCpilK0IEgRrsyuPd72JU9okuFP3oM6pVTNYnlBiZ+U9NKGrFGbacNQmKNG6jBbP
	6dzAMCiyoew+5pNLeCq/fBGKWa9jxIPJlBoGp7MP+rpk49IFZgSbGm6gXzhYEsPX
	z2uIB5uZ7wtgqjul/47kf+Or1j1MrKuQub0ORJDimHFIZCUIviNfg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshevhdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582HL3Dr009059;
	Tue, 2 Sep 2025 20:43:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumc6bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582Khp7m24707672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 20:43:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D745B58056;
	Tue,  2 Sep 2025 20:43:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 918F058065;
	Tue,  2 Sep 2025 20:43:51 +0000 (GMT)
Received: from localhost (unknown [9.61.19.179])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 20:43:51 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v9 2/7] bonding: Adding extra_len field to struct bond_opt_value.
Date: Tue,  2 Sep 2025 13:42:58 -0700
Message-ID: <20250902204340.2315079-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902204340.2315079-1-wilder@us.ibm.com>
References: <20250902204340.2315079-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vaclvKizeyEp-B2PBx4W4N2gj-yzq7Wr
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b7570b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=zofNYPC-ylGwukCjRwUA:9
X-Proofpoint-ORIG-GUID: vaclvKizeyEp-B2PBx4W4N2gj-yzq7Wr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX/yb1iY+TfTBE
 Rvi0fgaEFJN0dx4nVpVNym9ywB+ARQieMhBnbQUUW33KmXTDjVPT+FAzyMc5VDT+qnWPxI8MJC1
 ggHH0wmWLNj52qMUVOoq6TxAtqHil8viirkoO03s8v1G5r3pIwLU/0MM+O0NGrVCsT5fWScb6w6
 hEwHzTWF2/tQgjngerxRuGzPyinq45TqBRuORbtnXy+uc0CmXx1AIeDmBROZDKEN3OMxzfkdkD4
 5dBMLap6sBXu1gla6f36Pe7PJP3nGljhpuApqPNLiE0cYyAkzJlKfEMrEWUQ2nb5AmVEwEjbBcM
 7ixy7kbm3aXUqCzx3b4/y68MZ5x6iDtChY8660e7oH9Efb9bpRJHdtOsLaakQGySCuO2CQ2C9Dc
 MFN5mmoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

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


