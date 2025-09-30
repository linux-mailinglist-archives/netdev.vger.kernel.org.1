Return-Path: <netdev+bounces-227252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56579BAAE30
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F723A5145
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D01E7C19;
	Tue, 30 Sep 2025 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ck5beL77"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C252F4A
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195773; cv=none; b=P21s2xHMMlgHYKxhliPsthVIo0b3cB9IyjwsznV6t0lKKl7h+PrwjbGyyJuU0KOvHtF7vnXnx4G6GTkjAfbE96DjQR/KFj278Ui0AsRWHLqpZJQfkW0jsvYLux8jRGATgxKeMGT4GYXLJlY7j2K0VVv1kJd8tJ+QyjuXPa2kj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195773; c=relaxed/simple;
	bh=3zKg2Z9w+WZyE236CpTfTqswWM3zGacWYup2KvPBEyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMyjXxc4d/Ksa3zOs+UM9qsVezgGQE78sugtVvCGS+0dgoAUnXyGqA9YU/CSDocmTeTRH0dBJFg0LaJVs0PQ4fInqGDxvNkHoV+fMYEuXUxJbqBGlXq5PFsrISGacNk9R8UsUcjldsZke5x1jYDq530OXuc5H2Amrzw2eni5V4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ck5beL77; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TIUfm5031156;
	Tue, 30 Sep 2025 01:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eHVWs+0O7od5+sLmb
	6i7bM3IAopydqkgHlOdezhO4vc=; b=ck5beL77TPkcYNVn/M8NEUiVnpcHdGgux
	yWukh3/etgbggMKYWbs1wio47XOsynmGse5sjZS9gTRjMiTsTl/2OLadHtPpqtJ4
	PSLydz/P41xxrgaNIvKnwkENoFi5zmQSi6ayCVCxte6PaY7fM4PeAk/UV15NI5bs
	RNoCkJ3TMtEDFHgGWGye9BjsoRaRe30k2JayCbLZSuMCZMf2ILU6sKY6KbXeDkxg
	lo5i0cyiFfQg4Nl/cXwEIsw1vYyvhduFiGwQ6pptLdIEqEPvEF4HrXWJXozsXojO
	y4ZzGuLzejgTklB0RgWkyZHrstymNSTh9XI+h4zGE4BPR54bGbnQA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7npet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58U1T88h002081;
	Tue, 30 Sep 2025 01:29:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7npes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLQT1T024121;
	Tue, 30 Sep 2025 01:29:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy10pat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:29:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58U1SsSv26608300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 01:28:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37CC58055;
	Tue, 30 Sep 2025 01:29:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85C3F58043;
	Tue, 30 Sep 2025 01:29:05 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 01:29:05 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
        edumazet@google.com
Subject: [PATCH net-next v11 3/7] bonding: arp_ip_target helpers.
Date: Mon, 29 Sep 2025 18:27:09 -0700
Message-ID: <20250930012857.2270721-4-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: DTFOJA2J5j-QLJZUlxNpWw6kFp7uAd6a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX97FLBgbowNsf
 77cN55yCW9luULcNSvGkledREUEqe1rcRi6yx+5Uvmqzgob2LgUdWYxJmAtjVt0RgtesWERwnvz
 WMWfTtsJ16m4s0sxriHaMQRhL1U/xKPzRTu+CQ971MhTSa9ZHAJ0FLH0cAl85+jIvWsFIbKu9jU
 OO17B5ighOT0KVSlfMDokPpwugkoK5zn/IC+waUuK7RX95FxTLlzf5dikdBVskRO2twgL/HQSpc
 4/jTbqqiQ5XfC8s8NGHFzq0X038qMZorfPVwUY0A6EtYfOpL08JuSQNs3dDZW44QR0RzF6RCLZ9
 hdTaVsqjwbqHiX2ZlGBoCjt/yZUSL+N+ECS3Ozud6OwXfwlTRiNO+BOy+fSi9VnVDccqmmJhTtr
 CJEHhNqxFR77JNzRpAiRY4C+9D3U+g==
X-Proofpoint-GUID: YjCRrYBp7Ki-wmPpWDfRvDKKKZiKJeRh
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68db3265 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=JskuJHzKiSc7y_Fx0koA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
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


