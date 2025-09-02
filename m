Return-Path: <netdev+bounces-219291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C26D7B40EA9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E46C1B234E5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60CE2E8B85;
	Tue,  2 Sep 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rc/yUgTh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2402E88AE
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845848; cv=none; b=iNclEmck1PD8m244lznZm4Az9zsbIHZD30T70Nz7ek1mxPQQKBJrHRzACOh4+71J9f6G526XpWj8QCZvAyHt12WFFX11GM9gXclFBctUkrVonHV3wbliJF8+/tY0K+etS1RToSm7GEiOjrt93Tx4yGf3JXwmRlvYjT2mtcZqp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845848; c=relaxed/simple;
	bh=nZ5cvUU/34D0KVxJf8O292P74nqx4iZY+uNNoMPIBGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb4XwVMDUo+w5ZQHp8rcV//LpbzijgqMv1lFP/Ik0fAL1tY4pvf1w2xFaek3B9z4f7bQA+NCG910ePJ8pJxBFFgXpuWjKa7SIHMhLbYDsNWW2gD2L8nWT3Azyp+RbyNo3/+qBWkp/awn5+JTwm3gD2KK9Lj+sFSD5ELQbgC2+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rc/yUgTh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582IHwNE028857;
	Tue, 2 Sep 2025 20:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BGJ7cUt6h0/JAmFKr
	eDTX6Xux4Nay1JA9uWRemGS5Mo=; b=Rc/yUgThU2o/wEzNMZkIyHuNOlE70gjfl
	raWSUlHX/Nz7/WYg5fLC3ewbnmSmRtS6IO9u+ktu+LV2XfZvQofCaRw1uslz6oRS
	kJ3Fa+hWB6M16bjQvsMthK1ml5IlzhUnZzFNDGzw+coudnL8DKkIj02qHS0QGTZf
	z5pTciBBiWXN4wsnWlVAQfXbMwfxY/I9CEABdR7lPOMdxxUwRy/kTqrd18Tyqzo8
	MdJG/BDQ1ChESnl6PF7hyTFJcvgpAni+oIFS8pEdR2Yjbug5f3KyO64wqvsO3Qfn
	5cEoxUGS98q+fXg7WcCur2wcGJ53561oJYVCALbN6uXNzwk1v2YrA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur0n57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582J1WY9020375;
	Tue, 2 Sep 2025 20:43:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmu4ka2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:57 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582KhtFt15860310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 20:43:55 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43ACC58056;
	Tue,  2 Sep 2025 20:43:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F85058068;
	Tue,  2 Sep 2025 20:43:55 +0000 (GMT)
Received: from localhost (unknown [9.61.19.179])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 20:43:54 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v9 6/7] bonding: Update for extended arp_ip_target format.
Date: Tue,  2 Sep 2025 13:43:02 -0700
Message-ID: <20250902204340.2315079-7-wilder@us.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX5Clkd4SfH2o5
 lo2TDtnnP2iQ107HraRS7+n6EurEVUtW+QzCMSwGcc73AX/u8Snl1s+aW7rUC+oBbYq+Jfh87fF
 B+JbiUemhpUcTtJIJ+PNQzybuGqhZ9DFipXSy/vpNHiNUMfExjAvTv5vJdy0Hx66lgj9jFHa2Bt
 H3wZVB7n6y491Agvygj29+6IWxWyLT8nul/0bzBixbdligtZR5zpDGfQsuibDE3EdquqX78q4/H
 qPtX7DswmSs204ge1T9AUdgUhjYfAoR5GbWmVPUfTQ4OZP+Xl7DXfE6VOZ3zkDjkk4fjscxTEdB
 7Htgu3yDM5HXK9+kfAFarMiCtSxpbu037RNMCQk7c9oTb0UuJ+VAymIi1odoMSty1dfFQouvquE
 ELVK7FfB
X-Proofpoint-GUID: -vBuTSVV_0kkow4oAoj7L-oeOnp6Z-r6
X-Proofpoint-ORIG-GUID: -vBuTSVV_0kkow4oAoj7L-oeOnp6Z-r6
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b7570e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=5r6OpphZNv9Aoz4X3f8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

Updated bond_fill_info() to support extended arp_ip_target format.

Forward and backward compatibility between the kernel and iprout2 is
preserved.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

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
-- 
2.50.1


