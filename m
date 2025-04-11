Return-Path: <netdev+bounces-181733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044ECA8650F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86063B64DD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3C258CC1;
	Fri, 11 Apr 2025 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M2PzJ2JO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9B2586CC
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393774; cv=none; b=o8jP7+QtLv3B8aIShyJXn+BWgQ2mg5kRTy5ytLpSXZJtTUA+pHHCV+Ltw/73vhX7NSIJWqfA5EtPGz5J5h6iu96P5p6sJi3DbsJM9qj3NeeTX6kJTi+fWfeMS9oocgYmlNAPRelb6QZQY6zJ0tyql4K10g3YFU/8Tzh5ZpDkWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393774; c=relaxed/simple;
	bh=VDSkdsMyTyFtiCkhIzRqPQbDjWmtryvE5V1fWHU96bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLZ56Fhy6DfPcU8Oo04Km/lMC7Rb3iLAkvxYh03knI/dPGldxwjYHvwn+R04Bc6xZS1DXV4Tw+zDyETOZFkJJF2M7KGJaDLBrU18XZpllWk57x7O3qAx0HvrqlSIOJpLHDLy93bVmU+eq5oK9ZST8+Jjb1NYQ/2CMVtA/BZJv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M2PzJ2JO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGjLYm006650;
	Fri, 11 Apr 2025 17:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UGJ5GxCMdETZyC3Io
	FjW+9tAkxxNhD/xI3CFe4JToio=; b=M2PzJ2JOI0ZC4PZhd/DroWW90Gsms9Vvm
	UgDXqtD8F3zr5J0A6kaPYuu4qR3C2uHbHVbaPS8WvDlivmcn6RU2kjidpllZdb5A
	4GPgOlPsy5+HuPM+v4Wi3JxV6nI2xWX+BpvIm/zID50BsB8PmLxU6de7xZsAZ7fv
	+UeP0MXT4V3yvb14ARkfUle+gdZ+nh3/WljcjsqlTtUoBgFZ41YukTnLExkFUGBU
	AzAsxPMb4ydQSP07g4Gtm0RH200uehAg++K3HzynqMuAO7P+lPVmES6RhZCSjHJt
	5q4jOyL++Ml1ZvcbQb9GuUC4UfHGg44HHBj6VbM63jjQMjF4+dvgA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y4gqh40q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 17:49:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BEaIM2013860;
	Fri, 11 Apr 2025 17:49:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup427g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 17:49:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BHnQCZ25428604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:49:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57C358056;
	Fri, 11 Apr 2025 17:49:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA1158052;
	Fri, 11 Apr 2025 17:49:26 +0000 (GMT)
Received: from localhost (unknown [9.61.62.58])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 17:49:26 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com
Subject: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP monitoring with ovs.
Date: Fri, 11 Apr 2025 10:48:15 -0700
Message-ID: <20250411174906.21022-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250411174906.21022-1-wilder@us.ibm.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R9t5cHALjF6SYtgqq2aEo0vjiNqlTGr9
X-Proofpoint-ORIG-GUID: R9t5cHALjF6SYtgqq2aEo0vjiNqlTGr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110110

Adding limited support for the ARP Monitoring feature when ovs is
configured above the bond. When no vlan tags are used in the configuration
or when the tag is added between the bond interface and the ovs bridge arp
monitoring will function correctly. The use of tags between the ovs bridge
and the routed interface are not supported.

For example:
1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported
2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.
3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not supported.

Configurations #1 and #2 were tested and verified to function corectly.
In the second configuration the correct vlan tags were seen in the arp.

Signed-off-by: David J Wilder <wilder@us.ibm.com>
Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com>
---
 drivers/net/bonding/bond_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 950d8e4d86f8..6f71a567ba37 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 	struct net_device *upper;
 	struct list_head  *iter;
 
-	if (start_dev == end_dev) {
+	/* If start_dev is an OVS port then we have encountered an openVswitch
+	 * bridge and can't go any further. The programming of the switch table
+	 * will determine what packets will be sent to the bond. We can make no
+	 * further assumptions about the network above the bond.
+	 */
+
+	if (start_dev == end_dev || netif_is_ovs_port(start_dev)) {
 		tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
 		if (!tags)
 			return ERR_PTR(-ENOMEM);
-- 
2.43.5


