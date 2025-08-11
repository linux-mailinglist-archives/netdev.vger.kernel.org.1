Return-Path: <netdev+bounces-212537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A1B21217
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB18C1893CAB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E62264D3;
	Mon, 11 Aug 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfaHOcz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B55311C2E
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929718; cv=none; b=uwU3elvQrzsgJoqgHhaFcTqixm9Q7WTo5YQ8C91mCc/0PtlGKYriABg0W6c3RuixgidNOg6SQ5MS8m4ndkTm2jZ4hUetB+tRjqhFmzRfOudf1yPRaStXYJggJVRtY14fvR0bHxGgvLP/bbZ1X4/gfcO5Zyo0DF9ckL0UEQyZQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929718; c=relaxed/simple;
	bh=+RMn9AFiGHAhqZm1nH/+34rDg3Lr/cDqH9ZAN2mup4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+6FeWI9capnsx8tKJmNgvmEermp/OxYk9LniwPX7m85kzQqGQBGzxIRkQyC/40giKORYDb14S93U8y3rfk7+WaKFLKaxzoGeg/EryGRtF+T/gTn7aQ8wUQ0IF7uHjfF50ErO0XnoHVebPFWS5LVq9m2yFIyGjJcAh9ZdxfVBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfaHOcz+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458ba079338so35570105e9.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929714; x=1755534514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q67DRWrXlyXlidkM6wSYNWw1um1lTrwUmrSWvXSavKc=;
        b=MfaHOcz+hepD6HfZA5+N/mqIc9SqmwEX3p+pdZj+CFxcSqk/UfP0ZswxvQNz8/v2sD
         fTC8T7AUMb66Yy/k2EKJmCo1mv+ZBDtejzXQpGxL0tgKNME/JT97u0LCZqZgsyM7d7Lq
         hAOKRtGvJGFr1zfDtJnOstdINkRqULbTbLqvA1kTzJqzh5IyubkH/eqxNn7b449HX5Lb
         OYLDsZtu2g7TC6hvSRvo0vhm5rJGzKN/HTx8MbXG5Kob32PHjryBvl+t4Z/XByJAzTPS
         TB25zV8JT6qDdTvXI64gicNlyNgRP5ItSLXqKYvn7Yi0LEKVqarhv/M1z6j8xeiLN3Uw
         bCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929714; x=1755534514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q67DRWrXlyXlidkM6wSYNWw1um1lTrwUmrSWvXSavKc=;
        b=q4CX39qHlOhxI5EBTqmfN7vbglPjjPCibXaRnZIkwUE1IFoCt88I3sFpj4yaUvsqM+
         91Nl6/QF+x/V53g1E4vGS+snr8Z/K7TDG71gsbgj5Qn2tlqHAQYdrg/AngG2LthZwyLR
         ne9Me9CJKKP3N1ObxwuzLJjePh1+nam0aXE/lY0zlg8bhWgjJ52LzSIhHvXPBDUbGRG4
         ExWaNDjnZERc0oeaQon9VPl87h5JCuaR3AHhSEN60o7rbww6nmDfyvkt0ikr2I63sncD
         HLXl5zyDwEn6irhcBackrJK3uG0RAmrJ9jsYsmmo6eiWQg0WfOl42YqpuFYuM4Wu3Auc
         o03Q==
X-Gm-Message-State: AOJu0YzGzDK91e21MyFqLlKf6vbBnbqvNKENVPi2UBpg2md2IZyAVdN5
	e8dx2d3cRY3crIpWs0ixhy/yYoT2UaayyrMp7NOn4KQmBuhF5/hkcLHEQAGzGg==
X-Gm-Gg: ASbGncujabTccSUJu8qAzeS2X9gF67pHjnpNBMbT5HSUpbesRqH1lGqJ63+MXnYBmYH
	dQYXuj59fdzdqZ7hqwknmu2rlb6GaY7/8hWoAwAX9ngHznK5r5obPMgEyRf/y6RCK2bGlD6KGai
	5IA6+seJrEy/VfEKG01TYoWe+LuuPQWLWWuqWn2kCkYsMA78NOPdKp7Aara7joKfRSJEjCHTeac
	PI+dFIEmn5vq71lVeeLRIygZHTAl87KmTiRzPjg8mD0VWON8BgK/MYA+uksjq5KT8Uadu4WP0G/
	ysvJ+bWW8Wgo0GdZTxD8qzIhLpuYP6JYcfn6cL3FzGvBeuD4ka5UCocQl/eNlvycKy5d4h0BX8H
	XCj869htS+t82+3Fs
X-Google-Smtp-Source: AGHT+IEGnMJQ5ujGhm7S83dQ5EhwrwQ4VJIj8OwaOd5xpfmBwUlRDEEA+YtbZ6ChXsi0LAi0Xop+Qg==
X-Received: by 2002:a05:600c:4fca:b0:456:189e:223a with SMTP id 5b1f17b1804b1-45a10d92d93mr2084965e9.10.1754929713906;
        Mon, 11 Aug 2025 09:28:33 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:628b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm260267515e9.12.2025.08.11.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:28:32 -0700 (PDT)
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
Subject: [RFC net-next v1 5/6] net: page_pool: convert refcounting helpers to nmdesc
Date: Mon, 11 Aug 2025 17:29:42 +0100
Message-ID: <7be7a705b9bac445e40c35cd227a4d5486d95dc9.1754929026.git.asml.silence@gmail.com>
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

Use netmem descriptors for the basic buffer refcounting helpers and use
them to implement all other variants. This way netmem type aware helpers
can avoid intermediate netmem casting and bit masking/unmasking.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h            |  5 -----
 include/net/page_pool/helpers.h | 29 ++++++++++++++++++++++-------
 net/core/devmem.c               |  5 -----
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index ca6d5d151acc..7b5f1427f272 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -324,11 +324,6 @@ static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 	return netmem_to_nmdesc(netmem)->pp;
 }
 
-static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
-{
-	return &netmem_to_nmdesc(netmem)->pp_ref_count;
-}
-
 static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
 {
 	/* NUMA node preference only makes sense if we're allocating
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index a9774d582933..bc54040186d9 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -234,9 +234,14 @@ page_pool_get_dma_dir(const struct page_pool *pool)
 	return pool->p.dma_dir;
 }
 
+static inline void page_pool_fragment_nmdesc(struct netmem_desc *desc, long nr)
+{
+	atomic_long_set(&desc->pp_ref_count, nr);
+}
+
 static inline void page_pool_fragment_netmem(netmem_ref netmem, long nr)
 {
-	atomic_long_set(netmem_get_pp_ref_count_ref(netmem), nr);
+	page_pool_fragment_nmdesc(netmem_to_nmdesc(netmem), nr);
 }
 
 /**
@@ -259,12 +264,12 @@ static inline void page_pool_fragment_netmem(netmem_ref netmem, long nr)
  */
 static inline void page_pool_fragment_page(struct page *page, long nr)
 {
-	page_pool_fragment_netmem(page_to_netmem(page), nr);
+	page_pool_fragment_nmdesc(pp_page_to_nmdesc(page), nr);
 }
 
-static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
+static inline long page_pool_unref_nmdesc(struct netmem_desc *desc, long nr)
 {
-	atomic_long_t *pp_ref_count = netmem_get_pp_ref_count_ref(netmem);
+	atomic_long_t *pp_ref_count = &desc->pp_ref_count;
 	long ret;
 
 	/* If nr == pp_ref_count then we have cleared all remaining
@@ -307,19 +312,29 @@ static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
 	return ret;
 }
 
+static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
+{
+	return page_pool_unref_nmdesc(netmem_to_nmdesc(netmem), nr);
+}
+
 static inline long page_pool_unref_page(struct page *page, long nr)
 {
-	return page_pool_unref_netmem(page_to_netmem(page), nr);
+	return page_pool_unref_nmdesc(pp_page_to_nmdesc(page), nr);
+}
+
+static inline void page_pool_ref_nmdesc(struct netmem_desc *desc)
+{
+	atomic_long_inc(&desc->pp_ref_count);
 }
 
 static inline void page_pool_ref_netmem(netmem_ref netmem)
 {
-	atomic_long_inc(netmem_get_pp_ref_count_ref(netmem));
+	page_pool_ref_nmdesc(netmem_to_nmdesc(netmem));
 }
 
 static inline void page_pool_ref_page(struct page *page)
 {
-	page_pool_ref_netmem(page_to_netmem(page));
+	page_pool_ref_nmdesc(pp_page_to_nmdesc(page));
 }
 
 static inline bool page_pool_unref_and_test(netmem_ref netmem)
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 24c591ab38ae..e084dad11506 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -440,14 +440,9 @@ void mp_dmabuf_devmem_destroy(struct page_pool *pool)
 
 bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 {
-	long refcount = atomic_long_read(netmem_get_pp_ref_count_ref(netmem));
-
 	if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
 		return false;
 
-	if (WARN_ON_ONCE(refcount != 1))
-		return false;
-
 	page_pool_clear_pp_info(netmem);
 
 	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
-- 
2.49.0


