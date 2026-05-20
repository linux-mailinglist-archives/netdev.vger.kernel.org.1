Return-Path: <netdev+bounces-289808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJMvL25jDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:31:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 204BC588FA1
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37543018D5A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333B366073;
	Wed, 20 May 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnvG4t/e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6533ADA4
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262060; cv=none; b=Cl2gw3D3SNIgi8S2o5Z6mwuSi5Qd+KPGYdiGM2HXPDqJ4tvvAbLYLdh8cUoeIXebuDmqEocC05Oa6Zh7ObfHw+osa7bKnhlP9NOaTniiiQDixLh6oYrH6CsPuoV8FzMHTAQMmvU2KM63v12rId5MCVTHZdRUWqETNGQxHXBltrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262060; c=relaxed/simple;
	bh=4FRxNnqDMNdEkwcqxtdH8RepBGpls1NqJol4l4qjRAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRBQVajX+XYlqmuhwFerXWWNjFqPjY42XbAh2x13m9pmfCV8V3DNT4FY+97YJwRzVQ18brM22TA/l0pai1aw3rJGpnE3IwdMoVfIJ0IZALgmOPBG/7YuRq5IbH+fG7ieNZyPx7qR50Enn8RJCQIjWXX8bkE19ufdIrzV37GAAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnvG4t/e; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44c350a5b87so2681327f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779262057; x=1779866857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YFCpyBr8c2WuPvvXn0j2wRYx2mdw2tGa8zkYj1VPho8=;
        b=DnvG4t/es7kOIsXbZdDJArAzcr5IwUoq36YDnFoVV6dr137DrKgnkl1ayDnixQ11uF
         YSLYpTbegvb2rPzi1jQ4kIRtNMJjlAzIn43kJWpexrUG96Zitc2Ob3A6AfKxzVdBQUHl
         0NRG98UOj+uYLUcSLjd3LONjLV6qoRJvZ72rDRoC9WasF7DW841op0qek1tv3Yf0i/Hq
         fQrBbXKIrO1q3sLRq7N3Jge+waj47R0G1HjTDe/dcWN5rqVfW1OjXn9hRs0rjw2IsR8i
         cChdcYpx/IlMiz3+dhBUe1egGGBe3tCTlvjdNALF/A7FrQsnkDFgsVT1kx+sC9VTn+EO
         JwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262057; x=1779866857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFCpyBr8c2WuPvvXn0j2wRYx2mdw2tGa8zkYj1VPho8=;
        b=hL8AVwpENLyVl+QmCK53bfLTyRychihPVUAsJ7Gmxo2S/aYwmTfIzbNBFmZGs1nMHW
         dckKhr6sAg3V3Aa8sINPuUlKV6xFN2gjV2CCYuCNt80QRqX6JNreTFyk+T9uD3/mJBEW
         uQIw8tGtxJjExPum4kEo+FnHUxH7H1xdcrrPPaDxixLDhDEGjcN8JEX30pGQY/zY2Lcj
         vuqWb8ae9WL0PshNsvMq1OOL9ebHcxjDmAdZ3n7oLIMSxsC6Kr2CQfMWfMmtf7CBZmy+
         INxFx8AjGrh+QgN8C8rvqOsFdG3o2yur67h24aR5vd5X92M/DI8bAmtiy4xSCGWfwktK
         h6Pw==
X-Gm-Message-State: AOJu0Yy81BGFaz1ifxzby4CI4ZI4PySvrTCkKoOrKF8ZfaflzLfbJCpP
	p+DYstC5RX8edTboOJCvp0eZAjCAB/dC/QLz+k6qnesIGBQzYiduJpWYgTja2cKd
X-Gm-Gg: Acq92OERI5egn4nUHeRzH/xqSEbuQFPsyxm61jDAGesRBgnLBa2i1zgVwE6IAHzgUcN
	6GKDnYIwMc2sn44WPLr7EfUPcOY3lSBx7lXeIRODpUaoGvaNCIE4jFlrkucbNA2LykugpLRXNcX
	k9+3OKOkIMKq07eo4ZnDTde215IJ6AH52BGJ3kOCFMyLl446jhBo3MNWvs5iov/RcWOy1QRNBzk
	iIHJ69OWRnDVWppMieQM6sj7QrLcqKTIGn1v/mq5Crq58+H7XgKn4ZgikmGP3gTABh5eFbjIwrs
	OswfN6HYIT+nZsEV1rBnyh17xVhiukrIihYvgoq7Q55XkMiksHXnJ5/fov0O4s4Fxs47p38kcqF
	108P9/VvACLt/eQaCSzQmF4hNz8+jYS4BauzhZuuUfarihCRmOfjFn2HPDIiPZQliCAA0qqfhuH
	bRiaHTyE6TPg1oj0sxKRInwMVv+dc0ofpDDm1czrRH1Hc05/iorIPFr++RgoH9Zx5NzefAoU67m
	JWzkFNc6xjY1gFrjr1hGsyQEgz6nfAIIzK+npZ13drK2FqrvshEFsn40t1/5CCLndI=
X-Received: by 2002:a05:6000:4305:b0:43c:fe66:43ec with SMTP id ffacd0b85a97d-45e5c5af3e1mr38635027f8f.14.1779262056517;
        Wed, 20 May 2026 00:27:36 -0700 (PDT)
Received: from localhost.localdomain (host-217-59-207-212.business.telecomitalia.it. [217.59.207.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm53915917f8f.29.2026.05.20.00.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:27:36 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	e521588 <alessandro.schino@sbb.ch>,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH ipsec v2] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Wed, 20 May 2026 09:27:17 +0200
Message-ID: <20260520072717.2043-1-7991aleschino@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,vger.kernel.org,sbb.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-289808-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[7991aleschino@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sbb.ch:email]
X-Rspamd-Queue-Id: 204BC588FA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: e521588 <alessandro.schino@sbb.ch>

In esp_output_tail(), when esp->inplace is false, the old skb page frags
are replaced with a new page from the xfrm page_frag cache. The source
scatterlist (sg) is built from the old frags before the replacement, and
esp_ssg_unref() is responsible for releasing the old page references
after the crypto operation completes.

However, if the second skb_to_sgvec() call (which builds the destination
scatterlist from the new page) fails, the code jumps to error_free which
only calls kfree(tmp). The old page frag references captured in the
source scatterlist are never released:

  1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
  2. nr_frags is set to 1 and frag[0] is replaced with the new page
  3. Second skb_to_sgvec() fails -> goto error_free
  4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
  5. kfree_skb() only releases frag[0] (the new page), not the old ones

Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
unconditionally unrefs the source scatterlist frags without checking
req->src and req->dst, since those fields are not yet initialized by
aead_request_set_crypt() at the point of the error. Existing callers
pass false to preserve the original behavior.

The same issue exists in both esp4 and esp6 as the code is identical.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")

Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
---
 net/ipv4/esp4.c | 12 +++++++-----
 net/ipv6/esp6.c | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6a5febbdbee4..8314d7bddcb7 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -96,7 +96,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -113,7 +113,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
+	if (already_unref || req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
@@ -220,7 +220,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp, skb);
+	esp_ssg_unref(x, tmp, skb, false);
 	kfree(tmp);
 
 	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
@@ -569,8 +569,10 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0))
+		if (unlikely(err < 0)) {
+			esp_ssg_unref(x, tmp, skb, true);
 			goto error_free;
+		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
@@ -602,7 +604,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb);
+		esp_ssg_unref(x, tmp, skb, false);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9c06c5a1419d..9d0c4957ac62 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -113,7 +113,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -130,7 +130,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
+	if (already_unref || req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
@@ -254,7 +254,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp, skb);
+	esp_ssg_unref(x, tmp, skb, false);
 	kfree(tmp);
 
 	esp_output_encap_csum(skb);
@@ -600,8 +600,10 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0))
+		if (unlikely(err < 0)) {
+			esp_ssg_unref(x, tmp, skb, true);
 			goto error_free;
+		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
@@ -634,7 +636,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb);
+		esp_ssg_unref(x, tmp, skb, false);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
-- 
2.41.0.windows.3


