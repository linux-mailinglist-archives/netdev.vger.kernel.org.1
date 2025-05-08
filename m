Return-Path: <netdev+bounces-189060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C049AB02BF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED143BADCF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A21286439;
	Thu,  8 May 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ofbd9lmh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C06202980
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729055; cv=none; b=m5skmWCdGgmMXNTHgLon2oD+TX+DxXi9YHeDE957k4XLHv0IsKsr5jxAKuR/rOn8c0rxpntb1xPNBlLeroqhJLHezsF0rwKGz5FP0iY+kYQl/5PuuXXwtXUnnlWtsldFg5mzNnYSebVYtEtr8DqpPTkBr2g7XkDH5vVl1lW5eXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729055; c=relaxed/simple;
	bh=USRU6Z77jcVR0Ijz9CyIyNWTa4YMKQI41NVIwUguADs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgsJt97oxXv5pUBViHVh9b3JqAugCcW36hXbxU1yjzY6BcYvHG2VbLnb+ON2HVzcGNeK4DPBz3wl6HiXHYSCrG20YH4C9rFqfIPMn4E1ZKoZ58n6S6C8FzFWnlpoqh4oKWUDLyG/UVWwZDBSi9Jdh00t5OXYWr3fhxX0lmsyxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ofbd9lmh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Af5e9012235;
	Thu, 8 May 2025 18:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fx5Z/f39uRJwWbUw2
	i9LjMR5AdZbwaNXyJOKJ99St7o=; b=Ofbd9lmhVDVAL+PloPj0Q8cx6L9DsWR3l
	mwhiknI3avV4KG3yjkNw24RIa4KOzNyjpIr8PrGRZehjOai1QCXCo/BsxWjbHj9v
	TyxDRaOIzLfmtGsQdnD2DNN1l+7cuAxZtZl+f7bhYoGs6Fe0BH9IJuIv2A+irncW
	lG4Lz+s91emJ7zdnW1gheBKknz9FygjCMUpHTfpbG/THenfKOPQ3QHSe+A7t/5TG
	Q9/Ud/NLUsdnLVAs6To8+WKqY5QNZVvKpZzOu3mNzOvjh+rRns/U3ZzTzO3gcx4I
	qDT+t82P8lKUDJBjBvpEPqWuZpOGBZW85rB6ZmUqFIxXJQEZg1nkg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t291e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 18:30:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548HQ9jH004253;
	Thu, 8 May 2025 18:30:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2bryj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 18:30:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548IUhNX56492296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 18:30:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC3858056;
	Thu,  8 May 2025 18:30:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 736F558052;
	Thu,  8 May 2025 18:30:43 +0000 (GMT)
Received: from localhost (unknown [9.61.84.219])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 18:30:43 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v1 2/2] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Thu,  8 May 2025 11:29:29 -0700
Message-ID: <20250508183014.2554525-3-wilder@us.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681cf856 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=_9dExB9TU08cRdUV:21 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=jxJuSLKSS-QuM16cv4sA:9
X-Proofpoint-ORIG-GUID: Gdyu5k5zZPsGA-SWvKur-8h7ROzpGeam
X-Proofpoint-GUID: Gdyu5k5zZPsGA-SWvKur-8h7ROzpGeam
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE2MSBTYWx0ZWRfX+4ZtczsFEntZ Timcjm6h1a5lRwvC14fMTjwol0VqzkLY4Q0B3Ys1yq2/jPibWhVt5EYtiEgDFHW9R2PbX1suI6V J0uHdBNoI7o8Y3EAihJwsIUjdwqjU1soiqwTYWci/FfISGqdZpIinSGYc1jQWJCHRG/vSKw0jqT
 vPrZh2HpjasYFE2JVI0LVaLOrasvqvi/Lf1+af5UEsO/zdgPJykG0OkAat+cBX5fve/B7Zf+gPN 7B0w6cAxq+2FXFc6EqMHU4TaEGRcWhw0Vrajr+g8hYeAfadoI799kfmz//b7P4+bgssU1wkaxro MAsod3PhWVS1x9o+xeUXDaN16kjc0ChWFlznVcTQeqYQ1NhMKP5lvFhmpjD4rTUXrw3M7jP667q
 m0dx4a6hF6d/3pMBNtm4YCBnWnM1HQDH0+aM07Hp5CqILRdWbcOYYXmsAoi16kYuxaeYOncw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080161

This change extends the "arp_ip_target" parameter format to allow for a
list of vlan tags to be included for each arp target. This new list of
tags is optional and may be omitted to preserve the current format and
process of gathering tags.  When provided the list of tags circumvents
the process of gathering tags by using the supplied list. An empty list
can be provided to simply skip the process of gathering tags.

Signed-off-by: David J Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c | 140 ++++++++++++++++++++++++++++----
 1 file changed, 123 insertions(+), 17 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ab388dab218a..12195e60c7de 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2672,6 +2672,17 @@ static int __bond_release_one(struct net_device *bond_dev,
 	return 0;
 }
 
+/* helper to free arp_target.tags */
+static void free_tags(struct net_device *bond_dev)
+{
+	struct bonding *bond = netdev_priv(bond_dev);
+	struct arp_target *targets = bond->params.arp_targets;
+	int i;
+
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].tags; i++)
+		kfree(targets[i].tags);
+}
+
 /* A wrapper used because of ndo_del_link */
 int bond_release(struct net_device *bond_dev, struct net_device *slave_dev)
 {
@@ -3159,9 +3170,6 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		target_ip = targets[i].target_ip;
 		tags = targets[i].tags;
 
-		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
-			  __func__, &target_ip);
-
 		/* Find out through which dev should the packet go */
 		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
 				     RT_SCOPE_LINK);
@@ -3182,9 +3190,13 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
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
@@ -3200,7 +3212,6 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
 		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
-		kfree(tags);
 	}
 }
 
@@ -6082,6 +6093,7 @@ static void bond_uninit(struct net_device *bond_dev)
 	/* Release the bonded slaves */
 	bond_for_each_slave(bond, slave, iter)
 		__bond_release_one(bond_dev, slave->dev, true, true);
+	free_tags(bond_dev);
 	netdev_info(bond_dev, "Released all slaves\n");
 
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -6095,6 +6107,96 @@ static void bond_uninit(struct net_device *bond_dev)
 	bond_debug_unregister(bond);
 }
 
+/* Convert vlan_list into struct bond_vlan_tag.
+ * Inspired by bond_verify_device_path();
+ */
+static struct bond_vlan_tag *vlan_tags_parse(char *vlan_list, int level)
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
+		tags = vlan_tags_parse(vlan_list, level + 1);
+		if (IS_ERR_OR_NULL(tags)) {
+			if (IS_ERR(tags))
+				return tags;
+			continue;
+		}
+
+		tags[level].vlan_proto = __cpu_to_be16(ETH_P_8021Q);
+		if (kstrtou16(vlan, 0, &tags[level].vlan_id))
+			return ERR_PTR(-EINVAL);
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
+ * arp_ip_target_opt_parse - parse a single arp_ip_target option value string
+ * @src: the option value to be parsed
+ * @dest: struct arp_target to place the results.
+ *
+ * This function parses a single arp_ip_target string in the form:
+ * x.x.x.x[tag/....] into a struct arp_target.
+ * Returns 0 on success.
+ */
+static int arp_ip_target_opt_parse(char *src, struct arp_target *dest)
+{
+	char *ipv4, *vlan_list;
+	char target[128], *args;
+	struct bond_vlan_tag *tags = NULL;
+	__be32 ip;
+
+	/* Prevent buffer overflow */
+	if (strlen(src) > 128)
+		return -E2BIG;
+
+	pr_debug("Parsing arp_ip_target (%s)\n", src);
+
+	/* copy arp_ip_target[i] to local array, strsep works
+	 * destructively...
+	 */
+	args = strcpy(target, src);
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
+		tags = vlan_tags_parse(vlan_list, 0);
+		if (IS_ERR(tags))
+			return PTR_ERR(tags);
+	}
+
+	dest->target_ip = ip;
+	dest->tags = tags;
+	return 0;
+}
+
 /*------------------------- Module initialization ---------------------------*/
 
 static int __init bond_check_params(struct bond_params *params)
@@ -6289,21 +6391,25 @@ static int __init bond_check_params(struct bond_params *params)
 
 	for (arp_ip_count = 0, i = 0;
 	     (arp_ip_count < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
-		__be32 ip;
+		struct arp_target tmp_arp_target;
 
-		/* not a complete check, but good enough to catch mistakes */
-		if (!in4_pton(arp_ip_target[i], -1, (u8 *)&ip, -1, NULL) ||
-		    !bond_is_ip_target_ok(ip)) {
+		if (arp_ip_target_opt_parse(arp_ip_target[i], &tmp_arp_target)) {
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
+		++arp_ip_count;
 	}
 
 	if (arp_interval && !arp_ip_count) {
-- 
2.43.5


