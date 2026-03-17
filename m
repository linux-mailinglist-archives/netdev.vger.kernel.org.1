Return-Path: <netdev+bounces-268641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNDuJXNvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:12:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A32ACBF3
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F273051C9C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B73EB7E8;
	Tue, 17 Mar 2026 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te0wT+0Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EF3EB7E3;
	Tue, 17 Mar 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759885; cv=none; b=YZpx1OJSljUAXvk+9g4opttaRrVmmmJeWmXyVDXu/ENRZqh5D9z5iL+MOBpGGvKH/vsP0/EzfxTygMd2aqXS/mNp6GNIS9R3KmqicqXlO7HklW2PHJ/z+cYHEgemfHSJOuD3s0nycIdLN5nbR9fCNGkrm5xJTg/ou1/DNodRlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759885; c=relaxed/simple;
	bh=3S69d08kIMLUiUwIHtizMYl6Fptrc9J+Hmv5pj0GAb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EyeCYabZlibCEtTeLG7yAvd2VsPk/25ztaWx4zMA5/IwvGmGivbbaOybMUU/1EiQ5kVrJLopuVB+4iOyrxZnLQyPl2rQEWR5xLkh6rc2yAu+H2a8UVwdP8kobndSlOrpGEz/+Q4nm5Yp2Tgoq6t0BSqPsIi68rLWUZMHbFp26Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te0wT+0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E83DC2BCAF;
	Tue, 17 Mar 2026 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759884;
	bh=3S69d08kIMLUiUwIHtizMYl6Fptrc9J+Hmv5pj0GAb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Te0wT+0YwRi4heRKEeAE1FWnGCZGGB6C/8umepmHZBTlQC/7N7uFHmNnOkfbQ1s6z
	 8n2zOu4QYNg5QJpmFUxAAOCIwwuhkKtaPtLMK5ClpGOzmhsUwgSNt7OKdOKQRR5dxb
	 5lAQNYmA39oxVR3t9Ya9bXjgVY3NmFy/LlpOJCMI6Hw/EkaTQYW0VLQlkz0xBw6Sac
	 xdchY+KFCDxGpDbjt/dtMrpX+ja+CJi7rFRW39iuA5dl/oqQfT9Jpm5T6zluN7wURL
	 +/i4fXkHbgNQKyLaOfES0rAfFIlIGzMJHkRuTNhaGEe/sBg2Y5v6kQ/CbBNb8ZYwOV
	 PN6EW0IW1uBWQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 17 Mar 2026 11:04:14 -0400
Subject: [PATCH PATCH net-next v4 1/8] tls: Factor
 tls_decrypt_async_drain() from recvmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tls-read-sock-v4-1-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
In-Reply-To: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2o+P5ruE9Ny+yHWDKORmfHpUJcqEi9eQK3/IcUKsq0E=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpuW2KTnp0HAY0kckXnWCKkmw+Lf4Cyn7KHFU4q
 yT8b/OnZVCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabltigAKCRAzarMzb2Z/
 l1NtD/9QMPKdIrLeuBkgXInCsOu3aUcN1DvzbZahuE8BzGH0iUXmOWl3PaFXeQaIiHExpPQs1tS
 hwkVnQX4A0EW91CN7HWyNm4bvl2nVUsVLCP58p28Pnl7deU+D1aXTZViOBUbpVlCj9BCeogHOwG
 Kb6DCqYfkqCLrnBOMKAaph+RyQY6+nZikQiIZSkM3fYkmk6vkBPjFw1zp8TXR+sv+JNEaqB3zwI
 06A0QP9woCr3gfh5aD7aJiK6ZJ5uNy8+JWc2ep8eCaDCFLMXOX5Juy/HXBcc7nL8TVwjqlYCpSD
 rPZkfmGwNOlMKh2oRjPL/goENpk5XJAnIXn18UkukpzBqefDsegVbdCtsMfcvcPaNooAebRWwir
 WqBt5bdi8WLHdukzHoZfAK2ckoOylxe4uy9fGSA46xidGs4p90P/aa+tdSazpyj1nj9DDuLkJj3
 +2YQ4TQ3jYya0TVXOdmR1ePyzdqlE3ZsyD+/kP8PyLaweSizDP1nXfwV1LJj6AzNEKCfxfzDeF1
 ELZzRfLV+6EMg5F3gJCkCyl9gEPkSOAoXa0G0zAfzqGVte2KtO7rjTVoMsvUfuBdF/cBwtSD0CS
 EW2ZuONCkNbloF3QYeo0HbeUcboUG5YuuB9rdxGSeFwza2/1yGYmFI2vqeahnUvG69aId8myEkZ
 Xc+kwLkZR5OmndQ==
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
	TAGGED_FROM(0.00)[bounces-268641-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,wdc.com:email,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 454A32ACBF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The recvmsg path pairs tls_decrypt_async_wait() with
__skb_queue_purge(&ctx->async_hold). Bundling the two into
tls_decrypt_async_drain() gives later patches a single call
for async teardown.

The purge is kept separate from tls_decrypt_async_wait()
because other callers (the -EBUSY fallback in
tls_do_decryption and the tls_strp_msg_hold error path)
need to synchronize without discarding held skbs that
are still awaiting delivery.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a656ce2357589672bcef24343fef0aa83606cf41..09ccfe82af1a6c38978327e941de34818b5da7a8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -249,6 +249,18 @@ static int tls_decrypt_async_wait(struct tls_sw_context_rx *ctx)
 	return ctx->async_wait.err;
 }
 
+/* Collect all pending async AEAD completions and release the
+ * skbs held for them.  Returns the crypto error if any
+ * operation failed, zero otherwise.
+ */
+static int tls_decrypt_async_drain(struct tls_sw_context_rx *ctx)
+{
+	int ret = tls_decrypt_async_wait(ctx);
+
+	__skb_queue_purge(&ctx->async_hold);
+	return ret;
+}
+
 static int tls_do_decryption(struct sock *sk,
 			     struct scatterlist *sgin,
 			     struct scatterlist *sgout,
@@ -2222,9 +2234,8 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (async) {
 		int ret;
 
-		/* Wait for all previously submitted records to be decrypted */
-		ret = tls_decrypt_async_wait(ctx);
-		__skb_queue_purge(&ctx->async_hold);
+		/* Drain all pending async decryptions and their held skbs */
+		ret = tls_decrypt_async_drain(ctx);
 
 		if (ret) {
 			if (err >= 0 || err == -EINPROGRESS)

-- 
2.53.0


