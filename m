Return-Path: <netdev+bounces-156465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0485A067E1
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037EC167B90
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8422054E1;
	Wed,  8 Jan 2025 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="H3p8llut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC3204F94
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374039; cv=none; b=iO2N+Bf4aRCmD37kpORTstAjbL+kvNpepRyGD591Vz6WaQ/Ppwp8T4aXTDE2Youe2lbWj4G6myaDI794yq+Ut7PXMBUYrhLQKT8Vm4tsZJOZWS4n84880F5rs5GHOCqbxNw9MaXJ93HTev2WTqCASuFNprnHY39nDhv8Esn6C/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374039; c=relaxed/simple;
	bh=M/dVYf0LGQa6CQVsOOIFCgdYwKSSZAsHqwkr/NwsAxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0b+myFjKct2ziogOIm2y3NP2PVmiREwwzBqPfeCtFuHQqHzdeb1Fef6tk5GN16c/E4jdYZ8dIaMi5527n6ZcvofbjzOkQgg8+gDftrsaxbLgEFq6SQIPb3zOsVtDLtG1YH584PGv15fZzdHNP2sYLV8ttRllwsxzQBK0LxItQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=H3p8llut; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f8263ae0so3698355ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374037; x=1736978837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E88BGwIt5bUHwmtMswODWXw/q/DmBb3EpfR2MxHweGI=;
        b=H3p8llutR+uM4anuzB0jMjBQzYP2xOHJTK7FNZJ/b6iWUHksbJth1yL1ulC5bLFocK
         ni2LYGBNlco5HGTO64QGUrPtlSnW09G+iU1tsTYK8MrPzTfLqgu0KOEYAkG1spfPn/g3
         RKtbB11e06nU8na2HIx2AQwvXyxM2DYX9EiH19bppCBcPNqYDapJEZOmA1xFyX9gR7Aa
         EpLLBxkhkyWsclKbPBdTPrQ4TWldIyUJkll6TNEC6g8a8BJ/jK/FvqH+7kPegkt0TsgW
         A/14DaHmc1a31IMJVV/d9e3kpbgfoJncuVtObzSiN7uDlvIHA3EU5iEWLdKz5uqAgXh+
         MDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374037; x=1736978837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E88BGwIt5bUHwmtMswODWXw/q/DmBb3EpfR2MxHweGI=;
        b=unpYD+V0yNU/BRvK+MAED8zvhoD+udKbgVz3Qv1KeFXw5dVmU4AtU14j4mRc9wFJmh
         VY78c8dy6qgfA7KaBElKxldC5xYmnIqedL+LBb/v/9IxiCxaPSn4uIKdVJwiJ+JOScth
         zsqCEYyTPeQxkcLxuEo3yWvj3irz/1anDeH0lr+2ZwL80ZbPWde/izTZ6PuPMOI0ZCvt
         n4itJ2kIq/6O5e8Y1bKegFYIqBGIPDHkyHfK/BKm7h2NU4SwQ/rkosw78Um14FGO84wn
         fasinRsbN6z5tGyMNKTjpZGnywrBxEeWKXeCqd5mcKbLTjjP6fHEKsyNnAQyxxA01BOu
         JoIg==
X-Forwarded-Encrypted: i=1; AJvYcCUO9oO3mTqfGVXukrm9BnQqnoYX6bvqCsV8u0BzyQqIEl8Tc/LwqqIBDo8PvEEM89W4cCh7U5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QnXDXervjQnRKpMl+6vqS1cKIODPqLZkM05B/mfuKWD59ANP
	/+WsRIT4/tqO880W/CWEtVpyNJvWcyCDv/X4QP0t7f0yh8Bs6Dcb+nKA+H7VOso=
X-Gm-Gg: ASbGnctCEcMn9zo9igyNuEyUbRuQoNCxKZMj7Qi+Pl39zDXiuocAS3pBdIjHy79p8+6
	cJOpU1IZidW5HVE3VQy4zK3YJhlsOwCQ7DnPdWV26CALWWUjW4apdV7usnJpxtaOaGlFG35pRSR
	0W/XPAlH460HIEYiGSXya+q99+xb9SI0j9SZZsOy25kF26Eb3vV+1Sd44QFzgHjrJG5pLGyBqpl
	D/peNimytfOJLuceFHBSocnrXy7wdzUFFOu9aXN5A==
X-Google-Smtp-Source: AGHT+IEfClJH41YC9th1DSIqA6Ne/cqSeNeurvw5YSc9k/gX7ZNkjtHs9UixT3lobYiVXXMDd61LMQ==
X-Received: by 2002:a05:6a00:39a6:b0:724:e75b:22d1 with SMTP id d2e1a72fcca58-72d21ff524emr6060020b3a.16.1736374037114;
        Wed, 08 Jan 2025 14:07:17 -0800 (PST)
Received: from localhost ([2a03:2880:ff:18::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8361b7sm35665238b3a.74.2025.01.08.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:16 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH net-next v10 11/22] net: page_pool: add memory provider helpers
Date: Wed,  8 Jan 2025 14:06:32 -0800
Message-ID: <20250108220644.3528845-12-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108220644.3528845-1-dw@davidwei.uk>
References: <20250108220644.3528845-1-dw@davidwei.uk>
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

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h | 18 ++++++++++++++++++
 net/core/page_pool.c                    | 23 +++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index ef7c28ddf39d..c58ac54adb2f 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -23,4 +23,22 @@ struct memory_provider_ops {
 	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
 };
 
+void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
+void net_mp_niov_clear_page_pool(struct net_iov *niov);
+
+/*
+ * net_mp_netmem_place_in_cache() - give a netmem to a page pool
+ * @pool:      the page pool to place the netmem into
+ * @netmem:    netmem to give
+ *
+ * Push an accounted netmem into the page pool's allocation cache. The caller
+ * must ensure that there is space in the cache. It should only be called off
+ * the mp_ops->alloc_netmems() path.
+ */
+static inline void net_mp_netmem_place_in_cache(struct page_pool *pool,
+						netmem_ref netmem)
+{
+	pool->alloc.cache[pool->alloc.count++] = netmem;
+}
+
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 0c5da8c056ec..29591177eb31 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1212,3 +1212,26 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
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


