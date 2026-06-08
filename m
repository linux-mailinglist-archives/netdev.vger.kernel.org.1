Return-Path: <netdev+bounces-296639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /usREZH0JmrGogIAu9opvQ
	(envelope-from <netdev+bounces-296639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714A658FED
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:57:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rLtRoh30;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296639-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296639-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86E3B37058D8
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E53EDAD7;
	Mon,  8 Jun 2026 15:14:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960A3ED5CD
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:14:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931696; cv=none; b=hzxlz8lpf0xYs2DHp4PDKszHLAqr0iPWRvPOwfqO4liDuceFUGBd7zac2wcCQ9jPWjSysAG99biUVlTH3JYQc/s5cfDyZH53kdtuZf7uXeeRKb6eNv0CjXkrQv+nZymQTxekR6PdX+oR44Ki1DTbyq4UZWLpMd1ydZntSSVb0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931696; c=relaxed/simple;
	bh=pei2VWOvp/YH9Qy3jyZ4kVmh+Nca8jmdmlk7Zeg44zs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p+tNb8ECQzEfvYVtCY7NMbYYychC/zPmfAcrXwfKFjAwPY7FUZ5h+nMC+BMYyD6+0yx4BICdzSlqMoswxjd4XJjzRcQ0qKav+Umdl4suoZ+EeMLcB1W7ytnS+lrcvlqDO5cEq3KbQtnyUsu8+i2KzGomkWfZkxdhKwvmcHVIx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLtRoh30; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ccdcd8dd3dso106680376d6.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780931694; x=1781536494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jjgpL0PrEaqNWc+io73apjZJgayjnxuqJdTJg4xns6M=;
        b=rLtRoh30Hw92l/mgwUQU3amnIADlKqaNp9W8ZkYOJTZqxb29PA44y4PmEPJQZRwlet
         4VhHCNECbkArk4TljKj/vPJ6yw6MA6fLR5RwmxBzjsSC7EHJkNxW2x4oIF694doDUmUP
         YXpHd2SQ++4Ck78SngB/v3dvIkF45FuorLHTWoC1BM6YcUl0Ld5nvf5qwzx1yCqHVbEz
         h+cJrYdUynUj4D6A6UUmmqdcfAgTyHrQwTpyoPw0Hd/YRCaVlvhjxwmOvyxKuNFUMtJA
         qQkLgCeWpU3XwwPoI0RPFsWgNZ0sQvTOgjV0N3Ex62ewV5S8FkdT8sw3uAESf24lWxMM
         smOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931694; x=1781536494;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjgpL0PrEaqNWc+io73apjZJgayjnxuqJdTJg4xns6M=;
        b=cmA03RX5PD8x9hJERmq04MG4xQMiT53KzKhCbSUw1vzSY9gj5zTkNsbrr13P6zzUcR
         m/dsq/XZE7ww5UX69enDCQQSRKbYID4ObLD+QacgVgMXPZvuM/74TMR7QJU15qrXHDaU
         rC9AnD47wOZ0rns6jB5QbN6cUlnB6qXt1VntxUKnZaZwsQRMFmH/thZeU44abp8oZgLM
         +GojNZTdz28BTf7N5FifPj8kIVvY31vJ8tpbgAsqYejfyOI159ofS2Of6XTK2Gk3d1LJ
         D8FipxZxML3bFgqZgsk+1oAiakgqoeMJ3VUigfqK/R2O7bK7TCstZ4JaRhEM0Pgh1L6M
         Db+g==
X-Forwarded-Encrypted: i=1; AFNElJ9BcxO60jaCvAALms80IliXLJ4vFyBiFqlCWBFrdrJf8H54DHn+Ly0+jNkYRdgLaEqkBHQiezw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GzeTuyA3RvVpzVt7UhvnvkGrs1N4N4yshxM2zf0RqMPBs9/e
	jMF3TkE6nm5VB/XlhnsohIWAacWwnkwTg+4TOGEtj6zGKHhWH5q7XxjZyJOicPmOu+9N1J3nnkT
	k139O5BjziN8CWQ==
X-Received: from qtmk5.prod.google.com ([2002:ac8:6045:0:b0:517:8af2:1639])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:514:b0:50d:8792:b6d1 with SMTP id d75a77b69052e-51795bcb646mr229104551cf.38.1780931693669;
 Mon, 08 Jun 2026 08:14:53 -0700 (PDT)
Date: Mon,  8 Jun 2026 15:14:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260608151452.706822-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: refine tcp_sequence() for the FIN exception
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Simon Baatz <gmbnomis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296639-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:gmbnomis@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9714A658FED

Commit 0e24d17bd966 ("tcp: implement RFC 7323 window retraction
receiver requirements") removed the special FIN case that
was added in commit 1e3bb184e941 ("tcp: re-enable acceptance of
FIN packets when RWIN is 0").

If a peer sends a segment containing data and a FIN flag before
it learns about our window retraction and has a buggy TCP stack,
it might place the FIN one byte beyond what it thinks is the
right edge of the window (i.e., max_window_edge + 1).

The data portion (end_seq - th->fin) will end exactly at max_window_edge.
In this case, we will drop the packet if our receive queue is not empty,
even though the data was sent within the window we previously allowed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Simon Baatz <gmbnomis@gmail.com>
---
 net/ipv4/tcp_input.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ab7a4e5435a8a2cbb532d42c54af76d8541c903b..8560a9c6d38207c098d673497caf2c7652c36f5c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4812,18 +4812,20 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
 					 const struct tcphdr *th)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
+	u32 seq_limit;
 
 	if (before(end_seq, tp->rcv_wup))
 		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
 
-	if (unlikely(after(end_seq, tp->rcv_nxt + tcp_max_receive_window(tp)))) {
+	seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
+	if (unlikely(after(end_seq, seq_limit))) {
 		/* Some stacks are known to handle FIN incorrectly; allow the
 		 * FIN to extend beyond the window and check it in detail later.
 		 */
-		if (!after(end_seq - th->fin, tp->rcv_nxt + tcp_receive_window(tp)))
+		if (!after(end_seq - th->fin, seq_limit))
 			return SKB_NOT_DROPPED_YET;
 
-		if (after(seq, tp->rcv_nxt + tcp_max_receive_window(tp)))
+		if (after(seq, seq_limit))
 			return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
 
 		/* Only accept this packet if receive queue is empty. */
-- 
2.54.0.1032.g2f8565e1d1-goog


