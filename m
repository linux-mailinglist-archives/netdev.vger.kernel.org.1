Return-Path: <netdev+bounces-227406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F2BAECA0
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3404E19432EB
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EFF287272;
	Tue, 30 Sep 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C601xvY6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E92D3731
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275549; cv=none; b=I33JYD4Las/MvPwFeXGX1BaknZclWP/h4gaBbppQibYQCabqg33hpxzmltYqPILSA+jbacOeMr2IURm4HKHVYL2AOghoJKTEeDLtu9amYt7jfbsBc/6kos8HgIh35x4GLOjS4pryUcvU0doIu1Xkf5M9W08w7LTje/LVDlRLHmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275549; c=relaxed/simple;
	bh=/zvY6AZuWlM3j5y6SYMDhhtW7fQAk7FYYzhDpxoPeGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJsAXQxkBpch+fo519Wq8QEsnHZbhteWolstIbSbvBbKL7cGe6ImYKONaYyxtujz/aucbgJWNzRkssw/2jsgXNgNPN7tgJ69uyZS5gIxGyWUh7F0ey5C/aUCUjMOajMB/5JqEK0yN5P2KGJjK1PcSnt+ySrPWW1FDE6BNV5j8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C601xvY6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UHStLQ030156
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7ZaBZQtDbN+NcIEMi
	bBPqboiskWvizJUJt8wsJCtdlI=; b=C601xvY6lhlQHSBDnxkU2tvtLCy5G2laD
	VKOzB/1Yd2/1km8v5OGVD+PGOlhe2Oy9LmCAfzpVEqx7HyUYLywyV8NKjIziUgbF
	Y/USHwIRJ+4i6lUIPhmIV3ajUy7SSV4NpQtxNW+utPX1BlnAbEQSdYUPbzDeniUl
	yzyH05fo7XE5V0ZtfCIT9Sha3ivQdNkC+Cz6myn3Ha512ifRmdr+Njfyx4Hz5VUY
	Ms9i2n0Z9R1bBGfgISYiV5ZcgctZuzYJL/IqzGhcVj3/KrfqIGDTdNfaJ7rL/3WN
	ckDCLweqWMb5g1MmyNPCYCM8ZODXbj6rLzrA0t89N2Hc4x+K8YzOQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e7c78u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJhLmo007285
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurjx1ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:04 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UNd2rx29885064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 23:39:03 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE73258052;
	Tue, 30 Sep 2025 23:39:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F5B65805A;
	Tue, 30 Sep 2025 23:39:02 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 23:39:02 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: wilder@us.ibm.com
Subject: [PATCH net-next v12 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Tue, 30 Sep 2025 16:38:05 -0700
Message-ID: <20250930233849.2871027-6-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250930233849.2871027-1-wilder@us.ibm.com>
References: <20250930233849.2871027-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vldpGQolNV4mlwGhWfc6bInFFpYu4t-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX7IpOnHI90BiE
 dvbxN82cKoAFfNBq2itQ4vTNwdlYKxqFIDOYydQRtbLESgT4mv8HUYHgJayM35oIs3mXXsEpfZo
 h+k35jV5+47Y3TaaXFrqBgOrfQNhhLHhKkDYcCiabTQUEcMn+2zT7gAeyrgXykyxnnEks3/75c9
 FAW7muiKHORHl4WUeQyTcM1tVSmcskOuDDrh3OlT6eI8Kw5DtVHJjRgjwH5NfZQtTvHQkikqAWc
 lxIL0cqdnzbI3GMLrI4p3Ng2U+xsSJDk7N6TaRcatyn46RIbs/+3askeHV/Sl3atBSFbfAfBnAa
 jmqfcBTTcNSLgTqi3LlqS+fJia2yraJeLizVRCEhcKq4r4WfCRH2a1QSYDxeGaezhmph9zNeALO
 IUN+WUpIuSS+eWjdpSYcwtFjZjzX7A==
X-Proofpoint-GUID: vldpGQolNV4mlwGhWfc6bInFFpYu4t-c
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68dc6a1a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=vY6KpHgGsgsBOyHPQ_YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

bond_arp_send_all() will pass the vlan tags supplied by
the user to bond_arp_send(). If vlan tags have not been
supplied the vlans in the path to the target will be
discovered by bond_verify_device_path().

bond_uninit() is also updated to free vlan tags when a
bond is destroyed.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 57cf4585816d..8ef8b062d6f3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3064,18 +3064,21 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 
 static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
-	struct rtable *rt;
-	struct bond_vlan_tag *tags;
 	struct bond_arp_target *targets = bond->params.arp_targets;
+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
+	struct bond_vlan_tag *tags;
 	__be32 target_ip, addr;
+	struct rtable *rt;
+	u32 flags;
 	int i;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
 		target_ip = targets[i].target_ip;
 		tags = targets[i].tags;
+		flags = targets[i].flags;
 
-		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
-			  __func__, &target_ip);
+		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__,
+			  bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf)));
 
 		/* Find out through which dev should the packet go */
 		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
@@ -3097,9 +3100,11 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		if (rt->dst.dev == bond->dev)
 			goto found;
 
-		rcu_read_lock();
-		tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
-		rcu_read_unlock();
+		if (!tags) {
+			rcu_read_lock();
+			tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
+			rcu_read_unlock();
+		}
 
 		if (!IS_ERR_OR_NULL(tags))
 			goto found;
@@ -3115,7 +3120,8 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
 		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
-		kfree(tags);
+		if  (!(flags & BOND_TARGET_USERTAGS))
+			kfree(tags);
 	}
 }
 
@@ -6047,6 +6053,7 @@ static void bond_uninit(struct net_device *bond_dev)
 	bond_for_each_slave(bond, slave, iter)
 		__bond_release_one(bond_dev, slave->dev, true, true);
 	netdev_info(bond_dev, "Released all slaves\n");
+	// bond_free_vlan_tags(bond->params.arp_targets);
 
 #ifdef CONFIG_XFRM_OFFLOAD
 	mutex_destroy(&bond->ipsec_lock);
-- 
2.50.1


