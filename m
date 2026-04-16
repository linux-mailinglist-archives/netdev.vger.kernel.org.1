Return-Path: <netdev+bounces-279145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIs7JKVB4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:08:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747F414778
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B3EC3052899
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13EA3E959C;
	Thu, 16 Apr 2026 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxiXrQDQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA738C2B5
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369813; cv=none; b=h0VPhE8MP1fzBM+DVOa26hvOs6T8HI0AP1uqY/uS3z0rXDkwNkbGUuQ34irzXel2Xw0GaXmv6X5u8bgAvz6yZntTFnx8h28ytNY2JZBzB3yC3lB3j79PTsLZO7/8DOXItrKKY1pTaO5E+pVJYUmq2tlLBLkXT4Htvc9GEvjuDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369813; c=relaxed/simple;
	bh=vIkWRDzo3EDvTR6bAlqkznEDh5KFydinAo8Siy8tpRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pzgcR44ZivKaIjq9l2zixrHAzfBa1/eHoIME+vWWzrI5dyKuTSUKZKoBNhSKvLYC8mOXGBQRjrjyGZ+CE8ZFNRgZKj+nUtgEsLdvI7HieQkm0IrTXYWkeINR4EXMFhJ/y6k0m3pe6qWQkGhOSWkR4bpUeye/d6NEtQDbGRWT0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxiXrQDQ; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-956995b87e6so6936190241.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369804; x=1776974604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=opNwWZN1co7vlxK7a/fMpwUn0yhkKvANh3SI5hyTq7A=;
        b=CxiXrQDQntlZTdySO6unylooO2mnOPgm/rZ5pU5zDJU/4O+nutxs4TvXokKsZQKefN
         sbQhd6tYXITF3C91gDccdflBhlWa5WxMwEd4AWEO8HKGUw8S04tjSrrghFRq6uwZsSx4
         EhVW1qIBGqNX7H+xhb8keFup1q5udFwkxGvHzbyuiDBH3yVMwOv+X84UisVzUhB6twRb
         fVwcQHRw4eMv8VVwfYwUfHHMbF+T70/UoztVB/6JFag2lzbA73wxGcMoZCjSKbOH6GmH
         2n5kQsgJKgSOwtJPd8aSQ6lbj2iIvLeFG3HkK8kYhIMEnY00r7tu4pEO0QvDFgcqgtGc
         9sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369804; x=1776974604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opNwWZN1co7vlxK7a/fMpwUn0yhkKvANh3SI5hyTq7A=;
        b=tYN53WkD22hqGYGYDub74tEBNyXPocCP9XiQIVvw/ArYJ3topEXIo8mvuHlFllNjwE
         91TWOig1WnXpjgGny9nGSIfyCvT9HUkm+7yuJ6ZLwqahmwcvkrsafr7XiYdf/LESV9ay
         uKo0AT0Bs2PABIv43Ue0S6nhN4iaDP7r9Y9BxlROCpSfXeTmZNudkQ9nEy4Zna53Leu/
         uI0qyIBdcU/H3axatw9jzwELS11ayBWaiUINDfbt/5GFvWge6dRUggRAzM2OP/lvYFLz
         Jii2A5gI6iT562+zHRPDRjmhiRMNNVR/2nywEFNqoafyRao/q2pRTJlHhgfRc6DiGLEz
         nq7g==
X-Forwarded-Encrypted: i=1; AFNElJ8XCZ1zrfjX79yHzO6XqJpvCNp6WGhpt+muFtp6P5gymVI/aaaIBXh6IvBstQHyOAa8TMwOGnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGDQZh0uPRF8CNZCwkkyTkuFzPccQnhc3IPevSZPlV1+Gr4Wn
	fPs4ulWQqhXr+tUKCsFKCDYr9KkAU/lt8b9sE1RA/bfKI933wFsk/blaoaT1vQmiI0b76mC1xey
	uzHHoEFUXdooueQ==
X-Received: from qvxa1.prod.google.com ([2002:a05:6214:621:b0:89c:c936:5ac9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3749:b0:606:49d:1861 with SMTP id ada2fe7eead31-616ce4784dcmr349080137.27.1776369804121;
 Thu, 16 Apr 2026 13:03:24 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:07 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-3-edumazet@google.com>
Subject: [PATCH net 02/14] tcp: add data-race annotations around
 tp->data_segs_out and tp->total_retrans
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
	TAGGED_FROM(0.00)[bounces-279145-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0747F414778
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 7e98102f4897 ("tcp: record pkts sent and retransmistted")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c        | 4 ++--
 net/ipv4/tcp_output.c | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7b7812cb710f6e05a83615811eefd0cf8a845cab..e39e0734d958f39aa83a33f5c608ce3b94232fb1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4434,9 +4434,9 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u64_64bit(stats, TCP_NLA_SNDBUF_LIMITED,
 			  info.tcpi_sndbuf_limited, TCP_NLA_PAD);
 	nla_put_u64_64bit(stats, TCP_NLA_DATA_SEGS_OUT,
-			  tp->data_segs_out, TCP_NLA_PAD);
+			  READ_ONCE(tp->data_segs_out), TCP_NLA_PAD);
 	nla_put_u64_64bit(stats, TCP_NLA_TOTAL_RETRANS,
-			  tp->total_retrans, TCP_NLA_PAD);
+			  READ_ONCE(tp->total_retrans), TCP_NLA_PAD);
 
 	rate = READ_ONCE(sk->sk_pacing_rate);
 	rate64 = (rate != ~0UL) ? rate : ~0ULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8e99687526a64cef0c8f7b8f0d5ec7a5fa883f09..d8e8bba2d03a3be5e7a9ebac16e39f4a29ae6037 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1688,7 +1688,8 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 
 	if (skb->len != tcp_header_size) {
 		tcp_event_data_sent(tp, sk);
-		tp->data_segs_out += tcp_skb_pcount(skb);
+		WRITE_ONCE(tp->data_segs_out,
+			   tp->data_segs_out + tcp_skb_pcount(skb));
 		tp->bytes_sent += skb->len - tcp_header_size;
 	}
 
@@ -3642,7 +3643,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	TCP_ADD_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS, segs);
 	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNRETRANS);
-	tp->total_retrans += segs;
+	WRITE_ONCE(tp->total_retrans, tp->total_retrans + segs);
 	tp->bytes_retrans += skb->len;
 
 	/* make sure skb->data is aligned on arches that require it
@@ -4646,7 +4647,8 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 			 * However in this case, we are dealing with a passive fastopen
 			 * socket thus we can change total_retrans value.
 			 */
-			tcp_sk_rw(sk)->total_retrans++;
+			WRITE_ONCE(tcp_sk_rw(sk)->total_retrans,
+				   tcp_sk_rw(sk)->total_retrans + 1);
 		}
 		trace_tcp_retransmit_synack(sk, req);
 		WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


