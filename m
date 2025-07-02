Return-Path: <netdev+bounces-203543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B12AF655C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022EA524E11
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBDA2F85F1;
	Wed,  2 Jul 2025 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5YKMfGl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC52F7D0A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495777; cv=none; b=DGttxnPWoPBFSg3Pfybi9UDsfcYhJmsrleVNq7YSLG3RtUfvlsWCI78hR/gEQ5ZmWsdgPkitMKLk1brFCH/DLHXYP8T0rIUqCxbeMePkuEl/E2+62s6hClgyYlLyadGqeyPJpR76pqYbA0AwZVZtVScc/VAYK+qFM10tPgWUO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495777; c=relaxed/simple;
	bh=o5842VTlELOtdLKUtQ0V+qX6IFqC06Xxus6gcmHrFmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CcyBBKOOQAqu8Pfs1BmZt3rq3RJgydBupoRFlL6060uRR/ZFBDDgPGQJEN/HytDf26nKb0w9XKfWyx5lDoTRaLhBeaXwNYgEXZBnEhA7fcfzR5KWdI0lp+nCBQcm+/QniUme925+vpHCuj1f+CMFf221PeYED+hNtlXl6qL1ns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5YKMfGl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-749177ad09fso2185388b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751495776; x=1752100576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+hZDaqvG/Pprt6uOD9GJq6ajuVuv4TQ0N/e04L3aHY=;
        b=F5YKMfGl/dPa0BU2amh6YCz6Maarz0CRXhyAdIOyQd2Ij1bcfF+3bCl60JZk1Vxy6Y
         juYUcOu2F6DRmMHQb/af/3bryIUOJaquKmNqkb1fkZGq3skG+ZCqKKtxCFmfDQuzWs0C
         LpjvO2P6bP2xoXSk82fWevZ2irglC1lqS/L7pRJf9NVGG5SsOoVnezFxMpGKc/EF2tmO
         cVc15Zbz9O9SsIUBPXncsGfxtDdHwAYNpNbMXCzU7ZEJXS0ADEwfS/YE8TgwAkodoTkc
         32vvPxSYfSojnYVVGJYAYRmrRko5vvPUreSLNfbokpgxyV5zO+pMKp6tMuR+Nl76gTIL
         b0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495776; x=1752100576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+hZDaqvG/Pprt6uOD9GJq6ajuVuv4TQ0N/e04L3aHY=;
        b=HKOD4IwuZbUeXFT3bXJH1pexbEeRIzop7fu8dxtvuCfxhGb2Ng2ht/BLQPWJIKtSOe
         EeLEmFawo17ukyml3DY4UMibXNvf+x+wTbt5Nb6x4jCu+AoScrTu25iUKm6pvq3v1mWO
         NTthQwPvlFUXxnvwfVyweLf2jEOBwz13klZC3OHs3z09EVCnmYdU04+fpc8iAQJWCB8A
         PIoPWOEkBKaRwzJT1/RUVrcW/TEpxbGgKViHHEgHvzxiToMfMApQ+36sdgFxLtzVsi9v
         ypI2fXZYht9RDhMlwRX4ZIroJDQ4IZxw/6gZO3PObMLFz9UvgXykaiAcuvLQ58//DJNP
         5bHA==
X-Forwarded-Encrypted: i=1; AJvYcCWXFAHv2M8CJc7tTh5C/6/MWJlGWU7KHQBpwuXYuQy7n5Qvn0+nXNiCrpymaB80RCSlBqHwtpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+GkrGvvxUs3m/7BQ7CXrh/eVrzXO8iQruLGxAn2YDzZvUWkT
	2ta3jvciAtDyR5yALUstFnCmT8MNb+FkocI12xLePJBiF5k+t+1Gl1VwCHvyKWVM2/PD2/nIbtp
	348KGSA==
X-Google-Smtp-Source: AGHT+IGGJXKz3c5F10WQd1kp0enfY62WQmPjRolatq0lORTWTjExKs/L08mqChgM7GMmt2/laU1YD3nqRaU=
X-Received: from pgjf21.prod.google.com ([2002:a63:dc55:0:b0:b2e:664a:d5f4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca1:b0:220:2a64:bce1
 with SMTP id adf61e73a8af0-2240bebaa59mr2038735637.35.1751495775879; Wed, 02
 Jul 2025 15:36:15 -0700 (PDT)
Date: Wed,  2 Jul 2025 22:35:17 +0000
In-Reply-To: <20250702223606.1054680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702223606.1054680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702223606.1054680-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/7] af_unix: Cache state->msg in unix_stream_read_generic().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In unix_stream_read_generic(), state->msg is fetched multiple times.

Let's cache it in a local variable.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index aade29d65570..074edbbfb315 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2841,20 +2841,21 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				    bool freezable)
 {
-	struct scm_cookie scm;
+	int noblock = state->flags & MSG_DONTWAIT;
 	struct socket *sock = state->socket;
+	struct msghdr *msg = state->msg;
 	struct sock *sk = sock->sk;
-	struct unix_sock *u = unix_sk(sk);
-	int copied = 0;
+	size_t size = state->size;
 	int flags = state->flags;
-	int noblock = flags & MSG_DONTWAIT;
 	bool check_creds = false;
-	int target;
+	struct scm_cookie scm;
+	unsigned int last_len;
+	struct unix_sock *u;
+	int copied = 0;
 	int err = 0;
 	long timeo;
+	int target;
 	int skip;
-	size_t size = state->size;
-	unsigned int last_len;
 
 	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)) {
 		err = -EINVAL;
@@ -2874,6 +2875,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	memset(&scm, 0, sizeof(scm));
 
+	u = unix_sk(sk);
+
 	/* Lock the socket to prevent queue disordering
 	 * while sleeps in memcpy_tomsg
 	 */
@@ -2965,14 +2968,12 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		}
 
 		/* Copy address just once */
-		if (state->msg && state->msg->msg_name) {
-			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
-					 state->msg->msg_name);
-			unix_copy_addr(state->msg, skb->sk);
+		if (msg && msg->msg_name) {
+			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, msg->msg_name);
 
-			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
-							      state->msg->msg_name,
-							      &state->msg->msg_namelen);
+			unix_copy_addr(msg, skb->sk);
+			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, msg->msg_name,
+							      &msg->msg_namelen);
 
 			sunaddr = NULL;
 		}
@@ -3034,8 +3035,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	} while (size);
 
 	mutex_unlock(&u->iolock);
-	if (state->msg)
-		scm_recv_unix(sock, state->msg, &scm, flags);
+	if (msg)
+		scm_recv_unix(sock, msg, &scm, flags);
 	else
 		scm_destroy(&scm);
 out:
-- 
2.50.0.727.gbf7dc18ff4-goog


