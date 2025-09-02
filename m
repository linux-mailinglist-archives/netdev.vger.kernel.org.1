Return-Path: <netdev+bounces-219295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49286B40EAD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D581B23749
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506523570A2;
	Tue,  2 Sep 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="idGzAKCP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D62258CF9
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845850; cv=none; b=Ke2OXlpSfJU4v7wADIYO5MTD08kvIFnEMBSLsjV1SiQcVmWHDaSGt67Plw3aSbJibYYU1Bp7pPNUWOxGq8Tr+l5vqD/tY4nCJ5/g+XoTKAChKSibsvR+bN6or5Cdc/0qjdD7vNEcAU2s3CjFowSMKRXMHkkXJX+sWrfDJZmckIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845850; c=relaxed/simple;
	bh=x6tX6nu91SYmevBuzLc9GegifWHbFz1pKTFs2oYCmA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igq7rcX8vI4KB8Cpaw199l2DVDczNkbVweIsDWUwirtGFjhZ6+vBdDSCuR/O3gIUiVN7QbXeBgJoYJeLWrJNeYOHCOJ0GBh+9MPg8VlRg5FXfl0ga7hkDJWRN2PeG8gX37BUTWWdeGXxdv256wwmWvw5FoZu72PYGdqfHdieqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=idGzAKCP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Dvcf5020786;
	Tue, 2 Sep 2025 20:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+QtwAtGi+lUeG9MX/
	6kY5OE1Y/lXcKLRMncePf4XB3M=; b=idGzAKCPv6JOF/AcfPFhZ+DubOnxAXzTp
	BMkkYzQ2BKiHB52dLxX7LmjgMOnlyuI0LDiUh7ardW151Yh/a6dv9nOai2XeI2za
	NJsZUTeEj3tccXR+fMq0Khk2MqkksfwPuRfkInDu/pokMTd/pvR6v1FmG2Gb2vrM
	8nv6KamPOxoEyn+tlPgs8DKA4JlGM+GGvNns7cWbuTR9hAi9f8CIRS8oRseMQ8b2
	gJnCSLCMr8fymCa/mMmD6WfK2vO6ON+kTAosdhPVhfnZii8VAoM3K+9x2ekB6k2b
	0/0icAFkhNJE8BiSKye1Nb7rlTahxjo0sDFioQDpk2KXcjSkwGZOA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv30nf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582K3ITZ017205;
	Tue, 2 Sep 2025 20:43:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc10mgg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582KhsoP26280672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 20:43:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FA155806A;
	Tue,  2 Sep 2025 20:43:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB0558068;
	Tue,  2 Sep 2025 20:43:54 +0000 (GMT)
Received: from localhost (unknown [9.61.19.179])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 20:43:54 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v9 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Tue,  2 Sep 2025 13:43:01 -0700
Message-ID: <20250902204340.2315079-6-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902204340.2315079-1-wilder@us.ibm.com>
References: <20250902204340.2315079-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8hllmvu01yV8KNelr2grCe9svlsqGoM9
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68b7570f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=ZKn5ET9WYz78Zcf0JJ0A:9
X-Proofpoint-GUID: 8hllmvu01yV8KNelr2grCe9svlsqGoM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX1AxFm4Uiqo2B
 G866XTRPmX5kbKEs1Pu8bRaiTl3LZAKAbAPT2BM3NmqsX/0gzTK1qD3oZhCRqJvejpztDO4JCkM
 uFzt4D0I0+sq83ApBj4EBDo+IfOlxvW6tLzf1SkOgP1YlursWYW3BQrZsw1Qo/Awh5sHbNdo2+R
 OJ9jYip+pFuMacLh6yIaRbjIjd3qxwn7N76KcIPvmeacydhKq2GXErHsymMamfvT8T+pkfuEODh
 79FuQC5LcP2Vg/nf+UEMlyZEu2X3tzjBqKe3wn3Q5cHusG3wDDihYUY5uMe8DcIsATeiFBPC612
 cfACCIXRImyFPiSqGUnmVnU7Laq4OdGgZTWSF6MlMdl+gMoY0G4gbYpUSPaxSBACB9+Ecp/kwrl
 04/4KZHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034

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


