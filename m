Return-Path: <netdev+bounces-286854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBGHHbRlAmqZsQEAu9opvQ
	(envelope-from <netdev+bounces-286854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:26:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5128517448
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AEDF30356E4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D1362153;
	Mon, 11 May 2026 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GenZXgs8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD135F169;
	Mon, 11 May 2026 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541972; cv=none; b=SXfAAlHw77dIHJur/LjjP63+f0Q2vR5vM5RDu/F/DxUJRemNcQxEyKdK41JWE/aFSGv6L5dsjZ4pZujFxfCE5+aZqvy0socRQNlB7qyDe6qPPO7r4dL/K7zTOVFz6mGdjcj457spZIZkaU3lYYUxpW10Dwk6vt3XyNFgMAZdysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541972; c=relaxed/simple;
	bh=IKCey0FB+FZJNHH80fQGHGx9moVR2eEWisXTJPqqxWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGNy8As9teJ6DaSjmyG589TTg3z0tsqK2k5nGbrbZpqho7ILBurF5YoA96k8SNa+dYOO1ZcS9zoCHGQY0Jcymt3Ufe6t4HqYY0nkZfQxXeBlNF1cTYIkLbMSf12cmeFN/H6ix3PBlmY7O8Nx1jjC/TwZarTn6cQ6+OmLg18O4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GenZXgs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B73C2BCFB;
	Mon, 11 May 2026 23:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541972;
	bh=IKCey0FB+FZJNHH80fQGHGx9moVR2eEWisXTJPqqxWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GenZXgs8/8cXxXa8nYf4fbhlQe4sVjYC7AhEE9qPbh7MGxwoVxuYVdXNEvpk6KHyI
	 V016Xj7+kAgOE2OzRraJZ0VruLLI+ejhqFtRRyEhy9phawQxOzdwDKYtIJCz18HV2x
	 qVBFKTn94TUDK2S2rvDstVI6sYT9N9o0MBVYRMmenunnIqloH764V/O4qaoHhF5xA5
	 UYMzJ78QRoDBC9egT+9kmyVjniHyn6KrV/FAruQxAIjnFZOoyWyFxcviiuTkjglUgH
	 04fV6DmjbvUiaCsVgaybWcRJlBs0eIwCORUloFRvM6fmt/V+R9QWjKwPDOaw43Maq7
	 p6jtTzakwoFRQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 11 May 2026 19:25:52 -0400
Subject: [PATCH net-next v10 1/7] tls: Move decrypt-failure abort into
 tls_rx_one_record()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tls-read-sock-v10-1-279fc5015f0e@oracle.com>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
In-Reply-To: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Ya6GWQXR83RZFi9jRlW/vpxihLEkSSp2k9Xzbn+YQbY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqAmWRb1J5qC1xzHHNl1GWk+070ZF1Ywt5T5eUn
 gzRnmZySm+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagJlkQAKCRAzarMzb2Z/
 l4MvD/92mRd5yIdHFMV59LYR3uqXaVgdOG4stf9zb8FAeKSNQdubRlJncWWfattBA3XdRhHVzJJ
 inYK1BS76bewFusxbSQerivTQrk9WHGqXV2dus37Ivy37TIAFl0V4xRK4s/c4xVOg5PUA0kRSov
 t8TsKabu353yz69BdMvACq5rdeKmTyVa50JMpLHVbCoA5eT1oJqbJx2mwdcS4eeqvyv6yR+8/hY
 BJgvqFdKM+tag1wycSe8cA3R8rEnqhFS+9qMAAnCHJOR/5WBiPuv1b7rLSMUkmW869zii8UtCOR
 Q+rnj/UJaZQRooaUMskdPy//7KzmbbRc3TSaMWa3NY5OELNpF3/i8tl0UscvwvvUfTH1+mvFFIW
 UilrxT3mpfDF4A5UFLbpRqu/S/faBD0u2Dp5nbG86R6hsSLIXdkLYQN5dD2k/+cpS5IBY1DOtZI
 OZuhauD2VbSiL2aUdMBFIgwc8Hz1s7XFb7Ake6YKIIdduL1kArUHUvHEHykQVMIzAKt97JJUvVi
 V94/qiMpEKVHeeVCdU3gjoJne43Me3VKCGsl7sln/4DHz9yXZUckl2fvHyDozMyM7wweKh7EFB5
 GqTculJ/L98wc3v68qHOWBGclxso9xfDieWtK2MGsdAgpT/18H/4T35ZdpxedthUhuGvWm901W3
 z0OhBLDiZT7PzCA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: E5128517448
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286854-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Three receive paths -- recvmsg, read_sock, and splice_read --
each follow tls_rx_one_record() with the same tls_err_abort()
call. Consolidate the abort into tls_rx_one_record() so the
decrypt-and-abort sequence lives in one place.

A tls_check_pending_rekey() failure after successful
decryption no longer triggers tls_err_abort(). That path
fires only when skb_copy_bits() fails on a valid skb,
which is not a realistic scenario.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2590e855f6a5..f607ccccb232 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1809,6 +1809,9 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	return 0;
 }
 
+/* On decrypt failure the connection is aborted (sk_err set) before
+ * returning a negative errno.
+ */
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
 {
@@ -1820,8 +1823,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	err = tls_decrypt_device(sk, msg, tls_ctx, darg);
 	if (!err)
 		err = tls_decrypt_sw(sk, tls_ctx, msg, darg);
-	if (err < 0)
+	if (err < 0) {
+		tls_err_abort(sk, -EBADMSG);
 		return err;
+	}
 
 	rxm = strp_msg(darg->skb);
 	rxm->offset += prot->prepend_size;
@@ -2132,10 +2137,8 @@ int tls_sw_recvmsg(struct sock *sk,
 			darg.async = false;
 
 		err = tls_rx_one_record(sk, msg, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto recv_end;
-		}
 
 		async |= darg.async;
 
@@ -2294,10 +2297,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto splice_read_end;
-		}
 
 		tls_rx_rec_done(ctx);
 		skb = darg.skb;
@@ -2380,10 +2381,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 			err = tls_rx_one_record(sk, NULL, &darg);
-			if (err < 0) {
-				tls_err_abort(sk, -EBADMSG);
+			if (err < 0)
 				goto read_sock_end;
-			}
 
 			released = tls_read_flush_backlog(sk, prot, INT_MAX,
 							  0, decrypted,

-- 
2.54.0


