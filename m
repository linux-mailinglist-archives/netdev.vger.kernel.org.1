Return-Path: <netdev+bounces-218025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF8B3AD6F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FF21894D66
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FBB29E110;
	Thu, 28 Aug 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cVNz+edZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CEB28B7DE
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419579; cv=none; b=hksxQL+8ezg+ZeIV5EwwhVJVpsncA/VJNTsOG7Sth8jcWs5MwTyuaqwqDwUZmhRylnJd41RUrPBsUwk5ErcOoCxM50DQR+9UmHwum8Z0D27Af8WEeMRxq0c25K4hUXXw4yZ5apw4O99Wzyg3T+GXz8sXSkB+5B8SHXiPw4WkX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419579; c=relaxed/simple;
	bh=QR4IRgukHjMPuT40zZ4OuDQJDtClfYGTPwpkYgugD3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugcvUYUDLXxhqi/CxNlNx0KIS/9CZ+8pK9nBHThjIvEy1DnxBcZBkh2hw034wS+uMZ0rrZq/+dl50jIAVeAKhSU2JOoIDubPPHhiCMNpbAYVdWCOnGGUFWXSn3YZGBWQqc9y2m/lXEY8zmH7np+GsFp77YRpvUnhx7XBIENj+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cVNz+edZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SGhUBT004361;
	Thu, 28 Aug 2025 22:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/jQxW3XlXt+NvLGmY
	lP9Cpg2Uyt0J/JotWl8Xu3o72g=; b=cVNz+edZogoG84oTcbuEIn5C/0l7xBmDE
	PPeVD1vFWBko+yl/7R6qiQ2GTprL4XFHElOmCrUnvSIsOnX90PxSVZ1p1wJlKtEi
	OCR3mxHvQbQgKWHun2dU9bDzSaIKbHeZkNHU/I2CLnRWfM9LrAMEcK1muDV1O1m2
	k7WG3hBW0d3de+nP5uSHoU0OmaYkMQGi0XVA7CnhgsuV6ArchiZAfawsiWq88nYn
	EH05daguBEDIHEbLt//RHaGZegaZj9igXNzMs38/UOre+19+Dil3l/5VQaoYPLbd
	SkP+hbTwvfAQCC6cmblCzcuhLzm0n9PQ+H5ZO45PhvisfAgGXEslQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q558cmaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLjSbp002512;
	Thu, 28 Aug 2025 22:19:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mpx0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57SMJPNc32572006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 22:19:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2916858059;
	Thu, 28 Aug 2025 22:19:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E964658043;
	Thu, 28 Aug 2025 22:19:24 +0000 (GMT)
Received: from localhost (unknown [9.61.155.164])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 22:19:24 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v8 6/7] bonding: Update for extended arp_ip_target format.
Date: Thu, 28 Aug 2025 15:18:08 -0700
Message-ID: <20250828221859.2712197-7-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250828221859.2712197-1-wilder@us.ibm.com>
References: <20250828221859.2712197-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: plbrh0c3R3Z1H_pdMlK45esIWC42MVWO
X-Proofpoint-ORIG-GUID: plbrh0c3R3Z1H_pdMlK45esIWC42MVWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXxNjz0WWNZNU2
 2hfPtYVq7oI97kKPDXentqH6Acl+FXhEFIFo02MvB0G+mrqUHbwMeFn9msTL98wMQ3KlB3nEMdy
 ubGRuQujE4d6z4XRqn1NNKelZQuQkPDtMBXYICnKlv8Wy6xRHNePPfm6hwmrHYQUJqJBiXsDdZA
 gYyYhFqK9MaFVRyVMvWdzCAL3ekJlbRpoEvsR3XYZCnwSl0z5I0JZY7/PqKUvxfzzZKq9ffoJW1
 EVKkmyk8gmVIr1y5iYNVMo31Hiqa3odm0Y20VzP4mc7fNCqPZvaHeGs7FYrMxPGKf4gqGYpV/3t
 qwYgL3RvGVfm9Peeutrq/XTolN/1uSBsgQ2NJ0F8XnOQH08WpSyYHvjkLCo0SCWJqJUFcUW5aNl
 am5aik/c
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68b0d5f0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=rW1rgPF15oU2z4qWOn4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

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


