Return-Path: <netdev+bounces-282510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHpDH7N88ml2rwEAu9opvQ
	(envelope-from <netdev+bounces-282510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:48:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8749AB4A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41DA7300DCD6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFFE391826;
	Wed, 29 Apr 2026 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D12VRAwI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14493890FC;
	Wed, 29 Apr 2026 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499306; cv=none; b=P37/ny7iKkjx1kV6Rn9aKZUMvDBIqcmc5m5wlUhFl7mZWCVg62Cj6FKAlf00QtWZu1i07j83M3m8MwgS7cxce08a0+EDpc2GKmDrqYmDbNnX/7MefU+TzuCNENcxu51JHvR1RouhyQYcCbhsLM+ONIjAXCRCnf7seK/FSsl0m8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499306; c=relaxed/simple;
	bh=F+sfapjHi4nbkJbK1f+vjGOtKSlMFa2zLHZ3Ff6faSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr97joKCTO9F3YMhEbrnrI7Jf2+01ickAK3VFEl95y9iHpGch9KvQgbU72pGfqKamHZd4XRiN7DB14P69weFgNxJLfj1rrNlfTg3bGj/u9AgAxn7lveF4nNyJ2zMHKPVT1nY/I1+q5I+zekHqY0vk6C8LwMP7bOO8kHGqMsq5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D12VRAwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93A9C2BCB3;
	Wed, 29 Apr 2026 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777499305;
	bh=F+sfapjHi4nbkJbK1f+vjGOtKSlMFa2zLHZ3Ff6faSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D12VRAwIqNHmso6Ojz6Pdi32RNgi7huRdi16hNpS0bYdYFgYEF4QehTcPktyoyciT
	 ozlo+6r/sb+8iMArIy/cmrnAMuaeoTS2nyROhNZwYyW9fa5q3zDq1QJTwMXEDgpWBW
	 QYxIrf8x92Q7wNg/ri//GAiWBPLAAod8jPkHPJ2z7de4Ocm4S/97WspYge/YtBx6yK
	 cowTEJgbT+bNmoSg19DZYrumSmrzO0s4oJDSWiG5yQDzZCi6Dtpn+RK8ERm62G5weg
	 YIz1QmdcF1EPlaate/Q7Sr+0AV1mpXH6tCdM26DaJSkoF21RoomadhwOhuSAcwhY0t
	 xiRId6ywGQ5GQ==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 17:48:09 -0400
Subject: [PATCH net-next v9 2/5] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-tls-read-sock-v9-2-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
In-Reply-To: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=HP5/mTnsVDVa8AI8kv+oUX2mTc0KKa2aWYCNHygPqRQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8nymrcXyUVf1vZXUTtj3XtF8Xha61EemM6maa
 sLF/baFny2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJ8pgAKCRAzarMzb2Z/
 l4UsEACRpWn9GlLg5gwYbWqgCnS9zoeOdCyUPlDV0B/Nag9PFg6wLHwkJe75348Q5u956Eh3oYH
 cXPAVU5kQ1RsvV43Ie0QFpPJ/nzcXuoBN8Zaa8JxBTfXGG1/5JoCoyu/TYWAFFcHLLQAOPZ2Eze
 xWHkSRHL+omDNNJbd5F+rezF/z1P/4W8QrfZ8SRu60aZxiJvFlGSOH6F2yvk/6ss0Awdm6neLKm
 zkgo5NtCR5xtXyhu8kNkU6idpf+3DYdCd2VSVgXZMWyR1TPIXmOlm+gOKlzWcnXngDDCaPtfH7e
 thjiGDBxCd+87XSW2OjE+lVPmJYUwsDxqLTlShJbFG9d4DG4Ogg4GbyiBNg7H6RHMr1drCgHRjD
 FQUqbl70Ry8Dn45ZuNclcUiYPqXE6WRkZC1JL5LdxdWGu3YDU/7xv3+E3pRDIu7JlV9ilSq4DYX
 460rWFyDGetMhPnFuVJn24AQG5g3FuN5y5iEEp84fCNCHAjZQw6ddgFhbuHOcTT4msGLRe8qaRw
 31N06fMLYEEwXYQtUedRbNLtq1WmtqOIatOmLYISYE0rwE36cwAb1/elTMLLRQ74pxtMTCpcQwJ
 ktwcPoBDSJvlwmZmu91CYLXcbA+QMAwNuuyr5Iy6J7zcNmfobAcs7ZeEZhvTSo2OqRGzUl4ymr2
 AId6bZVmp/+cycA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 26A8749AB4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282510-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,queasysnail.net:email,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

Two related defects in the receive loop of tls_sw_read_sock()
share a single fix.

Per ISO/IEC 9899:2011 section 6.2.4p2, a pointer value becomes
indeterminate when the object it points to reaches the end of
its lifetime; Annex J.2 classifies the use of such a value as
undefined behavior. consume_skb(skb) in the fully-consumed path
frees the skb, but the "do { } while (skb)" loop condition then
evaluates that freed pointer. Although the value is never
dereferenced -- the loop either continues and overwrites skb,
or exits -- any future change that adds a dereference between
consume_skb() and the loop condition would produce a silent
use-after-free.

Separately, when read_actor() consumes only part of a record
(used < rxm->full_len) but desc->count is still non-zero, the
existing code updates rxm in place and falls through to the
next loop iteration. The next iteration then unconditionally
overwrites skb without freeing or requeuing the partially
consumed buffer, leaking the skb and silently dropping stream
data.

A read_actor returning fewer bytes than offered is in every
case a backpressure signal; the only correct response is to
requeue and exit. Replace the do/while with an explicit
for(;;), requeue unconditionally on partial consume, and break
on exhausted desc->count after a full consume.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 244ac8ed4b01..c58d3b0b0a8a 100644
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
@@ -2411,14 +2411,13 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		if (used < rxm->full_len) {
 			rxm->offset += used;
 			rxm->full_len -= used;
-			if (!desc->count)
-				goto read_sock_requeue;
-		} else {
-			consume_skb(skb);
-			if (!desc->count)
-				skb = NULL;
+			goto read_sock_requeue;
 		}
-	} while (skb);
+		consume_skb(skb);
+		skb = NULL;
+		if (!desc->count)
+			break;
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);

-- 
2.53.0


