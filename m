Return-Path: <netdev+bounces-228990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5ABD6CAA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37FCE4F71E4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C452FF14D;
	Mon, 13 Oct 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hki6X5Ph"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D42FF177
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399651; cv=none; b=UvTTEdpmZp22ITURBBYwYHlbqt4r5M56MXfPHbZ1P+WpSaByXriwGZfgMF/FQkkQcGT72fDQwagm5AIjyI5WFkNYkSIeI4jZK73fsvueUfh1OQVLzS7Rz9ZPkaQz/E+IMem8DU51g8pQPH7yNf25lWUDfV7tYd5uTqcWpz+vOxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399651; c=relaxed/simple;
	bh=A9HBvb4ceLcJKiRWQtli9PWZx0A5hCZXGEagpBEhZZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoPwa1RcqwyFnIk167Tck+6ZsodCIYBSbokQ59d4Edvwar62qPBiH8Uw8zAmwAihVrT3NNFwgFnT2C+jPUSzhwrcSamfLt1nhJsxL6qiVmu6psrCDXv7Qau+GybT5wZlXSHUvazi152PMlhtHapvUnrhbMKKOpsmQsWWv6Ue60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hki6X5Ph; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DJbLsR004516;
	Mon, 13 Oct 2025 23:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=en+FaXCKGOF5cEZyB
	ugyI6pQ/iaETweShDrfQFcHfhw=; b=Hki6X5PhbYviJAjoiD1VLciXx7dW7uQJH
	7lv7t5xFcaBO+RzZxAXg1joZLiwvpiWcFiZnMcNCtcmfmxqPPkxNbFw2npeBzhzp
	t52jXIOzzRpfhmLvAPJCrm8p8RuOEdhbp6HtPbnyKsz+WFimRIN3S6qVhjbgOzi8
	/m9zzW60A7+2DlE9PZnmlx7uXKGZd9dWtoUGzMv1zvQekr8pS4GcGEOuu+S9U3rx
	7JIjTqDH5P1439E3dWCLfa435Bf9ijY1fVgopxT8B8gGNctDX5CDIvd7kG7uKD+f
	3AhS18IBGtowqc+Z/ho3NfQ3A2Cicx8Myt1hOoKAMJn+aZzrtEzJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7peaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DNrkqQ012252;
	Mon, 13 Oct 2025 23:53:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7pead-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DMu8pE018353;
	Mon, 13 Oct 2025 23:53:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf1x1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DNrpKK30474730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 23:53:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70BE58050;
	Mon, 13 Oct 2025 23:53:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42DF758056;
	Mon, 13 Oct 2025 23:53:51 +0000 (GMT)
Received: from localhost (unknown [9.61.176.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 23:53:51 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com
Subject: [PATCH net-next v13 4/7] bonding: Processing extended arp_ip_target from user space.
Date: Mon, 13 Oct 2025 16:52:49 -0700
Message-ID: <20251013235328.1289410-5-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013235328.1289410-1-wilder@us.ibm.com>
References: <20251013235328.1289410-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iF33gmhzAiwmujRrprroXAMqQ5O7kIWE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX/NAWN/XH8LZc
 Ex0Yg7Q52A9QL7BqeU9eFXaBjAqw0xG4J6Y8DUHi15DA6OASA2Uq2/jIWN1UItllk/XofP2x3lw
 LEklOWTITw3hOTE9hDldxgdi/fdqpnig/RQfyFYPYgwCLhyhmToDtAx00IHgoKoYKPd2CB+TLhu
 ijmEcdC65FmDIFJfXfwyjqhFKXfoH3mQjf9bhsL1qMpIPGqnqGgNwHujSeiTo7Oo34ewqs5Qfzv
 yJIDnHkA1iB76sfoep7KhtKxW/nWwER0HQUNTp6GnIZ2e/TikUR0FVYE0XbIC8CT906B+swmtAs
 VU9gpWc3nVOx6AfCP/G94Df/5udMdrLnaSgDp1dz7RKLsiQ6DBSebNsjtv+qYVhmxD4WY9sSonX
 C0QCgKUK+NTgftyP+4W/QkQIcKySMQ==
X-Proofpoint-GUID: iYvnB8z0mOR5uFqRRipiJ9x_ZbkRgsp6
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68ed9113 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Yn90BycCmSjmNZNuBK8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

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
index 566a11bb7f1e..15782745fa4d 100644
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
index 91d57ba968d6..fb31d0b800b0 100644
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
+	struct bond_arp_target target = {};
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


