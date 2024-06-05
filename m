Return-Path: <netdev+bounces-100805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110508FC1AA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427391C22B3A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C0C55E49;
	Wed,  5 Jun 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijzrh2WK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5A1EB36;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554032; cv=none; b=S3rhccI4DOWD08yUvQylXWtJdgH/57LSILMhsIdplfASr2KhmXjnEiMrImEMLugCTySq/7KlvrUacUgs6HyJImltRyrZcUPlLcyWQJyFu+0ZO4rFfSbb2eNUzh9DUbpoCwNvEWWJry7ZtcPCIUZfBNSw8TLj/bgzB2SNasvMO9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554032; c=relaxed/simple;
	bh=tJ1awYP5L69e9xHMeuSbQ2+lYWQUK2O8SQPWa5BRTF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bK0UiMXEkiEl42BmYccVLCJLRyUQbJl1nh6fg75XcL1oXgjb7+bU7zDbg9ol1+9OWJsJq4iVDAZHilpLRvQgyQg6/PhWrBM1I6SFxULEI6I/i8roCU/CTHdNzBxCkE62B38ww5QlyuEasM9gozi0PIWutK4/zQ6/v7c0IxXQIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijzrh2WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A188FC4AF07;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717554031;
	bh=tJ1awYP5L69e9xHMeuSbQ2+lYWQUK2O8SQPWa5BRTF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ijzrh2WKXy11ljh1pIV0fU8jJMGYie94bsdE1J+mrXaN6hUJ1Yzc/EtJcuOzUmOTC
	 mRoF7E4kbAee8vYR6KbIxsAZxCcPqtxWtLF1EkegTfO5LsagnGjUx3PlMyPgVMO5Gt
	 l7asv7/zL3+qzt2Ex280lRTVnuAknTqiNTJEOR7ou/MuZTryb2mnD3k6gi7BJv6v7O
	 J/p0U7/xgJQ+ziKepEPZk+i1pT524MqNckP9/WXopryAzx3wjVe+bR+BfjeHZkenNw
	 DM9lPShYljj4HwtvE4w3dhgCy6rijobuDg9hZSnAaKhvpkoBJsDo6N7vBStTwMscHs
	 kIaT5G4AVetzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C439C27C54;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 05 Jun 2024 03:20:02 +0100
Subject: [PATCH net-next v2 1/6] net/tcp: Use static_branch_tcp_{md5,ao} to
 drop ifdefs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717554029; l=2385;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=vprIUxoXS6O+nQsZYJ0TnN8AY1IxVix3tPSqfwEiZ4I=;
 b=vKqtpyxvZrc7sKLEyhxdDFQVM+OvC7W9pmwXl9I+h5yYG9H4K8nOFcJf4eG4CPPWPJUjb22sbl2L
 r/7fpIdMBtXDXjHKSj60A4AvgZtm6FrU5cpHi7h+DqBsCtSeg51M
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

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp.h   | 14 ++++----------
 net/ipv4/tcp_ipv4.c |  8 ++------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 08c3b99501cf..f6dd035e0fa9 100644
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
index 04044605cadf..59c252b90b55 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1052,12 +1052,10 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
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
@@ -1126,8 +1124,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 #else
 	if (0) {
 #endif
-#ifdef CONFIG_TCP_MD5SIG
-	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
+	} else if (static_branch_tcp_md5()) {
 		const union tcp_md5_addr *addr;
 		int l3index;
 
@@ -1136,7 +1133,6 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 		key.md5_key = tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
 		if (key.md5_key)
 			key.type = TCP_KEY_MD5;
-#endif
 	}
 
 	tcp_v4_send_ack(sk, skb, seq,

-- 
2.42.0



