Return-Path: <netdev+bounces-286859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Aa3CrNlAmqZsQEAu9opvQ
	(envelope-from <netdev+bounces-286859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:26:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D69517441
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7E99303AF39
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C13630B2;
	Mon, 11 May 2026 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB3Z3sv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970236165E;
	Mon, 11 May 2026 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541977; cv=none; b=L9w7StYrTTQ2ess1ezdeJJpFDb+YR3Qs3g5R6xVLH/L8EHK3iI1tpkBIt+KVdsf75rPrbTCW6+9fP3gbP7opH/YqLxiDSeC5UKmFOVWJ4u6g1TANaCEA0yvsBUS4D1+/fL7IuMwutijsGlkpof8dr/iW/pIm3vyClZHfFhgM85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541977; c=relaxed/simple;
	bh=6QitpkQcyvOMV6v5rSbba5hwwrZ9rpupmnsSIon61ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4QFInRNhiKzNgOcXr5qcXw2rPtbveKznlZi+oC+7tNXqehHJfaw5NiwOpa31j6zW6jx1aiI6ZrDXm1MgYLl/tCpJI/id03yOCMAb2VVSHTTtPYwOo7P0gu1JDK5rGq9DehVamWfBYkwzoHWxdDPqN0QxFT3UbcSoSPGPrr4Svs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB3Z3sv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD26C2BCF7;
	Mon, 11 May 2026 23:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541976;
	bh=6QitpkQcyvOMV6v5rSbba5hwwrZ9rpupmnsSIon61ds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YB3Z3sv5AEn2qlDvfaN/0LR60PluvFy10v9fk0UymZ3VLc+tgpRBtffDcJ/GM6Hnv
	 CeNgmPdcIPMlY/s+4F21NZPiiKKGohbgGG/U9P48xXo+OZVNWwk7RNoOmZ4P81b/pw
	 39E9fEpHb0820eW5krKmYh4JtLeGeMz++5cul/iXTVv6fxzRyhKb/HhmtCD8UY94hN
	 DQZTrda40+OsCslIe8TbTlgltAApiCjy7sR8DLJ+M3bRf7V7KSLuN3525vz6nmeQ8F
	 LjwuuztfBBdMelxAJ7s+DXhydrsCioCqqEfHX/Dch8T5REFAJeArdjjdtFkcItJr5v
	 K8dtvE7wHpjuA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 11 May 2026 19:25:57 -0400
Subject: [PATCH net-next v10 6/7] tls: Flush backlog before waiting for a
 new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tls-read-sock-v10-6-279fc5015f0e@oracle.com>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
In-Reply-To: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=KaL64IKzNa/m6/MD4eXuqieu/IMKsc5ummh3EG9rnJs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqAmWSG0VpAppw2NtXlSGKYkeWOfoL9MDTIM2Ul
 dL+CkI5QXqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagJlkgAKCRAzarMzb2Z/
 lzHJD/9n88LDR3tQi47tHSDvCDWvTqc9OMesBYr51E2eknBhONLpdSpF0TXzfRcTIhl9nyWljKj
 1L8UHniOy4b44AY00T9OiRGf79FoVFyl7U/dYEwziWYhj4uMnnz9gLdwHZxvIvTtXSdkJyT+OmN
 72RK76Ws61RzWX+uwtN9WhZE8ewBxY6wRwbvj8Ar1C4jtlGV0AVTgL27s2WQDOSuvdyqWu+M5Rb
 CDxwTutO5emfj1BFcPtqdLnJF2i5NnORjxbxYXwrxNqLKNjraw0N+oYFcrLQIjkKr4JhTS1bzrI
 t6pUc16Qe+OFaKrGQJAwP9PgqTKtorPI+St8ysAIQJIvVN655rBWjTWoiYC36RfM/ioLj+u+2wT
 Hczi0/3WzivPONfeGYXUPjARnfT30QgNy6dHxtMSKS2Alii5f1z5r/d5ZcfZaminrZOI73FGkGt
 GxOkgMeCkeId2LDCfTxR9kY+YmFibwnWce1lcn3AqNwBH24XjR+p3T7/AjUVliFu1pRcDJKcTNe
 HeR7vLzDXq14Rlmnj4kOeMhPE7RuaVKjuq72ZpZ+nDfmsuDRtgu3PEGX8tezCQdphg2POmAJ0D1
 Ykv55zamPK6Z8jd/llrMkX6TT7g1SEzDDxcSJJELBVHxQnMpsegaCzzU5KxtH/YEP//DhW85WZ9
 HJRsc8t7HdDIWjg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 93D69517441
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286859-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,suse.de:email,queasysnail.net:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

While lock_sock is held, incoming TCP segments land on
sk->sk_backlog rather than sk->sk_receive_queue.
tls_rx_rec_wait() inspects only sk_receive_queue, so backlog
data remains invisible. For non-blocking callers (read_sock,
and recvmsg or splice_read with MSG_DONTWAIT) this causes a
spurious -EAGAIN. For blocking callers it forces an
unnecessary sleep/wakeup cycle.

Flush the backlog inside tls_rx_rec_wait() before checking
sk_receive_queue so the strparser can parse newly-arrived
segments immediately. On the next loop iteration
tls_read_flush_backlog() may redundantly flush, but this
path is cold and the cost is negligible.

Backlog processing can run tcp_reset(), which calls
tcp_done_with_error() to set sk->sk_err = ECONNRESET and then
tcp_done() to set sk->sk_shutdown = SHUTDOWN_MASK. The pre-existing
top-of-loop sk_err check already ran before the flush, so the
freshly-set error would be masked by the next-line sk_shutdown test
returning 0 (EOF). Re-check sk_err immediately before the sk_shutdown
test so a connection abort surfaces as -ECONNRESET rather than a clean
EOF.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 88d07199d5aa..2b7093d27eb6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1382,6 +1382,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (ret < 0)
 			return ret;
 
+		if (sk_flush_backlog(sk))
+			released = true;
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			/* Defer notification to the exit point; this thread
 			 * will consume the record directly.
@@ -1391,6 +1393,13 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 				break;
 		}
 
+		/* sk_flush_backlog() can run tcp_reset(), which sets
+		 * sk_err and then sk_shutdown via tcp_done(). Recheck
+		 * sk_err here so a connection abort surfaces as the
+		 * actual error rather than a clean EOF.
+		 */
+		if (sk->sk_err)
+			return sock_error(sk);
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			return 0;
 

-- 
2.54.0


