Return-Path: <netdev+bounces-206897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14366B04B17
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D76189DF63
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB527A123;
	Mon, 14 Jul 2025 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DAd26BX3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27026279782
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533759; cv=none; b=U6ce0pwniW+MOtc7WpFuP40+wITC2tKxwE92Bd2bdp0V4kX4xTwrD9rPHaBlTT8lI18NT9Bo8bI4ubA+suvDh0euhyam1xPaGkY6uC5RXyHOgOVuApiIoZaBbP6+yK2YonxOhOfjzktQ/jx+rOR/C55s8cR4ljFFKJkey7xY5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533759; c=relaxed/simple;
	bh=Jok8URkwLlWMjHWZ3tH0IVh+tHRKtWOb8NHEOv5T18M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTH/Sv9uAm46jUBY4eOuZ7knS4Gha8iDOaKlPos91SOXIYRVZVQH4qZWsWInA9SOaMgon3NQuhix0rU9qTiDk0uWt01iMzG2qBLO58s15ElBKoV4H3fcbPr0jd2hETinUAo6JS5LA/Jrfx7gJovFIYi/mNpaOuZAW6Ia8R5XNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DAd26BX3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGSBNV008825;
	Mon, 14 Jul 2025 22:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3LrikzsQuY6dwO7qF
	PGUNvQ5Ae0dayV1rLfjzNdwE1M=; b=DAd26BX3ABVJ6bdShtnElPARizq2h6Uru
	bvDgkRky24DWWe9175fIcXqZRU9EI2Bq2GJjTFnu6EzFUHXYwqIOKVbgc0Q+PCFw
	tnTTtkX9WI6sXcAKt7HfSPXKkLQ6NhCRVs9zPJAGMYSeqURUidCUvQZI8vs7m6+X
	PIPJzFOWxOphjM+1FjUFsWzCEP/sm/27CFOJN2F9NYMUWDCynUuPlJhk6MQ0Z/UB
	jgDrvAHF5sHTi5yifLqcMrbiB1tvf8/2stMIo/4N0gHcIvxFTKnE82qtUejbwuvd
	hmjWpMxNYQuswEr45xVXrzxTlDMPOaxgfAV0kMy8dS9hc5nmBCu8A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cv6h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIR7jC008944;
	Mon, 14 Jul 2025 22:55:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmfspe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EMtm3v28246706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 22:55:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 952475805D;
	Mon, 14 Jul 2025 22:55:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 553E258059;
	Mon, 14 Jul 2025 22:55:48 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 22:55:48 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v5 6/7] bonding: Update for extended arp_ip_target format.
Date: Mon, 14 Jul 2025 15:54:51 -0700
Message-ID: <20250714225533.1490032-7-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: 84cEK7LuFn5aHFRdUAkjrR4EVANECe9K
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68758af7 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=rW1rgPF15oU2z4qWOn4A:9
X-Proofpoint-GUID: 84cEK7LuFn5aHFRdUAkjrR4EVANECe9K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfX9HJT9GFRsS3D l/S+RG2p/E2eCH9f1mtRCEYzHhXwB/leFh/4y590fcV5osNCeIKsBFohfyqhTX/Nd1NCsQHRf6b IJQ9KmHc6u99jy5Kvx2mGBHxMmmPAISDpZAgY0Hwi4OQHKqFy13u5RNjiMgqfQQBJQOOzPaYTRm
 41lOLheBFY+Y1F45d1smxGP7ZQDkDyd3PHD05Letr2BTCe+ncpnsmHDwRbu0S4d2zTozge+Tmhh Cgvjzb5q6nLpZK5yZwzdtcqQMUc/joP+jFZiTfHAAReluj/tG3X8UrLdSUdL8OxuYcs6dvx9umA I+cDK32VyBWgvlWlUhOG1FV/nCpyNcgInAG26OS695JNUVxnFckZjbPnll8JuXT0/CFrXf8Ynrk
 5wR3P4E6crpEp92eWbOJppKfLPQJeoHbWFcnlQe2TrxhFgdcNIq1sAk/zQ80Blz3/FV+Kdif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=757 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140159

Updated bond_fill_info() to support extended arp_ip_target format.

Forward and backward compatibility between the kernel and iprout2 is
preserved.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c | 28 ++++++++++++++++++++++++++--
 include/net/bonding.h              |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 5486ef40907e..6e8aebe5629f 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -701,8 +701,32 @@ static int bond_fill_info(struct sk_buff *skb,
 
 	targets_added = 0;
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i].target_ip) {
-			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
+		struct bond_arp_target *target = &bond->params.arp_targets[i];
+		struct Data {
+			__u32 addr;
+			struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
+		} data;
+		int size = 0;
+
+		if (target->target_ip) {
+			data.addr = target->target_ip;
+			size = sizeof(target->target_ip);
+		}
+
+		for (int level = 0; target->flags & BOND_TARGET_USERTAGS && target->tags; level++) {
+			if (level > BOND_MAX_VLAN_TAGS)
+				goto nla_put_failure;
+
+			memcpy(&data.vlans[level], &target->tags[level],
+			       sizeof(struct bond_vlan_tag));
+			size = size + sizeof(struct bond_vlan_tag);
+
+			if (target->tags[level].vlan_proto == BOND_VLAN_PROTO_NONE)
+				break;
+		}
+
+		if (size) {
+			if (nla_put(skb, i, size, &data))
 				goto nla_put_failure;
 			targets_added = 1;
 		}
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 1989b71ffa16..2502cf8428b3 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -811,6 +811,7 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 
 /* Helpers for handling arp_ip_target */
 #define BOND_OPTION_STRING_MAX_SIZE 64
+#define BOND_MAX_VLAN_TAGS 5
 #define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
 
 static inline char *bond_arp_target_to_string(struct bond_arp_target *target,
-- 
2.43.5


