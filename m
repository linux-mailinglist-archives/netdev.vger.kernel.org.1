Return-Path: <netdev+bounces-264547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC2bOSbyqWnhIQEAu9opvQ
	(envelope-from <netdev+bounces-264547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:14:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73B2186FA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C6363027940
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051F3537E5;
	Thu,  5 Mar 2026 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT55LRGH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE66351C3C;
	Thu,  5 Mar 2026 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745247; cv=none; b=TGx4eZW7XMnvSpX00rjpiRhAgvMxH3QS3PRVBcMcQKktcPZXX9KD4Umii8Zg4TcjhVDBGmqrGs25l4imZQOWemKF0lb9S7r65m6ZusbYRXUX1QHPRv6leccLqGBoW7GQ7A78TLYjGX9Xxr8FIbVljdd8uGNN8ff5Np5WmPalij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745247; c=relaxed/simple;
	bh=ok5eaUhmp1SUTfc5L+jy3xy+akjx359vVIjnX7ZVwRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPt640QFbyF+km0982aPBAcTDUI3Swf+GvKwhFHA6O9TlTUdV8+Wsbq6v1cV0q3bHEHGZpM2rMkjeW/374NA4pCMn0leSDRTYE2WPeDN66Pm0HOyK28UarMwiIz3nIEPfFl85EDZ/FXxREHVhCUNvdiN39ed6mPzSDey3f6pH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT55LRGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCE4C19422;
	Thu,  5 Mar 2026 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772745246;
	bh=ok5eaUhmp1SUTfc5L+jy3xy+akjx359vVIjnX7ZVwRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nT55LRGHPUY52XmznYCn5E7Yr284CDan4opTKlJ6Qi5NTqjKh2i7B/Ph5xewG+PcN
	 3/hpnnsPeqT7jfbb8G6CcjBPVHg+TFLmIRtQWWlkEmYYnTAT4Ue/wJcMfX6Fhd5MPK
	 W48JbJ9he/NMNxexJ6l/db7LJiMJlD/Vrk5PQJ+uPRRXvn/UePFqs7ZCoOjCv+yrCn
	 HsiS6VM9xxxV1I+8I7gbxtobeGvNnKixkTdVtEbxckgUnWSQuKztlgw85y6juoVcN4
	 duFxtvgtH8v1G6evXoTHieSxv9liKhu74qjnkgHdmukSVTW6emM/K5ZN3uLnf9/s+w
	 iWBDeuFv6Ft6A==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: <netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v1 1/6] tls: Fix dangling skb pointer in tls_sw_read_sock()
Date: Thu,  5 Mar 2026 16:13:57 -0500
Message-ID: <20260305211402.39408-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305211402.39408-1-cel@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D73B2186FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264547-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Evaluating a dangling pointer is undefined behavior under the C
standard. In tls_sw_read_sock(), consume_skb(skb) in the fully-
consumed path frees the skb, but the "do { } while (skb)" loop
condition then evaluates that freed pointer. Although the value is
never dereferenced -- the loop either continues and overwrites skb,
or exits -- any future change that adds a dereference between
consume_skb() and the loop condition would produce a silent
use-after-free.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a656ce235758..108d417dcfb7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2355,7 +2355,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2406,10 +2406,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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


