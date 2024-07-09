Return-Path: <netdev+bounces-110107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B097392B009
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199C6B20A1C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06D13AA4D;
	Tue,  9 Jul 2024 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uw83fab+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AB137775
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506229; cv=none; b=C+SorTJNVnUeH8FBOYPMJn07TvxIgvspWniY7MAIjayJ0egV8SOvmaRkzwjIAdUg7cpu1i0jnAbSE//qpJtJzTPke5NPeCvCDusg/cBIGtPnosAmYpQuAyjYNXTins+dTJZAUrilbO6DRDt6A4+/bHdVBjTU8xLD0KrJ3L7dIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506229; c=relaxed/simple;
	bh=fvpTZTkC0144XgY0xDFgf+dUI0rwkqhzRTfazGyTAg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c5/mtlQtNeUCg7A5rZWBj4zGvi013dOHilcjV3X+2Epc75q/4LMn02D6PVdaQG0wxOCvEZOdEpwhPnPi5Y1e00YqPU5JGnQG6To+SCh9NNg/fTD0WRjDJKkEHoX85YDG3YXG2TpPFKrBaXzzcwOutlDmPmLQm1Ku65DeqUUIncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uw83fab+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0360f8d773so8354760276.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 23:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720506226; x=1721111026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZHu+GdNMiKtnxtQETzAPgrNeDiM2cwjRzDmck39LRE=;
        b=uw83fab+qBjCPZ9pnPtM1vup1MG2b6DQoWeCw+k8OnEbEO1xDrZ1tnEyErqU4Y69Hm
         UUoNHuLXfBdDcF6oTCRmD4AxTF4VmQbogP/eZt4lbfCUAspssKQsGbmApHXSNmso58Ee
         Ap13LouGdnZQjhCtguC5N4hX9M/BGuNdZtodTHUUWSuaqKDTVaFxfIHXYe/5UePVrNgn
         ej1GSF87aKmfSjy2JuF2dqKYepEujiJNOyZWTvNKNbTiahq6b1KyvJY7Jh/PpM8NHKAL
         M2bAgbyw4BVBwy6/RTAFEoHd1jHdlsOxlmXvAcy3WAmLIolBEj25ZjCANwXInagdZLGy
         DLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506226; x=1721111026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZHu+GdNMiKtnxtQETzAPgrNeDiM2cwjRzDmck39LRE=;
        b=xGno7AJgj2gpFsvOAbGXDYzSh3H3LxZIt15fTpQmY58MZvokzIWcX2z7w24AHrLIJZ
         tjWwlKmSHjnGV5P+WL6la/LXbndU0rPWLnB5XNhspla+2Jw7x9LzAr7ks5A7GrDgybev
         edKtzlcwH9cyM54TRHAKongEmi07VTV+vAbgViEGlEpTHgrrO+DdFey/WSNSjEv2+SbT
         q/6f4/nsXgozg6GBGg+i3mbXKkgfIwdO4r4sotlXSjWA+ZfFXAQ3h+1iL1AL1Ll/YFtp
         OKi5X6Sg0XVJULZIKMIfK60EeuCfApmPbEcsI/gsa2BE5lUypK7EuIaIKL1w8J7e6jtP
         T0gg==
X-Gm-Message-State: AOJu0YyuxUxx77WP4z59FnUiIKtzRHk9Kn0j5KM19dmeuDRFQDMIr1tA
	C6tbHwF30vNUShJ3V8N7ne9DtLJUfuzELKO1Py6YfTYkoPgqL2WtEX+hRRNcsWRCMipL5NsUL2Z
	Otbd7MEjyFXZCqBRAGO0gcNT47R1ODbKYSN55qLSShlI9f0EF8cxbzVBl68ZvMTon/TCln5APSX
	GxATjpo1liUDXYLmkyouDdiL46qj1vz7gI
X-Google-Smtp-Source: AGHT+IED3GopilEEe0cFM4fw69eQASb02qJkPFvZd2W9cWpkyzzKNUSEJ33jnzSrdhJkUMw1hhf7n2EOx5c=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:1007:b0:e03:510d:3b6e with SMTP id
 3f1490d57ef6-e041b02f9efmr79205276.3.1720506226368; Mon, 08 Jul 2024 23:23:46
 -0700 (PDT)
Date: Tue,  9 Jul 2024 14:23:26 +0800
In-Reply-To: <20240709062326.939083-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709062326.939083-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709062326.939083-5-yumike@google.com>
Subject: [PATCH ipsec v2 4/4] xfrm: Support crypto offload for outbound IPv4
 UDP-encapsulated ESP packet
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: yumike@google.com, stanleyjhu@google.com, martinwu@google.com, 
	chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"

esp_xmit() is already able to handle UDP encapsulation through the call to
esp_output_head(). The missing part in esp_xmit() is to correct the outer
IP header.

Test: Enabled both dir=in/out IPsec crypto offload, and verified IPv4
      UDP-encapsulated ESP packets on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
---
v1->v2: https://lore.kernel.org/all/20240702084452.2259237-5-yumike@google.com
- Fix comment style.
---
 net/ipv4/esp4.c         |  8 +++++++-
 net/ipv4/esp4_offload.c | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

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
index b3271957ad9a..60fb58a2e321 100644
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
@@ -324,6 +327,16 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
 
+	if (hw_offload && encap_type == UDP_ENCAP_ESPINUDP) {
+		/* In the XFRM stack, the encapsulation protocol is set to iphdr->protocol by
+		 * setting *skb_mac_header(skb) (see esp_output_udp_encap()) where skb->mac_header
+		 * points to iphdr->protocol (see xfrm4_tunnel_encap_add()).
+		 * However, in esp_xmit(), skb->mac_header doesn't point to iphdr->protocol.
+		 * Therefore, the protocol field needs to be corrected.
+		 */
+		ip_hdr(skb)->protocol = IPPROTO_UDP;
+	}
+
 	ip_hdr(skb)->tot_len = htons(skb->len);
 	ip_send_check(ip_hdr(skb));
 
-- 
2.45.2.803.g4e1b14247a-goog


