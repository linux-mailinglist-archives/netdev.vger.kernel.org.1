Return-Path: <netdev+bounces-241776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1279C88138
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632F03B451D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248B2749D5;
	Wed, 26 Nov 2025 04:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6A800;
	Wed, 26 Nov 2025 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131825; cv=none; b=Je8ldLJ+qyGG8KKnDwIiBiZ75rg1q8sZ6t7+TGbdlsfn60K9UaK06wscO4z+H7tf1bIWnJFbCIZtBxNBaC2DEo2J82GKu06LVOp9XcgcdA5uD22g3jgFx/CTo/OOzh3cltax+LvCKRAsmlX5UbcuyCsxB1i0SXaewoS5mkh2MTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131825; c=relaxed/simple;
	bh=4r2tG5OcpK/gxeMJIi4NFKmZJ8hk/NIS0GZRwstCZn0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kwizxa5PLVh0l9lZQDpGis+XatXjplcXkd6aIhcfclohPsaH7lsXC6yre1wmOJ5JG/kbGWSiSsw1Jqa7BlNzbLPiMX5NWKxDXAHXSP5ZErOu+xWoxmvnSlZh/SfzvBgEkugTdIm3Hke4ZXw7m50Fsz7n5YNC0PKbahuxpiJfVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-f9-692683e88426
From: Byungchul Park <byungchul@sk.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	toke@redhat.com,
	kuba@kernel.org,
	asml.silence@gmail.com,
	almasrymina@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	sdf@fomichev.me,
	dw@davidwei.uk,
	ap420073@gmail.com,
	dtatulea@nvidia.com,
	shivajikant@google.com
Subject: [PATCH net-next v2] netmem, devmem, tcp: access pp fields through @desc in net_iov
Date: Wed, 26 Nov 2025 13:36:46 +0900
Message-Id: <20251126043646.75869-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC9ZZnoe6LZrVMgw3PLC1W/6iw+LnmOZPF
	nFXbGC3mnG9hsVi3q5XJYueu54wWr2asZbN4euwRu8X9Zc9YLB71n2CzuLCtj9Xi3OGVbBaX
	d81hs+i4s5fF4tgCMYtvp98wWlyduYvJYuGdeItLhx+xOAh7bFl5k8nj2oyJLB439p1i8tg5
	6y67x4JNpR6bVnWyefQ2v2Pz+Pj0FovH+31X2Tw+b5IL4IrisklJzcksSy3St0vgyth6ex9T
	wSyBilvT97M1MM7k7WLk5JAQMJGYuvoRE4y9+uAtMJtNQF3ixo2fzCC2iICUxMcd29m7GLk4
	mAU2M0tMfPefBSQhLBAtsXnaXUYQm0VAVeL1hUVsXYwcHLwCphK/H9pCzJSXWL3hADNIr4TA
	bTaJlct3sEMkJCUOrrjBMoGRewEjwypGocy8stzEzBwTvYzKvMwKveT83E2MwABeVvsnegfj
	pwvBhxgFOBiVeHg3/FHNFGJNLCuuzD3EKMHBrCTCu7ZPJVOINyWxsiq1KD++qDQntfgQozQH
	i5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDY4nOaZEnbSz6cS/dRTb/8H1TsXX7lUun8r88
	25fK3lzVe0s/6kjmqYA7X5OWbbn19t7ywxvZP7E/qb44fe7NGvZi90831prni5Q/eOR7a8nq
	pfO/t88OXn/0p+Fd+1NdWr/lau7c3P/UeDKbneLRwkOXu52nx4Z/YVlgcuiEv0vZQ0PNZ5/1
	0hyUWIozEg21mIuKEwEr5efMXAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAwFDArz9CAMSsAMaCGludGVybmFsIgYKBApOO4Mt6IMmaTDyjiw4q/h4OPms
	5wI4nKq2ATicz4QEOK66hQI4ubrnATjqmK0GOOXG4gc436bmBDjij8gGOMOdyQU40LaOBTjO
	w6kGONO6nAY4iNy9BDjGoBY49svsATjVmboCOKHcXzjSw+IEQBRItKnZAkjWmJEESNi+ygJI
	uZrdB0igsnVIsqqJBkiNg+4GSPHl2gRI777VBkij6PACSPOyHlALWgo8ZGVsaXZlci8+YApo
	tdu+AnCaEHjal78GgAGZDYoBCQgYEDQYq8HaAooBCQgGECcY2Nj5A4oBCQgUEBoY8bi3B4oB
	CggDELMDGJHu/wSKAQkIExBbGLOW3QGKAQkIBBAlGOvQogaKAQgIDRA1GPvhPYoBCQgYEB8Y
	q7DAA5ABCKABAKoBFGludm1haWw1LnNraHluaXguY29tsgEGCgSmffyRuAH000fCARAIASIM
	DbD8JWkSBWF2c3ltwgEYCAMiFA2tjiRpEg1kYXl6ZXJvX3J1bGVzwgEbCAQiFw1KV2VgEhBn
	YXRla2VlcGVyX3J1bGVzwgECCAkagAEDkmeWRhIMFVInB20rdKCvRqKOGTgVl6yHiuj6bHXT
	kzaxcmLCxowtkyHYfTlZ7KcRRIVoDq580enGVi84v8zF38mENR1oF68uZWuWGJaz6GJGAHYB
	KJkIck212su1fT4t6FVfkOHFKub7IBzBjU7vaGGScPEObPA5TYMfFEE3TCIEc2hhMSoDcnNh
	GnsTZkMCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Convert all the legacy code directly accessing the pp fields in net_iov
to access them through @desc in net_iov.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
Changes from v1:
	1. Drop 1/3 since it already has been worked in io-uring tree.
	2. Drop 3/3 since it requires the io-uring change to be merged.
---
 include/linux/skbuff.h | 4 ++--
 net/core/devmem.c      | 6 +++---
 net/ipv4/tcp.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ff90281ddf90..86737076101d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3778,8 +3778,8 @@ static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
 					    enum dma_data_direction dir)
 {
 	if (skb_frag_is_net_iov(frag)) {
-		return netmem_to_net_iov(frag->netmem)->dma_addr + offset +
-		       frag->offset;
+		return netmem_to_net_iov(frag->netmem)->desc.dma_addr +
+		       offset + frag->offset;
 	}
 	return dma_map_page(dev, skb_frag_page(frag),
 			    skb_frag_off(frag) + offset, size, dir);
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 1d04754bc756..ec4217d6c0b4 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -97,9 +97,9 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	index = offset / PAGE_SIZE;
 	niov = &owner->area.niovs[index];
 
-	niov->pp_magic = 0;
-	niov->pp = NULL;
-	atomic_long_set(&niov->pp_ref_count, 0);
+	niov->desc.pp_magic = 0;
+	niov->desc.pp = NULL;
+	atomic_long_set(&niov->desc.pp_ref_count, 0);
 
 	return niov;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index dee578aad690..f035440c475a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2587,7 +2587,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->pp_ref_count);
+				atomic_long_inc(&niov->desc.pp_ref_count);
 				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
 
 				sent += copy;
-- 
2.17.1


