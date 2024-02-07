Return-Path: <netdev+bounces-69664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1584C1CC
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8BD1C24823
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874419457;
	Wed,  7 Feb 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvZrZx1N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D83DDC1
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268747; cv=none; b=WydlZVP/Ib5lgEu9vK4NeEUzAvK8S9NEzY5GLZVEM+1FdxEPf/yQlWBxypvNj/trGlj2XU9PnhaOhHmNIQNbmjuGPjWXmyLQjIOnZn/qOcZSOyd5m8cO6iCwq3mE1iEIzQ1GnJtsX3UxFaITVB+9n+WtTcNW0Fja+Bx2E1wfsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268747; c=relaxed/simple;
	bh=lF/mdvlKkje8no8Kd9f9/LDGoqiM26kXocIW3GBIqA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP05N1ZPtfLHuAqZurjpbfwNcNi0KXDLhLZaEfvf89X19UVrLmHPg7bNk5FQ2EBLY1iQloHxEDewXLoJh/EpbkA/Vn1CKaaTbq+yVNeuNNsUgkDC6qctC2Y0hGtkHPMoSZJnpYEFlwiSDmnQFPWBEr6OYPBagwig0vXgrL+N2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvZrZx1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72790C433A6;
	Wed,  7 Feb 2024 01:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268746;
	bh=lF/mdvlKkje8no8Kd9f9/LDGoqiM26kXocIW3GBIqA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvZrZx1NkjzdneXULJhchkovfsmN/0ZBepMSnZaWCbbgx9jtHA5/8R6EQRNW0EJZD
	 w5nJnCZ4AV+OtedOxPHZzOu2sjeQ0jNSS/SYRnOga+UISaywgEhPBzVWr39MJdtzvt
	 pgMfU6Ua8RFwHbPR5E785dNYVgKHeqiSqZey3NG1DC/NZFJuCM47rF/bsJuR6wBGow
	 O8KmI+ZK42a8u5h9Gcw6RWJk4gf6uV9waPyvGKRQPD4RVed03gIqaU6gb7I1h+7/EL
	 EUefNyb43VUITEd6DH/ugumxqdzVj+YJ6HJMpYKiwNz5rHwBjf9tEdDCRA38s5iNbz
	 WTBxnFVQYAsng==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	vakul.garg@nxp.com,
	davejwatson@fb.com
Subject: [PATCH net 4/7] net: tls: handle backlogging of crypto requests
Date: Tue,  6 Feb 2024 17:18:21 -0800
Message-ID: <20240207011824.2609030-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011824.2609030-1-kuba@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
 -EBUSY instead of -EINPROGRESS in valid situations. For example, when
the cryptd queue for AESNI is full (easy to trigger with an
artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
to the backlog but still processed. In that case, the async callback
will also be called twice: first with err == -EINPROGRESS, which it
seems we can just ignore, then with err == 0.

Compared to Sabrina's original patch this version uses the new
tls_*crypt_async_wait() helpers and converts the EBUSY to
EINPROGRESS to avoid having to modify all the error handling
paths. The handling is identical.

Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
CC: vakul.garg@nxp.com
CC: davejwatson@fb.com
---
 net/tls/tls_sw.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9374a61cef00..63bef5666e36 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -196,6 +196,17 @@ static void tls_decrypt_done(void *data, int err)
 	struct sock *sk;
 	int aead_size;
 
+	/* If requests get too backlogged crypto API returns -EBUSY and calls
+	 * ->complete(-EINPROGRESS) immediately followed by ->complete(0)
+	 * to make waiting for backlog to flush with crypto_wait_req() easier.
+	 * First wait converts -EBUSY -> -EINPROGRESS, and the second one
+	 * -EINPROGRESS -> 0.
+	 * We have a single struct crypto_async_request per direction, this
+	 * scheme doesn't help us, so just ignore the first ->complete().
+	 */
+	if (err == -EINPROGRESS)
+		return;
+
 	aead_size = sizeof(*aead_req) + crypto_aead_reqsize(aead);
 	aead_size = ALIGN(aead_size, __alignof__(*dctx));
 	dctx = (void *)((u8 *)aead_req + aead_size);
@@ -269,6 +280,10 @@ static int tls_do_decryption(struct sock *sk,
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
+	if (ret == -EBUSY) {
+		ret = tls_decrypt_async_wait(ctx);
+		ret = ret ?: -EINPROGRESS;
+	}
 	if (ret == -EINPROGRESS) {
 		if (darg->async)
 			return 0;
@@ -449,6 +464,9 @@ static void tls_encrypt_done(void *data, int err)
 	struct sk_msg *msg_en;
 	struct sock *sk;
 
+	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
+		return;
+
 	msg_en = &rec->msg_encrypted;
 
 	sk = rec->sk;
@@ -553,6 +571,10 @@ static int tls_do_encryption(struct sock *sk,
 	atomic_inc(&ctx->encrypt_pending);
 
 	rc = crypto_aead_encrypt(aead_req);
+	if (rc == -EBUSY) {
+		rc = tls_encrypt_async_wait(ctx);
+		rc = rc ?: -EINPROGRESS;
+	}
 	if (!rc || rc != -EINPROGRESS) {
 		atomic_dec(&ctx->encrypt_pending);
 		sge->offset -= prot->prepend_size;
-- 
2.43.0


