Return-Path: <netdev+bounces-71384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD74853226
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66BE1F23E23
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BA56461;
	Tue, 13 Feb 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guJq/zOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0A56444
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831776; cv=none; b=ISXhwOK9ryRCIR22c/+fk1zVWUJlafFAwzgOhFZeeTGM4O423y4kr7Hzannqipzof6V8grrINhp3qCzAfvX08wIEVJQPEmpa+FXKgLpDu67IKAwspr+zHeGmv9wNqK6mc/NRx2sCn0q6kpgYdKp82tgFWnyITqcMNtLMZjMHtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831776; c=relaxed/simple;
	bh=fQb7dApvd5j+NpxFIhp/n6nuqBvVbkrn55gSG3uPoWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tt2a46TOiE8cjJTlPQ1lxxcO7lYRj4SqPZbv1fjhjuz9nD6z9vIXm2zUMZYgd7azRtrh9d3sFvBorvhnwkR5mOjUV44G1TKNuLURTGXIeZoe7FU03Monah5V1KDCqn7wtnvREJiuIps8I5ukJDnt/Bcay5omUPtYUOHpfptI7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guJq/zOD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so757382166b.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831772; x=1708436572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgLyTkyvz4VgKllJSwa+R9epbNXXnH66EvP1/Jvwyu8=;
        b=guJq/zODqpzGu6Nr/gwM2zaEf22pWjvxtYt1k4zN/7gaD/qs2vPPE168p1Pffbi5jp
         uaoHICwcgJW8H+fslhnzAkAcIVaCmfJx3N4+RLlazt6JqguQh1K9A9bkd3Imz9p7z6BM
         Em1Br2PAlo92X9avRUBMxfoXRrPYif4tBEs3Vbrbs3Xxqh6SOAjF9q80naW01XHQ34ua
         pWDKNvjnC2pbJIYEOs702wShF2LN/NHjnYvb2GGpcJdpPGuHP/RMxg/KN2setlF+yp37
         hpv3YkXnJv9Kp3jP08jxW1vWDSFkBrSjWZCS5yKS+70CygFHIfVjBe8zJJgcQ6hzNRwM
         VBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831772; x=1708436572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgLyTkyvz4VgKllJSwa+R9epbNXXnH66EvP1/Jvwyu8=;
        b=ZWG4WyUKYDpmJVzvU2SLLjOlH9jrvaK0jWcTFYW2NrWsTpesCzB+P0lC3ts/o2sW9X
         iPnvXMQkIW+1Qh5DPdd98ilDQZ5VpdHuBeSYNDNq6HS6ZDM1GuVAvruQKGvK6flZrnHy
         CZXIsWOXLldS/iDdQ1ak3dN4fTYjRhwrNUNRJDHjamHekSgsg1pLvAoltytO6af5IsYN
         D1Ox36jSFWEoifx7dlqTPq8NBe3EgMFqaO0iiP0x2D4Qu8amrIHjuy6Cvm2jinqdwO88
         AP3QS/PTR+0Ca/QpLoflAjlZMwB34FtO5mXWIoR5zHe63AafjaxxdXgXjxxi9OCVoUhb
         ugWA==
X-Gm-Message-State: AOJu0YxqQZ5o+Hokq/rRtK1T3J3SCBmKc3lfKndn5n+mB8GH3jy3bG2e
	rjAuJFdIrTB6e0P+nth6N2hN1c6oy2K6+/tLPZoCpxdIVj7iTdOdJusulfUnpAk=
X-Google-Smtp-Source: AGHT+IEbymN2DhN41K1Q5tA2RcFI38SPq8wc/hIp1qlT63Xg9lCrjefnG4EtT+cZ5q6OBXu4ho/AuA==
X-Received: by 2002:a17:906:2a94:b0:a3c:ba16:7e35 with SMTP id l20-20020a1709062a9400b00a3cba167e35mr2408315eje.22.1707831772196;
        Tue, 13 Feb 2024 05:42:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcvHGfHColoQgNBqN75dw9jJXBOIrKLls6kLPF/tpGYDnJJAxRvXLN0K+sVWxo/HN6n3GWW6oTErpowDjxNaFI7NpLHyWBeGvu1+CTe7FrhUmJLR75Bc7+MgB2M4d2cAL8MD5bNHzi3RxTs14FcTra9+fMDZUrvhtVl+wIjZF40rgosnb6WRw+gMkK3ujb3FE=
Received: from 127.com ([2620:10d:c092:600::1:a107])
        by smtp.gmail.com with ESMTPSA id gv24-20020a170906f11800b00a3bd8a34b1bsm1299534ejb.164.2024.02.13.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:42:51 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2] net: cache for same cpu skb_attempt_defer_free
Date: Tue, 13 Feb 2024 13:33:08 +0000
Message-ID: <7a01e4c7ddb84292cc284b6664c794b9a6e713a8.1707759574.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimise skb_attempt_defer_free() executed by the CPU the skb was
allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
disable softirqs and put the buffer into cpu local caches.

Trying it with a TCP CPU bound ping pong benchmark (i.e. netbench), it
showed a 1% throughput improvement (392.2 -> 396.4 Krps). Cross checking
with profiles, the total CPU share of skb_attempt_defer_free() dropped by
0.6%. Note, I'd expect the win doubled with rx only benchmarks, as the
optimisation is for the receive path, but the test spends >55% of CPU
doing writes.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v2: remove in_hardirq()

 net/core/skbuff.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9b790994da0c..f32f358ef1d8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6947,6 +6947,20 @@ void __skb_ext_put(struct skb_ext *ext)
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
+	skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
+	napi_skb_cache_put(skb);
+	local_bh_enable();
+}
+
 /**
  * skb_attempt_defer_free - queue skb for remote freeing
  * @skb: buffer
@@ -6965,7 +6979,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
 	    !cpu_online(cpu) ||
 	    cpu == raw_smp_processor_id()) {
-nodefer:	__kfree_skb(skb);
+nodefer:	kfree_skb_napi_cache(skb);
 		return;
 	}
 
-- 
2.43.0


