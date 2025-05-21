Return-Path: <netdev+bounces-192157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDAABEB6F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAE28A0D8F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA4230D0A;
	Wed, 21 May 2025 05:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56F22FDEA
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806238; cv=none; b=iy94dE4BbuDAOKLhsounfrJMZJ5LFDzLsxkt/KSc2wxEIdjJJvWYzvSjOyEHSCHXDvb08plYl+xNIoLa5CeRVJGNOOroBrDlNr7DIbmFu+FeCR3VO5h0SonrOGbfAVHTu+YhJJ5egMgHPKg3K7g7WC/wNz58utzz3ieBLnhyaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806238; c=relaxed/simple;
	bh=7Kc47lTY4LePCA7ibacu8iRyJ5wdidF/eR8SOAbvo+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYoqZ8+lThV6kT/i4rt+YOfeQr8fkQGze5zjoqKHv1peiQdRRe0qt59UFZ4D4NcsYTa7YfcIT1uF2E2KuAXDpaEFra8PqZuGQDtrx+4hUj2U9qH/kl2IGK59veyFzuPndopi5XUBoy3xxppwznsRdykl4SNX8YQ4BoPPLDYq4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 206DB20754;
	Wed, 21 May 2025 07:43:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x490WpwXPCOM; Wed, 21 May 2025 07:43:52 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 662BB2074F;
	Wed, 21 May 2025 07:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 662BB2074F
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 21 May
 2025 07:43:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 07:43:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 17D4D3182B01; Wed, 21 May 2025 07:43:50 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/5] xfrm: Fix UDP GRO handling for some corner cases
Date: Wed, 21 May 2025 07:43:46 +0200
Message-ID: <20250521054348.4057269-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521054348.4057269-1-steffen.klassert@secunet.com>
References: <20250521054348.4057269-1-steffen.klassert@secunet.com>
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

From: Tobias Brunner <tobias@strongswan.org>

This fixes an issue that's caused if there is a mismatch between the data
offset in the GRO header and the length fields in the regular sk_buff due
to the pskb_pull()/skb_push() calls.  That's because the UDP GRO layer
stripped off the UDP header via skb_gro_pull() already while the UDP
header was explicitly not pulled/pushed in this function.

For example, an IKE packet that triggered this had len=data_len=1268 and
the data_offset in the GRO header was 28 (IPv4 + UDP).  So pskb_pull()
was called with an offset of 28-8=20, which reduced len to 1248 and via
pskb_may_pull() and __pskb_pull_tail() it also set data_len to 1248.
As the ESP offload module was not loaded, the function bailed out and
called skb_push(), which restored len to 1268, however, data_len remained
at 1248.

So while skb_headlen() was 0 before, it was now 20.  The latter caused a
difference of 8 instead of 28 (or 0 if pskb_pull()/skb_push() was called
with the complete GRO data_offset) in gro_try_pull_from_frag0() that
triggered a call to gro_pull_from_frag0() that corrupted the packet.

This change uses a more GRO-like approach seen in other GRO receivers
via skb_gro_header() to just read the actual data we are interested in
and does not try to "restore" the UDP header at this point to call the
existing function.  If the offload module is not loaded, it immediately
bails out, otherwise, it only does a quick check to see if the packet
is an IKE or keepalive packet instead of calling the existing function.

Fixes: 172bf009c18d ("xfrm: Support GRO for IPv4 ESP in UDP encapsulation")
Fixes: 221ddb723d90 ("xfrm: Support GRO for IPv6 ESP in UDP encapsulation")
Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/xfrm4_input.c | 18 ++++++++++--------
 net/ipv6/xfrm6_input.c | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index b5b06323cfd9..0d31a8c108d4 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -182,11 +182,15 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	int offset = skb_gro_offset(skb);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
-	int ret;
-
-	offset = offset - sizeof(struct udphdr);
+	int len, dlen;
+	__u8 *udpdata;
+	__be32 *udpdata32;
 
-	if (!pskb_pull(skb, offset))
+	len = skb->len - offset;
+	dlen = offset + min(len, 8);
+	udpdata = skb_gro_header(skb, dlen, offset);
+	udpdata32 = (__be32 *)udpdata;
+	if (unlikely(!udpdata))
 		return NULL;
 
 	rcu_read_lock();
@@ -194,11 +198,10 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
-	ret = __xfrm4_udp_encap_rcv(sk, skb, false);
-	if (ret)
+	/* check if it is a keepalive or IKE packet */
+	if (len <= sizeof(struct ip_esp_hdr) || udpdata32[0] == 0)
 		goto out;
 
-	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
@@ -208,7 +211,6 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 
 out:
 	rcu_read_unlock();
-	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->same_flow = 0;
 	NAPI_GRO_CB(skb)->flush = 1;
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 4abc5e9d6322..841c81abaaf4 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -179,14 +179,18 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	int offset = skb_gro_offset(skb);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
-	int ret;
+	int len, dlen;
+	__u8 *udpdata;
+	__be32 *udpdata32;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return xfrm4_gro_udp_encap_rcv(sk, head, skb);
 
-	offset = offset - sizeof(struct udphdr);
-
-	if (!pskb_pull(skb, offset))
+	len = skb->len - offset;
+	dlen = offset + min(len, 8);
+	udpdata = skb_gro_header(skb, dlen, offset);
+	udpdata32 = (__be32 *)udpdata;
+	if (unlikely(!udpdata))
 		return NULL;
 
 	rcu_read_lock();
@@ -194,11 +198,10 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
-	ret = __xfrm6_udp_encap_rcv(sk, skb, false);
-	if (ret)
+	/* check if it is a keepalive or IKE packet */
+	if (len <= sizeof(struct ip_esp_hdr) || udpdata32[0] == 0)
 		goto out;
 
-	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
@@ -208,7 +211,6 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 
 out:
 	rcu_read_unlock();
-	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->same_flow = 0;
 	NAPI_GRO_CB(skb)->flush = 1;
 
-- 
2.34.1


