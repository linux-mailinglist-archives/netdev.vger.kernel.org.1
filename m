Return-Path: <netdev+bounces-271100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDRsCD6hwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:35:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5630A3DB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 666863039B8C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7D3FE65E;
	Tue, 24 Mar 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XGeJChWS"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2813FD14A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362932; cv=none; b=pddbF+sFAWTCL57kLMJXC7VJ4+8MI1MLTw9PrM/XCKakmPNel2FzcFAej4kDjeH3GNTXwcHNyJvZGZ0ZKiTkyS9SeVpF25xTRV2jZpWO81DAKD7xDT8EkH+UWK5lZsO4Kj4//fk4Rma1aNJg9qCeKPEWAtF039aG+tR2dtr6D+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362932; c=relaxed/simple;
	bh=4hrUhnoaKveSU+PDlzp55IOc5xwLAeYrWhRrD4mc9Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/gijDMlMIefYY0tNIiYXVIlfYytX752g1ALCD7o/9R7BFv4mJ3n7mfSPsBRYuDmo+apY6ggCfEg/LUKzxYp0MbmxtLGMqDprB63jSLckSj2GypEytETuhf2W6Ijqp3JNMo7ROojLt98RDQs2bb2dFuTMy+mfXLvRf9hWsntuog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XGeJChWS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774362928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJnFrFlNIpZDRT68oQPN1Mvm05ZQfMpajX/85miZxDA=;
	b=XGeJChWSqL/bVm4CCPHTnh50ovC+FAdBC5S3MiZFOQl8wCyABtdpBGAughPVJj0/cCYy8E
	6ej8cBUadT/xQwiEom0h9lohQQj8nZObeh/asBxM32Wv325G0dW6bLLYSW3Olpr+y5YFar
	/uVe53YBiJpkdQAMDCiCaG0LwDNX4dE=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 1/4] net: hsr: serialize seq_blocks merge across nodes
Date: Tue, 24 Mar 2026 15:35:00 +0100
Message-ID: <20260324143503.187642-2-luka.gejak@linux.dev>
In-Reply-To: <20260324143503.187642-1-luka.gejak@linux.dev>
References: <20260324143503.187642-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linutronix.de,vger.kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271100-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EC5630A3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

During node merging, hsr_handle_sup_frame() walks node_curr->seq_blocks
to update node_real without holding node_curr->seq_out_lock. This
allows concurrent mutations from duplicate registration paths, risking
inconsistent state or XArray/bitmap corruption.

Fix this by locking both nodes' seq_out_lock during the merge.
To prevent ABBA deadlocks, locks are acquired in order of memory
address.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_framereg.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 577fb588bc2f..d09875b33588 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -123,6 +123,40 @@ static void hsr_free_node_rcu(struct rcu_head *rn)
 	hsr_free_node(node);
 }
 
+static void hsr_lock_seq_out_pair(struct hsr_node *node_a,
+				  struct hsr_node *node_b)
+{
+	if (node_a == node_b) {
+		spin_lock_bh(&node_a->seq_out_lock);
+		return;
+	}
+
+	if (node_a < node_b) {
+		spin_lock_bh(&node_a->seq_out_lock);
+		spin_lock_nested(&node_b->seq_out_lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock_bh(&node_b->seq_out_lock);
+		spin_lock_nested(&node_a->seq_out_lock, SINGLE_DEPTH_NESTING);
+	}
+}
+
+static void hsr_unlock_seq_out_pair(struct hsr_node *node_a,
+				    struct hsr_node *node_b)
+{
+	if (node_a == node_b) {
+		spin_unlock_bh(&node_a->seq_out_lock);
+		return;
+	}
+
+	if (node_a < node_b) {
+		spin_unlock(&node_b->seq_out_lock);
+		spin_unlock_bh(&node_a->seq_out_lock);
+	} else {
+		spin_unlock(&node_a->seq_out_lock);
+		spin_unlock_bh(&node_b->seq_out_lock);
+	}
+}
+
 void hsr_del_nodes(struct list_head *node_db)
 {
 	struct hsr_node *node;
@@ -432,7 +466,7 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 	}
 
 	ether_addr_copy(node_real->macaddress_B, ethhdr->h_source);
-	spin_lock_bh(&node_real->seq_out_lock);
+	hsr_lock_seq_out_pair(node_real, node_curr);
 	for (i = 0; i < HSR_PT_PORTS; i++) {
 		if (!node_curr->time_in_stale[i] &&
 		    time_after(node_curr->time_in[i], node_real->time_in[i])) {
@@ -455,7 +489,7 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 				  src_blk->seq_nrs[i], HSR_SEQ_BLOCK_SIZE);
 		}
 	}
-	spin_unlock_bh(&node_real->seq_out_lock);
+	hsr_unlock_seq_out_pair(node_real, node_curr);
 	node_real->addr_B_port = port_rcv->type;
 
 	spin_lock_bh(&hsr->list_lock);
-- 
2.53.0


