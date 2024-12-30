Return-Path: <netdev+bounces-154468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE69FE137
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 01:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB5F3A1F94
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D6719B5A7;
	Mon, 30 Dec 2024 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqsgrDXN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7819AD93;
	Mon, 30 Dec 2024 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735517763; cv=none; b=a+4+y4vF5RLgkPdrl1vWzJmbQO2aU4fvyUnL8WhfIXmXlxZ0lPBqfGOTYm9K51uwnX5L7tBW3lXhMQ5znjOmd8xuBSgi0cdGtfgpHgE4Uzno4BYAxjhiMRzikCaUEfMiMsc3sdhZ7BlRc7tN8B7b2Kig7aLFfzxMYiqv2MYtaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735517763; c=relaxed/simple;
	bh=gxWz7ItVuXZh7ZMr8mOrMUU9vut7iYem6KQDBMBsI2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3QT+BrGGPMwwfFV2xo9ea84kkFB7RzdR99OBHb3RbwtMMSV0mYIlcnzirCxxTiNfiV9mQMKKLXpUlItaMDmQRfAdwRN+w1kNvc0MefyFU/ABvc2Q+3y+tvNh+EYh6ZEInuLQdTdublOAFKSwSwEg86fSwCsxwJB392jjDjQn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqsgrDXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F120EC4CED1;
	Mon, 30 Dec 2024 00:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735517763;
	bh=gxWz7ItVuXZh7ZMr8mOrMUU9vut7iYem6KQDBMBsI2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqsgrDXN20s8Fr17gpRjswtOcmwmPwp48qmCUjmftKxDXucDgA7zMbDojvTfGePJR
	 2ulGDs/k/VXAZpxixAvCBo3i72LbT03V+pzzqSEylr5W4cypx9R1T+RcbRKVYN44oO
	 mlKjj64YSrwJCZK0gwcnutdv3DmtOTSwrshOXupGc0IHxV4qjw3n10rYTVD8wlr+fO
	 IZWkuCbfZR/fOIeUNZ/cTrqZ+Tqo0D+yNFtSJF3RvGCGwDKe+ENnM3KtnVqGNvZY8U
	 H070vgD/IS6rJkxkWAWwSltDR9uiPMoN3xTTOE93BnDJ+/8kXhAOQR0tqsFEqMJKzU
	 TKd/OwN29+92g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/29] crypto: scatterwalk - add new functions for iterating through data
Date: Sun, 29 Dec 2024 16:14:02 -0800
Message-ID: <20241230001418.74739-14-ebiggers@kernel.org>
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

Add scatterwalk_next() which consolidates scatterwalk_clamp() and
scatterwalk_map().  Also add scatterwalk_done_src() and
scatterwalk_done_dst() which consolidate scatterwalk_unmap(),
scatterwalk_advance(), and scatterwalk_done() or scatterwalk_pagedone().
A later patch will remove scatterwalk_done() and scatterwalk_pagedone().

The new code eliminates the error-prone 'more' parameter.  Advancing to
the next sg entry now only happens just-in-time in scatterwalk_next().

The new code also pairs the dcache flush more closely with the actual
write, similar to memcpy_to_page().  Previously it was paired with
advancing to the next page.  This is currently causing bugs where the
dcache flush is incorrectly being skipped, usually due to
scatterwalk_copychunks() being called without a following
scatterwalk_done().  The dcache flush may have been placed where it was
in order to not call flush_dcache_page() redundantly when visiting a
page more than once.  However, that case is rare in practice, and most
architectures either do not implement flush_dcache_page() anyway or
implement it lazily where it just clears a page flag.

Another limitation of the old code was that by the time the flush
happened, there was no way to tell if more than one page needed to be
flushed.  That has been sufficient because the code goes page by page,
but I would like to optimize that on !HIGHMEM platforms.  The new code
makes this possible, and a later patch will implement this optimization.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/scatterwalk.h | 69 ++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 5c7765f601e0..8e83c43016c9 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -62,16 +62,10 @@ static inline unsigned int scatterwalk_clamp(struct scatter_walk *walk,
 	if (walk->offset >= walk->sg->offset + walk->sg->length)
 		scatterwalk_start(walk, sg_next(walk->sg));
 	return min(nbytes, scatterwalk_pagelen(walk));
 }
 
-static inline void scatterwalk_advance(struct scatter_walk *walk,
-				       unsigned int nbytes)
-{
-	walk->offset += nbytes;
-}
-
 static inline struct page *scatterwalk_page(struct scatter_walk *walk)
 {
 	return sg_page(walk->sg) + (walk->offset >> PAGE_SHIFT);
 }
 
@@ -84,10 +78,28 @@ static inline void *scatterwalk_map(struct scatter_walk *walk)
 {
 	return kmap_local_page(scatterwalk_page(walk)) +
 	       offset_in_page(walk->offset);
 }
 
+/**
+ * scatterwalk_next() - Get the next data buffer in a scatterlist walk
+ * @walk: the scatter_walk
+ * @total: the total number of bytes remaining, > 0
+ * @nbytes_ret: (out) the next number of bytes available, <= @total
+ *
+ * Return: A virtual address for the next segment of data from the scatterlist.
+ *	   The caller must call scatterwalk_done_src() or scatterwalk_done_dst()
+ *	   when it is done using this virtual address.
+ */
+static inline void *scatterwalk_next(struct scatter_walk *walk,
+				     unsigned int total,
+				     unsigned int *nbytes_ret)
+{
+	*nbytes_ret = scatterwalk_clamp(walk, total);
+	return scatterwalk_map(walk);
+}
+
 static inline void scatterwalk_pagedone(struct scatter_walk *walk, int out,
 					unsigned int more)
 {
 	if (out) {
 		struct page *page;
@@ -106,10 +118,55 @@ static inline void scatterwalk_done(struct scatter_walk *walk, int out,
 	if (!more || walk->offset >= walk->sg->offset + walk->sg->length ||
 	    !(walk->offset & (PAGE_SIZE - 1)))
 		scatterwalk_pagedone(walk, out, more);
 }
 
+static inline void scatterwalk_advance(struct scatter_walk *walk,
+				       unsigned int nbytes)
+{
+	walk->offset += nbytes;
+}
+
+/**
+ * scatterwalk_done_src() - Finish one step of a walk of source scatterlist
+ * @walk: the scatter_walk
+ * @vaddr: the address returned by scatterwalk_next()
+ * @nbytes: the number of bytes processed this step, less than or equal to the
+ *	    number of bytes that scatterwalk_next() returned.
+ *
+ * Use this if the @vaddr was not written to, i.e. it is source data.
+ */
+static inline void scatterwalk_done_src(struct scatter_walk *walk,
+					const void *vaddr, unsigned int nbytes)
+{
+	scatterwalk_unmap((void *)vaddr);
+	scatterwalk_advance(walk, nbytes);
+}
+
+/**
+ * scatterwalk_done_dst() - Finish one step of a walk of destination scatterlist
+ * @walk: the scatter_walk
+ * @vaddr: the address returned by scatterwalk_next()
+ * @nbytes: the number of bytes processed this step, less than or equal to the
+ *	    number of bytes that scatterwalk_next() returned.
+ *
+ * Use this if the @vaddr may have been written to, i.e. it is destination data.
+ */
+static inline void scatterwalk_done_dst(struct scatter_walk *walk,
+					void *vaddr, unsigned int nbytes)
+{
+	scatterwalk_unmap(vaddr);
+	/*
+	 * Explicitly check ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE instead of just
+	 * relying on flush_dcache_page() being a no-op when not implemented,
+	 * since otherwise the BUG_ON in sg_page() does not get optimized out.
+	 */
+	if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE)
+		flush_dcache_page(scatterwalk_page(walk));
+	scatterwalk_advance(walk, nbytes);
+}
+
 void scatterwalk_skip(struct scatter_walk *walk, unsigned int nbytes);
 
 void scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
 			    size_t nbytes, int out);
 
-- 
2.47.1


