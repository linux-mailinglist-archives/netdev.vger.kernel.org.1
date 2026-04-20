Return-Path: <netdev+bounces-279698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLhjKPoC5mmBqQEAu9opvQ
	(envelope-from <netdev+bounces-279698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:42:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845E4296A9
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A74AE305E2E2
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584D39A06E;
	Mon, 20 Apr 2026 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="McTQ0NbX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2638AC65;
	Mon, 20 Apr 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681685; cv=none; b=LuyMvHvc+XCbwUbZSNH/QPAJs437LITVRL/etSQE/dWDiw0ql6ShRx8MUjdNs59fglbM5JbFEavOhHef2/N40TX+/OvOPAhQ2QM8lp8oPBEAaIcoy4xrZkhl8jk3sytPF0hlhGn5i3tWfBTO19RM3lOnVAjsa6N5NtACPVV2SVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681685; c=relaxed/simple;
	bh=LAYjhP3oZzTAOdFhvjhAKzRL1X1YUV0ed7fbUAmPlJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHZisT+XnaI0/akwXsLcmfFnWK6DE7MFctf3KYyvbebG1bJWYFBUIhEtGwHmiiWcyQYPx3fTijepUDnr060KmWOIBZj0NVWgKb+WdHk37ROUGzOuXqpzhruvuCVV9VafSK8ArskTKHxs3q4kjlUEhu1b9D3xwcZakBuXMoLGK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=McTQ0NbX; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K908Ls268904;
	Mon, 20 Apr 2026 11:41:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=tR9zlPUE9
	OLIrT6Ka9u7VM5UW4su9y1h8WrE2pKiiKc=; b=McTQ0NbXyZIwvBuBJUbILSxV+
	fx3xtKOqiuCrbhxy4E1ONirsO8JgFYKAlyPfyuTMCs+y+eTk7Pz3ah5D6ZSjHHW4
	gOZ5mLxCI+cC2L5K6Vsl1sHWzJfRiZ8NRBbQqHw6K+qj0z1l+tg98oE9k538O6uN
	W9rlVpCPXL//N1N7jfg2jBzN4ORZLANx3X6c4xnqmV11F4YPnCO4kjVYUEhP+zJB
	RlpaYFlXpSRYzXBwooDKnNizdIWMwk7KdC+tJQwmrmPt8MuIHeaEcv7aYOrtM9/9
	4BQ7k5yF6R2/Q37jfWT+fz1AvPB2aNXMEnEPmlmP/+1TCoRY3mJPN0GkgcGMw==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4dkxtrdqxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:41:02 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63KAQkG3014388;
	Mon, 20 Apr 2026 06:41:02 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4dm59tfcfm-1;
	Mon, 20 Apr 2026 06:41:01 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 092968A;
	Mon, 20 Apr 2026 10:40:59 +0000 (UTC)
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
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] bpf: allow new DECAP flags and add guard rails
Date: Mon, 20 Apr 2026 11:40:49 +0100
Message-Id: <20260420104051.1528843-5-nhudson@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604200101
X-Proofpoint-GUID: iX5q0nSxX8Oaj1iOuO8BsU31E51oaFEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwMyBTYWx0ZWRfX1mMDyxp2jYac
 fhhpVpMf62+RVafMP8vU9PPgCNFNqtZN/3li81CpZJgAD6OFuqJCra09gw4UbDqoxRRY0PMbbKb
 JHFBCgG9ArRyaqdbdKtJGkWlQk6lqU8tI4Pu6iadgsyOdYDoUSeOLfdPTsM3CJLB5C36W5IvMYG
 M9ay8DxrCZhBgo4hgvweAlSvmvOcqfNVSvKOdyAp7KadAB4SDhKEtCI+omSrWgpYXhUzmhrpNUz
 bDnXLqDBQba6CXcaJJmZuyoEq+1PZwLo812BaWlg4lyfqQF1bwYWLyfv+b5PGSg/W5qv3xZC/Fy
 b0DNj/gipPoByDHfLe3ZuZCxElaBdUWBceM2l6wv2zapZYuwOzKM/1cm8miGqEDzRfdrBYL0HuU
 //l7/M2cO5ivvD0O6SHBLSpukjuaFnUEF2mK2w3BJ2ER7DcgP3RV19+s3JGxVy5xOPXuRD+ahW9
 QvSwt94vtUACGjnbJBA==
X-Authority-Analysis: v=2.4 cv=G70s1dk5 c=1 sm=1 tr=0 ts=69e602be cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=VcQvXEo1OZcA_IiPcy3B:22 a=X7Ea-ya5AAAA:8 a=Hfnf2daL9bryszF4jIsA:9
X-Proofpoint-ORIG-GUID: iX5q0nSxX8Oaj1iOuO8BsU31E51oaFEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604170000 definitions=main-2604200103
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
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279698-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
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
X-Rspamd-Queue-Id: 2845E4296A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add checks to require shrink-only decap, reject conflicting decap flag
combinations, and verify removed length is sufficient for claimed header
decapsulation.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/filter.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4e860da4381d..7f8d43420afb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -56,6 +56,7 @@
 #include <net/sock_reuseport.h>
 #include <net/busy_poll.h>
 #include <net/tcp.h>
+#include <net/gre.h>
 #include <net/xfrm.h>
 #include <net/udp.h>
 #include <linux/bpf_trace.h>
@@ -3490,6 +3491,12 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 
+#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+
+#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+
 #define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
@@ -3497,7 +3504,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
 
-#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
 
 #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
 					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
@@ -3740,6 +3749,8 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	}
 
 	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
+		u32 len_decap_min = 0;
+
 		if (!shrink)
 			return -EINVAL;
 
@@ -3748,6 +3759,37 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
 			return -EINVAL;
 
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
+			return -EINVAL;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
+			return -EINVAL;
+
+		/* Reject mutually exclusive decap tunnel type flags. */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
+		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
+			return -EINVAL;
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK)
+			len_decap_min += bpf_skb_net_base_len(skb);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
+			len_decap_min += sizeof(struct udphdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+			len_decap_min += sizeof(struct gre_base_hdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
+			len_decap_min += sizeof(struct iphdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+			len_decap_min += sizeof(struct ipv6hdr);
+
+		if (len_diff_abs < len_decap_min)
+			return -EINVAL;
+
 		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
 			len_min = sizeof(struct iphdr);
 
-- 
2.34.1


