Return-Path: <netdev+bounces-206895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCAB04B16
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169054A75C3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66911279917;
	Mon, 14 Jul 2025 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KUIaSogj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C0279354
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533759; cv=none; b=dNwrUssuaOPONrymIXnNPt7yYmmg3FeNqi5adq6IJ0kotiYz198IBhuY6K+GjFZs8yf2HTV32P9jWG1pDGP1EVawWNXa+VwcjsGA06ptOUXr0Pk3h3/Cr7z6yKqAiCMde7HiCBAt2YNEGv2rDNUuyBoOkr6wt9WB9pj0F+cCV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533759; c=relaxed/simple;
	bh=6gt3Qi9dSk1drQ8qZcjORU3yeW++yAyeRkwIaAqyA58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv/D/aOVo/s61JTTdg1skO4XFeCR3nogKgNxw7s75j1FXcd+dXwiGCu91BJuibSMnz2jtrTGSQ+3ACE80Z8xATCYZgyZUaLLSWJ5qq5OJUjQ74toN58rmW1S7a/oFrCMUu2cz1Fd/8vDm7TMbTdXcoawtdYS9pSPM83c9RSguZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KUIaSogj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELbHGG004602;
	Mon, 14 Jul 2025 22:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p7Vw2dsgSBCznGwMd
	2AXNFIZilbjuCPE4PZNnozzTq0=; b=KUIaSogj+LEyAb9aK6OLSGrX0NaIOugvJ
	pcrYnnNWgXrvOFxC86nLMsRJV5ZwVnvFOFIAArt4zAFF5nOjz+0BFi39BhqAIwvT
	Zl+vuev+mT2qWNrhf2+DsEhWW6xyfFYIvbMz/0zZmuNaEdl3vLvZHM49d4/dl6ox
	gfhhazHXC2HvzhuwgMqGirtMEIsJRRo/+lTOlJEAwAQIQRxhCaoHWtpRCWX3lZtN
	IAbtgSHTMyWXgVZTgrIIWszXqLZ+C1CgaBxHw7hGVIVVYfXP99CVIMy+7OPX6S8t
	1RCjnua/HF5ja5mKVtkjUacCMmYOtD6NEwPYWy8jD4HizdOCoe7iw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6uvcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIQB4C008914;
	Mon, 14 Jul 2025 22:55:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmfspd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:50 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EMtl2t1507932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 22:55:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF5658050;
	Mon, 14 Jul 2025 22:55:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5103C58045;
	Mon, 14 Jul 2025 22:55:47 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 22:55:47 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v5 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Mon, 14 Jul 2025 15:54:50 -0700
Message-ID: <20250714225533.1490032-6-wilder@us.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=68758af7 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=ZKn5ET9WYz78Zcf0JJ0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfX/rgREGQgNBEb zC4oXmf6S75g4n0E+jFJMXpa+v3q7XZx1/TFnP2bnW2gzHEqp+4B2eWzYgf8deJrzPcN8Cjfa/v E4KQNN8cEqlxL1si52uqkyAzbTaFNWT48xsWl+M0n1kjrVxE/HryUJGCO8VbKuKkQ5yOXw5PkYZ
 wic7iQ9OceDTbT4yQMrQMHkxeJPsWXqaIhWkb/1riuaoULaD1x19YmCkPTBo13mNvqLDNOv72sK zv6chBJzmdnPMR9uS9g3K9+5fpT/7IUcpC9Kz3I74IayJ3ORPPLOIpbxIQDVgN+fWdcIheoR6m0 MQcboWKThRkxj9EgIAdYFbR2Y/aIj+9H4Yd3uOgJdbXqXcVGEUecxRDdT3ayuEiwughXy9NZ64X
 7GpPZ5bZ9Kec3YytubgHEPDmRO9ziWsIFECBgK0vUjOBQZHGghAsLDRKMmH0wSNQfCETv2MH
X-Proofpoint-GUID: ZUNERs3vYCb5YLZeFXh9rSBMLvqijjn2
X-Proofpoint-ORIG-GUID: ZUNERs3vYCb5YLZeFXh9rSBMLvqijjn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140159

bond_arp_send_all() will pass the vlan tags supplied by
the user to bond_arp_send(). If vlan tags have not been
supplied the vlans in the path to the target will be
discovered by bond_verify_device_path(). The discovered
vlan tags are then saved to be used on future calls to
bond_arp_send().

bonding_exit() is also updated to free vlan tags when a
bond is destroyed.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7e938077bbde..2f153c89e401 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3161,18 +3161,19 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 
 static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
-	struct rtable *rt;
-	struct bond_vlan_tag *tags;
 	struct bond_arp_target *targets = bond->params.arp_targets;
+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
+	struct bond_vlan_tag *tags;
 	__be32 target_ip, addr;
+	struct rtable *rt;
 	int i;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
 		target_ip = targets[i].target_ip;
 		tags = targets[i].tags;
 
-		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
-			  __func__, &target_ip);
+		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__,
+			  bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf)));
 
 		/* Find out through which dev should the packet go */
 		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
@@ -3194,9 +3195,13 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
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
@@ -3212,7 +3217,6 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
 		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
-		kfree(tags);
 	}
 }
 
@@ -6732,7 +6736,7 @@ static void __exit bonding_exit(void)
 
 	bond_netlink_fini();
 	unregister_pernet_subsys(&bond_net_ops);
-
+	bond_free_vlan_tags(bonding_defaults.arp_targets);
 	bond_destroy_debugfs();
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.43.5


