Return-Path: <netdev+bounces-268587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAiaNBlGuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:16:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C292A9AD4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04F163033BE1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D283C13E1;
	Tue, 17 Mar 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="UdbUyQOo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCA3BF699;
	Tue, 17 Mar 2026 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749723; cv=none; b=oTrDooy1dmPO18rEwaZGXktrVgp8JFX3kAUiV/PKGAPgS52i1x9KvBZFQktERrIc4ZTlvOunwlwtoeDRE6QE54ySlyCPpXS1c2L68M+OhFJj9oPxYVy5R6fXS4nOVkR3awJm56OmuVxT5pBKLtVEK1wdnnNSc3k3OqeXXtqn8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749723; c=relaxed/simple;
	bh=YR2k2yLrOsSuceB5Cnn9pvx7r08O04mLrTzJpZs8Aio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5OGC7z5UVWRQwSO72vzzxrK0cm7uKiu+YioFZRrs2CbDw+2DIzgxrkFpUJUIstEoweMcxZynZBNn55zf7gp5Ic0W3r6Z9sgXmF6jKWfzlUzIESRtVSzSdQkSgrDDOyEqMUd6MgxCageIYa4P9iOUi8o2eHyZUdS1Nf20Y5qW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=UdbUyQOo; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62H9PlKY352828;
	Tue, 17 Mar 2026 12:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=WSb0ADp0J
	rbjQBZ7p37umbjBrTfay1dldOFhUtuxzso=; b=UdbUyQOof1qXeSnIJhZiCKgf6
	tawI7RjK9S8tZeYg3PhiKea5oGOzDrbNG8Ccbsy9sIt4JakifQYBozqjK4DvDeoZ
	9ddwrHXtzcAG4TBW1/omm9FS8YaiFLqVNx9UuZHtQXbd5nXlQPCmaFF1uKF7N8gK
	gS7a8hDYShK5cA+A2Ah2OtZ3XmG9/WFr6MN6wIu6jJSfkhS5uWK6yPknAgbkhVfq
	QrZX3bHBFgiokMlNzd9XbYD/CnvhECY93YEsAiFpsoDaOaSf94+HR3yIQamTHtLF
	AGnQOxBXBZZHxiF5J92I8CC/1+DwPNhK86wAEZ8p/YAST3sffS718dCtOe8Hg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4cwkf8r9tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:14:56 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62HC43Jg029048;
	Tue, 17 Mar 2026 08:14:56 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4cw30x2wwp-1;
	Tue, 17 Mar 2026 08:14:56 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 62D2A83;
	Tue, 17 Mar 2026 12:14:54 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] bpf: add helper masks for ADJ_ROOM decap flags
Date: Tue, 17 Mar 2026 12:14:27 +0000
Message-Id: <20260317121429.2399539-4-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317121429.2399539-1-nhudson@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603170107
X-Authority-Analysis: v=2.4 cv=SoSgLvO0 c=1 sm=1 tr=0 ts=69b945c0 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=KDzEjHMMTas96-nIEKpj:22 a=X7Ea-ya5AAAA:8 a=3XhTswxj0UAuUy2bmtcA:9
X-Proofpoint-GUID: __E4F7pG9uy0jNNJBJri1D7kmOcsIVm8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEwNyBTYWx0ZWRfX5nH+LhtDPMlh
 5Pu1xq31PDcF4D0NqpMt3z/VahLBj77M0nTL10ZatcCUGkOB641m2iNtCbLGu+Wx7tx6G2QiqDq
 FtJxeGv0j2xou0P3LkRD9MLnz53JaaitVkd9rgBlHjhyNKU8IQvO6ViiJSPe5xwSEtkMXMOB2/o
 xAmJHsyHhsni049A6xeUAz2KFwVaBpY19N4hPIU3xkfhtdDLdaj0HHu+GDVtk7WNsCETuSZwi2y
 uCt+GHxdJi+MnY4n2DWoVfRPhoUJS4Tzp6870TvBRaoiCgoCCaIcCaA1F9RIgy8rY6iYbghFfiC
 yClsM3dlbpyaU/57tAGERm6W8CD4mFk0+UT0ApikaLBYxKF8fk/uVYNHUOynQEQ5/t1+/72Lonc
 Zdje8jPoaQ+vc72bQxEjpHSz2OLq6K8kMIcPxWQN14+K8pzxI4DkkMili7bwaOhRnxxeDd7qUUd
 1Y0LjV6Pd/s97OQc/3A==
X-Proofpoint-ORIG-GUID: __E4F7pG9uy0jNNJBJri1D7kmOcsIVm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603170107
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268587-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,akamai.com:dkim,akamai.com:email,akamai.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A6C292A9AD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce helper masks for bpf_skb_adjust_room() decapsulation flags
to simplify validation and keep flag handling readable:

- BPF_F_ADJ_ROOM_DECAP_L4_MASK
- BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
- BPF_F_ADJ_ROOM_ENCAP_MASK
- BPF_F_ADJ_ROOM_DECAP_MASK

Also fold these masks into BPF_F_ADJ_ROOM_MASK and per-path flag
validation checks.

This is a refactoring/plumbing change; functional decapsulation and
GSO behavior updates are handled in later patches.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/filter.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0d5d5a17acb2..ac7e1068fe4c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3483,14 +3483,27 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
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
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
+
+#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
+					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_MASK | \
+					 BPF_F_ADJ_ROOM_NO_CSUM_RESET)
 
 static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			    u64 flags)
@@ -3502,6 +3515,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
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
@@ -3611,8 +3629,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 {
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
-			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
+	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
+			       BPF_F_ADJ_ROOM_FIXED_GSO |
 			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
 		return -EINVAL;
 
@@ -3708,8 +3726,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
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


