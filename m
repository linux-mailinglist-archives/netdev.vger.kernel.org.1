Return-Path: <netdev+bounces-165514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C2A326B8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373E3167E78
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A4A20E334;
	Wed, 12 Feb 2025 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4d/Ghbzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32320E31E
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366015; cv=none; b=Tr6Pxx6VA7Jz2oyBOqpWcZAi3AMdmxBN6JSBLm0WivZCkxanvY4AWHSOLyDJNeUGgsJfbLpKFBFfQUpGmKeIAy1j5XyPNAz6IZ1fMBti3jSn8lZkkLXi6eqa3KFwLwEXngcuGn+bmm9rwJJ4nOsAbyS8ycr+fSD5pS5ANzFAxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366015; c=relaxed/simple;
	bh=yoh/UoF/t6i7/T/SmK22QBFx4z1Jil4Bph+7RqtEyW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzuUN/pJRZh/+KeZMIUAr/Lu4oj35DxMTlYJ5EWAzVDlPHPnAwxqHGeLtO9qWHqSqQrXZj6BMZZ9pemahOcdzPttMC7zH8cz/nCHr2oBPtasPCM76VIfAwYEZSsJeMgZSUcb7ubcsxrngKq5Kekj28d3dKvQYCHStN6Rbir4I3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4d/Ghbzi; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c078ebcc7fso13022285a.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366013; x=1739970813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XXzZgAcxEur3fQE0La9o0DqvjAxE2gRn70cTzuQdow=;
        b=4d/Ghbzi1wX3exqG65TUlWARnD7njEGZ5d5xJiQvXZn6WESDQgBkJXV+PIiuWs5UtZ
         zY1CodfGc4TsEdXFlKgNzQnMwjeLX3g4ru03dFQmisTYe4wgKVVzAVenRc2G+KXOB7xt
         yxZXb63fowqqExsqWp9S8HV2UYPvWxjJXoeKhGc8fX/vRTuoqCdsZbg8SJZBvY7bq/nG
         FWikBT7lI54U3tc0KsYdmn6AaZdZJFT8EDHSBajLT5O5Za8tQYAP2CoI/oYVSUV++hJY
         ownUOZxsioljAT/O3G2YFV6VEbFmC86UA4TRHtTFRHCnp0k90CG2JML5T/23OYYbGvbL
         gnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366013; x=1739970813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XXzZgAcxEur3fQE0La9o0DqvjAxE2gRn70cTzuQdow=;
        b=hB06kvr0k1Y3pLcpMlE2Le1DhlktPrO+qGJDoDzXCxOYCkwoAVovTIUOjVm0nlSpUI
         JKOwfoHv6XaAIizUCxpWI8FmxGvhz44sqFEvKDOz4voCj32QOM89T+zQxV4nzUqSX0bY
         4MJrDM+yLF3OX+b7oHgLlvTm1Y8OCC+77jJ8tEBduL+7pBCke3myi3zbzAXVgplGPyFy
         XNZQjw99wb02mZY0j7eSYJPwGMDq+wA1IJIsly0/5sMD6JHyDK6CO3TisSzoccitpNMr
         vqhPBBYZY97CidM3qgvcebvgWpvNzBHmK6+P5/IeSjxl9+jlzZckNXPLQ72CNWTp4yAy
         Z3yg==
X-Gm-Message-State: AOJu0Yxap2AKtDh+gyYsBp/6X4+geCLYg5me0e/LEKcaK4EnG2SrrHt3
	VJ32H4w2xCl+9Fvofvbg7WdptBhPIf6oWffpUcwagHQiwqzsIPssVPGUfyWzkWLwP9m+sgvApjS
	BIw/uw64k3w==
X-Google-Smtp-Source: AGHT+IEQX4rSjr/kZRfC7zOwobfycARZ7d1ZgKpvD36rK+/gTb4XlM1yWBLA+AFPeD0xByqbAxzFxoAG7jwT3w==
X-Received: from qkbea8.prod.google.com ([2002:a05:620a:4888:b0:7c0:6053:5dec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2b9a:b0:7c0:5807:d6 with SMTP id af79cd13be357-7c070798bebmr465099585a.57.1739366012950;
 Wed, 12 Feb 2025 05:13:32 -0800 (PST)
Date: Wed, 12 Feb 2025 13:13:27 +0000
In-Reply-To: <20250212131328.1514243-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212131328.1514243-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212131328.1514243-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] inet: reduce inet_csk_clone_lock() indent level
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Return early from inet_csk_clone_lock() if the socket
allocation failed, to reduce the indentation level.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 50 ++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 2b7775b90a0907727fa3e4d04cfa77f6e76e82b0..1c00069552ccfbf8c0d0d91d14cf951a39711273 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1237,39 +1237,43 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 				 const gfp_t priority)
 {
 	struct sock *newsk = sk_clone_lock(sk, priority);
+	struct inet_connection_sock *newicsk;
 
-	if (newsk) {
-		struct inet_connection_sock *newicsk = inet_csk(newsk);
+	if (!newsk)
+		return NULL;
 
-		inet_sk_set_state(newsk, TCP_SYN_RECV);
-		newicsk->icsk_bind_hash = NULL;
-		newicsk->icsk_bind2_hash = NULL;
+	newicsk = inet_csk(newsk);
 
-		inet_sk(newsk)->inet_dport = inet_rsk(req)->ir_rmt_port;
-		inet_sk(newsk)->inet_num = inet_rsk(req)->ir_num;
-		inet_sk(newsk)->inet_sport = htons(inet_rsk(req)->ir_num);
+	inet_sk_set_state(newsk, TCP_SYN_RECV);
+	newicsk->icsk_bind_hash = NULL;
+	newicsk->icsk_bind2_hash = NULL;
 
-		/* listeners have SOCK_RCU_FREE, not the children */
-		sock_reset_flag(newsk, SOCK_RCU_FREE);
+	inet_sk(newsk)->inet_dport = inet_rsk(req)->ir_rmt_port;
+	inet_sk(newsk)->inet_num = inet_rsk(req)->ir_num;
+	inet_sk(newsk)->inet_sport = htons(inet_rsk(req)->ir_num);
 
-		inet_sk(newsk)->mc_list = NULL;
+	/* listeners have SOCK_RCU_FREE, not the children */
+	sock_reset_flag(newsk, SOCK_RCU_FREE);
 
-		newsk->sk_mark = inet_rsk(req)->ir_mark;
-		atomic64_set(&newsk->sk_cookie,
-			     atomic64_read(&inet_rsk(req)->ir_cookie));
+	inet_sk(newsk)->mc_list = NULL;
 
-		newicsk->icsk_retransmits = 0;
-		newicsk->icsk_backoff	  = 0;
-		newicsk->icsk_probes_out  = 0;
-		newicsk->icsk_probes_tstamp = 0;
+	newsk->sk_mark = inet_rsk(req)->ir_mark;
+	atomic64_set(&newsk->sk_cookie,
+		     atomic64_read(&inet_rsk(req)->ir_cookie));
 
-		/* Deinitialize accept_queue to trap illegal accesses. */
-		memset(&newicsk->icsk_accept_queue, 0, sizeof(newicsk->icsk_accept_queue));
+	newicsk->icsk_retransmits = 0;
+	newicsk->icsk_backoff	  = 0;
+	newicsk->icsk_probes_out  = 0;
+	newicsk->icsk_probes_tstamp = 0;
 
-		inet_clone_ulp(req, newsk, priority);
+	/* Deinitialize accept_queue to trap illegal accesses. */
+	memset(&newicsk->icsk_accept_queue, 0,
+	       sizeof(newicsk->icsk_accept_queue));
+
+	inet_clone_ulp(req, newsk, priority);
+
+	security_inet_csk_clone(newsk, req);
 
-		security_inet_csk_clone(newsk, req);
-	}
 	return newsk;
 }
 EXPORT_SYMBOL_GPL(inet_csk_clone_lock);
-- 
2.48.1.502.g6dc24dfdaf-goog


