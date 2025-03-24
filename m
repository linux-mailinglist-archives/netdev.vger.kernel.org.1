Return-Path: <netdev+bounces-177017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF8A6D41D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E447A5C9B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3021993B7;
	Mon, 24 Mar 2025 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fEzFW2oC"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775D84037
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797153; cv=none; b=jbdXkOaVysuUf9Th7JP/vHDFwtqMidBoO32NeMgXSU5Y+IRyhaYxOEzfYQ3qnJd9aZzx94LNqiPgoRNINoPPQ5TDeYaixcu4z6BNM3kQ3v9E+VnVfVhq5nSmSRd6Z6GBCQfPJGqtFNtrGqMKLillodBwBz3zzBS795g+qHrVV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797153; c=relaxed/simple;
	bh=ya3ifQeqW/FORrUjcYnaoCbh1gRLleNuYoZw4vZdxhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU93ZlET76eAO1+kd1i6Ww6xpYKyaODiQNQ/8w4IJ3n2T3yvvfpqHTbVZb4scEgbJOSxRUiMJTptAyqBcm+yB+SklcB2MpWv/YaK3MOMzsiTumAOso5SHo4h/ul/+QJ061KA0W9aDVBkruxn35JKBEqjAyaiXtOd/Mwt2oAb2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fEzFW2oC; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 02A42207B2;
	Mon, 24 Mar 2025 07:19:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v_iyCHrsVcgf; Mon, 24 Mar 2025 07:19:01 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 73B4A2074F;
	Mon, 24 Mar 2025 07:18:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 73B4A2074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742797139;
	bh=jHqELCdYMo5nBvqpUAbyaGLkibfv3Aj0mudeEbfGspk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=fEzFW2oC8R2m7rni5WEpNVWVsEwzma8WPfg2ofedb5ODlzfMMX1NxFIDRgAgWSvCj
	 tOYey7jTkKF6QwnX0uxH0N3z2WrC57npQm5zr5tGvMIEiIcSozF4BmFQtycNgck+zP
	 vHTxqJiVFILFZ7GZHFBVAKfljTO2rhzU432wHPjlV89g/5JBhIxpxu+qd/Xvoq3950
	 BFNuC3WEAc3iz6BZ8WA9SpJbrsZYEr6j4adeUVgwJx6rtOJ4HW0qYf2D1Ll36gapHU
	 aK0DXG4Y8qzQIqYaVUao8N8r9lAK3Jbz3pAwaJCHV/bhQ6l1n935kD5i5LSRfm4ax/
	 TBq9YtwAEsSfw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 07:18:59 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 07:18:58 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 89F4E3182FE0; Mon, 24 Mar 2025 07:18:57 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 6/8] xfrm: check for PMTU in tunnel mode for packet offload
Date: Mon, 24 Mar 2025 07:18:53 +0100
Message-ID: <20250324061855.4116819-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324061855.4116819-1-steffen.klassert@secunet.com>
References: <20250324061855.4116819-1-steffen.klassert@secunet.com>
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

From: Leon Romanovsky <leonro@nvidia.com>

In tunnel mode, for the packet offload, there were no PMTU signaling
to the upper level about need to fragment the packet. As a solution,
call to already existing xfrm[4|6]_tunnel_check_size() to perform that.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     |  9 +++++++++
 net/xfrm/xfrm_device.c | 10 ++++++++--
 net/xfrm/xfrm_output.c |  6 ++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 15997374a594..39365fd2ea17 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1781,6 +1781,15 @@ int xfrm_trans_queue(struct sk_buff *skb,
 				   struct sk_buff *));
 int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err);
 int xfrm_output(struct sock *sk, struct sk_buff *skb);
+int xfrm4_tunnel_check_size(struct sk_buff *skb);
+#if IS_ENABLED(CONFIG_IPV6)
+int xfrm6_tunnel_check_size(struct sk_buff *skb);
+#else
+static inline int xfrm6_tunnel_check_size(struct sk_buff *skb)
+{
+	return -EMSGSIZE;
+}
+#endif
 
 #if IS_ENABLED(CONFIG_NET_PKTGEN)
 int pktgen_xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index f9d985ef30f2..d62f76161d83 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -418,12 +418,12 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct dst_entry *dst = skb_dst(skb);
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
+	bool check_tunnel_size;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
 		return false;
 
-	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-	    ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm)) {
+	if ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm) {
 		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
 		if (skb->len <= mtu)
 			goto ok;
@@ -435,16 +435,22 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
+	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
+			    x->props.mode == XFRM_MODE_TUNNEL;
 	switch (x->props.family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
 			return false;
+		if (check_tunnel_size && xfrm4_tunnel_check_size(skb))
+			return false;
 		break;
 	case AF_INET6:
 		/* Check for IPv6 extensions */
 		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
 			return false;
+		if (check_tunnel_size && xfrm6_tunnel_check_size(skb))
+			return false;
 		break;
 	default:
 		break;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f7abd42c077d..34c8e266641c 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -786,7 +786,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(xfrm_output);
 
-static int xfrm4_tunnel_check_size(struct sk_buff *skb)
+int xfrm4_tunnel_check_size(struct sk_buff *skb)
 {
 	int mtu, ret = 0;
 
@@ -812,6 +812,7 @@ static int xfrm4_tunnel_check_size(struct sk_buff *skb)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xfrm4_tunnel_check_size);
 
 static int xfrm4_extract_output(struct xfrm_state *x, struct sk_buff *skb)
 {
@@ -834,7 +835,7 @@ static int xfrm4_extract_output(struct xfrm_state *x, struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static int xfrm6_tunnel_check_size(struct sk_buff *skb)
+int xfrm6_tunnel_check_size(struct sk_buff *skb)
 {
 	int mtu, ret = 0;
 	struct dst_entry *dst = skb_dst(skb);
@@ -864,6 +865,7 @@ static int xfrm6_tunnel_check_size(struct sk_buff *skb)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xfrm6_tunnel_check_size);
 #endif
 
 static int xfrm6_extract_output(struct xfrm_state *x, struct sk_buff *skb)
-- 
2.34.1


