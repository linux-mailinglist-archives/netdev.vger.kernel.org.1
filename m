Return-Path: <netdev+bounces-259839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCeVM8pAmmlXaAMAu9opvQ
	(envelope-from <netdev+bounces-259839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:33:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66A16E3F3
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 901163046B87
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7130DEB8;
	Sat, 21 Feb 2026 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cl4ApvPz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949832938A
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716763; cv=none; b=HUUftqDiiDiffJy9IM7SeStbgji9z3kV7aEBwQqK1kWV7at57eOmvA6rwwtEaqudxkpVVDYL3MKxKaWGyKxDdsFa+vlu0wqG+ILvoPVFMWKPPb89BPX2UrRNFVLaOJyWEj1ldtI+iwwoyqSPhox1phaoPEvsZyAgmo4T4p8iOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716763; c=relaxed/simple;
	bh=w8IxoBaZ/ych/LK46ivskIm0/MyrSrBDhhNVaW/Di8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IpJ6WTPSPpHhSHpC6C3BAMng77ZaIst0HURViAtn8VKU/Pj6uMdMThO1RNBV/2AsYsZhRwQHNgoBX96zp0EqHlVmY8WN5u7vHdhFxVqZRAQkBmfTbzEfIfCH3flpEPzbSYJeZzEXRWytC+zxpbov+vBqDZqthy2+GCQcpoZEnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cl4ApvPz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a92a3f5de9so17714115ad.2
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716761; x=1772321561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1LCPL/qUtE8WHjYpGieZEgldrqDUcwGczoEoM5uQNo=;
        b=Cl4ApvPz6XUjReIu/TjIddFJ21ttM0/6NhmLpnSWQIV19lFAmzn1YY+Dm4KrnsxxWJ
         z1n1o0JUv8SsoqvSbTf89BMkmxX2+k+kz2UPllQhi+51wvzBG5UJ6L+/EvOXvdAv5I5d
         n0nbKjIcP9Qp3g+pcaAouqG/+y7v7F2NHT9/6NPHhgjuoheosWIlvAbBRhv37Ge8a8O7
         h/KtxJ/qD8iZ5DPjG9u4Q+bHm47wmtp9OOAxbFZcsboaULkMpL89xo1Mz1VZUJlW3O/A
         Senj/+5f0Amj28IQjCjrv35t60mOfAlg6WIKkssOuQBJvIF/6W3zGHiLyVl9bJ8xX84Z
         kySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716761; x=1772321561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1LCPL/qUtE8WHjYpGieZEgldrqDUcwGczoEoM5uQNo=;
        b=ZZQZr3A3xAF66KHetvTaugGTiidgq/YCDUoUrbZMzmZAe9XW94WVgXxfUPWhm1+kq3
         UxmImEmQfdpLAfOvyT5i3OuFiqCmXGu9ZT3oHXpATPolaaGRgDAyVoO7+T+wPIQv2Cwa
         HbXWBnl0p+4vPGxisWslxoCH8zwhuNGV1igE0kugrOcq986G7hfmFy0FyLcQuGkyjc0s
         WEicVGtYDf6MCtOBy09u4xRJfxF3H9t8d0b5F0USJyREEDxvwGrLuLeYWA8KZ0+dIW1A
         f65Z0TtyrEIH2oFnListjNBGF+FNbRVmyXoJPMaHpBhz8YbjV/bCseTO6i/PSHrrhehJ
         WrBA==
X-Forwarded-Encrypted: i=1; AJvYcCV4c+YHIMx67WISa6DCnt6hV6GOoLDVbcNqSdeUnwvrYs/PSt1xiQxVvelzGlAIBlfpYGH281c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDQcVpBPRx8x4R8VyNguCOf2zfcR+YBIVBpT2veo/PTKwIVXg
	ZhvklVmuF7vcJpoASLBZFBQrl3OW4rS1BuD7168viU9hF+N13YgIcctDfXct3W3W+5/QIvg39yx
	tERrufw==
X-Received: from plxm17.prod.google.com ([2002:a17:902:db11:b0:2a9:633f:4a0f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4d:b0:295:b46f:a6c2
 with SMTP id d9443c01a7336-2ad744e0f5cmr40005565ad.37.1771716760373; Sat, 21
 Feb 2026 15:32:40 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:49 +0000
In-Reply-To: <20260221233234.3814768-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-3-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A66A16E3F3
X-Rspamd-Action: no action

UDP TX skb->destructor() is sock_wfree(), and UDP only
holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().

Otherwise, sk->sk_write_space() is read locklessly.

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().

Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Use WRITE_ONCE() in udp_bpf_update_proto()
v2: Cache sk->sk_write_space in sock_wfree()
---
 net/core/skmsg.c   | 2 +-
 net/core/sock.c    | 8 ++++++--
 net/ipv4/udp_bpf.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 75fa94217e1e..3d7eb2f4ac98 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 
 	psock->saved_data_ready = sk->sk_data_ready;
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
diff --git a/net/core/sock.c b/net/core/sock.c
index 693e6d80f501..710f57ff3768 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2673,8 +2673,12 @@ void sock_wfree(struct sk_buff *skb)
 	int old;
 
 	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
+		void (*sk_write_space)(struct sock *sk);
+
+		sk_write_space = READ_ONCE(sk->sk_write_space);
+
 		if (sock_flag(sk, SOCK_RCU_FREE) &&
-		    sk->sk_write_space == sock_def_write_space) {
+		    sk_write_space == sock_def_write_space) {
 			rcu_read_lock();
 			free = __refcount_sub_and_test(len, &sk->sk_wmem_alloc,
 						       &old);
@@ -2690,7 +2694,7 @@ void sock_wfree(struct sk_buff *skb)
 		 * after sk_write_space() call
 		 */
 		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
-		sk->sk_write_space(sk);
+		sk_write_space(sk);
 		len = 1;
 	}
 	/*
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 91233e37cd97..779a3a03762f 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -158,7 +158,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 	int family = sk->sk_family == AF_INET ? UDP_BPF_IPV4 : UDP_BPF_IPV6;
 
 	if (restore) {
-		sk->sk_write_space = psock->saved_write_space;
+		WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
 		sock_replace_proto(sk, psock->sk_proto);
 		return 0;
 	}
-- 
2.53.0.371.g1d285c8824-goog


