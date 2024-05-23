Return-Path: <netdev+bounces-97789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB48CD333
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A461F23659
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743431474BC;
	Thu, 23 May 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CovLbCdb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802F13B7BC
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469532; cv=none; b=JuBaUCFb/fEUn5ZjU58eAGOtHthWiAmdcK8Lsw/KMBDHSWYBngdcEPMC6h8WWzS9Z/IDKkqRABvYkBi0YglHT2WrXmnFvRoVxYSiGIl3urEJBgS0aemsVVzvF9+7rzqnpJxkZtfjayaNhkzEHWUy/HqxYZjpoWyMDyszsW4+fLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469532; c=relaxed/simple;
	bh=8RQLCZ9srNCfcvSKJ5lca8MJSc+IM5YxxnAq9yuN7PM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jwC41+plru5NOQP8qteIBJTpTogRku0ivylxYVUfo7cZEET3AEv60wjD+FFIxK3DVcMTuQnKPMfAYp6HXXn+jxUeKDBC2tvNkgtyzFVm1vEDLoEYzi6Xx/mxcQkbe5LAeDhQKQclO8vTuNKNBLx+anmFXoKkjLjyjMTqHNQ1shU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CovLbCdb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4d631a4c1so3823107276.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716469530; x=1717074330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dq6RwR61fv1jU7e8ha8BCvcCN/vIlu8Voqzt+yd1vNA=;
        b=CovLbCdb2aGiHiymj3Z3iegoUiPNJvY4bb/7yNbT0RQdJ6CLe+CoExvRieskl5JWAk
         ibgXNdZ4p6WAqVhUjXG8ayn3GtKNu/G5uOh3zyp7GZ1a4tvHBZHs7bwcxmGkcjqEQRIF
         g4bjIh+S9rlBUUw5MsCYzuZcenDZp0DtVNxrLJEjq4qxAp/X/A1lOMkohoNHVafLmjgU
         Tso8SCTet8hixijUjwJVTzxh/Wi7+/Mh5vyrP6Q8fs0UWpScLEA66yZGM7d1G6HGfGFN
         HRk0rTSpp+q70mti/q8BUaotKYqu2Cplags2Q4V6qDXygqaMu6MRaFV3KD7gBM2hyAwu
         FGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469530; x=1717074330;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dq6RwR61fv1jU7e8ha8BCvcCN/vIlu8Voqzt+yd1vNA=;
        b=XRhUgWjOtbgaX/MsOu3zINlxPNnCCIjLuxaCzjrVKlZTXybSDvJTuyCoGAWuao6VnH
         tp4ix8B+SznrfsBE417Ofk1ETpo/4HIUCA1E3bQGVCOOvb/v0hZDiSmsY+ng4DHkGWzs
         D75HCKbOpVG+PUSksAYu/nDYYQOgjPklkh8z1h/PZ3NS1pbhlGtROy5OA26vqKUlIZDN
         YB9Fw7BJ1P8VCGLRoufCOvREvhxUrotPkW8yLwnmU9gUl2Hjk4qSDOiQxepKFBfy8de0
         J+X/4X+IKL0GSyrpW5M1bOlTwI3ZiummKfrfsbAHuXjWvRctW+cyujevlXPSAB9+O9XN
         grOg==
X-Gm-Message-State: AOJu0YxVE29GgoCMrL3W/4h0BasR5bHkq5LHCCmOj0Lj1G315MCJtCd2
	z+0jz8+END6Vdaf9UhOK9taiXRI9nsGBvy5y+2UlCtctVghvL8Yf1KnM1k6Z2DjqWHYjLTA/Imt
	M93ISKwCBHQ==
X-Google-Smtp-Source: AGHT+IG/i2k6DouZlgUZl4zZlH3Z6z06+rWqzymL01SY3711RaGD4xjp1iQz3ncEx8tCISpAPytRevf/pIn4FA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:114a:b0:df4:9f33:317 with SMTP
 id 3f1490d57ef6-df4e0d30e2bmr426977276.4.1716469529722; Thu, 23 May 2024
 06:05:29 -0700 (PDT)
Date: Thu, 23 May 2024 13:05:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523130528.60376-1-edumazet@google.com>
Subject: [PATCH net] tcp: reduce accepted window in NEW_SYN_RECV state
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jason Xing <kernelxing@tencent.com>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"

Jason commit made checks against ACK sequence less strict
and can be exploited by attackers to establish spoofed flows
with less probes.

Innocent users might use tcp_rmem[1] == 1,000,000,000,
or something more reasonable.

An attacker can use a regular TCP connection to learn the server
initial tp->rcv_wnd, and use it to optimize the attack.

If we make sure that only the announced window (smaller than 65535)
is used for ACK validation, we force an attacker to use
65537 packets to complete the 3WHS (assuming server ISN is unknown)

Fixes: 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_wnd value")
Link: https://datatracker.ietf.org/meeting/119/materials/slides-119-tcpm-ghost-acks-00
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kernelxing@tencent.com>
Cc: Neal Cardwell <ncardwell@google.com>
---
 include/net/request_sock.h | 12 ++++++++++++
 net/ipv4/tcp_ipv4.c        |  7 +------
 net/ipv4/tcp_minisocks.c   |  7 +++++--
 net/ipv6/tcp_ipv6.c        |  7 +------
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index bdc737832da66a1eb5c50928e67d45d8b58d7b8e..68c1c5a5444c2c73a5e2209012b0f985f4361704 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -284,4 +284,16 @@ static inline int reqsk_queue_len_young(const struct request_sock_queue *queue)
 	return atomic_read(&queue->young);
 }
 
+/* RFC 7323 2.3 Using the Window Scale Option
+ *  The window field (SEG.WND) of every outgoing segment, with the
+ *  exception of <SYN> segments, MUST be right-shifted by
+ *  Rcv.Wind.Shift bits.
+ *
+ * This means the SEG.WND carried in SYNACK can not exceed 65535.
+ * We use this property to harden TCP stack while in NEW_SYN_RECV state.
+ */
+static inline u32 tcp_synack_window(const struct request_sock *req)
+{
+	return min(req->rsk_rcv_wnd, 65535U);
+}
 #endif /* _REQUEST_SOCK_H */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 30ef0c8f5e92d301c31ea1a05f662c1fc4cf37af..b710958393e64e2278c088018c87ac97a1291a23 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1144,14 +1144,9 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 #endif
 	}
 
-	/* RFC 7323 2.3
-	 * The window field (SEG.WND) of every outgoing segment, with the
-	 * exception of <SYN> segments, MUST be right-shifted by
-	 * Rcv.Wind.Shift bits:
-	 */
 	tcp_v4_send_ack(sk, skb, seq,
 			tcp_rsk(req)->rcv_nxt,
-			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
+			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
 			READ_ONCE(req->ts_recent),
 			0, &key,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b93619b2384b3735ecb6e40238f8367d9afb7e15..538c06f95918dedf29e0f4790795fcc417f2516f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -783,8 +783,11 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* RFC793: "first check sequence number". */
 
-	if (paws_reject || !tcp_in_window(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq,
-					  tcp_rsk(req)->rcv_nxt, tcp_rsk(req)->rcv_nxt + req->rsk_rcv_wnd)) {
+	if (paws_reject || !tcp_in_window(TCP_SKB_CB(skb)->seq,
+					  TCP_SKB_CB(skb)->end_seq,
+					  tcp_rsk(req)->rcv_nxt,
+					  tcp_rsk(req)->rcv_nxt +
+					  tcp_synack_window(req))) {
 		/* Out of window: send ACK and drop. */
 		if (!(flg & TCP_FLAG_RST) &&
 		    !tcp_oow_rate_limited(sock_net(sk), skb,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4c3605485b68e7c333a0144df3d685b3db9ff45d..8c577b651bfcd2f94b45e339ed4a2b47e93ff17a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1272,15 +1272,10 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 	/* sk->sk_state == TCP_LISTEN -> for regular TCP_SYN_RECV
 	 * sk->sk_state == TCP_SYN_RECV -> for Fast Open.
 	 */
-	/* RFC 7323 2.3
-	 * The window field (SEG.WND) of every outgoing segment, with the
-	 * exception of <SYN> segments, MUST be right-shifted by
-	 * Rcv.Wind.Shift bits:
-	 */
 	tcp_v6_send_ack(sk, skb, (sk->sk_state == TCP_LISTEN) ?
 			tcp_rsk(req)->snt_isn + 1 : tcp_sk(sk)->snd_nxt,
 			tcp_rsk(req)->rcv_nxt,
-			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
+			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
 			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
 			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
-- 
2.45.1.288.g0e0cd299f1-goog


