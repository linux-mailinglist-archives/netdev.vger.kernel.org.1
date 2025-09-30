Return-Path: <netdev+bounces-227405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E6BAEC9D
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417CF194347B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6A2D1936;
	Tue, 30 Sep 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fjtgyNVp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89134BA50
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275549; cv=none; b=N5gNgld7RFgmVl4jfrq9uWqb1wuqtP9R8RFjHcQb6Eb+sRUHv3Gf2yWqKeP8+BE4VozJlAdbhE/VA3No5AZpkPlp446SOZ3YHLSnA6nhX91o0FqDU+GntcrhaV7nr5Wr7GtAwBoCNUijyL+4RajzV4RtF7CUhfHSN7i6nvGcTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275549; c=relaxed/simple;
	bh=3zKg2Z9w+WZyE236CpTfTqswWM3zGacWYup2KvPBEyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Caq+0h38R9G5iL1NDeSTjIH/jk5KBZdxGVXg3B4IIFfIW9VUgOvLSFqej/9NPJAw29ulZo1WlG+9E9oCesViq0aOws9KH8HBRCDsjxESrGEWm45LatFqS1MAkmQptrX6i6gP1Ht1UF6c2aEk+jbeU6k3luVRNrNfejdg1Zh8T7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fjtgyNVp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UGRGoe011807
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eHVWs+0O7od5+sLmb
	6i7bM3IAopydqkgHlOdezhO4vc=; b=fjtgyNVpSiTXeJFhbKaCVjHWA17ujSN4+
	F/xMUN+U13YpC7LXxi5y6ABVIKayufUMs0NBHDeg39LSuNjRAht4AbJ66KPaekmy
	3oWjfZciH5UUYZ4VAnP83eWQ7l1pr0kSoNVKaRY6zbyKKM8C4hYeUd75OxsvKRel
	WDihY7vKOO9QiqZ5wf72CjeSA3Gsq302YtYZXHxoVPO3LJB0qQ2aUz/d2BDsg6zo
	Wcc7GJvDeaTe4ipXTMUBdxrsIJy44Uw4RVIZRs+hKIUyBupyVKj7f5gs85fIdvWf
	PEfUuqtMKRlYdoSunI4x7muuCSSH8bUNBAH11/S8qCQ5AmwWecbjg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwkej0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJhLmn007285
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurjx1r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:04 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UNd1aW29491498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 23:39:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FF5058055;
	Tue, 30 Sep 2025 23:39:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBCC358043;
	Tue, 30 Sep 2025 23:39:00 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 23:39:00 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: wilder@us.ibm.com
Subject: [PATCH net-next v12 3/7] bonding: arp_ip_target helpers.
Date: Tue, 30 Sep 2025 16:38:03 -0700
Message-ID: <20250930233849.2871027-4-wilder@us.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX3yZvhe23+Y9b
 gWkIaK/ilIrd8qOj2a8bQguqNsaclG3/uMC81L5DyNEZvEaSiFvJ9dJpqOBvI+mE7+IqKWGC7iR
 bQ7mWAOlVKlQSUUzyoxLAE6Ccs4j4DQie3KTORotBpkqhRWwvi0zkeKVglZ2LA4Y5bKLWuUS0C7
 bl5ldlmZWOQlil/88yDy0bFg9pgbif2lWl9MZPODqmqrkg/6HtGl56AgnCDsv9LkqTfhviNcPZV
 sGNRofapKrzONtz5r2N3isHxOzmmWD+kKaR8D9P0tDNJAbPtmFlkUB/cBfOulo+H3rdS15X/y8I
 x5KtRg+Nu1iGxj48CHOFDO1WGPwDiO4VlaRD9724Ud3TX3zNWwUy7blOT70rPL0JTXyGvg/9jtq
 lT7qquZbA2hVHbn/EzhSbPUwJ7h4Lg==
X-Proofpoint-ORIG-GUID: qHqoMz-08wQzFox8kvZ5ALEt3iXw4o_-
X-Proofpoint-GUID: qHqoMz-08wQzFox8kvZ5ALEt3iXw4o_-
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dc6a18 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=JskuJHzKiSc7y_Fx0koA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Adding helpers and defines needed for extending the
arp_ip_target parameters.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bonding.h | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index a0eae209315f..75f6b1e32b3d 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -808,4 +808,50 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 	return NET_XMIT_DROP;
 }
 
+/* Helpers for handling arp_ip_target */
+#define BOND_OPTION_STRING_MAX_SIZE 64
+#define BOND_MAX_VLAN_TAGS 5
+#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
+
+static inline char *bond_arp_target_to_string(struct bond_arp_target *target,
+					      char *buf, int size)
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
+				num = num + snprintf(&buf[num], size - num, "/");
+			num = num + snprintf(&buf[num], size - num, "%u",
+					     tags[i].vlan_id);
+		}
+	}
+	snprintf(&buf[num], size - num, "]");
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


