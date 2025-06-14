Return-Path: <netdev+bounces-197698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B4AD9986
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FFC4A0DB0
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322C282EE;
	Sat, 14 Jun 2025 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s6OFf8D0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C4BA42
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749865769; cv=none; b=PE9TmW1seP+moSrGk4DjMo0HIuUKo0LRK93NLj07VA10UzD6NBCaUKr9+FpQbDvMUM3YpVVn/ZIeFp+JfEpdhKxiA1rozDe2J/bFOw1qhgBSgRi4UxgzsMGozYwyQt56JUbgu/LEarZufkyrtKGlWVSi1lLMsex4DCgEKqsYyps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749865769; c=relaxed/simple;
	bh=fDNTWXoh9VAv9P6So7sP+wwK9dpHjWiW2qVPRMu56d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXqcylid8qEABwPN1tiWnzIY091fOw+9IlAfGR9kKuoqQ7kziXydFT1FWpWPlHdqJ9/Xhy1KCv/vR6RlB4f4fZc/vPokydKJM92cnQh/rRnkh9/fjcx6huqSio73uPJejqfJ7Vz/HF7VKqyh4AjoVg/tYj2fF6jg1qHjpnrgVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s6OFf8D0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DFfu9C019988;
	Sat, 14 Jun 2025 01:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BSW3LWLkqDULBDr2Z
	aO8Qnr1OVaBb3OiIgeB9xrRtSM=; b=s6OFf8D0C+KCtNI1lxch/EYA+ly+kkVY1
	bcGbdZFrCwb5jqiFomC+OPLYRiQLTtPJL+AZytB1oCrZ91sE9bHqZnBybhY9yIte
	3NS4gFjoj8+O1tq9G/ErNtRHzFZYASkF7Lel8u8mIQK1IsEOKB1SGaruzxX+rI0x
	vWKKTa6VptGnSAPgRBBx9FPhfqzcSlC9jlsxHmkZGHsngJQzCtnAaULIdgXzcnX0
	ht/dNLA1hEgfhO1ZfI3i1r3EYyMcJUEhhkfdFd47g1zd/vPjg5jsI7njpw7w5AZP
	BXwYczjU9xHSl3YozHsd54qLorkJvqik3vu3eWngW7bEVPHADp92w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjvfad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 01:49:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55DM1gLh014912;
	Sat, 14 Jun 2025 01:49:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpmu2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 01:49:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55E1nHOY30016164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Jun 2025 01:49:17 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 058305804E;
	Sat, 14 Jun 2025 01:49:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B73A15803F;
	Sat, 14 Jun 2025 01:49:16 +0000 (GMT)
Received: from localhost (unknown [9.61.34.221])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Jun 2025 01:49:16 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v3 1/4] bonding: Adding struct bond_arp_target
Date: Fri, 13 Jun 2025 18:48:27 -0700
Message-ID: <20250614014900.226472-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250614014900.226472-1-wilder@us.ibm.com>
References: <20250614014900.226472-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k9lQcjqf6_njDs1bRreiFxajTzC08A1d
X-Proofpoint-GUID: k9lQcjqf6_njDs1bRreiFxajTzC08A1d
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684cd521 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Al8d5LBM4mRIXYHQ2n4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDAwOCBTYWx0ZWRfX8Wkf2cGRPIrO mdQfYKZvQ0Ow7F6zALIXAzbRFfOpH3uzX3/g+kVrL/tKSsSSm6rGMUW6eOX/vsjJksQkPMWbSoK VmoDZlyl7Zpy8RGOd1rSpwowLGIDA/wNwLnkjsStupTX7EuUYslvc5Olbjqj69wmXHtyjNh57SX
 RllNORKdnOGiWVx12TtjPZ47ctrZCIQg3Z6FFgdTAJ8MJA/BN+AM2rBC6NiltLE4Q8beA9krOhn URvXfBLYtM0JxVlfEi2g71kZlrmN8+4C3UvFxLYVLihsmgB0R2t+a2XxQb3Gqvz3Yw4Sii+Zl8F mppOAOHg+lKe1Kw8ww3ObRvnWwql20Akpt7Jfq1GPz3NTlQMCBg1v6g/idCro88MQESxKL9NyfW
 0IoKd7HOFXg3dcpIMPbRksA3CTQ5vpXuQKJqE7iTnp7B+PubRTk87iad0kOZ0wpDgMfCVyXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506140008

Replacing the definition of bond_params.arp_targets (__be32 arp_targets[])
with:

struct bond_arp_target {
	__be32			target_ip;
	struct bond_vlan_tag	*tags;
	u32			flags;
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
index c4d53e8e7c15..ac654b384ea1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3146,26 +3146,29 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
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
@@ -3183,15 +3186,15 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 
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
@@ -6096,7 +6099,7 @@ static int __init bond_check_params(struct bond_params *params)
 	int arp_all_targets_value = 0;
 	u16 ad_actor_sys_prio = 0;
 	u16 ad_user_port_key = 0;
-	__be32 arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
+	struct bond_arp_target arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
 	int arp_ip_count;
 	int bond_mode	= BOND_MODE_ROUNDROBIN;
 	int xmit_hashtype = BOND_XMIT_POLICY_LAYER2;
@@ -6290,7 +6293,7 @@ static int __init bond_check_params(struct bond_params *params)
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
index 91893c29b899..e4b7eb376575 100644
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
@@ -1166,7 +1166,7 @@ static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 
 static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct bond_arp_target *targets = bond->params.arp_targets;
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
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 18687ccf0638..0a7d690cb005 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -119,6 +119,26 @@ struct bond_option {
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
+	struct bond_vlan_tag	*tags;
+	u32			flags;
+};
+
 int __bond_opt_set(struct bonding *bond, unsigned int option,
 		   struct bond_opt_value *val,
 		   struct nlattr *bad_attr, struct netlink_ext_ack *extack);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308c19..5b4c43f02c89 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -135,7 +135,7 @@ struct bond_params {
 	int ad_select;
 	char primary[IFNAMSIZ];
 	int primary_reselect;
-	__be32 arp_targets[BOND_MAX_ARP_TARGETS];
+	struct bond_arp_target arp_targets[BOND_MAX_ARP_TARGETS];
 	int tx_queues;
 	int all_slaves_active;
 	int resend_igmp;
@@ -274,11 +274,6 @@ struct bonding {
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
@@ -522,7 +517,7 @@ static inline unsigned long slave_oldest_target_arp_rx(struct bonding *bond,
 	int i = 1;
 	unsigned long ret = slave->target_last_arp_rx[0];
 
-	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++)
+	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i].target_ip; i++)
 		if (time_before(slave->target_last_arp_rx[i], ret))
 			ret = slave->target_last_arp_rx[i];
 
@@ -760,14 +755,14 @@ static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
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
2.43.5


