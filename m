Return-Path: <netdev+bounces-189061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BACEAB02C0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960EC1B67B57
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B850286D66;
	Thu,  8 May 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UAv/rCqC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84B8C1E
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729056; cv=none; b=HAu+5SzkPubU6vLdy0ioGktshpEvs+K3NnWRZVdGMT6o+MWolt2nQ0hc7qRPmXXg2V0Wj4oToyYHHeeW73wQj5okOWHDAxO6a4kvDhXyjqv/F5iBZSgvGNm3eAOnA2zvL6Z191vDJKATsOxix9reCioelqYuc1H6A9AK7ERLAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729056; c=relaxed/simple;
	bh=fkcj2uf5v7msDYYKRn8vtkovLG5BYEgnLcRRAl+jh+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLOn8IwRk6YGLTGUQ5CaIKJuKvonx2LN1ljZeNUErZ5YIz2BJ6Ih+6vim+ywsLtrCv2iQVWVg+Nuxk2C3lRWwclT5Q0qBZnzqu+qpniL0XKCCB55QpJ08Cur9LDChd5rz949j9+dAP3fCxuAnQYRxvveiB26rpRFHjbvh3hhEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UAv/rCqC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Hn5cg000532;
	Thu, 8 May 2025 18:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=znW0sWrDgotepwVNG
	wOFRnUJ9WfbWqDDF6Tderq1xSY=; b=UAv/rCqCYLfTg4KqOM3k2npEmTfCaiCp0
	Wy8N1lZ/kuFpYyFZr1SMnCZlLjPCsaNXEjicHsquCqW5ZGpY7TA1zYDn6oB8Sd10
	2fNxyUahVcGeS+8jpVLRIv+A6JIZD6aRSyCyxRi86CCHJTi+yQI0rWrQnUsXIfuY
	DxJtH4SvJXngptVa3c4zg6DxFLFP/iMwWPynX5WYi0gYkGls0tTsW05bW3frjZzy
	jqAs1FWKYbpVKf97eDOV2yiSndkhIa9z0+5MHR5wrItxnTSN7fuyGvJ5pbDZv5TO
	YoX2LckAjTM+SOv8x8vu3sfbqrQ9ULzUmLd4BQtqRf+b2wJwX1HeQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gf3kwbrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 18:30:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548HQ9jG004253;
	Thu, 8 May 2025 18:30:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2bryh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 18:30:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548IUfFD29426302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 18:30:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E84E5804E;
	Thu,  8 May 2025 18:30:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 431E55803F;
	Thu,  8 May 2025 18:30:41 +0000 (GMT)
Received: from localhost (unknown [9.61.84.219])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 18:30:41 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v1 1/2] bonding: Adding struct arp_target
Date: Thu,  8 May 2025 11:29:28 -0700
Message-ID: <20250508183014.2554525-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508183014.2554525-1-wilder@us.ibm.com>
References: <20250508183014.2554525-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qmBOd_7QzK7raNwNA29yREFjLnwNtdwF
X-Proofpoint-GUID: qmBOd_7QzK7raNwNA29yREFjLnwNtdwF
X-Authority-Analysis: v=2.4 cv=S/rZwJsP c=1 sm=1 tr=0 ts=681cf856 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=iLGOUBwdGH6lFlYEbN4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE2MSBTYWx0ZWRfX3vmiEYhagMjk X7p0I1Q17nCd87NSuokd5JD7FNRS8twpvkK1OiNvKd5Pj9Dg/xeMD2tdRDQD1YQoB8XSwsuQtVN Nt0Kk6Y9e0Il740d4q65tycCPiuyHeprcSjtNb7nfjEQ7y2KJ3DXU+F262yaESNr2Gn1URsGhsq
 ZU9vUzxDcKCTFuCBOKE3MMmusIalDHcHuHB6Da6GPak3YUUMh/ztzik5bK9by9BSzlknhjUwu3H clW1w6OWXaZRSrMG1uEFqRAqjIYhGbxRZJao1r+5k/FA7pnwZQ8SEmdAM033gStbjkSQbSwFXXd 2QQBQTjAu72bauVOrYPTjZyxcCLwQx7TORmkb1YZysP5h3042Nrjethx/VISTI5xiMewb6wK103
 5TxGnjE0oFXDZjyAq/NdH54LvxxMIWNO+JTUEU3fstthTmliLjSyi4WbvdoTVAmteYFlGYKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080161

Replacing the definition of bond_params.arp_targets (__be32 arp_targets[])
with:

struct arp_target {
        __be32 target_ip;
        struct bond_vlan_tag *tags;
};

To provide storage for a list of vlan tags for each target.

All references to arp_target are change to use the new structure.

Signed-off-by: David J Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c    | 29 ++++++++++++++++-------------
 drivers/net/bonding/bond_netlink.c |  4 ++--
 drivers/net/bonding/bond_options.c | 18 +++++++++---------
 drivers/net/bonding/bond_procfs.c  |  4 ++--
 drivers/net/bonding/bond_sysfs.c   |  4 ++--
 include/net/bonding.h              | 15 ++++++++++-----
 6 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d05226484c64..ab388dab218a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3151,26 +3151,29 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
 	struct rtable *rt;
 	struct bond_vlan_tag *tags;
-	__be32 *targets = bond->params.arp_targets, addr;
+	struct arp_target *targets = bond->params.arp_targets;
+	__be32 target_ip, addr;
 	int i;
 
-	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i]; i++) {
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
+		target_ip = targets[i].target_ip;
+		tags = targets[i].tags;
+
 		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
-			  __func__, &targets[i]);
-		tags = NULL;
+			  __func__, &target_ip);
 
 		/* Find out through which dev should the packet go */
-		rt = ip_route_output(dev_net(bond->dev), targets[i], 0, 0, 0,
+		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
 				     RT_SCOPE_LINK);
 		if (IS_ERR(rt)) {
-			/* there's no route to target - try to send arp
+			/* there's no route to target_ip - try to send arp
 			 * probe to generate any traffic (arp_validate=0)
 			 */
 			if (bond->params.arp_validate)
 				pr_warn_once("%s: no route to arp_ip_target %pI4 and arp_validate is set\n",
 					     bond->dev->name,
-					     &targets[i]);
-			bond_arp_send(slave, ARPOP_REQUEST, targets[i],
+					     &target_ip);
+			bond_arp_send(slave, ARPOP_REQUEST, target_ip,
 				      0, tags);
 			continue;
 		}
@@ -3188,15 +3191,15 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 
 		/* Not our device - skip */
 		slave_dbg(bond->dev, slave->dev, "no path to arp_ip_target %pI4 via rt.dev %s\n",
-			   &targets[i], rt->dst.dev ? rt->dst.dev->name : "NULL");
+			   &target_ip, rt->dst.dev ? rt->dst.dev->name : "NULL");
 
 		ip_rt_put(rt);
 		continue;
 
 found:
-		addr = bond_confirm_addr(rt->dst.dev, targets[i], 0);
+		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
-		bond_arp_send(slave, ARPOP_REQUEST, targets[i], addr, tags);
+		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
 		kfree(tags);
 	}
 }
@@ -6102,7 +6105,7 @@ static int __init bond_check_params(struct bond_params *params)
 	int arp_all_targets_value = 0;
 	u16 ad_actor_sys_prio = 0;
 	u16 ad_user_port_key = 0;
-	__be32 arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
+	struct arp_target arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
 	int arp_ip_count;
 	int bond_mode	= BOND_MODE_ROUNDROBIN;
 	int xmit_hashtype = BOND_XMIT_POLICY_LAYER2;
@@ -6296,7 +6299,7 @@ static int __init bond_check_params(struct bond_params *params)
 			arp_interval = 0;
 		} else {
 			if (bond_get_targets_ip(arp_target, ip) == -1)
-				arp_target[arp_ip_count++] = ip;
+				arp_target[arp_ip_count++].target_ip = ip;
 			else
 				pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\n",
 					&ip);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index ac5e402c34bc..1a3d17754c0a 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -688,8 +688,8 @@ static int bond_fill_info(struct sk_buff *skb,
 
 	targets_added = 0;
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i]) {
-			if (nla_put_be32(skb, i, bond->params.arp_targets[i]))
+		if (bond->params.arp_targets[i].target_ip) {
+			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
 				goto nla_put_failure;
 			targets_added = 1;
 		}
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 91893c29b899..54940950079e 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1090,7 +1090,7 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 			netdev_dbg(bond->dev, "ARP monitoring cannot be used with MII monitoring. Disabling MII monitoring\n");
 			bond->params.miimon = 0;
 		}
-		if (!bond->params.arp_targets[0])
+		if (!bond->params.arp_targets[0].target_ip)
 			netdev_dbg(bond->dev, "ARP monitoring has been set up, but no ARP targets have been specified\n");
 	}
 	if (bond->dev->flags & IFF_UP) {
@@ -1118,20 +1118,20 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 					    __be32 target,
 					    unsigned long last_rx)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct arp_target *targets = bond->params.arp_targets;
 	struct list_head *iter;
 	struct slave *slave;
 
 	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
 		bond_for_each_slave(bond, slave, iter)
 			slave->target_last_arp_rx[slot] = last_rx;
-		targets[slot] = target;
+		targets[slot].target_ip = target;
 	}
 }
 
 static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct arp_target *targets = bond->params.arp_targets;
 	int ind;
 
 	if (!bond_is_ip_target_ok(target)) {
@@ -1166,7 +1166,7 @@ static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 
 static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct arp_target *targets = bond->params.arp_targets;
 	struct list_head *iter;
 	struct slave *slave;
 	unsigned long *targets_rx;
@@ -1185,20 +1185,20 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 		return -EINVAL;
 	}
 
-	if (ind == 0 && !targets[1] && bond->params.arp_interval)
+	if (ind == 0 && !targets[1].target_ip && bond->params.arp_interval)
 		netdev_warn(bond->dev, "Removing last arp target with arp_interval on\n");
 
 	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target);
 
 	bond_for_each_slave(bond, slave, iter) {
 		targets_rx = slave->target_last_arp_rx;
-		for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
+		for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++)
 			targets_rx[i] = targets_rx[i+1];
 		targets_rx[i] = 0;
 	}
-	for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
+	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++)
 		targets[i] = targets[i+1];
-	targets[i] = 0;
+	targets[i].target_ip = 0;
 
 	return 0;
 }
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 7edf72ec816a..94e6fd7041ee 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -121,11 +121,11 @@ static void bond_info_show_master(struct seq_file *seq)
 		seq_printf(seq, "ARP IP target/s (n.n.n.n form):");
 
 		for (i = 0; (i < BOND_MAX_ARP_TARGETS); i++) {
-			if (!bond->params.arp_targets[i])
+			if (!bond->params.arp_targets[i].target_ip)
 				break;
 			if (printed)
 				seq_printf(seq, ",");
-			seq_printf(seq, " %pI4", &bond->params.arp_targets[i]);
+			seq_printf(seq, " %pI4", &bond->params.arp_targets[i].target_ip);
 			printed = 1;
 		}
 		seq_printf(seq, "\n");
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 1e13bb170515..d7c09e0a14dd 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -290,9 +290,9 @@ static ssize_t bonding_show_arp_targets(struct device *d,
 	int i, res = 0;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i])
+		if (bond->params.arp_targets[i].target_ip)
 			res += sysfs_emit_at(buf, res, "%pI4 ",
-					     &bond->params.arp_targets[i]);
+					     &bond->params.arp_targets[i].target_ip);
 	}
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308c19..709ef9a302dd 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -115,6 +115,11 @@ static inline int is_netpoll_tx_blocked(struct net_device *dev)
 #define is_netpoll_tx_blocked(dev) (0)
 #endif
 
+struct arp_target {
+	__be32 target_ip;
+	struct bond_vlan_tag *tags;
+};
+
 struct bond_params {
 	int mode;
 	int xmit_policy;
@@ -135,7 +140,7 @@ struct bond_params {
 	int ad_select;
 	char primary[IFNAMSIZ];
 	int primary_reselect;
-	__be32 arp_targets[BOND_MAX_ARP_TARGETS];
+	struct arp_target arp_targets[BOND_MAX_ARP_TARGETS];
 	int tx_queues;
 	int all_slaves_active;
 	int resend_igmp;
@@ -522,7 +527,7 @@ static inline unsigned long slave_oldest_target_arp_rx(struct bonding *bond,
 	int i = 1;
 	unsigned long ret = slave->target_last_arp_rx[0];
 
-	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++)
+	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i].target_ip; i++)
 		if (time_before(slave->target_last_arp_rx[i], ret))
 			ret = slave->target_last_arp_rx[i];
 
@@ -760,14 +765,14 @@ static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
 /* Check if the ip is present in arp ip list, or first free slot if ip == 0
  * Returns -1 if not found, index if found
  */
-static inline int bond_get_targets_ip(__be32 *targets, __be32 ip)
+static inline int bond_get_targets_ip(struct arp_target *targets, __be32 ip)
 {
 	int i;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
-		if (targets[i] == ip)
+		if (targets[i].target_ip == ip)
 			return i;
-		else if (targets[i] == 0)
+		else if (targets[i].target_ip == 0)
 			break;
 
 	return -1;
-- 
2.43.5


