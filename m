Return-Path: <netdev+bounces-228985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8ECBD6C9B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3203A92B4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8262E2F1FD3;
	Mon, 13 Oct 2025 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="puWkVoM2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7D2BF00A
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399647; cv=none; b=PL5W7okD91SFJ133dLIaSK4MEUQyzPRL9teBw68JlCP2Cvh2G8HXeyX+mGyY0g1v2VDaCbMmchXfnGrz2L/1Od3vI3pQmGJqN8+BxOT66hrzf2RuAEZeriEMwHxc1NLfJ49Pzg1ZrexiCoY+3+tWVjglU18a8l2tw64+RbxKIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399647; c=relaxed/simple;
	bh=vwMXNWdOXoryAkZMxfbI7kzA0ajj9ZRb7VcwF43tF8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxqldH2Kz+reqsSS/rQBkH/HA999h8ckT99n6rBTtHVcC1QMt85dIj4WFL5lbDqAo6VKNx24zmIu2h5U1MpCTF37iiJin8JwQAo0+gY0lQtTRUqYNRxtWD8oHvbQyNfw6vgi6aiFlejrJR28EglodtMlAZpUjPROIajiTsWri4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=puWkVoM2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DDAwTF005409;
	Mon, 13 Oct 2025 23:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NEqb9lGAGZyCyh3f7
	LMrGk/6raU1cbHmH8oaNRsFzIA=; b=puWkVoM2Yv0irbpCkhdF33ROsxR82MPQ1
	uNdxO7kE6YiZfVsIiZ8JDjDIFldOoro/sndmzDF0VkxI9RsHeLNmjl5+N6J99QTG
	FhTCxqCBzUGDaTQGPsiYEcj6+4LzErFRTI20GgMXNb+EgudAhLwtYoo+iTdV8v5t
	M5cjdd9pfZaHaCKS5cLbtuGTRrqqsl60qtdSQPGFAzZmUc8Z3DEYlguYdlgnxsDg
	/0IhB8Cl+9xKLvZU07Y5OymtLN1F+M7yGH1mIcpTow9KCQqyHUP8X5/wfgnE8nQA
	8Qlaw4kHKuB1HI+UyaJ+at3CGvhX6RIT+7EmTnuRoWkIl6wlIxviA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewtumk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DNmtss019979;
	Mon, 13 Oct 2025 23:53:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewtumk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DML1Pa016745;
	Mon, 13 Oct 2025 23:53:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jr7wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DNroMA58786232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 23:53:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A1E58056;
	Mon, 13 Oct 2025 23:53:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6213758052;
	Mon, 13 Oct 2025 23:53:50 +0000 (GMT)
Received: from localhost (unknown [9.61.176.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 23:53:50 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com
Subject: [PATCH net-next v13 3/7] bonding: arp_ip_target helpers.
Date: Mon, 13 Oct 2025 16:52:48 -0700
Message-ID: <20251013235328.1289410-4-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013235328.1289410-1-wilder@us.ibm.com>
References: <20251013235328.1289410-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AEWbTD_knI7MCpDKZ6P8gdnQMi0-G05P
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ed9113 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=JskuJHzKiSc7y_Fx0koA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: oSSMutjUZUByfGJlfgAB9SvihyWTr4p3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX/oRx9cFmBJvo
 OQaN4RmAvQ6lzDbMfRaDRtU43Iw/X5zN4i3VsXzNasSrlhIWLeYVOtmfEaUh0e3UxZ2DOAG27Cm
 uTH1b2E3nyu6ZEi5ABa+tCxG66epkpINYeGG4jGjKDusN/BvEdoFuarC3JN2UkrzW+2iYVE2I9l
 tdUWjmwx5kSpzR6NYLs+ntSmuDjK9xnbqbCZTWVx6mR1PLUgHGTA+MlyvRT2L85UFbuJJa/GyQu
 P440OisQVh9z+4/Wxurz2xzT6smg/nLf47nsOZUQiz2xeSGzdH0/EiawK0ope/seLxLh57F2URE
 8NOi8Te3kvT1wxPLpgvBHHGMhYv2BX2ovQ801MMBF62glLk0iWiERHULkkXRPYGgsop9WCHvPUU
 eFP6+TcqjXsatn0L60pJHZPdigzGPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Adding helpers and defines needed for extending the
arp_ip_target parameters.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bonding.h | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 3497e5061f90..62359b34b69c 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -809,4 +809,54 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 	return NET_XMIT_DROP;
 }
 
+/* Helpers for handling arp_ip_target */
+#define BOND_OPTION_STRING_MAX_SIZE 64
+#define BOND_MAX_VLAN_TAGS 5
+#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
+
+static inline char *bond_arp_target_to_string(struct bond_arp_target *target,
+					      char *buf, int size)
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
+				num = num + snprintf(&buf[num], size - num, "/");
+			num = num + snprintf(&buf[num], size - num, "%u",
+					     tags[i].vlan_id);
+		}
+	}
+	snprintf(&buf[num], size - num, "]");
+	return buf;
+}
+
+static inline void bond_free_vlan_tag(struct bond_arp_target *target)
+{
+	struct bond_vlan_tag *tags = target->tags;
+
+	target->tags = NULL;
+	target->flags = 0;
+	kfree(tags);
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


