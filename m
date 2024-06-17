Return-Path: <netdev+bounces-104265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BBC90BC74
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD441C21B7A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5219A291;
	Mon, 17 Jun 2024 20:54:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF421993AF
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657665; cv=none; b=KQ+vpmgA2vV2mYECFF2x33+1IQwn3xOsXAKIF3rYrin0Ek2UR+pVJCO7l7d5qxiV/Jrp4IMl8fPeXJ3Wkx29cbqsoajKv5tgsTzpmc2fHftg0aWaK48CNevwE0dxg6gOqF8VZkhknhF91stXuIhcKJAIRbYXRqkTFS+0v03JUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657665; c=relaxed/simple;
	bh=AiGiJ1P3fOYpCslKS1giS+v5vGX8E5xPFt8tkbXFCX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRmPl/eDtvu72lxstSHEjEHuDWgigFnxi2oRtd6WJ53eosIbxH8G04cx9wM0zysLtrvvwPrcWeq5O/zm1N7T02hDrYQybUFoNVZqpomf4kYbrNpT3ksE8Ql+Ymw0t2LI7AdMetwIMv6CEMtq4k0Cvp2BXMTr4EHIANBd+mRlCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id DD6D77D12B;
	Mon, 17 Jun 2024 20:54:23 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v4 14/18] xfrm: iptfs: add reusing received skb for the tunnel egress packet
Date: Mon, 17 Jun 2024 16:53:12 -0400
Message-ID: <20240617205316.939774-15-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617205316.939774-1-chopps@chopps.org>
References: <20240617205316.939774-1-chopps@chopps.org>
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
 net/xfrm/xfrm_iptfs.c | 126 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 105 insertions(+), 21 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index a8ef3eb7427c..2a8781dbcc85 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -579,19 +579,20 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	struct ip_iptfs_cc_hdr iptcch;
 	struct skb_seq_state skbseq;
 	struct list_head sublist; /* rename this it's just a list */
-	struct sk_buff *first_skb, *next;
+	struct sk_buff *first_skb, *defer, *next;
 	const unsigned char *old_mac;
 	struct xfrm_iptfs_data *xtfs;
 	struct ip_iptfs_hdr *ipth;
 	struct iphdr *iph;
 	struct net *net;
-	u32 remaining, iplen, iphlen, data, tail;
+	u32 remaining, first_iplen, iplen, iphlen, data, tail;
 	u32 blkoff, capturelen;
 	u64 seq;
 
 	xtfs = x->mode_data;
 	net = dev_net(skb->dev);
 	first_skb = NULL;
+	defer = NULL;
 
 	seq = __esp_seq(skb);
 
@@ -719,25 +720,94 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 			skb_prepare_seq_read(save, data, tail, &skbseq);
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
+				skb_abort_seq_read(&skbseq);
+				skb_prepare_seq_read(skb, data, tail, &skbseq);
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
-		skb = iptfs_pskb_extract_seq(iplen, &skbseq, data, capturelen);
 		if (!skb) {
-			/* skip to next packet or done */
-			data += capturelen;
-			continue;
-		}
-		BUG_ON(skb->len != capturelen);
-
-		skb->protocol = protocol;
-		if (old_mac) {
-			/* rebuild the mac header */
-			skb_set_mac_header(skb, -first_skb->mac_len);
-			memcpy(skb_mac_header(skb), old_mac,
-			       first_skb->mac_len);
-			eth_hdr(skb)->h_proto = skb->protocol;
+			skb = iptfs_pskb_extract_seq(iplen, &skbseq, data,
+						     capturelen);
+			if (!skb) {
+				/* skip to next packet or done */
+				data += capturelen;
+				continue;
+			}
+			BUG_ON(skb->len != capturelen);
+
+			skb->protocol = protocol;
+			if (old_mac) {
+				/* rebuild the mac header */
+				skb_set_mac_header(skb, -first_skb->mac_len);
+				memcpy(skb_mac_header(skb), old_mac,
+				       first_skb->mac_len);
+				eth_hdr(skb)->h_proto = skb->protocol;
+			}
 		}
 
 		data += capturelen;
@@ -772,8 +842,19 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
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
 	list_for_each_entry_safe(skb, next, &sublist, list) {
+		BUG_ON(skb == defer);
 		skb_list_del_init(skb);
 		if (xfrm_input(skb, 0, 0, -3))
 			kfree_skb(skb);
@@ -783,12 +864,15 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	skb = skbseq.root_skb;
 	skb_abort_seq_read(&skbseq);
 
-	if (first_skb) {
-		consume_skb(first_skb);
-	} else {
+	if (defer) {
+		consume_skb(defer);
+	} else if (!first_skb) {
 		/* skb is the original passed in skb, but we didn't get far
-		 * enough to process it as the first_skb.
+		 * enough to process it as the first_skb, if we had it would
+		 * either be save in ra_newskb, trimmed and sent on as an skb or
+		 * placed in defer to be freed.
 		 */
+		BUG_ON(!skb);
 		kfree_skb(skb);
 	}
 
-- 
2.45.2


