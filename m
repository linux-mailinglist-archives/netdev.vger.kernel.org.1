Return-Path: <netdev+bounces-295829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KqnyNkrKImrrdgEAu9opvQ
	(envelope-from <netdev+bounces-295829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 15:08:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C331648679
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 15:08:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kzNFY45o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295829-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295829-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286D13070F2F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3C3803F3;
	Fri,  5 Jun 2026 12:57:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0F385D77;
	Fri,  5 Jun 2026 12:57:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664239; cv=none; b=chQ8PUKLhG3K9cEQSlayvwDbySAPQuT0fdNwIvhIfwczWWRJYZcvOl80uNxYZpA6QEnueJV2iuKIfGIVSNYqCqNmnBmHbburUAx/Tn+SH4SYrteKv5DcnY5h8U+iQB2goRg7WkX0aEZft/zPmSV/YbFFiLRlnxEy6Mx/dRwA1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664239; c=relaxed/simple;
	bh=2gDsZLPkqY1uRIJkwjXi8LY2Nq7ONbmfCtUnxeK4UlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlv2/dAeBcTkbK49rBVh16wYHvuYaYnTPP8svqbg7Gy1L8FfvlJSoHCArjikjgHhb2IOyKeza7RnWTr2kRICV3V7Ra6k0o+uWLvMNJAdxsDcCLige/2TXZcxnQmCHm2RGYSZs9mKpeIYsUYsRZoH4G9iAC9QvpuRAjL+xPBkVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzNFY45o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA151F00893;
	Fri,  5 Jun 2026 12:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664237;
	bh=xW/9033em5tyQ+Y/zDCFngnNCH0QAduSUxtG+Zo2vwc=;
	h=From:To:Cc:Subject:Date;
	b=kzNFY45oBMUoIxr6I22HWDdOGfNjKoCc04rg8fWPJ9xBh2Gpw1XCFNVXdHJuyQdlj
	 WNRE8XdUQWo8dfzD8DZLVV7ohvBjGTclKrvTN0ZvLHSabMghqMTS7lNgzRDkDE8nZT
	 Vl8yOeJzk0/Tm6qlxIDNZ0/8RLnIsUmOfoCDhvcP5vAgeYiVCliynCgKH/R9FmELWg
	 BiTYHJz6eatjVNKzXDqslgp6YHJ+ud8uA5wOeIg6g4sDynvTQuN2xXeK7im9vqo+Iy
	 DEUZS7YqME4AZPClAwqw01TvKZ1kvUmRELc2O+sisR7d1KuAsijtzwCdbcehh9GMdK
	 wnE46jnsWVZxg==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Atul Gupta <atul.gupta@chelsio.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH net] tls: restore sk_prot before calling original destructor
Date: Fri,  5 Jun 2026 20:57:07 +0800
Message-ID: <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:atul.gupta@chelsio.com,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,chelsio.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295829-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C331648679

From: Geliang Tang <tanggeliang@kylinos.cn>

When a TLS socket is offloaded to a TOE device, tls_toe_bypass() replaces
sk->sk_prot with a TLS-specific protocol table. On socket destruction,
tls_toe_sk_destruct() calls the original sk_destruct callback
(ctx->sk_destruct), which may rely on the original sk_prot (e.g., for
memory accounting or close handling). Without restoring sk->sk_prot
before calling ctx->sk_destruct, the destructor may access stale or
incorrect protocol functions, leading to use-after-free or kernel panic.

Add WRITE_ONCE(sk->sk_prot, ctx->sk_proto) before invoking
ctx->sk_destruct to restore the original protocol pointer. This mirrors
the restoration already done in tls_sk_proto_close() for the software
and device offload paths.

Fixes: 76f7164d02d4 ("net/tls: free ctx in sock destruct")
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Hi,

This bug was identified by Sashiko during my development of "MPTCP KTLS
support" [1]. I am sending this fix separately for now.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1780621326.git.tanggeliang@kylinos.cn/
---
 net/tls/tls_toe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
index 825669e1ab47..c9c1a0952f4b 100644
--- a/net/tls/tls_toe.c
+++ b/net/tls/tls_toe.c
@@ -48,6 +48,8 @@ static void tls_toe_sk_destruct(struct sock *sk)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx = tls_get_ctx(sk);
 
+	WRITE_ONCE(sk->sk_prot, ctx->sk_proto);
+
 	ctx->sk_destruct(sk);
 	/* Free ctx */
 	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
-- 
2.53.0


