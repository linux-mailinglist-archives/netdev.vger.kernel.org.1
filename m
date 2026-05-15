Return-Path: <netdev+bounces-288324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P43HRkpB2ppsQIAu9opvQ
	(envelope-from <netdev+bounces-288324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:09:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DE7551085
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3581930363A8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D20481FC0;
	Fri, 15 May 2026 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="fmNcj47c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D6382F28
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853558; cv=none; b=PveOH00dvCQCCmDCeARyh9ledJn3FyvuQgs7QznlxnO1E7Hdjj3hk7I9hB/oD+0PnVIpaubhNcCj7t/Ifthrnex7aDwREAQe1R+0OcsioeiUJzYsikmKoYMLrh5VfKwyZlnYWdpW7lEzvLwGrg1yvrRxFrHT11i4M24K8v0VQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853558; c=relaxed/simple;
	bh=c2A8vEE2A3EOtpSYwg0f125Ondvt0pIyQEAXqLz0mvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2muJdOkW787qSg0THosX06ymJHL9J/dr7uH7WrBDjuAbTBLcTPFlZt+RvQHIWAnsKwPpsCH6q49vVEaOBvRfPokplDXHcqjmY6L/40ZCB00D1z1DQiRsT16/7fxjsJ8F96wwM4IZyO96rmM4ZMhupnO/57EemCAaegsGaXS3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=fmNcj47c; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so73861706d6.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853554; x=1779458354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PSh+GRhXVkv5mk3aFGVuPSlHgL1BMdkj34hW/QwWJ8g=;
        b=fmNcj47c5EueFa+UmKZs/YWQSZ82fffK5kruWWXcjecYBoiQfjUy6u4484nzTqEjcY
         UQ7QCe1oWs8LGt85+Y7j+imQZB8O+t5y/b2zATpSeTlZ74F0p9cJDGeehMCFN3im1djI
         mg6f4UIg1aLMw3t+Fp0nLOOqu/hi6X2P7AiHYnvn5Mfn/5F3O4C+0aobIMeky1HYi3Vl
         0BYeMn6G7vcFM4QsbK5I6Dac51H9NmYg6U6PSp0IoRZWLP3lk30wjN1+laMFY2kF5F4b
         ynpQ8OGXV40UmPGWaQMITicRCDp50d5yVDvYSieRJluq33Buddf0gZOkud/VZTDdGhTm
         6uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853554; x=1779458354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSh+GRhXVkv5mk3aFGVuPSlHgL1BMdkj34hW/QwWJ8g=;
        b=RztPP01Jk8raiql6wuYyGzPWn8CaS7izqoHNlil+KfcF1ju4fyUQ1LYAIxoTHK0nse
         ATojTaUd7CFFvGDeHnYvIdHG6NKgal+43C7ssMz2Nys6/LPdbB2Aph/RgRiWTl//buYp
         rxD7ZSyg0GRzaetg10MeJhp0tSSjc/a+j4MDBEbbu7FCO/QMhf+4GHLYlNXR2ktF3MjW
         HrQ+e3o1ODBRToUqyhNNpGMH5R5a6yMnr2RTekQmvy/qIkzkSDc3NeHVOe6QpPOz28a5
         pF1aJ8TnDwn1r9u7C1ojixiFGpzTI0R4BbzNtfW23Kw62M3E4/L5vlTtogKW1Vo4jB8A
         2xnQ==
X-Gm-Message-State: AOJu0YxZSU7dVJYeXMvd5m4iGQlJYeslmhkj9Q7j4liPD6kIFll6IRfR
	bnHX4mRtey79+lIBYB0qGP8eEaURqMZ1co9xKas0Pjn9PupFI16SuydQT7vfe09w/c/JkxjJPjz
	cricnOe4=
X-Gm-Gg: Acq92OHRSu0oX3tgPPJj1W9NOHn8QcgH2ow3cVyc0aiyvxa/tsVcNF8iIo7dJ6sPhHh
	464c7HLEnn3sbI6McpVQQeerbAvao5BNdRM8+0/2Tpn58hVmlE4tvav/+AxJmKaUPnj60Q+HrK7
	qZbjGLlKpsTXQV9kZmZ7uPh+6c+Sl5BUb57fzlgjgpeQ4SSFzIyktfXD5TepZRF6557TuHnpcVw
	9lHVishVfjfHZdlCu/8FnUChPYzH5sWW8KlqgOSIpMicZbxvDcdsYd9dhKVZ9vceg7MThyryQLT
	JbEtpQjz8lDjyl5pMrsoAIh9cOWeswbHrAXeRPZpCYjKSYMWKrymdJfxeet519WlAfAsvFaD6yk
	96VSztGA/HAA13YKpGjkTc2V53Mmr41oZ3LLT+eGTIuLN3jWYKNRdYQTTx88YGNgsgV4KfRZwco
	50BcwbRLcX/pjNc9IjZR101zVpRgJ0
X-Received: by 2002:a05:6214:600f:b0:899:fd8c:55c3 with SMTP id 6a1803df08f44-8ca0f690ff5mr65423206d6.22.1778853554129;
        Fri, 15 May 2026 06:59:14 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d19csm52839666d6.13.2026.05.15.06.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:13 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 02/11] net: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:09 -0400
Message-ID: <20260515135909.2238774-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23DE7551085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-288324-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bitbyteword.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,ovn.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bitbyteword.org:email,bitbyteword.org:mid,bitbyteword.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Action: no action

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 net/core/dev.c             | 2 +-
 net/core/xdp.c             | 2 +-
 net/openvswitch/actions.c  | 2 +-
 net/openvswitch/datapath.c | 2 +-
 net/sctp/outqueue.c        | 2 +-
 net/tipc/node.c            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8bfa8313ef62..12a583ce4d95 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6482,7 +6482,7 @@ void netif_receive_skb_list(struct list_head *head)
 		return;
 	if (trace_netif_receive_skb_list_entry_enabled()) {
 		list_for_each_entry(skb, head, list)
-			trace_netif_receive_skb_list_entry(skb);
+			trace_call__netif_receive_skb_list_entry(skb);
 	}
 	netif_receive_skb_list_internal(head);
 	trace_netif_receive_skb_list_exit(0);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..3003e5c57419 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 		xsk_pool_set_rxq_info(allocator, xdp_rxq);
 
 	if (trace_mem_connect_enabled() && xdp_alloc)
-		trace_mem_connect(xdp_alloc, xdp_rxq);
+		trace_call__mem_connect(xdp_alloc, xdp_rxq);
 	return 0;
 }
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 140388a18ae0..7b7c93c3bde4 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1260,7 +1260,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		int err = 0;
 
 		if (trace_ovs_do_execute_action_enabled())
-			trace_ovs_do_execute_action(dp, skb, key, a, rem);
+			trace_call__ovs_do_execute_action(dp, skb, key, a, rem);
 
 		/* Actions that rightfully have to consume the skb should do it
 		 * and return directly.
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index bbbde50fc649..f2b6688f18d6 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_buff *skb,
 	int err;
 
 	if (trace_ovs_dp_upcall_enabled())
-		trace_ovs_dp_upcall(dp, skb, key, upcall_info);
+		trace_call__ovs_dp_upcall(dp, skb, key, upcall_info);
 
 	if (upcall_info->portid == 0) {
 		err = -ENOTCONN;
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index f6b8c13dafa4..4025d863ffc8 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -1267,7 +1267,7 @@ int sctp_outq_sack(struct sctp_outq *q, struct sctp_chunk *chunk)
 	/* SCTP path tracepoint for congestion control debugging. */
 	if (trace_sctp_probe_path_enabled()) {
 		list_for_each_entry(transport, transport_list, transports)
-			trace_sctp_probe_path(transport, asoc);
+			trace_call__sctp_probe_path(transport, asoc);
 	}
 
 	sack_ctsn = ntohl(sack->cum_tsn_ack);
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 97aa970a0d83..6cfe4c40c82b 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1943,7 +1943,7 @@ static bool tipc_node_check_state(struct tipc_node *n, struct sk_buff *skb,
 
 	if (trace_tipc_node_check_state_enabled()) {
 		trace_tipc_skb_dump(skb, false, "skb for node state check");
-		trace_tipc_node_check_state(n, true, " ");
+		trace_call__tipc_node_check_state(n, true, " ");
 	}
 	l = n->links[bearer_id].link;
 	if (!l)
-- 
2.54.0


