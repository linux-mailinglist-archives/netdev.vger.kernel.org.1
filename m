Return-Path: <netdev+bounces-279146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP0aCrVB4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57841477F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24233066693
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1573ED13F;
	Thu, 16 Apr 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pU/f37mP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8223ED5A7
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369815; cv=none; b=SyhrY1FifAnThxf0fD/WHadHeUOoWIKkYdEYXLu1+VVYJ4AarUGMD5A5RZWPMcY5GlBwuoSVjYp1vDNEVyQAkO7ITQgHVmveZhLJr5uC1H1AAyDahqxNbieaM+lL4RDYFkqRN+DobAnPiftElV/sN9XdCnBqMYJ8Bv00pDKcWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369815; c=relaxed/simple;
	bh=NY+7fTgb5K3VaDGtR4Uv+BwX/i/tmHo/6OloHzPLWBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5VKkeZNYWmrrtA/LEN9G2WI13Lkwk966dwqRRN+3gKGO9MRfaeTj/hbDddzsldSavs80F0NXv0m/CHV213Pef7S9Ti7DiQ8FvfdNbW+8NZu6GsS8Qsvx4srYijcdTqFd2AUHJiQAH4xijgfy5xLDmF+wBDeOViSMW5hgBGl9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pU/f37mP; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d9a6a853bso205184251cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369808; x=1776974608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dUiTIZgxIxP+roqgsZaqtlSBBxlUtBa8zoLft159zI=;
        b=pU/f37mPt0aebyimEONTjhqmhdBP12ahnUeJaSXZ2394K42RqTiw14dtvKmLtYeyWe
         9kO97AJihqF1GfyCzK7pibBoAShs+pqvjJ6YrW2sqTaeo0x7K6rdcwUBQs0lE7RSXY7Z
         Ixo5gNiRVElzMDkvu3hDl956fvQXov8Kt9M4V1mPJQhDFDFmRuu2KuSmCMFFAhqELWl4
         hWjbM5M2nsPHwQYl3yMTst0Nve1i2cHRwOlzoTyMcjrpS4duenK4oMM8wgfPS5zyirkC
         7eG04zvaa5sAaEqUys6madoxNvxHwQhihb/KiA9wYK+wJnCxhwX//CEEwAkrEp/Xx2bI
         Mc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369808; x=1776974608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dUiTIZgxIxP+roqgsZaqtlSBBxlUtBa8zoLft159zI=;
        b=j5nMjSl60pPuHKXNzgI3qIde+UcF2mlduJMrkQ6WQjXd41Eq0pC2MYsbxxDaefl3nw
         vDQ1sgMWGRw9+ndZpl/CHTeP//Ku3pKqh86IzofsebAOAtv4z2yy/W+ibQDSAyjyuJJ+
         T03QFWy7gePxaV3xhPQOJR88UtG8ULxSr/jEtxigevhO6GqwpEDXDq7l7n9nZwwbM5dl
         eg1OyM9/Nh5odTYS+G2jpQPVcgr6on8gYueel2wXfB4LZ+/BpbrA4XnX0TpEjHp2nzex
         PZGOKm3QcodXR29CTa+Z8ko6C/LqTCct90NQeMbijCpK4klLytrxuv4/RDqi5YCX4MAA
         1Lig==
X-Forwarded-Encrypted: i=1; AFNElJ/7eQIGVCUVos8yyuukNvTZk2MCz5Iho444c4cqtbDmTxiHLi7I39eVAZg3+k1PZWBtUqYT23g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7pb6PY9VhbrfVxKtbMk4q0xTmOBVtpdorIHyVLNB94at5wsaH
	o7QDdUTP3ij0D1gKK+0y5H0KVAlgAV0R/Ser+F/in4+byXPxGezr4SRfEyffK6v6hx8alOxQcxc
	okLljiHnCwq3uZA==
X-Received: from qtkm9.prod.google.com ([2002:a05:622a:1189:b0:509:16b2:dc6c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:588b:b0:50b:4337:179a with SMTP id d75a77b69052e-50e349009f6mr8814981cf.3.1776369807829;
 Thu, 16 Apr 2026 13:03:27 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:09 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-5-edumazet@google.com>
Subject: [PATCH net 04/14] tcp: annotate data-races around tp->snd_ssthresh
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
	TAGGED_FROM(0.00)[bounces-279146-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6E57841477F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 7156d194a077 ("tcp: add snd_ssthresh stat in SCM_TIMESTAMPING_OPT_STATS")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/filter.c       | 2 +-
 net/ipv4/tcp.c          | 4 ++--
 net/ipv4/tcp_bbr.c      | 6 +++---
 net/ipv4/tcp_bic.c      | 2 +-
 net/ipv4/tcp_cdg.c      | 4 ++--
 net/ipv4/tcp_cubic.c    | 6 +++---
 net/ipv4/tcp_dctcp.c    | 2 +-
 net/ipv4/tcp_input.c    | 8 ++++----
 net/ipv4/tcp_metrics.c  | 4 ++--
 net/ipv4/tcp_nv.c       | 4 ++--
 net/ipv4/tcp_output.c   | 4 ++--
 net/ipv4/tcp_vegas.c    | 9 +++++----
 net/ipv4/tcp_westwood.c | 4 ++--
 net/ipv4/tcp_yeah.c     | 3 ++-
 14 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index fcfcb72663ca3798bb33d33275d18fc73071c8d4..3b5609fb96de5e92880c6170a7fcf54da4612818 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5396,7 +5396,7 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 		if (val <= 0)
 			return -EINVAL;
 		tp->snd_cwnd_clamp = val;
-		tp->snd_ssthresh = val;
+		WRITE_ONCE(tp->snd_ssthresh, val);
 		break;
 	case TCP_BPF_DELACK_MAX:
 		timeout = usecs_to_jiffies(val);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 24ba80d244b1fb69102b587b568cebe7b78dff9d..802a9ea05211f8eab30b6f937a459a270476974d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3425,7 +3425,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
 	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
 	WRITE_ONCE(icsk->icsk_delack_max, TCP_DELACK_MAX);
-	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
+	WRITE_ONCE(tp->snd_ssthresh, TCP_INFINITE_SSTHRESH);
 	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
 	tp->snd_cwnd_cnt = 0;
 	tp->is_cwnd_limited = 0;
@@ -4452,7 +4452,7 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u8(stats, TCP_NLA_RECUR_RETRANS,
 		   READ_ONCE(inet_csk(sk)->icsk_retransmits));
 	nla_put_u8(stats, TCP_NLA_DELIVERY_RATE_APP_LMT, data_race(!!tp->rate_app_limited));
-	nla_put_u32(stats, TCP_NLA_SND_SSTHRESH, tp->snd_ssthresh);
+	nla_put_u32(stats, TCP_NLA_SND_SSTHRESH, READ_ONCE(tp->snd_ssthresh));
 	nla_put_u32(stats, TCP_NLA_DELIVERED, tp->delivered);
 	nla_put_u32(stats, TCP_NLA_DELIVERED_CE, tp->delivered_ce);
 
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 1ddc20a399b07054f8175b5f6459f8ae6dbf34bb..aec7805b1d37634783491649da1fa01602061781 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -897,8 +897,8 @@ static void bbr_check_drain(struct sock *sk, const struct rate_sample *rs)
 
 	if (bbr->mode == BBR_STARTUP && bbr_full_bw_reached(sk)) {
 		bbr->mode = BBR_DRAIN;	/* drain queue we created */
-		tcp_sk(sk)->snd_ssthresh =
-				bbr_inflight(sk, bbr_max_bw(sk), BBR_UNIT);
+		WRITE_ONCE(tcp_sk(sk)->snd_ssthresh,
+			   bbr_inflight(sk, bbr_max_bw(sk), BBR_UNIT));
 	}	/* fall through to check if in-flight is already small: */
 	if (bbr->mode == BBR_DRAIN &&
 	    bbr_packets_in_net_at_edt(sk, tcp_packets_in_flight(tcp_sk(sk))) <=
@@ -1043,7 +1043,7 @@ __bpf_kfunc static void bbr_init(struct sock *sk)
 	struct bbr *bbr = inet_csk_ca(sk);
 
 	bbr->prior_cwnd = 0;
-	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
+	WRITE_ONCE(tp->snd_ssthresh, TCP_INFINITE_SSTHRESH);
 	bbr->rtt_cnt = 0;
 	bbr->next_rtt_delivered = tp->delivered;
 	bbr->prev_ca_state = TCP_CA_Open;
diff --git a/net/ipv4/tcp_bic.c b/net/ipv4/tcp_bic.c
index 58358bf92e1b8ac43c07789dac9f6031fa2e03dd..65444ff142413aa7ea6151f1cb3cef7d14f253eb 100644
--- a/net/ipv4/tcp_bic.c
+++ b/net/ipv4/tcp_bic.c
@@ -74,7 +74,7 @@ static void bictcp_init(struct sock *sk)
 	bictcp_reset(ca);
 
 	if (initial_ssthresh)
-		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
+		WRITE_ONCE(tcp_sk(sk)->snd_ssthresh, initial_ssthresh);
 }
 
 /*
diff --git a/net/ipv4/tcp_cdg.c b/net/ipv4/tcp_cdg.c
index ceabfd690a296739323a795da5e1fc7453229b3f..0812c390aee5643ee39209f47e8ae901045dc498 100644
--- a/net/ipv4/tcp_cdg.c
+++ b/net/ipv4/tcp_cdg.c
@@ -162,7 +162,7 @@ static void tcp_cdg_hystart_update(struct sock *sk)
 				NET_ADD_STATS(sock_net(sk),
 					      LINUX_MIB_TCPHYSTARTTRAINCWND,
 					      tcp_snd_cwnd(tp));
-				tp->snd_ssthresh = tcp_snd_cwnd(tp);
+				WRITE_ONCE(tp->snd_ssthresh, tcp_snd_cwnd(tp));
 				return;
 			}
 		}
@@ -181,7 +181,7 @@ static void tcp_cdg_hystart_update(struct sock *sk)
 				NET_ADD_STATS(sock_net(sk),
 					      LINUX_MIB_TCPHYSTARTDELAYCWND,
 					      tcp_snd_cwnd(tp));
-				tp->snd_ssthresh = tcp_snd_cwnd(tp);
+				WRITE_ONCE(tp->snd_ssthresh, tcp_snd_cwnd(tp));
 			}
 		}
 	}
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index ab78b5ae8d0e3d13a39bd1adf1e105b84f806b63..119bf8cbb007c22993367f0f1452a2db4ed9d92b 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -136,7 +136,7 @@ __bpf_kfunc static void cubictcp_init(struct sock *sk)
 		bictcp_hystart_reset(sk);
 
 	if (!hystart && initial_ssthresh)
-		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
+		WRITE_ONCE(tcp_sk(sk)->snd_ssthresh, initial_ssthresh);
 }
 
 __bpf_kfunc static void cubictcp_cwnd_event_tx_start(struct sock *sk)
@@ -420,7 +420,7 @@ static void hystart_update(struct sock *sk, u32 delay)
 				NET_ADD_STATS(sock_net(sk),
 					      LINUX_MIB_TCPHYSTARTTRAINCWND,
 					      tcp_snd_cwnd(tp));
-				tp->snd_ssthresh = tcp_snd_cwnd(tp);
+				WRITE_ONCE(tp->snd_ssthresh, tcp_snd_cwnd(tp));
 			}
 		}
 	}
@@ -440,7 +440,7 @@ static void hystart_update(struct sock *sk, u32 delay)
 				NET_ADD_STATS(sock_net(sk),
 					      LINUX_MIB_TCPHYSTARTDELAYCWND,
 					      tcp_snd_cwnd(tp));
-				tp->snd_ssthresh = tcp_snd_cwnd(tp);
+				WRITE_ONCE(tp->snd_ssthresh, tcp_snd_cwnd(tp));
 			}
 		}
 	}
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 96c99999e09dde9de9c337e4d6c692f517467c7b..274e628e7cf8621fd955528c8353001e773efb21 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -177,7 +177,7 @@ static void dctcp_react_to_loss(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	ca->loss_cwnd = tcp_snd_cwnd(tp);
-	tp->snd_ssthresh = max(tcp_snd_cwnd(tp) >> 1U, 2U);
+	WRITE_ONCE(tp->snd_ssthresh, max(tcp_snd_cwnd(tp) >> 1U, 2U));
 }
 
 __bpf_kfunc static void dctcp_state(struct sock *sk, u8 new_state)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6bb6bf049a35ac91fd53e3e66691f64fc4c93648..c6361447535f0a2b72eccb6fede4618471e38ae5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2567,7 +2567,7 @@ void tcp_enter_loss(struct sock *sk)
 	    (icsk->icsk_ca_state == TCP_CA_Loss && !icsk->icsk_retransmits)) {
 		tp->prior_ssthresh = tcp_current_ssthresh(sk);
 		tp->prior_cwnd = tcp_snd_cwnd(tp);
-		tp->snd_ssthresh = icsk->icsk_ca_ops->ssthresh(sk);
+		WRITE_ONCE(tp->snd_ssthresh, icsk->icsk_ca_ops->ssthresh(sk));
 		tcp_ca_event(sk, CA_EVENT_LOSS);
 		tcp_init_undo(tp);
 	}
@@ -2860,7 +2860,7 @@ static void tcp_undo_cwnd_reduction(struct sock *sk, bool unmark_loss)
 		tcp_snd_cwnd_set(tp, icsk->icsk_ca_ops->undo_cwnd(sk));
 
 		if (tp->prior_ssthresh > tp->snd_ssthresh) {
-			tp->snd_ssthresh = tp->prior_ssthresh;
+			WRITE_ONCE(tp->snd_ssthresh, tp->prior_ssthresh);
 			tcp_ecn_withdraw_cwr(tp);
 		}
 	}
@@ -2978,7 +2978,7 @@ static void tcp_init_cwnd_reduction(struct sock *sk)
 	tp->prior_cwnd = tcp_snd_cwnd(tp);
 	tp->prr_delivered = 0;
 	tp->prr_out = 0;
-	tp->snd_ssthresh = inet_csk(sk)->icsk_ca_ops->ssthresh(sk);
+	WRITE_ONCE(tp->snd_ssthresh, inet_csk(sk)->icsk_ca_ops->ssthresh(sk));
 	tcp_ecn_queue_cwr(tp);
 }
 
@@ -3120,7 +3120,7 @@ static void tcp_non_congestion_loss_retransmit(struct sock *sk)
 
 	if (icsk->icsk_ca_state != TCP_CA_Loss) {
 		tp->high_seq = tp->snd_nxt;
-		tp->snd_ssthresh = tcp_current_ssthresh(sk);
+		WRITE_ONCE(tp->snd_ssthresh, tcp_current_ssthresh(sk));
 		tp->prior_ssthresh = 0;
 		tp->undo_marker = 0;
 		tcp_set_ca_state(sk, TCP_CA_Loss);
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 7a9d6d9006f651e91054d3369b47758a6c35253b..dc0c081fc1f33f735a38aaae8a7b4ab3d633b148 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -490,9 +490,9 @@ void tcp_init_metrics(struct sock *sk)
 	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
 	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
 	if (val) {
-		tp->snd_ssthresh = val;
+		WRITE_ONCE(tp->snd_ssthresh, val);
 		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
-			tp->snd_ssthresh = tp->snd_cwnd_clamp;
+			WRITE_ONCE(tp->snd_ssthresh, tp->snd_cwnd_clamp);
 	}
 	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
 	if (val && tp->reordering != val)
diff --git a/net/ipv4/tcp_nv.c b/net/ipv4/tcp_nv.c
index a60662f4bdf92cba1d92a3eedd7c607d1537d7f2..f345897a68dfcfe0f620ba50ff88f08b1c23e43f 100644
--- a/net/ipv4/tcp_nv.c
+++ b/net/ipv4/tcp_nv.c
@@ -396,8 +396,8 @@ static void tcpnv_acked(struct sock *sk, const struct ack_sample *sample)
 
 			/* We have enough data to determine we are congested */
 			ca->nv_allow_cwnd_growth = 0;
-			tp->snd_ssthresh =
-				(nv_ssthresh_factor * max_win) >> 3;
+			WRITE_ONCE(tp->snd_ssthresh,
+				   (nv_ssthresh_factor * max_win) >> 3);
 			if (tcp_snd_cwnd(tp) - max_win > 2) {
 				/* gap > 2, we do exponential cwnd decrease */
 				int dec;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d8e8bba2d03a3be5e7a9ebac16e39f4a29ae6037..2663505a0dd7a0eae69f6a91250b4a0b6f357f7d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -171,7 +171,7 @@ void tcp_cwnd_restart(struct sock *sk, s32 delta)
 
 	tcp_ca_event(sk, CA_EVENT_CWND_RESTART);
 
-	tp->snd_ssthresh = tcp_current_ssthresh(sk);
+	WRITE_ONCE(tp->snd_ssthresh, tcp_current_ssthresh(sk));
 	restart_cwnd = min(restart_cwnd, cwnd);
 
 	while ((delta -= inet_csk(sk)->icsk_rto) > 0 && cwnd > restart_cwnd)
@@ -2143,7 +2143,7 @@ static void tcp_cwnd_application_limited(struct sock *sk)
 		u32 init_win = tcp_init_cwnd(tp, __sk_dst_get(sk));
 		u32 win_used = max(tp->snd_cwnd_used, init_win);
 		if (win_used < tcp_snd_cwnd(tp)) {
-			tp->snd_ssthresh = tcp_current_ssthresh(sk);
+			WRITE_ONCE(tp->snd_ssthresh, tcp_current_ssthresh(sk));
 			tcp_snd_cwnd_set(tp, (tcp_snd_cwnd(tp) + win_used) >> 1);
 		}
 		tp->snd_cwnd_used = 0;
diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
index 950a66966059e89fc108a31c106805a0f76fc6f0..574453af6bc03c95e7dee69bff7dde2b63fe65c4 100644
--- a/net/ipv4/tcp_vegas.c
+++ b/net/ipv4/tcp_vegas.c
@@ -245,7 +245,8 @@ static void tcp_vegas_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 				 */
 				tcp_snd_cwnd_set(tp, min(tcp_snd_cwnd(tp),
 							 (u32)target_cwnd + 1));
-				tp->snd_ssthresh = tcp_vegas_ssthresh(tp);
+				WRITE_ONCE(tp->snd_ssthresh,
+					   tcp_vegas_ssthresh(tp));
 
 			} else if (tcp_in_slow_start(tp)) {
 				/* Slow start.  */
@@ -261,8 +262,8 @@ static void tcp_vegas_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 					 * we slow down.
 					 */
 					tcp_snd_cwnd_set(tp, tcp_snd_cwnd(tp) - 1);
-					tp->snd_ssthresh
-						= tcp_vegas_ssthresh(tp);
+					WRITE_ONCE(tp->snd_ssthresh,
+						   tcp_vegas_ssthresh(tp));
 				} else if (diff < alpha) {
 					/* We don't have enough extra packets
 					 * in the network, so speed up.
@@ -280,7 +281,7 @@ static void tcp_vegas_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 			else if (tcp_snd_cwnd(tp) > tp->snd_cwnd_clamp)
 				tcp_snd_cwnd_set(tp, tp->snd_cwnd_clamp);
 
-			tp->snd_ssthresh = tcp_current_ssthresh(sk);
+			WRITE_ONCE(tp->snd_ssthresh, tcp_current_ssthresh(sk));
 		}
 
 		/* Wipe the slate clean for the next RTT. */
diff --git a/net/ipv4/tcp_westwood.c b/net/ipv4/tcp_westwood.c
index c6e97141eef2591c5ab50f4058a5377e0855313f..b5a42adfd6ca1fd93a91b99d7aa16bb4e64a9b3e 100644
--- a/net/ipv4/tcp_westwood.c
+++ b/net/ipv4/tcp_westwood.c
@@ -244,11 +244,11 @@ static void tcp_westwood_event(struct sock *sk, enum tcp_ca_event event)
 
 	switch (event) {
 	case CA_EVENT_COMPLETE_CWR:
-		tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);
+		WRITE_ONCE(tp->snd_ssthresh, tcp_westwood_bw_rttmin(sk));
 		tcp_snd_cwnd_set(tp, tp->snd_ssthresh);
 		break;
 	case CA_EVENT_LOSS:
-		tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);
+		WRITE_ONCE(tp->snd_ssthresh, tcp_westwood_bw_rttmin(sk));
 		/* Update RTT_min when next ack arrives */
 		w->reset_rtt_min = 1;
 		break;
diff --git a/net/ipv4/tcp_yeah.c b/net/ipv4/tcp_yeah.c
index b22b3dccd05efddfe11203578950eddecee14887..9e581154f18f11832fa832544217fc9072b4f452 100644
--- a/net/ipv4/tcp_yeah.c
+++ b/net/ipv4/tcp_yeah.c
@@ -147,7 +147,8 @@ static void tcp_yeah_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 					tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp),
 								 yeah->reno_count));
 
-					tp->snd_ssthresh = tcp_snd_cwnd(tp);
+					WRITE_ONCE(tp->snd_ssthresh,
+						   tcp_snd_cwnd(tp));
 				}
 
 				if (yeah->reno_count <= 2)
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


