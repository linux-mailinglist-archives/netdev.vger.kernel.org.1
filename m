Return-Path: <netdev+bounces-18588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9C757CBC
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21330281777
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70810D2F7;
	Tue, 18 Jul 2023 13:00:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353214A8F
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19995C433C8;
	Tue, 18 Jul 2023 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689685244;
	bh=peXwgO2lyNmi+9SzG2/BdcMLN+f3eLd+y3jKWWgC8aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdkMaJKDTq+zIO7n8GZ1p6h2kCkWyoQVZH6lj/cGZHSgU+hRHEGX2iJAp83rnSOSw
	 7z9yGPVhvdymwCEL/bh89Q8SPgY4CGLXiUiwegZaO9RFiOtmVHD620zWrulzIqz5Fb
	 oq/U8LcSSgYAhLAOktz0OpCjr70/kOCmzLQ6DxPxetv6QlNyKsHj+iXub0jCsLR1Sm
	 IJDQqMIEunRPZAZFwtvCBglfCVX835YwoD6m9c1UhYZ7Kvl4djZ1iyX/sb4o3m+kkP
	 je/3k07aXFsZyASrqrqqy4HUICL9jUliyuYYU7ZL7rFU5X0e1s0NlXXKEc8+v7E88r
	 3gw+gyBOgIZzA==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Haren Myneni <haren@us.ibm.com>,
	Nick Terrell <terrelln@fb.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Richard Weinberger <richard@nod.at>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	qat-linux@intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 16/21] crypto: zstd - drop obsolete 'comp' implementation
Date: Tue, 18 Jul 2023 14:58:42 +0200
Message-Id: <20230718125847.3869700-17-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114; i=ardb@kernel.org; h=from:subject; bh=peXwgO2lyNmi+9SzG2/BdcMLN+f3eLd+y3jKWWgC8aQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT8NRrezVU4/VCR9T1G2en+U6PT268mNR7qltf/yWr W6dw1vRUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZysIDhD+duhXelu1kOWUzm bLrUfPHM98LuO2wvAxnCS2eFBF6LbGFkmFyxW636Xq/aoeVKTyexvWCOycrYJXNa+3NcRWVSweN 3LAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The 'comp' API is obsolete and will be removed, so remove this comp
implementation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/zstd.c | 56 +-------------------
 1 file changed, 1 insertion(+), 55 deletions(-)

diff --git a/crypto/zstd.c b/crypto/zstd.c
index 154a969c83a82277..c6e6f135c5812c9c 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -121,13 +121,6 @@ static void *zstd_alloc_ctx(struct crypto_scomp *tfm)
 	return ctx;
 }
 
-static int zstd_init(struct crypto_tfm *tfm)
-{
-	struct zstd_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	return __zstd_init(ctx);
-}
-
 static void __zstd_exit(void *ctx)
 {
 	zstd_comp_exit(ctx);
@@ -140,13 +133,6 @@ static void zstd_free_ctx(struct crypto_scomp *tfm, void *ctx)
 	kfree_sensitive(ctx);
 }
 
-static void zstd_exit(struct crypto_tfm *tfm)
-{
-	struct zstd_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	__zstd_exit(ctx);
-}
-
 static int __zstd_compress(const u8 *src, unsigned int slen,
 			   u8 *dst, unsigned int *dlen, void *ctx)
 {
@@ -161,14 +147,6 @@ static int __zstd_compress(const u8 *src, unsigned int slen,
 	return 0;
 }
 
-static int zstd_compress(struct crypto_tfm *tfm, const u8 *src,
-			 unsigned int slen, u8 *dst, unsigned int *dlen)
-{
-	struct zstd_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	return __zstd_compress(src, slen, dst, dlen, ctx);
-}
-
 static int zstd_scompress(struct crypto_scomp *tfm, const u8 *src,
 			  unsigned int slen, u8 *dst, unsigned int *dlen,
 			  void *ctx)
@@ -189,14 +167,6 @@ static int __zstd_decompress(const u8 *src, unsigned int slen,
 	return 0;
 }
 
-static int zstd_decompress(struct crypto_tfm *tfm, const u8 *src,
-			   unsigned int slen, u8 *dst, unsigned int *dlen)
-{
-	struct zstd_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	return __zstd_decompress(src, slen, dst, dlen, ctx);
-}
-
 static int zstd_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 			    unsigned int slen, u8 *dst, unsigned int *dlen,
 			    void *ctx)
@@ -204,19 +174,6 @@ static int zstd_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 	return __zstd_decompress(src, slen, dst, dlen, ctx);
 }
 
-static struct crypto_alg alg = {
-	.cra_name		= "zstd",
-	.cra_driver_name	= "zstd-generic",
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct zstd_ctx),
-	.cra_module		= THIS_MODULE,
-	.cra_init		= zstd_init,
-	.cra_exit		= zstd_exit,
-	.cra_u			= { .compress = {
-	.coa_compress		= zstd_compress,
-	.coa_decompress		= zstd_decompress } }
-};
-
 static struct scomp_alg scomp = {
 	.alloc_ctx		= zstd_alloc_ctx,
 	.free_ctx		= zstd_free_ctx,
@@ -231,22 +188,11 @@ static struct scomp_alg scomp = {
 
 static int __init zstd_mod_init(void)
 {
-	int ret;
-
-	ret = crypto_register_alg(&alg);
-	if (ret)
-		return ret;
-
-	ret = crypto_register_scomp(&scomp);
-	if (ret)
-		crypto_unregister_alg(&alg);
-
-	return ret;
+	return crypto_register_scomp(&scomp);
 }
 
 static void __exit zstd_mod_fini(void)
 {
-	crypto_unregister_alg(&alg);
 	crypto_unregister_scomp(&scomp);
 }
 
-- 
2.39.2


