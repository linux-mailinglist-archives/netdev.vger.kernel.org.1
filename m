Return-Path: <netdev+bounces-224881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D625FB8B3B7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DE564CB7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0370D2C2376;
	Fri, 19 Sep 2025 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NX3Gl4MC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567562C0F95
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314944; cv=none; b=kjSxeeVojzsB9aR0WMQVNHe1YvhZFIyUjDz7/JjbMj2VtdhwgZTO8W1hLv66MWTbCzaYWrUeb9G6bVvyhabhBPbwoHn19sFm+9tHN0l2f+G1PeG/XLoOeF7ejvoHucwbLD3R7JKWDh30FlP7tBWNHZVaAGTDkJ+5vq7LyxghdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314944; c=relaxed/simple;
	bh=P1tfNZmVWEs+LrB1Wv8mMxfqgYcg37wAZJEhhfjRBww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B6nsw3WMGJI2CIhNkkRcpwcRV2/SZeoZ6iLY6U9h3QdMoBgXCOfZ5y1wMXlNmsRb6S97/sO6gn8MFUYEPxCoKvtxMBYvV3nEAFlle9Silu9orv/VGvX7cwk3ZtKbV4ZGgUMYwo419wHDVYzhRKROZAwo8VEsTl96isfyykuXL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NX3Gl4MC; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8286b42f46bso506622885a.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314942; x=1758919742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PTVgQFKU5e49oJ3iISMgA9/cNvvPi9PBKL/+pE9HEk=;
        b=NX3Gl4MCjCbVOCqzMjB3YhdL9j1kSmxYbQJsmYjpE/P7FWyuUYPoS9jPBlU0CSGGio
         Yvr16TRgRTeM7oV6Cp+M2HkZO9Tsyznea2GrpN3F36+Ox88DGt5aTBods+tJyjTAI00F
         8iPDCYPByXm2mEVbcZ+fywpUpgry/wm2/tSr9W9nj5n9OYXX1aTRhQbFPBsNxK3MbTIL
         Nw81BPTqTlSZviFlznawcaLf78aDOng5fHDr/H820bfO+IIBLu5AIOgDj2nCmsSfhWRv
         YSMWoYiIZv/fFI2SL0LA2t1W+xvMKIWAJTucYl8ain2y62ObPeU5koG37gKrMPfMeqY5
         ptlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314942; x=1758919742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PTVgQFKU5e49oJ3iISMgA9/cNvvPi9PBKL/+pE9HEk=;
        b=Au1orRKLqW/hGlVgywoDuokzkEpCkCjVfHLdRtTusWVYeWQoNje/3L1euR5jEkwynN
         +hwbod8SeVNJnqsoaK/XnUQrlTR6kCKWtOqmVS5xqh4AmaBT2FtryPaDJgS2nkyuV8+o
         nuLVDx32SFMXqPBxRCLbtlYyJKb8TTt/AJs42LMkpEvUlOr+jFUbpo087wmFeJWyxTbP
         JkqtL5EpDWhogxOXDw1nDcGAxfw9qO73pK8SKvU5QDePZKgEh6DDnH8gcYzcSoz7AWxp
         FXkr7SWPBlV9oEf0uVfac5Kngwb2HfW/CFOvjiC+zuPsDyXMz/EEl7X1BcSWVI3Fsjhl
         oatQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtWsjH7TTlBqi/It5H4V2frpsZ+m7Ufimy68kqtiZBNsHqNl7oCqTVTqjayda/jD+Lj77oWN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnMdIifmm+B2aTuaXUJI4p0FOrIr2yt9vVACgbwqb7Z7rRhkd
	zfkP9OeG0vCdof1nfd2WNaqXcvQOeGVqj/rFMp8sdvlRu4UTAYBCL8g2KMxfdwZHPcEeJ7d9l3T
	tfjCFj6j8rPE2dA==
X-Google-Smtp-Source: AGHT+IEHt8BIqYV2AOG+6UxqCmWTffqgXYlgS8Hu9CRJ5xqgg358jMqS3y+6mS6swW60Y+uv3SdPLDPoN5rMvA==
X-Received: from qkntz12.prod.google.com ([2002:a05:620a:690c:b0:827:6d60:7d4e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2ef:b0:827:ecc1:819d with SMTP id af79cd13be357-83ba40addd2mr401996285a.21.1758314942230;
 Fri, 19 Sep 2025 13:49:02 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:50 +0000
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/8] net: move sk->sk_err_soft and sk->sk_sndbuf
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_sndbuf is read-mostly in tx path, so move it from
sock_write_tx group to more appropriate sock_read_tx.

sk->sk_err_soft was not identified previously, but
is used from tcp_ack().

Move it to sock_write_tx group for better cache locality.

Also change tcp_ack() to clear sk->sk_err_soft only if needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h   | 4 ++--
 net/core/sock.c      | 3 ++-
 net/ipv4/tcp_input.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 66c2f396b57de5a0048b4ae1e6181c4473be15c5..b4fefeea0213a548a1c3601b95f902a5fa499bc6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -467,7 +467,7 @@ struct sock {
 	__cacheline_group_begin(sock_write_tx);
 	int			sk_write_pending;
 	atomic_t		sk_omem_alloc;
-	int			sk_sndbuf;
+	int			sk_err_soft;
 
 	int			sk_wmem_queued;
 	refcount_t		sk_wmem_alloc;
@@ -507,6 +507,7 @@ struct sock {
 	unsigned int		sk_gso_max_size;
 	gfp_t			sk_allocation;
 	u32			sk_txhash;
+	int			sk_sndbuf;
 	u8			sk_pacing_shift;
 	bool			sk_use_task_frag;
 	__cacheline_group_end(sock_read_tx);
@@ -523,7 +524,6 @@ struct sock {
 	unsigned long	        sk_lingertime;
 	struct proto		*sk_prot_creator;
 	rwlock_t		sk_callback_lock;
-	int			sk_err_soft;
 	u32			sk_ack_backlog;
 	u32			sk_max_ack_backlog;
 	unsigned long		sk_ino;
diff --git a/net/core/sock.c b/net/core/sock.c
index ad79efde447675c8a8a3aafe204e2bbb1a5efe7c..dc03d4b5909a2a68aee84eb9a153b2c3970f6b32 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4452,7 +4452,7 @@ static int __init sock_struct_check(void)
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_omem_alloc);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_omem_alloc);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_sndbuf);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_err_soft);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_wmem_queued);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_wmem_alloc);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_tsq_flags);
@@ -4479,6 +4479,7 @@ static int __init sock_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_allocation);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_txhash);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_sndbuf);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_max_segs);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_pacing_shift);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_use_task_frag);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9fdc6ce25eb1035a88ff2640601cc665187a78b2..f93d48d98d5dacf2ee868cd6b2d65a396443d106 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4085,7 +4085,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	/* We passed data and got it acked, remove any soft error
 	 * log. Something worked...
 	 */
-	WRITE_ONCE(sk->sk_err_soft, 0);
+	if (READ_ONCE(sk->sk_err_soft))
+		WRITE_ONCE(sk->sk_err_soft, 0);
 	WRITE_ONCE(icsk->icsk_probes_out, 0);
 	tp->rcv_tstamp = tcp_jiffies32;
 	if (!prior_packets)
-- 
2.51.0.470.ga7dc726c21-goog


