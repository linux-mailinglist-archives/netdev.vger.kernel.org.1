Return-Path: <netdev+bounces-227403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53586BAEC97
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8984A424E
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB032D29AC;
	Tue, 30 Sep 2025 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKzCgSdm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AF2C3251
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275545; cv=none; b=OV0cJVkkFpRid4j96e6pmNjR8Seus6MzJdSaU2QaeGvadOSW6GkYHPFhfG4Ek7AukxpwSuCmEgVrPys6kF0zomJmU7CW/+5wy+JzDEob+DaqxT2Cgl87EQHLckOECQHPoXcIHP28aj0M0qS4YeHsFePlIHHFCv+2wfN+zZxJZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275545; c=relaxed/simple;
	bh=c8cSqlZ7XAs9QuG06AkL1+2HLgujbQDJGuadAz0X+ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ2299NO5TUdSQUmQruvHskv0PA+Aa0fR5hrsmZffwE0mUQclHbFsCL3EztBuQqRsspmajLy/dWu0ajCg7USXLiuMFLkvwJJWBLGtE6rSm+Jax/q0ATZ4hxrec7n0RUxbqeOQqURJtSKc19zt22QdCCPwMHvR1M+XpklSB3+1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKzCgSdm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UHmbpI011590
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ea35SGJ0Eq6/bJgG+
	diwjfnCuMMAV7g2Yv4SNUjgv1w=; b=nKzCgSdmBTJOIMGCBXT4/qSuAjdNEBH2H
	z0V4KTrX5axkS2Knp22BaI0myrVfCkOs4vOeU5OoX7kR17rT4wrZX/oyHRmr1+s3
	Nf7CCgVK1HfE38AfPRYLr6ytjqwWc3ZVzoLjRUDgkjhp7eY5g2+kFyRIMjXpnhFC
	Sc4QDEU+k3QTgOExMm/GbwEgGmIrO4Lx1LaJtVaZs+tSCro1k9VCgfSD6qa0O5QC
	tnLDClu7Gm5QVS/dd8GzumVUh9WilYePKt8oSh5vRv13BUkNHWuc43DQaPC3LKFP
	TKjhC3i3vRsnKrCtw6tQNfFfYpBwLhngpUlUUjOnyDbYQ3aoYvdjg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwkehw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJtXso007313
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurjx1r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:01 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UNcmIu30474978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 23:38:48 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EFE658045;
	Tue, 30 Sep 2025 23:38:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53E8758050;
	Tue, 30 Sep 2025 23:38:59 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 23:38:59 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: wilder@us.ibm.com
Subject: [PATCH net-next v12 1/7] bonding: Adding struct bond_arp_target
Date: Tue, 30 Sep 2025 16:38:01 -0700
Message-ID: <20250930233849.2871027-2-wilder@us.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX/Ig8j4nhbPMm
 motg4I1qv8JZNPVHFvywFiJKphofKB4MLS1QKDPbvyhXOSeHlgodAzW3a+ifUPCzIjmIsPWNjP3
 H1VOBtU+XK19Zr6GLz4q1utNFXpAQGAHOKegqIVPHQwNVbyr/UEhl8p8BErun9oqhxNA+i9O/4y
 HDp4H01agBJDtzG2baop0Ft5eWJySY7+5qKv2bcJ6AVF2qwuVAftXvLvdb9s7dAaEUSaPpuWAtO
 JSzX+z39aA8aOpnN5B207l7LZO2UK7Ta61PovyajeJrUjg2LV4Ak1S83uj+Pa2xZ0nnMYFWkqWa
 lUmMUTs0TVByLgYy0MV5qWwHHKu3od9PlvncjuphOzEoh2sjhcmyGTp9qEtc9ntNef2CMYLHOKd
 P9cEsPk1e3XC9vPmkZEe9Kw1Uw6UCw==
X-Proofpoint-ORIG-GUID: fOdJ3S6Ls0iRb6o4WjX6qnUjN9N6KMow
X-Proofpoint-GUID: fOdJ3S6Ls0iRb6o4WjX6qnUjN9N6KMow
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dc6a16 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Al8d5LBM4mRIXYHQ2n4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Replacing the definition of bond_params.arp_targets (__be32 arp_targets[])
with:

struct bond_arp_target {
	__be32			target_ip;
	u32                     flags;
	struct bond_vlan_tag	*tags;
};

To provide storage for a list of vlan tags for each target.

All references to arp_target are change to use the new structure.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c    | 29 ++++++++++++++++-------------
 drivers/net/bonding/bond_netlink.c |  4 ++--
 drivers/net/bonding/bond_options.c | 18 +++++++++---------
 drivers/net/bonding/bond_procfs.c  |  4 ++--
 drivers/net/bonding/bond_sysfs.c   |  4 ++--
 include/net/bond_options.h         | 20 ++++++++++++++++++++
 include/net/bonding.h              | 15 +++++----------
 7 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1ea41f1a9190..57cf4585816d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3066,26 +3066,29 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
 	struct rtable *rt;
 	struct bond_vlan_tag *tags;
-	__be32 *targets = bond->params.arp_targets, addr;
+	struct bond_arp_target *targets = bond->params.arp_targets;
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
@@ -3103,15 +3106,15 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 
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
@@ -6066,7 +6069,7 @@ static int __init bond_check_params(struct bond_params *params)
 	int arp_all_targets_value = 0;
 	u16 ad_actor_sys_prio = 0;
 	u16 ad_user_port_key = 0;
-	__be32 arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
+	struct bond_arp_target arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
 	int arp_ip_count;
 	int bond_mode	= BOND_MODE_ROUNDROBIN;
 	int xmit_hashtype = BOND_XMIT_POLICY_LAYER2;
@@ -6260,7 +6263,7 @@ static int __init bond_check_params(struct bond_params *params)
 			arp_interval = 0;
 		} else {
 			if (bond_get_targets_ip(arp_target, ip) == -1)
-				arp_target[arp_ip_count++] = ip;
+				arp_target[arp_ip_count++].target_ip = ip;
 			else
 				pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\n",
 					&ip);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index ba71d95a82d2..cc00fbad9dd3 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -714,8 +714,8 @@ static int bond_fill_info(struct sk_buff *skb,
 
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
index 495a87f2ea7c..91d57ba968d6 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1125,7 +1125,7 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 			netdev_dbg(bond->dev, "ARP monitoring cannot be used with MII monitoring. Disabling MII monitoring\n");
 			bond->params.miimon = 0;
 		}
-		if (!bond->params.arp_targets[0])
+		if (!bond->params.arp_targets[0].target_ip)
 			netdev_dbg(bond->dev, "ARP monitoring has been set up, but no ARP targets have been specified\n");
 	}
 	if (bond->dev->flags & IFF_UP) {
@@ -1153,20 +1153,20 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 					    __be32 target,
 					    unsigned long last_rx)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct bond_arp_target *targets = bond->params.arp_targets;
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
+	struct bond_arp_target *targets = bond->params.arp_targets;
 	int ind;
 
 	if (!bond_is_ip_target_ok(target)) {
@@ -1201,7 +1201,7 @@ static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 
 static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct bond_arp_target *targets = bond->params.arp_targets;
 	struct list_head *iter;
 	struct slave *slave;
 	unsigned long *targets_rx;
@@ -1220,20 +1220,20 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
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
index 9a75ad3181ab..7114bd4d7735 100644
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
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index e6eedf23aea1..dea58a07e4cc 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -121,6 +121,26 @@ struct bond_option {
 	int (*set)(struct bonding *bond, const struct bond_opt_value *val);
 };
 
+struct bond_vlan_tag {
+	__be16		vlan_proto;
+	unsigned short	vlan_id;
+};
+
+/* Value type flags:
+ *  BOND_TARGET_DONTFREE - never free the tags
+ *  BOND_TARGET_USERTAGS - tags have been supplied by the user
+ */
+enum {
+	BOND_TARGET_DONTFREE = BIT(0),
+	BOND_TARGET_USERTAGS = BIT(1),
+};
+
+struct bond_arp_target {
+	__be32			target_ip;
+	u32                     flags;
+	struct bond_vlan_tag	*tags;
+};
+
 int __bond_opt_set(struct bonding *bond, unsigned int option,
 		   struct bond_opt_value *val,
 		   struct nlattr *bad_attr, struct netlink_ext_ack *extack);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 37335f62f579..a0eae209315f 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -136,7 +136,7 @@ struct bond_params {
 	int ad_select;
 	char primary[IFNAMSIZ];
 	int primary_reselect;
-	__be32 arp_targets[BOND_MAX_ARP_TARGETS];
+	struct bond_arp_target arp_targets[BOND_MAX_ARP_TARGETS];
 	int tx_queues;
 	int all_slaves_active;
 	int resend_igmp;
@@ -276,11 +276,6 @@ struct bonding {
 void bond_queue_slave_event(struct slave *slave);
 void bond_lower_state_changed(struct slave *slave);
 
-struct bond_vlan_tag {
-	__be16		vlan_proto;
-	unsigned short	vlan_id;
-};
-
 /*
  * Returns NULL if the net_device does not belong to any of the bond's slaves
  *
@@ -524,7 +519,7 @@ static inline unsigned long slave_oldest_target_arp_rx(struct bonding *bond,
 	int i = 1;
 	unsigned long ret = slave->target_last_arp_rx[0];
 
-	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++)
+	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i].target_ip; i++)
 		if (time_before(slave->target_last_arp_rx[i], ret))
 			ret = slave->target_last_arp_rx[i];
 
@@ -762,14 +757,14 @@ static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
 /* Check if the ip is present in arp ip list, or first free slot if ip == 0
  * Returns -1 if not found, index if found
  */
-static inline int bond_get_targets_ip(__be32 *targets, __be32 ip)
+static inline int bond_get_targets_ip(struct bond_arp_target *targets, __be32 ip)
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
2.50.1


