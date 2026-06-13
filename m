Return-Path: <netdev+bounces-298860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t6IeCvesLGryVAQAu9opvQ
	(envelope-from <netdev+bounces-298860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:05:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36667D65B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:05:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=QFHHPqPR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298860-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298860-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B84F34F4C81
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1961925B08F;
	Sat, 13 Jun 2026 01:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E7235358
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312454; cv=none; b=e4qsy8ntUbLRf5Fvxm1wRYtkpH0rKHNIb8olBb/w1MNHqyPy+4/4YJh/agsW1SNUz2C62RJJ9Xs+4EiZ2RsKKQGL6wk4DaUIEns0IRS1GgftpSdjLE+rw63xDId1RSvY5pNhIAJR6TZbO/e1S/60WlgxzDpuIkuSjWZ1IQTpCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312454; c=relaxed/simple;
	bh=XHTBCfAfGiU76MQzuZ3pdXeK99V9yWQ6pM+XqgoDPRs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GscjnH3ONdSbA+xUgDXronP1u/bOdPIVOAATqBqHwgtL4Hmy/Stk/hFwJTo3BkTfDSBmUFon7dllSXYT0/lGGpkHfSkFXvdjBOuvDPyD9uTD1fe8R48t4bMYGKDzGxRkYnCMUrl2TSqmj3PlvDaEMSLBrMIVSmB2Us7wRsKJYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFHHPqPR; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so1498855a91.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781312447; x=1781917247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSHEO9H6uuPydVUInob3JWeqvAdKo84++kc3nhP54k4=;
        b=QFHHPqPROMomufTwvhTkU4Hj37LCocTSauZHkpPnijpLJ/olrQ6Svicuvlr8PnTXCf
         BcAKyLwcwBAlqAPV4CGgJMCaAmoadAYW6/+4M9XMWFISvMz4ZPS4OI6WrJawM75Lh+np
         3qiWxN66X6RyuEkcE/0YWgZbtXuV9+NSU/Fiy2vbfAWWNs83m9/h5ft4B6koPj8Iz49h
         p2dCvNjOBcsbzK/aFiGA4UM/Pt+AxCENLFczyriZIWoIkIhslbHR3SDyXMtWRccxU5oN
         pWK8XkrC14+Gq6ls8DcoOHYwb1sGO3tzDoaN7WZkByTB8AAjr8b/vzfbQ1laAl+w13kK
         XXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781312447; x=1781917247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSHEO9H6uuPydVUInob3JWeqvAdKo84++kc3nhP54k4=;
        b=iLJR6j/oi0uFLMqmw6S5soSzPcHe4H4gFg2WK1Wrt1pS61yNXE2k1QgFn0aop57HnZ
         YrIdMJW0AWC2LXlkoNWZTnRDqBXnKiAQfa0kj3VbSVxoC+96MZdcsxqEwTCLZ8TtYfio
         sOZ6aEHS6J8JeFMuFuvAugMstM2rJW/u3C4hjMQJacUgebbUAQ8xWj6iY7B4gfM64oED
         7ojTjRWeinfFO7zPENsQhmSI5k+BEI7MWhrfZa6EEd8YWs58/QD3qQkExOCqqhpzoXmb
         Sayhoo1DD9tT5EWpShMqQjky1/tvCxNLOdNZTUqJoyAAEoc9lvKXnZYnczMvrWqMsRAN
         gWmw==
X-Forwarded-Encrypted: i=1; AFNElJ+54Rn5+prJZOYX9yHFzubCRnQzcOwz/LOZVPzfY2maC9RqtiOIYZ7buvxabTZ6Iy4F6iYd7ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNINZgwTHCpvSjOVfHBrMHHg35O5mRFx2YBSilj7GqhkHsY9Cs
	WbJ9gnx/1zwXh4IFzMTDgICvZuLxGzm86+X8iK9CcmYNFbXlaHt+arFd/A7HPsOfknuAOLCnuXd
	/i7VkGA==
X-Received: from pgut18.prod.google.com ([2002:a65:6092:0:b0:c85:c9a9:ff69])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5904:b0:367:b819:2214
 with SMTP id 98e67ed59e1d1-37a038e4ff3mr5534882a91.13.1781312447127; Fri, 12
 Jun 2026 18:00:47 -0700 (PDT)
Date: Sat, 13 Jun 2026 01:00:01 +0000
In-Reply-To: <20260613010039.1362312-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613010039.1362312-5-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW Timestamp.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuniyu@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298860-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D36667D65B

In the setup mentioned in the previous patch, it is impossible
for socket applications to get TX hardware timestamps via
SCM_TIMESTAMPING.

To proxy TX hardware timestamp, let's add two kfuncs:

  * bpf_skb_scrub_tx_tstamp()    : scrub skb_shinfo(skb)->tx_flags
  * bpf_skb_complete_tx_tstamp() : enqueue skb to sk->sk_error_queue

The key idea is to regenerate an skb that contains all the
information required for the TX timestamp, identical to the
original skb.

Here is how it works:

When the socket application sends a packet, BPF prog at tc/egress
checks skb_shinfo()->tx_flags.  If it has SKBTX_HW_TSTAMP_NOBPF,
BPF prog scrub the value by bpf_skb_scrub_tx_tstamp() and inserts
a GENEVE option to signal that the packet wants TX HW timestamp.

The proxy decapsulates and forwards the packet to the hardware,
and if it has GENEVE option, the proxy keeps the original packet
until TX completion.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              |     ^ decap packet and              |
  userspace   |     |  keep it till TX cmpl         |
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `----|       geneve0       |<---'
  kernel     | |   skb   +---------------------+
             | |             ^             |
             | |             |             v
             | |          +------------------+  check skb_shinfo()->tx_flags
             | |          |  BPF@tc/egress   |    and insert a GENEVE option
             | |          +------------------+
  -----------| |-----------------------------------------------
              |
              v
       +------------+
       |  hardware  |
       +------------+

Once the proxy gets TX hwtstamp, encapsulate the original packet
with TX hwtstamp embedded in GENEVE option, and sends it to the
GENEVE device.

At tc@ingress, BPF extracts the TX hwtstamp and sets it to skb.
Then, it looks up the sender socket, assigns it to skb->sk,
calls bpf_skb_complete_tx_tstamp(), and returns TCX_ERRQUEUE to
put the skb to skb->sk->sk_error_queue.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     | encap packet                  ^ get TX hwtstamp by
  userspace   |     |  w/ TX hwtstamp               |  recvmsg(MSG_ERRQUEUE)
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|       geneve0       |    |
  kernel     | |   skb   +---------------------+    |
             | |             |              ________'
             | |             v             |    extract TX hwtstamp to skb
             | |          +------------------+   and look up the sender sk
             | |          |  BPF@tc/ingress  |   and enqueue skb to its
             | |          +------------------+    sk->sk_error_queue
  -----------| |-----------------------------------------------
              |
              | TX completion w/ TX hwtstamp
       +------------+
       |  hardware  |
       +------------+

This provides transparent TX HW timestamp support, and the socket
application can finally receive it via recvmsg(MSG_ERRQUEUE).

Note that struct bpf_tx_tstamp_cmpl needs network_offset and
payload_offset so that

  1. ip_cmsg_recv() and ipv6_recv_error() can correctly parse
     the IPv4/IPv6 header for some control messages

  2. applications can receive the original payload

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Remove __packed and use unnamed bit-field in struct
    bpf_tx_tstamp_cmpl (Alexei Starovoitov)
  * Check !skb_at_tc_ingress() in bpf_skb_complete_tx_tstamp()
    (Sashiko)
  * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)
---
 include/linux/filter.h       |  2 ++
 include/linux/skbuff.h       |  8 +++++
 include/net/tcx.h            |  1 +
 include/uapi/linux/bpf.h     |  1 +
 include/uapi/linux/pkt_cls.h |  3 +-
 kernel/bpf/verifier.c        |  6 +++-
 net/core/dev.c               | 39 ++++++++++++++++++++++
 net/core/filter.c            | 63 ++++++++++++++++++++++++++++++++++++
 8 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 88a241aac36a..59097bfd8522 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -770,6 +770,7 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_TX_TS_CMPL	BIT(5)
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -780,6 +781,7 @@ struct bpf_redirect_info {
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
 	u32 kern_flags;
+	struct bpf_tx_tstamp_cmpl txtscmpl;
 };
 
 struct bpf_net_context {
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0f62f7cd22e1..9709e3389b13 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4706,6 +4706,14 @@ struct bpf_hwtstamp {
 	u64 :64;
 };
 
+struct bpf_tx_tstamp_cmpl {
+	u32 tskey;
+	__be16 protocol;
+	u16 network_offset;
+	u16 payload_offset;
+	u16 :16;
+};
+
 /**
  * skb_complete_tx_timestamp() - deliver cloned skb with tx timestamps
  *
diff --git a/include/net/tcx.h b/include/net/tcx.h
index 23a61af13547..052e751d907e 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -151,6 +151,7 @@ static inline enum tcx_action_base tcx_action_code(struct sk_buff *skb,
 		fallthrough;
 	case TCX_DROP:
 	case TCX_REDIRECT:
+	case TCX_ERRQUEUE:
 		return code;
 	case TCX_NEXT:
 	default:
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..60950aa583aa 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6532,6 +6532,7 @@ enum tcx_action_base {
 	TCX_PASS	= 0,
 	TCX_DROP	= 2,
 	TCX_REDIRECT	= 7,
+	TCX_ERRQUEUE	= 9,
 };
 
 struct bpf_xdp_sock {
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 28d94b11d1aa..337f1bdbabb6 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -76,7 +76,8 @@ enum {
 				   * the skb and act like everything
 				   * is alright.
 				   */
-#define TC_ACT_VALUE_MAX	TC_ACT_TRAP
+#define TC_ACT_ERRQUEUE		9
+#define TC_ACT_VALUE_MAX	TC_ACT_ERRQUEUE
 
 /* There is a special kind of actions called "extended actions",
  * which need a value parameter. These have a local opcode located in
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b23577d001a..5451a19847ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11192,6 +11192,7 @@ enum special_kfunc_type {
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
 	KF_bpf_skb_set_hwtstamp,
+	KF_bpf_skb_scrub_tx_tstamp,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11286,8 +11287,10 @@ BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_skb_set_hwtstamp)
+BTF_ID(func, bpf_skb_scrub_tx_tstamp)
 #else
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
@@ -11371,7 +11374,8 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
-	       meta->func_id == special_kfunc_list[KF_bpf_skb_set_hwtstamp];
+	       meta->func_id == special_kfunc_list[KF_bpf_skb_set_hwtstamp] ||
+	       meta->func_id == special_kfunc_list[KF_bpf_skb_scrub_tx_tstamp];
 }
 
 static enum kfunc_ptr_arg_type
diff --git a/net/core/dev.c b/net/core/dev.c
index 1ecd5691992e..f8a8cc85d47d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4457,6 +4457,41 @@ tcx_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
 	return tcx_action_code(skb, ret);
 }
 
+static int skb_do_completion(struct sk_buff *skb)
+{
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
+	struct bpf_tx_tstamp_cmpl *txtscmpl;
+
+	if (!(ri->kern_flags & BPF_RI_F_TX_TS_CMPL))
+		goto drop;
+
+	if (skb_unclone(skb, GFP_ATOMIC))
+		goto drop;
+
+	__skb_push(skb, skb->mac_len);
+
+	txtscmpl = &ri->txtscmpl;
+
+	drop_reason = pskb_may_pull_reason(skb, txtscmpl->payload_offset);
+	if (drop_reason)
+		goto drop;
+
+	skb->protocol = txtscmpl->protocol;
+	skb_set_network_header(skb, txtscmpl->network_offset);
+	__skb_pull(skb, txtscmpl->payload_offset);
+
+	skb_shinfo(skb)->tskey = txtscmpl->tskey;
+	skb_shinfo(skb)->tx_flags = SKBTX_HW_TSTAMP_NOBPF;
+	__skb_tstamp_tx(skb, NULL, skb_hwtstamps(skb), skb->sk, SCM_TSTAMP_SND);
+
+	consume_skb(skb);
+	return NET_RX_SUCCESS;
+drop:
+	kfree_skb_reason(skb, drop_reason);
+	return NET_RX_DROP;
+}
+
 static __always_inline struct sk_buff *
 sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
@@ -4505,6 +4540,10 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		*ret = NET_RX_DROP;
 		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
+	case TC_ACT_ERRQUEUE:
+		*ret = skb_do_completion(skb);
+		bpf_net_ctx_clear(bpf_net_ctx);
+		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
 	case TC_ACT_QUEUED:
diff --git a/net/core/filter.c b/net/core/filter.c
index bee1e7eee5ea..fce2d24aad48 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12396,6 +12396,67 @@ __bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
 	return 0;
 }
 
+__bpf_kfunc int bpf_skb_scrub_tx_tstamp(struct __sk_buff *s)
+{
+	struct sk_buff *skb = (struct sk_buff *)s;
+
+	if (skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (skb_unclone(skb, GFP_ATOMIC))
+		return -ENOMEM;
+
+	skb_shinfo(skb)->tx_flags = 0;
+
+	bpf_compute_data_pointers(skb);
+
+	return 0;
+}
+
+__bpf_kfunc int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
+					   struct bpf_tx_tstamp_cmpl *attrs,
+					   int attrs__sz)
+{
+	int defined_sz = offsetofend(struct bpf_tx_tstamp_cmpl, payload_offset);
+	struct sk_buff *skb = (struct sk_buff *)s;
+	struct bpf_redirect_info *ri;
+	struct sock *sk = skb->sk;
+	s32 delta;
+
+	if (attrs__sz != sizeof(*attrs) ||
+	    memchr_inv((char *)attrs + defined_sz, 0, sizeof(u16)))
+		return -EINVAL;
+
+	if (!sk || !sk_fullsock(sk))
+		return -EINVAL;
+
+	if (!skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (attrs->payload_offset > skb->len)
+		return -EINVAL;
+
+	delta = attrs->payload_offset - attrs->network_offset;
+	switch (attrs->protocol) {
+	case htons(ETH_P_IP):
+		if (delta < (s32)sizeof(struct iphdr) || !sk_is_inet(sk))
+			return -EINVAL;
+		break;
+	case htons(ETH_P_IPV6):
+		if (delta < (s32)sizeof(struct ipv6hdr) || sk->sk_family != AF_INET6)
+			return -EINVAL;
+		break;
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	ri = bpf_net_ctx_get_ri();
+	ri->kern_flags |= BPF_RI_F_TX_TS_CMPL;
+	ri->txtscmpl = *attrs;
+
+	return 0;
+}
+
 /**
  * bpf_xdp_pull_data() - Pull in non-linear xdp data.
  * @x: &xdp_md associated with the XDP buffer
@@ -12525,6 +12586,8 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 BTF_KFUNCS_START(bpf_kfunc_check_set_sched_cls)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_skb_set_hwtstamp)
+BTF_ID_FLAGS(func, bpf_skb_scrub_tx_tstamp)
+BTF_ID_FLAGS(func, bpf_skb_complete_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sched_cls)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
-- 
2.54.0.1136.gdb2ca164c4-goog


