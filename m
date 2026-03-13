Return-Path: <netdev+bounces-267588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /PsJIoJztGmvoQAAu9opvQ
	(envelope-from <netdev+bounces-267588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:28:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0180289B55
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7270430D2897
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D43D3491;
	Fri, 13 Mar 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLoIiqjZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37E3CD8B8
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433686; cv=none; b=UOFGgM14u3wNIh7uRwQjTiUdCjge1O+AYpIgEfyP67qxy+f7NIxz8r4LxPUEAEnkGzeGtpmJaeNJ/IJlaGccvHNAwoOla7zGw4UEWruU2U3ICOqxzTeUU172uf66Br3c+qyCEbJj7Vye4S4w9N4PynUlZnvwAl4xqV3xt8oRvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433686; c=relaxed/simple;
	bh=jnDsaE7jv2pbANxoBK/+aURR4ySaUKPeDAcvrNIU9Rw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fV/DPabiaxs+GlEjsFrZLAPDoUIsg/lnPRE7dsNhEH8SmU+wLEIbG7NKtmj6jW+LHerpHEHhcrl2zdKSwR2mYoyXp5ZutA0QmuzA/3Gu/K1h0b2mbevak18/0a60BNozaSbyMrk2Go68hkvWZ8gessJrCGqTKtmt/YdJ7yl1x+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLoIiqjZ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cd773dd409so405223985a.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773433683; x=1774038483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EecwBVybwJxTmAqDCdtcxwCxKXQrFd7U2HePZufWylk=;
        b=sLoIiqjZeRccft4jkYAhsXwgblmhLkChYBJBONbLtCsfEYl+Zh3XmJlWGYf/4A1y0n
         N6TFe1BFSMfuVGK8AkeuDyQkLhuMJWErgjgzIk7adVbJBwTHHzaRaCQoy2Vh3qfhZV+3
         hiuwI3hN83ZRTTr3Zm1UsaAGcTFU0ZTD3akaGcz7v6nPD4OwY2Ep+9CZ8MMR7SQz/jLe
         XSUFJZgwlTrGn0fuoZBdvVTfZQnlGOQugLuMvU6E4ouTWfAE/HJXJzTtAa8NXUM4HtNL
         lsnuqHYigOi8VryYGaQlIHedMCC7hX+eOtaMYj7G8SvSwr2wtGw4pWG5fUy6LdxYlTk3
         NtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433683; x=1774038483;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EecwBVybwJxTmAqDCdtcxwCxKXQrFd7U2HePZufWylk=;
        b=YwYYR6Fis1yQ+hTy4Gx9YprYBHEZOZn/jNxGcRgmVdbLEKjwZYS+mCJOA5JVKHcSwE
         QjkYWFVpwfhq2sWZfDPAFix6m1bMspciShfA4ny4pU5Q965e5VeL4stiEG0b+oFGxDXK
         SZ5IlKBohHN6+iMdDsNmfjkSmsHXLXHyPpslxluLdGJow5xT3Ysxr4sb66WV48/CEibu
         asqurJb7mv8NChtxurkRP/QdFdVycRxLw4OC6zzCqGYEY7a6CpaCKinC06VLW6+Ny43R
         4KqKDnnaSmakiR0rSM2+eYFb6y4fHCFhchdfVSP6g9Gd6hfKfvcdNnK/zKljxUFivtoh
         2abQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH/uFyvdZyugdVQnNausZPErU/QcYjvQ2rJbtULmFlG8Ryio0zMKwCQ4epJvXxEwb2J/2j4LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyREvMsVucAgjewVbY0UtEO9TZ54T5TY6dhyfPBhfkvVA7Jasc/
	6AjG/mPmfdwY83w9c3rmTD26g/wseyiSgMc02RgzabczJCr9iFc23TgPih0yZuuZBADpOdn2+Pi
	9BazITKKzCDyvCQ==
X-Received: from qkkg23.prod.google.com ([2002:a05:620a:1097:b0:8b2:fb0e:83aa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:690d:b0:8cd:8f18:d1c4 with SMTP id af79cd13be357-8cdb5b3203amr593869185a.56.1773433683271;
 Fri, 13 Mar 2026 13:28:03 -0700 (PDT)
Date: Fri, 13 Mar 2026 20:28:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.880.g73c4285caa-goog
Message-ID: <20260313202802.1201129-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267588-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0180289B55
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
 include/net/tcp.h                             |  8 +++++
 net/ipv4/tcp_bbr.c                            |  8 ++---
 net/ipv4/tcp_cubic.c                          | 35 +++++++++----------
 net/ipv4/tcp_dctcp.c                          | 11 ++++--
 net/ipv4/tcp_vegas.c                          |  9 +++--
 net/ipv4/tcp_vegas.h                          |  1 +
 net/ipv4/tcp_veno.c                           |  8 ++++-
 net/ipv4/tcp_yeah.c                           |  1 +
 .../selftests/bpf/progs/bpf_cc_cubic.c        |  6 ++--
 tools/testing/selftests/bpf/progs/bpf_cubic.c | 33 ++++++++---------
 .../selftests/bpf/progs/tcp_ca_kfunc.c        | 16 ++++++---
 11 files changed, 82 insertions(+), 54 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 48dffcca0a71b70d0c0fd49d89a66c4f6ae72a58..72a6f7c338725154b457b70eb08fd2a85ae6375f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1319,6 +1319,9 @@ struct tcp_congestion_ops {
 	/* call when cwnd event occurs (optional) */
 	void (*cwnd_event)(struct sock *sk, enum tcp_ca_event ev);
 
+	/* call when CA_EVENT_TX_START cwnd event occurs (optional) */
+	void (*cwnd_event_tx_start)(struct sock *sk);
+
 	/* call when ack arrives (optional) */
 	void (*in_ack_event)(struct sock *sk, u32 flags);
 
@@ -1418,6 +1421,11 @@ static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
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
index 03abe0848420d7fb7b514e6ad24f4c702954ab14..8ce84890feeea3094b6f46001295e2761c35f1da 100644
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
index 9af19dfe4e80b00bc09fe40c7d6c9642cdfb4a23..0aa47d99513d1f1af8f4be0b92a7632b699286dc 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
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
index f95862f570b73f4c86fa6d7b6a912c4b055d02fb..a4334cf4c6bd59a0552a5a2cccabf75489d46f58 100644
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
+void BPF_PROG(cwnd_event_tx_stat, struct sock *sk)
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
2.53.0.880.g73c4285caa-goog


