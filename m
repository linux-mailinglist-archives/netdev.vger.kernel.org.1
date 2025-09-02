Return-Path: <netdev+bounces-219317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E45B40F4D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91062005E5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B23B2E1F11;
	Tue,  2 Sep 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PAq5hQec"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6C253F2A
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848138; cv=none; b=F/XkOnVWF5ZNmH+uEOHXva8nyFrFCbZK6NAjtw4BYVOCjOvhSTGFl+fXsjDkF7UnC7ErFDTJ0PZDNDf38Soyd8uLB01gn/B4smFJejRtMoGdymv9zOaYMrHNNPIXyvnbinrb9GXqCUY69GGz4qTW1JKgGLwfrwE8Fxt6Whn74EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848138; c=relaxed/simple;
	bh=y101hGsaktp9tFwSWNgaUb+RCwP/iLRvl4/yRVnIhT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XncTyNtWjq5ZSuG6coGDZUZLml0Xelw6j1tU1MKBs1une74HmKdNTCjZWDp6ZJ+GaQ4OfHCQqGSmN08jNTopYM9U4k3D3A6f9JRBAcWNhMRujAfo3z6ACo3axEnlO85nWGks8oeNCVt8/mZSE2CWeXsR2b2wbr+hDte+NjlDnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PAq5hQec; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582IiWYU001901;
	Tue, 2 Sep 2025 20:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0Hx2xxO21KCCCJcDs
	udzH7RyNJoeA6yLAzbUnCp16b4=; b=PAq5hQecBZnxFU5bLdzWr1syOfQR93jmF
	pB5HsNMK2A6VswNLzLN63JVQYGZ+WnEVpX7Yf6u80e30WX1q04ZPUOupcLwVx6MH
	nT6syRK1BRs5E1q3GZ7XUQKFPRmlMkKH2wxmhCc0AwDDLledII/VrLYzc/9jNiu5
	w8DKUhzWZUwIANZug8TuGzrTntYE4BYN9LAjYSAIEvNtUzMnI/u/cgJaiQZNeygN
	TP8kdt0p0eWkO+mlPvbD4Urf4dPYarh4vG6QfJjiS1vFCEs1zKbxpQjcHeqVDn0g
	+xzxjtcqqfX0zx4T6X3HYj756/Edc0eynEYSQP/Aej1lrdxnp0nLg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usua0bef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582Hg4s8013959;
	Tue, 2 Sep 2025 20:43:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3c2md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582Khrxw30933590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 20:43:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8EAE58053;
	Tue,  2 Sep 2025 20:43:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E71958043;
	Tue,  2 Sep 2025 20:43:53 +0000 (GMT)
Received: from localhost (unknown [9.61.19.179])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 20:43:53 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v9 4/7] bonding: Processing extended arp_ip_target from user space.
Date: Tue,  2 Sep 2025 13:43:00 -0700
Message-ID: <20250902204340.2315079-5-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902204340.2315079-1-wilder@us.ibm.com>
References: <20250902204340.2315079-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zuYg0YejwC2GO_Zx7pU8_rxeFtO8PmPR
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68b7570d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=8MP5e_xu_S4MiSi9wGMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX06l0gupE7hn9
 nFlJSg07O8vgtE7G7SRR8VmMVp9gjTNO0nckEKrTQ1ZUHrjqumvREOGNfF4wZOK6VXP/oCiSTF4
 ppCxS23Sgrq/ckkRTSAmLv9nWfyPRAq9P10Lc/0AhaBjwv+7fJk2VCOi6cfmZXt25ML/7phym1P
 u3CtdHiBvpWeqqlilpF+WTbcX/Gx2w0io9pouxZ72vdu0wn2NnpsZuWNee5O+uFT652Jv5EFPol
 lbzZ/VgHDJl3entpfouGR5LCXToeRI7myPICCwb0h2VA/CoHHgIHaKgl/u7cPghtl5HApxmYGcL
 36ADPrQcIyZziWDa5BwS7aBJqk97Vz3ZNe/x0NNTgzHk1JmBOcJstrOJ+xvnHPlbuDA6BeYPzKf
 vPW2ObZp
X-Proofpoint-ORIG-GUID: zuYg0YejwC2GO_Zx7pU8_rxeFtO8PmPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

Changes to bond_netlink and bond_options to process extended
format arp_ip_target option sent from user space via the ip
command.

The extended format adds a list of vlan tags to the ip target address.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c |   5 +-
 drivers/net/bonding/bond_options.c | 121 +++++++++++++++++++++++------
 2 files changed, 99 insertions(+), 27 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 9939e28dedd9..5486ef40907e 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -293,9 +293,10 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			if (nla_len(attr) < sizeof(target))
 				return -EINVAL;
 
-			target = nla_get_be32(attr);
+			bond_opt_initextra(&newval,
+					   (__force void *)nla_data(attr),
+					   nla_len(attr));
 
-			bond_opt_initval(&newval, (__force u64)target);
 			err = __bond_opt_set(bond, BOND_OPT_ARP_TARGETS,
 					     &newval,
 					     data[IFLA_BOND_ARP_IP_TARGET],
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 2c5e8d95999d..9f6b6ea11568 100644
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
@@ -1138,7 +1138,7 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 }
 
 static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
-					    __be32 target,
+					    struct bond_arp_target target,
 					    unsigned long last_rx)
 {
 	struct bond_arp_target *targets = bond->params.arp_targets;
@@ -1148,24 +1148,25 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
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
+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
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
 
@@ -1175,43 +1176,44 @@ static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 		return -EINVAL;
 	}
 
-	netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target);
+	netdev_dbg(bond->dev, "Adding ARP target %s\n",
+		   bond_arp_target_to_string(&target, pbuf, sizeof(pbuf)));
 
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
+	unsigned long *targets_rx;
 	struct list_head *iter;
 	struct slave *slave;
-	unsigned long *targets_rx;
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
@@ -1219,30 +1221,77 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
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
+	targets[i].flags = 0;
+	targets[i].tags = NULL;
 
 	return 0;
 }
 
 void bond_option_arp_ip_targets_clear(struct bonding *bond)
 {
+	struct bond_arp_target empty_target;
 	int i;
 
+	empty_target.target_ip = 0;
+	empty_target.flags = 0;
+	empty_target.tags = NULL;
+
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
-		_bond_options_arp_ip_target_set(bond, i, 0, 0);
+		_bond_options_arp_ip_target_set(bond, i, empty_target, 0);
+}
+
+/**
+ * bond_validate_tags - validate an array of bond_vlan_tag.
+ * @tags: the array to validate
+ * @len: the length in bytes of @tags
+ *
+ * Validate that @tags points to a valid array of struct bond_vlan_tag.
+ * Returns the length of the validated bytes in the array or -1 if no
+ * valid list is found.
+ */
+static int bond_validate_tags(struct bond_vlan_tag *tags, size_t len)
+{
+	size_t i, ntags = 0;
+
+	if (len == 0 || !tags)
+		return 0;
+
+	for (i = 0; i <= len; i = i + sizeof(struct bond_vlan_tag)) {
+		if (ntags > BOND_MAX_VLAN_TAGS)
+			break;
+
+		if (tags->vlan_proto == BOND_VLAN_PROTO_NONE)
+			return i + sizeof(struct bond_vlan_tag);
+
+		if (tags->vlan_id > 4094)
+			break;
+		tags++;
+		ntags++;
+	}
+	return -1;
 }
 
 static int bond_option_arp_ip_targets_set(struct bonding *bond,
 					  const struct bond_opt_value *newval)
 {
-	int ret = -EPERM;
-	__be32 target;
+	size_t len = (size_t)newval->extra_len;
+	char *extra = (char *)newval->extra;
+	struct bond_arp_target target;
+	int size, ret = -EPERM;
 
 	if (newval->string) {
+		/* Adding or removing arp_ip_target from sysfs */
 		if (strlen(newval->string) < 1 ||
-		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
+		    !in4_pton(newval->string + 1, -1, (u8 *)&target.target_ip, -1, NULL)) {
 			netdev_err(bond->dev, "invalid ARP target specified\n");
 			return ret;
 		}
@@ -1253,7 +1302,29 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 		else
 			netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
 	} else {
-		target = newval->value;
+		/* Adding arp_ip_target from netlink. aka: ip command */
+		if (len < sizeof(target.target_ip)) {
+			netdev_err(bond->dev, "invalid ARP target specified\n");
+			return ret;
+		}
+		memcpy(&target.target_ip, newval->extra, sizeof(__be32));
+		len = len - sizeof(target.target_ip);
+		extra = extra + sizeof(target.target_ip);
+
+		size = bond_validate_tags((struct bond_vlan_tag *)extra, len);
+
+		if (size > 0) {
+			target.tags = kmalloc((size_t)size, GFP_ATOMIC);
+			if (!target.tags)
+				return -ENOMEM;
+			memcpy(target.tags, extra, size);
+			target.flags |= BOND_TARGET_USERTAGS;
+		}
+
+		if (size == -1)
+			netdev_warn(bond->dev, "Invalid list of vlans provided with %pI4\n",
+				    &target.target_ip);
+
 		ret = bond_option_arp_ip_target_add(bond, target);
 	}
 
-- 
2.50.1


