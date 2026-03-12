Return-Path: <netdev+bounces-267116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLR2GqPXsmlDQAAAu9opvQ
	(envelope-from <netdev+bounces-267116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:11:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC13273FBC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E250030588B6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3473C1966;
	Thu, 12 Mar 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="E7acLtoB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C23B9DA4
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327950; cv=none; b=DvCxhUpx6blNEyVDsspayfQLZ/1AMilAfuf0k4V0eWi8GCyvunK14v5dOQcER8Kr1nnGdB2gjopYDETzT3peTAVg0FDnT4ADvK+QQJZZGaYCuS54reOrNqnCYO5JJd2a0wi/3jB3QYvr/HjaCHWUOmT7Ox6xW7Iv7M7CXuoQi/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327950; c=relaxed/simple;
	bh=guxb5JuRwHt26SwsPKoWQpt9pRz3v9T6U6dLZoAc/AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQwbT3Sq2qYY+8cDPdm+vFFbaWHmLLSWM8hyagvdUtzD7dFinQUKltDdqFme8n56S4u+nA2xfLenljvTrtoO9MFtUoCKFY26n8m1W0nyxPZCqD2xh6k7zyrDrK29tGPyB3g5UiyWVbPRQWbUTpTWX5BxxtRAvzvwW3fw2J75mQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=E7acLtoB; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-467161c4b89so697205b6e.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327947; x=1773932747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0owfrX/RnsqtfciHeZROr5f5IRld381S+Ztj32xJcD4=;
        b=E7acLtoB8mTSc5rKgK+bcbcoNEW30IvGv1X5OTafcXa2xszBHSLO6ESNPg8lkFMH6E
         XwVwaqKbjjeXXjYHEj0zTphL8oUg0Ax0UdLbhlIAmFAUcl2bgBlcy0RBPxLhTWu8Hnyb
         4jHazNJmreWykfp4yNYGTS28OHAiGmAk2YFsnb6es7ZIe5DHlrmTtTC22ulHeJ72rF45
         yxjQ+vbXxJxnczKH0isIUCeXnrMJRRgsJmwTCHJUFXN+0n0G309wjzuaKJKxFW4fXFEM
         GNDQIlhKjv0NPLUM3CYDrBqAb+GyX7w13fVN3VpF+UKnrcHj9meKsF8oTEzq23X8QS14
         wJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327947; x=1773932747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0owfrX/RnsqtfciHeZROr5f5IRld381S+Ztj32xJcD4=;
        b=wKfgWHlTjr1VsOkt0rYsGq3/0tlN4dsNaUKllWJ5/aLIssUzgFXH4diN5aG8qfc1Do
         HCovTJsviuBOaiQmE5EqboLUufVmi0nONtxDQ8c4s/x6upKN+eya8vKJmoUSLGWT3aDR
         K20Kuq7FPnqEUysH4UzrX9s/zoJc99qkhJzR414pYgDFo4agsS1wc0zkOqZp/CTUTYJq
         0Cn64CfOpRe2I5E3SXS195l4KsBRn8s5JRt/BWJnD+urp4Uv/Xksucn0y0D5/f9GHrfC
         7oeaNYyDAqNJRa7dEeHb1NIMYEgzn/3Btg30t4z8uj65Ba+pob3ca8MG+7qQz1OxJxNo
         DlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnaAGawNv1FD22MZ1VQ3QnTO9UgP3Jns3W0RW2URDIRDxbJxHoKVqfx2zTeyaq9xecU83YiTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvycdOSuMPf63/kCNdLrk4vbmaBLaj7cJHC3jiXPFWTfUqvTF
	AKbfUxfNimoK4ku1wHkSjAGf8pyTGWzMR9eAc0YtjwzO+165/kJKkHs7vjrO2/P0pzo=
X-Gm-Gg: ATEYQzyfELKbyVVHFYVG670t95B+hkBwW1BENSFX+pHQN0eBP/sJ0gS9JAha1QO9ydv
	dBuwvy9FV3oU8f4uI5q1kvjBpAx5bW1g1lw0GHu6gHrzdO2ShUMgZoNxCKJ/uWQTZe09odBJXVe
	CBoamvhKUo8zN5oFG83KXyqQ5HcGZ89AWOzxL8ybMYP5OH6XAOlceQa+GQUijIHwxy9PCmXf3Ly
	FP265QWdV+sn5U+6/+UclTls77bkLSAQ6N1aLtCnLTzMdRjtbpH5HSx8jwmgruQRLXadv6LfAsY
	XRXeR65ZLXww9XKKafB6mtswtO0Z2XcviznSyA9vpj0X1SW+ukRhCVOsNW1v6+gKIAbv4V+XFn8
	DIlAo4SQTF3+ehsNyUiZPVWPmrmfBoK6o1xOU86+g73svY7kqlyFKC7WTyyoKvI0QR8Rjg+wcks
	lpKl0jSmZyGa9FDp6otYd3NmzgUK3ei3vAoIgqiRr+Wa+gI3wxspzcvYz4o7oOpbrDKw==
X-Received: by 2002:a05:6808:308c:b0:45e:69af:6bc6 with SMTP id 5614622812f47-467333c5d11mr5089686b6e.13.1773327946780;
        Thu, 12 Mar 2026 08:05:46 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:46 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 04/15] net: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:04:59 -0400
Message-ID: <20260312150523.2054552-5-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[bitbyteword.org,goodmis.org,infradead.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,ovn.org,vger.kernel.org,openvswitch.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-267116-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[bitbyteword.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6EC13273FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

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
index 14a83f2035b93..a48fae2bbf57e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *head)
 		return;
 	if (trace_netif_receive_skb_list_entry_enabled()) {
 		list_for_each_entry(skb, head, list)
-			trace_netif_receive_skb_list_entry(skb);
+			trace_invoke_netif_receive_skb_list_entry(skb);
 	}
 	netif_receive_skb_list_internal(head);
 	trace_netif_receive_skb_list_exit(0);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba7..53acc887c3434 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 		xsk_pool_set_rxq_info(allocator, xdp_rxq);
 
 	if (trace_mem_connect_enabled() && xdp_alloc)
-		trace_mem_connect(xdp_alloc, xdp_rxq);
+		trace_invoke_mem_connect(xdp_alloc, xdp_rxq);
 	return 0;
 }
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 792ca44a461da..420eb19322e85 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		int err = 0;
 
 		if (trace_ovs_do_execute_action_enabled())
-			trace_ovs_do_execute_action(dp, skb, key, a, rem);
+			trace_invoke_ovs_do_execute_action(dp, skb, key, a, rem);
 
 		/* Actions that rightfully have to consume the skb should do it
 		 * and return directly.
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b41..02451629e888e 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_buff *skb,
 	int err;
 
 	if (trace_ovs_dp_upcall_enabled())
-		trace_ovs_dp_upcall(dp, skb, key, upcall_info);
+		trace_invoke_ovs_dp_upcall(dp, skb, key, upcall_info);
 
 	if (upcall_info->portid == 0) {
 		err = -ENOTCONN;
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index f6b8c13dafa4a..9831afbff070f 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -1267,7 +1267,7 @@ int sctp_outq_sack(struct sctp_outq *q, struct sctp_chunk *chunk)
 	/* SCTP path tracepoint for congestion control debugging. */
 	if (trace_sctp_probe_path_enabled()) {
 		list_for_each_entry(transport, transport_list, transports)
-			trace_sctp_probe_path(transport, asoc);
+			trace_invoke_sctp_probe_path(transport, asoc);
 	}
 
 	sack_ctsn = ntohl(sack->cum_tsn_ack);
diff --git a/net/tipc/node.c b/net/tipc/node.c
index af442a5ef8f3d..01e07ec18c56c 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1943,7 +1943,7 @@ static bool tipc_node_check_state(struct tipc_node *n, struct sk_buff *skb,
 
 	if (trace_tipc_node_check_state_enabled()) {
 		trace_tipc_skb_dump(skb, false, "skb for node state check");
-		trace_tipc_node_check_state(n, true, " ");
+		trace_invoke_tipc_node_check_state(n, true, " ");
 	}
 	l = n->links[bearer_id].link;
 	if (!l)
-- 
2.53.0


