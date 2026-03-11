Return-Path: <netdev+bounces-266386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ODQLpO1sGlvmQIAu9opvQ
	(envelope-from <netdev+bounces-266386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:21:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42967259B34
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E371309543B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD56031AF3B;
	Wed, 11 Mar 2026 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVtNyzi4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994EA31AABC;
	Wed, 11 Mar 2026 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188401; cv=none; b=Pi/txRC7kPqGNNfNGb3Sn9BUa2f2p6u9hzcHtB8ZqBIqsAcUbKB52ZmHnmNQnXLlRdnFpgNeDCn9fWYE6st+uYkwLXLQRG7TAWy+NGnk04yKFreUZ6QlpLbHVjtmZpcUvtwrDXpQQyM2HfU9NKJrC2NkhWmEDpOs0JUMIlHEmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188401; c=relaxed/simple;
	bh=K8rqDH4fcaoiYtlOysVL9g9Ks6aDcnHoHCcSkwAI4ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5kdVI0fyrZ5IpQByUHpFmezGwFHXox/AC1f5da09gS8nInX8zbhwv/MIMrjRzhis0u7ZCXVNlPAdwOuqZxzZ3yDFRzYhem/PQ47gPURYzyFPtJSTYxMreMw4STEoY+I+885hpj51PWlWUOZNNxNZaTYbOdLIZfeV0AUXqbqFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVtNyzi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EEBC2BCB1;
	Wed, 11 Mar 2026 00:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188401;
	bh=K8rqDH4fcaoiYtlOysVL9g9Ks6aDcnHoHCcSkwAI4ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVtNyzi4bndtLnwrLBdueF6YoLXciXteAISMYIISpW+9bw5VREz4zI6KOIn7fASHJ
	 p3pURdBLW3sAWTEw/pnTwW83A2VDiUCzTtlgBZr9BwJWHNsCRRuBcvfrbXeEUHIb63
	 Mvj5xLhiuZ/lkveuObwYjJK2NNzAHiaf+4mdQDerv1ZMe3eZf+Xo0TiqR1LQGG79Er
	 wMZznLyFpAAg0yS6JdMFDM+J4qjVrUVm5gJb3beuXUeGa2OW1KPfQP8+jr8Je8v9LW
	 xu9ltwAihEEydfLFNbGOMiP+biE6wkqmuEVQ+qErRFIaVQURR5DdB4+HuoTSeW1+sv
	 e5tQFPYp5kw4g==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/8] tls: Factor tls_rx_decrypt_record() helper
Date: Tue, 10 Mar 2026 20:19:46 -0400
Message-ID: <20260311001952.57059-3-cel@kernel.org>
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
X-Rspamd-Queue-Id: 42967259B34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-266386-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

recvmsg, read_sock, and splice_read each open-code the
same sequence: zero-initialize the decrypt arguments, call
tls_rx_one_record(), and abort the connection on failure.

Extract tls_rx_decrypt_record() so each receive path shares
a single decrypt-and-abort primitive. Each call site still
initializes darg.inargs separately, since recvmsg sets zc
and async between the memset and the decrypt call.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index cedcc82669db..81e0e8aaa6f9 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1832,6 +1832,17 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	return tls_check_pending_rekey(sk, tls_ctx, darg->skb);
 }
 
+/* Decrypt one record and abort the connection on failure. */
+static int tls_rx_decrypt_record(struct sock *sk, struct msghdr *msg,
+				 struct tls_decrypt_arg *darg)
+{
+	int err = tls_rx_one_record(sk, msg, darg);
+
+	if (err < 0)
+		tls_err_abort(sk, -EBADMSG);
+	return err;
+}
+
 int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
 {
 	struct tls_decrypt_arg darg = { .zc = true, };
@@ -2132,11 +2143,9 @@ int tls_sw_recvmsg(struct sock *sk,
 		else
 			darg.async = false;
 
-		err = tls_rx_one_record(sk, msg, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		err = tls_rx_decrypt_record(sk, msg, &darg);
+		if (err < 0)
 			goto recv_end;
-		}
 
 		async |= darg.async;
 
@@ -2294,11 +2303,9 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
-		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		err = tls_rx_decrypt_record(sk, NULL, &darg);
+		if (err < 0)
 			goto splice_read_end;
-		}
 
 		tls_rx_rec_done(ctx);
 		skb = darg.skb;
@@ -2380,11 +2387,9 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
-			err = tls_rx_one_record(sk, NULL, &darg);
-			if (err < 0) {
-				tls_err_abort(sk, -EBADMSG);
+			err = tls_rx_decrypt_record(sk, NULL, &darg);
+			if (err < 0)
 				goto read_sock_end;
-			}
 
 			released = tls_read_flush_backlog(sk, prot, INT_MAX,
 							  0, decrypted,
-- 
2.53.0


