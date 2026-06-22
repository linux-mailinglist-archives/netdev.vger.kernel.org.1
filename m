Return-Path: <netdev+bounces-301044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G/JLAZcSOWpgmQcAu9opvQ
	(envelope-from <netdev+bounces-301044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:46:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C86AED21
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:46:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P3Y1fIq9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301044-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301044-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85372301CC5C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874643A1A29;
	Mon, 22 Jun 2026 10:44:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743013911AB;
	Mon, 22 Jun 2026 10:44:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125098; cv=none; b=G0D9h8qnsO+MubWDq8wW/93Ea9R/u8ewHbguQTrfRmXNY4lGdaOS1AER/bwtxdpiCjPtl86V/IPk+r+9VuvvlI5YQQJRWCbfuK+XIOI6ZYhCzqQ6e19TWx1pPY6JZyln0HyAzhCZcawNLX6Xy112hxM8vz0gmScD/tR5HWQN86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125098; c=relaxed/simple;
	bh=8MUhb382d/R1PCu+tdHK8NlDjZwLDeCDY5OQYjc9EpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0z8SaaZ4p6C1Kl3aFJEYBpmzA9p3HomS0ZN6kDeYY+e4cgg5DjPaq4zATuEMLnRzKprQWOcXADdCYNlkQ8IUszu5Jdpq/ywuH97nZvbVqFEt7PnoKOP2JidzNs4q9weIoTGcNkclpv7vmBAd4QyN6xX+AEKbaq9tpwA4um29W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3Y1fIq9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB101F00A3D;
	Mon, 22 Jun 2026 10:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125097;
	bh=soDiR3RUZ9V+2GK/1ZPqifI1nKWagFi1KoWspkiO5mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P3Y1fIq9rFsWLiEd2siAIKgxDJtDdPWZpuzTRLP3kYvv5R2cZ6ZKI79Ajm2fsZ4K/
	 HqF3vil6YGUuwgVFTuUGiBxbIUTZsq0qkZ6K29HY45Oqd4kSpTm2fppwVZw+MDp5Wo
	 YESRoHvQVpgAQfw2ZRxvEIJl3Y5tH66c8MVtrHfmpbdbo/2DwTliVUldsJnfztQgG3
	 VjOnDtBGrekRrP8i47E6aNRvT5TNGguUXmzUECBpJMjNSHzXYwpJTPjZEy5qWz8d/F
	 xuV6cjxUW7G4BmkdntHWlQ1v2ji1tbXaOxjd/kCG6OSOvobhfF0owgtaho5RMznG5m
	 ZU+stnIZ37msg==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 08/17] tls: store original read_sock for non-tcp sockets
Date: Mon, 22 Jun 2026 18:43:28 +0800
Message-ID: <f4a199f216cb5eeca3d25110a8cfdb080df59d22.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301044-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D8C86AED21

From: Geliang Tang <tanggeliang@kylinos.cn>

TLS strparser uses tcp_read_sock() to copy data from the underlying
socket. This assumes the socket is always TCP, which fails when TLS
is used over MPTCP.

Store the original socket's read_sock method (sk->sk_socket->ops->
read_sock) in a new .sk_read_sock callback inside struct tls_context.
Then in tls_strp_read_copyin(), call this stored callback instead of
the hard-coded tcp_read_sock().

With this change, TLS strparser works transparently over any socket
that implements .read_sock (including MPTCP, which already provides
mptcp_read_sock). Behavior for plain TCP remains unchanged.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  | 2 ++
 net/tls/tls_main.c | 1 +
 net/tls/tls_strp.c | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index e57bef58851e..aee4f74dc3d9 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -262,6 +262,8 @@ struct tls_context {
 	struct sock *sk;
 
 	void (*sk_destruct)(struct sock *sk);
+	int (*sk_read_sock)(struct sock *sk, read_descriptor_t *desc,
+			    sk_read_actor_t recv_actor);
 
 	union tls_crypto_context crypto_send;
 	union tls_crypto_context crypto_recv;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b6adfa67491b..c9499bfd7a1d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1086,6 +1086,7 @@ static int tls_init(struct sock *sk)
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
 	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
+	ctx->sk_read_sock = sk->sk_socket->ops->read_sock;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 82a5b64b5f48..9945d17b2f8c 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -375,6 +375,7 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	read_descriptor_t desc;
 
 	desc.arg.data = strp;
@@ -382,7 +383,7 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
+	ctx->sk_read_sock(strp->sk, &desc, tls_strp_copyin);
 
 	return desc.error;
 }
-- 
2.53.0


