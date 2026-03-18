Return-Path: <netdev+bounces-269019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N0KoJ/6sumlXagIAu9opvQ
	(envelope-from <netdev+bounces-269019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:47:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CAB2BC4BF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34632319E04D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6A3D902E;
	Wed, 18 Mar 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="mqVitglu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD83D88FF;
	Wed, 18 Mar 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841408; cv=none; b=NeFsgDw/gSr/dKe+5AsVdZX8WTYAKF3LmHDQ4PTub+DcJs1XrCZawI2oaZuigJsi29/wC5r3yppWrk446VQwLRb+sQJ4LDZxstp1+4IGSTgY9hYEfck1/D7AN8mNIKaR7BT5EDPd/HqgPhB3lEJqGYyTUCoS41/a7ZFTpwqzRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841408; c=relaxed/simple;
	bh=7wpJK37gGJUwkqcnZHAso/EJ02GstyH177HjlWuMiVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJtWiWxSNTl07jiCpcT1Tq1Kq+EBSMGa3ZGq7Tvy/OS8bUdcnPj8eVUVfRZcr+uh8OcSlZ0nGFnMuU9/EjWudBs2wDoa7CCNvKKP9OUV8WgzkkxSKRVFqu3t3R78yCBUxqijYx+IGdxxX0JLPH1ISqR9eZUOEuf5cPOyHUOyPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=mqVitglu; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IACnig1433748;
	Wed, 18 Mar 2026 13:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=LyUOrkLDE
	62lobhd6oHnz+13G6fDmM5nd9fZ0uk3NdA=; b=mqVitglueRhDGgwNKZtb+2v4K
	bpO5zrqIsteRRp5Md9SNmxnLpwU4WkB1fpkCt2/8jrQjZ09s8jkEXizzlRo6HbC3
	4O3TIdvl97NG+mMCFPIPsEgWWgiMdl5+jsTmG8pL93z3oUWU8QhFeV5i1Qi491gt
	hRfJITF2MlJLh34Y+XhTbwgTgzBb0t02HO6VcyL3iiRz/LW+GiYEo4fBNOjSHY4x
	Ye5zQOgkrA2u/iRuBNke2hwZlCPIKxwxcx2INCcLoySl0cGg8CYUcqVI4JSIlTqK
	7CwpLuh+FlFrsfbcOEK1wLKqhm2Ajv/Gknu7A0kqV0JcImh2CIrhbWLbz2RWA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4cw02h97ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 13:42:50 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62IDYAJh007188;
	Wed, 18 Mar 2026 09:42:49 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4cw30x86gf-1;
	Wed, 18 Mar 2026 09:42:49 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 0774D95;
	Wed, 18 Mar 2026 13:42:47 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and encap validation
Date: Wed, 18 Mar 2026 13:42:40 +0000
Message-Id: <20260318134242.2725749-4-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318134242.2725749-1-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603180115
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=69baabdb cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=5uIk5skAYop0meUMGpPt:22 a=X7Ea-ya5AAAA:8 a=4LiNFLUkBdZjVW18zIQA:9
X-Proofpoint-GUID: foJa9n91mHzRGVPPpteQN-KLp04LvpGg
X-Proofpoint-ORIG-GUID: foJa9n91mHzRGVPPpteQN-KLp04LvpGg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX5CbXo8D/FvdU
 tgETYQR6Lbj3O3R9bf1fb0WC/dczUnXyPwzhlFrB4/uKL/ByggQfAnot4rG/yErxol+Vpuh73qG
 1ct3ColS8t5Ru1XvMNFIlhFs/MAT7kw7DoiKss76XXz6H+Hr5g42ghCyUUZD9+5qqFvppLZY482
 n0YksG+C5uXvHXbhEjMPZg4D2RQaAQbZwIcqrFPcSdA7f6v5ghuUOuzv/m0leS58Jm+z+M7YBm6
 34rSFQgYR432L9vldsJwdyymSlQ/+PI79zS1UJKu63M6tk08yDe9c9N0YrbK5Q1a0DHdQvThvUS
 ByViYzUgg98CYV7aWxlsnNYcp8aaOKUItYO9fX1n4y1P/VGys3CE9FwDdT6YuM2FDqf9w2jC54O
 J9/Aj7mVwxd3MPeneQNLA2tx/IWVG1Z/XTb1/krsGcWTNGuqSZ1pTkJTHH1UZ1ltnWQ642KQG+w
 W1mvDI1+bCq9fXTkOuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603180116
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269019-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 01CAB2BC4BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce helper masks for bpf_skb_adjust_room() flags to simplify
validation logic:

- BPF_F_ADJ_ROOM_DECAP_L4_MASK
- BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
- BPF_F_ADJ_ROOM_ENCAP_MASK
- BPF_F_ADJ_ROOM_DECAP_MASK

Add flag validation to bpf_skb_net_grow() to reject invalid encap
flags early. Refactor existing validation checks in bpf_skb_net_shrink()
and bpf_skb_adjust_room() to use the new masks (no behavior change).

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/filter.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0d5d5a17acb2..7c2871b40fe4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3483,14 +3483,25 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 
-#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
-					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
+#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+
+#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+
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
@@ -3502,6 +3513,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	unsigned int gso_type = SKB_GSO_DODGY;
 	int ret;
 
+	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_ENCAP_MASK |
+			       BPF_F_ADJ_ROOM_NO_CSUM_RESET |
+			       BPF_F_ADJ_ROOM_FIXED_GSO)))
+		return -EINVAL;
+
 	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
 		/* udp gso_size delineates datagrams, only allow if fixed */
 		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
@@ -3611,8 +3627,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 {
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
-			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
+	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
+			       BPF_F_ADJ_ROOM_FIXED_GSO |
 			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
 		return -EINVAL;
 
@@ -3708,8 +3724,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	u32 off;
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
-			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
+	if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
 		return -EINVAL;
 	if (unlikely(len_diff_abs > 0xfffU))
 		return -EFAULT;
-- 
2.34.1


