Return-Path: <netdev+bounces-291721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kExODDmuFWpkXwcAu9opvQ
	(envelope-from <netdev+bounces-291721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC95D77D6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41FFA30545BC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7E3FFACC;
	Tue, 26 May 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4SimwEQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AA3B9935;
	Tue, 26 May 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805313; cv=none; b=lt+AUpeWm2Ehj4R1q61OO9icZu0Uhg5vh3WixTzRkSdycS6UVIrtD1ZCeKkZrf2EyEaOROTEn3jGNVT9AG8DEY5FxMUn7xnr5DEKLdV/FSuQB+36lKQrEjnCCEV+m0WZ8YddpIRcciN4FvLeDzp3k4yt24b15gvMKu4RSSDfH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805313; c=relaxed/simple;
	bh=bJBvFSETAmcibl94dTlrTXjKW5v0n2O+KzbpigXeY5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lx/D7jeF0e2LquHNAcoPmVH4vUkYgeJ5DjwQ5RRJKKTjxEHD4Q/pv2gXxP4laQ+5Ab9GNBy80DBa79QhiNHKICY6iDTLHP9qNwOyU85BYP/Ub9Vtjpb/+GgXkpSIF23ZEPF7fcf/sbZTsbKPfORU0pvikhuRy7qRNymhLJwTCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4SimwEQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B641F000E9;
	Tue, 26 May 2026 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805312;
	bh=/n+O0HrGPs2DOd8qXS7aiY78YnANgbnJKKU17Wg5dPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E4SimwEQUDPkzYmOg2yvFclVDFbPCrf9z4wE9okXPBc21tegMA2auoNuuxNQpLGIa
	 /+mt/sruNNBYHy8Oh5UCZCKNP6st5BQPO3/Uhcm2M81TCZfeBjFJefhpdDcGGvPdvx
	 Ly6wx408yqIICrirlhkoftxLO04+6DUEAb7t4eln3x24zXZn2G5y4y1Xt2z4W/WvTd
	 7yykYEDuLQPNj71aFpb9j0734eQrMWJcVUss46wySKqivTHTikGe9F4+hjpYBZyarr
	 vkS/SvMNNOHQuQXkYLm2bL0NeyZ3aGU7GU+r3dS2Eab+EaSfrAyRgSX3FudnX0xO8q
	 vx+VQkzZxj1vw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 10:21:36 -0400
Subject: [PATCH net-next v11 6/6] tls: Flush backlog before waiting for a
 new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tls-read-sock-v11-6-244fe1dc4abd@oracle.com>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
In-Reply-To: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2BeWll1Lr7BR/iIOswWFoK5P8HGg4mAShFZOaOcihS4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFax5tzejqeMfcAsJZ9ZZgm0JnxnS2r+jvpp02
 XwwIReVBgqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWseQAKCRAzarMzb2Z/
 l4VJD/9zdi5GvXTK5QB5YU2LZBzi0XPIcqrPBbySHjDqtmchAw5GwRlRzgE2zhHKfLxd4IOH2wl
 83uChSTIQ+ILRrebORMDUHY7U28lKOZBrBGm4gN0evZ/1q/HOM/MyZ9SZj7ha7gmNebpI4cZDNo
 1QLXXNzn5BMEqc7JS/GXrKixQ9cOBRB0pMeDP1UNe4gXd0INs6u+QC35029XsspYPuwAK4TrZs+
 rCKfUKM4FpSZcGQeN4bvlLYVqY3op1MP0AnSjhcaFJXLYtrhy/FmlHOchPdyMhN5D9t/o5zMSNV
 FLGiPnqArLaAVLAXA5ZJsggO8LmeApeJGXB1PO/o5xoAqVdb6Nfm0RoluxC3xCt+xvITkoT7Gx+
 fdjopbhFaFrenchdGD/dtJJ5euxliVUDsCuqNtPxe7NtW1RNjG4b0w9p8+Hvsb2qr4Ftc4MdbZ9
 tlAmoRax+PiZHYIc3/zxT6yi2qSpxiPsibjt+iRmvzgX6tZeQB2ggGQK2CpDo2k4icUj5iePpup
 Uc66qyn+WbhZEwp51k5g30ivWSLCwK4rLsUGdCo3tz8FOWWC8lGS2lRZf4PMBruMKNTeb5ZSau1
 QLnhQaFcL8QmzxUkDjREPrF6UQufI6fl4uHvb1CwCwxlj1axuF4aH9gVq4ADeXHM2EZxeHeGVYY
 iGti6pU5ps7K3rw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291721-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,queasysnail.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: 98DC95D77D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index df4cdf11f784..d2f31623511a 100644
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
@@ -1409,6 +1411,13 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 				break;
 		}
 
+		/* sk_flush_backlog() can run tcp_reset(), which sets
+		 * sk_err and then sk_shutdown via tcp_done(). Recheck
+		 * sk_err here so a connection abort surfaces as the
+		 * actual error rather than a clean EOF.
+		 */
+		if (sk->sk_err)
+			return -READ_ONCE(sk->sk_err);
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			return 0;
 

-- 
2.54.0


