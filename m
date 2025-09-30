Return-Path: <netdev+bounces-227250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CEFBAAE2A
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14073A4398
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9591D5170;
	Tue, 30 Sep 2025 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OCmUcNrF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E35149C41
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195769; cv=none; b=VfwFy+UPzM5ISRqtCRHQDFqYDVrdsMU5LO+iPKgx8yjNT4TAW3+Py8CqRW3LmT0t3ib4c7/123dNlyaJhFMqJ5AbjmHWAllWreSP8VqYyvv62NROGGX/9HXMPHT2vdy+zhHt6Lq9DClM5edjxSFbpglrJaTDd3KIlU9PAdp7LVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195769; c=relaxed/simple;
	bh=vrJ/e+h+4OuTT04H2OGBBQ3YqA2WP49On1X73b4yAUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQFSuWpO9PAA8EfYeJKICN7+I56n7CPWfuRgKKNy87FcT8dkGv+UbomISHocbfqVygVFxN0qTT7KMihuhhavubaIwwV73hVrY6PDM4y4z3V5LPOLYq1dDnWZHYSdm3SY/HI9jolVaI3DOLbkH4ySSWz9XE6wnAk+B1zCcMRMuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OCmUcNrF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TK7b37017038;
	Tue, 30 Sep 2025 01:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M2IXk90/R7pJmNc8H
	OhiCt0piCQH4MpBGr8tJjhP3pE=; b=OCmUcNrFJDVWGuXr+RSBKC5FpBI60QJQf
	B/cVEl+97prxIyDvMWP0E0DLqyHifyNYmD8HkkThLf9ull719vA3R1/znHaesAxM
	MuhHdX2TbUB15XXtbwSaCByuyz5If/5pV25VKZGUtQ2YaLTfmXYktbsCOdnh2A5U
	ppQA+oYLbe8Td5RCpkCloymOs9DSgcUOSZMU8tGCqAChoOrBoKug2Ss0Wi3tn7ye
	x2uyq+SQlx10oxCRPkp3HtHlx5aW5GO/yFlpFz1stSek1waFGidGq+4jNk6fmwL1
	5tNJEmR5S3lK+mCbHQ2aG87P6V8BwoJEZ7g4irt8LlyJrvDLAZdjw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwd9sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58U1QCib005294;
	Tue, 30 Sep 2025 01:29:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwd9sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TNkKH1020098;
	Tue, 30 Sep 2025 01:29:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8s15ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58U1T8Of25232068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 01:29:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5931158059;
	Tue, 30 Sep 2025 01:29:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1541158043;
	Tue, 30 Sep 2025 01:29:08 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 01:29:07 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
        edumazet@google.com
Subject: [PATCH net-next v11 6/7] bonding: Update for extended arp_ip_target format.
Date: Mon, 29 Sep 2025 18:27:12 -0700
Message-ID: <20250930012857.2270721-7-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250930012857.2270721-1-wilder@us.ibm.com>
References: <20250930012857.2270721-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX8Yb5njy7Pg5x
 lpHhtiUcqkNvoSmeqXW/jfCQIM42gOIm5OYkXx1amG0U9njO36IToO25H9ndmagcbt8jhAeWsH+
 rW8Lu4PY9JzkPvdjCgoiIjoXKoKsALJvlwH1hQZIrT8bo1t2mUXsrAqgsKkfneHVKbYNl8805/Y
 9LyHIotpxfPt7uICvy6DtV4+T2RZqhL6wd2gCadMfI39EfhkWncDL7MsZr6/N6Qdc4YjldRHaao
 akC/2k2zwUBtdo2OcwWbxcS5FAN9Ngy2wgWUZEgYLEcNn7QCuxrt6kgLcWyjd9GD8Q3gZG4Igzw
 N9OcIDe3V2Jgk8e1wZJy8ZGWmLTyy4LauQK8tyaT0euMp2cEtDDjlPi0l2mDaesG7K3S0xvGKnV
 5g79Yn2WZJc9roS2NTpYzZjonAKeQA==
X-Proofpoint-ORIG-GUID: PqthDLm_h-Blb4d3scfPTcy2yE-QlBKh
X-Proofpoint-GUID: 9kcXhixRLDdTQj-ORVYxID9kPrmxejP-
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68db3268 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=KF---2x0OGxtNdzjTy4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Updated bond_fill_info() to support extended arp_ip_target format.

Forward and backward compatibility between the kernel and iproute2 is
preserved.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 97fdbd962513..349b5525d007 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -676,6 +676,7 @@ static int bond_fill_info(struct sk_buff *skb,
 			  const struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
+	struct bond_arp_target *arptargets;
 	unsigned int packets_per_slave;
 	int ifindex, i, targets_added;
 	struct nlattr *targets;
@@ -714,12 +715,31 @@ static int bond_fill_info(struct sk_buff *skb,
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


