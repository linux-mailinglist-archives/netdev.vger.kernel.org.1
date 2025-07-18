Return-Path: <netdev+bounces-208251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B639B0AB6A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2878D1C823DB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B81021D5B2;
	Fri, 18 Jul 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K8TrN0Tt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D0221275
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873901; cv=none; b=nQf1dSN36QmhbHtBofcRxjY4JIPvojMU03rDBE7jtIaqeT01nkr/zphTOgkEXav2WSD1KXaSiCXcpgSnqvYjXzNlsE5NdmR+eKWNwfbt8OD0bFF2HTP7KKnaL4DZ1jbF5bISVJIXrno+ULgRix3/y4knVpzPspb7cEf0eZQcsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873901; c=relaxed/simple;
	bh=mB7J/RP8+7JSRzYPXzWqBBX6BCy7v2eoH2/kjSzPkLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjXXg1zqxp0MI3YbzsV3siudlA45Bzzc9cwR5LjgZJ0s6enDisdksKjPZ6SSUzEHYK8BoKR16ccr8L6PxkHnU07lG0rnHZoOugp3P7ImPLQ7hyO1YFQE1PZo1MIdmGS00kxmqRq+2D6vXFmxMLLPoMNUGCKz5JB4waCjSfhq5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K8TrN0Tt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHFUW6005950;
	Fri, 18 Jul 2025 21:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6D00UZaX/jLB86xd7
	dmdbvISGJfrD1uZlk+uaAjkM80=; b=K8TrN0Tt8blSYfltLTJNvCVwaw0BOVtLW
	6fH2ycmfQ5KCBdpblcjKTtgJBpdZBQvyzE72dr1mygAZbyMiX43qGsDrZXWbNYtb
	oK+F36FG59EdHT3dQ+Q5G5Zz9TCFiszDaO09L5CWCmvUJE/Lgk1sUdVjYh6bPtg8
	Fz1vytSFhw9ID9SxIkL/GAf513JCkpm6ddX4Uzr2fLoNDMbKHWgqkkAqi075ogJK
	rP49Umdb6+HvdYwxjtf+gtg+YlDXoLriUuJxYWN3/HQt+vs6u72+SP8Jtm1sTKfU
	Hftfd3BF3GJo4JgrleVIP/uZcjH8lyv6ZN123S+DG+/bepOwAVCKg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7dkhu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IJZ3M7000722;
	Fri, 18 Jul 2025 21:24:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48mjtum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:49 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ILOlAK15139530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:24:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D9CC58056;
	Fri, 18 Jul 2025 21:24:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187CE58052;
	Fri, 18 Jul 2025 21:24:47 +0000 (GMT)
Received: from localhost (unknown [9.61.165.151])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 21:24:46 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v6 6/7] bonding: Update for extended arp_ip_target format.
Date: Fri, 18 Jul 2025 14:23:42 -0700
Message-ID: <20250718212430.1968853-7-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718212430.1968853-1-wilder@us.ibm.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QMetK3Syunxh9kKB9raR13Sj6LoKVcCk
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=687abba2 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=rW1rgPF15oU2z4qWOn4A:9
X-Proofpoint-GUID: QMetK3Syunxh9kKB9raR13Sj6LoKVcCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE3MyBTYWx0ZWRfX1E31Q9jJAOdk jKKx1HKMbo6MyXHPzUD2NZjSVYMPRD2GjebxSDL5USwHLaSdpARa57ANe/PM7uIg0S5eLw6BRrs Ge6BHmtPWL+todomhjlIp8VDCgg+66bR82GsUo0hzIm3B+0LFjaDnMJz0PcWut2A8c9gjqJxi7l
 itZAxzrpeiMjYkNhv+0y7GuHaODAhvJYqFW4ButyLXDwxI5GhTJyUKeX4z1rGqldg/DZhSyEyVt Euwcelmt6SgO/cYH+XG4GeWafhNqxJDy/cb6Uc5gyo9z47g4EdfX8HkEahCh1MZt9Rp7ShruzAp t310v5YID1weCqqVsJp+E7BRvxR5TSfCRl28vxmwSbmyUnq/kDCwDWRmPypk/5fW0XtuJTqpLMH
 8nSVLizxM8/Q442uvZSTJrbU2nPw5zC40QladS7zqeXIqV4WjD7g5h54g1CpVxnKlB4g4Oi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=698 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180173

Updated bond_fill_info() to support extended arp_ip_target format.

Forward and backward compatibility between the kernel and iprout2 is
preserved.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c | 29 +++++++++++++++++++++++++++--
 include/net/bonding.h              |  1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 5486ef40907e..64d314dc3c7e 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -701,8 +701,33 @@ static int bond_fill_info(struct sk_buff *skb,
 
 	targets_added = 0;
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i].target_ip) {
-			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
+		struct bond_arp_target *target = &bond->params.arp_targets[i];
+		struct Data {
+			__be32 addr;
+			struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
+		} data;
+		int size = 0, level;
+
+		if (!target->target_ip)
+			break;
+
+		data.addr = target->target_ip;
+		size = sizeof(target->target_ip);
+
+		for (level = 0; target->flags & BOND_TARGET_USERTAGS && target->tags; level++) {
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


