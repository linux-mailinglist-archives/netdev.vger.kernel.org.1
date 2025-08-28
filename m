Return-Path: <netdev+bounces-218020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E3B3AD66
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65D7582B74
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572E26E15F;
	Thu, 28 Aug 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LxNTr02I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F7262D0C
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419574; cv=none; b=hfF9pR0v53zviBKWYZJYw8S7+yqo+hONqLsT+N9oLvCoxFgHF01aI/w1NVpDmVJrJ17P1WT//VivOMhqCVW/v5ZPN5cq1OkVUfnUvRuJnKrw6QQLAw09Magl40v1ozK7ZtUSq0Zk6aLgw0Q4dACD580qg9iYXHAk4AjHNfyEXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419574; c=relaxed/simple;
	bh=oP/R6in0HrWODkU+mc3GB/+qcQ4oo8AqfjyuWwi8uCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEOOynxDBTvUPzFXSuHOajIKNPy7pCVZjLjDAGSlaZiZB3vCcwBa200eSln32sS9VOtdhrQPfhb3XLX5yg9a8ahUZfaGupF8toMQZIL2DBTKv6KUWd1KFUFxFj4btEGuqE9pOCjTkqM38PJxen88cOAHGy4OSFb+Gks1gfpodfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LxNTr02I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SFkRm6031616;
	Thu, 28 Aug 2025 22:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5q8WfhzWQBCS/U9HP
	KxokFDV5gyuzyaTLHkyqIBKkfc=; b=LxNTr02IeHC+K7X4ZPBFkzhuoHTB12E/5
	628hU4EdpaZE0uoGQt1c/cQACewH4eYZp83Wct93f9i24rCZ4z4gVJEij3vIykMK
	T/SdBngWdMaQm8WINW/0G9s6aPBTtAfr+w4U2y0uNE30zLwrArmtKjK/zAFxREQy
	r96+Aez73sPo5/QMnDmYUd2PVczwICb7o8arGcRxdozfhrhNtvWB7Zb3MSSYCliz
	pe6mkTYoEQ5EPS+JzTOWYVdxwsrIj2eicCtx6MlXmtxdq9VRjVV6oyOrxQoJ+04a
	4hj12C8oay2hxC07vCOuKWFuL5ef44OYrjdLMOadYqxes/L0pvogQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rw7gqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLZ4vn002512;
	Thu, 28 Aug 2025 22:19:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrypy49x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57SMJMBP11076160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 22:19:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1910358054;
	Thu, 28 Aug 2025 22:19:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4B4358045;
	Thu, 28 Aug 2025 22:19:21 +0000 (GMT)
Received: from localhost (unknown [9.61.155.164])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 22:19:21 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v8 3/7] bonding: arp_ip_target helpers.
Date: Thu, 28 Aug 2025 15:18:05 -0700
Message-ID: <20250828221859.2712197-4-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: DKqMIxm5JpEssqWzkmOb06zKx8JqM_lo
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68b0d5ec cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=foHp8GwuVaWwjksxq_YA:9
X-Proofpoint-GUID: DKqMIxm5JpEssqWzkmOb06zKx8JqM_lo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfXwl74A1eC2PVQ
 bsT6CfVynIHLVDBulYwy03PRRYJw3YPPnAHsQB1PLs07qZqpNvepgpCpSkB9X8vz2pBRifNDjwN
 6+cf4qHkE8ulsohZycap1XhHLeDvPzNGUIgkCtGn79bC3GSmqtAG2AVDo4OYuA6EBeTX2XiWAFZ
 SGue4xgu2e8rBAzpsiXbEARrhcTELS6qkn1bkPr4Q1NXI9UdBsaYcApSh0zGjC0Qe4hyx/yiBa2
 ChoBpn+u5ke5jLzBsK3tHiXz2iJofxGfzbMIaGkgdMBMSz0/uDK7rQyEJQyLZfJDlApyaL5x3NS
 FtKD+dwEdeJHto349Vew/iWSNojDoMcbuoe/S7rUNGU2Hqnron1l17IqwvVxa+7PMYgK2SoG8UO
 bnnE3mlU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055

Adding helpers and defines needed for extending the
arp_ip_target parameters.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bonding.h | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 27fbce667a4c..1989b71ffa16 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -809,4 +809,49 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 	return NET_XMIT_DROP;
 }
 
+/* Helpers for handling arp_ip_target */
+#define BOND_OPTION_STRING_MAX_SIZE 64
+#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
+
+static inline char *bond_arp_target_to_string(struct bond_arp_target *target,
+					    char *buf, int size)
+{
+	struct bond_vlan_tag *tags = target->tags;
+	int i, num = 0;
+
+	if (!(target->flags & BOND_TARGET_USERTAGS)) {
+		num = snprintf(&buf[0], size, "%pI4", &target->target_ip);
+		return buf;
+	}
+
+	num = snprintf(&buf[0], size, "%pI4[", &target->target_ip);
+	if (tags) {
+		for (i = 0; (tags[i].vlan_proto != BOND_VLAN_PROTO_NONE); i++) {
+			if (!tags[i].vlan_id)
+				continue;
+			if (i != 0)
+				num = num + snprintf(&buf[num], size-num, "/");
+			num = num + snprintf(&buf[num], size-num, "%u",
+					     tags[i].vlan_id);
+		}
+	}
+	snprintf(&buf[num], size-num, "]");
+	return buf;
+}
+
+static inline void bond_free_vlan_tag(struct bond_arp_target *target)
+{
+	kfree(target->tags);
+}
+
+static inline void __bond_free_vlan_tags(struct bond_arp_target *targets)
+{
+	int i;
+
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].tags; i++)
+		bond_free_vlan_tag(&targets[i]);
+}
+
+#define bond_free_vlan_tags(targets)  __bond_free_vlan_tags(targets)
+
 #endif /* _NET_BONDING_H */
-- 
2.50.1


