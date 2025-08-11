Return-Path: <netdev+bounces-212647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D347DB21918
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CB21903EDB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7C21E5B63;
	Mon, 11 Aug 2025 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p6LeUBSc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269011A08DB
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954373; cv=none; b=Mf5JCnt7+tGF6JQ8bqwVW4mNxa5BWb3OKfU65KVuOZM4kYlc2Yang+pnR7F84pMgG+brdVcf5tdjcdP7J16yqx6C4KXVTYFFg9maNnF7pMWmPK+TGdT/aY0Ol/C0e6/9Mag+RXjLt4/w5Fzs1y8WeDRvkIeO8Zv+ruuWpRwjTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954373; c=relaxed/simple;
	bh=QR4IRgukHjMPuT40zZ4OuDQJDtClfYGTPwpkYgugD3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUzXCO+RoqJEmvQ2xqHXfXs089wXpj6coaFPVhnScO5WYKBn/opPXd/vk1gqdzHsC6KU9d6f9gzG+NUZfXafJJvUvefIF7SwlCTu2G42gttnP/IMukf6sjLTw+z4gc+dt0NJ4oDf0PJgomG3K4dQoDTiv6ncVvEey8QForvpGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p6LeUBSc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BC2u3V012041;
	Mon, 11 Aug 2025 23:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/jQxW3XlXt+NvLGmY
	lP9Cpg2Uyt0J/JotWl8Xu3o72g=; b=p6LeUBScKk91NtlpIjjvvPiYus8bmQnMj
	AgPYqeHF0vbX55CvPvk8okFUKqBYXgH3wWiInFsFkXKk6uqn0JTo3Z7buXIFsXH8
	rZv1MU4ULAMyBFhQctn103wqtIxGcmNaELD0ZBQkUXD292zInTNvDOuRc7L9wKdl
	6AOw+U+aDIBAd+1m73Mzy9kYRZD7ELkuuFXiQp5XBPAancdqdN01pYBAvWdLYoya
	X0hu2SmPViOw1ctdFWU/K95Tpltod3KVIZH1hjEQKnStHanjoctnaSvNqz8Bb+3V
	IXi/PLJmD9A1QfIACWOtOzcBoHqs5D/YX5AOG+lLFrMIDmtJY4j5Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duru3pww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BN0I55010832;
	Mon, 11 Aug 2025 23:19:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnug4hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:22 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BNJDT527394620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 23:19:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAE7858065;
	Mon, 11 Aug 2025 23:19:20 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8762A5805D;
	Mon, 11 Aug 2025 23:19:20 +0000 (GMT)
Received: from localhost (unknown [9.61.174.150])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 23:19:20 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v7 6/7] bonding: Update for extended arp_ip_target format.
Date: Mon, 11 Aug 2025 16:18:05 -0700
Message-ID: <20250811231909.1827080-7-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811231909.1827080-1-wilder@us.ibm.com>
References: <20250811231909.1827080-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rjIq4KjzcNX7A32896YXYiamBEDC16m3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE2NSBTYWx0ZWRfXyuzEJCQQlfWH
 ATMj9xNFmFuSCoxb0gzCm1S/X9kb2IfrzXXJmWCuyVuNQzE9qkZ3OKFS+kpMVLjwNRaTTRV6uWR
 1in9hBtQdw66YE7ZaJ38WVayqY6apv0+kEx56Kh+aqWpn53eL7l1ebR6ZjRiZLreoG/XBXKdsoP
 X3I2f66KRioRbgtP3AQIM4E3dhc3tsQu5aqihujLO583oVfiFA+WCYQmSY3ARz0UW/yO6QOVXI0
 jkDChEgiOflaL3wE+xPNQFJA50WbvbRoqnb1gsxzHbKDPv9SA5566sw28DJpL4ks/K+X1Yvt4Ao
 R2JXM0FiLMYuMXsdYxOhBMzgnihvaHaMPwtN0kgPGijzZ6BZdqIfS7dLsYI2+8gN0bCN3rhmEPZ
 RUQRdZxH1PeYjfX5bL9DyyHSwD+5cYtwRpzMsrjI/+DcuLU6eZRe82Dlt1UkA/4wDmm3Laea
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689a7a7b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=rW1rgPF15oU2z4qWOn4A:9
X-Proofpoint-ORIG-GUID: rjIq4KjzcNX7A32896YXYiamBEDC16m3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110165

Updated bond_fill_info() to support extended arp_ip_target format.

Forward and backward compatibility between the kernel and iprout2 is
preserved.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c | 30 +++++++++++++++++++++++++-----
 include/net/bonding.h              |  1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 5486ef40907e..0857c93a57d0 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -662,6 +662,7 @@ static int bond_fill_info(struct sk_buff *skb,
 			  const struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
+	struct bond_arp_target *arptargets;
 	unsigned int packets_per_slave;
 	int ifindex, i, targets_added;
 	struct nlattr *targets;
@@ -700,12 +701,31 @@ static int bond_fill_info(struct sk_buff *skb,
 		goto nla_put_failure;
 
 	targets_added = 0;
-	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i].target_ip) {
-			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
-				goto nla_put_failure;
-			targets_added = 1;
+
+	arptargets = bond->params.arp_targets;
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && arptargets[i].target_ip ; i++) {
+		struct Data {
+			__be32 addr;
+			struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS];
+		} __packed data;
+		int level, size;
+
+		data.addr = arptargets[i].target_ip;
+		size = sizeof(__be32);
+		targets_added = 1;
+
+		if (arptargets[i].flags & BOND_TARGET_USERTAGS) {
+			for (level = 0; level < BOND_MAX_VLAN_TAGS ; level++) {
+				data.vlans[level].vlan_proto = arptargets[i].tags[level].vlan_proto;
+				data.vlans[level].vlan_id = arptargets[i].tags[level].vlan_id;
+				size = size + sizeof(struct bond_vlan_tag);
+				if (arptargets[i].tags[level].vlan_proto == BOND_VLAN_PROTO_NONE)
+					break;
+				}
 		}
+
+		if (nla_put(skb, i, size, &data))
+			goto nla_put_failure;
 	}
 
 	if (targets_added)
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
2.50.1


