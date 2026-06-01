Return-Path: <netdev+bounces-293663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKEYJC9VHWqnYwkAu9opvQ
	(envelope-from <netdev+bounces-293663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:47:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF461CB84
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2953308BF28
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F63921C8;
	Mon,  1 Jun 2026 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLzLrv++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA1391E60
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306705; cv=none; b=CGj5wdhLx1JNWs5gY0Cg0Vc3zVuiqz6zljLfKAcqStbMObTAFcv2FrJFtVuRZafDH1IjRw57vga5oJ8fXH/KhfPTuq+Af8HENOKggqHRY4vhsG/oqvfp1vg6Idgk/6bCRiaAypWOF5U9skgq0gX8GS+NOOm7pckLVlMwIYaeB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306705; c=relaxed/simple;
	bh=GSwybU/39LWjnbNTJORAqafJV4KjHVJmC05EiHqyJnE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tjSZ4MsMyK+P01CvXf1ZXvQEu55oAA9mL34YvX6JNipUj+HUDH6lRbB+feVSmjsbZ0bAFFJoKdy4EGDaajiXsk0eaZYIvw5Ly9svGrzUhH9CsGKdADqhsUotF1lZ0r+cb7K03u7i7J0afd+t7kgT3ff0PwXlqsrH7N5JCS9Ecsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLzLrv++; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ccd719a2f2so28567676d6.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780306700; x=1780911500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oU37Bye9vbsYAhFootcHMK3pmsBoDZIb5OSGwYpLS8s=;
        b=wLzLrv++h6KM+ISBXT2hQJbw6WbS2aPqOW+TR/rg97Pc8k5FQoS92/x5Uj3i8SLOja
         h66WJik5O7bV3HBeFEMq/2Eh7V7Y1cZYfbrRGeo+nxD7+v2TCTiA2FVTpgh6gF+y/P5+
         rULJBzpMAV0sLQhswh7SGUrI6acgj77JV6gDGYvllNqxaBYn6TIGnnv/nZ/ObMsn+pp7
         F0lU+8kyijkwIzLvNthxljmP3cEWuNXAJyoS3cDLk6Seq3Rub0aAYod3/vmouv4zPII7
         nQ0bpdYHvNgkZyMlZqHNw6k4uGb27KL+43PIoZzn8x2o3QSFzH04kpu0pGVMV1VUlAsb
         85dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306700; x=1780911500;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oU37Bye9vbsYAhFootcHMK3pmsBoDZIb5OSGwYpLS8s=;
        b=sqM/JmaYI89RjjPyomBhEDgb1KZmcHM8FIt/6cbPq8dlkqFfrg3pxBHuSPMQIaNVXM
         e/MbHEeqfxs+9MxkU8BqRIK4YZeG9xUhiwti9cPZ74SuuRGYCBNDtkgXfGIRpCS7h8Dp
         5i/Hv3EPBXxyQem/tPyAplBFxhVNw+tTBXJS8KThDPWQZdMhqMaN2RYGph8S+AAemunF
         XtsrTh23yzDXGhs/8Ew92P13WFoCFXqKzdfXRjXI0TINIdFuBdgzcCfxLNb6sIkn/AcK
         urr+cYZqHRxrgZyccw2Hsf3hEZ8bJXLqSJoVUBQECE87AJcabvwpqwXfaH/aPo03dXBv
         OP8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/5SCUT0SskmBNb+202gOhU0elxzu2p8Z6Q48zN+4lesznaAGkCCQNGADn+IcGSf1U1HAQoj9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9N66rROjjCPCsLQOx7ZE4Dm2qC/Ob6LrXXi/9awX2tTTnHjv
	x3lCNrlZ20yLSbLhOyrBzOmC+VR0MuTsaKAWB1IM2zFfPmkUMxQSrEhwml4LjQNugfKaKFA9OT+
	cs/Ls+efWyENyog==
X-Received: from qkbg3.prod.google.com ([2002:a05:620a:a343:b0:914:afc0:a9a8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1988:b0:914:7b4f:cf5b with SMTP id af79cd13be357-9153d9704famr1655070085a.16.1780306700272;
 Mon, 01 Jun 2026 02:38:20 -0700 (PDT)
Date: Mon,  1 Jun 2026 09:38:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601093819.469626-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: change bpf_skops_hdr_opt_len() signature
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293663-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vmlinux.new:url]
X-Rspamd-Queue-Id: EBFF461CB84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some compilers do not inline bpf_skops_hdr_opt_len() from
tcp_established_options(), forcing an expensive stack canary
when CONFIG_STACKPROTECTOR_STRONG=y.

Change bpf_skops_hdr_opt_len() to return @remaining by value
to remove this stack canary from TCP fast path.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 1/1 up/down: 10/-59 (-49)
Function                                     old     new   delta
bpf_skops_hdr_opt_len                        297     307     +10
tcp_established_options                      574     515     -59
Total: Before=31456795, After=31456746, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 51 +++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 31b459ecbe8307a8660623038fea6fa7b0860f7f..d3b8e61d3c5e7fb2723950b4d29aca535378df40 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -466,22 +466,22 @@ static int bpf_skops_write_hdr_opt_arg0(struct sk_buff *skb,
 }
 
 /* req, syn_skb and synack_type are used when writing synack */
-static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
-				  struct request_sock *req,
-				  struct sk_buff *syn_skb,
-				  enum tcp_synack_type synack_type,
-				  struct tcp_out_options *opts,
-				  unsigned int *remaining)
+static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
+				 struct request_sock *req,
+				 struct sk_buff *syn_skb,
+				 enum tcp_synack_type synack_type,
+				 struct tcp_out_options *opts,
+				 u32 remaining)
 {
 	struct bpf_sock_ops_kern sock_ops;
 	int err;
 
 	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
 					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
-	    !*remaining)
-		return;
+	    !remaining)
+		return remaining;
 
-	/* *remaining has already been aligned to 4 bytes, so *remaining >= 4 */
+	/* remaining has already been aligned to 4 bytes, so remaining >= 4 */
 
 	/* init sock_ops */
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
@@ -513,21 +513,21 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	}
 
 	sock_ops.args[0] = bpf_skops_write_hdr_opt_arg0(skb, synack_type);
-	sock_ops.remaining_opt_len = *remaining;
+	sock_ops.remaining_opt_len = remaining;
 	/* tcp_current_mss() does not pass a skb */
 	if (skb)
 		bpf_skops_init_skb(&sock_ops, skb, 0);
 
 	err = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
 
-	if (err || sock_ops.remaining_opt_len == *remaining)
-		return;
+	if (err || sock_ops.remaining_opt_len == remaining)
+		return remaining;
 
-	opts->bpf_opt_len = *remaining - sock_ops.remaining_opt_len;
+	opts->bpf_opt_len = remaining - sock_ops.remaining_opt_len;
 	/* round up to 4 bytes */
 	opts->bpf_opt_len = (opts->bpf_opt_len + 3) & ~3;
 
-	*remaining -= opts->bpf_opt_len;
+	return remaining - opts->bpf_opt_len;
 }
 
 static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
@@ -575,13 +575,14 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		       max_opt_len - nr_written);
 }
 #else
-static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
-				  struct request_sock *req,
-				  struct sk_buff *syn_skb,
-				  enum tcp_synack_type synack_type,
-				  struct tcp_out_options *opts,
-				  unsigned int *remaining)
+static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
+				 struct request_sock *req,
+				 struct sk_buff *syn_skb,
+				 enum tcp_synack_type synack_type,
+				 struct tcp_out_options *opts,
+				 u32 remaining)
 {
+	return remaining;
 }
 
 static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
@@ -1050,7 +1051,8 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
 
-	bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
+	remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
+					  remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
@@ -1137,8 +1139,8 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
 
-	bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
-			      synack_type, opts, &remaining);
+	remaining = bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
+					  synack_type, opts, remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
@@ -1228,7 +1230,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
 
-		bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
+		remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
+						  remaining);
 
 		size = MAX_TCP_OPTION_SPACE - remaining;
 	}
-- 
2.54.0.1013.g208068f2d8-goog


