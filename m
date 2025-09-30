Return-Path: <netdev+bounces-227257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47677BAAE3F
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A0F421949
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213531FF1C8;
	Tue, 30 Sep 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fBiL1G/T"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856011EDA0F
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195775; cv=none; b=sy1x6gtsAXZbk3rhU7Ez1jqrPFkAtp2qnbQPOFt6WrHEq+3240Yrkob0MMw5z/Q7mc/d4+561G9b10OWPUDaCaXR1YTM4bYKBH3JBllyxqqsFiROJcBMuFSROpbrYKAvy2qzW+mw7vtMzsFq2ZNlvHE4heO0bkUdVr2B2i+uNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195775; c=relaxed/simple;
	bh=ulqa1brJD0FIk4KaztsJi4T0e3ALmFrcR/KJz4QXUdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItXmUk4Bdzyc3Y9/DmHif68qrzEfhFDaoZjtdI0gaGjfnC1oqSTUOyY4elCEGErcZsSc02U7ajhd8ATWjpWbtTmUkFAEFmSpLwP7FFsHmJcvSoEvN5rTSCIqpQ39fX/TwQr1ffKChIsFvsBHnhN0EO3Ha/dx1moCYSDLmV+NIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fBiL1G/T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TKA93t024040;
	Tue, 30 Sep 2025 01:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ge8/xZ/RBQ/ZuwIhw
	DsjpfexJE7SlrTgwp1whrEkZ90=; b=fBiL1G/Tz5dYtFw/63PDzLAsML+4WxBH3
	XGGqkOqmu7RilWwPj8Bam+3DPT0of9UfX9P3GTk2EdQcQLZPn0NxO34502b09BVT
	Qsa10Un8bJ80EbbptPcgzMCDHcT0Ace+h0jl5BsJK7/Yxd5dL5b7aL8kXQ/2rdBe
	9fFVP4YL/WQ3e8OB35Jdrgx6jTuBsy8kQaAmF3Rxu1tGyOBgT2xdJEHEsOpVKs/S
	9od+OG3RZs3Z5tOE/DX61CWnQrkCa5tz1O/Uk44ClPuFzcTgSv6zp2YAssC6bjjw
	lg6uOZbcaDYGTwl2qCy3/64l7yU4u6DarMdI/IZ5VZHYRDzHlXsjg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7npew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58U1T88j002081;
	Tue, 30 Sep 2025 01:29:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7npev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58U11upF007328;
	Tue, 30 Sep 2025 01:29:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurjrwhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58U1T78r5505756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 01:29:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88B345805D;
	Tue, 30 Sep 2025 01:29:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F7FA58043;
	Tue, 30 Sep 2025 01:29:07 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 01:29:07 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
        edumazet@google.com
Subject: [PATCH net-next v11 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Mon, 29 Sep 2025 18:27:11 -0700
Message-ID: <20250930012857.2270721-6-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: rwBddmWXwpy7lCfdSJiOdYeJiOV2U1Ha
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX+bN5/oDj4HmV
 YprR8/GjY0+nqKqIGR+uyaaGOFu/0nLFNSdpJoVvIS98eV/pmFudXXw774221ZjegULm7T9h3Se
 scpT6H0rLVmoqhjhIMJUH+OUScnjPc1ufOHZFKLP6jQqQE4YMN9vdCE+BYFwjsZt1sS+aF79n7J
 qnDoZ0wqYbs+uJRmeXkQmZtGAjMoRdUn3sh+5LiLLHOAUX6uc3nQA+/4pCELjsLn8+mPUdWgPl5
 8+r3pQdq5JSds8q1Uu30byBPDZqiitkR+whqw++MuXPXZeQgoWshvjuA/4LJezEhPVrNIyy5rbh
 HvP42PLQhOxA9TM/mcNCdWH/MCxG6x1XYehEbUoRTcMca0yjyxy7ugJwHUn9bf4jwpZFma8pU+t
 57VJsOTrT37nqKHiDTNOzGgaInD8tg==
X-Proofpoint-GUID: TLzOUW3YTlqLYFmF9juwzB8--TVUcv8f
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68db3267 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=vY6KpHgGsgsBOyHPQ_YA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

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
index 57cf4585816d..333f7fef9c8b 100644
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
+	bond_free_vlan_tags(bond->params.arp_targets);
 
 #ifdef CONFIG_XFRM_OFFLOAD
 	mutex_destroy(&bond->ipsec_lock);
-- 
2.50.1


