Return-Path: <netdev+bounces-275951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKTVJAzi1GnbyQcAu9opvQ
	(envelope-from <netdev+bounces-275951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:53:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ADA3AD465
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51807305DD14
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE6F3AE19E;
	Tue,  7 Apr 2026 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="LnZHVz5S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B903AA4E2;
	Tue,  7 Apr 2026 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559055; cv=none; b=QxfXlaarp828WJPaVBfTeVbVMCA9QNXH0a1lFhM+WHrsnE4W4HG2RFyZAJa/OTcxw65L2llDfmjRhRN3JPJtpLWUGg+Rni5+QIu/nY7cx0C2/5yAtYBA946po7rDVTgqzWe9RFAP2MmuJGIvNVGKYPCKhhtDzjBvApIiHTL/ftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559055; c=relaxed/simple;
	bh=1nxOWCvVhVLJxrNEAhQo//rSDUMpOGN+mm74aJAO0DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXD9zK41d4LOd6V/PGnEWdqXhQqadgzVWcib8iJByE8X8eEvRxW6SLlcJ6B+x0uig7NAUdo00LVSQoNxzD7M/rD1bCrXCdlrnyL6whasBL8peKTNsm1+mCPq2CcfyP90oaX22blhiLcOvxChBz6yoRAYxATQ/8JLAsyKJIGMgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=LnZHVz5S; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6379UM301006649;
	Tue, 7 Apr 2026 11:50:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=qkcLPcX1Y
	1ZicE4oz8QgaXDnvJeJIEpnpLV+KZs8YiA=; b=LnZHVz5SQ8qAIXQlSD+Cja9BD
	PXSrAq6fcZ39Mm4YEQI3JaeG3IlEVXx33DFgb5Bn+sCD19sHRD1H9u9WlI/VXqvy
	54uX6t6UpMXHitSLbPhXMIaBYvNCQXZnN0FHEKE3pc4THpPFXsQTbYl9+OF6kqtr
	Ure/4Pm2Lvy0WvKdh+MDM7BRiGt3wqqPDqMy+SKcpfVEBm5x7dEM85ChWRGWJnc7
	ZF5LYjVi1x0trPc9BTBysZExYNT4n4S5M0ggeg1RLJDFsWPIATyro308U2tshdoF
	Q7df8UVJqzgPADW2PJv7vibzi8JsChB7vBe81CxpOUnguYjidi/4JE5CaAjAA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4dasw68su1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 11:50:22 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 637Ao40E031921;
	Tue, 7 Apr 2026 06:50:21 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4dcmehtasj-1;
	Tue, 07 Apr 2026 06:50:21 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 338AD80;
	Tue,  7 Apr 2026 10:50:20 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: tc_tunnel validate decap GSO state
Date: Tue,  7 Apr 2026 11:50:05 +0100
Message-Id: <20260407105005.1639815-7-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407105005.1639815-1-nhudson@akamai.com>
References: <20260407105005.1639815-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604010000 definitions=main-2604070101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OSBTYWx0ZWRfXxWbM+zoqpr1t
 nqnYL61RwoRO4qoF4RzP+GT4cs/9XVzOUiykspAjOU9llg6KSNeWAadgRENFPpPqJmVTRMW/rot
 xBGJ9AxCG+c/JQZwfSovZtW2RLmK8tH0yI6GRErFUgavr4NEEdi0KzI1s3vaF7T/Xk+b69ZdI5K
 BOyQBew7B405gPBC089uxb7vlCOtcg3FyZ7XzhRLOus4dOHsy72hzUUBeDshAmuxBf9fuxipqdK
 8uIM8yRmtG3oORX6xGRcdUOOwTWB9n/6Y7kwT4mDMT3mhtahQ2d9kPsz3A98mM1fehyMXGWM12O
 FCUlOW84aJXSUs07zU9wOjZBPmAsvhq7zSIgJTzn8yp+F0CQopkof4ZvAWRsCld4rSKlMjuZvyK
 M4rHsU6hMYkd+VYSQByvB7NCGbwaaRv9cx76NeEcVtCVXXx/xPFJzBbKoY9aKcDcmHfXdVIiMjC
 DkM9fQe0XHdWZt2CFLg==
X-Authority-Analysis: v=2.4 cv=AsXeGu9P c=1 sm=1 tr=0 ts=69d4e16f cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=5uIk5skAYop0meUMGpPt:22 a=X7Ea-ya5AAAA:8 a=70DEBb0-UiQd8ec9lQUA:9
X-Proofpoint-ORIG-GUID: L1kAVrX94zOtIxW5JwcYFUHSAzBCp2pn
X-Proofpoint-GUID: L1kAVrX94zOtIxW5JwcYFUHSAzBCp2pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070099
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275951-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,akamai.com:dkim,akamai.com:email,akamai.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 54ADA3AD465
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


