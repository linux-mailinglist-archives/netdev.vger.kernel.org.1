Return-Path: <netdev+bounces-220176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 755EBB4496C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 500BA4E1386
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281DF2EA740;
	Thu,  4 Sep 2025 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kU2f96b6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314A2E9EA6
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024417; cv=none; b=KhTy4RbqzoPtZpjIxoXDUwSq/hTdKbwHcVl7laDgav9YhPAhSY9LbazwJ8K39c2tU1PVRjsqIGQ6dV4yAZY6KMxs/mKe57rTvnRxAGFaqDK6SfzSkexyjP1gToTIm3Z/w3J8mJxI3+B/UgtaW4B8VffmdSzj1Emz9cansnP4neE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024417; c=relaxed/simple;
	bh=+qgcF2aVnyncQ5B0vWOz0KveiCntzSdl0MUJNm5dDkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkXyLjkz2Ghs5+/rUp/YJ7wKPXuvscCOJn1pla/DtPJLdvtfn/WZ1SlWRwkekhFMWfjvHx6+4/xjMaX1tvK2CiwG2Av93dEaJD0+lZc9qLLPwGOl2V+hbtJYmZCJ9/MQjOa+7jtheYKMqb/IPkfqHN15L7i/LFKG9lHRLjWtrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kU2f96b6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584J5aL1005211;
	Thu, 4 Sep 2025 22:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PsxBi+7iE6kHnvks+
	S0VQ1rmPOfgENPUoZzHm8iCB5A=; b=kU2f96b66eREebzui2cXiaGttgg8AvpM1
	+DATk7Bni/2ws2WQJBHZpbFJgZe73sQCaFIDka2ZUkHwQDKiX6NL/2nt2j0aBhKx
	XM9nmV23LpoEtF9nJAhx74sb3AicnvMuJnjX3Tw/lVf66wuZnC4wWUtnKyiMemo3
	1SUKzBV6mhpIJMX+/JAVqb352qBBNpon9wzSCzhmBSggDIVwCFdLbBkF5MuyAIOr
	UOSjxlszyNefQn2BLB7Zn2OpKLuss9IIOrpiRvApGheiJVrYr3QgP/NPW/yxuPZH
	ib9Cs5wLjaKLmCgApTQ5L7tm//7OcKaTrOlc0yB4jTFRGIXm4C2tg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3d108-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584JbAj1009444;
	Thu, 4 Sep 2025 22:20:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumpg5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:05 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584MK1JY2621956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 22:20:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D51958043;
	Thu,  4 Sep 2025 22:20:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC9958059;
	Thu,  4 Sep 2025 22:20:01 +0000 (GMT)
Received: from localhost (unknown [9.61.141.209])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 22:20:01 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v10 3/7] bonding: arp_ip_target helpers.
Date: Thu,  4 Sep 2025 15:18:21 -0700
Message-ID: <20250904221956.779098-4-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: 4kSD7QJ9ZMx2OFomj0qEiv2F1AZB_k0q
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68ba1096 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=JskuJHzKiSc7y_Fx0koA:9
X-Proofpoint-GUID: 4kSD7QJ9ZMx2OFomj0qEiv2F1AZB_k0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX3YLrFjaTIQ1L
 QOrjcyl5KzMSXziQZ4vKWH9/t//MxyVodotoOR8dy6GXdu4DpzbaIvBCXgyffJAu4rkDHpost2N
 ygHX+plSzE40945vUDarGpnnXnrJRJiFYkLY6MLrEFhJQPD8AmnWSQKdjZSjBM2jwDuJsY1/Zt6
 0jx6WV5GdoYwHOaWf9rHwqoRiHAzaaUGZzDHZbK5IQqUkQXvqbZiP01By+QPjVtAP1afAWLAVFa
 jk8mAKMXCyPuXzfOE2wMKOn22ypxjDfZRU4NY0ZAd3yA/vQGFPltxbpkaZr3w20UlrCRMKiYcb2
 u9GNXoGIEY4jWd8L7Og+L1HLcg5iiR0IjmBSFQhgPFE4MCYeJ/WDcU394SLtS0Ni2/Rdm8cC6fl
 GHku/6lt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034

Adding helpers and defines needed for extending the
arp_ip_target parameters.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bonding.h | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index a0eae209315f..8ebc39d08963 100644
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


