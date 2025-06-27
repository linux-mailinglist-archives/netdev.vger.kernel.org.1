Return-Path: <netdev+bounces-202037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A94AEC0C9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14583BA3DC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814122D7B1;
	Fri, 27 Jun 2025 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FqUustqy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8744502A
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055590; cv=none; b=g82mOVPimQdcXrkYCGyIe7V/PcvRyUbQYXF9J0DuatSor9Xtbi4xzqeRYIVlnKD6n3skzga+JhPLqulU2PhLdacv/1lqqbEvkuiX9gUZdxnb3R9Kz0qYG1A2+NoCaoPGhdwaAeRQO4k2l34xsrqNbu84tiAl+6CtC0E99fxAEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055590; c=relaxed/simple;
	bh=Oiuup6pb5JjuPes5uh+wetNvKqKz6HeV3k9mSOG7J14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBy7W5I1r4vvLFhTvm68NqX/fV4fzL5Os3/sJwkB8l05knvuqA22Bpnt80/2nvMl2b2aOnyRYbPLiaZhfH+l0QT6RulVRJ6ZHcUwq8NQYw1/Fff/0tAo27R3Kmfyi79AxOMCi0eZK7uEmDx3wyrWWdkGi7bvV8OkD6iiMWQELwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FqUustqy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RJEnQU010331;
	Fri, 27 Jun 2025 20:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TvokCbDtW7frsZ+mg
	hUKgNSAEN4E3U1H1D7yW3cPMs4=; b=FqUustqy6oESCMfNY8ApfqYNG+HreE9wF
	WkZaU4UvhO8b7hsn3N+0kVU0cuUQW2kker7VrXL2jLfH5Okgvzl0r06227i3KlYh
	MDtb1ZYymS4beDD1n0j9GdlPSYsbu2obskXkGUsfGz5xaKZaRB0E14n9EW/eTPeq
	FwJ1P2jZraAXHLMAl54wXf/AskKv2CC5unMAsN7NNSBoU088McABa+Bl8TIZjSHe
	sCHzqaD0mVL+7OgDzD5c3RWRuwykBn+K28yZ+1BiU8FJinUdcDJ3ayPhA+VjmdGf
	TXGdfGcGVJ1mCh5Tyam2W04iQtcE8x5txVGH8R+DDkAW9r36ozgUA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphwnvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RHtke4003976;
	Fri, 27 Jun 2025 20:19:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99m5q9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RKJWq727656776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 20:19:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 317E65805F;
	Fri, 27 Jun 2025 20:19:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E98B158053;
	Fri, 27 Jun 2025 20:19:37 +0000 (GMT)
Received: from localhost (unknown [9.61.49.21])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 20:19:37 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v4 3/7] bonding: arp_ip_target helpers.
Date: Fri, 27 Jun 2025 13:17:16 -0700
Message-ID: <20250627201914.1791186-4-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250627201914.1791186-1-wilder@us.ibm.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -LV2-pb9sT-a5mVRQ5O_LRZ6p9EBxbOy
X-Proofpoint-ORIG-GUID: -LV2-pb9sT-a5mVRQ5O_LRZ6p9EBxbOy
X-Authority-Analysis: v=2.4 cv=Hul2G1TS c=1 sm=1 tr=0 ts=685efcdd cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=JskuJHzKiSc7y_Fx0koA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE2NCBTYWx0ZWRfXzd+BS92iZSZz 9VU1WyUNdGx5hId9bJyMhdAg+Bi83F+XpbED74O6p5/aQOMy8qIfhGJkcT+B3/3g6hpvKxuRZ6v WO+Ssr9Y/oLhh37WOG5p6VL8rSxJjrHixC/0iu2oeLaOk5ZOFmy2gJEOog2pKCBXk3Gty3aVnl7
 MQx3hv0fLOyJdOcnA222DrPS4KUbsHcgElCQKURgJhRyXx/vlovgZsJlYj6wqN/W1GXJmG+4+mI cE/3cBKpK7jqXTAnitMXrBrdmr/kZp5U+wZ9rj06SEN407y7pPDAx8k+aCLSs2Z51P55t6Ju2G5 tnYjc5rCm1IUyq0PW8P+e8naOXX285xEtbeQgGkg/bC3RaLn79UTfG1awavmtXWCb90Nud5ZfG/
 XBVH3SinO5ld2rurYIL/502BQSvpXtVNkHDY8mos/U55bHl4OZBQqsGrp3p8UO+uE2zb1B8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=693 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270164

Adding helpers and defines needed for extending the
arp_ip_target parameters.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bonding.h | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b4c43f02c89..a111c50399d3 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -806,4 +806,49 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
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
2.43.5


