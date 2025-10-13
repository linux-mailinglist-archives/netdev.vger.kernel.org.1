Return-Path: <netdev+bounces-228988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1550BD6CA4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F20D19A2671
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD162FE583;
	Mon, 13 Oct 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BIDOCQbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEA2EB856
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399648; cv=none; b=doLLotNhXn0rvkmlc9MAI/7mE9oSk4mlvmcnJCv0g2NA2+397SDbd22f5h3PO7dJGLTFj/swmoM2qpYYSAGZLsEL0SdFasPAh6C+Fo1NtL4h8a9PLdC5eMGWOj45tCELqAYW7brT2PR46iv6oDnGaIzhUxZAjJeNo7RFbSoeRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399648; c=relaxed/simple;
	bh=KkurbH/HKRkyS1kQqlDVB7BfdHXnNxYCTIXUaUJ7dCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbCBrFW4JdpCGeALF7JwLtXhRX2RH1wLCTCgRZZ8uc2bIsU/wNyV1ggZSHkYXH31FWsKTR1cgboR7ll9x4bRh3S97LSVIAR2LnHQWdJJzu8uKIFE9WFxFjZCHyPEG4EZN+xMzJv/u7ekRPD0iOqOmkYApWkszpSzFi/5tz+mN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BIDOCQbZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHrilh007910;
	Mon, 13 Oct 2025 23:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2dudvhBcZ6TouLvxT
	u4/ocpCQeJeJqKFQAzCh/xNqLk=; b=BIDOCQbZL0lwN2k0xb5lnORcFCf7xWIyq
	/3caCezoWfpQJGWZjfGDMLScrLKoxSV0Y5GHtEzvVejSKREdgfVQyLMBX6ME81PX
	724zxW75GDEWGxmKmg05hDomhEARXTWnKjhRZyaBINLevn8Ml8QQ0ensybbs5H+2
	sxLu8dWiY+y7SUFOL10L4iOxcOt1wug7YhUBLbhK9id2UVR5s5sABKiObSh2wMWG
	wvkjoCaGU49JT++z70SOzSjTWnzkmR8smkDGocO8BDF1NgOXeECw0e90CT+ZOkf0
	roL50cmeUEpd1BRFCsJbXHm7u6pqocUMy2tIAGinIQgY/yWA5ZohA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7peah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DNpbfq008610;
	Mon, 13 Oct 2025 23:53:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7peae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DKj80Z015194;
	Mon, 13 Oct 2025 23:53:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1js0hsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DNrrBe25559672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 23:53:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3616358056;
	Mon, 13 Oct 2025 23:53:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0516258052;
	Mon, 13 Oct 2025 23:53:53 +0000 (GMT)
Received: from localhost (unknown [9.61.176.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 23:53:52 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com
Subject: [PATCH net-next v13 6/7] bonding: Update for extended arp_ip_target format.
Date: Mon, 13 Oct 2025 16:52:51 -0700
Message-ID: <20251013235328.1289410-7-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: CRqbyycU6u6cguvnAUhzjyfblSRXo9kD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX8OWpvwYgiIfH
 Llb3b9QxkZNMHb8o3bfsSfh19bm64uzSn3MPcFUoi+CfRvwGv2sBAc1ljLhNhjVgwwv6MUaLJ0o
 0aPMdcaUHzLK5xZYALOvCNbAXaCnLI362igLVomCeYZxv3ynrTeOcY8hEb7zWG811dN+xHkhO42
 jDuTD5dG2jk7r85o4ERT/kuAM3jUBOZLbEoRp0u6mky/fgt5oquyKsPX5uq0FDelaNaWg2Vym+R
 yvvvvzITgz4vH9wnw0iPtycEwd45k9HV1sGQSPJ/CdVLRNs/QftRN5dPeSFwT+y/jdzA0cmm+98
 HqjEonWzdYSQ+RQf9n1CMN3uB8kVyMECBnlaZZ/CUjEsha47VAiqqchNs/bZai2jeKuFqqTlMQ4
 tuE11vW2GqKOcYpDyhhuLDe/q2YAfA==
X-Proofpoint-GUID: 9WOKEacK9YzBybvCdzqJ3FSEx2U2kTMF
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68ed9113 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=KF---2x0OGxtNdzjTy4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

Updated bond_fill_info() to support extended arp_ip_target format.

Forward and backward compatibility between the kernel and iproute2 is
preserved.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 15782745fa4d..d1946d387e95 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -678,6 +678,7 @@ static int bond_fill_info(struct sk_buff *skb,
 			  const struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
+	struct bond_arp_target *arptargets;
 	unsigned int packets_per_slave;
 	int ifindex, i, targets_added;
 	struct nlattr *targets;
@@ -716,12 +717,31 @@ static int bond_fill_info(struct sk_buff *skb,
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
+		struct data {
+			__be32 addr;
+			struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
+		} __packed data;
+		int level, size;
+
+		data.addr = arptargets[i].target_ip;
+		size = sizeof(__be32);
+		targets_added = 1;
+
+		if (arptargets[i].flags & BOND_TARGET_USERTAGS) {
+			for (level = 0; level < BOND_MAX_VLAN_TAGS + 1 ; level++) {
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


