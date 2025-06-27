Return-Path: <netdev+bounces-202036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F89AEC0C8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A253BBDA3
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED582288F9;
	Fri, 27 Jun 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X+/CnQy0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FAA21D3EB
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055589; cv=none; b=pCf2dBNC4TK4x5lXkgNTYqFxr0uujzi1JIocy+v1eKXYr5JGyvt3G8G28+8Au69tIHmJXyW1wXr6dtCFoMgIT6xo9Gi8Sks+Ej092Q+qkAv0ew34KDUs/JO7VT4e8Zy6g7tQdcRSi+QBjjiDAqdaW5h3Prz3LnPW+9RZNZUAmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055589; c=relaxed/simple;
	bh=BNQktyJqV5pczRT5VBo+LbrXBgOuOi9P3o5hewZ2qEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzaHNOzl+WojClpf1x9wR6PMyzUdJgY+0vA8RoKkWxvDVk5ybR47LRnamiALCnHOUl62CIRueQR9rA6SfkWW3Iv2uKdTorkkvaae7QovaZ+G+YGo6XGe/xOJjIYK0EkUr3w7pEGN/N1qSn3mLRJVVOUkDJTQ4VyJhRCFHMP3Vdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X+/CnQy0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RIw5ub031446;
	Fri, 27 Jun 2025 20:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+IOUSljmM0gTe8kTA
	dl0mQHZR8OD9THTquGL9H6MnFI=; b=X+/CnQy0X5NiGy9EAS1iMNChggjHRS22D
	Vu9qLoeAedK3AogBzCLrGS3HWIxLPGHTwNfGZkGZIX9KR6xsHZClJ2ZO9x/RTyRj
	3AoCWqgSwXy0pokeGttFVH5Imepzg/tWMnPIf1QlqxxE1KdwqE6y5+7a1OiaKZik
	D8o9XDJSXg6MCMJmG6B0nU/eocqv55HEN3EF0TNNJ6xy3FRJpX8iUBcQbP6qg0eq
	7/dwpnXNjXQEyAhV6EWnBS5u8QpYPO85t8iXBnH4OHsre1ibOOBlsM9xJupzvpEp
	CuWzsBdksA53Uit0mDeqrT98fabCKE+HhkXVLPvhy6Jbw3Hqzj4Zw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk64faar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RK5w8N006329;
	Fri, 27 Jun 2025 20:19:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pny9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RKJe8E33227484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 20:19:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82CB558043;
	Fri, 27 Jun 2025 20:19:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53F5A58055;
	Fri, 27 Jun 2025 20:19:40 +0000 (GMT)
Received: from localhost (unknown [9.61.49.21])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 20:19:40 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v4 6/7] bonding: Update to bond's sysfs and procfs for extended arp_ip_target format.
Date: Fri, 27 Jun 2025 13:17:19 -0700
Message-ID: <20250627201914.1791186-7-wilder@us.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE2NCBTYWx0ZWRfX4we2gIsbxbji pIYnQG+wI/IrKVUOm1MPAb7oHfoAdYaykt6/HdR3SJBoIGFqHeEqsmYdGRnUVWPoom6I7gOA8Aw AhSqsj/RQRAmkhr5eu77CV+qZxjzHGobpcdX8W96xm4xQglyvo/pwq4uMwh6x+dacyDMk0RryoN
 LLosNuSmZJkFtDxaQm3DrvjmnrY/q4khTaC5BEQ7otMjmB/3yyH3xR2Jesg0abKHSNtIokd9qnf m32ZTAAeY4bnUba5xRkSoUiIT/FEqigi21ADdBXPFpOHYrc7U8+Z1yNYn1WwtU8+4mrl34dzQo/ p6SmBkEwcUaY/IrTg3si9rmLrFsrP2NIGB3C/bhBRl+86zVHPErMpkN22xQzZKN7IXsQsqhDyDR
 D7JumpdYUd5RKGc3AHmyKQOQsuyZy9mN+qp8PtQYhWFwV6F4MIOPphOZzpukmPEWZdV/Oa8p
X-Proofpoint-ORIG-GUID: cAVJB13dZT4GlGcbdg5YRFrsfi2IYlXw
X-Proofpoint-GUID: cAVJB13dZT4GlGcbdg5YRFrsfi2IYlXw
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685efcdf cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=ygcmUIgHL4RrXh-d5QkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270164

/sys/class/net/<bond>/bonding/arp_ip_target and
/proc/net/bonding/<bond> will display vlan tags if
they have been configured by the user

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_procfs.c | 5 ++++-
 drivers/net/bonding/bond_sysfs.c  | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 94e6fd7041ee..b07944396912 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -111,6 +111,7 @@ static void bond_info_show_master(struct seq_file *seq)
 
 	/* ARP information */
 	if (bond->params.arp_interval > 0) {
+		char pbuf[BOND_OPTION_STRING_MAX_SIZE];
 		int printed = 0;
 
 		seq_printf(seq, "ARP Polling Interval (ms): %d\n",
@@ -125,7 +126,9 @@ static void bond_info_show_master(struct seq_file *seq)
 				break;
 			if (printed)
 				seq_printf(seq, ",");
-			seq_printf(seq, " %pI4", &bond->params.arp_targets[i].target_ip);
+			bond_arp_target_to_string(&bond->params.arp_targets[i],
+						  pbuf, sizeof(pbuf));
+			seq_printf(seq, " %s", pbuf);
 			printed = 1;
 		}
 		seq_printf(seq, "\n");
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index d7c09e0a14dd..870e0d90b77c 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -286,13 +286,16 @@ static ssize_t bonding_show_arp_targets(struct device *d,
 					struct device_attribute *attr,
 					char *buf)
 {
+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
 	struct bonding *bond = to_bond(d);
 	int i, res = 0;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i].target_ip)
-			res += sysfs_emit_at(buf, res, "%pI4 ",
-					     &bond->params.arp_targets[i].target_ip);
+		if (bond->params.arp_targets[i].target_ip) {
+			bond_arp_target_to_string(&bond->params.arp_targets[i],
+						  pbuf, sizeof(pbuf));
+			res += sysfs_emit_at(buf, res, "%s ", pbuf);
+		}
 	}
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
-- 
2.43.5


