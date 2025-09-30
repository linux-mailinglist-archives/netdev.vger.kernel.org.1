Return-Path: <netdev+bounces-227255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F94DBAAE36
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ADF421988
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA082F4A;
	Tue, 30 Sep 2025 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhAEWDVY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7F1E5B70
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195774; cv=none; b=e39//JyMMkeMze5mfwce6b+sStYIkWrRUrRDSnZvyJpymASpa5cmCWB+aNktbv4a0b5ig2vBQZb+xmrx+oJZNd0Kks0uF0db/5Kdz4pGD5svzECsUtjdikZN/Ex/g2KzXwbkZVlP9R+7XMWTXfm55xohb4tR6qMMiJuusz53Ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195774; c=relaxed/simple;
	bh=yIwklXHiEWGdNACjrB1apRvFG9x3KDff1sT312aal4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYxS2B3pO1xLemnbBb4nVGlFVyuTalqPF4ZhEORbfsoh/er156jGIFkuYirzHU6f3HTodW422vthpCP2YQEI5H9w0EAj7BbNpblfETnSUQfWjUOWWNB7l36Ho1/PQIWcLY9BClEE7EybV27KgQLnDDiQ6eqbuxdn1b+5MzqQbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhAEWDVY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TIX2oT030392;
	Tue, 30 Sep 2025 01:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oyZ+qyIFpCj9Ob4+c
	B5nslIxPEW+fyLwBfYuvJ7JLkM=; b=bhAEWDVY+7p36VX+mn0+6o9vkLI5GsmvD
	bW++bRTZYW56GF9UUkcQdkPfnmnfthQbGPgYCD4OVsCZjWh0/seRX/ubFPaLhOpF
	VevHf5fAXr9sGV8Y47DRPdkK2xznl+hWIAnlaww+Vo8aMPG6Hn1OP2+IyVP1jT9i
	+hNMTYQX1Eu+Qxqh6ydyY9AOx7YeDRqlknlhKq0ktIPadDtOy/u5uGvsyprFUO+1
	auvOaXVMHAVO+OPyIzNC5V+CcbNhLrEwmaDuuRepyu4sAPdsdDuBPXMZF1bY1cFD
	nh+IlcnINmz0LqVYcOoc33m6zf8NZjZmppbfZBKWL9hrERAz6d8fA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e75sj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58U1Rkd5028599;
	Tue, 30 Sep 2025 01:29:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e75sj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLsNj3024198;
	Tue, 30 Sep 2025 01:29:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy10pau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58U1T6om54264150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 01:29:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B66A658056;
	Tue, 30 Sep 2025 01:29:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5054658052;
	Tue, 30 Sep 2025 01:29:06 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 01:29:06 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
        edumazet@google.com
Subject: [PATCH net-next v11 4/7] bonding: Processing extended arp_ip_target from user space.
Date: Mon, 29 Sep 2025 18:27:10 -0700
Message-ID: <20250930012857.2270721-5-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250930012857.2270721-1-wilder@us.ibm.com>
References: <20250930012857.2270721-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LQ6_yGZ6pHpNQVd7-YmQRqX1bDrgvBWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX7rjV0tEs2Rdu
 KAtGEgC74LxrqFHlhp2r3VDrh45yf2taQbsCHWVruwWbW7N+TfrbzZY+S/TvMeR7Xyias6i7ZEI
 SXkOullNVbZ4ABhFaJSenhUdc0639x/bzXcqHVDCZq7pS26upRfU9beEx1ktN8ScNv8fgBu0pcq
 kvSabfPu6uzK8ETEDB2cdpl8Fc59s4r1kUX55zxLevrZbZYRxHfinfFaDhrAxaHgF/no8K9tZ+n
 KXitzLE4mfjbGc82DyUHmCX+SHdr/DivkMuH1tzbeifS+GQF9hL1r+PBJtYFQ73RIqfMKCeB9dl
 z0meBTQ1tt6R7Uy21dydQPd4HHtJzIaPnFGoKox/wHoT3MCsG0SxLwB9qoWpKYMF8VH515mgM07
 ppbovUEr3BP9nadNozBI3xh68LNlZg==
X-Proofpoint-GUID: c4PBe8tHf7O2_vr-IN1wjvcPxhqwlWFB
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68db3266 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=8MP5e_xu_S4MiSi9wGMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

Changes to bond_netlink and bond_options to process extended
format arp_ip_target option sent from user space via the ip
command.

The extended format adds a list of vlan tags to the ip target address.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c |   5 +-
 drivers/net/bonding/bond_options.c | 126 +++++++++++++++++++++++------
 2 files changed, 104 insertions(+), 27 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index cc00fbad9dd3..97fdbd962513 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -307,9 +307,10 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
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
index 91d57ba968d6..ba97479080ba 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -13,6 +13,7 @@
 #include <linux/ctype.h>
 #include <linux/inet.h>
 #include <linux/sched/signal.h>
+#include <linux/if_vlan.h>
 
 #include <net/bonding.h>
 #include <net/ndisc.h>
@@ -31,8 +32,10 @@ static int bond_option_use_carrier_set(struct bonding *bond,
 				       const struct bond_opt_value *newval);
 static int bond_option_arp_interval_set(struct bonding *bond,
 					const struct bond_opt_value *newval);
-static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target);
-static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target);
+static int bond_option_arp_ip_target_add(struct bonding *bond,
+					 struct bond_arp_target target);
+static int bond_option_arp_ip_target_rem(struct bonding *bond,
+					 struct bond_arp_target target);
 static int bond_option_arp_ip_targets_set(struct bonding *bond,
 					  const struct bond_opt_value *newval);
 static int bond_option_ns_ip6_targets_set(struct bonding *bond,
@@ -1150,7 +1153,7 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 }
 
 static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
-					    __be32 target,
+					    struct bond_arp_target target,
 					    unsigned long last_rx)
 {
 	struct bond_arp_target *targets = bond->params.arp_targets;
@@ -1160,24 +1163,26 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
 		bond_for_each_slave(bond, slave, iter)
 			slave->target_last_arp_rx[slot] = last_rx;
-		targets[slot].target_ip = target;
+		memcpy(&targets[slot], &target, sizeof(target));
 	}
 }
 
-static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
+static int _bond_option_arp_ip_target_add(struct bonding *bond,
+					  struct bond_arp_target target)
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
 
@@ -1187,43 +1192,46 @@ static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 		return -EINVAL;
 	}
 
-	netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target);
+	netdev_dbg(bond->dev, "Adding ARP target %s\n",
+		   bond_arp_target_to_string(&target, pbuf, sizeof(pbuf)));
 
 	_bond_options_arp_ip_target_set(bond, ind, target, jiffies);
 
 	return 0;
 }
 
-static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
+static int bond_option_arp_ip_target_add(struct bonding *bond,
+					 struct bond_arp_target target)
 {
 	return _bond_option_arp_ip_target_add(bond, target);
 }
 
-static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
+static int bond_option_arp_ip_target_rem(struct bonding *bond,
+					 struct bond_arp_target target)
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
@@ -1231,30 +1239,77 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
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
+	struct bond_arp_target empty_target = {};
 	int i;
 
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
+ * Returns: the length of the validated bytes in the array or -1 if no
+ * valid list is found.
+ */
+static int bond_validate_tags(struct bond_vlan_tag *tags, size_t len)
+{
+	size_t i, ntags = 0;
+
+	if (len == 0 || !tags)
+		return 0;
+
+	if (len % sizeof(struct bond_vlan_tag) != 0)
+		return -1;
+
+	for (i = 0; i <= len; i = i + sizeof(struct bond_vlan_tag)) {
+		if (ntags > BOND_MAX_VLAN_TAGS)
+			break;
+
+		if (tags->vlan_proto == BOND_VLAN_PROTO_NONE)
+			return i + sizeof(struct bond_vlan_tag);
+
+		if (!tags->vlan_id || tags->vlan_id >= VLAN_VID_MASK)
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
+		    !in4_pton(newval->string + 1, -1, (u8 *)&target.target_ip,
+			      -1, NULL)) {
 			netdev_err(bond->dev, "invalid ARP target specified\n");
 			return ret;
 		}
@@ -1265,8 +1320,29 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 		else
 			netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
 	} else {
-		target = newval->value;
+		/* Adding arp_ip_target from netlink. aka: ip command */
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
+		} else if (size == -1) {
+			netdev_err(bond->dev, "Invalid list of vlans provided with %pI4\n",
+				   &target.target_ip);
+			return -EINVAL;
+		}
+
 		ret = bond_option_arp_ip_target_add(bond, target);
+
+		if (ret)
+			kfree(target.tags);
 	}
 
 	return ret;
-- 
2.50.1


