Return-Path: <netdev+bounces-293778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA6sHFaPHWr4cAkAu9opvQ
	(envelope-from <netdev+bounces-293778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:55:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A36205A6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91F64302AD3E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC23AA187;
	Mon,  1 Jun 2026 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH3/d67Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0C389115
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321569; cv=none; b=dc6paulQMgeI6Am9DzsOxKtWiodmh7SgbYaC+WXEaBVweq8pJPPgKDT7Usx6oqyTTtmV634fI2TgPbCgB0w7/T5rQmTzAjmfIN2GuJbTzb3MESD+UED293E1z9zdiLeuJ+RR1FSHZllTgEt33mF8GvOjUH9QjbxhBS3HU0pW/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321569; c=relaxed/simple;
	bh=dyZ86Cv8vGqv7gq9+mywke5I/pjRLYDP/XV/eYvJOr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9Q9gqi8vDVAkuNeToHRCLKTE1laa8rQ8XUaWSnhR3rvMnBc1DCCooHNlu6M7oTPATQpIUcXLDgB/cAdKn3M2bZnoaaunx/nP6pKpUcymbxZIvWE4/ZUOM/zcAp049kxgBGTCYMo1oiuH6sFSDMicWRlchvuuF2/tI+1ffneBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH3/d67Z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so90773105e9.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321566; x=1780926366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDFWzLbwsPQytHDEG9PwUoghyauZNQfRZ1OL2Tq9T1Y=;
        b=dH3/d67Z2N/4nzqziY5Iqq1S0LULfYtWRKv7tLhT/29bWsWoQVioRuFNIcwsIVNJaL
         6BcQNnN0+WWjNmUF6yrgHwcD5+vBA0/1PgiOloU4+cGpVxHX2M4xbF/MRl5QBFXFgxJI
         oFLZ69GyC0gEFCU5fY0wHckdEWIPVRsI+7SYKNYjLvhAVw/n4syaQu+UAWh/BLfY/a6Q
         8lp1hC2n6QzxWQ6b5WiSv4tJLtgnpjumnPbELnAgY/rVkC/0ODi+GiSSCI+u2iVyRb0B
         a47f36Q5OThSOQ9xIi4ieHt9pTW9CNkKS0CPiwDswyHsUYiz4HqHjVZzRzae3tvmVW3W
         XQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321566; x=1780926366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDFWzLbwsPQytHDEG9PwUoghyauZNQfRZ1OL2Tq9T1Y=;
        b=Po+gQNEmU9H1MxMlp+7SGmBaE7pe5en+ukYRB05MtV1ug2TobG+Lo9mXrgs7O2i8a5
         QXKx9QI8PhVYIfjXcOcfSHj+jcAf+eusGS1BKr6+Wb6oKXlETKJY124JVjNP/BBx8gTP
         2x339S/YWmajkH4QXTvG0sO61RlkyG43UgTwa5n4wVya0NOGR1x2I4j8KDZvJ8MqEkOU
         yV3BRay+h+iufZERhHRiuwGsisrorxJwdpdYOUkt4lYRwImYMaJVT+GxJ3cA0QeAlJoe
         z09xQ172ph9e1fRObmV3qhbH7a28ccujSz+9FG71ZfiCjOxtPlYM4SjpZGJf/Ycq+Ew5
         hs7g==
X-Gm-Message-State: AOJu0YxoK/FSrcruz2/ndbQBWxHhVXi/SfasUGzI7+/O17zPm8XswRlF
	HB1D0/Yll7XariCb5PCkGL9V9a1sOVnM2k4+dVLlyuATHUKEsR5JOU3WxoZaPNTb
X-Gm-Gg: Acq92OFQiP0s73KKZI8fUDLWeJCnqUdjtsrmPzbFdAGWG1aCW/YunNiatM/UXRuo/WQ
	slrVg2V1L3JuIdCoC5wQke+h6gf+eVhJ2a/pqZQ95Nh3bzYwRBqp2bXPgvACHdktHrjCpzuMf36
	Hh4nalcxBM4sqlTlt/LDUTav/BjFMgq87mMpjhcELhkK7pME3BRcmK0AC6czajNopBSiUBDlS8D
	QtPUNwaampFh/uKEgyTBPkBDRq4ME2XzioKcy8dw/0Sh+aWxzGPkDgQ5trfVz6LjRNlnP/FUQ0y
	FhIEkMZNmUuBC1WVoy0WUfr3fwVLkjq0qNl3/EPH1T3hnJkE3DNgjwoViktywHHNmyFQhAAEfzf
	4hh9UDp+mLR93pntdpBV0mkhYODeDO7ifv8PIQsLBrnixSr4QPgU9uzhhoo7pUM5O+nQSNdqBrx
	VvM5dK/8wLW68QXuqeItPlEaEgzl3Qm6K31/oJebt+jj5ZWy2GF1YSIk9/njzgmxQaLkLYrKEJ4
	2zYCv0ihPe06FzQXprbHn3ll+vR
X-Received: by 2002:a05:600c:5395:b0:490:4b89:535d with SMTP id 5b1f17b1804b1-490a2904b29mr247202275e9.1.1780321565884;
        Mon, 01 Jun 2026 06:46:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:827:3b28:500:30ab:2400:2a9c:6742])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490aaebf4f1sm94981775e9.12.2026.06.01.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:46:05 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH ipsec] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Mon,  1 Jun 2026 15:45:25 +0200
Message-ID: <20260601134526.82-1-7991aleschino@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-293778-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC3A36205A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
unconditionally unrefs the source scatterlist frags. Since req->src is
not yet initialized by aead_request_set_crypt() at the point of the
error, the source scatterlist is obtained directly via esp_req_sg().
Existing callers pass false to preserve the original behavior.

The same issue exists in both esp4 and esp6 as the code is identical.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
---
 net/ipv4/esp4.c | 14 ++++++++------
 net/ipv6/esp6.c | 14 ++++++++------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 513c8215c947..2429c7845984 100644
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
@@ -113,8 +113,8 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+	if (already_unref || req->src != req->dst)
+		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
 }
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
index 57481e423e59..50af6ab9b8fc 100644
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
@@ -130,8 +130,8 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+	if (already_unref || req->src != req->dst)
+		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
 }
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


