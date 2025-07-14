Return-Path: <netdev+bounces-206894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F93B04B14
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3603E189D4E6
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03827979A;
	Mon, 14 Jul 2025 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ls0e+pBB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D5277C83
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533758; cv=none; b=hldTypFBoeS1mB6sITw8tv2jeAAUnUBz143cptpm0aE3yxbyykLON5Oqfw6WGEK0i9t9W8pH3s+yfgZOCfK5D2l7Z6IYggHG4jxrYgiomayK5XhZ/xCqeqJl5CkcPw2Bn6yzDW1Q8YWKjcZx4faJY0eJzI9x4ian3v1gxk74Nfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533758; c=relaxed/simple;
	bh=sgcS6mercSlCeCoitu1W8jhOJ7QBA/Lyc60WJVcNyTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyeojz56EY566q4soShjytAHcVKKW5QnKAUvEPbCgg25q6rtcDHO5bTbqCwND2A7OWO8QfJQz/jzjPFl63CQjD0Zbfi4NbU/Fo/dxvShjTEO1iyyaeG6maQ4V3hZZ/LpjuYTvHFRTmgEHEJTM6TBR/Vs0rdVKAyMhdtVpWw/gUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ls0e+pBB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EKxFnn012194;
	Mon, 14 Jul 2025 22:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+fF5wSkeEoLjGY/H7
	QwvhDWz4B5twb+RP5MBmz53OPs=; b=ls0e+pBBLsBIzzLithdhpsk5aD7reLnl8
	yY+Zh6BsOSQA9RsNSQVgQ7ycDc+9LiIr+1uEHUColu+SKWtul4wXf4UIo9vAMw00
	THadFbJ+WBGtg776paXaONfmvr22p9UHl5DuObXyDLj5QUQHJ+ALM298Ag4Dh+Ln
	eEIIFSi8uFntS1xGh0GK30kUOCE11dYQ8PcYUcaO4NWPNzS8AnPoQE6NTxKrVqf7
	Dkcz5iiU5MWYy19R7cD4J5cSUrQv8rOrQ6Qb/NV9syRxWf6nobakUZ7J8QddFaYD
	maubjkhTfZu5/Ydtq7H6zE3AnJB+2PihSQ9PGSbElytgahk/HMP5Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cv6h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EK1fAU021967;
	Mon, 14 Jul 2025 22:55:49 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r2yhr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:49 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EMtkir24248758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 22:55:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9787C58056;
	Mon, 14 Jul 2025 22:55:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA3258052;
	Mon, 14 Jul 2025 22:55:46 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 22:55:46 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v5 4/7] bonding: Processing extended arp_ip_target from user space.
Date: Mon, 14 Jul 2025 15:54:49 -0700
Message-ID: <20250714225533.1490032-5-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250714225533.1490032-1-wilder@us.ibm.com>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n5WVN-j26R673EzTMmu5QU1zEH-oraGA
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68758af6 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=CoZdYgcViVoGV0ZuhukA:9
X-Proofpoint-GUID: n5WVN-j26R673EzTMmu5QU1zEH-oraGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfX8bYci1Ofqu1S gtvdOf4q1tLavwkhVuK31FUXZXI9BtuNaH/DmPIHWxI7pAciDPGDHqhnMitwiflr8xJvjv7XNyP 0ZERdBAdFSagE0Lb+l2BTFKyQepNy9cjB2fB4vzTHfwGlielDaqWXb0ZTAaO3RQqdatUqdAseFf
 SsW63mzXw7hE/GEvGLrn+fFIi3P157+ThPFecMYij5dFHZpCKA6QnpiKKm83p/lhewFX6Z9na3r p8LBXcKJWJcfucvGBHPAFXx5x3v1OeoHxhmT4csaZtlO9+lBsLp3KL6LiDYfDA5gsMExAm5yLw1 otZXUf1yM05GNZVr56lF+Y3FmV13QkMOumvcT3ac/GrrTVx0j9jWsmxVY/DAOgkuWLGXhdTJMOl
 oXTFju2yUlv3t2noh6AUrD9Qo8y+OdGmTA0cuCeoPM6dkDxi2O5xR0xJYCxDnwKDG/LZ6dsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=817 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140159

Changes to bond_netlink and bond_options to process extended
format arp_ip_target option sent from user space via the ip
command.

The extended format adds a list of vlan tags to the ip target address.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c |  5 +-
 drivers/net/bonding/bond_options.c | 81 +++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 26 deletions(-)

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
index e04487f8d79a..1455e7f15c31 100644
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
@@ -1219,30 +1221,45 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
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
+	empty_target.tags = NULL;
+
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
-		_bond_options_arp_ip_target_set(bond, i, 0, 0);
+		_bond_options_arp_ip_target_set(bond, i, empty_target, 0);
 }
 
 static int bond_option_arp_ip_targets_set(struct bonding *bond,
 					  const struct bond_opt_value *newval)
 {
+	size_t len = (size_t)newval->extra_len;
+	char *extra = (char *)newval->extra;
+	struct bond_arp_target target;
 	int ret = -EPERM;
-	__be32 target;
 
 	if (newval->string) {
+		/* Adding or removing arp_ip_target from sysfs */
 		if (strlen(newval->string) < 1 ||
-		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
+		    !in4_pton(newval->string + 1, -1, (u8 *)&target.target_ip, -1, NULL)) {
 			netdev_err(bond->dev, "invalid ARP target specified\n");
 			return ret;
 		}
@@ -1253,7 +1270,23 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
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
+		if (len)
+			target.tags = kmalloc(len, GFP_ATOMIC);
+
+		if (target.tags) {
+			memcpy(target.tags, extra, len);
+			target.flags |= BOND_TARGET_USERTAGS;
+		}
+
 		ret = bond_option_arp_ip_target_add(bond, target);
 	}
 
-- 
2.43.5


