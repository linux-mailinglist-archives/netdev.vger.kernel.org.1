Return-Path: <netdev+bounces-212653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1FB2191B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C54917E2FE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF5625DB1D;
	Mon, 11 Aug 2025 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R1sDR0NL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FAD23C8CD
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954378; cv=none; b=be+TRqPryP6OSOeE/tEPyG95+ZoSyYeT0SNW33ygFOKp+eneVtRHTko9RL3/2t8p88JewjuPdvkNAFSNLRWkQo1NOh+cOoNCT2bzFC40dppJfRFRk2k2B4AAlJBaQpaGwNwfisMP0/S1Sj8KgW3BW9CMNgq2ONtdhkb2yA+9xlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954378; c=relaxed/simple;
	bh=x6tX6nu91SYmevBuzLc9GegifWHbFz1pKTFs2oYCmA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDt3uZ9rVxSMNxCePMzH85zdlDgHIvwoGKt+H8/Q+WuxO0w5cYaBlbWUlLNTeLtqbDiMXQmZytcOcHeXDgRGH+4YIMkb+wMwEJhULmU7RiS7ziwHBwpeA2XWBzTQUaY7fY9kfsKWLMooYQFV7DczFXyJWq7hedHswKmFbGSma3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R1sDR0NL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BKYHaD025932;
	Mon, 11 Aug 2025 23:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+QtwAtGi+lUeG9MX/
	6kY5OE1Y/lXcKLRMncePf4XB3M=; b=R1sDR0NLBish21fraegzRkTyeoil3QL+E
	gSMBHAtG/FwKMdq0IE5O5jWv6VDSpqTiF36N8vvru8HuctV+Kv6h55620ImjBRrr
	FjvPV7oOezCqy8FBnVSwn4IsI2W85SmxGo1d4aSlgXqOd35lf3RL0tz4npcQUg9N
	c1BoLGOcvht9/+XDMAXhbWgkpvke3I6bxTX2xJXwta4Y8exNdPnzBwUU7XJUHgco
	J2hm/aPTAVEy2nyXVgNJk7/qniD3o0z6eBd6i9U8l03Ews/OFe3OVfYIVBqEThmM
	m2vaUNFwEVXYjV7Yl42KY7Zxskv7/mk12wulQ1RZB+t4cckPjumKQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14bn2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BKZeWQ017588;
	Mon, 11 Aug 2025 23:19:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3fknv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:21 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BNJKSA32309970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 23:19:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DA4858045;
	Mon, 11 Aug 2025 23:19:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B649958052;
	Mon, 11 Aug 2025 23:19:19 +0000 (GMT)
Received: from localhost (unknown [9.61.174.150])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 23:19:19 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v7 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Mon, 11 Aug 2025 16:18:04 -0700
Message-ID: <20250811231909.1827080-6-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: LVxU8kIdr1m4l8vMY2PVkg8gxEz_Q4yX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE2NSBTYWx0ZWRfX88QXYsRP1gAj
 LhFEqj9kxrCdNz5HBO0qG2+g7eYid/Tmfi6llOy440wbMLy4HsZfxZ3zkTl6IRnYetzKVE5Kvnq
 CXOfn8sGi0CMZ4Wzz0/28x3EfAJp0uRE2wChRgNHHaWhsbim0m2+7ARyqIwfQb+wuvb0TP0ZPjG
 WnqhWjr3uWXQizFE/JG9OcehioPi32UJ6jRgxPuQNkE0AbolsuDVOAX0XeE4iZxsRI98G5eBaxG
 3SNVT6Rz28xZ6jKTKciSiMDHvaaSNtNBH8NrNKUEVrni8jvtg606ZFju7TgYA2ID2q0Y5npUkzV
 cGQfBF3VSNb4new34JHkPLrylMCg0Amm+E3Sn0tZ8jpU7LzlflwagqyJoOfH72Vu98NHpExeMSl
 fGCjzzv12x+0VrEGzYUETRInI6kmBQRmZeiEtusMP53FI3MPOd7evliE5WrfqnziKCqDcpeN
X-Proofpoint-GUID: LVxU8kIdr1m4l8vMY2PVkg8gxEz_Q4yX
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689a7a7a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=ZKn5ET9WYz78Zcf0JJ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110165

bond_arp_send_all() will pass the vlan tags supplied by
the user to bond_arp_send(). If vlan tags have not been
supplied the vlans in the path to the target will be
discovered by bond_verify_device_path(). The discovered
vlan tags are then saved to be used on future calls to
bond_arp_send().

bond_uninit() is also updated to free vlan tags when a
bond is destroyed.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a095ca4e14a7..0096535b521b 100644
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
 
@@ -6145,6 +6149,7 @@ static void bond_uninit(struct net_device *bond_dev)
 	bond_for_each_slave(bond, slave, iter)
 		__bond_release_one(bond_dev, slave->dev, true, true);
 	netdev_info(bond_dev, "Released all slaves\n");
+	bond_free_vlan_tags(bond->params.arp_targets);
 
 #ifdef CONFIG_XFRM_OFFLOAD
 	mutex_destroy(&bond->ipsec_lock);
@@ -6732,7 +6737,6 @@ static void __exit bonding_exit(void)
 
 	bond_netlink_fini();
 	unregister_pernet_subsys(&bond_net_ops);
-
 	bond_destroy_debugfs();
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.50.1


