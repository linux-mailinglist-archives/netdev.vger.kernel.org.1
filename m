Return-Path: <netdev+bounces-208253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C1B0AB6B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48647AA445B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084FF221F01;
	Fri, 18 Jul 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kqRX9llO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76E22127C
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873901; cv=none; b=c2WCAd7rR4KQVQ0Tv4RI9T/cDkY9Inq2CPuiOUAR3ogH/7PwxA0KQAlxWPZBvWvfNFuE3FfLxKPxqwZBYJPkLvsWwiIvasO2YxRWaRJgN1aM3J9z7ETOlBvucTEI9SYsaobYW/3CcGurteZBttjCxwC19TH35CSP1hcrQQb/L1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873901; c=relaxed/simple;
	bh=H2xyD/eNpJS52rY9MoBjwpnCMxWLnR3gDjYtG78ZgOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c17zRWxXUDkXHgs52qvT/xves5QHR4yJnq+MWPH+1H1cg7lCbo7hSiX1n4w0IlfcuRw6puPzuLaBEwZW19lv11hr29wUfm5+7xU4oPcgqL+iqseq4ByJnkZCLuj9Zg8SuIItnBYXYixdpJOu8UZu0PCCofKosrv9caU82R/oL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kqRX9llO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IInMjA028289;
	Fri, 18 Jul 2025 21:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2sFnjqt+4GtdH/bH6
	9DElkubW9243ug4MetFjYPGkMA=; b=kqRX9llOgLJWUpgGkIghJwuU9DxMBmpeV
	OOsIL3fmzjwm/BUN29ADHR7KRTljcSaugSz3P6Qlpu0zztsmYjYY9s6ZFRbJOi3m
	l67qixBjA1zk92vSenKRjlK15JaKiFNK8wDCN1ovXYOgIUyi5/eWivnVh8S9dDpj
	4GAWwSpbiYW3JWsvRMWmdE/YXSK2Kr+I08mTrdeb6+rxzgSuPqQcd/kbyRiPSKpQ
	CMPzaTMA1C0TEidyaV64Wfd/pvhEEpSahuFvVgersroC+H7chPshLHt0l9YcmRl2
	8INh41EPDCIZDnUN9JiuJftEJvy9nBkceu6KYtvX6OANqhmcSY9Lw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4uk92c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHf8Pj008180;
	Fri, 18 Jul 2025 21:24:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e137yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ILOjJW30409294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:24:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01CDE5804E;
	Fri, 18 Jul 2025 21:24:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF8E25803F;
	Fri, 18 Jul 2025 21:24:44 +0000 (GMT)
Received: from localhost (unknown [9.61.165.151])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 21:24:44 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v6 3/7] bonding: arp_ip_target helpers.
Date: Fri, 18 Jul 2025 14:23:39 -0700
Message-ID: <20250718212430.1968853-4-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718212430.1968853-1-wilder@us.ibm.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=687abb9f cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=foHp8GwuVaWwjksxq_YA:9
X-Proofpoint-GUID: BT-NBzzzNcyH_8SlaOWbjgyTaJ0UyTHA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE3MyBTYWx0ZWRfX8Kr6DX/Bd/MO /atR7LaZFgNZL2ImKXtmtNZ5+yRFFpf+dGwM2hhcXIU+x3z08m4+B1l7L+DPxT+EXeOenc2ZrEo GAPqg686hkfwd1BQT20eiAxkwH0tOzMovfzyfEEhB2sGLL6Hw4lhMLbU01OX1Oygzp1tHRHrLBR
 liMCEzP0Bx8lHcJFNDsdMJ98JZD20t2qLNxgnOMx0iBUTcu7xvoVaB2iR4mywv1ZWP0MTg5Hak3 zn7YcajkskUaIZejRg/KiRaje5hx4y5vxSfhgiq3fh7CwBDoCcVFkSWKREsBNTRTJlnPH7DjshZ L7KViB2yztP+rabu7p8dWk3X46PY8WVtDa0/G/fE9R8eXlV0G15KZBTyiYkWfKlXgI2oQPhc08S
 PbnU+tV3UvMDTXGhZWChyvSNsYJVV3Ou4RDaGvzIoBigS/nKkujBjFY+ZjXgCkDpfNE0+Jlb
X-Proofpoint-ORIG-GUID: BT-NBzzzNcyH_8SlaOWbjgyTaJ0UyTHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=654
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180173

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
2.43.5


