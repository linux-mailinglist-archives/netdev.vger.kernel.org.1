Return-Path: <netdev+bounces-84546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F11E897406
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A920283490
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54E14B08B;
	Wed,  3 Apr 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bs5IfSlt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D114AD0A
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158135; cv=none; b=sCZ/Z6X7FsHW4dTMi0OhhOglRt+47zrNawlHxoHKWvALjcrsfhcLToGTP7DhFB+3/KgLWzCzUmeVd0PTtfZIT8luKmh9AHJlFzoJI0P5BWz6cEPuG4C6wp7M5t0ndNHDaRG7JbnC1SkkVDZu82KW8N6X3T8oMYHDIx6sldYW+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158135; c=relaxed/simple;
	bh=9MBXfFFaUkMScseJNVCokGwDY6l5vMDtbQJR1lmoadQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b2BO5icQr7q5PfXU+BrF48d0nk61U3MhWS2K60X5K7kfrHasGh3/h2d0UkHKsX5x92jl6TwZNBWAlkYRsEq+8zfn3hEGACprkKBl18d+eifI5e3/rg5hydNUOmxukQpiOLgNWWWv7hvYMbvhICpbrmOoSeYxLPIahGCEPM/7t4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bs5IfSlt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so10410495276.2
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712158133; x=1712762933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ46wgx2VOZhZI3amGmb078HYyws+2NawAwS/VEa28E=;
        b=bs5IfSltzz7E63ZXnVgagfOUKyUDAU0L2xci9/3yTS3emn1eqB0QlG3Bw1GNALGcvU
         naQntpM8oDEpStessr9xFB74f1+dfp2Game7PDKsBL2Q6lam2xyfcYHnEIB39IDFNpeM
         ogfek0ZcHuvNf+t9Lwtan/q8INSARZ1RwkEzJGaBd8PDWbCPDGg4kte4swF5vBalMuPG
         voxB7IN5yw2KC6/gE6xvvfxmwjXlZlgpR3dEL6WM9vNO0jzYHLaY0GMln7JGW6aliL6A
         TGB0T6FKYGScRZAhWmM2pRrA6lbTWuUXRG+dTzJebO5eWFM2MMl1PUfdtxOEMbl0Mbba
         BWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158133; x=1712762933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ46wgx2VOZhZI3amGmb078HYyws+2NawAwS/VEa28E=;
        b=s7obm8/Ga3oWXoydhwfFlWtQTuW+iFUOqUx3b+KJGi9hDoxNeMhASxHN0NJFHGAFVJ
         +XkE+alh5JKDqtcDw0XK7qXvL4fCUz8g1dDVOyG7yqCdirGNhv0ralcuqwzN+lGEDqKJ
         w1DU11ok7pVKffx45/Hdzbyqm1nwUgGR+hKo51FbY7RMt3G1G+2GCwBY8Q+h/6aG5KL1
         q+iCn2SOsKr4lRXh3TTVGQlogPR7hok0ZJSBzigSSSZq1AgwiTcy6FUHEGDYIDoy9Lbe
         AdGYOv6tAm9XruvB5lBxRoEQzJ9LApK4Unl5ChOGCT/gSC8uysBuDtyABtp5CrYg7ctF
         94Zw==
X-Gm-Message-State: AOJu0YztUPCweNkM3WASj6uoiHTcXu2OcPYlEcooDXIHqxbHpUFsfQ4m
	q4z25/uMrp/0tGM025tXhgZOSHB1p0aqbUcWEyie7wP6KEH9gzLnX+HJTRZmOrmkiD75eMKHZTT
	24gaNoNjtd/uHyZr+tLNSGfXKyaXFsCOMnP6eIH8PGN1ErnvwMai8D30Y3ZeuzeXPJkuaUu35X5
	VD3QYmTFpDCUBNDdYsJFILOF6wfVQfBTsvN002eIeNhn7hBUTeL461yGek5dM=
X-Google-Smtp-Source: AGHT+IH2BOj3HujJ3UAL3LDYPh9x/ZqBz2OYXz7yuPx/8kZYe48WcKGacUBuDSlX/S4SNRPVLQsoSlsEIcWqYK+yVg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:154d:b0:dc7:48ce:d17f with
 SMTP id r13-20020a056902154d00b00dc748ced17fmr4888098ybu.10.1712158133514;
 Wed, 03 Apr 2024 08:28:53 -0700 (PDT)
Date: Wed,  3 Apr 2024 08:28:42 -0700
In-Reply-To: <20240403152844.4061814-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403152844.4061814-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403152844.4061814-4-almasrymina@google.com>
Subject: [PATCH net-next v4 3/3] net: remove napi_frag_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Florian Westphal <fw@strlen.de>, David Howells <dhowells@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"

With the changes in the last patches, napi_frag_unref() is now
reduandant. Remove it and use skb_page_unref directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---
 include/linux/skbuff.h | 8 +-------
 net/core/skbuff.c      | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 71caeee061ca..eb3d70e57166 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3536,12 +3536,6 @@ skb_page_unref(struct page *page, bool recycle)
 	put_page(page);
 }
 
-static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle)
-{
-	skb_page_unref(skb_frag_page(frag), recycle);
-}
-
 /**
  * __skb_frag_unref - release a reference on a paged fragment.
  * @frag: the paged fragment
@@ -3552,7 +3546,7 @@ napi_frag_unref(skb_frag_t *frag, bool recycle)
  */
 static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
 {
-	napi_frag_unref(frag, recycle);
+	skb_page_unref(skb_frag_page(frag), recycle);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ff7e450ec5ea..9aa1b40d1693 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1082,7 +1082,7 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason)
 	}
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		napi_frag_unref(&shinfo->frags[i], skb->pp_recycle);
+		__skb_frag_unref(&shinfo->frags[i], skb->pp_recycle);
 
 free_head:
 	if (shinfo->frag_list)
-- 
2.44.0.478.gd926399ef9-goog


