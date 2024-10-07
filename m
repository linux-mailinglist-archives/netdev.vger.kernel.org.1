Return-Path: <netdev+bounces-132710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8845992E19
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B52B24023
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B946A1D7984;
	Mon,  7 Oct 2024 13:59:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D6D1D5CDB
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309595; cv=none; b=sK7sgfQ3B/gkfLv7iP9eburFpDlHRI3mJdwYdaQQDKA+/SceHGrfi8gs1T5VXmZ7+49mM4R2Y01YTBkFchXmYfM36icznapRps3GS5rWkFEn+qWjZpw/UWUPdop2jO4JK1bVLg+FADgR3olrYgjg5dxJv/xMF0sT3MLBQc+i4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309595; c=relaxed/simple;
	bh=M6iJHhuRqZkhJMt/shuLWa/ze8dsS+yHwuOwMSswe7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POcTjTxuZbPA0Lne/pT66yd6JbtVuyZ84vDSshzJZoF3EbSwdKcRtgHUF7zjw2a9FgiXNuNuG3Q8g8Sp2rh9WjJy7rYAyenRGS4962hDGRxCKSZSYc2Zq0VSBJywDufsugLRcOoc/8fdvsgd81Y5nqkmO8dxUUq31k5NBSd4lJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id BD5A97D1D3;
	Mon,  7 Oct 2024 13:59:50 +0000 (UTC)
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
Subject: [PATCH ipsec-next v12 09/16] xfrm: iptfs: share page fragments of inner packets
Date: Mon,  7 Oct 2024 09:59:21 -0400
Message-ID: <20241007135928.1218955-10-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007135928.1218955-1-chopps@chopps.org>
References: <20241007135928.1218955-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

When possible rather than appending secondary (aggregated) inner packets
to the fragment list, share their page fragments with the outer IPTFS
packet. This allows for more efficient packet transmission.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 88 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index ce2861c6a045..627b10ed4db0 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/icmpv6.h>
+#include <linux/skbuff_ref.h>
 #include <net/gro.h>
 #include <net/icmp.h>
 #include <net/ip6_route.h>
@@ -90,6 +91,24 @@ struct xfrm_iptfs_data {
 static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu);
 static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me);
 
+/* ======================= */
+/* IPTFS SK_BUFF Functions */
+/* ======================= */
+
+/**
+ * iptfs_skb_head_to_frag() - initialize a skb_frag_t based on skb head data
+ * @skb: skb with the head data
+ * @frag: frag to initialize
+ */
+static void iptfs_skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
+{
+	struct page *page = virt_to_head_page(skb->data);
+	unsigned char *addr = (unsigned char *)page_address(page);
+
+	WARN_ON_ONCE(!skb->head_frag);
+	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
+}
+
 /* ================================= */
 /* IPTFS Sending (ingress) Functions */
 /* ================================= */
@@ -306,14 +325,44 @@ static struct sk_buff **iptfs_rehome_fraglist(struct sk_buff **nextp,
 	return nextp;
 }
 
+static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
+{
+	struct skb_shared_info *fromi = skb_shinfo(from);
+	struct skb_shared_info *toi = skb_shinfo(to);
+	unsigned int new_truesize;
+
+	/* If we have data in a head page, grab it */
+	if (!skb_headlen(from)) {
+		new_truesize = SKB_TRUESIZE(skb_end_offset(from));
+	} else {
+		iptfs_skb_head_to_frag(from, &toi->frags[toi->nr_frags]);
+		skb_frag_ref(to, toi->nr_frags++);
+		new_truesize = SKB_DATA_ALIGN(sizeof(struct sk_buff));
+	}
+
+	/* Move any other page fragments rather than copy */
+	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
+	       sizeof(fromi->frags[0]) * fromi->nr_frags);
+	toi->nr_frags += fromi->nr_frags;
+	fromi->nr_frags = 0;
+	from->data_len = 0;
+	from->len = 0;
+	to->truesize += from->truesize - new_truesize;
+	from->truesize = new_truesize;
+
+	/* We are done with this SKB */
+	consume_skb(from);
+}
+
 static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 {
 	struct xfrm_iptfs_data *xtfs = x->mode_data;
 	struct sk_buff *skb, *skb2, **nextp;
-	struct skb_shared_info *shi;
+	struct skb_shared_info *shi, *shi2;
 
 	while ((skb = __skb_dequeue(list))) {
 		u32 mtu = iptfs_get_cur_pmtu(x, xtfs, skb);
+		bool share_ok = true;
 		int remaining;
 
 		/* protocol comes to us cleared sometimes */
@@ -360,7 +409,7 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 
 		/* Re-home (un-nest) nested fragment lists. We need to do this
 		 * b/c we will simply be appending any following aggregated
-		 * inner packets to the frag list.
+		 * inner packets using the frag list.
 		 */
 		shi = skb_shinfo(skb);
 		nextp = &shi->frag_list;
@@ -372,6 +421,9 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 				nextp = &(*nextp)->next;
 		}
 
+		if (shi->frag_list || skb_cloned(skb) || skb_shared(skb))
+			share_ok = false;
+
 		/* See if we have enough space to simply append.
 		 *
 		 * NOTE: Maybe do not append if we will be mis-aligned,
@@ -399,18 +451,36 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 				}
 			}
 
+			/* skb->pp_recycle is passed to __skb_flag_unref for all
+			 * frag pages so we can only share pages with skb's who
+			 * match ourselves.
+			 */
+			shi2 = skb_shinfo(skb2);
+			if (share_ok &&
+			    (shi2->frag_list ||
+			     (!skb2->head_frag && skb_headlen(skb)) ||
+			     skb->pp_recycle != skb2->pp_recycle ||
+			     skb_zcopy(skb2) ||
+			     (shi->nr_frags + shi2->nr_frags + 1 > MAX_SKB_FRAGS)))
+				share_ok = false;
+
 			/* Do accounting */
 			skb->data_len += skb2->len;
 			skb->len += skb2->len;
 			remaining -= skb2->len;
 
-			/* Append to the frag_list */
-			*nextp = skb2;
-			nextp = &skb2->next;
-			WARN_ON_ONCE(*nextp);
-			if (skb_has_frag_list(skb2))
-				nextp = iptfs_rehome_fraglist(nextp, skb2);
-			skb->truesize += skb2->truesize;
+			if (share_ok) {
+				iptfs_consume_frags(skb, skb2);
+			} else {
+				/* Append to the frag_list */
+				*nextp = skb2;
+				nextp = &skb2->next;
+				WARN_ON_ONCE(*nextp);
+				if (skb_has_frag_list(skb2))
+					nextp = iptfs_rehome_fraglist(nextp,
+								      skb2);
+				skb->truesize += skb2->truesize;
+			}
 		}
 
 		xfrm_output(NULL, skb);
-- 
2.46.0


