Return-Path: <netdev+bounces-266831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FrdHVsbsmnjIgAAu9opvQ
	(envelope-from <netdev+bounces-266831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:48:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3067A26C00E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDD23037905
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FCB375ACE;
	Thu, 12 Mar 2026 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP8xycWK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC78375AB1;
	Thu, 12 Mar 2026 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280088; cv=none; b=Ye3shs4PAc1KAMtaJ5S1/0QgpXioXMK/BGlqrQMQeTYcmdi0Kcz/bpTcGHynJ2KTg7X1jvyiEg2NDGatdb6vPN3ZRFBFluDR7q91qwMQWK2m/9jr1rsWS8paoA3z0LbMxy0DM/cFgLjjeZA22Du0cVWgdWdwVif5QbU+ZwDIyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280088; c=relaxed/simple;
	bh=5b/usVhx75iOGdckh9aiH4z1tfkrN7xh/oib5pX49pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KifiumUYXRPrv6eWW69GTXzhQRu3x2KXdkQ1lodcmS0WTo5FSBoXpU4OLQBs2P7i/hZYovLeJLT/GmFhVPZbMjm81IBWG0eHoeTk69yOGWYsH2ZokyLsGTSVYt1x5EhEJyYYU5gtpJqIVQ6J8xHKtfR1pRCb+3lT0VyD6t66PlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP8xycWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A41C19421;
	Thu, 12 Mar 2026 01:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280088;
	bh=5b/usVhx75iOGdckh9aiH4z1tfkrN7xh/oib5pX49pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JP8xycWK8ZD7nrWLis/bZeFb5QBfNOwMiK/yWik6+g9PS3ufhncy8HpOiEcTcWa4B
	 325Hsvj3XyUEf3LICZ6CThnIIg75TO7JEDGF4gJK1org+eFBNyAmhV5cL+SGGprY+2
	 S5HPwPrjWPH3M1V4OipXLmQNLM0ufg/8IGIYxGNgK9CIgOF32Kcy1q5DWcPVf/POmY
	 wbNZvNidzTunHBFw09gg12oML98d8vsjcRN159mUYQyaG22AhOV5o8By3Q8nlmc/mO
	 SJgjj9Qgc9iHLNohmE5uHtygBghyI+Q3sosy5LYhPIhEFZ/PwWfJdVcmUhkah5ApSc
	 1jA7ZxXkc0ySA==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 1/8] tls: Factor tls_decrypt_async_drain() from recvmsg
Date: Wed, 11 Mar 2026 21:47:57 -0400
Message-ID: <20260312014804.5083-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312014804.5083-1-cel@kernel.org>
References: <20260312014804.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266831-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 3067A26C00E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The recvmsg path pairs tls_decrypt_async_wait() with
__skb_queue_purge(&ctx->async_hold). Bundling the two into
tls_decrypt_async_drain() gives later patches a single call for
async teardown.

Reviewed-by: Hannes Reinecke <hare@suse.de>
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
2.52.0


