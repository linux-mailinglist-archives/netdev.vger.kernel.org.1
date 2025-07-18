Return-Path: <netdev+bounces-208254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEBAB0AB6C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88D31C8248A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340721FF26;
	Fri, 18 Jul 2025 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="USEk7cuA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCC221FB8
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873904; cv=none; b=dWVIr0eTpqtm8kibBaspNCWUbRzOOF1Gwx5ErDm7RjL24/lMe56hzIUX7SWR+gBMLXPfnhPecErwuzqeNUEl6te6CrLXUN27h/QQ4IS+BEMvxTg12mi581BD+7fH6buHjxVObc9LuT6f7+Z+idMuQ2TW9ZF64+hZwPXk5ayQv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873904; c=relaxed/simple;
	bh=6gt3Qi9dSk1drQ8qZcjORU3yeW++yAyeRkwIaAqyA58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEIl1s4dnD4rbxrhrdg9Xr0rrRooRkA/o2H1qN+nt5Gc/sNU/xYFMBvEMR9VvHAAC8McgAQ645KeqgAqkHPn9tlS/2l0X66LaEQKh/MtfZFCPAiZHVTTNIHMgHY+Sld2CL1id4Y2gkaEAQxKadyRlErBlI0zOeHEwptgGW6VD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=USEk7cuA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IF2RbJ027941;
	Fri, 18 Jul 2025 21:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p7Vw2dsgSBCznGwMd
	2AXNFIZilbjuCPE4PZNnozzTq0=; b=USEk7cuAtqiGjjZ2ui2NoHnb8g3n1D3eJ
	sTEowUCeTT9xWbF5S+2BXd9o2BJERqrxQ6FA9VnDGSiOmlWXr8IRCcn6kQmEOrSE
	Uqczuz+qyUWM84gFHmaag4CV0+lusVHVwI1s2MrDc6Vs8xGXbNwBeiGDiGMbQi9Q
	+Gv1Gxs1x2s86BVIKqybI+w4VUbEXvVpbWmQO2GTDFze6Mzn2h28SIIIzn+KeYN5
	9SrEMx1P6x4pH/DyJYr2E1svnSm2BomMKpWI3okam7/NbVDnUIcTkb5pipraBfrE
	z3H5y9XNXRcFmUS5744BMutUcxS4zCKDWeI2lw8PHF5IYZA00S38g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4uk92d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IJt85D032758;
	Fri, 18 Jul 2025 21:24:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48mjtuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ILOkwQ3932846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:24:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 846B258043;
	Fri, 18 Jul 2025 21:24:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C2B58059;
	Fri, 18 Jul 2025 21:24:46 +0000 (GMT)
Received: from localhost (unknown [9.61.165.151])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 21:24:46 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v6 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Fri, 18 Jul 2025 14:23:41 -0700
Message-ID: <20250718212430.1968853-6-wilder@us.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=687abba1 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=ZKn5ET9WYz78Zcf0JJ0A:9
X-Proofpoint-GUID: YVqz_vHwJqdxyEltkkH-PzpKCHxht5Fx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE3MyBTYWx0ZWRfXzKDIeVrnn64p rUuMWRGglkfkjLOSITt9eD4AlGWwSl8TeSrr9ku76eNTodojTaOX5WyAfzH3/qivnUFS4Ksdp0k eES8D8ypqnD1RjBtmRVEYPxbpDXasotZhiF5m5Ni6Ac2yQY2BiaoWfyAE1y6BcuaTFzD/btwBHJ
 ZpMb0LEy0yPlNwn261TIykZHKOPt877aB1XxpoVgdYKdQ0ogvPWlt0AA/dEjujQs017OJBUj7GR 6GC1SV43KOnb1sLMvkkN+lm+gsJ7/g57EhAE/5vFoR0LnddpYhcHkuPoPxeDUcfKa815OMiDkoq WA2dx7ShQTdYVcISgqDt3uPYgyI7IFJsZ4bh8ouJIwYnpjp5KJ9LmI93Jl4n9ACJK8ysggDjYU4
 dDeLp9kO9o0y6PQP1JiB+SPOgxoFXB6DlaXFb4go4I35kWPCLruECfOB/+iRBdB1IkINsVj3
X-Proofpoint-ORIG-GUID: YVqz_vHwJqdxyEltkkH-PzpKCHxht5Fx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180173

bond_arp_send_all() will pass the vlan tags supplied by
the user to bond_arp_send(). If vlan tags have not been
supplied the vlans in the path to the target will be
discovered by bond_verify_device_path(). The discovered
vlan tags are then saved to be used on future calls to
bond_arp_send().

bonding_exit() is also updated to free vlan tags when a
bond is destroyed.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7e938077bbde..2f153c89e401 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3161,18 +3161,19 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 
 static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
-	struct rtable *rt;
-	struct bond_vlan_tag *tags;
 	struct bond_arp_target *targets = bond->params.arp_targets;
+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
+	struct bond_vlan_tag *tags;
 	__be32 target_ip, addr;
+	struct rtable *rt;
 	int i;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
 		target_ip = targets[i].target_ip;
 		tags = targets[i].tags;
 
-		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
-			  __func__, &target_ip);
+		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__,
+			  bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf)));
 
 		/* Find out through which dev should the packet go */
 		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
@@ -3194,9 +3195,13 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		if (rt->dst.dev == bond->dev)
 			goto found;
 
-		rcu_read_lock();
-		tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
-		rcu_read_unlock();
+		if (!tags) {
+			rcu_read_lock();
+			tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
+			/* cache the tags */
+			targets[i].tags = tags;
+			rcu_read_unlock();
+		}
 
 		if (!IS_ERR_OR_NULL(tags))
 			goto found;
@@ -3212,7 +3217,6 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
 		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
-		kfree(tags);
 	}
 }
 
@@ -6732,7 +6736,7 @@ static void __exit bonding_exit(void)
 
 	bond_netlink_fini();
 	unregister_pernet_subsys(&bond_net_ops);
-
+	bond_free_vlan_tags(bonding_defaults.arp_targets);
 	bond_destroy_debugfs();
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.43.5


