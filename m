Return-Path: <netdev+bounces-279149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JN+MQtC4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:09:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8554147A1
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86AA130CFA17
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38A3ED5C2;
	Thu, 16 Apr 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lq/+3EMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF07370D49
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369819; cv=none; b=Ript4EtQuu2hKxmf56FBj1Xm/UntjIPAfLas51dFYIfIwpxDg3m/6H99f9s9EVifUzhUX3T0+hD1eZBsSB7naiGAFIEJiNXr6pGP6LXHuaUkksd/Hd799c7yZn6/YV/CzzaWMi2RUZD7+LOof1VlLUizCbFL3Kslqmyys8x8eRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369819; c=relaxed/simple;
	bh=YBnn/IPLU7tel366Kd/6VblmyKuwLEWu7jYPAXZ7/X8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YYstLNMZV8wE15jlhPnrYjvxPQJyd//179Hi/8uGJuuG6kKXvzDT1Vi4C3oBDY6WPE8jwpSYBxWjooXYs1YZYdgeruWe34UtGHzrEu06k9n4mFRuxlLzMAImiMDhO0cwhK3R89kDw4K5kBZu4aFIzgGmyRcZP7+iRkL2YcVU+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lq/+3EMy; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-605e5d95cccso7517900137.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369811; x=1776974611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VXz1sAO7uTut8xfy3XcwQg3ytiBsNZ4KD0JOUg7B+s=;
        b=Lq/+3EMy0W9kG6o7vVJ/BvVIN9GHoTko0iYM2VspYCqnHH9CgDYJsfTylQ05gjkQj3
         +oTaRiKNLmPURRxQ53It/p80s8OJvIki6fZyYDGN8Oqz86LDohGQUeAugT1kFIHJitwQ
         GpOMAhFwTsfDlIwmSj29Rfa0eCDgk3QVuH1mkwjifKmo0Loc1osYEpFYqbQQdc0VEkKq
         oDsHTDolJ24hKlm0VVjQRRQ2Rdlx7vqHgx5fRK5waqmDVEqhFS11Bdlefa8vw++YERkA
         9h6gsioqcmyUdbKA5ZJAfCLIpBSuIz2+jzlXArd2OnPG85a/EMpr8b3rh+GEiEdR2xKB
         Pdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369811; x=1776974611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VXz1sAO7uTut8xfy3XcwQg3ytiBsNZ4KD0JOUg7B+s=;
        b=AlIg3GqEvnp6K63NkGmvhMgEA2JU5KPpnMqeD71MHlPAdkIHkEvgjBhJE22hkXhFwR
         3c1aRWipI9UNaxYvIX4z3npbL03GoCP/B9p1ee23nnuNxiQDMVAgLbHS8BjUHMwajjlU
         zd03itJ9T2iQzzktnHcS0mHzFa8no2zbQyCW037787oosS/t7a441mD8/smLTHiZ2YtU
         pCSA3kK0h5HyLPQCPGUVFRlGNKUxb2PhWmJOdMIg2cyvXZsWfLG2mUH/uQS7M2uWNcF5
         8kWuziW3BLWWUZgNLarkIyPv0RrU1LBxtJCNZTdBhAMdjG5s6zkoIXJWj/T7c5xTlz77
         mv5w==
X-Forwarded-Encrypted: i=1; AFNElJ/rgXHSDAscEJpKhQXftaBC/QBWHVOpVlbz1P3imZWIFQ86fepCH8Oz9jhabfQGmMsd5vY4tZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxupLedmUB0AfQYbllq5cicR2NFVa5CqE0SApR66XGcG5bgT4T6
	NyhwigIosKzClS0KlyPJu2OljVw/S8IHTh9S29yGkj8/YFQq++EJ2RTn+4MloOJZn2kiPiSrhOm
	gCg/dWbKsZl2Bzw==
X-Received: from qvboe9.prod.google.com ([2002:a05:6214:4309:b0:8ac:a22e:36d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:6444:b0:5ff:cb2c:a04c with SMTP id ada2fe7eead31-616cadc88eemr396440137.1.1776369810885;
 Thu, 16 Apr 2026 13:03:30 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:11 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-7-edumazet@google.com>
Subject: [PATCH net 06/14] tcp: add data-race annotations for TCP_NLA_SNDQ_SIZE
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
	TAGGED_FROM(0.00)[bounces-279149-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C8554147A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 87ecc95d81d9 ("tcp: add send queue size stat in SCM_TIMESTAMPING_OPT_STATS")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c        | 4 +++-
 net/ipv4/tcp_input.c  | 4 ++--
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0aabd02d44967dae3e569702f76037beb45e5de8..729936d13a5c6d9c39edc880636e01cf0973688e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4456,7 +4456,9 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u32(stats, TCP_NLA_DELIVERED, READ_ONCE(tp->delivered));
 	nla_put_u32(stats, TCP_NLA_DELIVERED_CE, READ_ONCE(tp->delivered_ce));
 
-	nla_put_u32(stats, TCP_NLA_SNDQ_SIZE, tp->write_seq - tp->snd_una);
+	nla_put_u32(stats, TCP_NLA_SNDQ_SIZE,
+		    max_t(int, 0,
+			  READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una)));
 	nla_put_u8(stats, TCP_NLA_CA_STATE, inet_csk(sk)->icsk_ca_state);
 
 	nla_put_u64_64bit(stats, TCP_NLA_BYTES_SENT, tp->bytes_sent,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 63ff89210a72fbf5710279c41010d3f6e734e522..edb5013873e0c4a9ba2f8a81a43eff5fb6e7a47b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3912,7 +3912,7 @@ static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_acked += delta;
 	tcp_snd_sne_update(tp, ack);
-	tp->snd_una = ack;
+	WRITE_ONCE(tp->snd_una, ack);
 }
 
 static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
@@ -7240,7 +7240,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (sk->sk_socket)
 			sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
 
-		tp->snd_una = TCP_SKB_CB(skb)->ack_seq;
+		WRITE_ONCE(tp->snd_una, TCP_SKB_CB(skb)->ack_seq);
 		tp->snd_wnd = ntohs(th->window) << tp->rx_opt.snd_wscale;
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2663505a0dd7a0eae69f6a91250b4a0b6f357f7d..9f83c7e4acabc64f0a45e4879c326694a306b368 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4153,7 +4153,7 @@ static void tcp_connect_init(struct sock *sk)
 	tp->snd_wnd = 0;
 	tcp_init_wl(tp, 0);
 	tcp_write_queue_purge(sk);
-	tp->snd_una = tp->write_seq;
+	WRITE_ONCE(tp->snd_una, tp->write_seq);
 	tp->snd_sml = tp->write_seq;
 	tp->snd_up = tp->write_seq;
 	WRITE_ONCE(tp->snd_nxt, tp->write_seq);
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


