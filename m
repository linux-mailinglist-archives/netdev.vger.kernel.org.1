Return-Path: <netdev+bounces-194693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164ABACBEF3
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DB37A24F6
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A418DB24;
	Tue,  3 Jun 2025 03:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WZXC/ZY6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958C1798F
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748922775; cv=none; b=rPemn3E6+y0HNuYPvwtqPRljjfATRoqakWhAwt1ba8Fh25/X2x/eWHInJDEaq0EymFhXlTbWUgvEwfTkZ7CxVWrp+td4KR5FAH53Sun6GxkkoL19NF1npZadKB5DPeUs7uOBhS2p0aIFtFLfdu43IkZL4H0Q6C/yzWyqCnzH9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748922775; c=relaxed/simple;
	bh=cgL11n2DwqIZz8EoRLdZ3C1Y8Hj3OZi+fNuL+tWYLkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbRM6MoTAylG0mN1XUBOj7JER73kN5X5B4ct/EEIGhMvsqd5JZVEAjxGPB35M0EsZ0KWOd3VOKKImFSbTmXGcs00tofdv0V23i3xraQOLihdtPJXl4aN4rzyde50b5ocNWpOLQGtK2uEttGVqUZj6oaXQitQt7XLD09KCE6Co8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WZXC/ZY6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HX6jQ014535
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O8Rr/EQMD5se+Zf0y
	jRr3XJwrIHEPN4FkJCzqVwOYWE=; b=WZXC/ZY6JNHgNP0varn63vONJIWXJ5sPZ
	oiR78N4v08xRbmqjSvjeQPHP76aB7jbym4xgSrwOM6GY1zYv/tMBmIV3SGeh77qJ
	f0i3fX6pSe2hWH/oSOsjC8ksObTD3p9+jl9rn0GgapOqUG/fVXxuGIn8F+TBxYXS
	TP9mscq4xKdsdP0AlDDDcbshm/SeHbnAeqJA/v2GuJLK/DMtUDvsdGGZXV7eNN1x
	z9aePzjBXDA5oQikVpEUmbRsH4kpbcQrsYnyPwOc/pN2XZp6qyRHZinplI//LG5E
	ibaZ+m62lfKJl5Dw3K89PMU5cVLr+iD5fZ/m6T0h6xqf9ezSVITBA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyj0mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:52:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5530JqIU024944
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkm8ycr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:52:50 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5533qoEE2884244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74E0D58050
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A7C258045
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:50 +0000 (GMT)
Received: from localhost (unknown [9.61.177.224])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:50 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/4] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Mon,  2 Jun 2025 20:51:48 -0700
Message-ID: <20250603035243.402806-3-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603035243.402806-1-wilder@us.ibm.com>
References: <20250603035243.402806-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: On64zuvvBzDgARrSFGiUrt4vJg6q4GdJ
X-Proofpoint-ORIG-GUID: On64zuvvBzDgARrSFGiUrt4vJg6q4GdJ
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=683e7193 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=_9dExB9TU08cRdUV:21 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Ew-S_ov8G7oilRGAPbIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDAzMCBTYWx0ZWRfX6wBwywvmKbMk QkZMzy984mEerdz7dEItB8k3AYBgeFMW799Kml+NQLdO1dg4DdIqb1qh8QoKmtM/gOTVlRqrlR4 p80mx6FcsVaRnswGL+zMCBi0dtXNrZDntHo3NfuuLyeLYag/30KLezQ9GmEGC0U2IHY7hkuII0c
 nGm4LTAB6FvWz2V3o5b/njuL+3LBmYHQYuU7EnMo6ahJ3DcAmvdwQ4efdm2HzBoP+1Q3hrG+ZQg TeA1oh6ufq/PgO31XvaJtCv8mmbfH9BrJFMKNYGzJ7QUe8qiE76/mVV+yPPmdl3oO/ckZztWf6r iMg1D1yJJbjNo7DmzKJoT/MPQL2YQ3KsvuUk7gafqNJotLuZgv+4TLeSKs6HGsRNLSIw2RlkBtu
 knn1JdzDhWmH5vbJTl5ErOeQKoAZHiWH9X42tf7thuPnjwRVnsO+ofl+3qG+B1D9M4bTeHhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030030

This change extends the "arp_ip_target" parameter format to allow for a
list of vlan tags to be included for each arp target. This new list of
tags is optional and may be omitted to preserve the current format and
process of gathering tags.  When provided the list of tags circumvents
the process of gathering tags by using the supplied list. An empty list
can be provided to simply skip the process of gathering tags.

Signed-off-by: David J Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c    |  47 +++++----
 drivers/net/bonding/bond_netlink.c |  12 ++-
 drivers/net/bonding/bond_options.c |  57 ++++++-----
 drivers/net/bonding/bond_procfs.c  |   5 +-
 drivers/net/bonding/bond_sysfs.c   |   9 +-
 include/net/bond_options.h         |  20 ++++
 include/net/bonding.h              | 156 +++++++++++++++++++++++++++--
 7 files changed, 248 insertions(+), 58 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ac654b384ea1..a181879ab0c0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3029,8 +3029,6 @@ static bool bond_has_this_ip(struct bonding *bond, __be32 ip)
 	return ret;
 }
 
-#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
-
 static bool bond_handle_vlan(struct slave *slave, struct bond_vlan_tag *tags,
 			     struct sk_buff *skb)
 {
@@ -3153,13 +3151,15 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
 		target_ip = targets[i].target_ip;
 		tags = targets[i].tags;
+		char pbuf[BOND_OPTION_STRING_MAX_SIZE];
 
-		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
-			  __func__, &target_ip);
+		bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf));
+		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__, pbuf);
 
 		/* Find out through which dev should the packet go */
 		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
 				     RT_SCOPE_LINK);
+
 		if (IS_ERR(rt)) {
 			/* there's no route to target_ip - try to send arp
 			 * probe to generate any traffic (arp_validate=0)
@@ -3177,9 +3177,13 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
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
@@ -3195,7 +3199,6 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
 		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
-		kfree(tags);
 	}
 }
 
@@ -6077,6 +6080,7 @@ static void bond_uninit(struct net_device *bond_dev)
 	bond_for_each_slave(bond, slave, iter)
 		__bond_release_one(bond_dev, slave->dev, true, true);
 	netdev_info(bond_dev, "Released all slaves\n");
+	bond_free_vlan_tags(bond->params.arp_targets);
 
 #ifdef CONFIG_XFRM_OFFLOAD
 	mutex_destroy(&bond->ipsec_lock);
@@ -6283,21 +6287,26 @@ static int __init bond_check_params(struct bond_params *params)
 
 	for (arp_ip_count = 0, i = 0;
 	     (arp_ip_count < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
-		__be32 ip;
+		struct bond_arp_target tmp_arp_target;
 
-		/* not a complete check, but good enough to catch mistakes */
-		if (!in4_pton(arp_ip_target[i], -1, (u8 *)&ip, -1, NULL) ||
-		    !bond_is_ip_target_ok(ip)) {
+		if (bond_arp_ip_target_opt_parse(arp_ip_target[i], &tmp_arp_target)) {
 			pr_warn("Warning: bad arp_ip_target module parameter (%s), ARP monitoring will not be performed\n",
 				arp_ip_target[i]);
 			arp_interval = 0;
-		} else {
-			if (bond_get_targets_ip(arp_target, ip) == -1)
-				arp_target[arp_ip_count++].target_ip = ip;
-			else
-				pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\n",
-					&ip);
+			break;
 		}
+
+		if (bond_get_targets_ip(arp_target, tmp_arp_target.target_ip) != -1) {
+			pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\n",
+				&tmp_arp_target.target_ip);
+			kfree(tmp_arp_target.tags);
+			continue;
+		}
+
+		arp_target[i].target_ip = tmp_arp_target.target_ip;
+		arp_target[i].tags = tmp_arp_target.tags;
+		arp_target[i].flags |= BOND_TARGET_DONTFREE;
+		++arp_ip_count;
 	}
 
 	if (arp_interval && !arp_ip_count) {
@@ -6663,7 +6672,7 @@ static void __exit bonding_exit(void)
 
 	bond_netlink_fini();
 	unregister_pernet_subsys(&bond_net_ops);
-
+	bond_free_vlan_tags_all(bonding_defaults.arp_targets);
 	bond_destroy_debugfs();
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 1a3d17754c0a..78d41b7b28b5 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -288,13 +288,21 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 		bond_option_arp_ip_targets_clear(bond);
 		nla_for_each_nested(attr, data[IFLA_BOND_ARP_IP_TARGET], rem) {
 			__be32 target;
+			char target_str[1024 + 1];
 
 			if (nla_len(attr) < sizeof(target))
 				return -EINVAL;
 
-			target = nla_get_be32(attr);
+			if (nla_len(attr) > sizeof(target)) {
+				snprintf(target_str, sizeof(target_str),
+					 "%s%s", "+", (__force char *)nla_data(attr));
+
+				bond_opt_initstr(&newval, target_str);
+			} else {
+				target = nla_get_be32(attr);
+				bond_opt_initval(&newval, (__force u64)target);
+			}
 
-			bond_opt_initval(&newval, (__force u64)target);
 			err = __bond_opt_set(bond, BOND_OPT_ARP_TARGETS,
 					     &newval,
 					     data[IFLA_BOND_ARP_IP_TARGET],
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index e4b7eb376575..42a11483320c 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -31,8 +31,8 @@ static int bond_option_use_carrier_set(struct bonding *bond,
 				       const struct bond_opt_value *newval);
 static int bond_option_arp_interval_set(struct bonding *bond,
 					const struct bond_opt_value *newval);
-static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target);
-static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target);
+static int bond_option_arp_ip_target_add(struct bonding *bond, struct bond_arp_target target);
+static int bond_option_arp_ip_target_rem(struct bonding *bond, struct bond_arp_target target);
 static int bond_option_arp_ip_targets_set(struct bonding *bond,
 					  const struct bond_opt_value *newval);
 static int bond_option_ns_ip6_targets_set(struct bonding *bond,
@@ -1115,7 +1115,7 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 }
 
 static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
-					    __be32 target,
+					    struct bond_arp_target target,
 					    unsigned long last_rx)
 {
 	struct bond_arp_target *targets = bond->params.arp_targets;
@@ -1125,24 +1125,24 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
 		bond_for_each_slave(bond, slave, iter)
 			slave->target_last_arp_rx[slot] = last_rx;
-		targets[slot].target_ip = target;
+		memcpy(&targets[slot], &target, sizeof(target));
 	}
 }
 
-static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
+static int _bond_option_arp_ip_target_add(struct bonding *bond, struct bond_arp_target target)
 {
 	struct bond_arp_target *targets = bond->params.arp_targets;
 	int ind;
 
-	if (!bond_is_ip_target_ok(target)) {
+	if (!bond_is_ip_target_ok(target.target_ip)) {
 		netdev_err(bond->dev, "invalid ARP target %pI4 specified for addition\n",
-			   &target);
+			   &target.target_ip);
 		return -EINVAL;
 	}
 
-	if (bond_get_targets_ip(targets, target) != -1) { /* dup */
+	if (bond_get_targets_ip(targets, target.target_ip) != -1) { /* dup */
 		netdev_err(bond->dev, "ARP target %pI4 is already present\n",
-			   &target);
+			   &target.target_ip);
 		return -EINVAL;
 	}
 
@@ -1152,19 +1152,19 @@ static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 		return -EINVAL;
 	}
 
-	netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target);
+	netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target.target_ip);
 
 	_bond_options_arp_ip_target_set(bond, ind, target, jiffies);
 
 	return 0;
 }
 
-static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
+static int bond_option_arp_ip_target_add(struct bonding *bond, struct bond_arp_target target)
 {
 	return _bond_option_arp_ip_target_add(bond, target);
 }
 
-static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
+static int bond_option_arp_ip_target_rem(struct bonding *bond, struct bond_arp_target target)
 {
 	struct bond_arp_target *targets = bond->params.arp_targets;
 	struct list_head *iter;
@@ -1172,23 +1172,23 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 	unsigned long *targets_rx;
 	int ind, i;
 
-	if (!bond_is_ip_target_ok(target)) {
+	if (!bond_is_ip_target_ok(target.target_ip)) {
 		netdev_err(bond->dev, "invalid ARP target %pI4 specified for removal\n",
-			   &target);
+			   &target.target_ip);
 		return -EINVAL;
 	}
 
-	ind = bond_get_targets_ip(targets, target);
+	ind = bond_get_targets_ip(targets, target.target_ip);
 	if (ind == -1) {
 		netdev_err(bond->dev, "unable to remove nonexistent ARP target %pI4\n",
-			   &target);
+			   &target.target_ip);
 		return -EINVAL;
 	}
 
 	if (ind == 0 && !targets[1].target_ip && bond->params.arp_interval)
 		netdev_warn(bond->dev, "Removing last arp target with arp_interval on\n");
 
-	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target);
+	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target.target_ip);
 
 	bond_for_each_slave(bond, slave, iter) {
 		targets_rx = slave->target_last_arp_rx;
@@ -1196,9 +1196,16 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 			targets_rx[i] = targets_rx[i+1];
 		targets_rx[i] = 0;
 	}
-	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++)
-		targets[i] = targets[i+1];
+
+	bond_free_vlan_tag(&targets[ind]);
+
+	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++) {
+		targets[i].target_ip = targets[i + 1].target_ip;
+		targets[i].tags = targets[i + 1].tags;
+		targets[i].flags = targets[i + 1].flags;
+	}
 	targets[i].target_ip = 0;
+	targets[i].tags = NULL;
 
 	return 0;
 }
@@ -1206,20 +1213,24 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 void bond_option_arp_ip_targets_clear(struct bonding *bond)
 {
 	int i;
+	struct bond_arp_target empty_target;
+
+	empty_target.target_ip = 0;
+	empty_target.tags = NULL;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
-		_bond_options_arp_ip_target_set(bond, i, 0, 0);
+		_bond_options_arp_ip_target_set(bond, i, empty_target, 0);
 }
 
 static int bond_option_arp_ip_targets_set(struct bonding *bond,
 					  const struct bond_opt_value *newval)
 {
 	int ret = -EPERM;
-	__be32 target;
+	struct bond_arp_target target;
 
 	if (newval->string) {
 		if (strlen(newval->string) < 1 ||
-		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
+		    bond_arp_ip_target_opt_parse(newval->string + 1, &target)) {
 			netdev_err(bond->dev, "invalid ARP target specified\n");
 			return ret;
 		}
@@ -1230,7 +1241,7 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 		else
 			netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
 	} else {
-		target = newval->value;
+		target.target_ip = newval->value;
 		ret = bond_option_arp_ip_target_add(bond, target);
 	}
 
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 94e6fd7041ee..b07944396912 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -111,6 +111,7 @@ static void bond_info_show_master(struct seq_file *seq)
 
 	/* ARP information */
 	if (bond->params.arp_interval > 0) {
+		char pbuf[BOND_OPTION_STRING_MAX_SIZE];
 		int printed = 0;
 
 		seq_printf(seq, "ARP Polling Interval (ms): %d\n",
@@ -125,7 +126,9 @@ static void bond_info_show_master(struct seq_file *seq)
 				break;
 			if (printed)
 				seq_printf(seq, ",");
-			seq_printf(seq, " %pI4", &bond->params.arp_targets[i].target_ip);
+			bond_arp_target_to_string(&bond->params.arp_targets[i],
+						  pbuf, sizeof(pbuf));
+			seq_printf(seq, " %s", pbuf);
 			printed = 1;
 		}
 		seq_printf(seq, "\n");
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index d7c09e0a14dd..feff53e69bd3 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -288,11 +288,14 @@ static ssize_t bonding_show_arp_targets(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 	int i, res = 0;
+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i].target_ip)
-			res += sysfs_emit_at(buf, res, "%pI4 ",
-					     &bond->params.arp_targets[i].target_ip);
+		if (bond->params.arp_targets[i].target_ip) {
+			bond_arp_target_to_string(&bond->params.arp_targets[i],
+						  pbuf, sizeof(pbuf));
+			res += sysfs_emit_at(buf, res, "%s ", pbuf);
+		}
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
index fc685779d27d..decb83930e86 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -23,6 +23,7 @@
 #include <linux/etherdevice.h>
 #include <linux/reciprocal_div.h>
 #include <linux/if_link.h>
+#include <linux/inet.h>
 
 #include <net/bond_3ad.h>
 #include <net/bond_alb.h>
@@ -115,11 +116,6 @@ static inline int is_netpoll_tx_blocked(struct net_device *dev)
 #define is_netpoll_tx_blocked(dev) (0)
 #endif
 
-struct bond_arp_target {
-	__be32 target_ip;
-	struct bond_vlan_tag *tags;
-};
-
 struct bond_params {
 	int mode;
 	int xmit_policy;
@@ -279,11 +275,6 @@ struct bonding {
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
@@ -797,6 +788,151 @@ static inline int bond_get_targets_ip6(struct in6_addr *targets, struct in6_addr
 }
 #endif
 
+#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
+#define BOND_OPTION_STRING_MAX_SIZE 512
+
+/* Convert vlan_list into struct bond_vlan_tag.
+ * Inspired by bond_verify_device_path();
+ */
+static inline struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list, int level)
+{
+	struct bond_vlan_tag *tags;
+	char *vlan;
+
+	if (!vlan_list || strlen(vlan_list) == 0) {
+		tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
+		if (!tags)
+			return ERR_PTR(-ENOMEM);
+		tags[level].vlan_proto = BOND_VLAN_PROTO_NONE;
+		return tags;
+	}
+
+	for (vlan = strsep(&vlan_list, "/"); (vlan != 0); level++) {
+		tags = bond_vlan_tags_parse(vlan_list, level + 1);
+		if (IS_ERR_OR_NULL(tags)) {
+			if (IS_ERR(tags))
+				return tags;
+			continue;
+		}
+
+		tags[level].vlan_proto = __cpu_to_be16(ETH_P_8021Q);
+		if (kstrtou16(vlan, 0, &tags[level].vlan_id)) {
+			kfree(tags);
+			return ERR_PTR(-EINVAL);
+		}
+
+		if (tags[level].vlan_id < 1 || tags[level].vlan_id > 4094) {
+			kfree(tags);
+			return ERR_PTR(-EINVAL);
+		}
+
+		return tags;
+	}
+
+	return NULL;
+}
+
+/**
+ * bond_arp_ip_target_opt_parse - parse a single arp_ip_target option value string
+ * @src: the option value to be parsed
+ * @dest: struct bond_arp_target to place the results.
+ *
+ * This function parses a single arp_ip_target string in the form:
+ * x.x.x.x[tag/....] into a struct bond_arp_target.
+ * Returns 0 on success.
+ */
+static inline int bond_arp_ip_target_opt_parse(char *src, struct bond_arp_target *dest)
+{
+	char *ipv4, *vlan_list;
+	char target[BOND_OPTION_STRING_MAX_SIZE], *args;
+	struct bond_vlan_tag *tags = NULL;
+	__be32 ip;
+
+	if (strlen(src) > BOND_OPTION_STRING_MAX_SIZE)
+		return -E2BIG;
+
+	pr_debug("Parsing arp_ip_target (%s)\n", src);
+
+	/* copy arp_ip_target[i] to local array, strsep works
+	 * destructively...
+	 */
+	args = target;
+	strscpy(target, src);
+	ipv4 = strsep(&args, "[");
+
+	/* not a complete check, but good enough to catch mistakes */
+	if (!in4_pton(ipv4, -1, (u8 *)&ip, -1, NULL) ||
+	    !bond_is_ip_target_ok(ip)) {
+		return -EINVAL;
+	}
+
+	/* extract vlan tags */
+	vlan_list = strsep(&args, "]");
+
+	/* If a vlan list was not supplied skip the processing of the list.
+	 * A value of "[]" is a valid list and should be handled a such.
+	 */
+	if (vlan_list) {
+		tags = bond_vlan_tags_parse(vlan_list, 0);
+		dest->flags |= BOND_TARGET_USERTAGS;
+		if (IS_ERR(tags))
+			return PTR_ERR(tags);
+	}
+
+	dest->target_ip = ip;
+	dest->tags = tags;
+
+	return 0;
+}
+
+static inline int bond_arp_target_to_string(struct bond_arp_target *target,
+					    char *buf, int size)
+{
+	struct bond_vlan_tag *tags = target->tags;
+	int i, num = 0;
+
+	if (!(target->flags & BOND_TARGET_USERTAGS)) {
+		num = snprintf(&buf[0], size, "%pI4", &target->target_ip);
+		return num;
+	}
+
+	num = snprintf(&buf[0], size, "%pI4[", &target->target_ip);
+	if (tags) {
+		for (i = 0; (tags[i].vlan_proto != BOND_VLAN_PROTO_NONE); i++) {
+			if (!tags[i].vlan_id)
+				continue;
+			if (i != 0)
+				num = num + snprintf(&buf[num], size-num, "/");
+			num = num + snprintf(&buf[num], size-num, "%u",
+					     tags[i].vlan_id);
+		}
+	}
+	snprintf(&buf[num], size-num, "]");
+	return num;
+}
+
+static inline void bond_free_vlan_tag(struct bond_arp_target *target)
+{
+	if (!(target->flags & BOND_TARGET_DONTFREE))
+		kfree(target->tags);
+}
+
+static inline void __bond_free_vlan_tags(struct bond_arp_target *targets, int all)
+{
+	int i;
+
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].tags; i++) {
+		if (!all)
+			bond_free_vlan_tag(&targets[i]);
+		else
+			kfree(targets[i].tags);
+	}
+}
+
+#define bond_free_vlan_tags(targets)  __bond_free_vlan_tags(targets, 0)
+#define bond_free_vlan_tags_all(targets) __bond_free_vlan_tags(targets, 1)
+
+
 /* exported from bond_main.c */
 extern unsigned int bond_net_id;
 
-- 
2.43.5


