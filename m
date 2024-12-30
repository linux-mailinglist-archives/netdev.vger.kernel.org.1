Return-Path: <netdev+bounces-154476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1F9FE164
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 01:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1833D18852F4
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 00:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD321A23B1;
	Mon, 30 Dec 2024 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZjYwxLN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D51A239A;
	Mon, 30 Dec 2024 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735517767; cv=none; b=pNzmV7qeFNWeGwr32QM6tIqJwd5F+ZsFDwf2oOYPx8m+1nHHOvqr28h8PdgCwBITtL8imIKoc4Mc32hZHoimU1qcXtl3xHOpPT1zWJIkTLqdh7xr7sqShssga2jvrqFBIKZj/VzwC37W183OcfrtIOIyNzAyN4OqsCh4uIIyz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735517767; c=relaxed/simple;
	bh=dJNf7Ef27a6NAHmh6+QRwRI/qSPxeV2L1TYNFHLLkzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVWt5328LQLau88Aakmx0q+vfGdXdrdkryMnzziVvIncqFfdB9gx2B/MKBVj4DvX9QgY15Qc9chOQIBrfQ6LZTzMjztNhFY46panqLGjoEK9sncTUOLH2GqJKKvN9OXalapP3bTg+dDBvzr7dUbKiW4v5zgb+KQKbC4NE+WIJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZjYwxLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD69C4CED7;
	Mon, 30 Dec 2024 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735517767;
	bh=dJNf7Ef27a6NAHmh6+QRwRI/qSPxeV2L1TYNFHLLkzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZjYwxLNIsnI3UEDjC6onJ649O/YHCR0ndz/rCRokJNf/9Ow1DTkYDe+gQe0jtBlF
	 3Ac6R+iqoTEu5gb0n31NlsaPBnJm2xOTgr7cCi1jxN97iPeYyumX8mowsSYYXnq6bN
	 tjNVTZPAaj6kIZTFOjSMdQ9VP1RSESU9CDrvc/zUTA5tJ4hTIfsE9Up5+a349A8hmp
	 mHj9pCazllwDRqNxyvrNbiWGMxSQvIdz6iFvMA2MIb8tyKDfY/SSJ9/sJXTvgb4usq
	 gr/o2b6vkiRaWnkWHBHvFcbF83yyNdX0ZU/eSG6KdVNXl0g3lndVIzwDG0kjiCWHbY
	 fnnqkKM1ob26A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 22/29] crypto: s5p-sss - use the new scatterwalk functions
Date: Sun, 29 Dec 2024 16:14:11 -0800
Message-ID: <20241230001418.74739-23-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230001418.74739-1-ebiggers@kernel.org>
References: <20241230001418.74739-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

s5p_sg_copy_buf() open-coded a copy from/to a scatterlist using
scatterwalk_* functions that are planned for removal.  Replace it with
the new functions memcpy_from_sglist() and memcpy_to_sglist() instead.
Also take the opportunity to replace calls to scatterwalk_map_and_copy()
in the same file; this eliminates the confusing 'out' argument.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

This patch is part of a long series touching many files, so I have
limited the Cc list on the full series.  If you want the full series and
did not receive it, please retrieve it from lore.kernel.org.

 drivers/crypto/s5p-sss.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 57ab237e899e..b4c3c14dafd5 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -456,34 +456,21 @@ static void s5p_free_sg_cpy(struct s5p_aes_dev *dev, struct scatterlist **sg)
 
 	kfree(*sg);
 	*sg = NULL;
 }
 
-static void s5p_sg_copy_buf(void *buf, struct scatterlist *sg,
-			    unsigned int nbytes, int out)
-{
-	struct scatter_walk walk;
-
-	if (!nbytes)
-		return;
-
-	scatterwalk_start(&walk, sg);
-	scatterwalk_copychunks(buf, &walk, nbytes, out);
-	scatterwalk_done(&walk, out, 0);
-}
-
 static void s5p_sg_done(struct s5p_aes_dev *dev)
 {
 	struct skcipher_request *req = dev->req;
 	struct s5p_aes_reqctx *reqctx = skcipher_request_ctx(req);
 
 	if (dev->sg_dst_cpy) {
 		dev_dbg(dev->dev,
 			"Copying %d bytes of output data back to original place\n",
 			dev->req->cryptlen);
-		s5p_sg_copy_buf(sg_virt(dev->sg_dst_cpy), dev->req->dst,
-				dev->req->cryptlen, 1);
+		memcpy_to_sglist(dev->req->dst, 0, sg_virt(dev->sg_dst_cpy),
+				 dev->req->cryptlen);
 	}
 	s5p_free_sg_cpy(dev, &dev->sg_src_cpy);
 	s5p_free_sg_cpy(dev, &dev->sg_dst_cpy);
 	if (reqctx->mode & FLAGS_AES_CBC)
 		memcpy_fromio(req->iv, dev->aes_ioaddr + SSS_REG_AES_IV_DATA(0), AES_BLOCK_SIZE);
@@ -524,11 +511,11 @@ static int s5p_make_sg_cpy(struct s5p_aes_dev *dev, struct scatterlist *src,
 		kfree(*dst);
 		*dst = NULL;
 		return -ENOMEM;
 	}
 
-	s5p_sg_copy_buf(pages, src, dev->req->cryptlen, 0);
+	memcpy_from_sglist(pages, src, 0, dev->req->cryptlen);
 
 	sg_init_table(*dst, 1);
 	sg_set_buf(*dst, pages, len);
 
 	return 0;
@@ -1033,12 +1020,11 @@ static int s5p_hash_copy_sgs(struct s5p_hash_reqctx *ctx,
 	}
 
 	if (ctx->bufcnt)
 		memcpy(buf, ctx->dd->xmit_buf, ctx->bufcnt);
 
-	scatterwalk_map_and_copy(buf + ctx->bufcnt, sg, ctx->skip,
-				 new_len, 0);
+	memcpy_from_sglist(buf + ctx->bufcnt, sg, ctx->skip, new_len);
 	sg_init_table(ctx->sgl, 1);
 	sg_set_buf(ctx->sgl, buf, len);
 	ctx->sg = ctx->sgl;
 	ctx->sg_len = 1;
 	ctx->bufcnt = 0;
@@ -1227,12 +1213,11 @@ static int s5p_hash_prepare_request(struct ahash_request *req, bool update)
 		int len = BUFLEN - ctx->bufcnt % BUFLEN;
 
 		if (len > nbytes)
 			len = nbytes;
 
-		scatterwalk_map_and_copy(ctx->buffer + ctx->bufcnt, req->src,
-					 0, len, 0);
+		memcpy_from_sglist(ctx->buffer + ctx->bufcnt, req->src, 0, len);
 		ctx->bufcnt += len;
 		nbytes -= len;
 		ctx->skip = len;
 	} else {
 		ctx->skip = 0;
@@ -1251,13 +1236,12 @@ static int s5p_hash_prepare_request(struct ahash_request *req, bool update)
 			xmit_len -= xmit_len & (BUFLEN - 1);
 
 		hash_later = ctx->total - xmit_len;
 		/* copy hash_later bytes from end of req->src */
 		/* previous bytes are in xmit_buf, so no overwrite */
-		scatterwalk_map_and_copy(ctx->buffer, req->src,
-					 req->nbytes - hash_later,
-					 hash_later, 0);
+		memcpy_from_sglist(ctx->buffer, req->src,
+				   req->nbytes - hash_later, hash_later);
 	}
 
 	if (xmit_len > BUFLEN) {
 		ret = s5p_hash_prepare_sgs(ctx, req->src, nbytes - hash_later,
 					   final);
@@ -1265,12 +1249,12 @@ static int s5p_hash_prepare_request(struct ahash_request *req, bool update)
 			return ret;
 	} else {
 		/* have buffered data only */
 		if (unlikely(!ctx->bufcnt)) {
 			/* first update didn't fill up buffer */
-			scatterwalk_map_and_copy(ctx->dd->xmit_buf, req->src,
-						 0, xmit_len, 0);
+			memcpy_from_sglist(ctx->dd->xmit_buf, req->src,
+					   0, xmit_len);
 		}
 
 		sg_init_table(ctx->sgl, 1);
 		sg_set_buf(ctx->sgl, ctx->dd->xmit_buf, xmit_len);
 
@@ -1504,12 +1488,12 @@ static int s5p_hash_update(struct ahash_request *req)
 
 	if (!req->nbytes)
 		return 0;
 
 	if (ctx->bufcnt + req->nbytes <= BUFLEN) {
-		scatterwalk_map_and_copy(ctx->buffer + ctx->bufcnt, req->src,
-					 0, req->nbytes, 0);
+		memcpy_from_sglist(ctx->buffer + ctx->bufcnt, req->src,
+				   0, req->nbytes);
 		ctx->bufcnt += req->nbytes;
 		return 0;
 	}
 
 	return s5p_hash_enqueue(req, true); /* HASH_OP_UPDATE */
-- 
2.47.1


