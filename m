Return-Path: <netdev+bounces-80285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130F987E164
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 01:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962B61F21093
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CFA8833;
	Mon, 18 Mar 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hazp+2dq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89622EE0
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710722765; cv=none; b=YUlMaj9pOO6yEGB/lsnP4XNmKXz424tqhi1UJ7BAx/QEhi1Tg5jXNWfgrXmAFE5UeiJCxPc/yUMucvI6qhAwQY47bVkXSNSTz4Cds8+NM/6JnaAddnSYY6jL+PTaHVEDBlHiGiWFz6T8f688TkD9ej3mdjxbkQJesEPKndlE778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710722765; c=relaxed/simple;
	bh=+ltsd6aWy6p0bvX8Ci5iuGpWlOzugmIwQT0myf1DTSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyJJPUZ7j3pSLMWPQ3yW1VcdZw6NDTZURUV2rCmdyS/zyMCEeJ8bckBymwIUK/Nm6C6k269ZB/uURZCCtPNDt8br++/zLlG0lPJCzhQ8FX9rb9TFSAVRR0b1wM8zMXEtcrjRku9oDi3+ekf1U9n7EkklYgi4/C6wBjmZLU7/pZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hazp+2dq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46c2f29325so22441266b.1
        for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710722762; x=1711327562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwWedZBqfgVMsntn5pBHc4m3NiyzYvGji7quLshSYCY=;
        b=Hazp+2dqHlsdpsEWNpaHlSkn0py0spB2aFKBHTVwjVPfJuku0jOzaUvvLV46gyv6CX
         oNezZMOW1KhTN61C1Zsw1hrw4BJaTY+ZrsZghyL9z8OKZqB6OGeGSTYH1SuBnHOY26Nr
         Kwqhz7xcxP0TnEAFnmDAQX7vCqPMdloe8SQRYKo8QSmmMjV6getFZRIrNHEk8UaqrWxT
         N3hfExOohLslqVN9xzeB6e18mIJZXHw7ff15SuxkNkDbvrD2mx8UvHWpHLWm19lZQNHj
         H1giwR9n4oX29nHFcSy8ng258V7t4Khh08kp2rG/iCVAMxRetjd0qXMNQ4+UlgOw86X7
         LDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710722762; x=1711327562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwWedZBqfgVMsntn5pBHc4m3NiyzYvGji7quLshSYCY=;
        b=Vfz7t9t3w1bjRp+XnpFX4008zl53nuP4zW45GpidHDNUTua2BFsGtgDxxOtaEQ3lcH
         QkEsxrtcEYYWvBuqBSe1JuzfM/recc3vXFCPIotLTZM5bK987AnwPqhvVmbYvsRknZ/0
         t2ESR1+1ULdATWdz+555DHT3t1QGkMxqfkxOCSVo38yvmbNayZjhdZSU803DPyWo/WK0
         yBnSZIi83XQlUpI1/+DH9cCfKD8waQ5o3kz2Bh1rb68wGBKSQmqBk8AiRnM/K3PCW1fk
         7ZVd0SKBjKaOkNJlH96zbBKQJWOwmVp5YXD+BKVlbK6Cyb1xutfC7MhbRLdaO/GmTOgW
         xWsw==
X-Gm-Message-State: AOJu0YzttR3i1nx3lsqQBhwaBLsYv3r9Eap5z5NNtlUaYHwHvf+IOwof
	uPmEdXCpmmH+oqcWKEpSozxPfariNLe8kI/QFlWfYixqYPs9cx65a7gnFqTQ
X-Google-Smtp-Source: AGHT+IG7NnZwNPwviXR2uQoNGZvH5pXcSPvxEPLMvDTjOI5JEO5bkhc56S5HSt04azvTmEef5juE1A==
X-Received: by 2002:a17:906:29d9:b0:a46:59c6:2a4d with SMTP id y25-20020a17090629d900b00a4659c62a4dmr5584202eje.53.1710722761895;
        Sun, 17 Mar 2024 17:46:01 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.232.181])
        by smtp.gmail.com with ESMTPSA id xi8-20020a170906dac800b00a46af0fbe83sm1418343ejb.76.2024.03.17.17.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 17:46:01 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net-next v2] net: cache for same cpu skb_attempt_defer_free
Date: Mon, 18 Mar 2024 00:44:22 +0000
Message-ID: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimise skb_attempt_defer_free() when run by the same CPU the skb was
allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
disable softirqs and put the buffer into cpu local caches.

CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
I'd expect the win doubled with rx only benchmarks, as the optimisation
is for the receive path, but the test spends >55% of CPU doing writes.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v2: pass @napi_safe=true by using __napi_kfree_skb()

 net/core/skbuff.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b99127712e67..35d37ae70a3d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6995,6 +6995,19 @@ void __skb_ext_put(struct skb_ext *ext)
 EXPORT_SYMBOL(__skb_ext_put);
 #endif /* CONFIG_SKB_EXTENSIONS */
 
+static void kfree_skb_napi_cache(struct sk_buff *skb)
+{
+	/* if SKB is a clone, don't handle this case */
+	if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
+		__kfree_skb(skb);
+		return;
+	}
+
+	local_bh_disable();
+	__napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+	local_bh_enable();
+}
+
 /**
  * skb_attempt_defer_free - queue skb for remote freeing
  * @skb: buffer
@@ -7013,7 +7026,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
 	    !cpu_online(cpu) ||
 	    cpu == raw_smp_processor_id()) {
-nodefer:	__kfree_skb(skb);
+nodefer:	kfree_skb_napi_cache(skb);
 		return;
 	}
 
-- 
2.44.0


