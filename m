Return-Path: <netdev+bounces-278958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHprHTqW4GlMkAAAu9opvQ
	(envelope-from <netdev+bounces-278958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0D40B3D2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF31303DD15
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBA38C431;
	Thu, 16 Apr 2026 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="dMp9ET5t"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C637267E;
	Thu, 16 Apr 2026 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326157; cv=none; b=f1jgwT8eDH+6Cy3HkRkMa26GaYo27kFZKnAeHl3daI7Wszv+UrHj0uPDI8uPalJ1wqib0HHENGU+LOd76aKoBL5hyN3mzLGGrNDODSOK4o0LegKAur8K8+xk+2Qvt68YytBzi81P4cfZyoY+FVIpJqGVa2KXbv9koPtOpRLcYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326157; c=relaxed/simple;
	bh=wj0B9XnoeiSjT9OUedGk3dbAhADULSpsOmZbdeVYZsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMkDdqpKorYv5ggeUhlG+LMNoXDkL5QtL4Nllgiz6J9ar3JHmIjfk4217fWmmyh62lRGBOB1704NlAG66qWYj1LjVpXBwrXgnw3S+//tbWMLKKQJ+kZCv98QhaLFj6F+ZxRzcoAV2RiTuC6oynvrzC0pcWhNvVRXfa3UggsuNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=fail smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=dMp9ET5t; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G68NSg3779255;
	Thu, 16 Apr 2026 08:55:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=Of40J5Wnw
	9aBuZ0K80eVPgv5rPioXRjQOLCpWmNfeok=; b=dMp9ET5tzwM7IMV6oM+2SQJdC
	FxNE201EgB9irvYMsySjhtisR+r7qvDWRK/FwgqJRGODntWVBBjs1gEMfbzj8hJV
	5zLJm1hJu1qZdtNfaXbVdlTY3zLGdPWdRGkZrIzxBSmei1f8X5SCMJ6rjbG9NQkE
	QiZvcB9+H6V/0xuVpgtCQ21ONmPvlsD/M6+WVMV+EPc00dLAMT4brv/OzYrYWPu8
	fpkpPrKUxZNPo3F1ep7UHksoJjiwSavElD7ZVg1MpVhkbqMabbVQTXtBHuSS0feG
	6xnk7Ldivojv+BsG64kICqpcLHOMMi0ryYfs+e7VUklEk7wsYDIy5VwzUXPkg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4dfegxnmtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:55:29 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63G7QZWZ006738;
	Thu, 16 Apr 2026 03:55:27 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4dj2yvx0tq-1;
	Thu, 16 Apr 2026 03:55:27 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id A46D68D;
	Thu, 16 Apr 2026 07:55:25 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 5/6] bpf: clear decap tunnel GSO state in skb_adjust_room
Date: Thu, 16 Apr 2026 08:55:13 +0100
Message-Id: <20260416075514.927101-6-nhudson@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604160069
X-Authority-Analysis: v=2.4 cv=fKsJG5ae c=1 sm=1 tr=0 ts=69e095f1 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=5uIk5skAYop0meUMGpPt:22 a=X7Ea-ya5AAAA:8 a=1wbUKRMHqSFGxWi5NAsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MyBTYWx0ZWRfX98veyOSdwgzJ
 lenq9o1ehXTiReRM72WyH0rb2uItgmRgVgM4gO9munbDEjhyF3kUFt3heLwI1u4BEgi7XdF2euU
 RQ9aEAA5BUmxMacXEDQOWUpdrpIhwy3imFwpXkm0ZsID0cZLNch1WJ60+MyhF0o34hTWPCUUbvV
 hiAjTDeVfbDCfxG7TM/XrgqM4N3xCVvEVSHYU/RcNFfm6ydgLZJp9CASVihpLvijcadl066XL9D
 oyyViQS6t5hRW5KFk2aHVHXnSp5QEHNKIpzMY4GdEAfagC3uMuFxx5Olr4vDaHCBeUNvwZV9FeU
 kxwJSM+ceO9RBN9ZIZdCKFgWQ2u3oq+fipw6B5Ve3vLvTm2xYSWQLV9vhG8KdyefluFKXqSzkNe
 U6n4BRYN2sH1WKIT/ZfPdKpA79mbnG+dfAYLh6OSnRPwZ9L3SaqxZJSyJYhnZZcLnKbs9tzemS7
 KC+qIOObdoxi7jMT4Gw==
X-Proofpoint-GUID: TcZDaEQA-wgYGMQX3wOHrxGvP0UjW0-N
X-Proofpoint-ORIG-GUID: TcZDaEQA-wgYGMQX3wOHrxGvP0UjW0-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160073
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278958-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email,akamai.com:dkim,akamai.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 62F0D40B3D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
according to the decapsulation flags:

- BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}
- BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
- BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
- BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6

When all tunnel-related GSO bits are cleared, also clear
skb->encapsulation.

Handle the ESP inside a UDP tunnel case where encapsulation should remain
set.

If UDP decap is performed, clear encap_hdr_csum and remcsum_offload.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/filter.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7f8d43420afb..e113ae2f3f14 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3667,6 +3667,44 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
 			skb_increase_gso_size(shinfo, len_diff);
 
+		/* Selective GSO flag clearing based on decap type.
+		 * Only clear the flags for the tunnel layer being removed.
+		 */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
+		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+					 SKB_GSO_UDP_TUNNEL_CSUM)))
+			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
+					      SKB_GSO_UDP_TUNNEL_CSUM);
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
+		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
+			shinfo->gso_type &= ~(SKB_GSO_GRE |
+					      SKB_GSO_GRE_CSUM);
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP4))
+			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP6))
+			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
+
+		/* Clear encapsulation flag only when no tunnel GSO flags remain */
+		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+						  SKB_GSO_UDP_TUNNEL_CSUM |
+						  SKB_GSO_GRE |
+						  SKB_GSO_GRE_CSUM |
+						  SKB_GSO_IPXIP4 |
+						  SKB_GSO_IPXIP6 |
+						  SKB_GSO_ESP)))
+				if (skb->encapsulation)
+					skb->encapsulation = 0;
+
+			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
+				skb->encap_hdr_csum = 0;
+				skb->remcsum_offload = 0;
+			}
+		}
+
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= SKB_GSO_DODGY;
 		shinfo->gso_segs = 0;
-- 
2.34.1


