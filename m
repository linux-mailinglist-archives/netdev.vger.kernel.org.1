Return-Path: <netdev+bounces-220173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7702B4496E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0EA1899705
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4622E9EB9;
	Thu,  4 Sep 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QEpuKS5Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEF2E8E00
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024416; cv=none; b=rPh/AYZd2kkNukdHiuv14PTmUuvSsdB8hcVJ8EKQh4FhwwniyM0Zhi7zXNO4X4yEjKEge5DJfm4V6B4UJLo0C41XXvYXuX/zyWei4Zf47SYKfBMixyX3GQVarFA7o9tut2x8NqPxS1wkrtAnqiIkhsSb5YJ4OGwYhQHXGeTl7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024416; c=relaxed/simple;
	bh=h9Tp96V2m+jDdf0BMXdL59jsza5VkcjQbLFOf5wWQic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAhVKVh5JjjWjn+LQDqU85DoK8JNHaG1zDLPZWmxioJxKQ6HhyVYXoVOeoLtgYjQK7g1W5oCoAbU5Cn2UWgpJVWfie20WlIz1YHBhrujsgq179hQ0FFZRPFBvslpcXJiPXH838TVMnjVPr2vLtaO42iKI+VpKirTm2YtWkVEBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QEpuKS5Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584DZcnb005329;
	Thu, 4 Sep 2025 22:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1jn0RXlf82CnENqB/
	D5u221a6E2Fb2IGybu5+NtxIW8=; b=QEpuKS5QxSQRWlSEbMTFr0bEB6+zfKeTc
	BJAImmnuEvx5zhee4v4AbMd6N2pu1V+CDzDXsBRNkVYdT8tzrFTRL4LgbA3bIq+1
	Gq7ngxNy/rJU3V8cKdYcnkmSJNFE/m4scBfYMgQbj8IjDu1rY5WH/UKNwuoVt3Ni
	QrmMHVDDjK0Fb9LYD11K3rw8W4BcEW8Uo6qOUcxQjeGJsIR7pkqKFTWqh7t31Ie/
	MOqjzCW5xrF/khW9+4m0xDzXooTVoTYJRb/ptkcW4EiNlUBdUg0TZQ+AueHmZ0UY
	2orFOFQKKLYfyu1QIe9KgbIJC63MQc6LFNxgpgHWndIoBOfHcuedw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg4ets-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584Kksmh009059;
	Thu, 4 Sep 2025 22:20:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumpg5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584MK3BR30736944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 22:20:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F7365804E;
	Thu,  4 Sep 2025 22:20:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5391A5803F;
	Thu,  4 Sep 2025 22:20:03 +0000 (GMT)
Received: from localhost (unknown [9.61.141.209])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 22:20:03 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v10 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Thu,  4 Sep 2025 15:18:23 -0700
Message-ID: <20250904221956.779098-6-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904221956.779098-1-wilder@us.ibm.com>
References: <20250904221956.779098-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68ba1097 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=ZKn5ET9WYz78Zcf0JJ0A:9
X-Proofpoint-ORIG-GUID: 64aKZt19XMyfDCaS9ZI2i_Vmm8auiuCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfXzJXQQJvBN/cY
 Q8dJd8oNejTMT/UuaiFWw9wcL7/4P+n9f0AL2HldDmjD6aTqamDARmw6k7THZ3KbqHNEvuw1GiX
 rAfnM4NwnoxaORwdhzxHBVQpOK/46nxnjpLyYDMpDXy1fRjPrO8UR18wZidMe6y3Xr5lehoXaK7
 FBxClsKrYfQgzAxvm5XKK4RCq3SowD5MFTuiUFx1qow/9Lk/95j3Bo8cnMODxSVJKdjxW/nIKPi
 GXHYdfCUoQJ4VF2t5cAPBysrV1ux48ehMJMbiNu/bH5veRYmxSmuoz45oLO9qQ0nckht07CcVBX
 usKEP4uWNR3YDPz+XlohV2RDvi/waweQgb3fr40eUDDaJcEDRRUwvMSgXAjRN1i93OJ8QScJFhr
 Y8Y1DfnW
X-Proofpoint-GUID: 64aKZt19XMyfDCaS9ZI2i_Vmm8auiuCt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

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
index 7548119ca0f3..7288f8a5f1a5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3063,18 +3063,19 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 
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
@@ -3096,9 +3097,13 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
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
@@ -3114,7 +3119,6 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
 		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
-		kfree(tags);
 	}
 }
 
@@ -6047,6 +6051,7 @@ static void bond_uninit(struct net_device *bond_dev)
 	bond_for_each_slave(bond, slave, iter)
 		__bond_release_one(bond_dev, slave->dev, true, true);
 	netdev_info(bond_dev, "Released all slaves\n");
+	bond_free_vlan_tags(bond->params.arp_targets);
 
 #ifdef CONFIG_XFRM_OFFLOAD
 	mutex_destroy(&bond->ipsec_lock);
@@ -6633,7 +6638,6 @@ static void __exit bonding_exit(void)
 
 	bond_netlink_fini();
 	unregister_pernet_subsys(&bond_net_ops);
-
 	bond_destroy_debugfs();
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.50.1


