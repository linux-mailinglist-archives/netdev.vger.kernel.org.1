Return-Path: <netdev+bounces-239452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20CC68863
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1660365147
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BEC313E36;
	Tue, 18 Nov 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xYofhEgs"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62E2741A6
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457981; cv=none; b=A8NNEGgk5uL40zHQFb3QTz7S8c4BeOAqZTGtUY5FwRSc2W0gpM6kFl44NSCQqBwdldCZ5DYLeZnYTekdkFFWSGKK2j6EL7lKf/mExtxHoa12pwj9t/eEqxNPArf9ma49Ch6A/Q2NUDtGOZUWZs7vrUl1eCp5xbWz3EAPWf2sHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457981; c=relaxed/simple;
	bh=5W9mPEFRfYy6NR4BZC64VM6QBF33VMepSqlQi0nrqN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xigu2fVrMWOhZzXPANLL6gwxhjRAVwA5LLq7PRz70OkXiuYZDglsKrfRLBlpz2UYK7Y5olbjj0Zu+1FeInBgjZyB4/A23QHUdOKWYLs8BHuCe+1FRvAzEfW5wzfmNV+IVNcU6OSISJc5dq+Ja7SQgHQcWmGSs94IiZIvJrYJd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xYofhEgs; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 77F94207B2;
	Tue, 18 Nov 2025 10:26:17 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EgIxj9Fgdzs; Tue, 18 Nov 2025 10:26:16 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AC29D2085F;
	Tue, 18 Nov 2025 10:26:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AC29D2085F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763457975;
	bh=p98DyCB65D5TUAYdin1vQ14FrfVrsS6kErvOGC54bDQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=xYofhEgsZXuxVp7Hkx8/apY8U+ih8TMeEngtDJhqejgdEOJEY0BJENVQ8M3sA7J1V
	 z8jUznDmO8zkqinzT498KSCZ3je+lHMfUnFy+FzB783CrK9+by0ZFrj15zdYrQtthM
	 PqJSifZiCjzWFrRV8n574nI8sskDN4MrYx5s2//RMrvuSFy7/RxQSB51OBFg+T6NDw
	 laPgSL71p/DfSLFMm2Wu/TvvTMEIv1QSHe8mqolGkxFVzlIqpWE3NffVO79ZL0waa6
	 JmtG+fC/oyjpf9+h0o1YgpCdTFl+zUeMKR0UFDkdrv45fSlo6oGHq0PTtAQF17slDv
	 woKMhcNEc7Tew==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:26:15 +0100
Received: (nullmailer pid 2223956 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/12] xfrm: Refactor xfrm_input lock to reduce contention with RSS
Date: Tue, 18 Nov 2025 10:25:38 +0100
Message-ID: <20251118092610.2223552-2-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Jianbo Liu <jianbol@nvidia.com>

With newer NICs like mlx5 supporting RSS for IPsec crypto offload,
packets for a single Security Association (SA) are scattered across
multiple CPU cores for parallel processing. The xfrm_state spinlock
(x->lock) is held for each packet during xfrm processing.

When multiple connections or flows share the same SA, this parallelism
causes high lock contention on x->lock, creating a performance
bottleneck and limiting scalability.

The original xfrm_input() function exacerbated this issue by releasing
and immediately re-acquiring x->lock. For hardware crypto offload
paths, this unlock/relock sequence is unnecessary and introduces
significant overhead. This patch refactors the function to relocate
the type_offload->input_tail call for the offload path, performing all
necessary work while continuously holding the lock. This reordering is
safe, since packets which don't pass the checks below will still fail
them with the new code.

Performance testing with iperf using multiple parallel streams over a
single IPsec SA shows significant improvement in throughput as the
number of queues (and thus CPU cores) increases:

+-----------+---------------+--------------+-----------------+
| RX queues | Before (Gbps) | After (Gbps) | Improvement (%) |
+-----------+---------------+--------------+-----------------+
|         2 |          32.3 |         34.4 |             6.5 |
|         4 |          34.4 |         40.0 |            16.3 |
|         6 |          24.5 |         38.3 |            56.3 |
|         8 |          23.1 |         38.3 |            65.8 |
|        12 |          18.1 |         29.9 |            65.2 |
|        16 |          16.0 |         25.2 |            57.5 |
+-----------+---------------+--------------+-----------------+

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index c9ddef869aa5..257935cbd221 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -505,6 +505,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			async = 1;
 			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
+			spin_lock(&x->lock);
 			goto resume;
 		}
 		/* GRO call */
@@ -541,6 +542,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
 				goto drop;
 			}
+
+			nexthdr = x->type_offload->input_tail(x, skb);
 		}
 
 		goto lock;
@@ -638,11 +641,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop_unlock;
 		}
 
-		spin_unlock(&x->lock);
-
 		if (xfrm_tunnel_check(skb, x, family)) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
-			goto drop;
+			goto drop_unlock;
 		}
 
 		seq_hi = htonl(xfrm_replay_seqhi(x, seq));
@@ -650,9 +651,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		if (crypto_done) {
-			nexthdr = x->type_offload->input_tail(x, skb);
-		} else {
+		if (!crypto_done) {
+			spin_unlock(&x->lock);
 			dev_hold(skb->dev);
 
 			nexthdr = x->type->input(x, skb);
@@ -660,9 +660,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				return 0;
 
 			dev_put(skb->dev);
+			spin_lock(&x->lock);
 		}
 resume:
-		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
 				xfrm_audit_state_icvfail(x, skb,
-- 
2.43.0


