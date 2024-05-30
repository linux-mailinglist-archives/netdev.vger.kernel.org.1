Return-Path: <netdev+bounces-99495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F78D50ED
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A4F283323
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C303F45BFF;
	Thu, 30 May 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNTCkHfm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D924655F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089686; cv=none; b=nCgOB7Q+LD2ZXq47D7gEaw067tln9sboHRgn9WFMnSEQXTqopUd3nZ+3ywEuS8j0KLONS2IUmGkeOdAidjCxrG4GYVA0E+gMyON76X9p0MwSrTvgj8eulGzSKP13n3sWcqX3yDk+9oj2iL5asBXFNCdcSGs5kZJo23QW9KWYItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089686; c=relaxed/simple;
	bh=ThNfK80vfaVwVlWDWyFllwp95oYfJ7BBClbIpG7UWR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QumEVnnPAjwdh0zlS8qf8dO1BMWDH/eJhgWs9chjDOD1KATL31NqQxgtKeuFYnM8oH+jXOhgdQA+wqqLxv6pHpzx/5NG71cYxrXhX6yDTqPgxsrpO+BVtzEewQvYsnchShctcQzRhT7Q2ONZ9OeI/25bCgLGqufXej17AEixBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNTCkHfm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxbkADqPb1sAHUnDri1UMOEusAT7ldaPvVPWa4G6Nws=;
	b=SNTCkHfmIGu0rUy+l8DX8jV+EslXtTlPYVMRL0/cWi+fQgdyd1ovnaM93Q9+vUj4IR5Zzw
	EByJXZ6cloVlPW/wjRLdYFNJz0mf+aQC5VgVnUe+Py5fDw/Nwxa0U9kcWNnUzmIydczA0s
	NN6eb59GEWAzm2qjqlACSBVpmXqhNZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-ZuFNwf0pMJKDu0ach7YyDQ-1; Thu, 30 May 2024 13:21:18 -0400
X-MC-Unique: ZuFNwf0pMJKDu0ach7YyDQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58BFE101A525;
	Thu, 30 May 2024 17:21:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 386884026B8;
	Thu, 30 May 2024 17:21:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] dst_cache: let rt_uncached cope with dst_cache cleanup
Date: Thu, 30 May 2024 19:21:03 +0200
Message-ID: <cd710487a34149654a5ff73a8c0df9b1d3fc73a9.1717087015.git.pabeni@redhat.com>
In-Reply-To: <cover.1717087015.git.pabeni@redhat.com>
References: <cover.1717087015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Eric reported that dst_cache don't cope correctly with device removal,
keeping the cached dst unmodified even when the underlining device is
deleted and the dst itself is not uncached.

The above causes the infamous 'unregistering netdevice' hangup.

Address the issue by adding each entry held by the dst_caches to the
'uncached' list, so that the dst core will cleanup the device reference
at device removal time.

Reported-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: 911362c70df5 ("net: add dst_cache support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/dst_cache.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 6a0482e676d3..d1cb852d5748 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -11,6 +11,7 @@
 #include <net/route.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ip6_fib.h>
+#include <net/ip6_route.h>
 #endif
 #include <uapi/linux/in.h>
 
@@ -28,6 +29,7 @@ static void dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
 				      struct dst_entry *dst, u32 cookie)
 {
 	dst_release(dst_cache->dst);
+
 	if (dst)
 		dst_hold(dst);
 
@@ -98,6 +100,9 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 
 	idst = this_cpu_ptr(dst_cache->cache);
 	dst_cache_per_cpu_dst_set(idst, dst, 0);
+	if (dst && list_empty(&dst->rt_uncached))
+		rt_add_uncached_list(dst_rtable(dst));
+
 	idst->in_saddr.s_addr = saddr;
 }
 EXPORT_SYMBOL_GPL(dst_cache_set_ip4);
@@ -114,6 +119,9 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 	idst = this_cpu_ptr(dst_cache->cache);
 	dst_cache_per_cpu_dst_set(idst, dst,
 				  rt6_get_cookie(dst_rt6_info(dst)));
+	if (dst && list_empty(&dst->rt_uncached))
+		rt6_uncached_list_add(dst_rt6_info(dst));
+
 	idst->in6_saddr = *saddr;
 }
 EXPORT_SYMBOL_GPL(dst_cache_set_ip6);
-- 
2.43.2


