Return-Path: <netdev+bounces-71797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71662855186
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B3B1C206FD
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC387128388;
	Wed, 14 Feb 2024 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfT1XQJG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD21272CA
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933712; cv=none; b=luH0+bJSquBRT5lXLfYXQ0STjB3KOL0RDpL458VPndEDup/kRsLVtsFB5JKwOko4noHT042+LbYVXLXbkhLUheZD5XnobVIF8wzu9sUJjJwrPTOe30V288KiA+KLRrur1LD467x6H68GmAb52ljUJ3nSt+T0sdgH+EvumQ3iDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933712; c=relaxed/simple;
	bh=qY1jLmw81ZZfRJpn8v8sNSnOsKfWw4WiraorVwkA97w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kw+xePaq4ZerUC+sUpuHf29I6PkcKi0d3lbCFGPaMUPfhcWmPfxyQRKkjJ4HPxLQxPsuxsokxt4vYbIuW5uUSNXpSBbb2MDaiLl6X83lFJafR17MGB5Hw5ILyN0RgVOJpK7S86zYXVqS/eGYgKrkMZieIoAnajX3ncNuM7Yqh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfT1XQJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2288C433C7;
	Wed, 14 Feb 2024 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933712;
	bh=qY1jLmw81ZZfRJpn8v8sNSnOsKfWw4WiraorVwkA97w=;
	h=From:To:Cc:Subject:Date:From;
	b=JfT1XQJGBhPLd+ca1dHp7Jy58fc69iD3V2MNbIXEcStEGLAnzLcnJuER8IYlNLfQ7
	 VopsxHpjYExSKU3ZsiM6fRWkOLfw9Xfd0HJ4X6K7rcnhDj74VF06ruP+05a0kqEX3e
	 BpAb99avC9Fo0jmXSzxNT0GmqrMabxs7114JxnouacaWUPXAUyN9ZFToM5L08fM6O0
	 Hxsg1oTF+ecFnpkGDgrJPeeewoqtvSWzL788TJRs+G9jZOUIeJQ7y9scVHDT/JyLa2
	 RfB64ltJ9DdIbw8LG2aPHA3JMPjGtVWLRJ18pr37OXVIdZUn3R+x0aabfLBzWnpLRx
	 SeD9TdWBlxhnw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH net-next] net: page_pool: make page_pool_create inline
Date: Wed, 14 Feb 2024 19:01:28 +0100
Message-ID: <499bc85ca1d96ec1f7daff6b7df4350dc50e9256.1707931443.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make page_pool_create utility routine inline a remove exported symbol.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/page_pool/types.h |  6 +++++-
 net/core/page_pool.c          | 10 ----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 3828396ae60c..0057e584df9a 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -203,9 +203,13 @@ struct page_pool {
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
-struct page_pool *page_pool_create(const struct page_pool_params *params);
 struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
 					  int cpuid);
+static inline struct page_pool *
+page_pool_create(const struct page_pool_params *params)
+{
+	return page_pool_create_percpu(params, -1);
+}
 
 struct xdp_mem_info;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 89c835fcf094..6e0753e6a95b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -289,16 +289,6 @@ page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
 }
 EXPORT_SYMBOL(page_pool_create_percpu);
 
-/**
- * page_pool_create() - create a page pool
- * @params: parameters, see struct page_pool_params
- */
-struct page_pool *page_pool_create(const struct page_pool_params *params)
-{
-	return page_pool_create_percpu(params, -1);
-}
-EXPORT_SYMBOL(page_pool_create);
-
 static void page_pool_return_page(struct page_pool *pool, struct page *page);
 
 noinline
-- 
2.43.0


