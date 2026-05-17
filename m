Return-Path: <netdev+bounces-288717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKX/CeqiCWpdigQAu9opvQ
	(envelope-from <netdev+bounces-288717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:13:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C735560ABF
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55BDC3002F78
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A835C1BD;
	Sun, 17 May 2026 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4ubqSHz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B382D8DC3
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016416; cv=none; b=Mu8kIEoWuY3FeCtDCsWNVVBy5epO0LUbIuHAm6wqo6DQP3T1DsL23BROLrUs1C5xl+j7nrg29RPWs16iWadCkphftNJZhq/NWQ/IwgxXVdo4dw7mH5GYrhyiUMsMmcyqtlJirlz9SVVQN2a681cOVFFm8AKjqvxgasPJG+CNztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016416; c=relaxed/simple;
	bh=CkxPU9HMSAxjzXvdPzgS6n1OakeS4AGDFkQ7bV+qml4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4FAFBke68pd3hs2Sj2UOdFuRYCX9TpgeOkNTp1xrG4pi1P13zLUC6KXrOiafJQBhKekDxaVQRkPE3+KuZwlx4SincGEGCwUwlae6eZIVSWnPUyvHMNI+gW7pD7HCCZD07aca4/j6B48rkxo04pHyiVd1Lp5dMRtkFysVBCii58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4ubqSHz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso8373825e9.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779016413; x=1779621213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hq4bWdD9APUqfcF0QdwConc0D+0mUZE86sUdlR/xO8=;
        b=D4ubqSHzOEKcu4yTYsYUpAnF/e1R9Jlnfov2zQgiq0eUfpUMlqqvGoMljQ511t15Ww
         K5bIQG01aPjWGldLTL6ts/TdyaLPfrI9aNR1BaNa0OVWvsa8/zcKRd4Cu04cd17wezGa
         CDL62rYUHZg7ISS2nhB4ZVXuBsbYIQn1748wNCcR86eFV9Luk6qaBafO6hAtT+TZtiGZ
         Ubd+b08cPjE1rKoqLlBJ0XNmySRR5ZIWw8oLat2EjcwzrUNUoLZakGDUonDr00fuUu0H
         SVzWd1Hx+vWmcpYZsFJ6a8XwqxMlXx7yuv74m++mco06qE0p6+EmQZqXtjQUhta8ZBRm
         wDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779016413; x=1779621213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Hq4bWdD9APUqfcF0QdwConc0D+0mUZE86sUdlR/xO8=;
        b=Qy408EfDGFvg72hJDnNZiIwP8Y0IuHRhCluur5xEAB4b3rZ/39lhUdHHEVzSRqVNaK
         5Q/a5zYmsYBwNQ0QAPMUlaEILPvuqDI9WH6Hv5EFfmoHU5nPm2I8usRocuGBskhcUMCH
         1r1iohDzinU7JTgCIBeuuo5jpU3To8t60csfkKrUvQfZNAUmc/+GRQ8YbFsBNtioa7ey
         KE3eBpDgdo/KtRX7Kno860rh2ADHtDoIZT9YYRp/MtabX4qxwjPE+i2I45GW/y8mqQj2
         DZgm3dcAuerKj9I9PBr2kmlH6JvwzqieJPL5Hwv9MxDB7+H90kWcjaKpTgQOwhQEtx5W
         HPIw==
X-Gm-Message-State: AOJu0Yxha+91gMOFIV8Bu7qTZjwm+tQZPKsCZr9KhsE7TM08i8fstlZk
	21qqIZGRzx3EHo0p0SqQwkquMc7OvyHoTtNmj9V05yNkRAyitTdB5L2ca5wVBQPe
X-Gm-Gg: Acq92OGEPHgwAcctpgW9Tb7lr6xs3pWEA+AcWPiJcttVNa3xY4YdyErQ3qJzntlH9Fo
	8Bk+PdCOFXLPfuHfZtQrfaiGlNABgqqrTER3YUns2Jy5wP0G510GDO4etNW3i+93wVKoOSuP0GW
	sjtcpvRjpki0k0SOpmRwmpm1qSMjQ6xA9CqyUJIEw2av9zNAx9eKzuYsSujPYXscfbNJs22aPLC
	63WkdWan6DX3751vj5mlS11nKZCzEkjtnawiVh1TzRxsbAhdoLA1c1zIZq8UgvjMv7YhEUTIqrp
	Nyg+YykPZaWE3NrPOcQF6HKqh03+KkCeeGgn37d4/RcnbORZXsWaEdBp17xj7RKfAmqbpu1ki8D
	Nt3pWAm9d911FAKM5Ya2iqqMrcMQgngDJI80cyf6T/fq0L1gQz4+m2rxCIebG4lJzKOCjf+enAo
	bO7qr2nri6WfRz30HBC0/zZ0aurXCG2mEUx1z9aefFHHzXm2hCyaFWRpWnfov4sNjg28UmwrrkA
	a6gGtI=
X-Received: by 2002:a05:600c:4e87:b0:48a:93d2:60d2 with SMTP id 5b1f17b1804b1-48fe59ab8c8mr164353235e9.0.1779016412523;
        Sun, 17 May 2026 04:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:827:3b28:500:b184:4b99:e746:532b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2a23dsm57757125e9.5.2026.05.17.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:13:31 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	e521588 <alessandro.schino@sbb.ch>,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Sun, 17 May 2026 13:13:06 +0200
Message-ID: <20260517111306.1881-1-7991aleschino@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C735560ABF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,vger.kernel.org,sbb.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-288717-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sbb.ch:email]
X-Rspamd-Action: no action

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
 net/ipv4/esp4.c | 10 +++++-----
 net/ipv6/esp6.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 5c4b162c1bb5..8314d7bddcb7 100644
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
@@ -570,7 +570,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
 		if (unlikely(err < 0)) {
-			esp_ssg_unref(x, tmp, skb);
+			esp_ssg_unref(x, tmp, skb, true);
 			goto error_free;
 		}
 	}
@@ -604,7 +604,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb);
+		esp_ssg_unref(x, tmp, skb, false);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9166e1da3615..9d0c4957ac62 100644
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
@@ -601,7 +601,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
 		if (unlikely(err < 0)) {
-			esp_ssg_unref(x, tmp, skb);
+			esp_ssg_unref(x, tmp, skb, true);
 			goto error_free;
 		}
 	}
@@ -636,7 +636,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb);
+		esp_ssg_unref(x, tmp, skb, false);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
-- 
2.41.0.windows.3


