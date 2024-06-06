Return-Path: <netdev+bounces-101583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E8E8FF81B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED9D28228B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FF413E3EE;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkdECwNu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B16E26292;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716374; cv=none; b=noQF4GSRJqdyAdSLv+uyx2d27nhiF4XKiz/vCMyheCrALHKWIDD3mVgkQe3XAee+szgzwDMlLXuvjiYpc2p23F2BF9xerzPO7Nr3Q41S6cqq3vGFGc5qNAZC9XvbxQi8ZSaGbvWPJ3fLGaKHK+1RfTClNUiznQu8qLzXeVsZ6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716374; c=relaxed/simple;
	bh=M+7owuWJKB1TcQGrX6ydAUMZphqPdvJHKkUxkJgNcS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JstJPxbTFtheAqsUJmTnyMjhDjp6epM6s/d/gbUyVIN9I/dF35fCo9Zv3mvp5LSvqoNXiytl8CZPB1n9tIIvdq7AHbA98Vt5XK6vhjyNCnR1zYxNHOw+0SkSZoOC/fgrQvzE0XDSjwNLthKm88n/VlNvVs9sjmoGmRd+n+FXMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkdECwNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1610CC32781;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717716374;
	bh=M+7owuWJKB1TcQGrX6ydAUMZphqPdvJHKkUxkJgNcS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XkdECwNufaNp2v5aRlxBq8p9Q8C+Cl5N6Zkf3YsSBupip+aOJRpcQRah0LlJuvdLk
	 91DLjETxnCrXxXXdl35ixmy557hRxZpf9XdcvwZRHchww7tz/5irTHtZEgcqaTIvdE
	 5cVM1h0XKpm4Kwh6pXOHgwLoUb5eMBxg2vdEWvgK5wSz4qHZkuYqEtzHK0M16UU51k
	 b4BzCBNiokTMAw0I4+7mcB/napOuFDozd2bH42opSVgpVRxhu0grxR4BavS8YNhzJr
	 8/RczeMj/4yvA7e8L/WtRQLhfoncAz4C8qST16+odN5gHc76JGFNDBY4cZQrLnWp/V
	 Ii8HmanXRj62w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BEDC27C54;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 07 Jun 2024 00:25:55 +0100
Subject: [PATCH net-next v4 1/6] net/tcp: Use static_branch_tcp_{md5,ao} to
 drop ifdefs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-tcp_ao-tracepoints-v4-1-88dc245c1f39@gmail.com>
References: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
In-Reply-To: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717716372; l=2434;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=A+9VHh2Wjb1Lw7NYtMOuRJG+qPpXrhu2iaF3GgBb+QE=;
 b=w/5KE85UJNmKQBg00hYW6MZCqodcIzzoCoepeBt2fMkrGGCbgbcAkXfWJ8De5H+/UgEbIMHa7xWn
 lA9J34nWCKr+oTFgSQhjJ0ynhsMP7wMy8mrtsua1LOXrhJV/3kkH
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



