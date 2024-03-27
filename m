Return-Path: <netdev+bounces-82676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B306088F130
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 22:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37C41C2F7B5
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 21:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60510153BCA;
	Wed, 27 Mar 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lURWOSZb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9E15382D
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575932; cv=none; b=nODSiq4VwO9DSEr+LofmpQgo0NDHSy8jQ4RwWubOQsqxlnkJr0vS4RVEkCfuWCzrCqPLbwP8mZRe6YwfypIDXTCAgSD647NDx5EWsuaFSm0i8yTOOFdAcMFcy/RKUvo4XTtwJJlbQXOwflBzpKdDlTPsUjnDEYBQMeQGayWFl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575932; c=relaxed/simple;
	bh=Rak+tbVGAvFieKkSB/eo4ljeZ0A/D+7QGjSJN/aq218=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Km0/W46bD2JdeFY3tqp6kMtVkR+ArP6p/SA3oDA2Fw8Oz30k4DdGggmww3ctPZyc6xac5h53YjLcCgsKrQt7q1B4ti2O3Rp0ga/Wcij2UkifH2ZRlZeUD2yDfdH/HRL3uNlhiCWM0QIWwtlBxStmrtLhRCmWfYZoolexyPzb0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lURWOSZb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so422242276.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575930; x=1712180730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldINoU5VYJkv9i5GCH5hBaOnA51dgNGBQpx4IgBlUR8=;
        b=lURWOSZbi/xEhzRj+lH23e4jhAMJBYiQVPIZlOMELgjHud3YTFt2LjS0nv0oCEd4QG
         vsdHeEUSvaM4q200ady9WaPmfv3pUJbT6s6V5Cs7hVi3q98nyaty2Wtim30SrWIBQIWW
         AgRFFav4n0ojxIeqF50v9Jp/QFCTcAH043E+gyr+JsO+Ryf8XQebhD4QHX93f+bSdjPm
         qebeWxFqZbpT003qcOwoy5K6OLkN4biiSglMtU3QixougP9kZl9Zd90A/+JXQ4am0Jqe
         vTrm+fmdKtz93KxnNVIRsXGjEG9K2DQDYwCMgX2rXAxTs6WzWPlyeHiGxVG+n+74Nbkz
         gU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575930; x=1712180730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldINoU5VYJkv9i5GCH5hBaOnA51dgNGBQpx4IgBlUR8=;
        b=eUIdE6OfdHIl4gE63387OnYXOobqwA+8QVv/JXcDuPxw45P7PdWvhNAeavIkHLTmPu
         lR03bgh/t2rbn2cJvXJCZIVidr+L3EGeeWtzMGzlbG2x3ihfOnKF0S3+TfA5SBuRrt2g
         /HwYD4sKhm5Ri8OF3q/Thqyc1l+iDdq8GSSZBEChQutWoM2I9tzU8Qw+0I4/XxQSZKNl
         gQsFwWrfMGQ/icUhntbdgTTMX6nKPzHv2m5T3uIFCO0Y51g8BUPtOw0NPqW8eVYXXpzy
         mQUDK/9qEIBQzuPeBJ4II2hGoHuoMsmm74EK1w0YkaUT7YIWTHW9JSZVmj3sAj5fAU91
         xDwg==
X-Gm-Message-State: AOJu0YzQRHyUv+eLxxIUd8W/uG87E7BL65ej7Yr72UQRvdlozb3Rr8t7
	ogZxakoMccMVbo+jK4Nmftz7dimLpY6seT6lb50YsvjqliJFsxGA8CATCqGECxYK5eD7GFXS1dU
	5kWuecrg+OcFclJNaXiopun8P80aWDra5Wgqy3Md4nxZ4F0uZ7D73D+l440fUaSLeChXeYcvHVh
	GBcCgh5U5KQjyLWDrzw/xLsuF3wPuEegKqvoaRbzUI/8ON3hv29iZrCa4JxCI=
X-Google-Smtp-Source: AGHT+IEKtADRvlkxc7YGEqMlczMA9y2zeZF2AgXSBclUgkSzZX00m5c+R1YQNQRHKujGk4eQyKgrO2GZQNQ7f1pkaQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b757:6e7b:2156:cabc])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:110c:b0:dcc:f01f:65e1 with
 SMTP id o12-20020a056902110c00b00dccf01f65e1mr341668ybu.8.1711575929627; Wed,
 27 Mar 2024 14:45:29 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:45:19 -0700
In-Reply-To: <20240327214523.2182174-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327214523.2182174-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327214523.2182174-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/3] net: make napi_frag_unref reuse skb_page_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The implementations of these 2 functions are almost identical. Remove
the implementation of napi_frag_unref, and make it a call into
skb_page_unref so we don't duplicate the implementation.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h | 12 +++---------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b945af8a6208..bafa5c9ff59a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3524,10 +3524,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+skb_page_unref(struct page *page, bool recycle, bool napi_safe)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(page, napi_safe))
 		return;
 #endif
 	put_page(page);
@@ -3536,13 +3536,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
-		return;
-#endif
-	put_page(page);
+	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
 }
 
 /**
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..3d2c252c5570 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..4fe4f97f5420 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0.396.g6e790dbe36-goog


