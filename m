Return-Path: <netdev+bounces-212651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF134B21919
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56E416CA59
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4321523C51D;
	Mon, 11 Aug 2025 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gavNzY7w"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB122253A7
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954377; cv=none; b=J1F66HmbT7ZXqnImOzxqVWFh8sxdfSRSXqbZDO/BRrGZ607uPvWtBUqCD/tQ8AAKmhGXAfhyJEDc2+j91IJ4q9WxXb4LNGWNJPvvbbwwbng0VWjll+DhfnYGeoWPLBxwXOIi8VxC1bWPffZiS8DlOi9mV0reNgobN9bkrQSsTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954377; c=relaxed/simple;
	bh=oP/R6in0HrWODkU+mc3GB/+qcQ4oo8AqfjyuWwi8uCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8BY57c7NLI+Ci4maun2HgBnSB19d7DW/7NatbeKWtu6tUO/IStlJMGk3F+OCPy9ialESXpggD4uTeO9jOGwG3m8Ktp1YNP2sN+iG54dZmT/r4Z98Y8ln0U1Uauzzt3g+z5ZszVTL2KSYyk44Dx6Xy6NJ/tQpLkwlgKpFXi5uIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gavNzY7w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BMpxBB022445;
	Mon, 11 Aug 2025 23:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5q8WfhzWQBCS/U9HP
	KxokFDV5gyuzyaTLHkyqIBKkfc=; b=gavNzY7wRqJl2jWzNzny5H+R24ZDWwQQm
	OThiPKTAXJlnjDLzETlEnBXjQGKLPd7cifuW//XM2p7vEqMQFp7cMtygB7qwgG39
	EvDGlfa9/cGiBCvypHCxZKeGZzIW62NMTSBtsDFqUBpK/yftgOp41SoEQBLTwjQ8
	7/oy+tOYcXLwJ83DoGFGBPP+ga9M4E/kW+8JkNEo7GMSGd5De6FW8D7qyrb/CcYz
	kDxyiVtAQuXkgXpO7rFZaMMUY5hilp5LisxL814DU6swV4JX9IZSKCJGlUK/QRm1
	qTyVMLWgYtRDDUz9bJmHW4jBcYB2gB/rh5lYsGgeBr/e+BZZaX3FA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cup8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BN0V9D010622;
	Mon, 11 Aug 2025 23:19:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnug4h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BNJIE825559782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 23:19:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3522D58059;
	Mon, 11 Aug 2025 23:19:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C53AE58043;
	Mon, 11 Aug 2025 23:19:17 +0000 (GMT)
Received: from localhost (unknown [9.61.174.150])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 23:19:17 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v7 3/7] bonding: arp_ip_target helpers.
Date: Mon, 11 Aug 2025 16:18:02 -0700
Message-ID: <20250811231909.1827080-4-wilder@us.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE2NSBTYWx0ZWRfX9HcSHkSGc8tm
 Ew542p1jtHQtxGDnZZTxXWZ93NlexVYbW6/e9Ez4zG+a0e11lNk0VCQBbL/tLM3osJWEQWPkKKZ
 +I2tCzqMiSeP5ueree+eIWiGH/Fip63pGCmomvlGUb9SBAVx0B4sSTZBT4bMxduq/OTLb6vD+1Y
 BrFOwglvljhPfvy7GC5jlHsaoFJDaoi31y38LGickZZi5KngbUV4WEf7VCeZRKoltbMT42Sp045
 6ay5IRH3E3ATFbf+aUWGWxy14Fq8fQLr8iyc2BJoqxZMM265FZ+mEcWAT8BOp3vF+8oOjtSNykr
 BdkQIXo3XmdT65xqyyqGU+WdlhGf91dTe3jPpykoLfNqX0OafxxBSfQj8rQn2xtVq9KvkrN6BLh
 CCdk2cVRVMplYDmY6xIVLkfaGSN+qxSBh9kD94T0wP1bOjCPLoSXfszqlgiMasQtOHiSCETW
X-Proofpoint-GUID: UFFyQQdwF5nyOdTVvpNL45rEWTVC23ha
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689a7a78 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=foHp8GwuVaWwjksxq_YA:9
X-Proofpoint-ORIG-GUID: UFFyQQdwF5nyOdTVvpNL45rEWTVC23ha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=732 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110165

Adding helpers and defines needed for extending the
arp_ip_target parameters.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bonding.h | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 27fbce667a4c..1989b71ffa16 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -809,4 +809,49 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 	return NET_XMIT_DROP;
 }
 
+/* Helpers for handling arp_ip_target */
+#define BOND_OPTION_STRING_MAX_SIZE 64
+#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
+
+static inline char *bond_arp_target_to_string(struct bond_arp_target *target,
+					    char *buf, int size)
+{
+	struct bond_vlan_tag *tags = target->tags;
+	int i, num = 0;
+
+	if (!(target->flags & BOND_TARGET_USERTAGS)) {
+		num = snprintf(&buf[0], size, "%pI4", &target->target_ip);
+		return buf;
+	}
+
+	num = snprintf(&buf[0], size, "%pI4[", &target->target_ip);
+	if (tags) {
+		for (i = 0; (tags[i].vlan_proto != BOND_VLAN_PROTO_NONE); i++) {
+			if (!tags[i].vlan_id)
+				continue;
+			if (i != 0)
+				num = num + snprintf(&buf[num], size-num, "/");
+			num = num + snprintf(&buf[num], size-num, "%u",
+					     tags[i].vlan_id);
+		}
+	}
+	snprintf(&buf[num], size-num, "]");
+	return buf;
+}
+
+static inline void bond_free_vlan_tag(struct bond_arp_target *target)
+{
+	kfree(target->tags);
+}
+
+static inline void __bond_free_vlan_tags(struct bond_arp_target *targets)
+{
+	int i;
+
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].tags; i++)
+		bond_free_vlan_tag(&targets[i]);
+}
+
+#define bond_free_vlan_tags(targets)  __bond_free_vlan_tags(targets)
+
 #endif /* _NET_BONDING_H */
-- 
2.50.1


