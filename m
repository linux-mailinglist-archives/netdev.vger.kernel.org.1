Return-Path: <netdev+bounces-275947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAf6L4zh1GmZyQcAu9opvQ
	(envelope-from <netdev+bounces-275947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:50:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76A3AD3B2
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D456F3004D1C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED73A6409;
	Tue,  7 Apr 2026 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bI5WZPt4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0442F1FEA;
	Tue,  7 Apr 2026 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559045; cv=none; b=IupBXU2QBH8wekmk6bEcNg0JLZBKUK3EGS4Xe+y76yo/sbMeqoqnPipS6TUn0Tje363f3GsKzPqTvnHc92iUvHFL98SccOonmLHFkcDM4cCM4Bend0E8bkCL/kgO8NEd7k5FvfAVrfq5ayLA6yOVmBRNhDgwniigQmlHBCmO0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559045; c=relaxed/simple;
	bh=LAYjhP3oZzTAOdFhvjhAKzRL1X1YUV0ed7fbUAmPlJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSV7l1dDvDTQEHzD8uTbniCxFghuFl5QOC50qqgZi1HSz/wXBURaYsjekYW79fdO305iP+Z/3DCCP9JHaQrqsP72jzelvUKajROXN4HBf3zn8KIUHbQFBUhMaWzm/TVseOL8qhF31v2AdjOhtiXGm6z2esC/pwF3eD01Vm5X35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=bI5WZPt4; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 63760l5q890298;
	Tue, 7 Apr 2026 11:50:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=tR9zlPUE9
	OLIrT6Ka9u7VM5UW4su9y1h8WrE2pKiiKc=; b=bI5WZPt49jSUoKRvUNN+2FQFt
	E616fmHDrtXBzd8c7O3G0A+2gOx/yECX8QVg1W9vkT+kcnHYM2uCjtD9JS/mE7xM
	Uu1OC/3DbHjZwi1l4EINrEAwaEqzOcvOlbJne8gulA/ptp+IoTwvgHjhMEqowZ5Y
	xFfWZW7UVEaJVbF2nTHurnyfEbq24DdmArJuaUqb+dWMaxCSU32KjR3xM9xb4c3a
	kE9XsCeoyR1L41m127vFqoelZ+1hlCToG4IiY+AZ13NyBFO5Juib4OTRrRwNIZaJ
	TVYpPR7c+wSeTRpz7eh6fp1W9ZLd+5qAzBBZJC6GlwrjIxU3ItEoldSmmunoQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4dau25pp6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 11:50:18 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 637AoHsb001173;
	Tue, 7 Apr 2026 03:50:17 -0700
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4dcmehtbc3-1;
	Tue, 07 Apr 2026 03:50:17 -0700 (PDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id CAD2780;
	Tue,  7 Apr 2026 10:50:15 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 4/6] bpf: allow new DECAP flags and add guard rails
Date: Tue,  7 Apr 2026 11:50:03 +0100
Message-Id: <20260407105005.1639815-5-nhudson@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604010000 definitions=main-2604070101
X-Proofpoint-ORIG-GUID: JK9iwXZWTatNnLj4QjFY11gxv_6Zav35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OSBTYWx0ZWRfX7Yw4BHstzq50
 q9N1p14ZxlzBAS9U8hVrJxSOwhbHXvYBoBn+KMIXIeUYAu2yOQKfEBiUdzgx61YFOaoWhEOzcgq
 4/vwXDS48/O81s96YJv/GJzRsCWOmkg5vsnbV9Py7zUKmdJn6mbSz0FXPE3sZ/9k31bIBhngeIm
 rlDJNiO0JFMBZ9lk5Yo5c6OpK2fG0YT296mVfT/GdG9v066+GZeVUfpydcISY/FXzx44fafO1TW
 8bjLnq0nzlWbIudMi/V7CI1nHWV5b1ytbSlBQvujar61CG85wt9cSflFozaU9RQ9XEfrwXPTwD2
 +Z0MnVZClPf4niNMSyQo2OsHeEXqi83CWKgKyR/imdeN6nwJFrvACxIrJcVvdKQoA5cmnjMHRiL
 XThCDCqSq9CP1adEpJJncDwnOcweyoQohYpZQfqRt2tvdnV4JD2OHoSlJxc20DTAj/BEeCBj1dQ
 a+3S8ntUO0pQyBmPWMg==
X-Proofpoint-GUID: JK9iwXZWTatNnLj4QjFY11gxv_6Zav35
X-Authority-Analysis: v=2.4 cv=S7LpBosP c=1 sm=1 tr=0 ts=69d4e16a cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=8P__5Em-pwOPtXrf4HJ0:22 a=X7Ea-ya5AAAA:8 a=Hfnf2daL9bryszF4jIsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070099
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275947-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3C76A3AD3B2
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


