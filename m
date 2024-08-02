Return-Path: <netdev+bounces-115166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FC794553F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBD61F21A76
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25BC4C66;
	Fri,  2 Aug 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbU4PIay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5EB28FA
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557999; cv=none; b=kVWDFDNtKzGdt6AS7KSuLW0Gloavi6Z2BixWod1zWTGCgIVwbYmyDL1xisHA49Ze3TnCYBrN4fTFVPe68cw9kYU+zPHeLajPoRLWPwhKKD9gfoQn9qz8JK4WiQ0Td/QKf3fDGDxeZejh6u4aBiCuetW7F1Pez+TN3AE7mScp07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557999; c=relaxed/simple;
	bh=IyIfhXkFYvhnFpcSoip1XhHO0Pl4PCqPMI/jG1Sv7Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DigYzPr8bCw4eiBdj8G2ZHX94RhTLovFaQkAHGle836XtlB8I3fu6ln5VcAyVhb7/vup0xfWXULF+qqaHfksRyTtsKPjWpcZeikXyAOjtESypYgU09srKxjF/ZgUBEKGuoVzxTTpzuYsFd7kuh0GGbt/9qWr/X0p8S0S7ccYhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbU4PIay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30557C32786;
	Fri,  2 Aug 2024 00:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557999;
	bh=IyIfhXkFYvhnFpcSoip1XhHO0Pl4PCqPMI/jG1Sv7Xk=;
	h=From:To:Cc:Subject:Date:From;
	b=pbU4PIay9cWiqaTiQWsauerjhDnUAvyTfVf2jAFfU96F3o/Hvg3XI2KueVlIO2ApX
	 /ao5Ft7A+UMOt6glktxKGYglioV79Hv2M7XzblLAkqLY0ycUct0M2Iq+N87YRo4naf
	 KYCYqKL6QdRwWBbLyEJtYHQn3aXxpJSligWukV0qvEfB81q7l9CWWj/w2p2phSiKBT
	 VS1kiXjX4FU2lh3w2Ob2KtiA/Zak5Q+hMHxSFfW2xylBLRghdx9/hG5PIcwuwDqINL
	 CsYU1cX+SdGo+Yzf0ISAaxAW32JklqU6VkkErDo6lAVYgsHjpqx5V+0DLZaGgiD9+D
	 s5WSvjNyBg3KA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: skbuff: sprinkle more __GFP_NOWARN on ingress allocs
Date: Thu,  1 Aug 2024 17:19:56 -0700
Message-ID: <20240802001956.566242-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_skb() and frag allocations done with GFP_ATOMIC will
fail in real life, when system is under memory pressure,
and there's nothing we can do about that. So no point
printing warnings.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/skbuff.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..de2a044cc665 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -314,8 +314,8 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 	fragsz = SKB_DATA_ALIGN(fragsz);
 
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
-	data = __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
-				       align_mask);
+	data = __page_frag_alloc_align(&nc->page, fragsz,
+				       GFP_ATOMIC | __GFP_NOWARN, align_mask);
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 	return data;
 
@@ -330,7 +330,8 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
 
 		fragsz = SKB_DATA_ALIGN(fragsz);
-		data = __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC,
+		data = __page_frag_alloc_align(nc, fragsz,
+					       GFP_ATOMIC | __GFP_NOWARN,
 					       align_mask);
 	} else {
 		local_bh_disable();
@@ -349,7 +350,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
 		nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
-						      GFP_ATOMIC,
+						      GFP_ATOMIC | __GFP_NOWARN,
 						      NAPI_SKB_CACHE_BULK,
 						      nc->skb_cache);
 		if (unlikely(!nc->skb_count)) {
@@ -418,7 +419,8 @@ struct sk_buff *slab_build_skb(void *data)
 	struct sk_buff *skb;
 	unsigned int size;
 
-	skb = kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
+	skb = kmem_cache_alloc(net_hotdata.skbuff_cache,
+			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -469,7 +471,8 @@ struct sk_buff *__build_skb(void *data, unsigned int frag_size)
 {
 	struct sk_buff *skb;
 
-	skb = kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
+	skb = kmem_cache_alloc(net_hotdata.skbuff_cache,
+			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.45.2


