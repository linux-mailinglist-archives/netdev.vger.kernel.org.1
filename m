Return-Path: <netdev+bounces-140114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5EC9B545B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC90B22BCA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219D20898F;
	Tue, 29 Oct 2024 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmu5TXgE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF3208224
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234750; cv=none; b=lyd43v/2EKYHwuE/gwFQdbISnq4lbRbV9nxpKpX+oOyISzxoCGWGFWSKoVu4SlC9AydVlQURQ4bVzWMj5bwXUzkZb5q4RB1lQ1ANX9/jqvoCyecTQJaCEA7KmdlSXVaC/neA9S+4IhcTW4OqQFaGYiRquhB7XqLsu/MO3WbpKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234750; c=relaxed/simple;
	bh=MPpJ9MAgQTGKiMca+3TwxgtGAu4G2CP87nP4yq+P6DY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOb3aZUKIGaJBeXUQvHSt8B0qTn5BESHH42DBe3xkijgq7Gq5pGQFwrTYtdPLUGxZJj7dsRQjpj9EPVUyX8pT5AgZmZiN8feAc/zta9OKu/KaFYZAoua1Fh4lDGBbTG4wwba4DX9pNpYt8cd1IOnAYTJIOLNnQlrjmznfn3OlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mmu5TXgE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e4ece7221so164688b3a.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234748; x=1730839548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTE4xQCVjMyxxqMXxr+7N7iCNqUizi/3PQsJgMgvBFA=;
        b=mmu5TXgELb128CkFAiGNRv84wtnk9d8nLEg/H4kBpLGN9gwoC4oDNNvP+ygRvgKtOc
         o+dSPsC7BTjtAtOjWM8QIqX1x6y3rvu7t2MVz3twRkqB065DFQXk16kEuYOPpX6fzE5E
         Pf0CHlNCQbod2lyim6i85Y+OuboE9FbjZ12CuMy+0ShT8+Vq4v+OoDuRhF1ZhlWrj1P7
         LuSLSECVz2ImPf1FJQNXnk2pYj/lfSDc+Sr6MBAXmDRQ1LtrV+YkoyhYLHoO8cbfeqet
         BBSrCgr4VcTeHAoXrGqM+45qDEQa1/qoLQwBp7od54Z+R5OQUsq2y8BzKTUIBqcZy8mT
         Mn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234748; x=1730839548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTE4xQCVjMyxxqMXxr+7N7iCNqUizi/3PQsJgMgvBFA=;
        b=NWJatxvIn8t1OVaYKqOOf0JkEt2vbw1Q2VhM9VK78V1UEh1GQgsnA1vOBMK0rZJJL5
         Cg7HFPd47xkeu/zi7StjPFfDEMaTuODg/8E8WaK7F2aXKT8bA1C/vrubQDyRIellMNSB
         C8rLqoP8zxqi3vTyCSnm9/XV2OeGzN5iIY0VHUV+pBIRDD5OmmgJIuDaI9oTKOIyUwRS
         bZs1uwYCxwFJCyqGveJ7o53PqI1rNhB98LacfyIRSX5hvQ0WIwbZdBLjgeWtUHq/CqKF
         NQkIU5K0BRgWLSNbssHM8Q3lATn7CqxG3UWuj6cCjt2pqUrn9YpJVMXWQ3+Hv/1zz/Ky
         qE2w==
X-Gm-Message-State: AOJu0YxUpOSrfotwOA5zuvLPm0i4yZNZOTkMD6sbSK0Ln70ljC8+dJBV
	aj3e0iRu8aHxCpUxFPY6QnQF6ubDYr4AFhOkl1wJk1yBCUpDDYpawFI1S2W6TPiDTt5WLPJ3Hh9
	h94BcXtQjOiRx5L5nz6X1BoCzPibvnuiQzwbPi2+29WBDzmAINDqeWBanU2P/zPFswWnYtj91xv
	/AyjZUMxnEYH0v16KSQwB1I7FBmv26peAbE21RFcpJ58Vv4z5KY9EHlsC8tQ4=
X-Google-Smtp-Source: AGHT+IEKGxoSoddutyhUFaULkcAEtXglgd09/xsyxMRpkID6DUSV4Uo0pLLV1QBH/hysppFRWIE1Nt7vkyQ/XtJbAQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6a00:2e97:b0:71e:6a72:e9d with
 SMTP id d2e1a72fcca58-72096badedfmr36603b3a.3.1730234747151; Tue, 29 Oct 2024
 13:45:47 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:36 +0000
In-Reply-To: <20241029204541.1301203-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-3-almasrymina@google.com>
Subject: [PATCH net-next v1 2/7] net: page_pool: create page_pool_alloc_netmem
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.

This enables drivers that want currently use page_pool_alloc to
transition to netmem by converting the call sites to
page_pool_alloc_netmem.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool/helpers.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 793e6fd78bc5..8e548ff3044c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -116,22 +116,22 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 	return page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
-static inline struct page *page_pool_alloc(struct page_pool *pool,
-					   unsigned int *offset,
-					   unsigned int *size, gfp_t gfp)
+static inline netmem_ref page_pool_alloc_netmem(struct page_pool *pool,
+						unsigned int *offset,
+						unsigned int *size, gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
-	struct page *page;
+	netmem_ref netmem;
 
 	if ((*size << 1) > max_size) {
 		*size = max_size;
 		*offset = 0;
-		return page_pool_alloc_pages(pool, gfp);
+		return page_pool_alloc_netmems(pool, gfp);
 	}
 
-	page = page_pool_alloc_frag(pool, offset, *size, gfp);
-	if (unlikely(!page))
-		return NULL;
+	netmem = page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
+	if (unlikely(!netmem))
+		return 0;
 
 	/* There is very likely not enough space for another fragment, so append
 	 * the remaining size to the current fragment to avoid truesize
@@ -142,7 +142,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 		pool->frag_offset = max_size;
 	}
 
-	return page;
+	return netmem;
+}
+
+static inline struct page *page_pool_alloc(struct page_pool *pool,
+					   unsigned int *offset,
+					   unsigned int *size, gfp_t gfp)
+{
+	return netmem_to_page(page_pool_alloc_netmem(pool, offset, size, gfp));
 }
 
 /**
-- 
2.47.0.163.g1226f6d8fa-goog


