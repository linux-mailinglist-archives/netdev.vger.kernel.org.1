Return-Path: <netdev+bounces-101205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77AE8FDBC7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5121C22DA3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D28011713;
	Thu,  6 Jun 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P15oJyyi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B8CA64;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635511; cv=none; b=DISPp7AJgipxr0OBzHe/C+MCA6TYHBZ7pQ1wyQHaBfQumBgEEhqeAFpBt8vLNOpNPCq25UzEZW+WnXoo4nzxq/3O5vWT4WiFBplblDTnsryNrYLRZfRZWODXJTzgVAa5m3PG1cLBhnKOY66c+uHBOqOGrKkMzOj0wjHSUS1p35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635511; c=relaxed/simple;
	bh=M+7owuWJKB1TcQGrX6ydAUMZphqPdvJHKkUxkJgNcS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3lGyDcE1EOs0mxgYNyneDsyKb3FA5fE1KcWwNQe7TFJha8wsorqOdJehETl+nrBfm90Tc1j9oqrxN+P/Rh6+lusFsrGEFxETJFO3rOa5HpBBoKGGac/GqAxKU2xXKiNLDFpZsh8MMMNfGITsARRqETURUrtnQrdPhaqDPsj5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P15oJyyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6EE0C32786;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717635510;
	bh=M+7owuWJKB1TcQGrX6ydAUMZphqPdvJHKkUxkJgNcS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P15oJyyiiYyVQ7pObcgODIUbWnZ0X2Vb8AlcwrObY0bKbbboFfvo9WgMVjg+RzfKD
	 vbfEoid+Wtt4lpgi/cJ9H4lfqhKpTLbc2O21jSQ87H7q2HI8ddfj2sfKHdyv3NwOyw
	 xj4Yj7iRIU0H+CAFJAc40c3FxwhAqkfJogOrBu3cJiGnLxMfkSpjPO4WOmd5ijCiCP
	 iHRuaSejqEishMUF6aanHmUzHW3dOsVMnZcprMdHr0xIAQhV9KBaBnwouG41HeKqUE
	 lBAxhokkanEDjuG3jHLfQD2YRJHMSD2d4F/GuG0vnBkJa+5nqP6+pF5xQOcs0hXiTo
	 bXc/jzDBZgP8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA22C27C53;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 06 Jun 2024 01:58:18 +0100
Subject: [PATCH net-next v3 1/6] net/tcp: Use static_branch_tcp_{md5,ao} to
 drop ifdefs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-tcp_ao-tracepoints-v3-1-13621988c09f@gmail.com>
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717635508; l=2434;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=A+9VHh2Wjb1Lw7NYtMOuRJG+qPpXrhu2iaF3GgBb+QE=;
 b=MCMtuXR3ptmAVjLy1xb4OSwJnmGn47nX3fU02e6GW7Gr6tLyf59HRUQ2a8R8qm0CrynCMyp0vaTk
 T1XblNqQDbuyQSz74TIIohG5rzLmrB894f2H5QmJZQfYa1LFNEdd
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

It's possible to clean-up some ifdefs by hiding that
tcp_{md5,ao}_needed static branch is defined and compiled only
under related configs, since commit 4c8530dc7d7d ("net/tcp: Only produce
AO/MD5 logs if there are any keys").

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp.h   | 14 ++++----------
 net/ipv4/tcp_ipv4.c |  8 ++------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a70fc39090fe..e5427b05129b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2386,21 +2386,15 @@ static inline void tcp_get_current_key(const struct sock *sk,
 
 static inline bool tcp_key_is_md5(const struct tcp_key *key)
 {
-#ifdef CONFIG_TCP_MD5SIG
-	if (static_branch_unlikely(&tcp_md5_needed.key) &&
-	    key->type == TCP_KEY_MD5)
-		return true;
-#endif
+	if (static_branch_tcp_md5())
+		return key->type == TCP_KEY_MD5;
 	return false;
 }
 
 static inline bool tcp_key_is_ao(const struct tcp_key *key)
 {
-#ifdef CONFIG_TCP_AO
-	if (static_branch_unlikely(&tcp_ao_needed.key) &&
-	    key->type == TCP_KEY_AO)
-		return true;
-#endif
+	if (static_branch_tcp_ao())
+		return key->type == TCP_KEY_AO;
 	return false;
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 3613e08ca794..b36bfd64382f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1054,12 +1054,10 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 #else
 	if (0) {
 #endif
-#ifdef CONFIG_TCP_MD5SIG
-	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
+	} else if (static_branch_tcp_md5()) {
 		key.md5_key = tcp_twsk_md5_key(tcptw);
 		if (key.md5_key)
 			key.type = TCP_KEY_MD5;
-#endif
 	}
 
 	tcp_v4_send_ack(sk, skb,
@@ -1128,8 +1126,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 #else
 	if (0) {
 #endif
-#ifdef CONFIG_TCP_MD5SIG
-	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
+	} else if (static_branch_tcp_md5()) {
 		const union tcp_md5_addr *addr;
 		int l3index;
 
@@ -1138,7 +1135,6 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 		key.md5_key = tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
 		if (key.md5_key)
 			key.type = TCP_KEY_MD5;
-#endif
 	}
 
 	tcp_v4_send_ack(sk, skb, seq,

-- 
2.42.0



