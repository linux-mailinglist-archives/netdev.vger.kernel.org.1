Return-Path: <netdev+bounces-282135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLbDBCVA8WmhfAEAu9opvQ
	(envelope-from <netdev+bounces-282135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B45B48CF32
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 117E930232BE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71247389DE6;
	Tue, 28 Apr 2026 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUArBmoS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4583890F3
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418161; cv=none; b=HICt0Za/0LKOySgwC2q5/U8TAKWn2lIWUHEyiEJwWasOBPN88CS82KP5njhF3sk0Klvdq4Fa4ueooXfOCv5/KiR1BBlFXDl54qKtTqkKZKfrVAnSSsVgSy94gQlUE3p+bFyinpGeKDCewqqjHp3aDKIaXLCwYjFVGSNumgTlwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418161; c=relaxed/simple;
	bh=dOMPlL7AgmtInVnxU4LbBpRdeo/xUJORi1WsNFBaSuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXIi4VS9r9b/c6dgPDrE8k0g9ARiZiX1vkZ1RWhBuhk3LEq/CEdKatd3iT5+GU/pB+E1MF7h6w1Y9m4GN5EP4PumsLNakOsANUV017iRpDZXZJDaGxpkF7cwB6scHRL5sQMN8g6TvH4Xcl9DfkYwRYG8Bkw5Bhe9qUz8wEs/AvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUArBmoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD9EC2BCAF;
	Tue, 28 Apr 2026 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418161;
	bh=dOMPlL7AgmtInVnxU4LbBpRdeo/xUJORi1WsNFBaSuM=;
	h=From:To:Cc:Subject:Date:From;
	b=hUArBmoS5tlrYIZ4+ILEYbAKbMQf7emT3Gffsxpy0gtJ9AOoL+TrHHkeyjsILYsVd
	 9Uv27GXJO5Csg2Ri8OXkrhiz62XKYfnGX7Knyr+Uli98y0+nslsERara9N30O1B3m5
	 GcOeG0Sdy+idxBKuXbRZRBS9xyxYSapJcRO0J4PECfebWM43x83NTn6dB2LQUL3mWz
	 DsdJNi9K0E5YbUJjtn0CykjfGNRAKBIGyE6skcSmi1fpta24lCb/IsG/MzmDIW+oFm
	 Uf00ZRny7TX+BvbQ+pO1f6WEkkM+AWbBv3Jgln4bmdhTCeKjL1eFudsf5VYKYD7kKz
	 5kfK0wmttXOrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	john.fastabend@gmail.com,
	sd@queasysnail.net
Subject: [PATCH net] net: tls: fix strparser anchor skb leak on offload RX setup failure
Date: Tue, 28 Apr 2026 16:15:59 -0700
Message-ID: <20260428231559.1358502-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B45B48CF32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282135-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:email]

When tls_set_device_offload_rx() fails at tls_dev_add(), the error path
calls tls_sw_free_resources_rx() to clean up the SW context that was
initialized by tls_set_sw_offload(). This function calls
tls_sw_release_resources_rx() (which stops the strparser via
tls_strp_stop()) and tls_sw_free_ctx_rx() (which kfrees the context),
but never frees the anchor skb that was allocated by alloc_skb(0) in
tls_strp_init().

Note that tls_sw_free_resources_rx() is exclusively used for this
"failed to start offload" code path, there's no other caller.

The leak did not exist before commit 84c61fe1a75b ("tls: rx: do not use
the standard strparser"), because the standard strparser doesn't try
to pre-allocate an skb.

The normal close path in tls_sk_proto_close() handles cleanup by calling
tls_sw_strparser_done() (which calls tls_strp_done()) after dropping
the socket lock, because tls_strp_done() does cancel_work_sync() and
the strparser work handler takes the socket lock.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
---
 net/tls/tls.h      | 1 +
 net/tls/tls_strp.c | 6 ++++++
 net/tls/tls_sw.c   | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index e8f81a006520..12f44cb649c9 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -188,6 +188,7 @@ int tls_strp_dev_init(void);
 void tls_strp_dev_exit(void);
 
 void tls_strp_done(struct tls_strparser *strp);
+void __tls_strp_done(struct tls_strparser *strp);
 void tls_strp_stop(struct tls_strparser *strp);
 int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..c72e88317627 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -624,6 +624,12 @@ void tls_strp_done(struct tls_strparser *strp)
 	WARN_ON(!strp->stopped);
 
 	cancel_work_sync(&strp->work);
+	__tls_strp_done(strp);
+}
+
+/* For setup error paths where the strparser was initialized but never armed. */
+void __tls_strp_done(struct tls_strparser *strp)
+{
 	tls_strp_anchor_free(strp);
 }
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 94d2ae0daa8c..798243eabb1f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2624,8 +2624,12 @@ void tls_sw_free_ctx_rx(struct tls_context *tls_ctx)
 void tls_sw_free_resources_rx(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_rx *ctx;
+
+	ctx = tls_sw_ctx_rx(tls_ctx);
 
 	tls_sw_release_resources_rx(sk);
+	__tls_strp_done(&ctx->strp);
 	tls_sw_free_ctx_rx(tls_ctx);
 }
 
-- 
2.54.0


