Return-Path: <netdev+bounces-282513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA9dAdt88ml2rwEAu9opvQ
	(envelope-from <netdev+bounces-282513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:49:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B570249AB68
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9678302F43B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0218315D53;
	Wed, 29 Apr 2026 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXI4D2+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E32749D6;
	Wed, 29 Apr 2026 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499308; cv=none; b=KohgTtjjYLYtE4yCVGrANNyNx1Mgr0HGd/WzkjD5jVQqHAPaR8dz3qPbkS5CSugdF9cSkOTguvoSXGriX7Hyo4+7Crkx1ffnqlOj6BqyQ72nbPgkc49VcBgFwkGeWC/qEV8ioBq+oZKLVfcTnSR1863adoR6l0qxqj91elVWLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499308; c=relaxed/simple;
	bh=K3xdO/kgOqIE1mhISVtQeKuEWHiIfcP9hRjIw787Kzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3+A48OKOxTbFZx66EWECBGwfmvIbmg1vSQH2vWreSGY/8HYDPlkHId0HWu9YSmUQXRErX8biz+ib2lm5dePGgLvDSCEyLTPvmEZh65GcaZEYwieh9S2SvXXYVPSpMGCzqu2u7RU2IUZpL/dYBQpAYQFcJlc1ju5Y8202Zw2kT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXI4D2+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C744EC2BCB4;
	Wed, 29 Apr 2026 21:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777499308;
	bh=K3xdO/kgOqIE1mhISVtQeKuEWHiIfcP9hRjIw787Kzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JXI4D2+ND5L6GVQlQxCEWXorBvEiyfHXC4hS9i2RQUYw9wtLH+bmQ9jjSLd5RKzAa
	 UYtQ4LxhiDa2vR1dL0Dyekh5DwpbomSp5UsK/sOW+Q9tg0wJu3YoYF5DmtANqPwakT
	 Ls2zTzvfWbaqRWziaFs/FHoDR5pcsBpZ4ZeXN+2uk2pztbvfCQpr6NA+mF1zFADW1a
	 GoDUXimA2GIL8mMLCByMAzET3EuBRux7f/i8XjIG9ZuhBomidANDwKAHY20nqFsTdF
	 1QM7bA4+FwEJRFyrTkgNto84xy0143Gbq4CMYMOl2A1uIAg7WU7EZNNyZ5ej+DxOp9
	 LAynWEOgGnu0w==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 17:48:12 -0400
Subject: [PATCH net-next v9 5/5] tls: Flush backlog before waiting for a
 new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-tls-read-sock-v9-5-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
In-Reply-To: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=suBWFXmLddudAaKNeZeInfibTXDoWcvDMLZDzodb/LI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8nymAulfatNFKXDCEPLolubMkSmuuJXWlcEED
 A4Wuess0x+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJ8pgAKCRAzarMzb2Z/
 l2rtEACpdgmmJnkUebKmUisCNQ0Wg4+YNGJt87Yp3mijxNjSUozswCYQjTAQBF7/82zKNrNsrXG
 +9k65+ySSGjYZ2pgbwWHYr+PjgK6QZI+xs613hJ7PIhYOiFmFz9vNcRRQ5g4C76Dm6/F6W+/wFI
 ZLpBNNfFh+re+oq8aw/SAvvQsUGEiOUyn1qr9GuyjRNIf2IJd2BKTNmKySsqIVX1U+ttNEHj8rJ
 Yi6TRJje0MfdrOzBG8LtVxRfE3936cllHN/Gauw8V0FF6ejSjAJZuh1YcjrXRSuBVr1GFObZyFv
 Y5e6tDknONL99mhc03hyStTvsFtOAjSEsdAKHGNNqSSMDxyeOEbz+B5MTmsOgVtxKMJ5h1b55EV
 CL4Bvf4YEn7xk/9h1ajW4KfRhcPSEGsUMHKgYmqW6qj9OFw1cAAIpMqICRLkvgkj8qrw5s7IakH
 knQ1jzgIyq7Yo5XmveOwsbRsn7+jwMJW+HJ6kShcwwElb0VrcxxzAQlq171vpIzhDL7iE62yQRh
 VUhbeQEOj2aCG5o+sWvdWb4zHal2wimLV8MbKyDl0CYpAuTCIHNXFGWaVwzR0qZXpjSatTaQaG2
 /Wtmie0xY3SFPSp5wOE7GMt0LMUyEYXL/vQCbKSYMCtwZXah6sbjxLiKL6GbpbYnqCJk0nwortt
 gA+4Ry+ofUuNn/g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: B570249AB68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282513-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,queasysnail.net:email,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

Backlog processing can run tcp_reset(), which sets both
sk->sk_err = ECONNRESET and (via tcp_done()) sk->sk_shutdown
= SHUTDOWN_MASK. The pre-existing top-of-loop sk_err check
already ran before the flush, so without further care the
freshly-set error would be masked by the next-line
sk_shutdown test returning 0 (EOF). Re-check sk_err
immediately before the sk_shutdown test so a connection
abort surfaces as -ECONNRESET rather than a clean EOF.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index cbb068266bab..b888aaa505c0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1382,6 +1382,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (ret < 0)
 			return ret;
 
+		if (sk_flush_backlog(sk))
+			released = true;
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			/* Defer notification to the exit point;
 			 * this thread will consume the record
@@ -1392,6 +1394,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 				break;
 		}
 
+		if (sk->sk_err)
+			return sock_error(sk);
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			return 0;
 

-- 
2.53.0


