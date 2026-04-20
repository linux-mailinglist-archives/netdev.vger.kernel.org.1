Return-Path: <netdev+bounces-279702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P4lLsgD5mnuqQEAu9opvQ
	(envelope-from <netdev+bounces-279702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:45:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597A4297F1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0AFD30E660C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB939A072;
	Mon, 20 Apr 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="NipO0o/J"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B4388E60;
	Mon, 20 Apr 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681698; cv=none; b=OvtJn8zwkIHvVLTNkU2DEPMYhOQQonTDKTp1YNR0F1cZx4R7Rfur+Xk+0+yyya7rFwNyyEHEHGD0Ll8QC/QrU7eKhOqKK1EqDv4Dk+xeh3SZVRZHaQiI7udwWJgihOpGnL69jpAZH9j9jfWhF8omo7JVY30qtRnsy5mYeTxkw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681698; c=relaxed/simple;
	bh=AOrgGm18RpXJx6dzbMiEiZQi+s36OnXKGXf1n/IitNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AyvRBXymoHqkQnaY2oQQL0XMZH/tDJnkxfZ0TLL2nsk2xSUY/jwxY269/z9ABBL8/1Sf7mFbWYSxIGxIvB189uCRFCpQZQqvJxLyE533NwWOXtu7DKNAdjksYwrOXM7ZCq1lBn7s9Iw4kZ0dGG5kCWPD5dZhPzbCyiKjclvjzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=NipO0o/J; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 63K5xqpD3419076;
	Mon, 20 Apr 2026 11:40:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=ebf5Q0PaD
	nQoiYyhcMGVsZMGw3fN+UO6cglPFawnc8Q=; b=NipO0o/J5clhP4r2mPOdTf+/x
	PG7GNAm57szC0y9oLS91S6gl6IWBo2iZ2fWxXw3NaJeI121ie1tn//voGk7mRIsb
	dDKGKhwgw4/9GsHAac6Meb3nbVd6hRfBo3iyk4D2SJ9zSNQwtkTXOFx4ggiqn3gs
	KH/77urc3N/vFNvf3orP7y9Bt0LaKB2a2RpVfB/zweRzS4AStOnkEilVXxpWWOmq
	1ejpnE90f44Rdxn6yujal0lFJ/NNmXhjApUG7LmIlD3/lx0BBnfv4oiOmepeWVfr
	b2X+nPqWNSfifg57tzHh5BkAIJM23sf/1zh1CtuqqXAAlO/U3NUgwffZ4HdKw==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 4dm1g1fqmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:40:59 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63KAQiHV015214;
	Mon, 20 Apr 2026 03:40:58 -0700
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4dm7x673g6-1;
	Mon, 20 Apr 2026 03:40:57 -0700 (PDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id EADB583;
	Mon, 20 Apr 2026 10:40:55 +0000 (UTC)
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
Subject: [PATCH v5 2/6] bpf: refactor masks for ADJ_ROOM flags and encap validation
Date: Mon, 20 Apr 2026 11:40:47 +0100
Message-Id: <20260420104051.1528843-3-nhudson@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200101
X-Authority-Analysis: v=2.4 cv=R84z39RX c=1 sm=1 tr=0 ts=69e602bb cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=b_klpNw0ThsyXe4YF18s:22 a=X7Ea-ya5AAAA:8 a=XTcGtYan5i681LpXN6wA:9
X-Proofpoint-GUID: ciGikB8Tq1OCR7XC-HjLpTcsMGF37Zjs
X-Proofpoint-ORIG-GUID: ciGikB8Tq1OCR7XC-HjLpTcsMGF37Zjs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwMyBTYWx0ZWRfX1Gm0JZquDo5m
 sSN2Qc/02anc9Ldp9DptlEpx+nx2mw5IXkoVJQ714gDqjLyUEpEQfdnyBwComK2aEMoxhGbWGZL
 c/H/WjCNFBxV8hkVir01epmMFAhJ9Lhb9iPgqUfe5ZlKzQaERRDJnhCiCepInSHR9B2N+HUURCm
 pgsTahKiEamyw/ca3jenC6aavIC1dhZ6J9Po+c5uBVScL4MFXLFOH4LQDRvcgl850uiPxyxDSra
 0MfjHeb+XEBO7e46sI///9hEJ50Te7aNiX51eeVuWxqWrvcWeg1PHP1G4cm9/tGAb2YATpJiZeB
 X0EgVHOtXziWsl7JiU9TUvg7MbKuvZ/DrZHoXzS+iujuqvHc7Ru8xTv4aXvM+ZoaDvWmh7e3Jqw
 MAprCGH0v66lPrpkEsIgj77mDJMU2xudvc4FG7MkBqBAt+1QMFqPgswWOjYDWPVde8KyHF1l7wH
 AiQmHL3Fl4nGPl2Hp3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 classifier=typeunknown
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
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279702-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2597A4297F1
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


