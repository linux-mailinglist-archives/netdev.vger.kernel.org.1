Return-Path: <netdev+bounces-212652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D5B2191C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BC62154D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8FB25CC63;
	Mon, 11 Aug 2025 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NbMp2yOU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E52367C9
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954378; cv=none; b=jV1qKPhTqWWY6wDkSP/u45Gnf3xro1Kloa6QGwYaLyaE62UIagyt0fZbe879A1N4JIsOVMYz1GheiE7RNc4i4CGsYmOu8o+POKZv1Vzd+YssAL2AzL+bwg5qoqR8E8/13eWltyAhOPrRiqjlWlC3ahXyiwvfJUrGPE70RvF6cpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954378; c=relaxed/simple;
	bh=f/80rqNvR2XUX7QQH/EdiQgPvX6wkvywQ9bOWrDucuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky5D5GVjZxEDsLlX3jbNc28c+mpqoJYZUtJKmSdNevmTJglKeKOoZxlXbvFL5r7MsfIEapMb7/xq++FXu7Hi6cjMvU06G91g4uxtndMpb0+slQh3isecc/FsSY1P8Xhckkj9bvD6cJXBSYHUmbVVrCPiKxz0IQoVgvVQB3fwpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NbMp2yOU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BLsXjM018126;
	Mon, 11 Aug 2025 23:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JlvtyrxdWmCs7hyDg
	kF0DkyBgyhQtjtY1jy3LvbOfgY=; b=NbMp2yOUupsfusOrLqiDcVl9RfXhw+9gS
	FIZoyFKZXiSGQsqXptp8k3aNvrI9DiDxaNalIyYdI2jHZuQlCRvIaBfJYxSZhH+c
	BMMXageQ7va95NmHK+W6QPiW2zksT4nsig1CxO3n8saXPhHhHl+hZ7A+u3CdP1fU
	khBip6cxPCINOfftaBmEB3mUYmCDM3BTJylWgiif+W8Lq/xDGyI177VX8yhC2Crv
	d1/BW2RLL843iobJE/9SHkogiEioJ+QVRfpfXsCm4Y1Phyno+SFRFFEo/moyjLdG
	1A17mnV332KtLm5OXVL8gRChKdHsK+JBQOqTYQeZj0wlTYLkGfVYA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cup90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BK4qZV025654;
	Mon, 11 Aug 2025 23:19:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvm7pkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BNJJkJ1902016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 23:19:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09ADA5805D;
	Mon, 11 Aug 2025 23:19:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B53EF58055;
	Mon, 11 Aug 2025 23:19:18 +0000 (GMT)
Received: from localhost (unknown [9.61.174.150])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 23:19:18 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v7 4/7] bonding: Processing extended arp_ip_target from user space.
Date: Mon, 11 Aug 2025 16:18:03 -0700
Message-ID: <20250811231909.1827080-5-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811231909.1827080-1-wilder@us.ibm.com>
References: <20250811231909.1827080-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE2NSBTYWx0ZWRfXz7+5x1+vZmYU
 RPTRKCKYApclT9GHwz/kK110hGkKe+wFGr+XPDigVPlKhl3eaAXFXGBdxOsvUx8c1niJxuvc+D3
 oENB+FQx5ZPcFT3N+fGZLpxOOZqNgM+46io8UPsvkhBxjRiSCWhimWScBqLzItI40Rb3DHtZMYt
 QtceWb7i80OqUFwIMoqfaK8jjjeY/1ftec30aQvFZGQoyVi35Z8GmvpVhapsVALWKRx8uZ2/Ywr
 w3Zv0vB+mwwQee+M3grHnAqXRHsmCgq0fWw9AuoEZPm37FhQAlmivpYQQ3nx1sgRbygsvljRTev
 ORsYsq7Nk04oRqjAwxe6zEJnxE0L3+H1UvuFluIoBN+1RmJ1imOsrmgmU403N6JR86Wrbs/txRW
 PUsEWmA2VsH8nQWZcUxJ+dH5ixfvrgwdtD9ekRgCuoArTydlUeheiYKdG3dF1QcunV7LvZa6
X-Proofpoint-GUID: _RMNyn2ogTZyGrxmQEPIAnGs969Mc2oR
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689a7a79 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=CoZdYgcViVoGV0ZuhukA:9
X-Proofpoint-ORIG-GUID: _RMNyn2ogTZyGrxmQEPIAnGs969Mc2oR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=838 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110165

Changes to bond_netlink and bond_options to process extended
format arp_ip_target option sent from user space via the ip
command.

The extended format adds a list of vlan tags to the ip target address.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c |  5 +-
 drivers/net/bonding/bond_options.c | 82 +++++++++++++++++++++---------
 2 files changed, 61 insertions(+), 26 deletions(-)

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
index e04487f8d79a..e44e57557a31 100644
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
@@ -1219,30 +1221,46 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
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
@@ -1253,7 +1271,23 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
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
+		if (len >= sizeof(struct bond_vlan_tag))
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
2.50.1


