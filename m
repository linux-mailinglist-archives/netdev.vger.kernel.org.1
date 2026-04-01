Return-Path: <netdev+bounces-274004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKTdAhjmzGk/XwYAu9opvQ
	(envelope-from <netdev+bounces-274004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:32:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5BC377ADD
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A35BD3007AF7
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B463CF03F;
	Wed,  1 Apr 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EegHlCAs"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA939D6DF
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035396; cv=none; b=YREHZH+b7Se/QGtsko0uyp61w2jHIChNlJNjuO16N0ot1fwAa7FLi4InXAJxlb3MlaCTvGbASx8ZMdh/WqLRLExNOkdm67Cd99JR79mykuL2bYbT4PRqr945HOy1WzHmM/dCedGR/PLYbDfIg9S9EjGBdfAZMukK43jLeudFs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035396; c=relaxed/simple;
	bh=K77RlsEOnbuhsPup9QSM3W7r/ZHubGumAhuhZBZI0UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqYkKBNB2ZPE1G5vhKs7vPaF+W4tUPg6uoD/0BHhHBjY3AXyFHSaEYp/aSqCm2wLbVAu8vm602gN0Gf1fuzUrw/La15BqIYKOktX9PnIz+IiH+Inkl2kp/CM18tiACqJTEq2bquV5kxpDudinVHf+buw7klWjJRy1pFH7xTw3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EegHlCAs; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775035392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2U1CQnu9moxg0nSfdTTomTczpDKsKCthwKFYI2PMK78=;
	b=EegHlCAsrkIEavmwPntyUtFdoPqjHodcXg49fwCaxr7W6HjbjHhzfUI3n/l+2uAQLQgZFY
	myxEdOnJDV2zyVO8nOhyo0DzPASyZTqkiTz5o54pqJb4dknHoIb1EwWNpFDB4H3muz0lIE
	Blc9W152ijMHRe6RlVUNmoMGRhzQTMg=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	bigeasy@linutronix.de,
	m-karicheri2@ti.com,
	luka.gejak@linux.dev
Subject: [PATCH net v4 1/2] net: hsr: serialize seq_blocks merge across nodes
Date: Wed,  1 Apr 2026 11:22:42 +0200
Message-ID: <20260401092243.52121-2-luka.gejak@linux.dev>
In-Reply-To: <20260401092243.52121-1-luka.gejak@linux.dev>
References: <20260401092243.52121-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-274004-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F5BC377ADD
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

Reviewed-by: Felix Maurer <fmaurer@redhat.com>
Fixes: 415e6367512b ("hsr: Implement more robust duplicate discard for PRP")
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


