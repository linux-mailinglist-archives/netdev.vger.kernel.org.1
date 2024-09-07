Return-Path: <netdev+bounces-126166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D296FF3B
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 04:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200C41F23A43
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 02:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B647781;
	Sat,  7 Sep 2024 02:24:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF1C41C71
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675890; cv=none; b=XXMrzoCSmYZdNcyPo6dDOmHHBTU4CP55iEpszyts/3QrSTMZ8vMN/oBou/BAfYYHaxEXtiPVf3btVe8iUPb1QiVluoigSBejs15J9fKQNtNo6tcDRmEMhQvN5gpJxpLkuD2Kt/HTnj25AOUeRWQ22SExllMGwgVzFuJvDkQeEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675890; c=relaxed/simple;
	bh=rkGuWsuO+8UCBkpVBOs7O63AOg1Wud11r5j6J5nBVAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoDiUPpjnIN1fBuUkC6y+1k+lxjR/mIjXcMZOT8b93rZ+GFkTc5VZLwYQ1qdoPPIbYo8Iq3HUqnPuzwKuV4AuL+6Mv95PPI/kQ/qyKThf3U6xsQFBQo4svCa+Fx7O7Aafm4wN7HrMxFCQnEWmFF7uCbSKuPFjV0ZpG1yXXJs1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 269867D13C;
	Sat,  7 Sep 2024 02:24:48 +0000 (UTC)
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
Subject: [PATCH ipsec-next v11 13/16] xfrm: iptfs: add reusing received skb for the tunnel egress packet
Date: Fri,  6 Sep 2024 22:24:09 -0400
Message-ID: <20240907022412.1032284-14-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907022412.1032284-1-chopps@chopps.org>
References: <20240907022412.1032284-1-chopps@chopps.org>
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
index 9508c565c185..98ff553cd535 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -630,19 +630,20 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
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
 	net = xs_net(x);
 	first_skb = NULL;
+	defer = NULL;
 
 	seq = __esp_seq(skb);
 
@@ -769,25 +770,94 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
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
-		WARN_ON_ONCE(skb->len != capturelen);
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
+			WARN_ON_ONCE(skb->len != capturelen);
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
@@ -822,8 +892,19 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
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
+		WARN_ON_ONCE(skb == defer);
 		skb_list_del_init(skb);
 		if (xfrm_input(skb, 0, 0, -2))
 			kfree_skb(skb);
@@ -833,12 +914,15 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
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
+		WARN_ON_ONCE(!skb);
 		kfree_skb(skb);
 	}
 
-- 
2.46.0


