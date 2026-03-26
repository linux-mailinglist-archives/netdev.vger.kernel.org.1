Return-Path: <netdev+bounces-272123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDv+IxFbxWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:13:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01C33831D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F49A308F034
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14540626A;
	Thu, 26 Mar 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KTFDLZ29"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626084035B8
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540067; cv=none; b=drftxdZ/1HfX4UvM3ntAEebDoIlJ76l7EZsf2orjXxKqFPUA3pGM1/1AO58ZaToeKv4WwEWs+TBumNivW6FdEhGtGfnsVbdB0HrMHXHGLzHT3OvOWdIe1ifh50cesZP+uAc32mBfU5KclokCFYfsW/CVa3+F5fosZRuBt+zccmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540067; c=relaxed/simple;
	bh=BRIP1mTZDCMHEU04QrDwkcuyDCBEWWQgkhGzpNxjuEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhaLkqR7H6c6bY5fjXFgvXLg0R8YzFr1DU7NG8py7KKimztKZqU9rQ75b+zSngR8dZsTLUd/sklWbXKlyZ8YjCmCDnQONt8uUh4814GnnTIwfrjtNJXh9s51g7J2RikPvLonQ7bFUsE+AxKmoEVv+B+VZ0nHjxo7MxKzmuJ7V7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KTFDLZ29; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774540063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u347+uD3sb5mTEYMpGjCMcCICUQJttgR0qXNZxV+wWk=;
	b=KTFDLZ29KTVJC/qHcc4PdQSnoZfOKODzQ1soytx+KrSMFqQqb/DU6rYKAEoN/SdlNueg2Y
	INkHJdtAyBMkdV9EhLeMQIow8uyomMZ0oulASU6zNwSO+iQ4bfIbkaDk+YSgy9Nk4jyv6X
	MEOYKffPYzj/mGjtJvy+t5s1CxenGXQ=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v2 1/4] net: hsr: serialize seq_blocks merge across nodes
Date: Thu, 26 Mar 2026 16:47:12 +0100
Message-ID: <20260326154715.38405-2-luka.gejak@linux.dev>
In-Reply-To: <20260326154715.38405-1-luka.gejak@linux.dev>
References: <20260326154715.38405-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272123-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F01C33831D
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


