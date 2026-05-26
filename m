Return-Path: <netdev+bounces-291716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJd2LuWuFWr2XwcAu9opvQ
	(envelope-from <netdev+bounces-291716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B155D79A3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A03E300B2B5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238C3FF1A3;
	Tue, 26 May 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZPnecl/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA413FD14D;
	Tue, 26 May 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805308; cv=none; b=ZTtHkPcfOZTnC1v+qoVs338kAmAcxj/Sm9WV9pARbDLDtxo0F7JdAN+yEA3//X44fa7GsU4rtibRfKoMoUUjPPoJE6bmJDZS7fX0O4IdOnAYBSyjzoYtEzNrbPte5J/u0frMFIOw449lXJ3BpEWBkq+WBOOAc0aau7SXBMGci28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805308; c=relaxed/simple;
	bh=blYY6F4XVzT0cZ+JdFv5hdFF3f+fjhHUrEn6M6hahHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSmQbX8je7kI7UoB2Y4sLA0Xd08JoZPjPJFaGuprIj5LN5k9Ej6JsyY6fHPsDCMjhRXYYXVN8qeetQe9yJVBi++gnCgbprXFQ6t+OrapiSkMzoxxUr9nqVLMEoXhnaTxSwohpJKFUp6Dp0xz5bR18iKPquHQ7QLiZ8Iao1fuFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZPnecl/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7828F1F00A3A;
	Tue, 26 May 2026 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805307;
	bh=mvvrnidiJlzIyUspiiL1z3imu0wGJ2WcJkqP6BQe5mw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AZPnecl/UVj/UVFvDTqIdWIA3MMoe4597Ml+vjPRd3ucp70iJx04q5zvUA3cjIWbM
	 Yku8Y35gDvATNaZpkk/hTebpmq6PiR+CaZdzjuHDRpoNIQeuA5NKLnOoWbbnzWpDOc
	 3FAn5tCGw6K4eUTAEtkQt2qRxEw+9lzldntktLjpje03mkuuKey/gih/bA3KTQ6tro
	 Ix8bzp4WUxv9k4+iJCETSdiP7JMLh92tzXXWVkdzpTWBqJrUZMVj497cB41S69r9PU
	 UW8zDdLoyTSDtx3CGldXnKe0Gx7GIerk5/tv2EOpvvb/kT9mSfWjzAELRtJdsBohzx
	 hNAunQOTmRQ6Q==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 10:21:31 -0400
Subject: [PATCH net-next v11 1/6] tls: Avoid evaluating freed skb in
 tls_sw_read_sock() loop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tls-read-sock-v11-1-244fe1dc4abd@oracle.com>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
In-Reply-To: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Sagi Grimberg <sagi@grimberg.me>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=/rO6uLNSYVMg6gXKxqsd2H/iD25IE03u0ySmlcbbWRk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFax4HUhZfjxOtgn2Hof/d44EllZ75meGGpGiW
 YEyFfZYpJ2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWseAAKCRAzarMzb2Z/
 l9P0EAC5CE9ymnHAhWwr+vQJePZoV7diwckoETJFOHO223OTMGcz78BqMk6STPK7n9cNHt2T8D/
 s5LhL4NloZi6R9If2xCR5D8Rouh9vQI3sSRfGFrsrlXgynZHwlcZoFXFsOFyLPixkvEjnJRPmwT
 EtqDjBoocBtyOpoOJNJLJgc6Wg51uPGqFr50zP32ZenNV4BORBHivMre/jtQrw3pPnn7jgft9OF
 9JQ0n8VGdyauV8Py5emYfJQveYyutPMTAEc5VTqRzF7Iw1CsEOjxYaZyWkoYovl9NQwUt+wlf4d
 3OP1P5t+re8uV0xkBfL7M+9PRGsfsug2dxlZeVB6y83ugUBsxlPqf+ktWwI6szNkYbcEikO7TIw
 EzAnKvJMPimuSY/YGAm3QyYeJVzgSQL6+vFg9jnGbVSHZM/ZiP/QSOpcURIL3DIZ/6VjABXOLXa
 ym2/RMil8HatGvmm++IKMYMOH6XJRdYTYLAu+LeGs95oSTtzOyTx6yhGpK5NAdBprddJJAyX9Z6
 q26uGOFSb0t6qqDWQYr5JsihRRh7qAG4Lty2TrqA0TIy5lmR5m1fje3QcTQpEjWGKERf7dFHAZe
 LswJU2LgRd6yw3OlQx12J9sTepVsutC3zNA8v1n0eZnSM5wcXNi/tpS4VZUVQ4ptW1Oktc8GvO5
 XbWbKuyyVdH4Ctw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291716-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:mid,oracle.com:email,grimberg.me:email]
X-Rspamd-Queue-Id: C5B155D79A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

tls_sw_read_sock() ends its receive loop with while (skb), but
the else branch in the body calls consume_skb(skb) before the
predicate is re-evaluated. A pointer becomes indeterminate when
the object it points to reaches end-of-lifetime (C2011 6.2.4p2),
and using an indeterminate value is undefined behavior (Annex
J.2). The pointer is not dereferenced today -- the predicate
either exits the loop or skb is overwritten at the top of the
next iteration -- but any future change that adds a dereference
between consume_skb() and the predicate would silently introduce
a use-after-free.

Replace the do/while form with an explicit for(;;) loop so
termination happens through a break statement rather than
predicate evaluation of a freed pointer.

Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..8e4e57721335 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2383,7 +2383,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2435,9 +2435,9 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			consume_skb(skb);
 			if (!desc->count)
-				skb = NULL;
+				break;
 		}
-	} while (skb);
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);

-- 
2.54.0


