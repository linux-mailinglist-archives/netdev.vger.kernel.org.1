Return-Path: <netdev+bounces-279703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AREK9wD5mnqqQEAu9opvQ
	(envelope-from <netdev+bounces-279703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:45:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C3342981D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44B6830F8548
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4685D39B942;
	Mon, 20 Apr 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="DxguWQOu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40A38AC65;
	Mon, 20 Apr 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681699; cv=none; b=qKwGu4HP9iSCZmh7wL2QDSnopf+hRodGpl1/kugDM413xQD7t/Cu386QVzVzj+GSoPrn1bfMXv9bDsrBl5z/toqJa+sZh//Pkw+UYPgIHA500FavVIFK29AhLalsIoSY7kP3easRbNs37V+23eZRfGKlKC68rujhDfzvhskDV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681699; c=relaxed/simple;
	bh=QQ3g16h5A2ScaSGZq7cMSiDlwefFELwdXx+l8VMkO9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfK1+66Kj7BaS6AC8HyVBNVqYZmXFshQndnpbFm3zVm8kLhKteq5ujAw5LrR8HURQC5u/wVPcbZb2dIGf8JTH+fIkFBE/lVm8K6rSpdygZdO5Sc3qZq6nq+5X6vcbFEIe/Wmi+mDgTvw+9A4tZLpP9fXvDfuIDsPjtEguc9sU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=DxguWQOu; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409408.ppops.net [127.0.0.1])
	by m0409408.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 63K5rwhY1429513;
	Mon, 20 Apr 2026 11:41:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=F5YacMKKu
	D2bMrKo7gug8xWVYe6fIm4KuMzWaZDgsMM=; b=DxguWQOuA38OhJa+esmdFP2A5
	svXVdqQLzg8y7kiJuTMljHpBWNXuBDtvl93dwSd+Z+fGhCHQ/fLOGgV+GhJOku/+
	eC6Du7zIB6MvYw321LoZa3d7VeBwrDc+5L6DlHMkcgpczBfySyLqFehf4uJGi7IU
	AHG8ezBmyTrnIgCx/HFHXffuE8CNxTTv86zNR7Oi1USvaOEVXBe13WYcqgvEeOgA
	lnaleXkh4FPoSlCXlDL3Fj4zw++vQl9CvMSirynbvL0UUekFCfu0m5j9dwNxQnKZ
	5IFVYwfdzVvN1ncGC/pPXvDuIQqeUwTTiw40o2Ay2HLRlfehRxXTYI2/xFKIQ==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0409408.ppops.net-00190b01. (PPS) with ESMTPS id 4dmmv5dy8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:41:07 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63KABkFd011924;
	Mon, 20 Apr 2026 06:41:06 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4dm59tfe7c-1;
	Mon, 20 Apr 2026 06:41:06 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 6BC7A83;
	Mon, 20 Apr 2026 10:41:04 +0000 (UTC)
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
Subject: [PATCH v5 6/6] selftests/bpf: tc_tunnel validate decap GSO state
Date: Mon, 20 Apr 2026 11:40:51 +0100
Message-Id: <20260420104051.1528843-7-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420104051.1528843-1-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604200099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwMyBTYWx0ZWRfX64cK3cSTRqJK
 jX5RRCdTJ4S4TugFp7xUthtlTFphkjVHpuyAHEbBJOvypOKDecVb7SZxm3Bs4l3SQnwnTfR9LxR
 X+vtFKeE5D1wygKcX3WzaypgC8r1stzCCVKjhyrB0+aGznCsqtDRa5c3/eNU6PG6MKEe+Ij1JyJ
 sJ047H+q2+9GTlvtCilArErguH5pUyqB3zCBDdfrKEWf+143VYapfEAqdlEW4LvwhQ2ZK8QzZRK
 C7+aAKCj7OAz9MKaP8435RSE5cBmKGA/0CK6dRc17JJapP6V7zKkxnIJF/W1gEUotI53P7mD5x4
 1qEKPGHBqJob2VGqIGclOTkFxpNOkdDiweRz6z58QMeu78wegXWRpelBboEcs1lH4AGnAEP09a3
 /hO+1DMGIBHhit9LhQIiKeh3gDP2NknbiDL/fj5B46x3WcaP+3m6h44OLDhqn76VF3wX94hcum7
 ALpvT6eWFg9c1JxnudA==
X-Authority-Analysis: v=2.4 cv=GqdyPE1C c=1 sm=1 tr=0 ts=69e602c3 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=BYUV7c42er6_Rx9bq0XK:22 a=X7Ea-ya5AAAA:8 a=70DEBb0-UiQd8ec9lQUA:9
X-Proofpoint-ORIG-GUID: bQUvVOSb2dm9DgJhsCADXEi6U6CqCJ1X
X-Proofpoint-GUID: bQUvVOSb2dm9DgJhsCADXEi6U6CqCJ1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604170000 definitions=main-2604200103
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279703-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 55C3342981D
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
 .../selftests/bpf/progs/test_tc_tunnel.c      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 7376df405a6b..511022630bb1 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -6,6 +6,7 @@
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
 #include "bpf_tracing_net.h"
 #include "bpf_compiler.h"
 
@@ -37,6 +38,22 @@ struct vxlanhdr___local {
 
 #define	EXTPROTO_VXLAN	0x1
 
+#define SKB_GSO_UDP_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL |			\
+				 SKB_GSO_UDP_TUNNEL_CSUM)
+
+#define SKB_GSO_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL_MASK |		\
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
@@ -592,6 +609,8 @@ int __encap_ip6vxlan_eth(struct __sk_buff *skb)
 static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 {
 	__u64 flags = BPF_F_ADJ_ROOM_FIXED_GSO;
+	struct sk_buff *kskb;
+	struct skb_shared_info *shinfo;
 	struct ipv6_opt_hdr ip6_opt_hdr;
 	struct gre_hdr greh;
 	struct udphdr udph;
@@ -621,6 +640,11 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
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
@@ -634,6 +658,10 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
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
@@ -655,6 +683,35 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
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


