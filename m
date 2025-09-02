Return-Path: <netdev+bounces-219294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0556FB40EAC
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D757A208660
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41713568F0;
	Tue,  2 Sep 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gfs0z5bB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7F2E0402
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845849; cv=none; b=X1qK1CZPGSQKy9vGnwTyqiOKw8c05ZhqN2XP4s8VPcJI8hEyV0LjWbaTredoAGdqXlPXdz2zW+u8UqWj4yDivF3jnr77fzVQMHEk5m2EMn0tR9d+w3POUtPEWYIGydu3q2pkIUTtiWhHbjRRRhV42vcauEd217YSsNuGGYodIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845849; c=relaxed/simple;
	bh=vMCiqSwZNieM8CsPE49fBFViaUnIGcbdqLmxk0JAwTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYxPe8b/cuV1CVgK2No1kRiBZiddGSwW0G+FOITmVt8ktJZyN2r9H3DZm63yGq0tKW5TXRV7vGqCFMhRnVlNKNbMLYyDAr3/U7C+sp9zAMNrsbkck3N4y5vutoYSa16UWuqyD0VKMsdKeZbqYe5p5j0DIGwUma8Ls4fs2qNbM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gfs0z5bB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582D1lBm032366;
	Tue, 2 Sep 2025 20:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lbtviIuaH19jPKR7+
	2MCkJp/EuHDN2p3MSOmSy0ytW4=; b=gfs0z5bB+dLI7XYoQTdbIzsPMI+Fx9dhI
	Hkvv1cyy3m4jjpBY8uMvuW0wkNHTlYXzyJAmFyf7RZFedlpuWR+MlV93sSHYkvCk
	fh44DWcmaIKD9WkWYOeBalWHgbXR4I5sTkliO7Oa9c0dYH+uCJnfwCetavigCXtn
	i4cJE3QzgxED8oHxDjb61VZc8HfCjKY6aoqIGAnHkJCfiZHDzfMkirsErkHuFTtm
	hX6TOO33I9MunfovfB9LHAnSzC6qyub48unQHQDOs3OZWMjX8vnlg/27E2qIgajo
	/55tTeTWJ3TNV4M2GIQLwu/uN8TUEgAsyVDHwnt1RCvVdmFOznWIQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshevhe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582Gs7gH019331;
	Tue, 2 Sep 2025 20:43:55 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4mv9rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:55 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582Khq1e63767020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 20:43:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8F0D58056;
	Tue,  2 Sep 2025 20:43:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B1C058052;
	Tue,  2 Sep 2025 20:43:52 +0000 (GMT)
Received: from localhost (unknown [9.61.19.179])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 20:43:52 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v9 3/7] bonding: arp_ip_target helpers.
Date: Tue,  2 Sep 2025 13:42:59 -0700
Message-ID: <20250902204340.2315079-4-wilder@us.ibm.com>
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
X-Proofpoint-GUID: OW6-QYaxoqoQvIaRa8ZPrwy1itKdmm2-
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b7570c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=qs8wLYpL4z_OwzeJrIAA:9
X-Proofpoint-ORIG-GUID: OW6-QYaxoqoQvIaRa8ZPrwy1itKdmm2-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX7YbTBzogxBMK
 zM2BUxWka+NAvZYJ5XkPy6oxX4OCVwdAItW/6Gno/hdssG+AqcleYcOVLldIRyUPHoGr632Eoyn
 5pVzqqnTs32IR2Aawha4jBOeerYNpaBqUm4/EI5bFSj/AcsIxfO+oWSklhI1VR0/016nhGuuDv8
 2xtk/fazcBbK3FqAOJ23P/nHhCn8i+2MQZuu6y2h4pWm8Bnlv5T0BYG6rYyu2u7JQr8rgzMS3tP
 XOp5QGAyoNMp3A2HXksS66uMzu645xhSkLka7nGCaGzCFnDNI6Z+4iHITb1m19uJnaxDZR6O1w+
 +LpbsmmXBaiBWPvZE4rEHvfyZLolO1OdIMR/JUWoT0DppLEQ8RGpbfviFczvKGFzCQ0Syqm56Xr
 VgEZ/FDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

Adding helpers and defines needed for extending the
arp_ip_target parameters.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bonding.h | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 27fbce667a4c..2502cf8428b3 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -809,4 +809,50 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 	return NET_XMIT_DROP;
 }
 
+/* Helpers for handling arp_ip_target */
+#define BOND_OPTION_STRING_MAX_SIZE 64
+#define BOND_MAX_VLAN_TAGS 5
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


