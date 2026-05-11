Return-Path: <netdev+bounces-286860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFG6Hg5mAmqhsQEAu9opvQ
	(envelope-from <netdev+bounces-286860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:28:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DCC517481
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E69530530D7
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14168363086;
	Mon, 11 May 2026 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7UuhPUf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513B362138;
	Mon, 11 May 2026 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541978; cv=none; b=uYo6IbcVEg3A1/ebKbOdzShtLxFQTuiEX8240oziQ+QpNqRpDHmyVvponLWy+qDNwwWPBU+bxImkUzS22eBWGozUIAtcoZEXteXLfTaaPE7gIjNG9hvEEKkSjoSiEGE9XWvUEnIt6AF3xHVh4+vALKdnwvGUBrfrYcKDcvY21Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541978; c=relaxed/simple;
	bh=PQdRkk70Wejb9baE8WCU4V8UK+OIFo/qm9nepHvQepQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0WSWUSkijfj45rHwll8whSl6rzlAkxo+GP8apXQZwHM4wyivW/zWvTSwNdfSLjIvQxYAp3XTpAB3XCuu+aQXxHseHm46wU5p71T8YGzPSR1OOQDydGADVKyjpNmN18XJjiMrDt5N9vNUnh5Qgxwtn5u+Zfr3ejEVIaFsGc/VWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7UuhPUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C045C2BCB0;
	Mon, 11 May 2026 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541977;
	bh=PQdRkk70Wejb9baE8WCU4V8UK+OIFo/qm9nepHvQepQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q7UuhPUfLkbkWIhUDppaO1w4gAKUWHFVHiIkaFdKh1ws57DfrfN+O6hyHi+4kIBy9
	 +U19HV9VF6FziAjKJp/1OEtS6vM08MvqRH2s23RP6ztRnQv7NTekVgrRwfFtVIchsw
	 Wv84W49SaX/D5JjBZvlc8kO3qIUHiQWfMJ6FtRETJLtZKeQJqoy9acaGCYNfSdOMra
	 7Kv3Urx3pnd+wrpQSGnkF5+X9J19Dnhtsk/lFpHhOSgVVY0eDqlC6Ba4WRuBEBpYky
	 TpIlZHF+58o+nyjeAbc7b3mBezI6O4VgDUVfjAyPLYvJvfhL+kpyN71UpD+gMOGh/W
	 P3A/mBtEzIcgQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 11 May 2026 19:25:58 -0400
Subject: [PATCH net-next v10 7/7] tls: Preserve sk_err across recvmsg()
 when data has been copied
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tls-read-sock-v10-7-279fc5015f0e@oracle.com>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
In-Reply-To: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4348;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=cV7PVf2ylqU3vAE8V3E9ZoC4VxgJd96VlTBqfZ4ID7I=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqAmWSzADZfbYyMvaAeHh/d/DXg4f6k+srM/sXd
 bAmVeXsg1WJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagJlkgAKCRAzarMzb2Z/
 l1EHEAChrUotitTl7Wq/CwuMxRKRvteOIg2+etXfKcFAt+TVMX3pQNXIC1cTLUPnzKeJOn1X8kU
 8ikdOJseTai9MKFIgRIOQBIrE1f9VPb0BM3v6CSL5WA0PWaPkCvt6gQVu8v0X3o2wKPAfurMMBZ
 2TCWmVY4EqXZMNgQXjmbNggdmmU9qrim1g/GD3GUfMSfBK/gG3fmvXCwxwC9lTG/4lpIqzuDdMW
 ftVYdESVwSjY6MXHPD7zZR6EJJLCKQrZaSkN0Aidmp6ED3SeuHvSNAmvUVakbUAwbRQXY/2yTd9
 rVHdc2vzUBT0w9Yhy2bBEbjOLvixSopr5OLOaGa4n82h2l5N+VSjRyaimVQYAgYjOa6wETq9AnW
 hth5YrbiBm4PBhZM4qmC/lnzfwm8yb6xTNHuznROSMDxs++1ZeS8vBWDqYy1GggoeylCyzycArS
 8DChf9cE6gwNXb7rqHbWmspWOCunI+iczF06DPLlkyR1oaib/Si/wDGws2EOAc8S0AA/f6/PR9M
 N6Xc298S4jI0L94V9AS4iHZ+lXvKz39bJOZ/qlqMSYAul39JZ40/5pupdUN74dxmD1iYChkruYl
 +l8O4BHAOfh0iw/xrxq2ldXMhBOn7fxbx3xaV+FyGnx5fF1HStIpucID+MzJ23+HQ7Wqf33XzHo
 b971V1ThUr1JxVQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: D5DCC517481
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-286860-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Both sk_err checks in tls_rx_rec_wait() consume the error via
sock_error(), which clears sk_err atomically. When the caller
(tls_sw_recvmsg, tls_sw_splice_read, or tls_sw_read_sock) already
has bytes copied to userspace, it returns those bytes and discards
the error from this call. sk_err is now zero on the socket, so the
next read syscall observes only RCV_SHUTDOWN and reports a clean
EOF instead of the actual error (typically -ECONNRESET).

The race was reachable before this series via tls_read_flush_backlog()
when its periodic sk_flush_backlog() triggered tcp_reset() in the
middle of a multi-record read. The earlier patch in this series that
flushes the backlog inside tls_rx_rec_wait() widens the window: the
flush now runs on every iteration of every wait, not only when the
periodic threshold fires.

Have tls_rx_rec_wait() report sk_err without clearing it, using
READ_ONCE() to keep the read explicit. Each caller's return path
consumes sk_err only when no data is being returned and the err
about to surface matches the pending sk_err. This mirrors the
tcp_recvmsg() preserve-and-surface pattern, and also handles
tls_rx_one_record()'s decrypt-abort path: it raises sk_err to
EBADMSG via tls_err_abort() before returning a different errno
(-EFAULT from tls_setup_from_iter() on zero-copy receive, -ENOMEM
from decrypt setup). The gate keeps the actual error on this read
and lets the EBADMSG surface on the next, matching pre-series
behavior.

Fixes: c46b01839f7a ("tls: rx: periodically flush socket backlog")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2b7093d27eb6..6a0ac2ccde56 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1376,8 +1376,14 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (!sk_psock_queue_empty(psock))
 			return 0;
 
+		/* Report sk_err without clearing it. The caller may
+		 * discard the error return from this function in favor
+		 * of bytes already copied; leaving sk_err set ensures
+		 * the next read syscall surfaces the error instead of
+		 * a spurious EOF.
+		 */
 		if (sk->sk_err)
-			return sock_error(sk);
+			return -READ_ONCE(sk->sk_err);
 
 		if (ret < 0)
 			return ret;
@@ -1399,7 +1405,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		 * actual error rather than a clean EOF.
 		 */
 		if (sk->sk_err)
-			return sock_error(sk);
+			return -READ_ONCE(sk->sk_err);
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			return 0;
 
@@ -1430,6 +1436,18 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	return 1;
 }
 
+/* Clear sk_err only when it matches the err about to be returned.
+ * tls_rx_one_record() can raise sk_err to EBADMSG via tls_err_abort()
+ * while returning a different errno; preserving sk_err in that case
+ * lets the EBADMSG surface on the next read.
+ */
+static int tls_sw_consume_matching_sk_err(struct sock *sk, int err)
+{
+	if (err < 0 && -err == READ_ONCE(sk->sk_err))
+		return sock_error(sk);
+	return err;
+}
+
 static int tls_setup_from_iter(struct iov_iter *from,
 			       int length, int *pages_used,
 			       struct scatterlist *to,
@@ -2285,7 +2303,9 @@ int tls_sw_recvmsg(struct sock *sk,
 	tls_rx_reader_unlock(sk, ctx);
 	if (psock)
 		sk_psock_put(sk, psock);
-	return copied ? : err;
+	if (copied)
+		return copied;
+	return tls_sw_consume_matching_sk_err(sk, err);
 }
 
 ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
@@ -2350,7 +2370,9 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 
 splice_read_end:
 	tls_rx_reader_unlock(sk, ctx);
-	return copied ? : err;
+	if (copied)
+		return copied;
+	return tls_sw_consume_matching_sk_err(sk, err);
 
 splice_requeue:
 	__skb_queue_head(&ctx->rx_list, skb);
@@ -2444,7 +2466,9 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);
-	return copied ? : err;
+	if (copied)
+		return copied;
+	return tls_sw_consume_matching_sk_err(sk, err);
 
 read_sock_requeue:
 	__skb_queue_head(&ctx->rx_list, skb);

-- 
2.54.0


