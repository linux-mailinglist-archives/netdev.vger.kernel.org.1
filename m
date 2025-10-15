Return-Path: <netdev+bounces-229819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF173BE1097
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5769C19C1D3C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841E2306B2C;
	Wed, 15 Oct 2025 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjA1JCCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF081200BAE
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571485; cv=none; b=hj8YDyF9V7HByo0QZYbur2LPMan3GNTbpyTxLiBCnMNrVveBFjdOJLcfqhBR4la2hypuLgaALGtlWP5oX4rtpHl+YVoq9lPpjeGCXlWiP0ntCDtb9QIfcktwo1tPtfVqdP3vqOabn9FBBKARvQJIk+G/lVO3VmdYh457nG6vzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571485; c=relaxed/simple;
	bh=7iTp8Ln+TsdzigJ3kSLZugNljCXqM5nJipMiChdPw3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cbKIQAyOA55zzAWMfWogEn9oxQUg2qYROeyFK6xn3iU7p8oF10v7zqt7RBJhNLYmt52nDdTYol9iJJ5cs4rYt8Krx1QhcnDfZDS+ntPOYtjjBKWyvBSURA93x9hTufoE4B6irv05wJ94N71LBVNJemh42RFDxbKnX2LcXgqkS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjA1JCCU; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-88e35354330so56075185a.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760571483; x=1761176283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+XdobWh6ZG9XZVmQH+dusxWn2yqPGNi0J8B/7aO1PIU=;
        b=rjA1JCCUeWUuy320HGZU1G08X9rD5IUhtzmyWxU8VwJyYs4LppMdND4T0NY6bpW8Tt
         yJCmOvklZpdHyzpeg1tA4bYbfbQOYifuYbOciJ9XzxL7ho7ohXYDA36Y0FYINkdY+2yt
         k7rRoGbE086czlukfmZDQGZOWrJPKSIDHUJMlEe9up4kne/fOV6tYQC7I3yObQ34WTvn
         31Zi4DhriZpNPl22SkgBCSiTOitH7QnC39yU+j3Dzy6JmTNX4DphGAcgG8wHXj/SRlO4
         jZIWdEFYbAMTsz8GYdJWXOOy5hD8VFJmGS6TAanr4Gg4uuWr/e4wOVCyMUtqm8D/DPFX
         Iy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571483; x=1761176283;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XdobWh6ZG9XZVmQH+dusxWn2yqPGNi0J8B/7aO1PIU=;
        b=pNiYHyZOgUoU+g/eA1soQMQnay/RQQkyCxZGmf8vUQBB/VGOadj4d9YwBu+HTpna6E
         ndYqMrMJMIpPdxnqAUOzUALNLxb9UTV7/KPxkS13ESWP60PDC34+yyvSVXhOG10LcHH0
         p2Lglf84ub2+epZTSts/MhqBbaantoUEXCxEtWpqYJIn/fUal4Ry/VX0cvhQJh27r+1G
         RMHCzEoL+HsUezx2dxBpbx2YeEsDhumUyExQDbM78DCjtmPbb56WyVbAqxdrCok2UQyv
         QG1BS0JRGqkRnT48Jk7TM8lbQv5GEMX/ZQ0Re7lF4snILAoz5HR7141HEFD1mkiRV7NR
         KCHA==
X-Forwarded-Encrypted: i=1; AJvYcCW4tSTGhW8nmKOewNf5UdQOUe4e0LLlmPjb+E7ssNeQTGZWFin4NdJ2TQh5opG0IcDI2HCyXHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmITbzJPX/xK0vOZl1pP7/b7/i1X07icw151I4SONX2fzaImyK
	Je2tCIvB2j/hqrULESx4OdVbM8kBiV8duyYq3MOEzUqRUnI4/a5sgARzlNLnuQKGZGxdujIkxL5
	hJsHy/SrqAQh7Jw==
X-Google-Smtp-Source: AGHT+IHblgsd58nAOvxbhQgOLKNPI3E4aTubl0DG1hr/mElQqgznIPKYoUYeEKuFxewF3okFW41cLwrI2f1pBA==
X-Received: from qknox5.prod.google.com ([2002:a05:620a:8285:b0:856:535f:987b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:c54:b0:85e:24c3:a609 with SMTP id af79cd13be357-8835088e59fmr4967260785a.22.1760571482645;
 Wed, 15 Oct 2025 16:38:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 23:38:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015233801.2977044-1-edumazet@google.com>
Subject: [PATCH net-next] net: shrink napi_skb_cache_put()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"

Following loop in napi_skb_cache_put() is unrolled by the compiler
even if CONFIG_KASAN is not enabled:

for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
	kasan_mempool_unpoison_object(nc->skb_cache[i],
				kmem_cache_size(net_hotdata.skbuff_cache));

We have 32 times this sequence, for a total of 384 bytes.

	48 8b 3d 00 00 00 00 	net_hotdata.skbuff_cache,%rdi
	e8 00 00 00 00       	call   kmem_cache_size

This is because kmem_cache_size() is an extern function,
and kasan_unpoison_object_data() is an inline function.

Cache kmem_cache_size() result in a temporary variable, and
make the loop conditional to CONFIG_KASAN.

After this patch, napi_skb_cache_put() is inlined in its callers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/skbuff.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..5a8b48b201843f94b5fdaab3241801f642fbd1f0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1426,10 +1426,13 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	nc->skb_cache[nc->skb_count++] = skb;
 
 	if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
-		for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
-			kasan_mempool_unpoison_object(nc->skb_cache[i],
-						kmem_cache_size(net_hotdata.skbuff_cache));
+		if (IS_ENABLED(CONFIG_KASAN)) {
+			u32 size = kmem_cache_size(net_hotdata.skbuff_cache);
 
+			for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
+				kasan_mempool_unpoison_object(nc->skb_cache[i],
+							      size);
+		}
 		kmem_cache_free_bulk(net_hotdata.skbuff_cache, NAPI_SKB_CACHE_HALF,
 				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
 		nc->skb_count = NAPI_SKB_CACHE_HALF;
-- 
2.51.0.869.ge66316f041-goog


