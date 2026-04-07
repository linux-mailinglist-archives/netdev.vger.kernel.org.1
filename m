Return-Path: <netdev+bounces-275950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNrbEe3h1GnbyQcAu9opvQ
	(envelope-from <netdev+bounces-275950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:52:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E243AD429
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4701D305328A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B653AD502;
	Tue,  7 Apr 2026 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="hySYx7jM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778A3ACEFE;
	Tue,  7 Apr 2026 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559053; cv=none; b=LTxGcQORvXKJq6rIbZhszteaUzBKKmJegLHqqeBSJZY34LrwwQR7ShD31huslPE3niGyi7z2D/aRkjLe0BoJ7r1LqZHxzIRCWmecaJEMvN5mlzST0Z+Vmhzljh3huVGRWlr6bpA4nOlvQJUdOeGWEMDDyJdW0qeHerBt0j2pQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559053; c=relaxed/simple;
	bh=AOrgGm18RpXJx6dzbMiEiZQi+s36OnXKGXf1n/IitNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJrYI8Xca2E06qpI/zAJ823lBv5ecvqi/65uRv0Z04Fi7knFBxDRLXnqi5+wStFpQn0pBYQESCkWyS9ELlJ+3T4JoXiNNog/VbenXYOMLygeiPXlal9P7LqDRdccdnZBDQ2M1s46/cWU7m025cIlJdKK+NG1of23xn+rDPZPftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=hySYx7jM; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6379X39U353899;
	Tue, 7 Apr 2026 11:50:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=ebf5Q0PaD
	nQoiYyhcMGVsZMGw3fN+UO6cglPFawnc8Q=; b=hySYx7jMpJz2XrlWUP4yV3Ade
	p18hc34WR2vBXcmaTODQHDWocY+hvuB+al5PbsXz1ZlYeDJwgujh84W/FIj1lrzQ
	ByEv8mQ84s+ayOvZXX9OtYy+FMzDseZ1hZdVnGbFOcuSqTrc5QAWO4X5QuhFrmvE
	H/0hhXwRfYjiLlL042ix+8+YZrTyYLzZviIRUFNydwx4tidTKa0nqV+LOrmizQn0
	PfRf8jIWQahABwJgArnKryuSK6PjpKP8p9A3oXEgE6jmzzk2rBck7Iz/0mRV5fpp
	v3g0hi2/0jCQ7UqLBLxX8exjOBC3eyIBi6Z6sRRHxegpxTJPIjIA+C8IkIMcg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4datpggaja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 11:50:14 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 637Anuxp001030;
	Tue, 7 Apr 2026 06:50:13 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4dcmejac6t-1;
	Tue, 07 Apr 2026 06:50:13 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id B6E9884;
	Tue,  7 Apr 2026 10:50:11 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 2/6] bpf: refactor masks for ADJ_ROOM flags and encap validation
Date: Tue,  7 Apr 2026 11:50:01 +0100
Message-Id: <20260407105005.1639815-3-nhudson@akamai.com>
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
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604010000 definitions=main-2604070101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OSBTYWx0ZWRfX9079TLd4F2db
 logdyIE50rV5J9XEaE6GzfGF4iR3v4IOYijZQ68LSLgdBoH7JqpOAQg2BQiV0jXmVNMy3CgeJv8
 xfthn/nn5zbZxoBT+iJq3RpUfIU2yLzTXm9Is96cbMCgCrQvblSA5jVCbvmnRWJz2BrxDV4ebpG
 CHOaL5hg1/ur9RL9JO/L9+vV+nNxewJdLizA4RSpn7nCnP4Xqyhx7Oxo1Lgs2QCMiGwMOQQsP4W
 z7dxC4TXJfjxPTaF91iVI86jbfdEyJsXZ+OvA2Nb96caiKxzU+KBQkyPl11GtmXexktqnooYrBJ
 vnfgb61iZI+JB7CyN+4CVdDHF9HzaynJikKdJnFenBlvdbxcs5e6KtkEutKvGsbQtb3j+RQoiwg
 5uy4WNVwDsv2uMuziXKfCCvu5afUn3X5PP4GVcoZnY9gKGg7PtEp38R/FEUwavbz7mrriNM+4cF
 JdFaxvD8NaR5j3UgT0g==
X-Proofpoint-GUID: heXkUef39-R1NqMIfEDxbG2aQ8o94HOC
X-Proofpoint-ORIG-GUID: heXkUef39-R1NqMIfEDxbG2aQ8o94HOC
X-Authority-Analysis: v=2.4 cv=BNaDalQG c=1 sm=1 tr=0 ts=69d4e167 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4OENtXgxWbduB0e82o7S:22 a=X7Ea-ya5AAAA:8 a=XTcGtYan5i681LpXN6wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070099
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275950-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B4E243AD429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
validation logic and introduce:

- BPF_F_ADJ_ROOM_ENCAP_MASK
- BPF_F_ADJ_ROOM_DECAP_MASK

Refactor existing validation checks in bpf_skb_net_shrink()
and bpf_skb_adjust_room() to use the new masks (no behavior change).

This is in preparation for supporting the new decap flags.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
---
 net/core/filter.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..4e860da4381d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3490,14 +3490,19 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 
-#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
-					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
+#define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
-					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
-					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
+
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+
+#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
+					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_MASK | \
+					 BPF_F_ADJ_ROOM_NO_CSUM_RESET)
 
 static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			    u64 flags)
@@ -3618,8 +3623,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 {
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
-			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
+	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
+			       BPF_F_ADJ_ROOM_FIXED_GSO |
 			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
 		return -EINVAL;
 
@@ -3715,8 +3720,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	u32 off;
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
-			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
+	if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
 		return -EINVAL;
 	if (unlikely(len_diff_abs > 0xfffU))
 		return -EFAULT;
@@ -3735,20 +3739,20 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		return -ENOTSUPP;
 	}
 
-	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
+	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
 		if (!shrink)
 			return -EINVAL;
 
-		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
+		/* Reject mutually exclusive decap flag pairs. */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+			return -EINVAL;
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
 			len_min = sizeof(struct iphdr);
-			break;
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 			len_min = sizeof(struct ipv6hdr);
-			break;
-		default:
-			return -EINVAL;
-		}
 	}
 
 	len_cur = skb->len - skb_network_offset(skb);
-- 
2.34.1


