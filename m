Return-Path: <netdev+bounces-239459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B30ABC68881
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A88A4F11F6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28A31E10B;
	Tue, 18 Nov 2025 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wqIMmWmd"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779EB3101DD
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457986; cv=none; b=anz+RybbR2jNRXnZ5i7+BfbfkXB2fNqCUWvLsIqdNZxVIxXVmWT2uHCDW3g/CiOBkOOPJThXC4QHi/sdt3gzrD68drIgTkIxpt2TJQsuGf4gT+7Mx1M7+tI0zq/plC9omoECAa7t9u8TXWuBmmTf9bGFTdqp6iaQReRReMFfAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457986; c=relaxed/simple;
	bh=qYe4TJhxPzN+43IuG5E7bTCpaZFVu2hEwrzs5Bpaqy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEukkbqSW6u4fQEqc6dmNnQCwikvMBt+XURv7l0Ywh3UIkUmZpj8U0I4tEJbEBBApp1XSy4fw/iVzEwQF5q2E0azorZVDCeAe9QIm4w/FNKJ7lAponVA4OI6NucB0cZRm7jCKGb+6NqRR53i0vIzyIiDy+KJtIShmpNSue6eafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wqIMmWmd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AF04A20891;
	Tue, 18 Nov 2025 10:26:22 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vpCnwrI7O9R3; Tue, 18 Nov 2025 10:26:22 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 19D4C20890;
	Tue, 18 Nov 2025 10:26:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 19D4C20890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763457982;
	bh=F69NdEVrZZzXKj5S65gM2lWJxdy2HWqntIR5CjFIjb4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=wqIMmWmdORWPS4Ohtpc6MOs2fZ5+3lA46q+wK7Oh0w7Wp8wXS7og0BqrUBDMfcV+7
	 yXHMSAxYz3qT1QZdlET6AHGLLJDRVDk5X24BOBYrUvKiH1gm9fKJJ2eB01eS8b8kRy
	 vr35wazNJ5OrqTjSrA8oi2e0Rhg20kQaJz2qzeHUpBEKOmjTw+csDQi0r8WAWUYHMN
	 ZBKu+RP1bjPcein5AKTPfQx8KGpu8zY5OkYv3TPrYyjvgzRakfQu4c8ZWcPKxHdXUS
	 dUwZDkvw6SStAsZ1t++6WG1M6THryKd5AJ88nL3/pTw+T7Y7Dga6bcNv8Urc1Y3Vqj
	 Z+oMcwaqZJWYA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:26:21 +0100
Received: (nullmailer pid 2223959 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/12] xfrm: Skip redundant replay recheck for the hardware offload path
Date: Tue, 18 Nov 2025 10:25:39 +0100
Message-ID: <20251118092610.2223552-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118092610.2223552-1-steffen.klassert@secunet.com>
References: <20251118092610.2223552-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Jianbo Liu <jianbol@nvidia.com>

The xfrm_replay_recheck() function was introduced to handle the issues
arising from asynchronous crypto algorithms.

The crypto offload path is now effectively synchronous, as it holds
the state lock throughout its operation. This eliminates the race
condition, making the recheck an unnecessary overhead. This patch
improves performance by skipping the redundant call when
crypto_done is true.

Additionally, the sequence number assignment is moved to an earlier
point in the function. This improves performance by reducing lock
contention and places the logic at a more appropriate point, as the
full sequence number (including the higher-order bits) can be
determined as soon as the packet is received.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 257935cbd221..4ed346e682c7 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -546,7 +546,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			nexthdr = x->type_offload->input_tail(x, skb);
 		}
 
-		goto lock;
+		goto process;
 	}
 
 	family = XFRM_SPI_SKB_CB(skb)->family;
@@ -614,7 +614,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-lock:
+process:
+		seq_hi = htonl(xfrm_replay_seqhi(x, seq));
+
+		XFRM_SKB_CB(skb)->seq.input.low = seq;
+		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
+
 		spin_lock(&x->lock);
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
@@ -646,11 +651,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop_unlock;
 		}
 
-		seq_hi = htonl(xfrm_replay_seqhi(x, seq));
-
-		XFRM_SKB_CB(skb)->seq.input.low = seq;
-		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
-
 		if (!crypto_done) {
 			spin_unlock(&x->lock);
 			dev_hold(skb->dev);
@@ -676,7 +676,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* only the first xfrm gets the encap type */
 		encap_type = 0;
 
-		if (xfrm_replay_recheck(x, skb, seq)) {
+		if (!crypto_done && xfrm_replay_recheck(x, skb, seq)) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATESEQERROR);
 			goto drop_unlock;
 		}
-- 
2.43.0


