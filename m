Return-Path: <netdev+bounces-206898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA0B04B18
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2234A52F8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DC927FB28;
	Mon, 14 Jul 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SusN/Sk8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5627A46E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533761; cv=none; b=YsqwwQgzZFDtQlTjdURe1PxbaNqUNY3C/kBS8MCEBBwTf6qnhAO0F26dwXbdratS9sSrN+5xLiWdIW9CCuiHvDKultAAITui0P4uXmTzcjRbKnbCu7ldDilEBLelqIYYECHZCcE9NddfDH7h/vGWR1pRry21DWJASLUOwyLTGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533761; c=relaxed/simple;
	bh=H2xyD/eNpJS52rY9MoBjwpnCMxWLnR3gDjYtG78ZgOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSfMaGkSCeSGep6H7aDbP8Z0zPu3LZD/I0Sn98EIM4PLliMD6Z3ywxutG1sw5RuiqcN7hO9B78wYcG/adEqDi6Qxtn09A3BlzdTkmjUzGzQxj0wR8aaSye95a8zBpLjVpTbZT/2AXIqBC8GfBB/coevY6eXDW4P1F1kt1q5N5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SusN/Sk8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EH8XZM002668;
	Mon, 14 Jul 2025 22:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2sFnjqt+4GtdH/bH6
	9DElkubW9243ug4MetFjYPGkMA=; b=SusN/Sk8t7JgEQPFt2ptmvP14HcLRWPAQ
	qUjPRsqKdCatgq/3YdPXcffd1/uuG3PVWeyPGiYtCncuRgXB+Run/TZk+AWzzFnb
	vU5gN/bBQP/l4Urgekum13FxBskXAtj4ZCcNJcXyGuuXkcNj8X+5NkTe0q0LvSqc
	ufY3UsJWlys9EdTEsgAHwmAbv+PQTUs+iKy8j9JsNsk4BE5rTijz5e031n+oTSKZ
	9mQO+W7LI1LSLBZcU0KaBB24vpMWFLO+tz2q91OMQJ/siD8O4zXfecWcpgD5NIDW
	C9Ic9zGziy7i0yxzNFsU7Fs61Y6+Re2PSP6d7m+SuVQYJ9wOYsEww==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tv0jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EMhKUu025987;
	Mon, 14 Jul 2025 22:55:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31pfwc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EMtjv425035332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 22:55:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C387958059;
	Mon, 14 Jul 2025 22:55:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E92A58043;
	Mon, 14 Jul 2025 22:55:45 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 22:55:45 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v5 3/7] bonding: arp_ip_target helpers.
Date: Mon, 14 Jul 2025 15:54:48 -0700
Message-ID: <20250714225533.1490032-4-wilder@us.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68758af4 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=foHp8GwuVaWwjksxq_YA:9
X-Proofpoint-GUID: nanh39WTc0jFSVYpibCywj7TAsqHNjCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfXzS1xk2O+iOBG 4+AgB57tNncyUylQbKOsC8HtJiNpa1Y3s3kk4TRh/ebCRuTVn+wdXZ2gIS/3FhCpdSCecG28zND vKZGf53dGKT82lnFFqq9mZAYhP87zB2Eu69Zre5iUQYcxrO29k89tDY8ELhXdw4ikYsCGorAyc/
 JeRtV599EpiMOqduxeZivogjz9vh+wfA7j4tT76lG1Mf+b4yUVIq/KYzNnSdLCFT0hGjhwhmA1N kdqrMjb1/qcKJjYW0cFsBOCTBFSDxNavF31nDqYLCjwOrmAVmQIB/dzyIPfyyx7Q1YKHw2ZRV2x 1BwnHLaDlppRKWqNSBptLbvPlKydCo1okKpJbOD7rNVJSUor/XojhswGy90FvoCedxFx10vfCKc
 OmFOCEZAkviKLd+g8D/50cb3iChKAhegJA5Dg5eQcQbupOqF0fVMG3XLsvzf/K/9tWNgAnws
X-Proofpoint-ORIG-GUID: nanh39WTc0jFSVYpibCywj7TAsqHNjCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=707
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140159

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
2.43.5


