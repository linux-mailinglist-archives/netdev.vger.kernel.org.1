Return-Path: <netdev+bounces-144709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88339C83C5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513B01F233B6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0F1F8F11;
	Thu, 14 Nov 2024 07:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB361F8934
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568059; cv=none; b=VdSyx6h0lz01w6/Js8rUfIAEcl1+apczZM3XXzhtVoQqJuAHvlnsgUuaJRSQbytPH1z9d2Jh/EGwV3BjqOrSVoZ6u+1Ztz7Dtb9BsVSnL9Vt7i2g5OsK8uI2AtZam3xXZwmiNdj8Xj9uiyvFjGT+JvIMl86DuFLf1eAzCU3RW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568059; c=relaxed/simple;
	bh=b5xQyP3s1s2E9yN+Ow8+riULqcHPQjmN7aslfx6gD38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFQlWShx3NgQe+nFlAMnjcKRG4lMDbJz/w472cQfllajYdFtobFLMGd8Ih5CZmlF0Q9jTjjV4OEh9PzSXlOCEUpKCMDFWfQ040pSOCvoL2Ux9mppj590oAthzO8exZO0tJneI7mCOcWjALPVG6nOu60I5CZxCJJAoay6NJCp/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 0E2D57D136;
	Thu, 14 Nov 2024 07:07:35 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v14 12/15] xfrm: iptfs: add reusing received skb for the tunnel egress packet
Date: Thu, 14 Nov 2024 02:07:09 -0500
Message-ID: <20241114070713.3718740-13-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114070713.3718740-1-chopps@chopps.org>
References: <20241114070713.3718740-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add an optimization of re-using the tunnel outer skb re-transmission
of the inner packet to avoid skb allocation and copy.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 123 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 15 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 4af1f7b5818e..8538fb02ae8a 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -601,12 +601,12 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 				    struct list_head *sublist)
 {
 	u8 hbytes[sizeof(struct ipv6hdr)];
-	struct sk_buff *first_skb, *next, *skb;
+	struct sk_buff *defer, *first_skb, *next, *skb;
 	const unsigned char *old_mac;
 	struct xfrm_iptfs_data *xtfs;
 	struct iphdr *iph;
 	struct net *net;
-	u32 remaining, iplen, iphlen, tail;
+	u32 first_iplen, iphlen, iplen, remaining, tail;
 	u32 capturelen;
 	u64 seq;
 
@@ -614,6 +614,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 	net = xs_net(x);
 	skb = skbseq->root_skb;
 	first_skb = NULL;
+	defer = NULL;
 
 	seq = __esp_seq(skb);
 
@@ -688,23 +689,92 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			skb_prepare_seq_read(save, data, tail, skbseq);
 		}
 
-		if (!first_skb)
+		if (first_skb) {
+			skb = NULL;
+		} else {
 			first_skb = skb;
+			first_iplen = iplen;
+
+			/* We are going to skip over `data` bytes to reach the
+			 * start of the IP header of `iphlen` len for `iplen`
+			 * inner packet.
+			 */
+
+			if (skb_has_frag_list(skb)) {
+				defer = skb;
+				skb = NULL;
+			} else if (data + iphlen <= skb_headlen(skb) &&
+				   /* make sure our header is 32-bit aligned? */
+				   /* ((uintptr_t)(skb->data + data) & 0x3) == 0 && */
+				   skb_tailroom(skb) + tail - data >= iplen) {
+				/* Reuse the received skb.
+				 *
+				 * We have enough headlen to pull past any
+				 * initial fragment data, leaving at least the
+				 * IP header in the linear buffer space.
+				 *
+				 * For linear buffer space we only require that
+				 * linear buffer space is large enough to
+				 * eventually hold the entire reassembled
+				 * packet (by including tailroom in the check).
+				 *
+				 * For non-linear tailroom is 0 and so we only
+				 * re-use if the entire packet is present
+				 * already.
+				 *
+				 * NOTE: there are many more options for
+				 * sharing, KISS for now. Also, this can produce
+				 * skb's with the IP header unaligned to 32
+				 * bits. If that ends up being a problem then a
+				 * check should be added to the conditional
+				 * above that the header lies on a 32-bit
+				 * boundary as well.
+				 */
+				skb_pull(skb, data);
+
+				/* our range just changed */
+				data = 0;
+				tail = skb->len;
+				remaining = skb->len;
+
+				skb->protocol = protocol;
+				skb_mac_header_rebuild(skb);
+				if (skb->mac_len)
+					eth_hdr(skb)->h_proto = skb->protocol;
+
+				/* all pointers could be changed now reset walk */
+				skb_abort_seq_read(skbseq);
+				skb_prepare_seq_read(skb, data, tail, skbseq);
+			} else {
+				/* We couldn't reuse the input skb so allocate a
+				 * new one.
+				 */
+				defer = skb;
+				skb = NULL;
+			}
+
+			/* Don't trim `first_skb` until the end as we are
+			 * walking that data now.
+			 */
+		}
 
 		capturelen = min(iplen, remaining);
-		skb = iptfs_pskb_extract_seq(iplen, skbseq, data, capturelen);
 		if (!skb) {
-			/* skip to next packet or done */
-			data += capturelen;
-			continue;
-		}
+			skb = iptfs_pskb_extract_seq(iplen, skbseq, data,
+						     capturelen);
+			if (!skb) {
+				/* skip to next packet or done */
+				data += capturelen;
+				continue;
+			}
 
-		skb->protocol = protocol;
-		if (old_mac) {
-			/* rebuild the mac header */
-			skb_set_mac_header(skb, -first_skb->mac_len);
-			memcpy(skb_mac_header(skb), old_mac, first_skb->mac_len);
-			eth_hdr(skb)->h_proto = skb->protocol;
+			skb->protocol = protocol;
+			if (old_mac) {
+				/* rebuild the mac header */
+				skb_set_mac_header(skb, -first_skb->mac_len);
+				memcpy(skb_mac_header(skb), old_mac, first_skb->mac_len);
+				eth_hdr(skb)->h_proto = skb->protocol;
+			}
 		}
 
 		data += capturelen;
@@ -735,6 +805,16 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		/* this should not happen from the above code */
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);
 
+	if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb) {
+		/* first_skb is queued b/c !defer and not partial */
+		if (pskb_trim(first_skb, first_iplen)) {
+			/* error trimming */
+			list_del(&first_skb->list);
+			defer = first_skb;
+		}
+		first_skb->ip_summed = CHECKSUM_NONE;
+	}
+
 	/* Send the packets! */
 	list_for_each_entry_safe(skb, next, sublist, list) {
 		skb_list_del_init(skb);
@@ -742,7 +822,20 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			kfree_skb(skb);
 	}
 done:
-	return false;
+	skb = skbseq->root_skb;
+	skb_abort_seq_read(skbseq);
+
+	if (defer) {
+		consume_skb(defer);
+	} else if (!first_skb) {
+		/* skb is the original passed in skb, but we didn't get far
+		 * enough to process it as the first_skb, if we had it would
+		 * either be save in ra_newskb, trimmed and sent on as an skb or
+		 * placed in defer to be freed.
+		 */
+		kfree_skb(skb);
+	}
+	return true;
 }
 
 /**
-- 
2.47.0


