Return-Path: <netdev+bounces-250712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B3D38FD4
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37E273002B81
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D918A1F239B;
	Sat, 17 Jan 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdzpC/Rj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ADE282EB
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768668180; cv=none; b=BR77xmmtXpdxob7NVtbQ0BdoIvLOZKRBXT2fRRu6PdCvW02DA+WddpJS3Z/by5JaGPy9AABHga5d3LopTChhlq9iiZYavsW7Tx1812YxRdnmvyO4d0Z28I2s1mz3CS8Atq2J7XL+mAXZe5y+oTx5HWS6FXHCJ4zVgHwvdzl1cd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768668180; c=relaxed/simple;
	bh=OEVGyzvk1uWTQdL0DsuIr0FRD046wKDltQnW8AGQXOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRcZ4XgfYAMrOeA88gr2Ydw6FJr7pPBI7B1KWEBydD15Hhj5YJJQYWk8PehQGt8+xjhD2c1YQ840f7GFnd94MsAVqBQbIhb1L07ihCuZJGe9fw5fRyG6c3vFkW7+458ghGWn05nRyrlACVh/l8l6njt3lToVodvYSdPokOYD1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdzpC/Rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C401CC4CEF7;
	Sat, 17 Jan 2026 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768668180;
	bh=OEVGyzvk1uWTQdL0DsuIr0FRD046wKDltQnW8AGQXOo=;
	h=From:To:Cc:Subject:Date:From;
	b=sdzpC/Rjq29ne94r0sDpl8wNIPPQUnwKvaZTbuXM2mZh6QedbzpjnOrviLFAys7tD
	 uVhA3C6RadaN+khEa1XcCghv6HaGw+IJ45h9F6c3FI/X5KvXxBDT7HXsCvQujipSaa
	 Dq7VNOwhDk6TLWA2l6RSAnWTt/7JBjAcYNU3IeJyq/3vwBmWwsMHnk93EDMYm3g5V6
	 VHBrUPVvJLpJhOqKR1r4geXkeWeuMwjwlyE0aRu3HhmfF3dkcp/lz4zMUgSmWxOZav
	 PWuxxdEdDoocrsMu9PQ9oHvRWENSDFAGeYOLTkBUuxZJzNALw+vwqZSZD13gGmznh8
	 J7OIDyWt5abgQ==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tcp: try to defer / return acked skbs to originating CPU
Date: Sat, 17 Jan 2026 08:42:55 -0800
Message-ID: <20260117164255.785751-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running a memcache-like workload under production(ish) load
on a 300 thread AMD machine we see ~3% of CPU time spent
in kmem_cache_free() via tcp_ack(), freeing skbs from rtx queue.
This workloads pins workers away from softirq CPU so
the Tx skbs are pretty much always allocated on a different
CPU than where the ACKs arrive. Try to use the defer skb free
queue to return the skbs back to where they came from.
This results in a ~4% performance improvement for the workload.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ef0fee58fde8..e290651da508 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -332,7 +332,7 @@ static inline void tcp_wmem_free_skb(struct sock *sk, struct sk_buff *skb)
 		sk_mem_uncharge(sk, skb->truesize);
 	else
 		sk_mem_uncharge(sk, SKB_TRUESIZE(skb_end_offset(skb)));
-	__kfree_skb(skb);
+	skb_attempt_defer_free(skb);
 }
 
 void sk_forced_mem_schedule(struct sock *sk, int size);
-- 
2.52.0


