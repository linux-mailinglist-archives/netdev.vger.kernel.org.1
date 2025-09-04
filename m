Return-Path: <netdev+bounces-220175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CCDB4496B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2861E3AE492
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF342EA176;
	Thu,  4 Sep 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LdKl6Cjp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB002E92CF
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024416; cv=none; b=p3Jb9+KrdyqtfJEUMReS7u7FFZkhHFAU47rwMEfSdjsh8gpnpkBPeG/PtUg8Ns0nWVMABzaA2S5rPHPgFg86UZJnBdkaaZVOZrlb/Q7c+mHcPHqsoxFtuZEZd1gFGpOSKZ9u9Y3n7CrV0tBTROJea4eQhEhPIEBpqpSjC2K55cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024416; c=relaxed/simple;
	bh=W/T8BXyF83W2w3i9EmBbYQFJPPn/47EHtXmKfAdkCxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFU8kcjG819iNqbaiD2bZ5NogfIk0o2y3PLNw1dMuD/9tzxkGAG/YjAo0hmPalRDuvDk5cSHYhgqbo3Op91VApgXkmcTyPkCL0qReqVacf9lxNYEmjTGppf03uvuz7YG+8U/RbGY9vArTZ9f2M0B2YpWaxOrnuqLGpiZg2jLKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LdKl6Cjp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584JN5x3001199;
	Thu, 4 Sep 2025 22:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3SVHQ/MS5hpP3GwJh
	huGiTYBLq/pCuobYqR3jOcHRPE=; b=LdKl6CjpT7FCCqqpUHAD5Fj7GLzOkVc7S
	r3lhreMfNLSfcKMH7lrin4XURgKgb/5d1MEtGR5BSe9yIXwIVHlmARCEcHcvwAKE
	4QpyR6eRarKfL6aR7HKu/p+eNyworAm8RLdoyXZKgYmEC4xkEAx8F6lkHbWYX2FO
	wbLFv+fJtFcX7PCr4l1A0Q75B+J1FrijtxYFgGc+SwybZEO4bh4/ra3B+gSNU1lV
	r7rrDQPUwLcOHUH0BH8GbhcMeB4YUdArE526mtmEd+R7aoEZR6aDDtaehehCbx/H
	Unyq1yAYKMVjQ8TqqiRkkmbi/mFpnX22HXtGRQ0gY1mH9OkH/+7HQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf8k4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584KhZXW013959;
	Thu, 4 Sep 2025 22:20:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3pchv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584MK4Go3474326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 22:20:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D60C58053;
	Thu,  4 Sep 2025 22:20:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3051658043;
	Thu,  4 Sep 2025 22:20:04 +0000 (GMT)
Received: from localhost (unknown [9.61.141.209])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 22:20:04 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v10 6/7] bonding: Update for extended arp_ip_target format.
Date: Thu,  4 Sep 2025 15:18:24 -0700
Message-ID: <20250904221956.779098-7-wilder@us.ibm.com>
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
X-Proofpoint-GUID: UtFZwaYUXeLcLQqXLyG7aXUqn6cQCZ3Z
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68ba1097 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=LeF_Q9oKuOwkotFnX10A:9
X-Proofpoint-ORIG-GUID: UtFZwaYUXeLcLQqXLyG7aXUqn6cQCZ3Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX69kxDH/YfxxF
 R7IBwHdGMrXwzm1JdZaSkoyni5h8MzjKsSYay5hyAVSqSgUfBgOIuU2WJSTpi4FmdkWwOLK6D1o
 9Q39gU45OdY75IXKtgpB6sA5ga5kMgSaAgvjYaRsQrPiwXmNSab7RrWUjJAow/IeqjnH2wWr9i1
 E5Oz8wt1KOrnidhxqiJS4g2Fmqu2HtF2KY9o9Z38+ifV1q6TS+dnBdFGyqBFQOMu2ieexxLuj4a
 bIwgrT2YQfOeBhJIb3RbtB5UAjK8P9Q3+UMxnBtwdp+jj48A2bQM7Rc/fbebhUMIqyn+IMR9+P1
 EfTkm6ISdySHWOT6dHTf36DtOL+J0+sIXVJ/ex3Kw0CCSKO6y/kgi3DBhnLt+lkbxoJ3pekGRfv
 FrJXNH+i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

Updated bond_fill_info() to support extended arp_ip_target format.

Forward and backward compatibility between the kernel and iprout2 is
preserved.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 28ee50ddf4e2..1f0d3269a0b1 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -660,6 +660,7 @@ static int bond_fill_info(struct sk_buff *skb,
 			  const struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
+	struct bond_arp_target *arptargets;
 	unsigned int packets_per_slave;
 	int ifindex, i, targets_added;
 	struct nlattr *targets;
@@ -698,12 +699,31 @@ static int bond_fill_info(struct sk_buff *skb,
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


