Return-Path: <netdev+bounces-83821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407DE8946D5
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD04B20FC6
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6754FA3;
	Mon,  1 Apr 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="en4jrJVz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3E4D9EF
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008666; cv=none; b=Gw+hsSlY4RdD7AE6gV12Q5enLAWRN13hbLWWnfQC+AdVWmUhUWtFq9mErfVl8JYM7gRvIPwD0inucn3qvvLER6CpBa/Dcoj7aq9EdV/qFg8YDf93zy4RGgq/uNtaNNeoKoqSBo9S/fxy0RKqAeViJ5/kyhgC7gYjDF0GWsN5GVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008666; c=relaxed/simple;
	bh=eKbx3OApRaXqcFV5vBkjDuv3x59L9Vh/SY2/lJJ5uf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ltErxxqbXyXJttMa38myfmADkIusQxU49rpJcFJJlnI4L1dBY7KYAHAcbwn8f4ZqOiCQZL79Tjv+14M3WRDaOHvKlDJvzlFg+98ixKppoHqkeA8LOhEu36jH70DerAz/RhvoTG88bFYgYaftz8cAdGemeFek1rpq0pkVYDg65VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=en4jrJVz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e71495a60dso5054137b3a.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712008664; x=1712613464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zqw+BRTwGBvSeZ9P47W/5lq4WU5+34JtOjPY9Qvl6y0=;
        b=en4jrJVz+yjKLZTGZ9Q5spoSkWALBVNehSUgqE1TbhVRxK+gtlmCOO7duuk9ehJvC4
         W4vwuTZ/GroamSsBSzeOR4QwBNr0MW2njAYjxgSguC8vLsOVxoyTwLHuDqP5iM4CWY3Z
         WSdK2gzaRSvTmzIuMbWZds2FMt5G2036Teub6XAuAZV7bKqHKVHpGW37x/WHX8rUzm+l
         nAK1/p0u/kqaLySw6U0ySbQyOrHnOVCcm2ggADnYYSdKVbwtwvWnxrqGhHLvY7wVwyAs
         xJjsi3VZL2nBQdqP5Wr7fQja7MP5gxWn1Q5BLADDk3uSR/1P+nWtTyOltuZsQTJS6x2Q
         p0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008664; x=1712613464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zqw+BRTwGBvSeZ9P47W/5lq4WU5+34JtOjPY9Qvl6y0=;
        b=K38tgIEq8XCj1mCwtHuDwj/GEHxHt/v2Acam/fgw64E3xEZ7iSKMq4pUs1rkh+TAOZ
         GXU4DuK2Bw2kVtmZ7usRW0AR/jzmd1C4augiD5xWZWbLZBZcwfXZH6peB1drV8DOb7Ky
         kcXB3c5EWWma4PoyB9raqxfbUBcmgzb1e0q+2en5R9Yq9c1bpP8i0gJIe9mx+RwDw2+8
         ICyEKAbYrE+M3wBCLRwPKly/BXboj236SHJa1TyYziyRG/drCq/2+H6AMrf/98CEz6wg
         QU7DuyTRIlZpwBNHck/FOPC3jB7PSw0gR7eb7Px0+3EjvrCOMwi88tdpqBbyO/ZfRpJ1
         7eug==
X-Gm-Message-State: AOJu0Yyhp2qexah0v5gvGO7bdaemcgTrQuUIVmY08SIcWys2uvY58cW8
	fn2v2FtFqHBvdXzrS8fdCm7DdnvI5MCNckfDvy42g40myoElGRoWyHeSBzSBWu7xTLHwVX2Ccam
	KcvmjbXSG57qF6+1eVWNte3zkudljaEGi1CEBti/iEFuXAoHMw+UNErX9XJF6M8+dSGlVT0uTQq
	2mpaE7meCDLNqaEr+dKBW0Vyt7wpq9b8Ksh+hqQuxv90ibHw74yp4FynlBrhQ=
X-Google-Smtp-Source: AGHT+IHiSO1MuKLG2PKVQbdCWuwFdZapbLt2UKR3INhEcUZ7SVwCPFzN3L+SYnZHvf01xLFIZrXx+L/wRv6bW4/Bww==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b337:405b:46e7:9bd9])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:d8b:b0:614:a42b:1528 with
 SMTP id da11-20020a05690c0d8b00b00614a42b1528mr1480060ywb.10.1712008255028;
 Mon, 01 Apr 2024 14:50:55 -0700 (PDT)
Date: Mon,  1 Apr 2024 14:50:39 -0700
In-Reply-To: <20240401215042.1877541-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401215042.1877541-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401215042.1877541-4-almasrymina@google.com>
Subject: [PATCH net-next v3 3/3] net: remove napi_frag_unref
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
	Dragos Tatulea <dtatulea@nvidia.com>, Maxim Mikityanskiy <maxtram95@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Howells <dhowells@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Aleksander Lobakin <aleksander.lobakin@intel.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Liang Chen <liangchen.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

With the changes in the last patches, napi_frag_unref() is now
reduandant. Remove it and use skb_page_unref directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---
 drivers/net/ethernet/marvell/sky2.c        |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
 include/linux/skbuff.h                     | 14 +++++---------
 net/core/skbuff.c                          |  4 ++--
 net/tls/tls_device.c                       |  2 +-
 net/tls/tls_strp.c                         |  2 +-
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 07720841a8d7..8e00a5856856 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -2501,7 +2501,7 @@ static void skb_put_frags(struct sk_buff *skb, unsigned int hdr_space,
 
 		if (length == 0) {
 			/* don't need this page */
-			__skb_frag_unref(frag, false);
+			__skb_frag_unref(frag, false, false);
 			--skb_shinfo(skb)->nr_frags;
 		} else {
 			size = min(length, (unsigned) PAGE_SIZE);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index eac49657bd07..4dbf29b46979 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -526,7 +526,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 fail:
 	while (nr > 0) {
 		nr--;
-		__skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
+		__skb_frag_unref(skb_shinfo(skb)->frags + nr, false, false);
 	}
 	return 0;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 849d78554b50..e3f40f89e15a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3536,23 +3536,19 @@ skb_page_unref(struct page *page, bool recycle, bool napi_safe)
 	put_page(page);
 }
 
-static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
-{
-	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
-}
-
 /**
  * __skb_frag_unref - release a reference on a paged fragment.
  * @frag: the paged fragment
  * @recycle: recycle the page if allocated via page_pool
+ * @napi_safe: set to true if running in the same napi context as where the
+ * consumer would run.
  *
  * Releases a reference on the paged fragment @frag
  * or recycles the page via the page_pool API.
  */
-static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
+static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	napi_frag_unref(frag, recycle, false);
+	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
 }
 
 /**
@@ -3567,7 +3563,7 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	if (!skb_zcopy_managed(skb))
-		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle);
+		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle, false);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d878f2e67567..c4460408467e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1108,7 +1108,7 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason,
 	}
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		napi_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
+		__skb_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
 
 free_head:
 	if (shinfo->frag_list)
@@ -4199,7 +4199,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 		fragto = &skb_shinfo(tgt)->frags[merge];
 
 		skb_frag_size_add(fragto, skb_frag_size(fragfrom));
-		__skb_frag_unref(fragfrom, skb->pp_recycle);
+		__skb_frag_unref(fragfrom, skb->pp_recycle, false);
 	}
 
 	/* Reposition in the original skb */
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index bf8ed36b1ad6..5dc6381f34fb 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -140,7 +140,7 @@ static void destroy_record(struct tls_record_info *record)
 	int i;
 
 	for (i = 0; i < record->num_frags; i++)
-		__skb_frag_unref(&record->frags[i], false);
+		__skb_frag_unref(&record->frags[i], false, false);
 	kfree(record);
 }
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index ca1e0e198ceb..85b41f226978 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -196,7 +196,7 @@ static void tls_strp_flush_anchor_copy(struct tls_strparser *strp)
 	DEBUG_NET_WARN_ON_ONCE(atomic_read(&shinfo->dataref) != 1);
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		__skb_frag_unref(&shinfo->frags[i], false);
+		__skb_frag_unref(&shinfo->frags[i], false, false);
 	shinfo->nr_frags = 0;
 	if (strp->copy_mode) {
 		kfree_skb_list(shinfo->frag_list);
-- 
2.44.0.478.gd926399ef9-goog


