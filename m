Return-Path: <netdev+bounces-162767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A4A27DEA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D2A3A6871
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3D21C19A;
	Tue,  4 Feb 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="A14y07Cm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA821C9ED
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706196; cv=none; b=LhBr8cSczMnrowWqYbhG4Qf1hqjoUKjlT6/+vXEwoZtUN5hz3KIm5mrSUaovYxRl6mJUCA5KMxOSZ1cjOboomQW4nWnZCWEoIdyKTBhNNeF7rF/ly302vYTJZnk5+LGn3cRhHj//DtBuf1aWy5wogC+FMv6flqGqPpwopTr0M7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706196; c=relaxed/simple;
	bh=mbXtUnP/WKL7seD8UicVZtx/K5SuPbOrPlmp/jJLm14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxTdY4+wYMWxt7/YyW8b3jYIKLcy2IMKvpOYyPIz8g11jV96izabllfnGMTbcBCWhTwmqswPSOJObj3vg2kMCHqgp5Cqbil4Kc8kpZfgcybrpV+sJTZbRYPC2tSV/XYBMFEtobSo077WHssYWOYxC3Jlyx/GYQ1LxC67fBjDnn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=A14y07Cm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2165448243fso24796875ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706193; x=1739310993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhZ6eD3glG9OYssaUEfMWj1JxNHLYtd+Ux2YSvdXR7Q=;
        b=A14y07CmeVG3cl5Ekq8y4+XBdUALOfJw9zn2zVveF7VJDCkrrrzXneLenPqtGoHgHh
         AOT6+C6UlnvgwlWMkyTLYIQPzUcTbGG2UkX+CCAFeLRRFUWZ8+Zq5u2w7geUnvbXHxGz
         mzkarpbiIhS6O5zbOgbw1+xvKGlLmVJZxrXSgsgLDtksWdqPYTIBZHuF9hHxarcnHX32
         CYrlA6kymJNSPV9HGly7T3qv8z9L6kaj9VwWyECko79CoAUg0VuaRt/4763qCxCHyUAg
         qUzof4G2B+qRHzhNYk2xwlKbXIawo1fTcJmmRE6X0uzwxXrXCM6p/ow/Lo89V7EPgtEe
         Opuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706193; x=1739310993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhZ6eD3glG9OYssaUEfMWj1JxNHLYtd+Ux2YSvdXR7Q=;
        b=I9b+pgfyaIN5GHlC1CIghzRXYYmCENu3K61Ym0XzzQ+dowP/Xg8rUASnHjWfrmPwb+
         udS9AckcqJMaVDYDfE6nUk6wIgwHVPKgzKsxhZAt8yyHYokg6QR8ZcwbEZrZ7kuk1CoY
         ak4z4YClCcOMJT8ray/ImkIdumqmmxMxNIEEfGNAALCJAbEVD/113n4OUeEcETUULP6/
         tB31F4amhgByXmDaojD71jQy4z8vmtJyUB69VfHnJSQazp9Y4ePT39f6bMfc6OnGK+Aa
         BwtZh5tQQbxAuLZcKXMDPUTEdUrzSgIXgWca29t9Kp2d9cOcNv0Ev1mYu13ZnV+0WM8O
         PH4A==
X-Gm-Message-State: AOJu0YwG5tTBDDz1cwqjOvrb2yyG8oI/0dYobY56oifjzvSEhsEJaxON
	tUki2//7RwcPv9t8RbnnDhz0P3ivNVEl3G2FO149RIP//Z2dzGB2RFC0H8y69keSUXHqiOTeYh8
	x
X-Gm-Gg: ASbGncuHljKC+uOeYTD38ViG5N4Es9FdjtItP57AGDII4tpqTKdM7TbHZONc5L8TXJx
	ul5oJEjqARJ7DlLUQD/8IWwDg1iqTw6QRCLFqEFu+xj5Y9XfLsWFmPjylhq2sbo+IXFaH/5DzXi
	GO7zDOzfkFsBE71LqdFMxhJ/0QQGhnce9j2/wVmYGI6olxiQE4TnHpa8/vKoVaqJ2y0E3LBQnNn
	ISC1PQfPJeUuCMUSFn7naAlEunTcuVGWA9P4280pJB9YQDx5+oH4X41DGMyeDgl5kvc3lUM77ul
X-Google-Smtp-Source: AGHT+IGozdxYzNKuYFfVoVfzlfV9RBiFrYddMNuoyiF83QhheY9lQks53EbQBnsbnWTZgMTLt7Cn8Q==
X-Received: by 2002:a05:6a00:44c4:b0:725:db34:6a8c with SMTP id d2e1a72fcca58-730351428b2mr934167b3a.13.1738706193154;
        Tue, 04 Feb 2025 13:56:33 -0800 (PST)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cea77sm11022164b3a.150.2025.02.04.13.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:32 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v13 09/10] net: page_pool: add memory provider helpers
Date: Tue,  4 Feb 2025 13:56:20 -0800
Message-ID: <20250204215622.695511-10-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Add helpers for memory providers to interact with page pools.
net_mp_niov_{set,clear}_page_pool() serve to [dis]associate a net_iov
with a page pool. If used, the memory provider is responsible to match
"set" calls with "clear" once a net_iov is not going to be used by a page
pool anymore, changing a page pool, etc.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h | 19 +++++++++++++++++
 net/core/page_pool.c                    | 28 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 36469a7e649f..4f0ffb8f6a0a 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -18,4 +18,23 @@ struct memory_provider_ops {
 	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
 };
 
+bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
+void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
+void net_mp_niov_clear_page_pool(struct net_iov *niov);
+
+/**
+  * net_mp_netmem_place_in_cache() - give a netmem to a page pool
+  * @pool:      the page pool to place the netmem into
+  * @netmem:    netmem to give
+  *
+  * Push an accounted netmem into the page pool's allocation cache. The caller
+  * must ensure that there is space in the cache. It should only be called off
+  * the mp_ops->alloc_netmems() path.
+  */
+static inline void net_mp_netmem_place_in_cache(struct page_pool *pool,
+						netmem_ref netmem)
+{
+	pool->alloc.cache[pool->alloc.count++] = netmem;
+}
+
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d632cf2c91c3..686bd4a117d9 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1197,3 +1197,31 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
+
+bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr)
+{
+	return page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov), addr);
+}
+
+/* Associate a niov with a page pool. Should follow with a matching
+ * net_mp_niov_clear_page_pool()
+ */
+void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov)
+{
+	netmem_ref netmem = net_iov_to_netmem(niov);
+
+	page_pool_set_pp_info(pool, netmem);
+
+	pool->pages_state_hold_cnt++;
+	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
+}
+
+/* Disassociate a niov from a page pool. Should only be used in the
+ * ->release_netmem() path.
+ */
+void net_mp_niov_clear_page_pool(struct net_iov *niov)
+{
+	netmem_ref netmem = net_iov_to_netmem(niov);
+
+	page_pool_clear_pp_info(netmem);
+}
-- 
2.43.5


