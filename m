Return-Path: <netdev+bounces-228987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA4CBD6C9E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6417F19A2602
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA6C2FE04D;
	Mon, 13 Oct 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D8dQAXY4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC02D780A
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399648; cv=none; b=T2VSwuGhD2e6GJAFnaQhtEfBmH2Q6/RhxgljzYuEtfg/G8GohdbGAosmVl5HTLzej+PPAGrX4DMlTnbwnRH2VnjWLA39d9IiIvdtMTInZT8iwqJzYU+OTzIdxUDUJbjYtocAZC03Q3Z5NZDjwPGAQeNGJq7B8Bzg9zaWiKhCFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399648; c=relaxed/simple;
	bh=jd46XM8fcCLVWrdROC18zBvEsgDRHs+kpUioNEkrsWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbWwUjzYIMtJwN/j7hWytEMMTwtgkwuSjuezScQdsQRhbzfHzVD+zP7XNZtSiMYUjfVkfAy1RuXCCPSMU7o7ie5i3GYGIt2WySHaodgixsracOVaG0yPZCdjCt3lDWTqnS2JdXJ/q5VruZ0vv0/5uAtiLvGnhMUPKLRbLczQRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D8dQAXY4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DIr4Gc003456;
	Mon, 13 Oct 2025 23:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d21LjsY+f723UXRIX
	xZ+nYLrj+MnwAQg+UJF3MQtD04=; b=D8dQAXY4ghRcFtQfTY4LLqtO0Q8f20YoW
	XS6oqIAFpmVVj37/YTYfo3ieB2NZ5hBm782VDZIQ81I/BD+CSrBzDZOltw9Gpm7E
	8PB4TLk6x8QP8n5WSMJM46f3Is35NnYqcoIYH09tKuSyaZWKikl2m/dNc0SCGNzD
	YOyBoTtcU1YOdNhZlvwb7tGF5ZIZderqx1TCboIOcFv9hwTrGlK7owVG4VYCf9vY
	DQATNsAFtT4w6XK3f8QslfYCQNvVEpmiz5gpXd/CjAiFWMLlPjS7jLJQKcKsl7F1
	ikRE4uVtNcOZznsEdEa0YEQuZNdlsLikvi5ru5d3vmlfdVxEoR0/Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr3kdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DNrt3q025481;
	Mon, 13 Oct 2025 23:53:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr3kda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DMADQj016756;
	Mon, 13 Oct 2025 23:53:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jr7wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:53:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DNrq7Q28508872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 23:53:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8031458052;
	Mon, 13 Oct 2025 23:53:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422005805A;
	Mon, 13 Oct 2025 23:53:52 +0000 (GMT)
Received: from localhost (unknown [9.61.176.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 23:53:52 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com
Subject: [PATCH net-next v13 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Mon, 13 Oct 2025 16:52:50 -0700
Message-ID: <20251013235328.1289410-6-wilder@us.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ed9114 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=vY6KpHgGsgsBOyHPQ_YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: D0-QbAxHS8TNH463RN0QsBhIv7E21Zkm
X-Proofpoint-ORIG-GUID: 7skFTfbwwRLZ44PcxnLjACKwEj0gtAS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX7OjLq7CdUJJ9
 iLvZX3XVd5Z+Y1jEHlxCxSfzI1m1rOuKWshelqXTu7hb7ac5XhGopI/DQv4AJSynbtRwAX7RVo8
 TINLG5V37Kh7MqEsCwF/eUKprwMMkETC8zjSJ0UaCOKQr+filbP3xhTLxTvOOs7HTy/4GSbCC5h
 Atb747XrycBe6P4L7QtIb216XUyOCbddjs6Aiaj23T2jYPSEn0EmZ69DP9iCOa1baAs3ub8AQW9
 iT/rY6ZmlCMxszvDvEauZsVAG2bb9VPbCGp/PbtV0AEWwOv6m5gsnR7AYbIVAKL+gDunGEAb1RB
 Qwya35hXxaKEfZRv3PuuIbT6KbzRiWyClzQijXJi4WjfF/AN3NRE/eNrdHMQT4fLScz28j8d7jS
 +t/yQnd/nNRpZ6tmfRxZcW78f4QWAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140

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
index 3f35303b4920..5c2584ec544b 100644
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


