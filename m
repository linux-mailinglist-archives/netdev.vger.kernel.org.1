Return-Path: <netdev+bounces-111017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138CA92F432
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCCB1F22F18
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658DA947A;
	Fri, 12 Jul 2024 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z8iFNuO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4C945A
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752708; cv=none; b=ELB9h0wA6ghDOe+IxFmITtdfDBOr6YsOvuFtyvSOi3LW2ZsaKvD1uwfzgFn7nmjriI0eskQf+Oq6Garkh6gODAFxf4c/tyiMSwrSQ6jcTUWX4g5wgl3wxskaf2xQtEFJSiIYjwFGGrDBtEzCPHANhy9LD/UBWiPgTkHlROsLu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752708; c=relaxed/simple;
	bh=rDBvajKY5OC0PXZ1yITuS+5CAbjqQVusYbaPkwQLiLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kb3ZO+RYdu7vqqtAbwE2Y3xiQofVjbeEIJZb6KQiInh7RoDeq6TTlkgGvGr7ZIkE+SoXYfKpSFixZ5BWsJ71BddMplsZ0AwXL4LJm4w3sYRl+YDgkBPmmJ0dDHbStpVcyDdaQrJs/9mkp/80CNebUf3ymdFd5IXJkBU6GpFFS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z8iFNuO4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03c68c7163so2788601276.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720752706; x=1721357506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DB4pQNaU+Ev4vjvziD2IB7UTB9UxPT+SsJGcwrSVFTk=;
        b=z8iFNuO4pszmVBhY8ZFeIn0XQd4igNzNQFYE50+Kl5thnJEB7xHKXjN3WnQqkPI/8r
         jPcytyCxccEX9vEmzwwxF0rZpN9b443GqIC8ngoFnAe98oQkXauJ56SD9IWV0UDTKmYH
         V6U42ex/ylCDVFUyw7LPN+Nj5pKyZcKYWzSax9xnSeca8Us/loLSCjqhfIaGnBSvAUP6
         BbRQOYoEGTCeaAgMSqQyf0pSxxdLQ/sFjFftDWDh2GKW7lx1GDFMNNgVPvtoqLLgXx/a
         m4gK2qbWmNgugJ+zhQUZe8rrbMSO5XjypLO+d+fY4nugytj1nSP2SeRiDUYMJE7cDL6x
         qliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720752706; x=1721357506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DB4pQNaU+Ev4vjvziD2IB7UTB9UxPT+SsJGcwrSVFTk=;
        b=GqMkzxMy6IEk4sFHoNAzGSR33HqJBXfjB2/taSWxuE0qfgrjdWSBroaeUZB5H/ELvb
         Ku4iq9HdqnYrugUl3+x2ZcN0kELVbdVvr4nWg2Aa6If+U2FygK39Z/7GQbJyfGE9vYGL
         J+xitUJH4sSU9Vb+RlXYRt/XG3Zmq1Vvdz43c3FkXu3Fs0n2mCFt/wXfrccW+Rfri5W4
         33ZG7szPV34BS6mDUxyTu4xaK79iQkFJKO/W4zQRgU5oOeLHkANulNVTeGOr3QNx+78v
         4q1h+VBn0oNjBmY1DMYVKXYxZx23JCJsVN7faV9/93g0BzjHyuIKY1N8wB5zcGjHuVd2
         IXtg==
X-Gm-Message-State: AOJu0YyfAtLwWZ4TNnjHjVGvUmbeZfyHVDNBP+EM1ZRltQ2nad2RLWlq
	rfW7MFV4AKCy+A8J3gVN0wxdqmA+KFc1eSc17MY0X3cWWx0JgInsNLWRpIA1BzPmPqU8BWGVEHc
	Pe1ixJGTh3wk6Sz54JWpSoIk3mam2QBXTxWTQUvZ/IpCrzzd6edC9bTSldDeafYs9bNx5Lw7erL
	g/8hJGi99z08N4TVbj/jQUI/ijU2dAEal8
X-Google-Smtp-Source: AGHT+IFuN+UgKtKYNAIiDsh6EHpLvHt3XqfqagEvkPFAxUDjw6rFDm8sBcnrPqCvSQZ+Gby7eYaZKmdHd1g=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:188f:b0:dfb:b4e:407a with SMTP id
 3f1490d57ef6-e041b1153e5mr1113315276.9.1720752705816; Thu, 11 Jul 2024
 19:51:45 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:51:25 +0800
In-Reply-To: <20240712025125.1926249-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712025125.1926249-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712025125.1926249-5-yumike@google.com>
Subject: [PATCH ipsec-next v4 4/4] xfrm: Support crypto offload for outbound
 IPv4 UDP-encapsulated ESP packet
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
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
2.45.2.993.g49e7a77208-goog


