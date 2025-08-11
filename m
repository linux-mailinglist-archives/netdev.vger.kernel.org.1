Return-Path: <netdev+bounces-212536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF4B21214
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C2D18931AB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DE262FF1;
	Mon, 11 Aug 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/vCuRUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C512264D3
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929716; cv=none; b=hHe4VPr36rMun74+WkiQkZDsEjlJbwRzDI/mkhLErPLBD6Z/p6TZKxO2t1FQFQ2AHEdaNq5Wg5pFX9loyjL3r960qMKnTMfjs5r3Vtstp8vhQIw3a6nO+IjmsRt8RM7sd6+Q8usWAZXwsyFjDiNqv+GPY/WYXZovKRQVeVjmjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929716; c=relaxed/simple;
	bh=iPAz8leLOH0+VgCTsfqbq9xvx+kXtQloJxGaAGtjeyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHzvWUf3pmE6p78x4vqKhaEvNh7Loyu4HCeRx1ftyWDiXgP31TI3uN2j6iyXvLlCtRhi1BoYAe3aWsvvESka5XoO4gpHA8rVNy0TV8L18GIKgekQDWtk4h6c5PeA65vWx4pCnDTjJybqUfo5S+ZSjx4R/HwLssXTT85Y5h7nYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/vCuRUP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so41948945e9.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929713; x=1755534513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYVqX4UpHRW7fGFfRHzuuCdSWMj9Su3Ou+2QVwzuaq4=;
        b=K/vCuRUPM4LrGFklg+hYJzaf3mL+tGMKA6mGSyuIp4Bnqzu8VeePuRWEynywKZ+GJQ
         2wXRV3i2PMEKwkQQYGZVbMTLZVlTsizXO7HXbv0HvIr++ZgGzl75wp4fjOAvIaQMoFfv
         p82LBdl8zVIb841zO58sDTHXKk1G4/fb3EvlVDLgQfmSMzrcpFMN18Fc00KC0yWrXZx5
         FausPB5PpYyzgsUzi4naeCV7DZ3YWwQzH0uR7fyLgK1dh7zczy6A1sH2mo6Ifj+Owzoi
         BDwVwYGm4qwE6ke6Hzvr+fy8R+i8Aty2dJIEIvvWCd6WVGBhika4ib3e6kelajdmVa92
         9gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929713; x=1755534513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYVqX4UpHRW7fGFfRHzuuCdSWMj9Su3Ou+2QVwzuaq4=;
        b=hswxfjReSFHUsSqfaLPMPqTSAyAvJ+zBV44cGOQqdaouUf8hqHCDF5QW53CItYG5xa
         ZrLpOo2jA1UGqunuHmSv8uGEAkA2stYG9rOJ7oR3bgGgpzNWOSmak3rpqVxDxOosSrt6
         uhoicWt1CrHiYtRbtLo2aQY9ugU7Tn3Ys/zLQGl680D0fBi6106r2wYOmNVobDl5QMlm
         zmA0sWRhSUPbfU+kr6zDVH+DW9CuGFtKkY15FDOCw0frrP/aIoyafb2fMDXwox66cSC2
         ErgDzfe0knTwle8+wwGCntLaN8jesmqbgX0XWy727ROoP9ZuDHtAEtqbNvwBT6I45vvI
         TvBw==
X-Gm-Message-State: AOJu0YzUTvZtSaJc/uRXxXpe4xcSJtDMajuHyXqDMdWOlRtcXqCHcaM4
	wHRJg76KEDlsHATGQEhQGh4zbbThEqX6oSPtwWbfM7aP6hsmOJyk58jR2yIhww==
X-Gm-Gg: ASbGncv59TOoHAFF807UsiVpiig160NFEZKTTUJB/IEWM2k7/BR2n0uRL7kR0Ur0NH/
	NzwdEMhy4P16hUEpiwrXYfrGQqNFnwPYLWZgq5sOu7rbpAPaQV0/LwhSz4/z22j3drqGavs8lIw
	dDSKqvIMeBpqe6W68Qw6lL+OTQYbuEu1DfeGE5UfJP8MfP/4fxni3nQzkfgWYH5TaTEunft7WtZ
	CeI/eeHRZH/PTj1DOjNqgeNPiPB1TXEyMs5jmqcADf9IQGrmW3OAMY9x+PmWEFIbTglWgvKGWQH
	9eiCmwYyfdmGbVIsKq1QYhNWFmUT1cYut0oo3YHijo3Dx9YjUXeTYFgsqBJVG4W+0Epo235SCZW
	D7eCJm788uejnX7u5
X-Google-Smtp-Source: AGHT+IG6g3gUFIRph6jK0rmVYToqpPuCIk7P0OLzsM1mkzhzP/1zxarj6HBweqIqIrC/CVJDovroKg==
X-Received: by 2002:a05:600c:1e8b:b0:456:f9f:657 with SMTP id 5b1f17b1804b1-459f4faccd5mr117958615e9.27.1754929712407;
        Mon, 11 Aug 2025 09:28:32 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:628b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm260267515e9.12.2025.08.11.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:28:31 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Byungchul Park <byungchul@sk.com>,
	asml.silence@gmail.com
Subject: [RFC net-next v1 4/6] net: convert page pool dma helpers to netmem_desc
Date: Mon, 11 Aug 2025 17:29:41 +0100
Message-ID: <dbde32b0c68a1ac5729e1c331438131bddbf3b04.1754929026.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754929026.git.asml.silence@gmail.com>
References: <cover.1754929026.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct netmem_desc has a clearly defined field that keeps dma_addr. Use
the new type in netmem and page_pool functions and get rid of a bunch of
now unnecessary accessor helpers.

While doing so, extract a helper for getting a dma address out of a
netmem desc, which can be used to optimise paths that already know the
underlying netmem type like memory providers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h            |  5 -----
 include/net/page_pool/helpers.h | 12 ++++++++++--
 net/core/netmem_priv.h          |  6 ------
 net/core/page_pool_priv.h       |  9 +++++----
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index d08797e40a7c..ca6d5d151acc 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -389,11 +389,6 @@ static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
 	return page_is_pfmemalloc(netmem_to_page(netmem));
 }
 
-static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
-{
-	return netmem_to_nmdesc(netmem)->dma_addr;
-}
-
 void get_netmem(netmem_ref netmem);
 void put_netmem(netmem_ref netmem);
 
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index db180626be06..a9774d582933 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -425,9 +425,10 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
 	page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
 }
 
-static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
+static inline dma_addr_t
+page_pool_get_dma_addr_nmdesc(const struct netmem_desc *nmdesc)
 {
-	dma_addr_t ret = netmem_get_dma_addr(netmem);
+	dma_addr_t ret = nmdesc->dma_addr;
 
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
 		ret <<= PAGE_SHIFT;
@@ -435,6 +436,13 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
 	return ret;
 }
 
+static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
+{
+	const struct netmem_desc *desc = netmem_to_nmdesc(netmem);
+
+	return page_pool_get_dma_addr_nmdesc(desc);
+}
+
 /**
  * page_pool_get_dma_addr() - Retrieve the stored DMA address.
  * @page:	page allocated from a page pool
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 23175cb2bd86..070faa136305 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -30,12 +30,6 @@ static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
 	netmem_to_nmdesc(netmem)->pp = pool;
 }
 
-static inline void netmem_set_dma_addr(netmem_ref netmem,
-				       unsigned long dma_addr)
-{
-	netmem_to_nmdesc(netmem)->dma_addr = dma_addr;
-}
-
 static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
 {
 	unsigned long magic;
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 6445e7da5b82..fcf70cbc3e09 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -18,17 +18,18 @@ void page_pool_unlist(struct page_pool *pool);
 static inline bool
 page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)
 {
+	struct netmem_desc *desc = netmem_to_nmdesc(netmem);
+
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
+		desc->dma_addr = addr >> PAGE_SHIFT;
 
 		/* We assume page alignment to shave off bottom bits,
 		 * if this "compression" doesn't work we need to drop.
 		 */
-		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
-				       << PAGE_SHIFT;
+		return addr != desc->dma_addr << PAGE_SHIFT;
 	}
 
-	netmem_set_dma_addr(netmem, addr);
+	desc->dma_addr = addr;
 	return false;
 }
 
-- 
2.49.0


