Return-Path: <netdev+bounces-261731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNraAbA6oWlrrQQAu9opvQ
	(envelope-from <netdev+bounces-261731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:33:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3C1B3451
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9EFC303800B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A333261A;
	Fri, 27 Feb 2026 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9poLRPq"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECE355F36
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173992; cv=none; b=HMlEMrsbTCAmzaMeSd4colVGYXc3kEaFsFScQNFrCk2KEgDp1qHZgVhue8QXklHAFzwhRnEk8Ip115kPqtI+oknZQ6AUHuDYIh9Rz4ymNWFo1STUPc1YL/15fhB8dlZIc46DYrmqQvZV+jZUXZBM2oXXvNAgUiiZqq/xZbd6ru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173992; c=relaxed/simple;
	bh=wZ5N7uv8KPTHpoGDDc4HKy8x/Zs2klO0Z9yzwZp9k5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPjPzg6kMfU2eSycxzBV+W4D7A4/RlMErhpH76x2WeRd6AIDQ4EZ4T7uvS5Ak8dkozgtlQry2q8f2zJ8zi7IV4kEuTCUx79zSjcYJsDDd+FTLNUAWqLo6FM90CaWbqQMEzjt0qVh2Z4VZRoSmPgNqn6gS70CwXxBJK6+Gg+97Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t9poLRPq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772173979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nTFptO84ZPVQV80rRXeEqqT9kuYpp3EHXOHWrz8HsgI=;
	b=t9poLRPqjCm97eRBzapRqA4QedwjE+k+pyg74y9xtfsy6E4rg4fRyPznUXdvOCjvoM9fcU
	GGTQ0fvhjn9YRiVp6Kj7+puXAixUdadmr8PXnTISpH/drM5ovbLdc2/WEHeRuS7OX2Rkfo
	q1RQ8P3UIjpdr95RswlxGFcAX8Zi9Cc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] tls: fix hung task in tx_work_handler by using non-blocking sends
Date: Fri, 27 Feb 2026 14:32:31 +0800
Message-ID: <20260227063231.168520-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,syzkaller.appspotmail.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,nxp.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-261731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,ca1345cca66556f3d79b];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CB3C1B3451
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

tx_work_handler calls tls_tx_records with flags=-1, which preserves
each record's original tx_flags but results in tcp_sendmsg_locked
using an infinite send timeout. When the peer is unresponsive and the
send buffer is full, tcp_sendmsg_locked blocks indefinitely in
sk_stream_wait_memory. This causes tls_sk_proto_close to hang in
cancel_delayed_work_sync waiting for tx_work_handler to finish,
leading to a hung task:

  INFO: task ...: blocked for more than ... seconds.
  Call Trace:
    cancel_delayed_work_sync
    tls_sw_cancel_work_tx
    tls_sk_proto_close

A workqueue handler should never block indefinitely. Fix this by
introducing __tls_tx_records() with an extra_flags parameter that
gets OR'd into each record's tx_flags. tx_work_handler uses this to
pass MSG_DONTWAIT so tcp_sendmsg_locked returns -EAGAIN immediately
when the send buffer is full, without overwriting the original
per-record flags (MSG_MORE, MSG_NOSIGNAL, etc.). On -EAGAIN, the
existing reschedule mechanism retries after a short delay.

Also consolidate the two identical reschedule paths (lock contention
and -EAGAIN) into one.

Reported-by: syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com
Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/tls/tls_sw.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..c9d3d44581da 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -404,7 +404,7 @@ static void tls_free_open_rec(struct sock *sk)
 	}
 }
 
-int tls_tx_records(struct sock *sk, int flags)
+static int __tls_tx_records(struct sock *sk, int flags, int extra_flags)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
@@ -417,9 +417,9 @@ int tls_tx_records(struct sock *sk, int flags)
 				       struct tls_rec, list);
 
 		if (flags == -1)
-			tx_flags = rec->tx_flags;
+			tx_flags = rec->tx_flags | extra_flags;
 		else
-			tx_flags = flags;
+			tx_flags = flags | extra_flags;
 
 		rc = tls_push_partial_record(sk, tls_ctx, tx_flags);
 		if (rc)
@@ -463,6 +463,11 @@ int tls_tx_records(struct sock *sk, int flags)
 	return rc;
 }
 
+int tls_tx_records(struct sock *sk, int flags)
+{
+	return __tls_tx_records(sk, flags, 0);
+}
+
 static void tls_encrypt_done(void *data, int err)
 {
 	struct tls_sw_context_tx *ctx;
@@ -2629,6 +2634,7 @@ static void tx_work_handler(struct work_struct *work)
 	struct sock *sk = tx_work->sk;
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx;
+	int rc;
 
 	if (unlikely(!tls_ctx))
 		return;
@@ -2642,16 +2648,21 @@ static void tx_work_handler(struct work_struct *work)
 
 	if (mutex_trylock(&tls_ctx->tx_lock)) {
 		lock_sock(sk);
-		tls_tx_records(sk, -1);
+		rc = __tls_tx_records(sk, -1, MSG_DONTWAIT);
 		release_sock(sk);
 		mutex_unlock(&tls_ctx->tx_lock);
-	} else if (!test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
-		/* Someone is holding the tx_lock, they will likely run Tx
-		 * and cancel the work on their way out of the lock section.
-		 * Schedule a long delay just in case.
-		 */
-		schedule_delayed_work(&ctx->tx_work.work, msecs_to_jiffies(10));
+		if (rc != -EAGAIN)
+			return;
 	}
+
+	/* Someone is holding the tx_lock, they will likely run Tx
+	 * and cancel the work on their way out of the lock section.
+	 * Schedule a long delay just in case.
+	 * Also reschedule on -EAGAIN when the send buffer is full
+	 * to avoid blocking the workqueue indefinitely.
+	 */
+	if (!test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask))
+		schedule_delayed_work(&ctx->tx_work.work, msecs_to_jiffies(10));
 }
 
 static bool tls_is_tx_ready(struct tls_sw_context_tx *ctx)
-- 
2.43.0


