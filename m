Return-Path: <netdev+bounces-278967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKadLzWe4GlKkQAAu9opvQ
	(envelope-from <netdev+bounces-278967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE6D40B90F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB92B307AAF6
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97AE39150D;
	Thu, 16 Apr 2026 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="myYBazHI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13A37C0FE;
	Thu, 16 Apr 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327968; cv=none; b=u0hnU91336kq1/xLCj7mH05ZYjAm9BnyWKEyLu4mmdF5J7rt49QpbTpQMXOZSD/nMgiBUHy0t5LMLleInkpfImMSrlDvib4NO4qvsFNmfgbK+oy8AYa7b50mcFkvOgBzcr0Qxj7XCDPcAHj6B200cx4fmiFC9GVW5WPo+Ipts0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327968; c=relaxed/simple;
	bh=1nxOWCvVhVLJxrNEAhQo//rSDUMpOGN+mm74aJAO0DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EU+/7qcMba9yju17arWotZauTTAZ+uRrSPX2DKpB50vSn9+SnnQJ+e0VtHl06YoAmoh1XSNhAo6ZBpMYfUmXru3BJCmQt9g23KfEYHpbOrk4366/2DqYlIXMzAULP8u3C09ggqO10GX6UHH2+IYveakBLL2B5NxTUrRoCgfnrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=myYBazHI; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 63G46r9K4066359;
	Thu, 16 Apr 2026 08:55:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=qkcLPcX1Y
	1ZicE4oz8QgaXDnvJeJIEpnpLV+KZs8YiA=; b=myYBazHIS+TfFTOSTsKB4ZAf2
	FKfWLRLKnFNQwxfO/8WvBteFYuaXRV48qeQmIvT1wbzWTe8UypaoZx0fVmf7jEpg
	6W4M1A2NWLpaq6lHjCqqWoM4yqXeewiLlj9WWS4uxFk/PiqYenZRMf2u/T52k2Ov
	c2mgw4Wj/CAk73jf5xTJLbEipM81qunvIItiqd1PjLxzyCho457Jx1Wo4vJN+Qxm
	kWJy6ngyRdrRgFKlZSE8stTTPIy1zqGgCvuBhZVWL/TE5sxRk3G0uAhabbotJmIi
	iHPQixfH5QJaUYsiGDM53kejwQWwo8h6sm4ZU9LfD1IiuF8XyvO3lmhae4RPQ==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4dfeq6ud3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:55:30 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63G7fhUv025247;
	Thu, 16 Apr 2026 03:55:29 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4dj2v8e0a0-1;
	Thu, 16 Apr 2026 03:55:29 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id D798D8D;
	Thu, 16 Apr 2026 07:55:27 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: tc_tunnel validate decap GSO state
Date: Thu, 16 Apr 2026 08:55:14 +0100
Message-Id: <20260416075514.927101-7-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416075514.927101-1-nhudson@akamai.com>
References: <20260416075514.927101-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604160071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MyBTYWx0ZWRfXzLmKFo4oqgU4
 F68lWMLzSCs7kXuBjv0F6PeQ2N/iVsgmlg93dmR7xvn/IbWTIPgLMKXJOsjiuHxRSMssCQvNqfc
 v/QzLlOenOlbGabxa8tSbIAqJOX5H44V2osM1Jo/4x4fXkctsotPjMzXMx7lLxMxz9cguLVkfz1
 zQLJLh6cQOoi/PO3A+HmrNtX72W3v4XBpA16bKKQHl8qXWw+ZXDK/4g2eNbCXl8n8t9mDl5ZW47
 zu7yoFsmX2sLmIq0YGy7B1mSMxPD5cF7Yyn+aM37zkjc/ORnBpNjZrp+rDsqrFy/EFBO6iCHmce
 cHxKBwVxTGmyevj5NB25bWWkr9BsDIRaupweQ/T4Th+MYh6J1P3XITOrOmETvl0O8qNl2anFV2m
 oHKFmnSqvGW33l2h/kIcwAfe3pP7C8HJ+XYsL2u8OaLX5CvTLP7KUvwOgq5IEKdxB7uOhpBFWXC
 nZplPs2fZitF/OI5DRw==
X-Proofpoint-ORIG-GUID: pjQx7DjXyoBwf2cIj79D8k8MMxyoqHM2
X-Authority-Analysis: v=2.4 cv=bsV8wkai c=1 sm=1 tr=0 ts=69e095f2 cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=8P__5Em-pwOPtXrf4HJ0:22 a=X7Ea-ya5AAAA:8 a=70DEBb0-UiQd8ec9lQUA:9
X-Proofpoint-GUID: pjQx7DjXyoBwf2cIj79D8k8MMxyoqHM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160073
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,akamai.com:dkim,akamai.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AE6D40B90F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Require BPF_F_ADJ_ROOM_DECAP_L4_UDP and BPF_F_ADJ_ROOM_DECAP_L4_GRE enum
values at runtime using CO-RE enum existence checks so missing kernel
support fails fast instead of silently proceeding.

After bpf_skb_adjust_room() decapsulation, inspect skb_shared_info and
sk_buff state for GSO packets and assert that the expected tunnel GSO
bits are cleared and encapsulation matches the remaining tunnel state.

Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 .../selftests/bpf/progs/test_tc_tunnel.c      | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 7376df405a6b..74dfb694a210 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -6,6 +6,7 @@
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
 #include "bpf_tracing_net.h"
 #include "bpf_compiler.h"
 
@@ -37,6 +38,23 @@ struct vxlanhdr___local {
 
 #define	EXTPROTO_VXLAN	0x1
 
+#define SKB_GSO_UDP_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL |			\
+				 SKB_GSO_UDP_TUNNEL_CSUM |		\
+				 SKB_GSO_TUNNEL_REMCSUM)
+
+#define SKB_GSO_TUNNEL_MASK		(SKB_GSO_UDP_TUNNEL_MASK |		\
+				 SKB_GSO_GRE |				\
+				 SKB_GSO_GRE_CSUM |			\
+				 SKB_GSO_IPXIP4 |			\
+				 SKB_GSO_IPXIP6 |			\
+				 SKB_GSO_ESP)
+
+#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP |	\
+				 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+
+#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 |	\
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+
 #define	VXLAN_FLAGS     bpf_htonl(1<<27)
 #define	VNI_ID		1
 #define	VXLAN_VNI	bpf_htonl(VNI_ID << 8)
@@ -592,6 +610,8 @@ int __encap_ip6vxlan_eth(struct __sk_buff *skb)
 static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 {
 	__u64 flags = BPF_F_ADJ_ROOM_FIXED_GSO;
+	struct sk_buff *kskb;
+	struct skb_shared_info *shinfo;
 	struct ipv6_opt_hdr ip6_opt_hdr;
 	struct gre_hdr greh;
 	struct udphdr udph;
@@ -621,6 +641,11 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 		break;
 	case IPPROTO_GRE:
 		olen += sizeof(struct gre_hdr);
+		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+						BPF_F_ADJ_ROOM_DECAP_L4_GRE))
+			return TC_ACT_SHOT;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L4_GRE;
+
 		if (bpf_skb_load_bytes(skb, off + len, &greh, sizeof(greh)) < 0)
 			return TC_ACT_OK;
 		switch (bpf_ntohs(greh.protocol)) {
@@ -634,6 +659,10 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 		break;
 	case IPPROTO_UDP:
 		olen += sizeof(struct udphdr);
+		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+						BPF_F_ADJ_ROOM_DECAP_L4_UDP))
+			return TC_ACT_SHOT;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L4_UDP;
 		if (bpf_skb_load_bytes(skb, off + len, &udph, sizeof(udph)) < 0)
 			return TC_ACT_OK;
 		switch (bpf_ntohs(udph.dest)) {
@@ -655,6 +684,35 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
 		return TC_ACT_SHOT;
 
+	kskb = bpf_cast_to_kern_ctx(skb);
+	shinfo = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
+	if (!shinfo->gso_size)
+		return TC_ACT_OK;
+
+	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
+	    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
+		return TC_ACT_SHOT;
+
+	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
+	    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
+		return TC_ACT_SHOT;
+
+	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
+	    (shinfo->gso_type & SKB_GSO_IPXIP4))
+		return TC_ACT_SHOT;
+
+	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
+	    (shinfo->gso_type & SKB_GSO_IPXIP6))
+		return TC_ACT_SHOT;
+
+	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+		if ((shinfo->gso_type & SKB_GSO_TUNNEL_MASK) && !kskb->encapsulation)
+			return TC_ACT_SHOT;
+		if (!(shinfo->gso_type & SKB_GSO_TUNNEL_MASK) && kskb->encapsulation)
+			return TC_ACT_SHOT;
+	}
+
 	return TC_ACT_OK;
 }
 
-- 
2.34.1


