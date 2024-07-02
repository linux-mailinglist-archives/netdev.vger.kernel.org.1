Return-Path: <netdev+bounces-108365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7609923855
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B471C2230D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A13150987;
	Tue,  2 Jul 2024 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cN0rcVp7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDC55C1A
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909917; cv=none; b=k9YZt/MhAc2i37ZcSfhSqvckoaXz7BcXXqSchDaAJ4XuMEC2Mg4lHFH/NXVDfNcVquadLClU53nwlUTTJre+7VqMYVLYNhoshvyndvQSlXZnZPGWcHGXhTcyK1SR1jr+7MDx/hf/pFZ/3fGyXPyeUUjgfeQh2WRtMUmU4RrAgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909917; c=relaxed/simple;
	bh=Au1Mxoq0dOSVwMhbNvubqJYaXs1cEOtuXfPknsWQRI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ky3pStI9XwBK6RkA+s3VhalmR9OlePlAkoPP7X9EkLI+O5PfWfw/L8VVN9U6H9P2YEkdq340Bx0PstVtYcqbqZfQwq8IqefEKRr44aKpPN+GMd3BsFgNe2I3i9R2R1yj3QNP31Fe1KKZmyb9bxulBkEj13mzFBAw24DfWoDWkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cN0rcVp7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64aac532a60so67197237b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719909915; x=1720514715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6fZgcTM+CTMpnrUlEpBkATHgtZKfVVC2EZUby1pMxk=;
        b=cN0rcVp7BsS2MW6WW0qefpvGToCrWLaJz6AZyZB9kJtkIr9Kt06VdrBhPtJOvviyQD
         a7yGML/GBbOyHZHRu6gmBpxEm/g2wdkcM+yZZPYJVs/Q7qCQM8WsRtIuf+lT/ymCj4ny
         Iykd36AwABmqabFXfzamosm5G3/dOZLdCJtIQaNK7x9ru/147ce1w2QcSTBRQp3Ck+nG
         ngvMde5vqenGNZUxuPkyZIqZdjW4V0Pg+4V0qItXEbZSeaLfwjb0Nh/IVBH/ptOUOW/u
         EZ1qg6R8HUhRpvt34JyEQD/l3G80aImFVh1B4bER9Ut30AaTG7F67Dkqu8aneJjeq7Di
         EAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719909915; x=1720514715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6fZgcTM+CTMpnrUlEpBkATHgtZKfVVC2EZUby1pMxk=;
        b=tJMIoU+WIYDMuQhuG1w31yd/ohWzt/vfL+lNxCG7glhF9ikXi1/R1Z2biXwG0butww
         KnGGaVkdnG0TLG3LbrotaeltGSlJlWv7vguUMfrHLZDheqI/YnnTbW9pGGLK6TLAhRV6
         ddQ0w6xwvb3FaPO+B/HOWNJBzK3x7RtlHNfpKtMGleX2NcTXa9TolW5UFTv66JofPHwJ
         wX7VVU4i4gy8Z4pCJ10+HaW5n2Uiji9D4Eoj2yWMmw+fzw+wfjIfJ+301k4EHRz5LK3e
         nbzm1Q2bcvcC52TqhovX3IP7oQthmhWos8bfq+6fPQ0LX3IGL/gCkHbfJZH1qy3vCXa6
         BaeQ==
X-Gm-Message-State: AOJu0Yzttr75dSM6Zh1vzjNETz3asMRVTEVS3h4QjHehThbgM26lDsQl
	6JJfAAdpw1g5uTJnyGf0BYb7Kt+RGp4kSIofk/RcQpZdsxdS8+PDIhRLAadNWN0gLzWGAVHOnp/
	Ys3yxTjgFV1McuGWqVXCl6CjFun37X0HkrG0nEigitGgqEsUYreGQ2/02BaaKNFiGwVKmmsph2F
	ESefyi/B2QkLuHtJpE/plJwpwAejGLcgIi
X-Google-Smtp-Source: AGHT+IEaVjUEmum0spKNwzTbd7P5NG91PMIN8gv+thMp//lWw2455Q7H1Ss9+K+SNJMOAvRd7YQ2YP5x3Og=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:1806:b0:e03:a2f7:71d with SMTP id
 3f1490d57ef6-e03a2f70e66mr12772276.0.1719909915084; Tue, 02 Jul 2024 01:45:15
 -0700 (PDT)
Date: Tue,  2 Jul 2024 16:44:51 +0800
In-Reply-To: <20240702084452.2259237-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702084452.2259237-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702084452.2259237-5-yumike@google.com>
Subject: [PATCH ipsec 4/4] xfrm: Support crypto offload for outbound IPv4
 UDP-encapsulated ESP packet
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

esp_xmit() is already able to handle UDP encapsulation through the call to
esp_output_head(). The missing part in esp_xmit() is to correct the outer
IP header.

Test: Enabled both dir=in/out IPsec crypto offload, and verified IPv4
      UDP-encapsulated ESP packets on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/ipv4/esp4.c         |  7 ++++++-
 net/ipv4/esp4_offload.c | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 3968d3f98e08..cd4b52e131ce 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -349,6 +349,7 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
 {
 	struct udphdr *uh;
 	unsigned int len;
+	struct xfrm_offload *xo = xfrm_offload(skb);
 
 	len = skb->len + esp->tailen - skb_transport_offset(skb);
 	if (len + sizeof(struct iphdr) > IP_MAX_MTU)
@@ -360,7 +361,11 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
 	uh->len = htons(len);
 	uh->check = 0;
 
-	*skb_mac_header(skb) = IPPROTO_UDP;
+	// For IPv4 ESP with UDP encapsulation, if xo is not null, the skb is in the crypto offload
+	// data path, which means that esp_output_udp_encap is called outside of the XFRM stack.
+	// In this case, the mac header doesn't point to the IPv4 protocol field, so don't set it.
+	if (!xo || encap_type != UDP_ENCAP_ESPINUDP)
+		*skb_mac_header(skb) = IPPROTO_UDP;
 
 	return (struct ip_esp_hdr *)(uh + 1);
 }
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index b3271957ad9a..ccfc466ddf6c 100644
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
@@ -324,6 +327,15 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
 
+	if (hw_offload && encap_type == UDP_ENCAP_ESPINUDP) {
+		// In the XFRM stack, the encapsulation protocol is set to iphdr->protocol by
+		// setting *skb_mac_header(skb) (see esp_output_udp_encap()) where skb->mac_header
+		// points to iphdr->protocol (see xfrm4_tunnel_encap_add()).
+		// However, in esp_xmit(), skb->mac_header doesn't point to iphdr->protocol.
+		// Therefore, the protocol field needs to be corrected.
+		ip_hdr(skb)->protocol = IPPROTO_UDP;
+	}
+
 	ip_hdr(skb)->tot_len = htons(skb->len);
 	ip_send_check(ip_hdr(skb));
 
-- 
2.45.2.803.g4e1b14247a-goog


