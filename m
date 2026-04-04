Return-Path: <netdev+bounces-275358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MnJMYr20GlyCwcAu9opvQ
	(envelope-from <netdev+bounces-275358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:31:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8814E39AF06
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42780300D6BC
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1F2236FD;
	Sat,  4 Apr 2026 11:31:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801902BD0B
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775302277; cv=none; b=EjPw6GXxg5W4S05j9jF2E9fbJGCJ/W4I9DB4XJMbA/2+L8HMKCLnTCiEgABVD21opbTZBUj8H+6OTg9RddS4DixRrwoq7CRQsRNvJFJIAghQDnan2qu80DIerobgbZcxjE3XG0T+VZ+2pi1kxnMML+DJpQpyscY7RF8t5KFOxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775302277; c=relaxed/simple;
	bh=IWnOiRGNhRT/prylB2A0OTWFcAtycTbn0M2ZRVgBMKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYI9Ucv6BhMNeUrKHZp95gsJjAsRql58/DuSnoGhig41gDaVq8Pg7BNnbhW708eqjhc2+m4wfEzAzA/bpXx9zUDqTLEmwqN6ls9U33kV2EJY0lUgYemTW0yXVjlLnibEk9LBpjLMnUGaUTGcVynhlIAC7HiC9oNA9yPP/1+5KlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from Draw.localdomain (unknown [172.23.146.222])
	by app2 (Coremail) with SMTP id zQmowAB3EIdl9tBpV8gxAA--.26820S2;
	Sat, 04 Apr 2026 19:30:45 +0800 (CST)
From: Ao Zhou <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yuqi Xu <xuyuqiabc@gmail.com>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Haoze Xie <royenheart@gmail.com>
Subject: [PATCH net v2 1/1] net: hsr: avoid learning unknown senders for local delivery
Date: Sat,  4 Apr 2026 19:30:47 +0800
Message-ID: <b053e938014c9bac22f7f687ecc2970f23a2b74a.1775281843.git.royenheart@gmail.com>
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
X-CM-TRANSID:zQmowAB3EIdl9tBpV8gxAA--.26820S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy3tF4Dury5tw1DWFyUKFg_yoW7tw1Upa
	s3Grn5ArZ7Jr1fCr40ya18Zr90yF1kGw429rW8A34IgrnrJFyYvFZxGF4qvFn5GrWkGFWY
	kF4qqr18Gw1DWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQUHCWnP4nwGMwABsG
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275358-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ti.com,ee.vjti.ac.in,gmail.com,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 8814E39AF06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoze Xie <royenheart@gmail.com>

Traffic that is directly addressed to the local HSR/PRP master can be
delivered locally without creating a persistent node entry. Learning one
node per previously unseen source MAC lets forged sender floods grow
node_db until the prune timer catches up.

Determine whether a frame is locally exclusive before node lookup and
skip learning for unknown senders in that case. When no node state
exists, also skip duplicate discard checks that depend on it.

This keeps locally-destined traffic reachable while avoiding node table
growth from source-MAC floods in both the PRP SAN path and the HSR/PRP
tagged sender paths.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
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
changes in v2:
- generalize the fix beyond PRP SAN traffic and cover HSR/PRP tagged sender floods
- decide whether learning is needed from local-exclusive delivery instead of protocol-specific SAN checks
- use the normal NULL return semantics from hsr_get_node() instead of ERR_PTR-based error plumbing
- skip duplicate-discard state checks when no node state exists

 net/hsr/hsr_forward.c  | 23 +++++++++++++----------
 net/hsr/hsr_framereg.c |  5 ++++-
 net/hsr/hsr_framereg.h |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba..15bd17b4ee17 100644
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
@@ -545,7 +546,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		/* Don't send frame over port where it has been sent before.
 		 * Also for SAN, this shouldn't be done.
 		 */
-		if (!frame->is_from_san &&
+		if (frame->node_src && !frame->is_from_san &&
 		    hsr->proto_ops->register_frame_out &&
 		    hsr->proto_ops->register_frame_out(port, frame))
 			continue;
@@ -688,21 +689,25 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		return -EINVAL;
 
 	memset(frame, 0, sizeof(*frame));
+	frame->port_rcv = port;
 	frame->is_supervision = is_supervision_frame(port->hsr, skb);
 	if (frame->is_supervision && hsr->redbox)
 		frame->is_proxy_supervision =
 			is_proxy_supervision_frame(port->hsr, skb);
 
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	check_local_dest(port->hsr, skb, frame);
+
 	n_db = &hsr->node_db;
 	if (port->type == HSR_PT_INTERLINK)
 		n_db = &hsr->proxy_node_db;
 
 	frame->node_src = hsr_get_node(port, n_db, skb,
-				       frame->is_supervision, port->type);
-	if (!frame->node_src)
-		return -1; /* Unknown node and !is_supervision, or no mem */
+				       frame->is_supervision, port->type,
+				       !frame->is_local_exclusive);
+	if (!frame->node_src && !frame->is_local_exclusive)
+		return -1;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	frame->is_vlan = false;
 	proto = ethhdr->h_proto;
 
@@ -720,13 +725,10 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 	}
 
 	frame->is_from_san = false;
-	frame->port_rcv = port;
 	ret = hsr->proto_ops->fill_frame_info(proto, skb, frame);
 	if (ret)
 		return ret;
 
-	check_local_dest(port->hsr, skb, frame);
-
 	return 0;
 }
 
@@ -739,7 +741,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	if (fill_frame_info(&frame, skb, port) < 0)
 		goto out_drop;
 
-	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
+	if (frame.node_src)
+		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
 	hsr_forward_do(&frame);
 	rcu_read_unlock();
 	/* Gets called for ingress frames as well as egress from master port.
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 50996f4de7f9..2bc6f8f154c2 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -221,7 +221,7 @@ void prp_update_san_info(struct hsr_node *node, bool is_sup)
  */
 struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 			      struct sk_buff *skb, bool is_sup,
-			      enum hsr_port_type rx_port)
+			      enum hsr_port_type rx_port, bool learn)
 {
 	struct hsr_priv *hsr = port->hsr;
 	struct hsr_node *node;
@@ -270,6 +270,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 			san = true;
 	}
 
+	if (!learn)
+		return NULL;
+
 	return hsr_add_node(hsr, node_db, ethhdr->h_source, san, rx_port);
 }
 
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index c65ecb925734..3d9c88e83090 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -33,7 +33,7 @@ void hsr_del_self_node(struct hsr_priv *hsr);
 void hsr_del_nodes(struct list_head *node_db);
 struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 			      struct sk_buff *skb, bool is_sup,
-			      enum hsr_port_type rx_port);
+			      enum hsr_port_type rx_port, bool learn);
 void hsr_handle_sup_frame(struct hsr_frame_info *frame);
 bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr);
 bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr);
-- 
2.53.0


