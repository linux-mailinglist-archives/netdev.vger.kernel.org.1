Return-Path: <netdev+bounces-84810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ACA89863F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F084FB26164
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9784D37;
	Thu,  4 Apr 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1FJRM54/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7184D12
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230956; cv=none; b=XjU77oELvZiSeafC3gBtGA5nDx2iNKpO4ja4gQ50prU8nUHc6a+Cp9iVxkkrtKSyNkzM5laxNhpeusZJtaje2UAPobdU+E1NRQ/RpWurXVZTzL4NvOW51VxYA0yIDcexjux5LvbhrJrDzbh7GnFvDpRgpyS/yr5iTwlN5j/GlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230956; c=relaxed/simple;
	bh=LKIvyXDy8TljehlEMIBbnxtuR75MpD0M9PjLbhm+XyA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gjp/FRNYH2yZWty9izIGv7RHE3mjcqUbqqpFrfKg7WbhPHitoXrLyzmGCwpgcIlygJlvThxBfCnYKo1NZSi/is61mTfOE3tAq/5FjjB2ST8fXx9yvaHEICPu0eig6eDlKhQ+jGcAvoa4Y//NAXOQiUYN4rHOnUyerKxLVbk69Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1FJRM54/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so188650276.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712230953; x=1712835753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MxftR2FyVCxPn9wDKkZj3NDuIW6tNG2j6/fLbDBaBhA=;
        b=1FJRM54/cxYPRWLvcqEu4byizZE1TVYxa5Jy+K5G725r4ASapuy581xSCLyq7v6YQi
         4K/rRuUKKLwRBMsCAibvy074RacHz2Sq7bRQUarR3Nc2A8aZK5tNE7yHOGDR8wynS5x/
         SnpBPJjg6dGJlP7uV6rNBAdgqywCiR27XoQ/N/ygcze+hjT879tj6h1smE4hmpxecXLD
         G2g6YoSsDb2WIUZSid0SVZ75rM9Ss8tZzzsbwdxSzeqjzgisGQc7Ipo3ekfxNfmKZjsm
         hn45p0vM+Y/eILZKIr0gFt9kXYLUvSBO75OpnPyMXbaq9nxjBA21iKZNPn/dX+5vDohm
         6eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230953; x=1712835753;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxftR2FyVCxPn9wDKkZj3NDuIW6tNG2j6/fLbDBaBhA=;
        b=AHgEHNh8C9NlZd6+qxs547QB3PL6ZjypoYugP8g4FNnP2DIMtzGjeRmKiXPPm2Yoy1
         QDEgcrzcHrQRLrO7yQyikuGP8ZfXMcY1w3B4VITYY7o6X3uULYZEByMdhm7YQyxJtnRE
         4G7su1B9qwNUt5G1xL4dgOfhhOlECEo3bR0AQRNGVcIuceiL7Pq0ocvHHZ3hKlWuWgbH
         SRSuZ3Vo93e6v8WKfo1EDXZBVmeJFTxvQq2lD9tvSWSz7M9L50DXsK27234x8JHVaE80
         GMbt2C/iVd/8G+PCr9TylSd/zZR0DUngLpseHaPnL//4aM4qHZN8gfd7MwrgPfblKw2b
         3B/Q==
X-Gm-Message-State: AOJu0YwrEIu8gxIRa22rjBczZas+F6reIpwH73i7ohe1aONXEhmEc02C
	/zqzMWijYj7gjw7euE/r01HlewWT3XhwyEULegg38knFsKvU7t1G2lhr8/q6iTzNAZR1QWY291W
	xQUdL1KBZAA==
X-Google-Smtp-Source: AGHT+IGBNxMtueWEPA0QSfSdQeQIqvKCdArIsNK+LljuGIRqgmunx7f9aa1Myo5yZuecRbaVqD77SQ4U6tzdog==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:725:b0:dd9:312c:83c8 with SMTP
 id l5-20020a056902072500b00dd9312c83c8mr213693ybt.10.1712230953172; Thu, 04
 Apr 2024 04:42:33 -0700 (PDT)
Date: Thu,  4 Apr 2024 11:42:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404114231.2195171-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: annotate data-races around tp->window_clamp
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tp->window_clamp can be read locklessly, add READ_ONCE()
and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/syncookies.c |  3 ++-
 net/ipv4/tcp.c        |  8 ++++----
 net/ipv4/tcp_input.c  | 17 ++++++++++-------
 net/ipv4/tcp_output.c | 18 ++++++++++--------
 net/ipv6/syncookies.c |  2 +-
 net/mptcp/protocol.c  |  2 +-
 net/mptcp/sockopt.c   |  2 +-
 7 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 500f665f98cbce4a3d681f8e39ecd368fe4013b1..b61d36810fe3fd62b1e5c5885bbaf20185f1abf0 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -462,7 +462,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
-	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
+	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :
+				dst_metric(&rt->dst, RTAX_WINDOW);
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	full_space = tcp_full_space(sk);
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e767721b3a588b5d56567ae7badf5dffcd35a76a..92ee60492314a1483cfbfa2f73d32fcad5632773 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1721,7 +1721,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	space = tcp_space_from_win(sk, val);
 	if (space > sk->sk_rcvbuf) {
 		WRITE_ONCE(sk->sk_rcvbuf, space);
-		tcp_sk(sk)->window_clamp = val;
+		WRITE_ONCE(tcp_sk(sk)->window_clamp, val);
 	}
 	return 0;
 }
@@ -3379,7 +3379,7 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 	if (!val) {
 		if (sk->sk_state != TCP_CLOSE)
 			return -EINVAL;
-		tp->window_clamp = 0;
+		WRITE_ONCE(tp->window_clamp, 0);
 	} else {
 		u32 new_rcv_ssthresh, old_window_clamp = tp->window_clamp;
 		u32 new_window_clamp = val < SOCK_MIN_RCVBUF / 2 ?
@@ -3388,7 +3388,7 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 		if (new_window_clamp == old_window_clamp)
 			return 0;
 
-		tp->window_clamp = new_window_clamp;
+		WRITE_ONCE(tp->window_clamp, new_window_clamp);
 		if (new_window_clamp < old_window_clamp) {
 			/* need to apply the reserved mem provisioning only
 			 * when shrinking the window clamp
@@ -4057,7 +4057,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
-		val = tp->window_clamp;
+		val = READ_ONCE(tp->window_clamp);
 		break;
 	case TCP_INFO: {
 		struct tcp_info info;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1b6cd384001202df5f8e8e8c73adff0db89ece63..8d44ab5671eacd4bc06647c7cca387a79e346618 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -563,19 +563,20 @@ static void tcp_init_buffer_space(struct sock *sk)
 	maxwin = tcp_full_space(sk);
 
 	if (tp->window_clamp >= maxwin) {
-		tp->window_clamp = maxwin;
+		WRITE_ONCE(tp->window_clamp, maxwin);
 
 		if (tcp_app_win && maxwin > 4 * tp->advmss)
-			tp->window_clamp = max(maxwin -
-					       (maxwin >> tcp_app_win),
-					       4 * tp->advmss);
+			WRITE_ONCE(tp->window_clamp,
+				   max(maxwin - (maxwin >> tcp_app_win),
+				       4 * tp->advmss));
 	}
 
 	/* Force reservation of one segment. */
 	if (tcp_app_win &&
 	    tp->window_clamp > 2 * tp->advmss &&
 	    tp->window_clamp + tp->advmss > maxwin)
-		tp->window_clamp = max(2 * tp->advmss, maxwin - tp->advmss);
+		WRITE_ONCE(tp->window_clamp,
+			   max(2 * tp->advmss, maxwin - tp->advmss));
 
 	tp->rcv_ssthresh = min(tp->rcv_ssthresh, tp->window_clamp);
 	tp->snd_cwnd_stamp = tcp_jiffies32;
@@ -773,7 +774,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
 			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 
 			/* Make the window clamp follow along.  */
-			tp->window_clamp = tcp_win_from_space(sk, rcvbuf);
+			WRITE_ONCE(tp->window_clamp,
+				   tcp_win_from_space(sk, rcvbuf));
 		}
 	}
 	tp->rcvq_space.space = copied;
@@ -6426,7 +6428,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 		if (!tp->rx_opt.wscale_ok) {
 			tp->rx_opt.snd_wscale = tp->rx_opt.rcv_wscale = 0;
-			tp->window_clamp = min(tp->window_clamp, 65535U);
+			WRITE_ONCE(tp->window_clamp,
+				   min(tp->window_clamp, 65535U));
 		}
 
 		if (tp->rx_opt.saw_tstamp) {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad965676facaacd8f82848c52cf966f97c3..9282fafc0e6109f3ac86d1641740f24588b2d75d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -203,16 +203,17 @@ static inline void tcp_event_ack_sent(struct sock *sk, u32 rcv_nxt)
  * This MUST be enforced by all callers.
  */
 void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
-			       __u32 *rcv_wnd, __u32 *window_clamp,
+			       __u32 *rcv_wnd, __u32 *__window_clamp,
 			       int wscale_ok, __u8 *rcv_wscale,
 			       __u32 init_rcv_wnd)
 {
 	unsigned int space = (__space < 0 ? 0 : __space);
+	u32 window_clamp = READ_ONCE(*__window_clamp);
 
 	/* If no clamp set the clamp to the max possible scaled window */
-	if (*window_clamp == 0)
-		(*window_clamp) = (U16_MAX << TCP_MAX_WSCALE);
-	space = min(*window_clamp, space);
+	if (window_clamp == 0)
+		window_clamp = (U16_MAX << TCP_MAX_WSCALE);
+	space = min(window_clamp, space);
 
 	/* Quantize space offering to a multiple of mss if possible. */
 	if (space > mss)
@@ -239,12 +240,13 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 		/* Set window scaling on max possible window */
 		space = max_t(u32, space, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
 		space = max_t(u32, space, READ_ONCE(sysctl_rmem_max));
-		space = min_t(u32, space, *window_clamp);
+		space = min_t(u32, space, window_clamp);
 		*rcv_wscale = clamp_t(int, ilog2(space) - 15,
 				      0, TCP_MAX_WSCALE);
 	}
 	/* Set the clamp no higher than max representable value */
-	(*window_clamp) = min_t(__u32, U16_MAX << (*rcv_wscale), *window_clamp);
+	WRITE_ONCE(*__window_clamp,
+		   min_t(__u32, U16_MAX << (*rcv_wscale), window_clamp));
 }
 EXPORT_SYMBOL(tcp_select_initial_window);
 
@@ -3855,7 +3857,7 @@ static void tcp_connect_init(struct sock *sk)
 	tcp_ca_dst_init(sk, dst);
 
 	if (!tp->window_clamp)
-		tp->window_clamp = dst_metric(dst, RTAX_WINDOW);
+		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
 	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
@@ -3863,7 +3865,7 @@ static void tcp_connect_init(struct sock *sk)
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
 	    (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp == 0))
-		tp->window_clamp = tcp_full_space(sk);
+		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
 
 	rcv_wnd = tcp_rwnd_init_bpf(sk);
 	if (rcv_wnd == 0)
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 6d8286c299c9d139938ef6751d9958c80d3031e9..bfad1e89b6a6bb99c28b9ef14c142a6c4aeae54b 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -246,7 +246,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		}
 	}
 
-	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(dst, RTAX_WINDOW);
+	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :dst_metric(dst, RTAX_WINDOW);
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	full_space = tcp_full_space(sk);
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a1967bc7bad63d5a8a628b3f3b868e3a27baaca..3897a03bb8cb88f7869180b5ec261158e8e5d027 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2056,7 +2056,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 				ssk = mptcp_subflow_tcp_sock(subflow);
 				slow = lock_sock_fast(ssk);
 				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
-				tcp_sk(ssk)->window_clamp = window_clamp;
+				WRITE_ONCE(tcp_sk(ssk)->window_clamp, window_clamp);
 				tcp_cleanup_rbuf(ssk, 1);
 				unlock_sock_fast(ssk, slow);
 			}
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dcd1c76d2a3ba1ccc31a3e9279f725cd6d433782..b702e994633788183ad95b2e12859ee6b60bf208 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1519,7 +1519,7 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 
 		slow = lock_sock_fast(ssk);
 		WRITE_ONCE(ssk->sk_rcvbuf, space);
-		tcp_sk(ssk)->window_clamp = val;
+		WRITE_ONCE(tcp_sk(ssk)->window_clamp, val);
 		unlock_sock_fast(ssk, slow);
 	}
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


