Return-Path: <netdev+bounces-110549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496B92D090
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED87B28844
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB719066E;
	Wed, 10 Jul 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ph76nE2d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995EC190051
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610246; cv=none; b=PhKfy3cYoHTp5jkMeUY8UoMVI6Lrhs8o8Os21OxDQOim/Vko6sQj67wIfu7SYh5RA5I+47r5g490ckIOSKp+kB36oc8Qbzw3DgjCTkqfJRWbfXMgyOemvHRirgppgXwFtsPmD0oHcS6/QMmMSeXtf2u21y/uNJE7UL9Jll4kyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610246; c=relaxed/simple;
	bh=WrtqFERzEJIkzZQo3fRBAxU6zrDUOl/mlBTil4k/bNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OqZy7hatpjwjFuHUCCYlkkewUoeM+9xthRtHMc0vfQzwbI9WabCmF390C1nqfXBQu/QzpxbI7rKGlKQEiLa4hdLm95hNELZ7sVCz94VQkRWQvAaZNePrVicJATNBX97J5eYEisd69S3I1JD1zrENYKpnwG8vkWwiJ5+0FBDp9z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ph76nE2d; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a5534d58so8437703276.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720610243; x=1721215043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCgskX3LFMnRlDKQpiJhgyUXnZTae+zWHxn2qpG7om0=;
        b=Ph76nE2dpzJnZCwrGQWqMPjgrD6Zc/KCVZSOnBH51R4zb0LzqEaas2xzqQ8peZI/B9
         v2OPwrsE4WAQh/wrkjfDJPTWEC3mV9RdBHRh3OyOO/UfGXA3LmVCvxXdcjKb8rHPW+ki
         ydS3mFX9W6bQAObMEjpLJhTSvDq1Apvnu3xD8XjUBBA8YVsTz2VAgfMLz8rO/3xiWsTe
         sdyFXeBuX3o0xD5f7fSs1W0D8cCIgtsBREbp67PH7q+cqR4nGV+uEpoyNRSnuvgzrCRq
         +z5pM3/88JY7UjTHvmidoGLKJ/FrIThWtDleljrt5ug7vEifCBXC4vJyL54/uC5XVql3
         r3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720610243; x=1721215043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCgskX3LFMnRlDKQpiJhgyUXnZTae+zWHxn2qpG7om0=;
        b=jRPg12m6sJXbPAXtxSxqD9Gp5rMLszIkcJ0AHSb3smYBpB4UmS3yjJeSe3nO4g4340
         qrE8fO5BLAycfjKGYODuknJknyHL8XWOLeYpNPtup7U8XJOP8oP1b/DBwTqEjnQYMe87
         qndBOt99it90USz4sY0/sE7iMMMDDbTj1AQRn15W4h7vt1ZvZ1CyBJCoJyBri/kmMePd
         VtgVUi/aZrvrBMlWdUk8rZrkFjcr/o9YAu+ezKij+UxaqtKoeE0WE16RSGoeUM+X9ZIG
         Vw9lTkxVoShT5IVHY1bt4E6DI2ls5MGVgDsZrMQFLfDNqip0iJ3Hz27ZJDHfuUNdUBW/
         xZNA==
X-Gm-Message-State: AOJu0YzWsr5LD08VkThDayTAzCL1bxYVqv6LLK2ChpeX8wj1zpK9X9bN
	PxA0hr/JhOIMeTqXCPqqSY0QjMlwRcSQWSU9uCnz1kxmu+r1fLaSgG8PO1UzZWhbKWbOvS0HdHX
	2ouQH3b/0lcGFcuCz5ca/b/A7dITqMi8vw2F2kZgwI/0p43CQQhtVQZTxaNfB7d9ByNiVZ7Gul2
	zZteY6t+GHmBmmcdX2gKu9TObmDJPSvUs4
X-Google-Smtp-Source: AGHT+IEnS5uR0fvQf6+sDiC+DBrIFAdLWTPed9KtnSQCjl12dzBU/IYVxQJreQSiVLq87dYb6VOAdlX/dLU=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:114b:b0:e05:70c2:b907 with SMTP id
 3f1490d57ef6-e0570c2bcb5mr222276.4.1720610243048; Wed, 10 Jul 2024 04:17:23
 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:16:54 +0800
In-Reply-To: <20240710111654.4085575-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710111654.4085575-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710111654.4085575-5-yumike@google.com>
Subject: [PATCH ipsec v3 4/4] xfrm: Support crypto offload for outbound IPv4
 UDP-encapsulated ESP packet
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: yumike@google.com, stanleyjhu@google.com, martinwu@google.com, 
	chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"

esp_xmit() is already able to handle UDP encapsulation through the call to
esp_output_head(). However, the ESP header and the outer IP header
are not correct and need to be corrected.

Test: Enabled both dir=in/out IPsec crypto offload, and verified IPv4
      UDP-encapsulated ESP packets on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
---
v2->v3: https://lore.kernel.org/all/20240709062326.939083-5-yumike@google.com
- Correct ESP seq in esp_xmit().
v1->v2: https://lore.kernel.org/all/20240702084452.2259237-5-yumike@google.com
- Fix comment style.
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
2.45.2.803.g4e1b14247a-goog


