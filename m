Return-Path: <netdev+bounces-177046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95689A6D818
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B559316DBEB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5749325DAE4;
	Mon, 24 Mar 2025 10:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A443425DB1E
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810989; cv=none; b=L1q9xV3IHnij72bAZHSAq9AADK+l7riyt+FvB0J3oI1Bk8ckz5as60K/LY55hf5yY04pUYro74OVAueFm5CzpPjVkFhkd/7iYivASYdKqgaRmsAjkbZM77v+/qgtELRyFYExhl+re7DPQwI2X9Qfp4yqcihO+xYryxEkqmmOMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810989; c=relaxed/simple;
	bh=OOgpMdXazjbmLIqrB2lRz2uqIj2BxZXHX41hF4Ue2yE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VtwdXoJz4mLyGssGR8NZHZOU6QlJrjAdo1p+D1dXJGH1r4Bi0EtqF9RP+ucIzBzCNVnQG3Vv3pIivFKlykpP91oW3yaoc31EvSielo7/5NbdL+Z0vvKn6JP+spLHewCPyOygHnT24dh47bDO0yPelo67VPberjD9PVv3qJKWn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1742810926tla4hmf0
X-QQ-Originating-IP: MtxKjww700jc/ntmGKJuf0PdG8pNF/y25gD3I67gYkw=
Received: from wxdbg.localdomain.com ( [60.186.241.229])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Mar 2025 18:08:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11007348207255364183
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 1/2] net: libwx: fix Tx descriptor content for some tunnel packets
Date: Mon, 24 Mar 2025 18:32:34 +0800
Message-Id: <20250324103235.823096-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NYy4cmBavWt4rRKOJg2x3stDV5m/N/u9NTcQ2LcrlrfHyrm4Ql2QGS11
	HhS9z03KovQ5CfHCERii+zSs3ks+2xPkM5xu88YyMgGcNac74rIOgE8oO2uHFgNmRUrUsKu
	pK0mJnBYZHNW3kpYSgYWJihFywVk+Y7EzPRTek21Ps69naaKYXCKaB4GOVal+jpIzGLm6GP
	hMxYNfPw4VLOncEWn0wcPdvgJKpSQiKFhq5AdXhmHeeBDlpgJZO/8fVLtcPLFyC0mVPc9rM
	0aWEPEitM0msnHjx+Db1rWxkC41Mv0VjrdFB6pAS/pwqfeVH5KLj/7jeWnWGVslyKr+4Xw3
	qd97k//AaJ5KCgmG5gH5UXwVDstBkpuG3qztA5WmsGs0mHCVj7YL5PEyMuauVOQGl+C2hEw
	KuDIIPb+gBtnigQnN/+3I/w4ODiTjT3oCFfItIBaakZ/ipLd3eQi+8Mk91qcqSjjANA94hq
	BBuhgOmnrDgPnq/pQymJT931JHnQ7WjMbkP4RUNk7TY3sANz2+r+j8UDpqXaeefJgXYscQJ
	bUevewZOCtTI3SY4XKNica776P4PA3wdXtFebWDYZHc9dj2z1eM4j3n8nZWvqq7ha96Uiac
	XzZgsxrbWVIXaaE1fJepbQPyG9eVFJ8lG/6z5EyNNVD1GPQdpVuUwBQgWg/OHVaoUMZneVK
	2dNKIe0XESR+WnDOpfypa4Sf6FfC7byHk1PtVKHFmJVtEm8Pc7EPAWSSBJCeYbz7rqQW4cV
	Oh2MMnFFbqqqyn8hog/T7i654+MdtiNhR0hmmIrXYB41jnF+fvmAuO5nMSJtWQVfgVMbqZp
	hws+vs18GZN3w3yeyoUgm/fFQe2oT+nbfRu4bG2IFZEVnsVGqa3ieR0c3CAbUL4cKURfm5j
	UAmG2Tyv6jY0cicnf0wGfqAy6l1sI5uTYvbIGbT0BIqGydLZ9rK7A5dr6owUxeqMIVJ8JAV
	7EX+JmPRFWERM/945S3ieo6JMpjwUgXAi7hXN4P072ogdog5UAhbP2Fuar/f2BL181b/LlL
	FVzJ47shcHyTKYCGBr
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

The length of skb header was incorrectly calculated when transmit a tunnel
packet with outer IPv6 extension header, or a IP over IP packet which has
inner IPv6 header. Thus the correct Tx context descriptor cannot be
composed, resulting in Tx ring hang.

Fixes: 3403960cdf86 ("net: wangxun: libwx add tx offload functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 61 +++++++++++++--------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 2b3d6586f44a..9294a9d8c554 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1082,26 +1082,6 @@ static void wx_tx_ctxtdesc(struct wx_ring *tx_ring, u32 vlan_macip_lens,
 	context_desc->mss_l4len_idx     = cpu_to_le32(mss_l4len_idx);
 }
 
-static void wx_get_ipv6_proto(struct sk_buff *skb, int offset, u8 *nexthdr)
-{
-	struct ipv6hdr *hdr = (struct ipv6hdr *)(skb->data + offset);
-
-	*nexthdr = hdr->nexthdr;
-	offset += sizeof(struct ipv6hdr);
-	while (ipv6_ext_hdr(*nexthdr)) {
-		struct ipv6_opt_hdr _hdr, *hp;
-
-		if (*nexthdr == NEXTHDR_NONE)
-			return;
-		hp = skb_header_pointer(skb, offset, sizeof(_hdr), &_hdr);
-		if (!hp)
-			return;
-		if (*nexthdr == NEXTHDR_FRAGMENT)
-			break;
-		*nexthdr = hp->nexthdr;
-	}
-}
-
 union network_header {
 	struct iphdr *ipv4;
 	struct ipv6hdr *ipv6;
@@ -1112,6 +1092,8 @@ static u8 wx_encode_tx_desc_ptype(const struct wx_tx_buffer *first)
 {
 	u8 tun_prot = 0, l4_prot = 0, ptype = 0;
 	struct sk_buff *skb = first->skb;
+	unsigned char *exthdr, *l4_hdr;
+	__be16 frag_off;
 
 	if (skb->encapsulation) {
 		union network_header hdr;
@@ -1122,14 +1104,18 @@ static u8 wx_encode_tx_desc_ptype(const struct wx_tx_buffer *first)
 			ptype = WX_PTYPE_TUN_IPV4;
 			break;
 		case htons(ETH_P_IPV6):
-			wx_get_ipv6_proto(skb, skb_network_offset(skb), &tun_prot);
+			l4_hdr = skb_transport_header(skb);
+			exthdr = skb_network_header(skb) + sizeof(struct ipv6hdr);
+			tun_prot = ipv6_hdr(skb)->nexthdr;
+			if (l4_hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data, &tun_prot, &frag_off);
 			ptype = WX_PTYPE_TUN_IPV6;
 			break;
 		default:
 			return ptype;
 		}
 
-		if (tun_prot == IPPROTO_IPIP) {
+		if (tun_prot == IPPROTO_IPIP || tun_prot == IPPROTO_IPV6) {
 			hdr.raw = (void *)inner_ip_hdr(skb);
 			ptype |= WX_PTYPE_PKT_IPIP;
 		} else if (tun_prot == IPPROTO_UDP) {
@@ -1166,7 +1152,11 @@ static u8 wx_encode_tx_desc_ptype(const struct wx_tx_buffer *first)
 			l4_prot = hdr.ipv4->protocol;
 			break;
 		case 6:
-			wx_get_ipv6_proto(skb, skb_inner_network_offset(skb), &l4_prot);
+			l4_hdr = skb_inner_transport_header(skb);
+			exthdr = skb_inner_network_header(skb) + sizeof(struct ipv6hdr);
+			l4_prot = inner_ipv6_hdr(skb)->nexthdr;
+			if (l4_hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data, &l4_prot, &frag_off);
 			ptype |= WX_PTYPE_PKT_IPV6;
 			break;
 		default:
@@ -1179,7 +1169,11 @@ static u8 wx_encode_tx_desc_ptype(const struct wx_tx_buffer *first)
 			ptype = WX_PTYPE_PKT_IP;
 			break;
 		case htons(ETH_P_IPV6):
-			wx_get_ipv6_proto(skb, skb_network_offset(skb), &l4_prot);
+			l4_hdr = skb_transport_header(skb);
+			exthdr = skb_network_header(skb) + sizeof(struct ipv6hdr);
+			l4_prot = ipv6_hdr(skb)->nexthdr;
+			if (l4_hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data, &l4_prot, &frag_off);
 			ptype = WX_PTYPE_PKT_IP | WX_PTYPE_PKT_IPV6;
 			break;
 		default:
@@ -1269,13 +1263,20 @@ static int wx_tso(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 
 	/* vlan_macip_lens: HEADLEN, MACLEN, VLAN tag */
 	if (enc) {
+		unsigned char *exthdr, *l4_hdr;
+		__be16 frag_off;
+
 		switch (first->protocol) {
 		case htons(ETH_P_IP):
 			tun_prot = ip_hdr(skb)->protocol;
 			first->tx_flags |= WX_TX_FLAGS_OUTER_IPV4;
 			break;
 		case htons(ETH_P_IPV6):
+			l4_hdr = skb_transport_header(skb);
+			exthdr = skb_network_header(skb) + sizeof(struct ipv6hdr);
 			tun_prot = ipv6_hdr(skb)->nexthdr;
+			if (l4_hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data, &tun_prot, &frag_off);
 			break;
 		default:
 			break;
@@ -1298,6 +1299,7 @@ static int wx_tso(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 						WX_TXD_TUNNEL_LEN_SHIFT);
 			break;
 		case IPPROTO_IPIP:
+		case IPPROTO_IPV6:
 			tunhdr_eiplen_tunlen = (((char *)inner_ip_hdr(skb) -
 						(char *)ip_hdr(skb)) >> 2) <<
 						WX_TXD_OUTER_IPLEN_SHIFT;
@@ -1341,6 +1343,8 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 		vlan_macip_lens = skb_network_offset(skb) <<
 				  WX_TXD_MACLEN_SHIFT;
 	} else {
+		unsigned char *exthdr, *l4_hdr;
+		__be16 frag_off;
 		u8 l4_prot = 0;
 		union {
 			struct iphdr *ipv4;
@@ -1362,7 +1366,12 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 				tun_prot = ip_hdr(skb)->protocol;
 				break;
 			case htons(ETH_P_IPV6):
+				l4_hdr = skb_transport_header(skb);
+				exthdr = skb_network_header(skb) + sizeof(struct ipv6hdr);
 				tun_prot = ipv6_hdr(skb)->nexthdr;
+				if (l4_hdr != exthdr)
+					ipv6_skip_exthdr(skb, exthdr - skb->data,
+							 &tun_prot, &frag_off);
 				break;
 			default:
 				return;
@@ -1386,6 +1395,7 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 							  WX_TXD_TUNNEL_LEN_SHIFT);
 				break;
 			case IPPROTO_IPIP:
+			case IPPROTO_IPV6:
 				tunhdr_eiplen_tunlen = (((char *)inner_ip_hdr(skb) -
 							(char *)ip_hdr(skb)) >> 2) <<
 							WX_TXD_OUTER_IPLEN_SHIFT;
@@ -1408,7 +1418,10 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 			break;
 		case 6:
 			vlan_macip_lens |= (transport_hdr.raw - network_hdr.raw) >> 1;
+			exthdr = network_hdr.raw + sizeof(struct ipv6hdr);
 			l4_prot = network_hdr.ipv6->nexthdr;
+			if (transport_hdr.raw != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data, &l4_prot, &frag_off);
 			break;
 		default:
 			break;
-- 
2.27.0


