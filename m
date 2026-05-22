Return-Path: <netdev+bounces-290709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOEPOS8LEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:52:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA65B03B9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7561C30887D4
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B053A5E8A;
	Fri, 22 May 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHFdnSGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06589392825
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435976; cv=none; b=ap2nCzZ3NIddJyaCag1ox/afRvjdG1OiHmLyMGtz7j4vQFe6yjTILL4N8r8BCqblnyEOV9LVXF6H5c7p/wbReIcALXLBgcewhHD5O9nwS7duWuQppc71X0Nz+wfFhzAxZVGj/s689TVEUfl71i7l2Gv7iIZzbsPZtM+4W6GYgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435976; c=relaxed/simple;
	bh=iFTUUrqhpuyai3E321B5Sm1AeeTBqErBXB7ZVIwBLmk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9nZbL7AYXtfsNml1rylMXlAEnMav+2dTBltB+kZPZA0fNaeGBBajrRqEnljoExHVfdDJC2Xi6ktIAS3VSLUlridrVxRKuYWbEkxoTHKnUyiegXt5vAhSESxwD4d23UatMiPwLB/9KtHBRyPG0EEoGA6bBRg8X4M03saZNFwNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHFdnSGD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-368b68a33adso10577381a91.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435974; x=1780040774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3ulAOOH4b33u1XjlABRRi3F/0LpqdLj5+YvtoxxlwI=;
        b=kHFdnSGDov9uK6nKHlo2MHaEVf+TRBjD277164TVdxjglbRQiLTzSQJernhyUZ2Tpd
         ebfrgi9o2wAlCKGKhsnExVtpHxSie/GpJ19nFbVTkCDSeJLLq9kgVBUBhSBI8elePOVm
         bM1Y0kpqe3Xm2kywYcJGX7/czPKXaRHMErAjpEZUf1bt+xNmoCtvzFBWkHFfXuDqyXHt
         8a9HD98OmuubuM7YLbHPK81sf1bObh8vf5fOGkoQBXUSoPntSTabp+Bp8RYN1C0CeuZ1
         yDsE8N9wr1bvKvZMIJtl63TjCG3qsg8QyVkHeHod04q3T/M4NI0+VhFHIr5h425LsRsh
         vujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435974; x=1780040774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3ulAOOH4b33u1XjlABRRi3F/0LpqdLj5+YvtoxxlwI=;
        b=bvauWZ41oZiMVOoKrfAJfS9UzvE+EWbdjS/IavW0RnklEk+TXSvaBneCQLSTOjKCtQ
         IqAsESCo9S+ZFffEqzXDtDBFIJweiCu8d7im6wex8acaM35Fu3tcD4jCuzx3lCVdK4ny
         Xn8AVt3lWcwRa7B+XRsg4o93iNbtTA88bz9MxxoDPDunQBV7zAvUCYbEFQp538HCVSXn
         Lp+jlB8gVgcmIFD0s2Zf4Z4HzR0L38lIt92WIaHsP5/nUPb0wVMUJP34gYqIEufUtnTR
         mDQVRN1IicOQg93PKq31C0RZ003tiP/b0j9hC1rwPnScHgSnHPUnNhaMPTmmWPtTnOvh
         6yAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VU6OHeAH9/Y5xTA/J4GLfhHkcpGijOlpOxLDNNwW4X4R305OhfB0cqqZEp2MLHeJ2cWEcm78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBbtC9UwqXGTx7i1jOjkNGNlHF9PH8JAGXHtLmk0oRqeIh5ZO
	/ZY0oHVNt99kRngE3ZstKGyvLAR2yfQXNIHs9Xv3PRFb5LMQb+keQiow6mxUnorWeH1U06ptdaA
	kLKncYg==
X-Received: from pgmo8.prod.google.com ([2002:a63:5d48:0:b0:c85:a9c:435f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:14c:b0:398:7a23:2779
 with SMTP id adf61e73a8af0-3b328fcde36mr2465308637.52.1779435973987; Fri, 22
 May 2026 00:46:13 -0700 (PDT)
Date: Fri, 22 May 2026 07:45:01 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-11-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290709-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.944];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bpf_sock_ops.data:url]
X-Rspamd-Queue-Id: 48AA65B03B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.

Let's invoke the BPF SOCK_OPS prog when

  1. TCP stack enqueues skb to sk->sk_receive_queue
     -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()

  2. TCP recvmsg() completes
     -> __tcp_cleanup_rbuf()

This will allow the BPF prog to parse each skb and dynamically
adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
until sufficient data (e.g., a full RPC frame) is available
in the receive queue.

Note that the direct access to bpf_sock_ops.data is intentionally
disabled by passing 0 as end_offset.

Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
with bpf_sock_ops because payload is not in the linear area
with TCP header/data split on and skb may contain a RPC
descriptor in skb frag.  This also simplifies the BPF prog.

The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
tcp_fastopen_add_skb() is chosen to provide the same snapshot
with tcp_queue_rcv().

For example, if tcp_bpf_rcvlowat() were called before updating
TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
need to implement an unlikely if branch to strip SYN.

In addition, TCP stack can queue overlapping skb into recvq.
Once rcv_nxt is updated with a new skb, BPF prog cannot infer
the previous one from skb->len.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Add explanation of tcp_bpf_rcvlowat() placement.
---
 include/net/tcp.h       | 12 ++++++++++++
 net/ipv4/tcp.c          |  2 ++
 net/ipv4/tcp_fastopen.c |  2 ++
 net/ipv4/tcp_input.c    | 10 ++++++++++
 4 files changed, 26 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c6a6853909c4..2247937e385a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2888,12 +2888,24 @@ static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 	skops->skb = skb;
 	skops->skb_data_end = skb->data + end_offset;
 }
+
+void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
+
+static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
+{
+	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
+		bpf_skops_rcvlowat(sk, skb);
+}
 #else
 static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 				      struct sk_buff *skb,
 				      unsigned int end_offset)
 {
 }
+
+static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
+{
+}
 #endif
 
 /* Call BPF_SOCK_OPS program that returns an int. If the return value
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3afeb69a547a..f7e32891bb4e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
 		tcp_mstamp_refresh(tp);
 		tcp_send_ack(sk);
 	}
+
+	tcp_bpf_rcvlowat(sk, NULL);
 }
 
 void tcp_cleanup_rbuf(struct sock *sk, int copied)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be5513..91bf421fc5b6 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->seq++;
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
+	tcp_bpf_rcvlowat(sk, skb);
+
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c4ba4f1e9d9e..477bcf2ba89d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -204,6 +204,12 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	bpf_skops_common_locked(sk, bpf_op, skb, skb ? tcp_hdrlen(skb) : 0);
 }
+
+void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb)
+{
+	/* skb is NULL when called from __tcp_cleanup_rbuf(). */
+	bpf_skops_common_locked(sk, BPF_SOCK_OPS_RCVQ_CB, skb, 0);
+}
 #else
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
@@ -5306,6 +5312,8 @@ static void tcp_ofo_queue(struct sock *sk)
 			continue;
 		}
 
+		tcp_bpf_rcvlowat(sk, skb);
+
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
@@ -5509,6 +5517,8 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 	int eaten;
 	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
 
+	tcp_bpf_rcvlowat(sk, skb);
+
 	eaten = (tail &&
 		 tcp_try_coalesce(sk, tail,
 				  skb, fragstolen)) ? 1 : 0;
-- 
2.54.0.746.g67dd491aae-goog


