Return-Path: <netdev+bounces-270602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPl/AIdwwWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:55:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B752F91C7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E05C307E7C3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7143BA243;
	Mon, 23 Mar 2026 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="tCiidTFQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CE3B8BCF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281677; cv=none; b=EyRQ5ejvc2CWr06hxiv2sut6PSX98dsPrHepWbumHuKCSEafwWSF4wcJxnM7XgoWl+uK+jOv//pdJx8ZCjX09iPiISUtlP6kg61e28QLXglOkZg2zsbNs7twO0BnhlITHu0hP2PP/EjhEXPAyWyoRrW0GxiLviSExm+fU2LcMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281677; c=relaxed/simple;
	bh=xyAGaEXQZTWs4DlMf28kBT1WbT71fLVTUKX8/OJIrfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW45t5hNlWhEck7SETnVBX7QRsFCS8XrW1pELB+IIvtCkoL/Ru6lzKFMYbgdELUIxFDiJrS2GI2VVb82cY5RWTUMsVwoqgykfmOe5PjWXZi7Uo13hGXSwK3ffLo+ZwPAOEbs0p8pAELjbh8lvuG368cWwhLZ9dclTTtjC1o19qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=tCiidTFQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfc497a604so456931485a.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281675; x=1774886475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzezBvlbzIGXplopQPhzXRTVv1p4U7sUNeKcBaGOoCw=;
        b=tCiidTFQ7qgvwelsnitMx+MlaYKCt1PDy488Bos+z0M4gALZSPysD6uED5Lay1Joil
         o8MKnT0KuetxDzQMFZnGLqUvPU+EIztk0uBmJwlI6eJIGZhPrd8lBeL+t9WHoYThcJba
         hWIWVfuj8x7/1r98kVmYsF0rS4+20hskeiQdqClLDSdXxCr6Qoxh7KfSJVLMpL+dnoxR
         YiEawU+vuIhGIvv5EgoxcHSsL8VgaAGmhEEWkBWclrzj7kyEou40xDqPsMG/GF4cLmJZ
         1L5hql6AHYCMgViigflIQ1coZ80elgn5igKHIQUkz2TCZa7DGkooLhtzCi1e2BFsxuLZ
         WbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281675; x=1774886475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzezBvlbzIGXplopQPhzXRTVv1p4U7sUNeKcBaGOoCw=;
        b=W8BVUuijfa4PixHApyWPthjrAPeWkRqI6w5bIvZKKiwVYY4Z25RJIyWx/n9DcqNVJW
         t3t+Wwsfcl0DrpfQoyaaKvQKH5Fxd0jw3AVcXJIL0ayUw4JFLuEb1LGXEt5fcKingErj
         d0wRWkMNKllOpRsY3poYGwCtx0iUix20Nh6VQCibQVY7r72S/QSFeMRgI1ULI3sk0wer
         vo4ZCXOo0JsxF3qd0Ul25N/m/S7efFnJ2n1EgtkoatCO0pzO2xI3xlHa186i+pa1TPFp
         IiFuYjtKByCp0FIpldH2PjO+3XRtR/ONkiQtgHL68g2gRZsf3Or7is15bVtiEsKLCz56
         cbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7py1mafRCMudlx3Y3RpwL+Ik8yyQzN3TNPV34XKf3WtR6l26DQIp7wuOVyNQbe4jgvJhYC98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjn1E0dHv2aKNJBUeRoidlnJl07+xG0xyuBHu/xzgd90NIbbCQ
	oEofl7H9GRjVCP9zzVNYAEgrp0LZS9PAkG7H0rqcfKaBtTX+d0nXG2MEK0yS5YLZ1o4=
X-Gm-Gg: ATEYQzx4mvwZJPSSZX05P8fmy+su2gw4E5mN4gU17KqiykfoMnP2MtuqXboVcbcqfd0
	gwVElsSPuTenQ/Ytj32kQW0wQBWB45b5KxFWyZBsCsfeZsTMR/pQIDOFty1aNdFjVyusi1iaDMu
	i4iBybacgm7SA41FswTKzriOywaXbCBUQY2ZJyxm9QcPYTXCn77cQBf+bAsm3u22Mo/fFEeYhE4
	BVUaOjK0L9pytyDmsMwNdcAyioqoIGmSstXVIQWfZdI/e44tdJBmZbtZuMzJmfdOQswcTtTOKbs
	jxEfgshbdG5NJ8BhMYirCxI0TJcB2T6sGtxjny04V1qZpXoBpYwemgsVuvHmYTrv7LhIVbL0TZO
	fBvLafXTqLQ8IlEANfUz2OtyA5E67sAbuj3SP4d60lCJ41R6H4LEx+AEzzLiWpWkB6qNoTjMiQF
	tRYngRvXr02IEMDZ9MdRj4nm9N7IRNkVjATz77idKTUArBxbER2pxRT5971/JNcUBt9A==
X-Received: by 2002:a05:620a:4594:b0:8cd:75df:f2fb with SMTP id af79cd13be357-8cfc80dd30cmr1961607085a.65.1774281669680;
        Mon, 23 Mar 2026 09:01:09 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:09 -0700 (PDT)
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
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 04/19] net: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:23 -0400
Message-ID: <20260323160052.17528-5-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
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
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[bitbyteword.org,goodmis.org,infradead.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,ovn.org,vger.kernel.org,openvswitch.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-270602-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 01B752F91C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
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
index 14a83f2035b93..f7602b1892fea 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *head)
 		return;
 	if (trace_netif_receive_skb_list_entry_enabled()) {
 		list_for_each_entry(skb, head, list)
-			trace_netif_receive_skb_list_entry(skb);
+			trace_call__netif_receive_skb_list_entry(skb);
 	}
 	netif_receive_skb_list_internal(head);
 	trace_netif_receive_skb_list_exit(0);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba7..3003e5c574191 100644
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
index 792ca44a461da..60823de201417 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		int err = 0;
 
 		if (trace_ovs_do_execute_action_enabled())
-			trace_ovs_do_execute_action(dp, skb, key, a, rem);
+			trace_call__ovs_do_execute_action(dp, skb, key, a, rem);
 
 		/* Actions that rightfully have to consume the skb should do it
 		 * and return directly.
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b41..2b9755e2e4731 100644
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
index f6b8c13dafa4a..4025d863ffc84 100644
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
index af442a5ef8f3d..5745d6aa0a054 100644
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
2.53.0


