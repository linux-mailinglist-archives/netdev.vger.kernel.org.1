Return-Path: <netdev+bounces-270817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCtRAmjSwWk9XAQAu9opvQ
	(envelope-from <netdev+bounces-270817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:53:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDC82FF15B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B3430CBE12
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB8A3328FA;
	Mon, 23 Mar 2026 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkL8eKYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69A3128D7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309764; cv=none; b=acZzzbm33BtfUCMa3DWn9Vp02BI80JGqhDn1ZjCJHUYjBeK9Fe33vuOMZylUcOOwVvV9LsedJpuZknWG2FpC/Q8Aqg7fOQ/hzp7Dgm8CAs5SR1znyT2vooeeCsPRz+hv00QWKLd8OCNhp0ig/iDMuY6HtqgEXblBtpjtOivixXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309764; c=relaxed/simple;
	bh=er23Pv0U0Vyn0CTm9zUx5UjOl5qNxIdZ0DWkGuaGuTU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G+XnM++UBhJONA2JhH9Gl4tMRu1IlKM9suKUcYEwmk/cnOhI1vYWLbK8NOWabdvcS6hVX+B5eC6GtUPKkZIYfTyppp4Y5hXacs822SaaeXo3NRudgqiXE2s6So9Wi0oaIU/D4D0a3/TQlVE7JAxQHkgvgPK3TG0rtf0E3G2mgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkL8eKYS; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-899f1c1e4d6so160712426d6.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774309762; x=1774914562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSHAf5mjuY7ZNpienjxuDoRG74HBmkG56y96hvDExzs=;
        b=IkL8eKYSRNEg1trrYzfHLtCKg3se0fjP9HBXLn52m5lCF3Z0kNmfFMlGbfBFt/7QIp
         R8xDipNU8vFoNhDAxRjq0r7+34CwTVpPnHb1UNN+PZM//ArLYte1XRXm1jU7u7gnicH+
         NGGd5QgWIlXT88snOgoHYTsRL3641RwXzV5b2kDQRjDhjO0VQbGPbyF6+9fxENSYE6bx
         f7AVP1969XdqErlrkomxe1O+pcc5UGPwn3WLvm7Lu2mrwu+m/HPdlvCDcmWO4NtpvB5M
         pARTYQ5qRSlQmpIoWp0P0ZMWRS+m2zyBuVzm9rXyulGbVJbFNN687tJ9ZAbTHe8kh6oW
         eTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309762; x=1774914562;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSHAf5mjuY7ZNpienjxuDoRG74HBmkG56y96hvDExzs=;
        b=C0mrCL/EULKWJgqCBCOW7byGuGvRi5RbUO0B3N+tSyz2RksrvLvODp5aJDw+nM5HYA
         8O4Map0t9EU4sM6jl2qPQHT4ur7q88RKg131w5mbyIUyTk7SKzgWA47FHJmO08BBt8nf
         r3oBaZDMy3YtygNL0/KghCjfE/oyYDr+KQwxKCkpTBhHDmMXBIOzx3t887/x2dZqZ1oA
         McxBKm+mUjWfm+sKfvgX+39CMuvccwFQ5qEwBI69IwNZCfF2DJrls+IeA6mhHQ8VOATv
         q8yHkVIHMmX5Xmm5OZoUg4dMuqMMN3IaBrnfcb8G5BiuVLN2HIZwCtRxhIJHdrf5cRXW
         Bb2g==
X-Forwarded-Encrypted: i=1; AJvYcCUB0isEdEOYhTsvwe6r7nGkpb/ndR9P3S3ldqSnc6ZlYmhIcBu5Qb02tS7hwYO5e/wF/Y8BNAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBDUwyNAeIIwYcTDMNwVilXJMiXQXf2PS6U7rWRrFvFARlnfN
	Mn4xln32qWthRDISvXKgld6DErkrnuaFG5LB1hWkyoogi4hssfPYdVjAq07T+GXmCPuxI/SZlgD
	LOeoAX04WQyEriw==
X-Received: from qtbdo10.prod.google.com ([2002:a05:622a:478a:b0:509:5c69:658f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1e0c:b0:50b:3ff3:f4a7 with SMTP id d75a77b69052e-50b3ff3f592mr193412181cf.35.1774309761733;
 Mon, 23 Mar 2026 16:49:21 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:49:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323234920.1097858-1-edumazet@google.com>
Subject: [PATCH v4 net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-270817-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CDC82FF15B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

(tcp_congestion_ops)->cwnd_event() is called very often, with
@event oscillating between CA_EVENT_TX_START and other values.

This is not branch prediction friendly.

Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_START.

Both BBR and CUBIC benefit from this change, since they only care
about CA_EVENT_TX_START.

No change in kernel size:

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 4/4 grow/shrink: 3/1 up/down: 564/-568 (-4)
Function                                     old     new   delta
bbr_cwnd_event_tx_start                        -     450    +450
cubictcp_cwnd_event_tx_start                   -      70     +70
__pfx_cubictcp_cwnd_event_tx_start             -      16     +16
__pfx_bbr_cwnd_event_tx_start                  -      16     +16
tcp_unregister_congestion_control             93      99      +6
tcp_update_congestion_control                518     521      +3
tcp_register_congestion_control              422     425      +3
__tcp_transmit_skb                          3308    3306      -2
__pfx_cubictcp_cwnd_event                     16       -     -16
__pfx_bbr_cwnd_event                          16       -     -16
cubictcp_cwnd_event                           80       -     -80
bbr_cwnd_event                               454       -    -454
Total: Before=25240512, After=25240508, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v4: more eBPF fixes in net/ipv4/bpf_tcp_ca.c
v3: fix tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c (Jakub)
v2: fix tools/testing/selftests/bpf/progs/bpf_cc_cubic.c (Jakub)
v1: https://lore.kernel.org/netdev/20260313202802.1201129-1-edumazet@google.com/

 include/net/tcp.h                             |  8 +++++
 net/ipv4/bpf_tcp_ca.c                         |  5 +++
 net/ipv4/tcp_bbr.c                            |  8 ++---
 net/ipv4/tcp_cubic.c                          | 35 +++++++++----------
 net/ipv4/tcp_dctcp.c                          | 12 +++++--
 net/ipv4/tcp_vegas.c                          |  9 +++--
 net/ipv4/tcp_vegas.h                          |  1 +
 net/ipv4/tcp_veno.c                           |  8 ++++-
 net/ipv4/tcp_yeah.c                           |  1 +
 .../selftests/bpf/progs/bpf_cc_cubic.c        |  8 ++---
 tools/testing/selftests/bpf/progs/bpf_cubic.c | 33 ++++++++---------
 .../selftests/bpf/progs/tcp_ca_kfunc.c        | 16 ++++++---
 12 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f87bdacb5a6995422851e88cfb65734702c84093..39ff4cf3c810f5619a479dcd92192043374a1739 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1341,6 +1341,9 @@ struct tcp_congestion_ops {
 	/* call when cwnd event occurs (optional) */
 	void (*cwnd_event)(struct sock *sk, enum tcp_ca_event ev);
 
+	/* call when CA_EVENT_TX_START cwnd event occurs (optional) */
+	void (*cwnd_event_tx_start)(struct sock *sk);
+
 	/* call when ack arrives (optional) */
 	void (*in_ack_event)(struct sock *sk, u32 flags);
 
@@ -1440,6 +1443,11 @@ static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
+	if (event == CA_EVENT_TX_START) {
+	    if (icsk->icsk_ca_ops->cwnd_event_tx_start)
+			icsk->icsk_ca_ops->cwnd_event_tx_start(sk);
+		return;
+	}
 	if (icsk->icsk_ca_ops->cwnd_event)
 		icsk->icsk_ca_ops->cwnd_event(sk, event);
 }
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e01492234b0b349498f8e56c2f07d8bba092c00e..008edc7f6688523dc86963d90485655e9fa8374e 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -272,6 +272,10 @@ static void bpf_tcp_ca_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
 {
 }
 
+static void bpf_tcp_ca_cwnd_event_tx_start(struct sock *sk)
+{
+}
+
 static void bpf_tcp_ca_in_ack_event(struct sock *sk, u32 flags)
 {
 }
@@ -313,6 +317,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.cong_avoid = bpf_tcp_ca_cong_avoid,
 	.set_state = bpf_tcp_ca_set_state,
 	.cwnd_event = bpf_tcp_ca_cwnd_event,
+	.cwnd_event_tx_start = bpf_tcp_ca_cwnd_event_tx_start,
 	.in_ack_event = bpf_tcp_ca_in_ack_event,
 	.pkts_acked = bpf_tcp_ca_pkts_acked,
 	.min_tso_segs = bpf_tcp_ca_min_tso_segs,
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 05d52372ca8fb068530a9b3379f1ae0f9d0b362a..1ddc20a399b07054f8175b5f6459f8ae6dbf34bb 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -330,12 +330,12 @@ static void bbr_save_cwnd(struct sock *sk)
 		bbr->prior_cwnd = max(bbr->prior_cwnd, tcp_snd_cwnd(tp));
 }
 
-__bpf_kfunc static void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event)
+__bpf_kfunc static void bbr_cwnd_event_tx_start(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bbr *bbr = inet_csk_ca(sk);
 
-	if (event == CA_EVENT_TX_START && tp->app_limited) {
+	if (tp->app_limited) {
 		bbr->idle_restart = 1;
 		bbr->ack_epoch_mstamp = tp->tcp_mstamp;
 		bbr->ack_epoch_acked = 0;
@@ -1149,7 +1149,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
 	.cong_control	= bbr_main,
 	.sndbuf_expand	= bbr_sndbuf_expand,
 	.undo_cwnd	= bbr_undo_cwnd,
-	.cwnd_event	= bbr_cwnd_event,
+	.cwnd_event_tx_start	= bbr_cwnd_event_tx_start,
 	.ssthresh	= bbr_ssthresh,
 	.min_tso_segs	= bbr_min_tso_segs,
 	.get_info	= bbr_get_info,
@@ -1161,7 +1161,7 @@ BTF_ID_FLAGS(func, bbr_init)
 BTF_ID_FLAGS(func, bbr_main)
 BTF_ID_FLAGS(func, bbr_sndbuf_expand)
 BTF_ID_FLAGS(func, bbr_undo_cwnd)
-BTF_ID_FLAGS(func, bbr_cwnd_event)
+BTF_ID_FLAGS(func, bbr_cwnd_event_tx_start)
 BTF_ID_FLAGS(func, bbr_ssthresh)
 BTF_ID_FLAGS(func, bbr_min_tso_segs)
 BTF_ID_FLAGS(func, bbr_set_state)
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 76c23675ae50ab50c977dc1de79a3df57db98ef6..ab78b5ae8d0e3d13a39bd1adf1e105b84f806b63 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -139,24 +139,21 @@ __bpf_kfunc static void cubictcp_init(struct sock *sk)
 		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
 }
 
-__bpf_kfunc static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event)
+__bpf_kfunc static void cubictcp_cwnd_event_tx_start(struct sock *sk)
 {
-	if (event == CA_EVENT_TX_START) {
-		struct bictcp *ca = inet_csk_ca(sk);
-		u32 now = tcp_jiffies32;
-		s32 delta;
-
-		delta = now - tcp_sk(sk)->lsndtime;
-
-		/* We were application limited (idle) for a while.
-		 * Shift epoch_start to keep cwnd growth to cubic curve.
-		 */
-		if (ca->epoch_start && delta > 0) {
-			ca->epoch_start += delta;
-			if (after(ca->epoch_start, now))
-				ca->epoch_start = now;
-		}
-		return;
+	struct bictcp *ca = inet_csk_ca(sk);
+	u32 now = tcp_jiffies32;
+	s32 delta;
+
+	delta = now - tcp_sk(sk)->lsndtime;
+
+	/* We were application limited (idle) for a while.
+	 * Shift epoch_start to keep cwnd growth to cubic curve.
+	 */
+	if (ca->epoch_start && delta > 0) {
+		ca->epoch_start += delta;
+		if (after(ca->epoch_start, now))
+			ca->epoch_start = now;
 	}
 }
 
@@ -481,7 +478,7 @@ static struct tcp_congestion_ops cubictcp __read_mostly = {
 	.cong_avoid	= cubictcp_cong_avoid,
 	.set_state	= cubictcp_state,
 	.undo_cwnd	= tcp_reno_undo_cwnd,
-	.cwnd_event	= cubictcp_cwnd_event,
+	.cwnd_event_tx_start = cubictcp_cwnd_event_tx_start,
 	.pkts_acked     = cubictcp_acked,
 	.owner		= THIS_MODULE,
 	.name		= "cubic",
@@ -492,7 +489,7 @@ BTF_ID_FLAGS(func, cubictcp_init)
 BTF_ID_FLAGS(func, cubictcp_recalc_ssthresh)
 BTF_ID_FLAGS(func, cubictcp_cong_avoid)
 BTF_ID_FLAGS(func, cubictcp_state)
-BTF_ID_FLAGS(func, cubictcp_cwnd_event)
+BTF_ID_FLAGS(func, cubictcp_cwnd_event_tx_start)
 BTF_ID_FLAGS(func, cubictcp_acked)
 BTF_KFUNCS_END(tcp_cubic_check_kfunc_ids)
 
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 03abe0848420d7fb7b514e6ad24f4c702954ab14..96c99999e09dde9de9c337e4d6c692f517467c7b 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -203,15 +203,19 @@ __bpf_kfunc static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
 		tcp_plb_update_state_upon_rto(sk, &ca->plb);
 		dctcp_react_to_loss(sk);
 		break;
-	case CA_EVENT_TX_START:
-		tcp_plb_check_rehash(sk, &ca->plb); /* Maybe rehash when inflight is 0 */
-		break;
 	default:
 		/* Don't care for the rest. */
 		break;
 	}
 }
 
+__bpf_kfunc static void dctcp_cwnd_event_tx_start(struct sock *sk)
+{
+	struct dctcp *ca = inet_csk_ca(sk);
+
+	tcp_plb_check_rehash(sk, &ca->plb); /* Maybe rehash when inflight is 0 */
+}
+
 static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 			     union tcp_cc_info *info)
 {
@@ -252,6 +256,7 @@ static struct tcp_congestion_ops dctcp __read_mostly = {
 	.init		= dctcp_init,
 	.in_ack_event   = dctcp_update_alpha,
 	.cwnd_event	= dctcp_cwnd_event,
+	.cwnd_event_tx_start = dctcp_cwnd_event_tx_start,
 	.ssthresh	= dctcp_ssthresh,
 	.cong_avoid	= tcp_reno_cong_avoid,
 	.undo_cwnd	= dctcp_cwnd_undo,
@@ -275,6 +280,7 @@ BTF_KFUNCS_START(tcp_dctcp_check_kfunc_ids)
 BTF_ID_FLAGS(func, dctcp_init)
 BTF_ID_FLAGS(func, dctcp_update_alpha)
 BTF_ID_FLAGS(func, dctcp_cwnd_event)
+BTF_ID_FLAGS(func, dctcp_cwnd_event_tx_start)
 BTF_ID_FLAGS(func, dctcp_ssthresh)
 BTF_ID_FLAGS(func, dctcp_cwnd_undo)
 BTF_ID_FLAGS(func, dctcp_state)
diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
index 786848ad37ea8d5f9bd817666181905f3f6ec9d4..cf12fb6be079d8ccd65f297a3a90a9a5e90036e8 100644
--- a/net/ipv4/tcp_vegas.c
+++ b/net/ipv4/tcp_vegas.c
@@ -151,12 +151,17 @@ EXPORT_SYMBOL_GPL(tcp_vegas_state);
  */
 void tcp_vegas_cwnd_event(struct sock *sk, enum tcp_ca_event event)
 {
-	if (event == CA_EVENT_CWND_RESTART ||
-	    event == CA_EVENT_TX_START)
+	if (event == CA_EVENT_CWND_RESTART)
 		tcp_vegas_init(sk);
 }
 EXPORT_SYMBOL_GPL(tcp_vegas_cwnd_event);
 
+void tcp_vegas_cwnd_event_tx_start(struct sock *sk)
+{
+	tcp_vegas_init(sk);
+}
+EXPORT_SYMBOL_GPL(tcp_vegas_cwnd_event_tx_start);
+
 static inline u32 tcp_vegas_ssthresh(struct tcp_sock *tp)
 {
 	return  min(tp->snd_ssthresh, tcp_snd_cwnd(tp));
diff --git a/net/ipv4/tcp_vegas.h b/net/ipv4/tcp_vegas.h
index 4f24d0e37d9c1e9d5336e8e99253e660143362c9..602af8e600c7f85603ff1a53008e1144617ea14b 100644
--- a/net/ipv4/tcp_vegas.h
+++ b/net/ipv4/tcp_vegas.h
@@ -20,6 +20,7 @@ void tcp_vegas_init(struct sock *sk);
 void tcp_vegas_state(struct sock *sk, u8 ca_state);
 void tcp_vegas_pkts_acked(struct sock *sk, const struct ack_sample *sample);
 void tcp_vegas_cwnd_event(struct sock *sk, enum tcp_ca_event event);
+void tcp_vegas_cwnd_event_tx_start(struct sock *sk);
 size_t tcp_vegas_get_info(struct sock *sk, u32 ext, int *attr,
 			  union tcp_cc_info *info);
 
diff --git a/net/ipv4/tcp_veno.c b/net/ipv4/tcp_veno.c
index 366ff6f214b2ee746cecdf10353e4624252478e0..1b2e1b947901f3ca6004aced8e6d39c131f1fb68 100644
--- a/net/ipv4/tcp_veno.c
+++ b/net/ipv4/tcp_veno.c
@@ -112,10 +112,15 @@ static void tcp_veno_state(struct sock *sk, u8 ca_state)
  */
 static void tcp_veno_cwnd_event(struct sock *sk, enum tcp_ca_event event)
 {
-	if (event == CA_EVENT_CWND_RESTART || event == CA_EVENT_TX_START)
+	if (event == CA_EVENT_CWND_RESTART)
 		tcp_veno_init(sk);
 }
 
+static void tcp_veno_cwnd_event_tx_start(struct sock *sk)
+{
+	tcp_veno_init(sk);
+}
+
 static void tcp_veno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -213,6 +218,7 @@ static struct tcp_congestion_ops tcp_veno __read_mostly = {
 	.pkts_acked	= tcp_veno_pkts_acked,
 	.set_state	= tcp_veno_state,
 	.cwnd_event	= tcp_veno_cwnd_event,
+	.cwnd_event_tx_start = tcp_veno_cwnd_event_tx_start,
 
 	.owner		= THIS_MODULE,
 	.name		= "veno",
diff --git a/net/ipv4/tcp_yeah.c b/net/ipv4/tcp_yeah.c
index 18b07ff5d20e6c5eefe9ab54c6b8e429f01d64b9..b22b3dccd05efddfe11203578950eddecee14887 100644
--- a/net/ipv4/tcp_yeah.c
+++ b/net/ipv4/tcp_yeah.c
@@ -212,6 +212,7 @@ static struct tcp_congestion_ops tcp_yeah __read_mostly = {
 	.cong_avoid	= tcp_yeah_cong_avoid,
 	.set_state	= tcp_vegas_state,
 	.cwnd_event	= tcp_vegas_cwnd_event,
+	.cwnd_event_tx_start = tcp_vegas_cwnd_event_tx_start,
 	.get_info	= tcp_vegas_get_info,
 	.pkts_acked	= tcp_vegas_pkts_acked,
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
index 9af19dfe4e80b00bc09fe40c7d6c9642cdfb4a23..bccf677b94b61226a3dd0517e0b2e64168de711f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
@@ -23,7 +23,7 @@
 #define TCP_REORDERING (12)
 
 extern void cubictcp_init(struct sock *sk) __ksym;
-extern void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event) __ksym;
+extern void cubictcp_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern __u32 cubictcp_recalc_ssthresh(struct sock *sk) __ksym;
 extern void cubictcp_state(struct sock *sk, __u8 new_state) __ksym;
 extern __u32 tcp_reno_undo_cwnd(struct sock *sk) __ksym;
@@ -108,9 +108,9 @@ void BPF_PROG(bpf_cubic_init, struct sock *sk)
 }
 
 SEC("struct_ops")
-void BPF_PROG(bpf_cubic_cwnd_event, struct sock *sk, enum tcp_ca_event event)
+void BPF_PROG(bpf_cubic_cwnd_event_tx_start, struct sock *sk)
 {
-	cubictcp_cwnd_event(sk, event);
+	cubictcp_cwnd_event_tx_start(sk);
 }
 
 SEC("struct_ops")
@@ -172,7 +172,7 @@ struct tcp_congestion_ops cc_cubic = {
 	.cong_control	= (void *)bpf_cubic_cong_control,
 	.set_state	= (void *)bpf_cubic_state,
 	.undo_cwnd	= (void *)bpf_cubic_undo_cwnd,
-	.cwnd_event	= (void *)bpf_cubic_cwnd_event,
+	.cwnd_event_tx_start	= (void *)bpf_cubic_cwnd_event_tx_start,
 	.pkts_acked     = (void *)bpf_cubic_acked,
 	.name		= "bpf_cc_cubic",
 };
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index 46fb2b37d3a70671485af37ed700a991c0975cd2..ce18a4db813fab877aec0c73d72cc9c958312ad3 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -185,24 +185,21 @@ void BPF_PROG(bpf_cubic_init, struct sock *sk)
 }
 
 SEC("struct_ops")
-void BPF_PROG(bpf_cubic_cwnd_event, struct sock *sk, enum tcp_ca_event event)
+void BPF_PROG(bpf_cubic_cwnd_event_tx_start, struct sock *sk)
 {
-	if (event == CA_EVENT_TX_START) {
-		struct bpf_bictcp *ca = inet_csk_ca(sk);
-		__u32 now = tcp_jiffies32;
-		__s32 delta;
-
-		delta = now - tcp_sk(sk)->lsndtime;
-
-		/* We were application limited (idle) for a while.
-		 * Shift epoch_start to keep cwnd growth to cubic curve.
-		 */
-		if (ca->epoch_start && delta > 0) {
-			ca->epoch_start += delta;
-			if (after(ca->epoch_start, now))
-				ca->epoch_start = now;
-		}
-		return;
+	struct bpf_bictcp *ca = inet_csk_ca(sk);
+	__u32 now = tcp_jiffies32;
+	__s32 delta;
+
+	delta = now - tcp_sk(sk)->lsndtime;
+
+	/* We were application limited (idle) for a while.
+	 * Shift epoch_start to keep cwnd growth to cubic curve.
+	 */
+	if (ca->epoch_start && delta > 0) {
+		ca->epoch_start += delta;
+		if (after(ca->epoch_start, now))
+			ca->epoch_start = now;
 	}
 }
 
@@ -537,7 +534,7 @@ struct tcp_congestion_ops cubic = {
 	.cong_avoid	= (void *)bpf_cubic_cong_avoid,
 	.set_state	= (void *)bpf_cubic_state,
 	.undo_cwnd	= (void *)bpf_cubic_undo_cwnd,
-	.cwnd_event	= (void *)bpf_cubic_cwnd_event,
+	.cwnd_event_tx_start	= (void *)bpf_cubic_cwnd_event_tx_start,
 	.pkts_acked     = (void *)bpf_cubic_acked,
 	.name		= "bpf_cubic",
 };
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
index f95862f570b73f4c86fa6d7b6a912c4b055d02fb..0a3e9d35bf6f0c4c988c741c010fb7f3405fb43c 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -8,7 +8,7 @@ extern void bbr_init(struct sock *sk) __ksym;
 extern void bbr_main(struct sock *sk, u32 ack, int flag, const struct rate_sample *rs) __ksym;
 extern u32 bbr_sndbuf_expand(struct sock *sk) __ksym;
 extern u32 bbr_undo_cwnd(struct sock *sk) __ksym;
-extern void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event) __ksym;
+extern void bbr_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern u32 bbr_ssthresh(struct sock *sk) __ksym;
 extern u32 bbr_min_tso_segs(struct sock *sk) __ksym;
 extern void bbr_set_state(struct sock *sk, u8 new_state) __ksym;
@@ -16,6 +16,7 @@ extern void bbr_set_state(struct sock *sk, u8 new_state) __ksym;
 extern void dctcp_init(struct sock *sk) __ksym;
 extern void dctcp_update_alpha(struct sock *sk, u32 flags) __ksym;
 extern void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev) __ksym;
+extern void dctcp_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern u32 dctcp_ssthresh(struct sock *sk) __ksym;
 extern u32 dctcp_cwnd_undo(struct sock *sk) __ksym;
 extern void dctcp_state(struct sock *sk, u8 new_state) __ksym;
@@ -24,7 +25,7 @@ extern void cubictcp_init(struct sock *sk) __ksym;
 extern u32 cubictcp_recalc_ssthresh(struct sock *sk) __ksym;
 extern void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked) __ksym;
 extern void cubictcp_state(struct sock *sk, u8 new_state) __ksym;
-extern void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event) __ksym;
+extern void cubictcp_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern void cubictcp_acked(struct sock *sk, const struct ack_sample *sample) __ksym;
 
 SEC("struct_ops")
@@ -69,9 +70,15 @@ u32 BPF_PROG(undo_cwnd, struct sock *sk)
 SEC("struct_ops")
 void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
 {
-	bbr_cwnd_event(sk, event);
 	dctcp_cwnd_event(sk, event);
-	cubictcp_cwnd_event(sk, event);
+}
+
+SEC("struct_ops")
+void BPF_PROG(cwnd_event_tx_start, struct sock *sk)
+{
+	bbr_cwnd_event_tx_start(sk);
+	dctcp_cwnd_event_tx_start(sk);
+	cubictcp_cwnd_event_tx_start(sk);
 }
 
 SEC("struct_ops")
@@ -111,6 +118,7 @@ struct tcp_congestion_ops tcp_ca_kfunc = {
 	.sndbuf_expand	= (void *)sndbuf_expand,
 	.undo_cwnd	= (void *)undo_cwnd,
 	.cwnd_event	= (void *)cwnd_event,
+	.cwnd_event_tx_start = (void *)cwnd_event_tx_start,
 	.ssthresh	= (void *)ssthresh,
 	.min_tso_segs	= (void *)min_tso_segs,
 	.set_state	= (void *)set_state,
-- 
2.53.0.983.g0bb29b3bc5-goog


