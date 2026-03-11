Return-Path: <netdev+bounces-266385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePwkKoe1sGlvmQIAu9opvQ
	(envelope-from <netdev+bounces-266385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:21:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B3259B25
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8570309037E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0431F9A9;
	Wed, 11 Mar 2026 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJTsF34G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F30317167;
	Wed, 11 Mar 2026 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188400; cv=none; b=LUDgE+gxk6E3CtSmZcR37qZtF6xTvxFVFqGneHWTpfWIIlSwR399T8AEiOlzUdfK38tq+s64sJt0l68DfMfZpZB/h7+b4W9R1Sj8/eCL5Z8aRNasKdSKRm3ObBE5GUoNilfHHdPfv+hEPov7K6Xbfdtnvdfbl0kFUWZ3irS7xsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188400; c=relaxed/simple;
	bh=b02zkt4NUR9l+CTwQ1oDADehl+q6118Aw00vCjrG7SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCfJyNNhsJOSjsegYesO6/ESW2WFuJboQ5cgEpN6GOdjNweMLxTYguoIn0Yi9pAlXC7fGnFp4nAoyGun46Tkmo9LUBkZrYn7R5Yd9x06r4DURqoSL4PeNlXL4LccUEbiZOdeNY8kpjWVpsygXWB3cYNEnYxXQlzdfZ32ziP0XEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJTsF34G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC62AC2BC87;
	Wed, 11 Mar 2026 00:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188400;
	bh=b02zkt4NUR9l+CTwQ1oDADehl+q6118Aw00vCjrG7SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJTsF34GbZr7TMIz7WV9Vhb7cHJma8psjxNX2S2YTOg0I2/gtu5ETGraO9jH5pI0s
	 YgdddnLZCm0fgLq/ZXvQBa4arX5HkoMdGdmrYFvfEYOZ6Hn3fXIxcxYAqv7H/07GJr
	 XyOynShl/SmvHoJh0XbwJ63oXKPKVci+Zjyii2skO4d0oaFpv+43eS45hIzC1qMSGP
	 sN5DjAK9lAxSxZsSoMxp8RE+srcgHj0e7UpAU2B1jmRBB3nCqIGDTCfzvDrWKDAgAI
	 WBdgSSbhZnGkK8R8+2EOUfScnNYy84o9vHv7hE6mzSD6rRbmqLqgbTxBxxXuEP9Uo9
	 KzXdRqZYq395Q==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/8] tls: Factor tls_decrypt_async_drain() from recvmsg
Date: Tue, 10 Mar 2026 20:19:45 -0400
Message-ID: <20260311001952.57059-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311001952.57059-1-cel@kernel.org>
References: <20260311001952.57059-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 230B3259B25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-266385-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The recvmsg path pairs tls_decrypt_async_wait() with
__skb_queue_purge(&ctx->async_hold). Bundling the two into
tls_decrypt_async_drain() gives later patches a single call for
async teardown.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a656ce235758..cedcc82669db 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -249,6 +249,18 @@ static int tls_decrypt_async_wait(struct tls_sw_context_rx *ctx)
 	return ctx->async_wait.err;
 }
 
+/* Collect all pending async AEAD completions and release the
+ * skbs held for them.  Returns the crypto error if any
+ * operation failed, zero otherwise.
+ */
+static int tls_decrypt_async_drain(struct tls_sw_context_rx *ctx)
+{
+	int ret = tls_decrypt_async_wait(ctx);
+
+	__skb_queue_purge(&ctx->async_hold);
+	return ret;
+}
+
 static int tls_do_decryption(struct sock *sk,
 			     struct scatterlist *sgin,
 			     struct scatterlist *sgout,
@@ -2223,8 +2235,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		int ret;
 
 		/* Wait for all previously submitted records to be decrypted */
-		ret = tls_decrypt_async_wait(ctx);
-		__skb_queue_purge(&ctx->async_hold);
+		ret = tls_decrypt_async_drain(ctx);
 
 		if (ret) {
 			if (err >= 0 || err == -EINPROGRESS)
-- 
2.53.0


