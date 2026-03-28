Return-Path: <netdev+bounces-272777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOf3Iivxx2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:18:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E5C34ED6A
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8783303D713
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E4347FDE;
	Sat, 28 Mar 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCUL+pF9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AFF346FA6;
	Sat, 28 Mar 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711043; cv=none; b=T4i/RWiFZdasNvvLzMbBukBRKStiLNEN7fj474WnHsdWL0H8uVIz9xo9jr0X1+u1kSUIh/+tQP+v12ZhvBwLpAWC/tGVF7MZGASyUv7hNZd2XZ2wdb5LTSc4+6emBR/r+KjwzIjByFHF+BJ/ziR6DMLi2LyLZZg9DzO6Uaq0vJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711043; c=relaxed/simple;
	bh=ADsowbatqb/2SsLJ3HQ7L93bqVYsEjgbcxdwOPOvHEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lx+qA/e5uyj4tB4irEl0BdCEMiEUoIMfF96P0JdkX2JnpHQAURnd9T32gJuOcF54frJUR2lnpYGlZ8qf0AGBHhRtoivJ2UJEiiArY7/N3AhguhxMV6u3sBagtRp3GtBUoC5PnHqQw+lz2TsGhIXLO8m6xEdP1wOYPWl+TMexMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCUL+pF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0E7C2BC9E;
	Sat, 28 Mar 2026 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774711043;
	bh=ADsowbatqb/2SsLJ3HQ7L93bqVYsEjgbcxdwOPOvHEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KCUL+pF9/C16qhOiSX4fEbraQ5GS1OhAk8ksJGEpC/tYs7F4POt+wIN+SP5emSJ8h
	 xvWJoLmLysUBVM3lLppbJzSaA60un9enQ0gkOmaHQ+E2vFLq1i0oJfSkV7iok9v3X+
	 JGfDG6jw01SssYrZEPe1m9hblLPkula+fhZ+pKG2+2dlIFhmKY/f17aJa4OF/4aGpy
	 4zVzvqGzP4nO+bZ61e3KhQ1LZrM2PMduHREVOPUE04oWgrSm05ejRbt6/JCRYj8jwU
	 Fy8OciOOVWgXX7DeyHLFcM3s+P+NMvPQKql8t4xV74b+gSQPWskFup6DKfBpe9+2Tx
	 ZDjSG7Tvc8DzQ==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 28 Mar 2026 11:17:09 -0400
Subject: [PATCH net-next v7 2/5] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-tls-read-sock-v7-2-15678415dfc1@oracle.com>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
In-Reply-To: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=C6Eyt3fovBhxmJhtF8FQJ86E45z3fVSEaLjEsfKU3NA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpx/EAtizi39CbTdp8GY4W3nhi97ybzHDPDxlCq
 GTqtj6XNKaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacfxAAAKCRAzarMzb2Z/
 l4gtD/45O/fqvAYau4qY+2dosFPrKxJjmk7yDZXePo2GOX31EV3InpD0uKuBSfcD+u54bzdf5V1
 VZBczS9roUhhZdVkWQ51Y8qISPN46jNOxeVabGUFDZCeTcpe6kPv/g4+mBwErLqvub+CC2XBd6h
 zWhS5cxqfc1iUaF1ottNTpkLW7SU5bWdlKTx4a0LXC9CI5kqRdXrwQHZy83LNWmEaUcqj6hrRkQ
 2NA7VsM3bcdeZdb2IBzZL6K6o7nRJhaXu4oiwScXzrUccvAqdH/yW+aksT1lvfoTFpP5/9Yefnd
 jIZ3ghUEiAFF/61UqPdj3XJ8DDMkXVBE1EzRJ/SiAOQiZ5tJEW90wQH4PvmGICMw2jrmlplyQ0O
 VFfsyvUsJqLtvHr34+SjgWPeydmrAP2mhz0y0XrPEX4AncAbteKIkxldY6pVfGkTVauknmp+nqK
 GAmQkJ5JZx7NDNhnGPHyNE9q2lF/16E1qFqHUoO0O2YJnKM2ChgnZTjwTE7iTwn5gYyrGeaz8lk
 ylYo+MKtG76d3D6FarcnJjDz4VgX3d71es6RjKFAQH3/ra1V8163iITzWiNjKp1eGgXAnkI/PzJ
 i9Fr7higa5ING/p1cKkLmmB2F/z5L18iw2llIZC8iTAy6LpGSUayd/gwhbJbH923s/CVrIsg449
 zxbLvhapZXcRC/g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272777-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,suse.de:email]
X-Rspamd-Queue-Id: 07E5C34ED6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5626fdd4ea0a..5fdd43a55f1e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2356,7 +2356,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2405,10 +2405,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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


