Return-Path: <netdev+bounces-152562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97E49F4961
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3ADC7A2710
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F701E5708;
	Tue, 17 Dec 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iRQViPaQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F481E0087
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433014; cv=none; b=i+cEGJTN9mU2WaFXetXy8ZnuRLM1LbiIIbH6svIK+KEuV4rMM0xu+BJ2IZLYEQh0LowlHRwIRllp10saceiZmhZIjcwoMI+kTq1u19C8ggV5r29BSw0TtKkJOBt6X1c3ROGZr78sURCYb504NUxa9YOvXnqDOy8d71YOl0t84wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433014; c=relaxed/simple;
	bh=+gPw2p84+JcGzcVqUimdLrrr+ujlH7H1+rMmEw8ZAbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X6Ja08SCyb6HZ7Lyuz+U99t+RYtimVhLiZVQ+o8QkG2xK8KHzYJwD2LhfqQeuftyOOi1/IZN7JEdvJTjpmsOg3zeDL5uR87yWzgJ+zYaQm6NXABEDT1gVoAW1z1jLf75qnWshN+Mwm5sNYwN264XRqD8ZqHlzPbEbZ4XQnuR5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iRQViPaQ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734433009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bO3E0+rmn5snPXd9ch2E2+nIDmne3iawArYy2LgSexQ=;
	b=iRQViPaQqQ7Bp3vvcuuK2bSg+bGsHgBW899iWhgeInsOpU5k8rUcNXUtNJB264E6okg/KD
	vEHC1BCuaQvCOV+OR6K6xS7yJaNDnNylaTTv53ZiR4BMyqzUT4IA3KNR4ohPnj92dogQLb
	uGCse7eE1Xx2uHn21U4XqlOQhvT8zu0=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] sock: make SKB_FRAG_PAGE_ORDER equal to PAGE_ALLOC_COSTLY_ORDER
Date: Tue, 17 Dec 2024 18:56:59 +0800
Message-Id: <20241217105659.2215649-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The SKB_FRAG_PAGE_ORDER will be 3 if PAGE_SIZE is 4096, and less than 3
if it is not. So it will increase the number of memory allocations if
PAGE_SIZE is greater than 4096.

alloc_pages() only relates to the order, if an order is less than or equal
to PAGE_ALLOC_COSTLY_ORDER, it will get the page from rmqueue_pcplist() in
rmqueue(). So there's no need for the order to be less than
PAGE_ALLOC_COSTLY_ORDER.

To decrease the number of memory allocations, make SKB_FRAG_PAGE_ORDER
equal to PAGE_ALLOC_COSTLY_ORDER even if PAGE_SIZE isn't 4096.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/net/sock.h | 2 +-
 net/core/sock.c    | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..a33645226577 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2853,7 +2853,7 @@ extern __u32 sysctl_rmem_max;
 extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;
 
-#define SKB_FRAG_PAGE_ORDER	get_order(32768)
+#define SKB_FRAG_PAGE_ORDER	PAGE_ALLOC_COSTLY_ORDER
 DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
 
 static inline int sk_get_wmem0(const struct sock *sk, const struct proto *proto)
diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..0db306f4216c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3014,8 +3014,7 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 	}
 
 	pfrag->offset = 0;
-	if (SKB_FRAG_PAGE_ORDER &&
-	    !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
+	if (!static_branch_unlikely(&net_high_order_alloc_disable_key)) {
 		/* Avoid direct reclaim but allow kswapd to wake */
 		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
 					  __GFP_COMP | __GFP_NOWARN |
-- 
2.25.1


