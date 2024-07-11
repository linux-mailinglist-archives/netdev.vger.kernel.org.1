Return-Path: <netdev+bounces-110777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB12D92E438
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822A5289340
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C1A1581F9;
	Thu, 11 Jul 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="d12HNpnr"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B23157E9F
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692541; cv=none; b=ler6fZ9R4EkAoDgyw7JsyMR0QNN0cP3M7MBnsvSsELvD7k4bWBONbRsaU6oV7nMcWV2219Z4X310oFJWebtjhd354E89mQKG8YI+UkGYQmbe1RWbPcEbsIvXH3k8k4Gf/gCoVS6Pn/ozpbzUld/IAtvrzarNgvKhPydp7pQUrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692541; c=relaxed/simple;
	bh=Rt/UpJMUeOImssfQkgr4GMl6BPXRmjYMf9cVowA5TRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOeOA1FhETb62GTsvxg2ZGbMHzSwiez6zXwopgpXm/qV8/3F60Yn1Kkl0quLV6ny8f3cGt1hAwdY6KeoyPwyYzGhrj41zVOKuoaa8xTlHktBov0otv9+2b6jrWQlFOQxBrv0MTGjkzExyXoqIioGjo7FF/nPKmnQTUPY+b6kLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=d12HNpnr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EB7882084C;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2Ajt7S8JCrC; Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0E9A0207C6;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0E9A0207C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720692032;
	bh=fNHF1Aj9l56mIGdRQSObktt1JRejYDTjm8z6Dj2pmmE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=d12HNpnrpS+/lzrBl+2+9QVjR/wIA94+RWl6P7ScNcThXfOl4O36SWo7sxFQoQ3m4
	 4NoeLFZcTNSf5RufYt+4GxAeryjST2PBX9yAoidlzkcJ76KSyOA1yzphb9Ilkp9Hxs
	 qjWO4bbkbVd3kAnT79BX6lawI1h1aAsE3r1VeLjg3ALxCMVpaSZPEzwjx28D0i4Q1g
	 DZ6ZGMEr7jU8hjVUQeBG4jjB0San1/7jLzmF5+qJXazFvtJOLzkM8axLf473eBIvN4
	 KF8i//bdqXos53uxjnkt9C2bTZdqERbyKforqEkv3YfISW4fIcXTf40ttIdxPhCNPl
	 jMHc8atq/IHVA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 0095180004A;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 12:00:31 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 12:00:31 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0B99C3182CA2; Thu, 11 Jul 2024 12:00:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/7] xfrm: Log input direction mismatch error in one place
Date: Thu, 11 Jul 2024 12:00:21 +0200
Message-ID: <20240711100025.1949454-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711100025.1949454-1-steffen.klassert@secunet.com>
References: <20240711100025.1949454-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Antony Antony <antony.antony@secunet.com>

Previously, the offload data path decrypted the packet before checking
the direction, leading to error logging and packet dropping. However,
dropped packets wouldn't be visible in tcpdump or audit log.

With this fix, the offload path, upon noticing SA direction mismatch,
will pass the packet to the stack without decrypting it. The L3 layer
will then log the error, audit, and drop ESP without decrypting or
decapsulating it.

This also ensures that the slow path records the error and audit log,
making dropped packets visible in tcpdump.

Fixes: 304b44f0d5a4 ("xfrm: Add dir validation to "in" data path lookup")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4_offload.c | 7 +++++++
 net/ipv6/esp6_offload.c | 7 +++++++
 net/xfrm/xfrm_input.c   | 5 -----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index b3271957ad9a..3f28ecbdcaef 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -56,6 +56,13 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
 				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
 				      spi, IPPROTO_ESP, AF_INET);
+
+		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			/* non-offload path will record the error and audit log */
+			xfrm_state_put(x);
+			x = NULL;
+		}
+
 		if (!x)
 			goto out_reset;
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 527b7caddbc6..919ebfabbe4e 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -83,6 +83,13 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
 				      (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
 				      spi, IPPROTO_ESP, AF_INET6);
+
+		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			/* non-offload path will record the error and audit log */
+			xfrm_state_put(x);
+			x = NULL;
+		}
+
 		if (!x)
 			goto out_reset;
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 63c004103912..e95462b982b0 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -474,11 +474,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	if (encap_type < 0 || (xo && xo->flags & XFRM_GRO)) {
 		x = xfrm_input_state(skb);
 
-		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEDIRERROR);
-			goto drop;
-		}
-
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMACQUIREERROR);
-- 
2.34.1


