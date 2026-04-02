Return-Path: <netdev+bounces-274575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JkXHY58zmnBnwYAu9opvQ
	(envelope-from <netdev+bounces-274575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:26:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BE638A7A1
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF4D9310CC06
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FA3EDAA0;
	Thu,  2 Apr 2026 14:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F6396D1B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139523; cv=none; b=Q2FQUEiTeXRZ/c7XsGKAv7izA1xWuMYCASTahdvp7p9ohR3FWmexstDyO6mJleCF8vNVdIr7+n+Hr9oK2BkFxJwXYi8HKE7sMwM1s6LewexVVSeo+/pQu0/2ga2qSCmj5yWAE3gRwYkaUfxHPCs2TTMOuvkS6hccqUGKZtLLPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139523; c=relaxed/simple;
	bh=bz9rAVsx+xcLaoo9qheWN6CB+zwEoZYFRgIT3yUQDdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0/1d/lJkCznYbYufaYJkI6nsrEpd6ugmcy6+IiDvP/DnJeIgKnpc7rv5NGEt3YVPgwfZrN4aKt9cp/OEIwbUVyexKv+H5nboaEFGll3NBxg/Tu3R4lgLjTpU1Tsv/dMTaoebkygdVDP9TN93y6d5/qZBMZ6vbcrotq9urVtGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from Draw.localdomain (unknown [172.23.236.123])
	by app2 (Coremail) with SMTP id zQmowABX7oSmes5pNmswAA--.18793S2;
	Thu, 02 Apr 2026 22:18:14 +0800 (CST)
From: Ao Zhou <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yuqi Xu <xuyuqiabc@gmail.com>,
	Ao Zhou <n05ec@lzu.edu.cn>
Subject: [PATCH 1/1] net: hsr: avoid learning nodes from ordinary PRP SAN traffic
Date: Thu,  2 Apr 2026 22:18:14 +0800
Message-ID: <9c88b4b7844f867d065e7a7aba28b2c026386168.1775056603.git.royenheart@outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775056603.git.royenheart@outlook.com>
References: <cover.1775056603.git.royenheart@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowABX7oSmes5pNmswAA--.18793S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW3Jr1UAryUZr48CF1rJFb_yoWrXryxpa
	yfGrn5JrWktr17CrW0ya18ZrsIyF1kGw47KrWrA3s2vrnrJFyYvFZxKF90vF1rCrW8WFWa
	yF40qrs5uw1DXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9S1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0pRpOJnUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQQFCWnNP3wXiAAAsx
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274575-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ti.com,ee.vjti.ac.in,linutronix.de,gmail.com,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:mid]
X-Rspamd-Queue-Id: 37BE638A7A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoze Xie <royenheart@gmail.com>

PRP slave ports accept ordinary SAN traffic and forward it to the
master device without needing a persistent node entry. Creating one
node per previously unseen SAN source lets arbitrary source MAC floods
grow node_db until the prune timer catches up.

Keep the receive path for ordinary PRP SAN traffic, but stop learning a
new node when the frame is untagged and does not carry a PRP trailer.
Continue to deliver the frame locally and only keep node state for
actual HSR/PRP senders or nodes that have already been learned.

Fixes: 451d8123f897 ("net: prp: add packet handling support")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
---
 net/hsr/hsr_forward.c  | 14 ++++++++++----
 net/hsr/hsr_framereg.c | 16 +++++++++++++---
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba..5fbfc42997d2 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -403,7 +403,8 @@ static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
 	int res, recv_len;
 
 	was_multicast_frame = (skb->pkt_type == PACKET_MULTICAST);
-	hsr_addr_subst_source(node_src, skb);
+	if (node_src)
+		hsr_addr_subst_source(node_src, skb);
 	skb_pull(skb, ETH_HLEN);
 	recv_len = skb->len;
 	res = netif_rx(skb);
@@ -699,8 +700,12 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 
 	frame->node_src = hsr_get_node(port, n_db, skb,
 				       frame->is_supervision, port->type);
-	if (!frame->node_src)
-		return -1; /* Unknown node and !is_supervision, or no mem */
+	if (IS_ERR(frame->node_src)) {
+		ret = PTR_ERR(frame->node_src);
+		if (ret != -ENOENT)
+			return ret;
+		frame->node_src = NULL;
+	}
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	frame->is_vlan = false;
@@ -739,7 +744,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	if (fill_frame_info(&frame, skb, port) < 0)
 		goto out_drop;
 
-	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
+	if (frame.node_src)
+		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
 	hsr_forward_do(&frame);
 	rcu_read_unlock();
 	/* Gets called for ingress frames as well as egress from master port.
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 50996f4de7f9..13e1a0484879 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -230,7 +230,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	bool san = false;
 
 	if (!skb_mac_header_was_set(skb))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
@@ -263,14 +263,24 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
 		/* Check if skb contains hsr_ethhdr */
 		if (skb->mac_len < sizeof(struct hsr_ethhdr))
-			return NULL;
+			return ERR_PTR(-EINVAL);
 	} else {
 		rct = skb_get_PRP_rct(skb);
 		if (!rct && rx_port != HSR_PT_MASTER)
 			san = true;
 	}
 
-	return hsr_add_node(hsr, node_db, ethhdr->h_source, san, rx_port);
+	/* PRP accepts ordinary SAN traffic on slave ports without learning a
+	 * persistent node entry.
+	 */
+	if (hsr->prot_version == PRP_V1 && san)
+		return ERR_PTR(-ENOENT);
+
+	node = hsr_add_node(hsr, node_db, ethhdr->h_source, san, rx_port);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	return node;
 }
 
 static bool hsr_seq_block_is_old(struct hsr_seq_block *block)
-- 
2.53.0


