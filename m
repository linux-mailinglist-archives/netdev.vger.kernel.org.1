Return-Path: <netdev+bounces-111235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52DE930522
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 12:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D711C21134
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF913247D;
	Sat, 13 Jul 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="aOCEu/m1"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A32130AC8
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866273; cv=none; b=kJX01ZS7OHVQA7kVC85ZEKDTpS1hJn9XOB2eaI7DZzKQMrNudzLfSFW9ABUh8Fi1LANUMKfMUqOZt2t+TykqYXMzffvAGHTxGjAH9ugJzwwCBeGcyGqG9B/j2xMej/mz6Lp8KjOJr8kQPVnJMF2S+AqQpddI7oB97lCKeLdOnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866273; c=relaxed/simple;
	bh=5eHNvpVHutNTbieW2X35cWR4ydlJpHiOXkexoQ0UHnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dR7FzyswA5I4r43Rk+JJTfWSF0PxFM5kBq0mNvB5vHyFcdfl9zVc2euhUmzgr0J+b0rxEBbKp56QG2Y78nHIK36zs1AMQjdTGK+hpJOyKN9EBje2WaRQd9JDpDqzoH3DIKFleHI2SA2ZCn2s3eIxtkcbCADT4adXDYW5OTDYWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=aOCEu/m1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 485C12087C;
	Sat, 13 Jul 2024 12:24:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PnV8_8NMSLt; Sat, 13 Jul 2024 12:24:26 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EC0DB20754;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EC0DB20754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720866266;
	bh=GIa8Y8S1SJ4aBKnjJqdhcm+uoyyxgMQzUlJ8NWETypA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=aOCEu/m1UQ00GN+AQxtRW0HAA3kQ1256xyQI6SipvFaucGmJjkqJdySsf7yrzSzwo
	 pRsTlC35MffC1zrknnDnBQUAPUzSjSyteEeN4+miPSb178xSsvViLsDX3hmnTxA7l+
	 fqFhkSF62Tw0ZUfdNr/a9EC6Iew4wQI6ye4NcrPJk3xFt9a6W4vfi1yO6CBvwxBGQv
	 mihm9JYT+Sa2PO7naTcbxgtQsOHijcKMnPCUxq5ESLN9hdSdiT94mq2XaHeLOtq6O9
	 n73b3jf5hRRxYpFEuD1HElWzyLSEglbGehlQe/j54aqqii9D9I16KT7z0eKHF4nJio
	 iOIK3sO9Nt04Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id DFCF980004A;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 12:24:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 13 Jul
 2024 12:24:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5EF2D318401A; Sat, 13 Jul 2024 12:24:24 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/5] xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP packet
Date: Sat, 13 Jul 2024 12:24:16 +0200
Message-ID: <20240713102416.3272997-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713102416.3272997-1-steffen.klassert@secunet.com>
References: <20240713102416.3272997-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Mike Yu <yumike@google.com>

esp_xmit() is already able to handle UDP encapsulation through the call to
esp_output_head(). However, the ESP header and the outer IP header
are not correct and need to be corrected.

Test: Enabled both dir=in/out IPsec crypto offload, and verified IPv4
      UDP-encapsulated ESP packets on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c         |  8 +++++++-
 net/ipv4/esp4_offload.c | 17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 3968d3f98e08..73981595f062 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -349,6 +349,7 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
 {
 	struct udphdr *uh;
 	unsigned int len;
+	struct xfrm_offload *xo = xfrm_offload(skb);
 
 	len = skb->len + esp->tailen - skb_transport_offset(skb);
 	if (len + sizeof(struct iphdr) > IP_MAX_MTU)
@@ -360,7 +361,12 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
 	uh->len = htons(len);
 	uh->check = 0;
 
-	*skb_mac_header(skb) = IPPROTO_UDP;
+	/* For IPv4 ESP with UDP encapsulation, if xo is not null, the skb is in the crypto offload
+	 * data path, which means that esp_output_udp_encap is called outside of the XFRM stack.
+	 * In this case, the mac header doesn't point to the IPv4 protocol field, so don't set it.
+	 */
+	if (!xo || encap_type != UDP_ENCAP_ESPINUDP)
+		*skb_mac_header(skb) = IPPROTO_UDP;
 
 	return (struct ip_esp_hdr *)(uh + 1);
 }
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index b3271957ad9a..a37d18858c72 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -264,6 +264,7 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 	struct esp_info esp;
 	bool hw_offload = true;
 	__u32 seq;
+	int encap_type = 0;
 
 	esp.inplace = true;
 
@@ -296,8 +297,10 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	esp.esph = ip_esp_hdr(skb);
 
+	if (x->encap)
+		encap_type = x->encap->encap_type;
 
-	if (!hw_offload || !skb_is_gso(skb)) {
+	if (!hw_offload || !skb_is_gso(skb) || (hw_offload && encap_type == UDP_ENCAP_ESPINUDP)) {
 		esp.nfrags = esp_output_head(x, skb, &esp);
 		if (esp.nfrags < 0)
 			return esp.nfrags;
@@ -324,6 +327,18 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
 
+	if (hw_offload && encap_type == UDP_ENCAP_ESPINUDP) {
+		/* In the XFRM stack, the encapsulation protocol is set to iphdr->protocol by
+		 * setting *skb_mac_header(skb) (see esp_output_udp_encap()) where skb->mac_header
+		 * points to iphdr->protocol (see xfrm4_tunnel_encap_add()).
+		 * However, in esp_xmit(), skb->mac_header doesn't point to iphdr->protocol.
+		 * Therefore, the protocol field needs to be corrected.
+		 */
+		ip_hdr(skb)->protocol = IPPROTO_UDP;
+
+		esph->seq_no = htonl(seq);
+	}
+
 	ip_hdr(skb)->tot_len = htons(skb->len);
 	ip_send_check(ip_hdr(skb));
 
-- 
2.34.1


