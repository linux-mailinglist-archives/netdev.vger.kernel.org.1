Return-Path: <netdev+bounces-278974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO0nCyeh4GlukQAAu9opvQ
	(envelope-from <netdev+bounces-278974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F19840BBAE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997C9312DF44
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3674B387599;
	Thu, 16 Apr 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="YJHbmZXU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE413264CB;
	Thu, 16 Apr 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328807; cv=none; b=W6ypn29DARyQqOBByzMOCkq8pLb0ASuDbdP1jgk7KSjjhST36LfIMePEtTS8Cv0k5RzF/hfn9tojjmYGUKDDdVz+uCCACoIsrK7r3W48zoUYlMTlL4bbni/uqqe/RU9e5tWOiJIw/r6QEC16GB/MfGNOAU8pwNo6mNzO0CJEtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328807; c=relaxed/simple;
	bh=iw3pkpi0rpWv34W0Zy1IDNbxE46IPAKhAcqKQwIkudY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z7fLdT5BWr15T3ceKKv6gAwrEzkGxOvCTZ9f0Hgzt+dULkHzP/quIr8uQsLQHpDIrb+v3OsgXE5bzRoa9SFbrGph81mHvLxGltd/hsgKjYY/13OlkG6WvNW61teRbMGZQQouEIrduM2aj7z+QqBJcF9jle4Ah3iCMs2v8KOp9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=fail smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=YJHbmZXU; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 63G61iGL126706;
	Thu, 16 Apr 2026 08:55:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=tvzeqXY17
	UbphjoJsIOIquKsB7eKxzv9kuXvY8AZYjc=; b=YJHbmZXULp7LIMi4dPefFoNTo
	q58ECJrbdA98igfq4JRlz2J/s+g2rBuY9Fel4I2I5s3Zp1GCL8EOMCghOy6Yha7P
	SIVqO7tfVxw/cc7oA7zQTNak7S7uxyinKxJaVV+lQrhvhWtTLLqUhLMLB3ES/fHx
	op0zNHlWIwJEANxRlASMSoeDlr11sQ79VDYXRRZ7jmqRJVKRxga8fcxe8a5SR6iV
	ihLAF8ehzug7PP9i28k3eO0HnxZGsad5OqyxMLSUyU8l0cYE2Abxdf8CGHkh3fFg
	LfebAR2nPHx+biGwI1oLR/0XHPcQ0nlNkM1K2nPb5PIY7aUUWmXHGxPfFKzLA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4dfeq6ud2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:55:24 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63G7fdX0018471;
	Thu, 16 Apr 2026 03:55:23 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4dj2x560nc-1;
	Thu, 16 Apr 2026 03:55:23 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id A168991;
	Thu, 16 Apr 2026 07:55:21 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
Date: Thu, 16 Apr 2026 08:55:11 +0100
Message-Id: <20260416075514.927101-4-nhudson@akamai.com>
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
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=596 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604160071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MyBTYWx0ZWRfX0UTawQywIhZa
 W0m6a8Z7gVyby2bJr4QzUr3VJKvrEFVFOk3lB+H+tzNcmmj+bM40BualtRNabM2dylwcxRa4bZK
 R9MOkw1p+WSaa2zFxCHx8k+DXP8/XS3BP+Z5YdhhkyMQqqEM42/rfn0RVyysetMCdFHJ/xB6aXn
 hVHg16mMslV7I56RAGWHvDyTzRnjM2VC1218tBuCq7/VDq4dClMi25tWiT+E4V7z5xaJrsA2laE
 L51o8enY/mh4Lo0UeV9qFcJfw1LfwKiEp9oMv+n3H+QHSqW9lQOSKEKCaA58KzC9axBtRumqG2T
 cc4xZ5HRlWz9gVR6lj6z338yLaUgZi8GHzCno3ZFV8brriCulDnj2fIX7X4WiZvRdzqsF2havxs
 na7PrqWWoaoO6H5WdfyOti5I3GsVhQhoa+ZAB3N/lRPuaWbs069DSJGgufxTV9cV/qfR1z2JrXe
 n8FaA3fAMflyN5KQiuQ==
X-Proofpoint-ORIG-GUID: h1or0D8FYIWjHDVLTdqHAO2oRmRdJVcL
X-Authority-Analysis: v=2.4 cv=bsV8wkai c=1 sm=1 tr=0 ts=69e095ec cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=8P__5Em-pwOPtXrf4HJ0:22 a=X7Ea-ya5AAAA:8 a=KfGVUnEDJfcTcdlxACkA:9
X-Proofpoint-GUID: h1or0D8FYIWjHDVLTdqHAO2oRmRdJVcL
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278974-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
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
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F19840BBAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add new bpf_skb_adjust_room() decapsulation flags:

- BPF_F_ADJ_ROOM_DECAP_L4_GRE
- BPF_F_ADJ_ROOM_DECAP_L4_UDP
- BPF_F_ADJ_ROOM_DECAP_IPXIP4
- BPF_F_ADJ_ROOM_DECAP_IPXIP6

These flags let BPF programs describe which tunnel layer is being
removed, so later changes can update tunnel-related GSO state
accordingly during decapsulation.

This patch only introduces the UAPI flag definitions and helper
documentation.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 include/uapi/linux/bpf.h       | 34 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c021ed8d7b44..4a53e731c554 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3010,8 +3010,34 @@ union bpf_attr {
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
- *		  Indicate the new IP header version after decapsulating the outer
- *		  IP header. Used when the inner and outer IP versions are different.
+ *		  Indicate the new IP header version after decapsulating the
+ *		  outer IP header. Used when the inner and outer IP versions
+ *		  are different. These flags only trigger a protocol change
+ *		  without clearing any tunnel-specific GSO flags.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
+ *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
+ *		  when decapsulating a GRE tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
+ *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
+ *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
+ *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
+ *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
+ *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
+ *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
+ *		  or IPv4-in-IPv6).
+ *
+ *		When using the decapsulation flags above, the skb->encapsulation
+ *		flag is automatically cleared if all tunnel-specific GSO flags
+ *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
+ *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
+ *		removed from the packet. This handles cases where all tunnel
+ *		layers have been decapsulated.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -6221,6 +6247,10 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
+	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 };
 
 enum {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ca35ed622ed5..f4c2fbd8fe68 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3010,8 +3010,34 @@ union bpf_attr {
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
- *		  Indicate the new IP header version after decapsulating the outer
- *		  IP header. Used when the inner and outer IP versions are different.
+ *		  Indicate the new IP header version after decapsulating the
+ *		  outer IP header. Used when the inner and outer IP versions
+ *		  are different. These flags only trigger a protocol change
+ *		  without clearing any tunnel-specific GSO flags.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
+ *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
+ *		  when decapsulating a GRE tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
+ *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
+ *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
+ *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
+ *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
+ *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
+ *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
+ *		  or IPv4-in-IPv6).
+ *
+ *		When using the decapsulation flags above, the skb->encapsulation
+ *		flag is automatically cleared if all tunnel-specific GSO flags
+ *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
+ *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
+ *		removed from the packet. This handles cases where all tunnel
+ *		layers have been decapsulated.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -6221,6 +6247,10 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
+	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 };
 
 enum {
-- 
2.34.1


