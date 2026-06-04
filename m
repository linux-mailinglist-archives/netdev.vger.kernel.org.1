Return-Path: <netdev+bounces-295379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDhfCLm6IWrhMgEAu9opvQ
	(envelope-from <netdev+bounces-295379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:49:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E366642668
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:49:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="UmYe/REf";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295379-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295379-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ADD03028345
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E84D2ED2;
	Thu,  4 Jun 2026 17:48:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753534CA28E;
	Thu,  4 Jun 2026 17:48:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595324; cv=none; b=utnSxKV8kqjZ8+azIMV7TDVKVkpNq5c6zdEY/BDNn+TMVWG5zPQrFD9lI8i6s07tVxfCllKMxTGKPCLm8Z0lwPq6n+V1Hk/648SCUj2v2ngkxgdSfhYbP9YgPl3dOefRW3InlzF7oIKvM6hE9dWRWaZH0xHpa5x2W6trsOru0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595324; c=relaxed/simple;
	bh=W6IoCm8k2YaoSXfyNu0dP+g0UIHQ2jLkMzviiCEez0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5PkCfgdESokHobaVxg8UpyEMWPB5dQ+cxiwqZifJ8MuRNn840yB1GeqwA4heOoKapOlgyeMtrNE3XTJniVk0x1o1A+GcpR2k6B5X7F8t+JuJ3nuWUxmr514CnN5m5uEBmUQt/dL/bCUmIWNejZQVw4DYNkeZtqUG46GR4mamtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmYe/REf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7DF1F00893;
	Thu,  4 Jun 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595323;
	bh=G5lTzb6PZ26RdyvIpz6234N+JQ+TFr7aT8ilR9r4Fl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UmYe/REf01mob26PjgH2lKm68ATT38aE6vz/KSUWspeZ0vPkcY3JF7Rmtcgh6vqT/
	 xxyT773pf7scCgvlxiSz/4O0oqXTSAA1bBgXxfc89czszOPUVoqKB5Nm4HyJEANaYD
	 iCM7bDOIRVMjGCW9pCiNdfTbba2i3vOkbXWnrO4a0wZV0R++wmmnj69FLt3Ynu7gg4
	 l0a6nYgmwr2MLXY4jJOpqXZ2tlXXMT/WdDuvFzW6IqTWL42m+IPTwHvQ3sJeBT/d4K
	 yp8pCpOlWoKoUSMqZFIhkOrDyEmmIJuVUHzOeeOBEvBX6PfSFVZosmnCDSqxi0HAYc
	 WZBC+cln1Dv/w==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:48:29 -0400
Subject: [PATCH net-next v12 6/6] tls: Flush backlog before waiting for a
 new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-tls-read-sock-v12-6-b114efa6e3e2@oracle.com>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
In-Reply-To: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=/6ObuvjYz1Emi6QHBj5HPN2W7LFHmm8C+UVAlpiAMoc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbp3Y/Ykq8EMp9nytTLZW/pTPLaWr1hZ8foEX
 LLL3qyApPOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiG6dwAKCRAzarMzb2Z/
 l7rlD/48H8HGOpauwPdIZ8fkXzCOkP3h2sSPvZgvVM7H1lF4A9oxY49oSHZYmdD+BRTmgNLHDYq
 +he737mH8tg4RQ8bYqrfAI1MKIZl6CZ033yfophWbpTaxhKkpfWDJjUjamCC+PQ4A1J0UPuBxmh
 2RbS6BsRE0lMUpm5FDI7OX0ZUSZ9xDkte+hOoycOB7lGKB+3nJ2y2TvYbtOyv+f9uZKXXfKkKGZ
 ++TqsRPSlZlzzYKgs0983l5SltMcixv8br3M2WdALSUULbW7wb4VBFwzeNesR1M8qzwMx6KJfpZ
 KabmFBmni1CeMZRuNLJXvowTEg//rQbwVIk7vXzY0Mt6YGNHCHaiVECATCE3u9OLz+HSUxJl/Dt
 mJp+9ucynaWNIMbyw1FGuK9Rvml4LPrH/aKAD9XIdGsI0BAK69Ad+mlafajrqoZsy27MnPW7ttX
 oGqG6hST+Cfu6UuqXHq6NlYFvSDr4KDUDtFQAxZX6g4wqcbp2taUBDrPelppdet8RLtL3s1yNqu
 EsdaERucpv0sOh/xDiCLHqSowVtTEbK2d4uR27VTYiLeiBvmiL9KMN+43bp3odStqCFbuKfBI62
 1v6tAlu3MMy/DYW5ooOB7n2U6SigqdHkxywwTWWh7hajhIZ2hBfqf7C1xra5ABpUGEZm/hPPDe8
 mYjgoDvVAxa+keg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295379-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@suse.de,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E366642668

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

Commit f508262ae9f2 ("tls: Preserve sk_err across recvmsg() when
data has been copied") gave the top-of-loop sk_err check a
has_copied split. The recheck applies the same handling: when the
caller has already copied bytes, sk_err is reported but preserved
so the error surfaces on the next call; otherwise sock_error()
consumes it so the error is reported exactly once.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/netdev/ahgHgQ84RCc8uYrG@krikkit/
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index df4cdf11f784..5a4300c943a1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1400,6 +1400,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (ret < 0)
 			return ret;
 
+		if (sk_flush_backlog(sk))
+			released = true;
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			/* Defer notification to the exit point; this thread
 			 * will consume the record directly.
@@ -1409,6 +1411,16 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 				break;
 		}
 
+		/* sk_flush_backlog() can run tcp_reset(), which sets
+		 * sk_err and then sk_shutdown via tcp_done(). Recheck
+		 * sk_err here so a connection abort surfaces as the
+		 * actual error rather than a clean EOF.
+		 */
+		if (sk->sk_err) {
+			if (has_copied)
+				return -READ_ONCE(sk->sk_err);
+			return sock_error(sk);
+		}
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			return 0;
 

-- 
2.54.0


