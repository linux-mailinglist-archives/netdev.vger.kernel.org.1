Return-Path: <netdev+bounces-281882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLSAL+298GnSYAEAu9opvQ
	(envelope-from <netdev+bounces-281882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:02:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A908C4867E7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F08E31CFDA5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404C46AEF5;
	Tue, 28 Apr 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9ZJkbAX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34F43D4ED;
	Tue, 28 Apr 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383070; cv=none; b=gOU7QXXIXIre7u7gsrkTf0gtes4ZuNcZNSmg42vsl6uT1S2kPpcLSm/xr0NpPC6KOW0Vz74Gw/0+IaIqOb27FkDrLpBdPqZG3QvOcTzigskrzGRueJWCmc6NhNZpkQGcsPgnfumBro4zSKZc+2Udl5z2NGfSxQQFXw7LVhGt+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383070; c=relaxed/simple;
	bh=yFAPH/hU13t48/K9xiijm7ek8d+q80xIy9bfc9ArHnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YyoOk+qw/D8umPOY/E6p5aYOLn7oUMnGFKDpFCuMg6ej6cw1d871hOwB88RQVPo+Vkb4tCsylEdW9IfV6J2IJmF+5ZuBuYiSh5zdb9cqYOXi/0RZrO/focUX1x/i6ptGu52bikZkYVkiPGEoEl9OpQpQV5IrXlOJ3369+/DFOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9ZJkbAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5AFC32782;
	Tue, 28 Apr 2026 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383069;
	bh=yFAPH/hU13t48/K9xiijm7ek8d+q80xIy9bfc9ArHnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H9ZJkbAXQ/Xse6TuHkwJwqk97scVkVpkTRFpfmmni/Yud9rXsjxIvxlKYs9LAbdHY
	 pOiEEgxw41bkgAvgznbb7uIQakhqlbguvTJCTtHAcX14Y+wcGVYp9l3F3Au7sTWe6p
	 LT29MpXlkKhiPZPPF4xgGgLM4pdpPMNdJGxyvLMX8fn8Bor/ytk0mQxpkV5tK6JBlC
	 zTmKGGFUT500xZreQnEvAglmFhuOkz8zHPbdqiYlQo5bBaOAXQFBmx3iSSIEQQW7cp
	 Apg2uurTsR1m8Gn+b5Frcjono99KX5wgu4MquNX/4QlbRCiXcab5SLdasFBF8i1Dvi
	 EoFzgOugVQxUA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 28 Apr 2026 09:30:47 -0400
Subject: [PATCH net-next v8 2/5] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tls-read-sock-v8-2-85f96c7df24c@oracle.com>
References: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
In-Reply-To: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=jZJUQZ0cfEoFAACukrXtBWgvXBuhz4v+roXy4XtSUZk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8Labe1cMk/zgGdQeIBeAQXa4y1vG1iClEWG4E
 yJHWex9306JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafC2mwAKCRAzarMzb2Z/
 l8GwEACplLP4axvpuHeigtelE7nUE/RYLn5njt5Fkf278nAk50+RrltoFMqHXjuY/FPEjkHuYQs
 zv0xmTi79Jcnk+fp6fRdEOyvnhEhYJyhmWVrPpzs+RG0ql7UAMIu7y12Pmi4bT7qsL/Nsxj4Tiy
 BcEK3r3ckhPyhDNccVB4/2ijukeLrX0QivjuAYzt391MyD90r6109mgh0Cje1SIwuaPy3EmsgmC
 aiQgI43m4TRiV8Wu+IbPZIRWHztUYUgalaMKVjkROBDKAQGusyTzzbo3uOmoOF018EslRDvC6gA
 iwx543pflE/XrLl4vFTadw/oSUZLrpZg296Pmn2uR8u6zCK0JRDfXwTxmT4sqKePGEPM/RNrctq
 OvZRGvaKup/iooeQ/ULVD6u0tj0ni6ZGL0Qyq+u1f2OQ69fzJT1YgcU9RsRZJ7A1q6MK6Zo6FvR
 V3nrZPLNLcr4gOjzqXyxQACCr9UzKrdMkILimwTwn2zMIQarT1AZLegNfw9lNZnTjjW9RN0QICY
 UQxFTC+DnKZdUTjZ69AmyMHTPU6Dm9KTEYc+1E53KhSTdcdMalrX3LCQW4pbC/j7S+CVq74xi8k
 5VVmJemLlMNlvktf8pv4dry1lGtp0d9q34CIt5VCyYlp2FrrhvHQsNa186y+ib9o16NhHvc40o4
 AXzQHQjbBmx5Kqw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: A908C4867E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281882-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,wdc.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

Per ISO/IEC 9899:2011 section 6.2.4p2, a pointer value becomes
indeterminate when the object it points to reaches the end of its
lifetime; Annex J.2 classifies the use of such a value as undefined
behavior. In tls_sw_read_sock(), consume_skb(skb) in the
fully-consumed path frees the skb, but the "do { } while (skb)"
loop condition then evaluates that freed pointer. Although the
value is never dereferenced -- the loop either continues and
overwrites skb, or exits -- any future change that adds a
dereference between consume_skb() and the loop condition would
produce a silent use-after-free.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 244ac8ed4b01..71fc72a1b878 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2366,7 +2366,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2415,10 +2415,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 				goto read_sock_requeue;
 		} else {
 			consume_skb(skb);
+			skb = NULL;
 			if (!desc->count)
-				skb = NULL;
+				break;
 		}
-	} while (skb);
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);

-- 
2.53.0


