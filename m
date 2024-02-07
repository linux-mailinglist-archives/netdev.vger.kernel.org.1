Return-Path: <netdev+bounces-69665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392184C1CD
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C812283C2E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89EEDF57;
	Wed,  7 Feb 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwMcOu3b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC6DDD5
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268747; cv=none; b=R19ytxxUJPvOCfdyxGaqfl8A90N8Q3+f3CAx/vbXnfkPaCaV3qCJLYKvC7pGP37pXKR9eWUCmO+2ZiN2CYB8DnDUBmFFlLf7s3pu52EgKHUAlqZX5i5AOwqR6wUgYd5UHJBg8ajMULKojcXK5nRFEWpeI0S9EqThGuDXvU8cz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268747; c=relaxed/simple;
	bh=mncymzkQD0sxqMMAFIiUe9EF8JYqlrDLeGl45urf5/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZh9oodebK2e0C90YlTVm3+QB1Y6Xx4H4tH40SG4ayg1mosHfkra+pUlKEy3fBpVlcfcY+JHzRkYEigJLaACY4R/DXWg91S04sZcMlr3H/7hRk11wsSTb4zg/bkPl85Rm6wGrgFWHLphCFNVQ2Knyahp5C4Wo9X5pbByjnH5ypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwMcOu3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B35C43390;
	Wed,  7 Feb 2024 01:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268747;
	bh=mncymzkQD0sxqMMAFIiUe9EF8JYqlrDLeGl45urf5/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwMcOu3bdH4CLkkGYoSt7DOuAzsoCuG9S4E+LJL0cOYKz4jKjE+N2FjWrABfOZgbF
	 lD2oo9dEUBM6I5PiUrLqOKGYbw1lKcB1D3Z6Zn3Oj0DNfRVwv5G7Z+oPPGD47wOrHN
	 5PEsl1fXNAOVjC1+Nbz6xhC9INSDM86KioWXlCWkEgBEDNZjqEmz70hHMAxo8hIbdl
	 anBwxG3z9uNNMOOS6+fe8hZ/jjkgNj83+0jTmvT/14xPZ4px6rjG18XHaMRL3/Cc0J
	 klVeBRLn9LlPb9Vb1qBZYKL8jDKVun+7zAJBXPryq2NorNGHRV3SyVKoCsIIivmXlZ
	 9FNfTqazyPR0Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com
Subject: [PATCH net 5/7] net: tls: fix use-after-free with partial reads and async decrypt
Date: Tue,  6 Feb 2024 17:18:22 -0800
Message-ID: <20240207011824.2609030-6-kuba@kernel.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

tls_decrypt_sg doesn't take a reference on the pages from clear_skb,
so the put_page() in tls_decrypt_done releases them, and we trigger
a use-after-free in process_rx_list when we try to read from the
partially-read skb.

Fixes: fd31f3996af2 ("tls: rx: decrypt into a fresh skb")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This is pretty much Sabrina's patch just addressing my own
feedback, so I'm keeping her as the author.
---
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
---
 net/tls/tls_sw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 63bef5666e36..a6eff21ade23 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -63,6 +63,7 @@ struct tls_decrypt_ctx {
 	u8 iv[TLS_MAX_IV_SIZE];
 	u8 aad[TLS_MAX_AAD_SIZE];
 	u8 tail;
+	bool free_sgout;
 	struct scatterlist sg[];
 };
 
@@ -187,7 +188,6 @@ static void tls_decrypt_done(void *data, int err)
 	struct aead_request *aead_req = data;
 	struct crypto_aead *aead = crypto_aead_reqtfm(aead_req);
 	struct scatterlist *sgout = aead_req->dst;
-	struct scatterlist *sgin = aead_req->src;
 	struct tls_sw_context_rx *ctx;
 	struct tls_decrypt_ctx *dctx;
 	struct tls_context *tls_ctx;
@@ -224,7 +224,7 @@ static void tls_decrypt_done(void *data, int err)
 	}
 
 	/* Free the destination pages if skb was not decrypted inplace */
-	if (sgout != sgin) {
+	if (dctx->free_sgout) {
 		/* Skip the first S/G entry as it points to AAD */
 		for_each_sg(sg_next(sgout), sg, UINT_MAX, pages) {
 			if (!sg)
@@ -1583,6 +1583,7 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 	} else if (out_sg) {
 		memcpy(sgout, out_sg, n_sgout * sizeof(*sgout));
 	}
+	dctx->free_sgout = !!pages;
 
 	/* Prepare and submit AEAD request */
 	err = tls_do_decryption(sk, sgin, sgout, dctx->iv,
-- 
2.43.0


