Return-Path: <netdev+bounces-227409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB2BAECA9
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5274A64B4
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500592D3EF2;
	Tue, 30 Sep 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ItJNrpTA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11412D3A7B
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275552; cv=none; b=C+mKJRpPRtuU9GKf2FLqtVdMFo4JMVixFI7NzMdQBa2A9+i6V+Bxw/H2b3MOkXfewneX8uWEUuW92TEXVhg/DNUiJIvZnv3VHZIUKFSu1upKRI5YO8C4toQCdRqy60iMFIg9i8TYZnSsM5iCv6s46GkDJRIysW6u/zt9AWPYhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275552; c=relaxed/simple;
	bh=vrJ/e+h+4OuTT04H2OGBBQ3YqA2WP49On1X73b4yAUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txLEhoO5b2Ah98CBjFes9FGGKCxWeVF7m0DbKmvdy323tdGnR64vTaZZw9VExFR1M1svpmnXcU2tuITH8wLL6pBETp7VpQZtk3YtyhVMRA3POZUGhfdK7wjUE0vIn3Uuuam1xbSh8MlBpk6qrlRmNX0Jj0UxDZds6rBatXtmNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ItJNrpTA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UL839d023218
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M2IXk90/R7pJmNc8H
	OhiCt0piCQH4MpBGr8tJjhP3pE=; b=ItJNrpTApV2sEYHo0AWc1zuEqRHAvOkqX
	ULkqOvPrZduDbNpSvD4itPohojcUE2q9RcptOyqNDHrUdjH6SONf5aZLM2ctH9MK
	IkUKivpPNdCh7bU2I5hYQXrcfpwCJhL6Xh8NlHOB01UQDWHd8F/HXJhEOiuR6P3Y
	kf+spmvyShCPZwiE2Eb3bipRLj10lK/TS81+oGrR9EZRlV/9WP/zmhkD30516XXb
	pTw7mxUvMDEvDOJPMq0X2ovR4x790o+Vb/0LXOAU+UGViTdKqENdlZ0uXuw5iz+0
	hDUBclTXjKiL7+VNoFlFGDLbFqFNOaacQCpXNgjy3IexvSR5fMoBA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhks5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKkXOJ024191
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy15sah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UNd33432768526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 23:39:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2B9758050;
	Tue, 30 Sep 2025 23:39:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A00158045;
	Tue, 30 Sep 2025 23:39:03 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 23:39:03 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: wilder@us.ibm.com
Subject: [PATCH net-next v12 6/7] bonding: Update for extended arp_ip_target format.
Date: Tue, 30 Sep 2025 16:38:06 -0700
Message-ID: <20250930233849.2871027-7-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250930233849.2871027-1-wilder@us.ibm.com>
References: <20250930233849.2871027-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68dc6a1b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=KF---2x0OGxtNdzjTy4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX3fD86avZaodS
 /ySanseB0KGb4nwhcdSNcJ12Wzf/UyggkuJ+1livvLa+zEj5/VRHFQ8FzxiAnxHj2kePIAG7vMQ
 AE/HYc74MmCryFrsljFiRuHyt8XWYtx9GMJ4VahIHcl+BW//icer+cMQpOlccMf6krwKqZE5kKp
 o2MnDSGzfQ7UliIFa4m+6kTrz4el6T2nq+CP4Ing7XRtHo16prUNHfXINJxyifm4MLhf9YEQvF7
 6Qw2FoQKypWdnrFAog6pYSfOfoFy/d7ccYxIW158pc7g5eFDOMjFaAxnQ492TY39AS93pawPRqu
 y2AxtYYwMO/JWJGRjvudeYd8FaY5ARmo7u//DfCcQYU7ETUxrsba9v9fNS2uHtp3KpzANLWHgHT
 /2FXwmNGIoFsADDaqVc3XeYo8q5+iw==
X-Proofpoint-GUID: _QlRi8t2Y1b4RZe65WSdhS-ReJ5SrC0j
X-Proofpoint-ORIG-GUID: _QlRi8t2Y1b4RZe65WSdhS-ReJ5SrC0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010

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


